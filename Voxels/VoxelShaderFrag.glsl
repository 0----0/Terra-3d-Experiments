#version 450

uniform usamplerBuffer nodePool;

uint getNode(uint idx) {
        return texelFetch(nodePool, int(idx)).r;
}

uint getChildrenIdx(uint curNodeIdx) {
        uint curNode = getNode(curNodeIdx);
        // uint offset = bitfieldExtract(curNode, 17, 15);
        uint offset = bitfieldExtract(curNode, 1, 15);
        // bool farPtr = bool(bitfieldExtract(curNode, 16, 1));
        bool farPtr = bool(bitfieldExtract(curNode, 0, 1));
        if (farPtr) {
                return getNode(curNodeIdx + offset);
        }
        else {
                return curNodeIdx + offset;
        }
}

uint getLeafMask(uint parentNode) {
        return bitfieldExtract(parentNode, 24, 8);
}

uint getValidMask(uint parentNode) {
        return bitfieldExtract(parentNode, 16, 8);
}

uint getChildIdx(uint parentIdx, uint childOctant) {
        uint childrenIdx = getChildrenIdx(parentIdx);
        uint parentNode = getNode(parentIdx);
        uint hasNodeMask = getLeafMask(parentNode) ^ getValidMask(parentNode);
        return childrenIdx + bitCount(hasNodeMask & (0xFF >> 8-childOctant));
}

bool checkMask(uint mask, uint octant) {
        return bool(mask & (1 << octant));
}

bool checkIsLeaf(uint parentNode, uint childOctant) {
        return checkMask(getLeafMask(parentNode), childOctant);
}

bool checkIsValid(uint parentNode, uint childOctant) {
        return checkMask(getValidMask(parentNode), childOctant);
}

struct Ray {
        vec3 coeffs;
        vec3 offsets;
        uint octantMask;
        vec3 asdf;
};

Ray makeRay(vec3 p, vec3 d) {
        Ray ray;
        ray.octantMask = 0;
        p += 1;
        if (d.x > 0.0f) { p.x = 3.0f - p.x; d.x *= -1.0f; ray.octantMask ^= 1 << 0; }
        if (d.y > 0.0f) { p.y = 3.0f - p.y; d.y *= -1.0f; ray.octantMask ^= 1 << 1; }
        if (d.z > 0.0f) { p.z = 3.0f - p.z; d.z *= -1.0f; ray.octantMask ^= 1 << 2; }
        ray.asdf = p;
        ray.coeffs = vec3(1.0f/d.x, 1.0f/d.y, 1.0f/d.z);
        ray.offsets = vec3(-p.x * ray.coeffs.x, -p.y * ray.coeffs.y, -p.z * ray.coeffs.z);

        return ray;
}

float tx(Ray ray, float x) {
        return x * ray.coeffs.x + ray.offsets.x;
}
float ty(Ray ray, float y) {
        return y * ray.coeffs.y + ray.offsets.y;
}
float tz(Ray ray, float z) {
        return z * ray.coeffs.z + ray.offsets.z;
}

float tenter(Ray ray, vec3 pos) {
        return max(max(tx(ray, pos.x), ty(ray, pos.y)), tz(ray, pos.z));
}
float texit(Ray ray, vec3 pos) {
        return min(min(tx(ray, pos.x), ty(ray, pos.y)), tz(ray, pos.z));
}

uint selectChild(Ray ray, vec3 pos, float childScale, float t) {
        uint childOctant = 0;
        if(t < tx(ray, pos.x + childScale)) {
                childOctant ^= 1 << 0;
        }
        if(t < ty(ray, pos.y + childScale)) {
                childOctant ^= 1 << 1;
        }
        if(t < tz(ray, pos.z + childScale)) {
                childOctant ^= 1 << 2;
        }
        return childOctant;
}

vec3 childOffset(uint childOctant) {
        vec3 offset = vec3(0.0f, 0.0f, 0.0f);
        if(bool(childOctant >> 0 & 1)) { offset.x = 1.0f; }
        if(bool(childOctant >> 1 & 1)) { offset.y = 1.0f; }
        if(bool(childOctant >> 2 & 1)) { offset.z = 1.0f; }
        return offset;
}

vec3 convertPos(Ray ray, vec3 pos, float scale) {
        if(bool(ray.octantMask & 1 << 0)) { pos.x = 1.0f - pos.x + scale; }
        if(bool(ray.octantMask & 1 << 1)) { pos.y = 1.0f - pos.y + scale; }
        if(bool(ray.octantMask & 1 << 2)) { pos.z = 1.0f - pos.z + scale; }
        return pos;
}

const uint MAX_STACK_SIZE = 23;

