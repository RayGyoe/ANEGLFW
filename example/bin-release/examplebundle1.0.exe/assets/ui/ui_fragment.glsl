#version 330 core

// 输入
in vec2 TexCoord;

// 输出
out vec4 FragColor;

// Uniform变量
uniform bool uUseTexture;     // 是否使用纹理
uniform sampler2D uTexture;   // 纹理
uniform vec4 uColor;          // 颜色
uniform float uAlpha;         // 透明度

void main()
{
    vec4 finalColor;
    
    if (uUseTexture)
    {
        // 使用纹理
        finalColor = texture(uTexture, TexCoord) * uColor;
    }
    else
    {
        // 使用纯色
        finalColor = uColor;
    }
    
    // 应用透明度
    finalColor.a *= uAlpha;
    
    FragColor = finalColor;
}