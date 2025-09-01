package
{
	import com.vsdevelop.display.Stage3D;
	import com.vsdevelop.display3D.Context3D;
	import com.vsdevelop.display3D.IndexBuffer3D;
	import com.vsdevelop.display3D.Program3D;
	import com.vsdevelop.display3D.VertexBuffer3D;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	public class Display3DTestSimple extends Sprite
	{
		private var _stage3D:Stage3D;
		private var _context:Context3D;
		private var _vertexBuffer:VertexBuffer3D;
		private var _indexBuffer:IndexBuffer3D;
		private var _program:Program3D;
		
		// 使用更简单的着色器，不使用纹理
		private const VERTEX_SHADER:String = 
			"#version 330 core\n" +
			"layout (location = 0) in vec3 aPosition;\n" +
			"layout (location = 1) in vec3 aColor;\n" +
			"out vec3 vColor;\n" +
			"void main() {\n" +
			"  gl_Position = vec4(aPosition, 1.0);\n" +
			"  vColor = aColor;\n" +
			"}";
		
		private const FRAGMENT_SHADER:String = 
			"#version 330 core\n" +
			"in vec3 vColor;\n" +
			"out vec4 FragColor;\n" +
			"void main() {\n" +
			"  FragColor = vec4(vColor, 1.0);\n" +
			"}";
		
		public function Display3DTestSimple()
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_stage3D = new Stage3D(stage);
			_stage3D.x = 0;
			_stage3D.y = 100;
			_stage3D.requestContext3D();
			_stage3D.addEventListener(Event.CONTEXT3D_CREATE, onContextCreated);
		}
		
		private function onContextCreated(e:Event):void
		{
			trace("Context3D created:", e);
			_context = _stage3D.context3D;
			_context.configureBackBuffer(stage.stageWidth, stage.stageHeight, 0, false);
			
			// 创建顶点缓冲区 - 包含位置和颜色
			_vertexBuffer = _context.createVertexBuffer(3, 6); // 3个顶点，每个顶点6个分量(x,y,z,r,g,b)
			
			// 定义三角形顶点数据 (x, y, z, r, g, b)
			var vertices:Vector.<Number> = new <Number>[
				0.0, 0.5, 0.0, 1.0, 0.0, 0.0,  // 顶部顶点 - 红色
				-0.5, -0.5, 0.0, 0.0, 1.0, 0.0,  // 左下顶点 - 绿色
				0.5, -0.5, 0.0, 0.0, 0.0, 1.0   // 右下顶点 - 蓝色
			];
			
			trace("Uploading vertex data:", vertices.length, "floats");
			_vertexBuffer.uploadFromVector(vertices, 0, 3);
			
			// 创建索引缓冲区
			_indexBuffer = _context.createIndexBuffer(3);
			
			// 定义三角形索引
			var indices:Vector.<uint> = new <uint>[0, 1, 2];
			
			trace("Uploading index data:", indices.length, "indices");
			_indexBuffer.uploadFromVector(indices, 0, 3);
			
			// 创建着色器程序
			_program = _context.createProgram();
			try {
				trace("Compiling shaders...");
				_program.uploadFromGLSL(VERTEX_SHADER, FRAGMENT_SHADER);
				trace("Shader program compiled successfully");
			} catch (error:Error) {
				trace("Shader compilation error:", error.message);
				return;
			}
			
			trace("Starting render loop...");
			addEventListener(Event.ENTER_FRAME, render);
		}
		
		private function render(e:Event):void
		{
			if (!_context || !_program || !_vertexBuffer || !_indexBuffer)
			{
				trace("Missing required objects for rendering");
				return;
			}
			
			try {
				// 清除缓冲区 - 使用深灰色背景
				_context.clear(0.2, 0.2, 0.2, 1.0);
				
				// 设置着色器程序
				_context.setProgram(_program);
				
				// 设置顶点缓冲区 (位置:0, 颜色:1)
				_context.setVertexBufferAt(0, _vertexBuffer, 0, "float3"); // 位置
				_context.setVertexBufferAt(1, _vertexBuffer, 3, "float3"); // 颜色
				
				// 绘制三角形
				_context.drawTriangles(_indexBuffer, 0, 1);
				
				// 呈现渲染结果
				_context.present();
				
				// 减少trace输出频率
				if (getTimer() % 1000 < 16) {
					trace("Rendering colored triangle...");
				}
			} catch (error:Error) {
				trace("Rendering error:", error.message);
			}
		}
	}
}