float raycast(vec3 p, vec3 d) {
        Ray ray = makeRay(p, d);

        uint parentStack[MAX_STACK_SIZE];
        parentStack[0] = 0;
        uint depth = 0;

        float t = max(0.0f, tenter(ray, vec3(2.0f))); // Skip to the entrance of the octree.
        float tmax = texit(ray, vec3(1.0f));

        float scale = 0.5f;
        vec3 pos = vec3(1.0f, 1.0f, 1.0f);

        uint childOctant = selectChild(ray, pos, scale, t);
        pos += childOffset(childOctant) * scale;
        while (depth < MAX_STACK_SIZE) {
                if (tmax <= t) { return -1.0f; }

                if(checkIsLeaf(getNode(parentStack[depth]), childOctant ^ ray.octantMask)) {
                        return t;
                }
                else if(checkIsValid(getNode(parentStack[depth]), childOctant ^ ray.octantMask)) { // PUSH
                        uint childIdx = getChildIdx(parentStack[depth], childOctant ^ ray.octantMask);
                        depth++;
                        parentStack[depth] = childIdx;
                        scale *= 0.5f;
                        childOctant = selectChild(ray, pos, scale, t);
                        pos += childOffset(childOctant) * scale;
                }
                else { // ADVANCE or POP
                        t = texit(ray, pos);
                        uint oldOctant = childOctant;
                        vec3 oldPos = pos;
                        uint differingBits = 0;
                        if (t == tx(ray, pos.x)) {
                                childOctant ^= 1 << 0;
                                float new = pos.x - scale;
                                differingBits |= floatBitsToUint(pos.x) ^ floatBitsToUint(new);
                                pos.x = new;
                        }
                        if (t == ty(ray, pos.y)) {
                                childOctant ^= 1 << 1;
                                float new = pos.y - scale;
                                differingBits |= floatBitsToUint(pos.y) ^ floatBitsToUint(new);
                                pos.y = new;
                        }
                        if (t == tz(ray, pos.z)) {
                                childOctant ^= 1 << 2;
                                float new = pos.z - scale;
                                differingBits |= floatBitsToUint(pos.z) ^ floatBitsToUint(new);
                                pos.z = new;
                        }
                        if(bool(~oldOctant & childOctant)) {
                                uint msb = findMSB(differingBits);

                                if(msb > 22) {
                                        return -1;
                                }
                                depth = 23 - msb;
                                scale = exp2(-float(depth));
                                depth--;

                                uint shx = floatBitsToUint(pos.x) >> msb;
                                pos.x = uintBitsToFloat(shx << msb);
                                uint shy = floatBitsToUint(pos.y) >> msb;
                                pos.y = uintBitsToFloat(shy << msb);
                                uint shz = floatBitsToUint(pos.z) >> msb;
                                pos.z = uintBitsToFloat(shz << msb);

                                childOctant = (shx & 1) | ((shy & 1) << 1) | ((shz & 1) << 2);
                        }
                }
        }
        return t;
}

vec4 colorFromRay(vec3 p, vec3 d) {
        float t = raycast(p,d);
        if (t == -1) return vec4(0.3,0.5,0.6,1);
        else return vec4(vec3(1), 1);
}

#define M_PI 3.1415926535897932384626433832795

uniform mat4 camera;
in vec2 _position;
out vec4 color;
void main() {
        // gl_FragColor = vec4(texelFetch(nodePool, 0));
        vec4 _p = camera * vec4(0.0, 0.0, 0.0, 1.0);
        vec3 p = vec3(_p) / _p.w;
        vec4 _d = camera * vec4(_position.x, 1, _position.y*3/4, 1);
        // vec2 ang = _position;
        // ang.y *= -0.75;
        // ang *= M_PI/2;
        // mat4 pitch = mat4(1,0,0,0, 0,cos(ang.y),-sin(ang.y),0, 0,sin(ang.y),cos(ang.y),0, 0,0,0,1);
        // mat4 yaw = mat4(cos(ang.x),-sin(ang.x),0,0, sin(ang.x),cos(ang.x),0,0, 0,0,1,0, 0,0,0,1);
        // vec4 _d = camera * yaw * pitch * vec4(0,1,0,1);

        vec3 d = normalize((vec3(_d) / _d.w) - p);

        vec3 sunColor = vec3(1,0.97,0.87);
        vec3 ambientColor = vec3(0.1,0.2,0.3);
        vec3 baseColor = vec3(1);

        float t = raycast(p, d);
        if (t == -1.0f) { color = vec4(sunColor, 1); return; }
        vec3 sunDir = normalize(vec3(0.5, 0.5, 0.5));
        vec3 rayEnd = p + d*t;
        float t2 = raycast(rayEnd + sunDir * exp2(-20), sunDir);
        if(t2 == -1) { t2 = 1; }
        // t2 = t2 * (1-0.05) + 0.05;
        color = vec4(mix(ambientColor, sunColor, clamp(t2,0,1)) * baseColor.rgb, 1);
}
