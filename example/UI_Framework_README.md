# ANEGLFW UI框架

基于ANEGLFW扩展开发的ActionScript 3.0 UI框架，提供OpenGL渲染的高性能UI组件。

## 框架结构

```
src/
├── ui/
│   ├── core/
│   │   ├── UIComponent.as      # UI组件基类
│   │   └── UIManager.as        # UI管理器（单例）
│   ├── components/
│   │   ├── Button.as           # 按钮组件
│   │   └── Image.as            # 图片组件
│   ├── events/
│   │   └── UIEvent.as          # UI事件类
│   └── test/
│       └── UITestCase.as       # 测试用例
├── assets/
│   └── ui/
│       ├── ui_vertex.glsl      # UI顶点着色器
│       └── ui_fragment.glsl    # UI片段着色器
└── UITestMain.as               # 完整测试演示
```

## 核心组件

### UIComponent（基类）
- 提供位置、大小、可见性等基础属性
- 集成OpenGL资源管理（VAO、VBO）
- 支持事件系统和碰撞检测
- 自动处理资源释放

### UIManager（管理器）
- 单例模式，统一管理所有UI组件
- 处理渲染循环和事件分发
- 管理视口和投影矩阵
- 提供焦点管理

### Button（按钮组件）
- 支持多种状态：正常、悬停、按下、禁用
- 可自定义颜色主题
- 完整的鼠标事件支持
- 文本显示功能

### Image（图片组件）
- 支持多种缩放模式
- 异步图片加载
- OpenGL纹理管理
- 错误处理机制

## 使用方法

### 1. 基本初始化

```actionscript
// 获取UI管理器实例
var uiManager:UIManager = UIManager.getInstance();
uiManager.setViewport(800, 600);

// 设置OpenGL混合模式
Gl.glEnable(Gl.GL_BLEND);
Gl.glBlendFunc(Gl.GL_SRC_ALPHA, Gl.GL_ONE_MINUS_SRC_ALPHA);
```

### 2. 创建按钮

```actionscript
// 创建基本按钮
var button:Button = new Button(50, 50, 120, 40, "点击我!");
button.addEventListener(UIEvent.CLICK, onButtonClick);
uiManager.addComponent(button);

// 创建自定义颜色按钮
var customButton:Button = new Button(200, 50, 120, 40, "自定义");
customButton.setColors(
    new <Number>[0.2, 0.6, 0.2, 1.0], // 正常状态
    new <Number>[0.3, 0.8, 0.3, 1.0], // 悬停状态
    new <Number>[0.1, 0.4, 0.1, 1.0], // 按下状态
    new <Number>[0.1, 0.3, 0.1, 0.5]  // 禁用状态
);
uiManager.addComponent(customButton);
```

### 3. 创建图片

```actionscript
// 创建图片组件
var image:Image = new Image(50, 120, 200, 150);
image.source = "path/to/image.jpg";
image.scaleMode = Image.SCALE_MODE_FIT;
image.addEventListener(UIEvent.CLICK, onImageClick);
uiManager.addComponent(image);
```

### 4. 事件处理

```actionscript
private function onButtonClick(event:UIEvent):void
{
    trace("按钮被点击! 坐标:", event.mouseX, event.mouseY);
}

private function onImageClick(event:UIEvent):void
{
    trace("图片被点击!");
}
```

### 5. 渲染循环

```actionscript
private function renderFrame():void
{
    // 清除缓冲区
    Gl.glClear(Gl.GL_COLOR_BUFFER_BIT);
    
    // 渲染UI组件
    uiManager.render();
    
    // 交换缓冲区
    Glfw.glfwSwapBuffers(windowPtr);
}
```

### 6. 鼠标事件集成

```actionscript
// 在GLFW鼠标回调中调用UI管理器
Glfw.glfwSetCursorPosCallback(windowPtr, function(wPtr:Number, x:Number, y:Number):void {
    uiManager.handleMouseMove(x, y);
});

Glfw.glfwSetMouseButtonCallback(windowPtr, function(wPtr:Number, button:int, action:int, mods:int):void {
    var mousePos:Point = Glfw.glfwGetCursorPos(windowPtr);
    
    if (action == Glfw.GLFW_PRESS) {
        uiManager.handleMouseDown(mousePos.x, mousePos.y);
    } else if (action == Glfw.GLFW_RELEASE) {
        uiManager.handleMouseUp(mousePos.x, mousePos.y);
    }
});
```

## 运行测试

1. 编译并运行 `UITestMain.as`
2. 点击屏幕开始演示
3. 测试各种UI组件的交互功能

## 支持的事件类型

- `UIEvent.CLICK` - 点击事件
- `UIEvent.MOUSE_DOWN` - 鼠标按下
- `UIEvent.MOUSE_UP` - 鼠标释放
- `UIEvent.MOUSE_OVER` - 鼠标悬停
- `UIEvent.MOUSE_OUT` - 鼠标离开
- `UIEvent.FOCUS_IN` - 获得焦点
- `UIEvent.FOCUS_OUT` - 失去焦点
- `UIEvent.CHANGE` - 状态改变
- `UIEvent.COMPLETE` - 加载完成
- `UIEvent.ERROR` - 错误事件

## 扩展开发

要创建新的UI组件，继承 `UIComponent` 类并重写以下方法：

```actionscript
public class CustomComponent extends UIComponent
{
    public function CustomComponent(x:Number, y:Number, width:Number, height:Number)
    {
        super(x, y, width, height);
        // 初始化自定义属性
    }
    
    override protected function doRender():void
    {
        // 实现自定义渲染逻辑
        super.doRender();
    }
    
    override public function dispose():void
    {
        // 清理自定义资源
        super.dispose();
    }
}
```

## 注意事项

1. 确保在使用前正确初始化GLFW和OpenGL上下文
2. 所有UI组件都需要通过UIManager进行管理
3. 记得在应用程序退出时调用 `dispose()` 方法清理资源
4. 图片组件需要实际的图片文件才能正常显示
5. 框架使用OpenGL Core Profile，需要OpenGL 3.3+支持

## 依赖项

- ANEGLFW扩展
- Adobe AIR SDK
- OpenGL 3.3+支持的显卡驱动