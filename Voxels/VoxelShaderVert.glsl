#version 450

layout(location=0) in vec3 position;
out vec2 _position;

void main() {
        gl_Position = vec4(vec2(position), 0.0, 1.0);
        _position = vec2(position);
}
