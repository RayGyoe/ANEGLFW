#version 330 core
    #ifdef GL_ES
        precision highp float;
        precision highp int;
        precision mediump sampler3D;
    #endif
    in vec2 a_Position; //顶点 位置 是有默认值的 (0,0,0,1)
    void main() {
        gl_Position = vec4(a_Position.xy, 0.0 , 1.0);
    }