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
        if (d.x > 0.0f) { p.x = 1.0f - p.x; d.x *= -1.0f; ray.octantMask ^= 1 << 0; }
        if (d.y > 0.0f) { p.y = 1.0f - p.y; d.y *= -1.0f; ray.octantMask ^= 1 << 1; }
        if (d.z > 0.0f) { p.z = 1.0f - p.z; d.z *= -1.0f; ray.octantMask ^= 1 << 2; }
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
        if(t < tx(ray, pos.x - childScale)) {
                childOctant ^= 1 << 0;
        }
        if(t < ty(ray, pos.y - childScale)) {
                childOctant ^= 1 << 1;
        }
        if(t < tz(ray, pos.z - childScale)) {
                childOctant ^= 1 << 2;
        }
        return childOctant;
}

vec3 childOffset(uint childOctant) {
        vec3 offset = vec3(-1.0f, -1.0f, -1.0f);
        if(bool(childOctant >> 0 & 1)) { offset.x = 0.0f; }
        if(bool(childOctant >> 1 & 1)) { offset.y = 0.0f; }
        if(bool(childOctant >> 2 & 1)) { offset.z = 0.0f; }
        return offset;
}

vec3 convertPos(Ray ray, vec3 pos, float scale) {
        if(bool(ray.octantMask & 1 << 0)) { pos.x = 1.0f - pos.x + scale; }
        if(bool(ray.octantMask & 1 << 1)) { pos.y = 1.0f - pos.y + scale; }
        if(bool(ray.octantMask & 1 << 2)) { pos.z = 1.0f - pos.z + scale; }
        return pos;
}

const uint MAX_STACK_SIZE = 5;

vec3 raycast(vec3 p, vec3 d) {
        Ray ray = makeRay(p, d);

        uint parentStack[MAX_STACK_SIZE];
        parentStack[0] = 0;
        uint depth = 0;

        float t = 0.0f;
        float scale = 0.5f;
        vec3 pos = vec3(1.0f, 1.0f, 1.0f);
        t = max(t, tenter(ray, pos));
        float tmax = texit(ray, vec3(0,0,0));
        // return vec3(texit(ray, pos - 1) - t);
        // return vec3(1.0) + childOffset(selectChild(ray, vec3(1,1,1), 0.5, t) ^ ray.octantMask)*0.5;
        uint childOctant = selectChild(ray, pos, scale, t);
        pos += childOffset(childOctant) * scale;
        // return convertPos(ray, pos, scale);
        // return pos;
        while (depth < MAX_STACK_SIZE) {
                if (tmax <= t) { return vec3(0, 0, 0); }
                // if(bitfieldExtract(getNode(parentStack[depth]), 24, 8) == 1) {
                //         return vec3(1,0,1);
                // }
                // if(checkIsLeaf(getNode(parentStack[depth]), 0)) {
                //         return vec3(1,1,1);
                // }
                // return vec3(1,0.4,0.3);
                // if(ray.octantMask != 7) {
                //         return vec3(0, 1, 0);
                // }
                if(checkIsLeaf(getNode(parentStack[depth]), childOctant ^ ray.octantMask)) {
                        return vec3(1.0 - t);
                        return pos;
                }
                else if(checkIsValid(getNode(parentStack[depth]), childOctant ^ ray.octantMask)) { // PUSH
                        // return vec3(0,0,1);
                        // if ((childOctant ^ ray.octantMask) == 0) { return vec3(0,1,0); }
                        uint childIdx = getChildIdx(parentStack[depth], childOctant ^ ray.octantMask);
                        depth++;
                        parentStack[depth] = childIdx;
                        scale *= 0.5f;
                        childOctant = selectChild(ray, pos, scale, t);
                        pos += childOffset(childOctant) * scale;
                }
                else { // ADVANCE or POP
                        // return vec3(1,0,0);
                        t = texit(ray, pos - vec3(scale));
                        uint oldOctant = childOctant;
                        vec3 oldPos = pos;
                        vec3 newPos = pos;
                        uint differingBits = 0;
                        if (t == tx(ray, pos.x - scale)) {
                                childOctant ^= 1 << 0;
                                float new = pos.x - scale;
                                differingBits |= floatBitsToUint(pos.x) ^ floatBitsToUint(new);
                                pos.x = new;
                        }
                        if (t == ty(ray, pos.y - scale)) {
                                childOctant ^= 1 << 1;
                                float new = pos.y - scale;
                                differingBits |= floatBitsToUint(pos.y) ^ floatBitsToUint(new);
                                pos.y = new;
                        }
                        if (t == tz(ray, pos.z - scale)) {
                                childOctant ^= 1 << 2;
                                float new = pos.z - scale;
                                differingBits |= floatBitsToUint(pos.z) ^ floatBitsToUint(new);
                                pos.z = new;
                        }
                        if(bool(~oldOctant & childOctant)) {
                                uint msb = (floatBitsToUint(float(differingBits)) >> 23) - 127;
                                // uint msb = findMSB(differingBits);

                                if(msb > 22) {
                                        return vec3(0, 0, 0);
                                }
                                depth = 23 - msb;
                                scale = exp2(-float(depth));
                                depth--;
                                // return vec3(scale);

                                uint shx = floatBitsToUint(pos.x) >> (msb + 1);
                                pos.x = uintBitsToFloat(shx << msb);
                                uint shy = floatBitsToUint(pos.y) >> (msb + 1);
                                pos.y = uintBitsToFloat(shy << msb);
                                uint shz = floatBitsToUint(pos.z) >> (msb + 1);
                                pos.z = uintBitsToFloat(shz << msb);
                                // if (pos == vec3(1, 0.5, 0.5)) {
                                //         return vec3(0,1,0);
                                // }
                                // pos = vec3(1, 0.5, 0.5);
                                // return oldPos - pos;
                                childOctant = (shx & 1) | ((shy & 1) << 1) | ((shz & 1) << 2);
                                if (childOctant == 0) return vec3(0,0,0);
                                if (childOctant == 1) return vec3(0,0,1);
                                if (childOctant == 2) return vec3(0,1,0);
                                if (childOctant == 3) return vec3(0,1,1);
                                if (childOctant == 4) return vec3(1,0,0);
                                if (childOctant == 5) return vec3(1,0,1);
                                if (childOctant == 6) return vec3(1,1,0);
                                if (childOctant == 7) return vec3(1,1,1);
                                // pos = vec3(1,0.5,1);
                                // childOctant = 5;
                                // if (childOctant == 0) { return vec3(0, 1, 0); }
                                // childOctant ^= 4;
                                // return oldPos;
                                // pos += childOffset(childOctant) * scale;
                        }
                }
        }
        return vec3(0, 1, 0);
}

uniform mat4 camera;
in vec2 _position;
void main() {
        // gl_FragColor = vec4(texelFetch(nodePool, 0));
        vec4 _p = camera * vec4(0.0, 0.0, 0.0, 1.0);
        vec3 p = vec3(_p) / _p.w;
        vec4 _d = camera * vec4(_position.x, 1, _position.y, 1);
        vec3 d = (vec3(_d) / _d.w) - p;
        gl_FragColor = vec4(raycast(p,d), 1.0);
}
