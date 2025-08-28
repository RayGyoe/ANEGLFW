#version 330 core

// 顶点属性
layout (location = 0) in vec3 aPos;      // 位置
layout (location = 1) in vec2 aTexCoord; // 纹理坐标

// 输出到片段着色器
out vec2 TexCoord;

// Uniform变量
uniform mat4 uProjection;  // 投影矩阵
uniform mat4 uModel;       // 模型矩阵

void main()
{
    // 计算最终位置
    gl_Position = uProjection * uModel * vec4(aPos, 1.0);
    
    // 传递纹理坐标
    TexCoord = aTexCoord;
}