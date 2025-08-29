package
{
	import com.vsdevelop.display.Stage3D;
	import com.vsdevelop.display3D.Context3D;
	import com.vsdevelop.display3D.IndexBuffer3D;
	import com.vsdevelop.display3D.Program3D;
	import com.vsdevelop.display3D.VertexBuffer3D;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix3D;
	import flash.utils.ByteArray;
	
	public class Display3DTest extends Sprite
	{
		private var _stage3D:Stage3D;
		private var _context3D:Context3D;
		private var _vertexBuffer:VertexBuffer3D;
		private var _indexBuffer:IndexBuffer3D;
		private var _program:Program3D;
		
		private const VERTEX_SHADER:String = 
			"attribute vec4 a_position;\n" +
			"void main() {\n" +
			"  gl_Position = a_position;\n" +
			"}";
		
		private const FRAGMENT_SHADER:String = 
			"precision mediump float;\n" +
			"void main() {\n" +
			"  gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0);\n" +
			"}";
		
		public function Display3DTest()
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_stage3D = new Stage3D();
			addChild(_stage3D);
			
			_stage3D.addEventListener("CONTEXT3D_CREATE", onContextCreated);
			_stage3D.requestContext3D();
		}
		
		private function onContextCreated(e:Event):void
		{
			_context3D = _stage3D.context3D;
			_context3D.configureBackBuffer(800, 600, 0);
			
			// 创建顶点数据
			var vertices:ByteArray = new ByteArray();
			vertices.writeFloat(-0.5); vertices.writeFloat(-0.5); vertices.writeFloat(0.0);
			vertices.writeFloat( 0.5); vertices.writeFloat(-0.5); vertices.writeFloat(0.0);
			vertices.writeFloat( 0.0); vertices.writeFloat( 0.5); vertices.writeFloat(0.0);
			
			_vertexBuffer = _context3D.createVertexBuffer(3, 3);
			_vertexBuffer.uploadFromByteArray(vertices, 0, 0, 3);
			
			// 创建索引数据
			var indices:ByteArray = new ByteArray();
			indices.writeShort(0); indices.writeShort(1); indices.writeShort(2);
			
			_indexBuffer = _context3D.createIndexBuffer(3);
			_indexBuffer.uploadFromByteArray(indices, 0, 0, 3);
			
			// 创建着色器程序
			_program = _context3D.createProgram();
			_program.uploadFromGLSL(VERTEX_SHADER, FRAGMENT_SHADER);
			
			addEventListener(Event.ENTER_FRAME, render);
		}
		
		private function render(e:Event):void
		{
			_context3D.clear(0.2, 0.2, 0.2, 1.0);
			
			_context3D.setProgram(_program);
			_context3D.setVertexBufferAt(0, _vertexBuffer, 0, "float3");
			_context3D.drawTriangles(_indexBuffer, 0, 1);
			
			_context3D.present();
		}
	}
}