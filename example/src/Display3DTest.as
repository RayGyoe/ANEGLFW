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
	import flash.geom.Matrix3D;
	import flash.utils.ByteArray;
	
	public class Display3DTest extends Sprite
	{
		private var _stage3D:Stage3D;
		private var _context:Context3D;
		private var _vertexBuffer:VertexBuffer3D;
		private var _indexBuffer:IndexBuffer3D;
		private var _program:Program3D;
		private var _texture:Texture;
		
		private const VERTEX_SHADER:String = 
			"attribute vec3 aPosition;\n" +
			"attribute vec2 aTexCoord;\n" +
			"varying vec2 vTexCoord;\n" +
			"void main() {\n" +
			"  gl_Position = vec4(aPosition, 1.0);\n" +
			"  vTexCoord = aTexCoord;\n" +
			"}";
		
		private const FRAGMENT_SHADER:String = 
			"precision mediump float;\n" +
			"varying vec2 vTexCoord;\n" +
			"uniform sampler2D uTexture;\n" +
			"void main() {\n" +
			"  gl_FragColor = texture2D(uTexture, vTexCoord);\n" +
			"}";
		
		public function Display3DTest()
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_stage3D = new Stage3D(stage);			
			_stage3D.addEventListener(Event.CONTEXT3D_CREATE, onContextCreated);
			_stage3D.requestContext3D();
		}
		
		private function onContextCreated(e:Event):void
		{
			trace(e);
			_context = _stage3D.context3D;
			_context.configureBackBuffer(stage.stageWidth,stage.stageHeight , 0, false);
			
			// 创建顶点缓冲区
			_vertexBuffer = _context.createVertexBuffer(3, 5); // 3个顶点，每个顶点5个分量(x,y,z,u,v)
			
			// 定义三角形顶点数据 (x, y, z, u, v)
			var vertices:Vector.<Number> = new <Number>[
				0.0, 0.5, 0.0, 0.5, 0.0,  // 顶部顶点
				-0.5, -0.5, 0.0, 0.0, 1.0,  // 左下顶点
				0.5, -0.5, 0.0, 1.0, 1.0   // 右下顶点
			];
			
			_vertexBuffer.uploadFromVector(vertices, 0, 3);
			
			// 创建索引缓冲区
			_indexBuffer = _context.createIndexBuffer(3);
			
			// 定义三角形索引
			var indices:Vector.<uint> = new <uint>[0, 1, 2];
			
			_indexBuffer.uploadFromVector(indices, 0, 3);
			
			// 创建着色器程序
			_program = _context.createProgram();
			_program.uploadFromGLSL(VERTEX_SHADER, FRAGMENT_SHADER);
			
			// 创建纹理
			_texture = _context.createTexture(256, 256, "bgra", false);
			
			// 创建简单的棋盘纹理数据
			createCheckerTexture();
			
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
			
			_texture.uploadFromBitmapData(bitmapData);
		}
		
		private function render(e:Event):void
		{
			if (!_context)
				return;
			
			// 清除缓冲区
			_context.clear(0.0, 0.0, 0.0, 1.0);
			
			// 设置着色器程序
			_context.setProgram(_program);
			
			// 设置uniform变量 - 将纹理采样器绑定到纹理单元0
			_program.setUniform1i("uTexture", 0);
			
			// 设置顶点缓冲区 (位置:0, 纹理坐标:1)
			_context.setVertexBufferAt(0, _vertexBuffer, 0, "float3");
			_context.setVertexBufferAt(1, _vertexBuffer, 3, "float2");
			
			// 绑定纹理到纹理单元0
			_context.setTextureAt(0, _texture);
			
			// 绘制三角形
			_context.drawTriangles(_indexBuffer, 0, 1);
			
			// 呈现渲染结果
			_context.present();
			
			trace("Rendering textured triangle...");
		}
	}
}