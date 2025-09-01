# 新增的OpenGL方法

本次更新为ANEGLFW添加了以下缺失的OpenGL方法，这些方法对于着色器编译和程序链接的错误检查至关重要。

## 新增方法列表

### 1. glGetShaderiv
**功能**: 获取着色器对象的参数值  
**用途**: 检查着色器编译状态、获取信息日志长度等  
**参数**: 
- `shader:int` - 着色器对象ID
- `pname:int` - 参数名称（如GL_COMPILE_STATUS）
**返回值**: `int` - 参数值

### 2. glGetShaderInfoLog
**功能**: 获取着色器对象的信息日志  
**用途**: 获取着色器编译错误信息  
**参数**: 
- `shader:int` - 着色器对象ID
- `bufSize:int` - 缓冲区大小
**返回值**: `String` - 信息日志内容

### 3. glGetProgramiv
**功能**: 获取程序对象的参数值  
**用途**: 检查程序链接状态、获取信息日志长度等  
**参数**: 
- `program:int` - 程序对象ID
- `pname:int` - 参数名称（如GL_LINK_STATUS）
**返回值**: `int` - 参数值

### 4. glGetProgramInfoLog
**功能**: 获取程序对象的信息日志  
**用途**: 获取程序链接错误信息  
**参数**: 
- `program:int` - 程序对象ID
- `bufSize:int` - 缓冲区大小
**返回值**: `String` - 信息日志内容

### 5. glBindAttribLocation
**功能**: 将通用顶点属性索引绑定到命名属性变量  
**用途**: 在链接程序之前指定属性变量的位置  
**参数**: 
- `program:int` - 程序对象ID
- `index:int` - 属性索引
- `name:String` - 属性变量名称
**返回值**: `void`

## 相关常量

以下常量已经存在于Gl.as中，可以与新增方法配合使用：

- `GL_COMPILE_STATUS` (0x8B81) - 着色器编译状态
- `GL_LINK_STATUS` (0x8B82) - 程序链接状态
- `GL_INFO_LOG_LENGTH` (0x8B84) - 信息日志长度

## 使用示例

```actionscript
// 检查着色器编译状态
var compileStatus:int = Gl.glGetShaderiv(shaderID, Gl.GL_COMPILE_STATUS);
if (compileStatus == 0) {
    var errorLog:String = Gl.glGetShaderInfoLog(shaderID, 512);
    trace("Shader compilation failed:", errorLog);
}

// 检查程序链接状态
var linkStatus:int = Gl.glGetProgramiv(programID, Gl.GL_LINK_STATUS);
if (linkStatus == 0) {
    var errorLog:String = Gl.glGetProgramInfoLog(programID, 512);
    trace("Program linking failed:", errorLog);
}

// 绑定属性位置
Gl.glBindAttribLocation(programID, 0, "aPosition");
Gl.glBindAttribLocation(programID, 1, "aTexCoord");
```

## 修改的文件

### Native层 (C++)
- `d:\Works\Works\TalkMEDAndroid-Company\ANEGLFW\native\ANEGLFW\ANEGLFW\ANEGLFW.cpp`
  - 添加了5个新的ANE函数实现
  - 在函数注册表中注册了这些新函数

### ActionScript层
- `d:\Works\Works\TalkMEDAndroid-Company\ANEGLFW\swc\src\com\vsdevelop\air\extension\glfw\Gl.as`
  - 添加了5个对应的静态方法

## 影响

这些新增方法将显著改善着色器调试体验：

1. **更好的错误报告**: 现在可以获取详细的编译和链接错误信息
2. **更可靠的着色器管理**: 可以在运行时检查着色器和程序的状态
3. **更精确的属性绑定**: 可以显式控制顶点属性的位置
4. **与现有代码兼容**: Program3D.as中已经使用了这些方法，现在可以正常工作

这些改进将使Display3DTest.as和其他3D应用程序能够提供更好的错误诊断和调试信息。