package
{
	import com.vsdevelop.display.Stage3D;
	import com.vsdevelop.display3D.Context3D;
	import com.vsdevelop.display3D.IndexBuffer3D;
	import com.vsdevelop.display3D.Program3D;
	import com.vsdevelop.display3D.VertexBuffer3D;
	import com.vsdevelop.display3D.textures.Texture;
	import flash.display.Sprite;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	public class Display3DTestCompat extends Sprite
	{
		private var _stage3D:Stage3D;
		private var _context:Context3D;
		private var _vertexBuffer:VertexBuffer3D;
		private var _indexBuffer:IndexBuffer3D;
		private var _program:Program3D;
		private var _texture:Texture;
		
		// 使用OpenGL 2.1兼容的着色器
		private const VERTEX_SHADER:String = 
			"attribute vec3 aPosition;\n" +
			"attribute vec2 aTexCoord;\n" +
			"varying vec2 vTexCoord;\n" +
			"void main() {\n" +
			"  gl_Position = vec4(aPosition, 1.0);\n" +
			"  vTexCoord = aTexCoord;\n" +
			"}";
		
		private const FRAGMENT_SHADER:String = 
			"#ifdef GL_ES\n" +
			"precision mediump float;\n" +
			"#endif\n" +
			"varying vec2 vTexCoord;\n" +
			"uniform sampler2D uTexture;\n" +
			"void main() {\n" +
			"  gl_FragColor = texture2D(uTexture, vTexCoord);\n" +
			"}";
		
		public function Display3DTestCompat()
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
			
			// 创建顶点缓冲区
			_vertexBuffer = _context.createVertexBuffer(3, 5); // 3个顶点，每个顶点5个分量(x,y,z,u,v)
			
			// 定义三角形顶点数据 (x, y, z, u, v)
			var vertices:Vector.<Number> = new <Number>[
				0.0, 0.5, 0.0, 0.5, 0.0,  // 顶部顶点
				-0.5, -0.5, 0.0, 0.0, 1.0,  // 左下顶点
				0.5, -0.5, 0.0, 1.0, 1.0   // 右下顶点
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
			
			// 创建纹理
			_texture = _context.createTexture(256, 256, "bgra", false);
			
			// 创建简单的棋盘纹理数据
			createCheckerTexture();
			
			trace("Starting render loop...");
			addEventListener(Event.ENTER_FRAME, render);
		}
		
		private function createCheckerTexture():void
		{
			const SIZE:int = 256;
			var bitmapData:BitmapData = new BitmapData(SIZE, SIZE, false, 0);
			
			// 创建棋盘格纹理
			for (var y:int = 0; y < SIZE; y++)
			{
				for (var x:int = 0; x < SIZE; x++)
				{
					var color:uint = ((x >> 4) + (y >> 4)) & 1 ? 0xFF0000 : 0x0000FF;
					bitmapData.setPixel(x, y, color);
				}
			}
			
			trace("Uploading texture data...");
			_texture.uploadFromBitmapData(bitmapData);
			trace("Texture uploaded successfully");
		}
		
		private function render(e:Event):void
		{
			if (!_context || !_program || !_vertexBuffer || !_indexBuffer || !_texture)
			{
				trace("Missing required objects for rendering");
				return;
			}
			
			try {
				// 清除缓冲区 - 使用深灰色背景
				_context.clear(0.2, 0.2, 0.2, 1.0);
				
				// 设置着色器程序
				_context.setProgram(_program);
				
				// 绑定纹理到纹理单元0
				_context.setTextureAt(0, _texture);
				
				// 设置uniform变量 - 将纹理采样器绑定到纹理单元0
				_program.setUniform1i("uTexture", 0);
				
				// 设置顶点缓冲区 (位置:0, 纹理坐标:1)
				_context.setVertexBufferAt(0, _vertexBuffer, 0, "float3");
				_context.setVertexBufferAt(1, _vertexBuffer, 3, "float2");
				
				// 绘制三角形
				_context.drawTriangles(_indexBuffer, 0, 1);
				
				// 呈现渲染结果
				_context.present();
				
				// 减少trace输出频率
				if (getTimer() % 1000 < 16) {
					trace("Rendering textured triangle...");
				}
			} catch (error:Error) {
				trace("Rendering error:", error.message);
			}
		}
	}
}