package
{
	import com.vsdevelop.air.extension.glfw.Gl;
	import com.vsdevelop.display.Stage3D;
	import com.vsdevelop.display3D.Context3D;
	import com.vsdevelop.display3D.IndexBuffer3D;
	import com.vsdevelop.display3D.Program3D;
	import com.vsdevelop.display3D.VertexBuffer3D;
	import com.vsdevelop.display3D.textures.Texture;
	import flash.display.Bitmap;
	
	import flash.display.Sprite;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Matrix3D;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	
	public class Display3DTest extends Sprite
	{
		private var _stage3D:Stage3D;
		private var _context:Context3D;
		private var _vertexBuffer:VertexBuffer3D;
		private var _indexBuffer:IndexBuffer3D;
		private var _program:Program3D;
		private var _vao:uint; // Vertex Array Object
		
		// 简化的纯色着色器，用于调试
		private const VERTEX_SHADER:String = "#version 330 core\n" + "layout (location = 0) in vec3 aPosition;\n" + "void main() {\n" + "  gl_Position = vec4(aPosition, 1.0);\n" + "}";
		
		private const FRAGMENT_SHADER:String = "#version 330 core\n" + "out vec4 FragColor;\n" + "void main() {\n" + "  FragColor = vec4(1.0, 0.0, 0.0, 1.0);\n" + "}";
		
		public function Display3DTest()
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_stage3D = new Stage3D(stage);
			_stage3D.x = 0;
			_stage3D.y = 0;
			_stage3D.requestContext3D();
			_stage3D.addEventListener(Event.CONTEXT3D_CREATE, onContextCreated);
		}
		
		private function onContextCreated(e:Event):void
		{
			trace("Context3D created:", e);
			_context = _stage3D.context3D;
			_context.configureBackBuffer(stage.stageWidth, stage.stageHeight, 0, false);
			
			// 添加视口调试信息
			trace("Viewport configured: width=", stage.stageWidth, "height=", stage.stageHeight);
			
			// 禁用深度测试以简化调试
			Gl.glDisable(Gl.GL_DEPTH_TEST);
			Gl.glDisable(Gl.GL_CULL_FACE);
			trace("Depth test and culling disabled for debugging");
			
			// 创建顶点缓冲区 - 简化为只有位置数据
			_vertexBuffer = _context.createVertexBuffer(3, 3); // 3个顶点，每个顶点3个分量(x,y,z)
			
			// 定义三角形顶点数据 (x, y, z) - 更大的三角形便于观察
			var vertices:Vector.<Number> = new <Number>[
				 0.0,  0.8, 0.0,  // 顶部顶点
				-0.8, -0.8, 0.0,  // 左下顶点
				 0.8, -0.8, 0.0   // 右下顶点
			];
			
			trace("Uploading vertices:", vertices);
			_vertexBuffer.uploadFromVector(vertices, 0, 3);
			
			// 创建并配置VAO (OpenGL 3.3 Core需要)
			_vao = Gl.glGenVertexArrays(1);
			trace("Created VAO:", _vao);
			Gl.glBindVertexArray(_vao);
			
			// 在VAO绑定状态下设置顶点属性 - 只设置位置属性
			_context.setVertexBufferAt(0, _vertexBuffer, 0, "float3");
			trace("Set vertex attribute 0 (position)");
			
			// 解绑VAO，保存配置
			Gl.glBindVertexArray(0);
			trace("VAO configuration saved");
			
			// 启用深度测试和背面剔除
			// Gl.glEnable(Gl.GL_DEPTH_TEST);
			// Gl.glEnable(Gl.GL_CULL_FACE);
			
			// 创建索引缓冲区
			_indexBuffer = _context.createIndexBuffer(3);
			
			// 定义三角形索引
			var indices:Vector.<uint> = new <uint>[0, 1, 2];
			
			_indexBuffer.uploadFromVector(indices, 0, 3);
			
			// 创建着色器程序
			_program = _context.createProgram();
			try
			{
				_program.uploadFromGLSL(VERTEX_SHADER, FRAGMENT_SHADER);
				trace("Shader program compiled successfully");
			}
			catch (error:Error)
			{
				trace("Shader compilation error:", error.message);
				return;
			}
			
			addEventListener(Event.ENTER_FRAME, render);
		}
		

		private function render(e:Event):void
		{
			if (!_context || !_program || !_vertexBuffer || !_indexBuffer)
			{
				trace("Missing required objects for rendering");
				return;
			}
			
			// 清除缓冲区 - 使用深灰色背景便于调试
			_context.clear(0.2, 0.2, 0.2, 1.0);
			
			// 设置着色器程序
			_context.setProgram(_program);
			
			// 绑定VAO (包含所有顶点属性配置)
			Gl.glBindVertexArray(_vao);
			
			// 添加详细的调试信息
			if (getTimer() % 1000 < 16)
			{
				trace("=== Render Debug Info ===");
				trace("- Program ID:", _program.programID);
				trace("- Vertex buffer ID:", _vertexBuffer.bufferID);
				trace("- Index buffer ID:", _indexBuffer.bufferID);
				
				// 检查视口设置
				//var viewport:Vector.<int> = new Vector.<int>(4);
				//for (var i:int = 0; i < 4; i++) {
					//viewport[i] = Gl.glGetIntegerv(Gl.GL_VIEWPORT + i);
				//}
				//trace("- Viewport: x=", viewport[0], "y=", viewport[1], "w=", viewport[2], "h=", viewport[3]);
				
				// 检查当前绑定的VAO
				var currentVAO:int = Gl.glGetIntegerv(Gl.GL_VERTEX_ARRAY_BINDING);
				trace("- Current VAO:", currentVAO, "(expected:", _vao, ")");
				
				// 检查顶点属性状态
				var attr0Enabled:int = Gl.glGetIntegerv(Gl.GL_VERTEX_ATTRIB_ARRAY_ENABLED + 0);
				var attr1Enabled:int = Gl.glGetIntegerv(Gl.GL_VERTEX_ATTRIB_ARRAY_ENABLED + 1);
				trace("- Vertex Attrib 0 enabled:", attr0Enabled);
				trace("- Vertex Attrib 1 enabled:", attr1Enabled);
				
				var error:int = Gl.glGetError();
				if (error != Gl.GL_NO_ERROR)
				{
					trace("OpenGL Error before draw:", error.toString(16));
				}
			}
			
			// 绘制三角形
			_context.drawTriangles(_indexBuffer, 0, 1);
			
			// 检查绘制后的OpenGL错误
			if (getTimer() % 1000 < 16)
			{
				var drawError:int = Gl.glGetError();
				if (drawError != Gl.GL_NO_ERROR)
				{
					trace("OpenGL Error after draw:", drawError.toString(16));
				}
			}
			
			// 解绑VAO
			Gl.glBindVertexArray(0);
			
			// 呈现渲染结果
			_context.present();
			
			// 减少trace输出频率
			if (getTimer() % 1000 < 16)
			{
				trace("Rendering solid color triangle...");
			}
		}
		
		/**
		 * 清理资源
		 */
		public function dispose():void
		{
			if (_vao > 0)
			{
				var arrays:Vector.<uint> = new Vector.<uint>(1);
				arrays[0] = _vao;
				Gl.glDeleteVertexArrays(1, arrays);
				_vao = 0;
			}
			
			if (_vertexBuffer)
			{
				_vertexBuffer.dispose();
				_vertexBuffer = null;
			}
			
			if (_indexBuffer)
			{
				_indexBuffer.dispose();
				_indexBuffer = null;
			}
			
			if (_program)
			{
				_program.dispose();
				_program = null;
			}
			

		}
	}
}