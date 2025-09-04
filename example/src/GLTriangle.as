package
{
	import com.vsdevelop.display.Stage3D;
	import com.vsdevelop.display3D.Context3D;
	import com.vsdevelop.display3D.IndexBuffer3D;
	import com.vsdevelop.display3D.Program3D;
	import com.vsdevelop.display3D.VertexBuffer3D;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * 使用基于OpenGL的3D API渲染三角形的测试用例
	 * @author Ray.eDoctor
	 */
	public class GLTriangle extends Sprite
	{
		private var stage3D:com.vsdevelop.display.Stage3D;
		private var renderContext:Context3D;
		private var indexList:IndexBuffer3D;
		private var vertexes:VertexBuffer3D;
		private var programPair:Program3D;
		
		private const VERTEX_SHADER:String =
			"#version 330 core\n" +
			"layout (location = 0) in vec3 aPos;\n" +
			"layout (location = 1) in vec3 aColor;\n" +
			"out vec3 ourColor;\n" +
			"void main()\n" +
			"{\n" +
			"    gl_Position = vec4(aPos, 1.0);\n" +
			"    ourColor = aColor;\n" +
			"}";
		
		private const FRAGMENT_SHADER:String = 
			"#version 330 core\n" +
			"out vec4 FragColor;\n" +
			"in vec3 ourColor;\n" +
			"void main()\n" +
			"{\n" +
			"    FragColor = vec4(ourColor, 1.0);\n" +
			"}";
		
		public function GLTriangle()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			stage3D = new com.vsdevelop.display.Stage3D(this.stage);
			stage3D.addEventListener(Event.CONTEXT3D_CREATE, contextCreated);
			stage3D.requestContext3D();
		}
		
		private function contextCreated(event:Event):void
		{
			renderContext = stage3D.context3D;
			renderContext.configureBackBuffer(stage.stageWidth, stage.stageHeight, 4, true);
			
			var triangles:Vector.<uint> = Vector.<uint>([0, 1, 2]);
			indexList = renderContext.createIndexBuffer(triangles.length);
			indexList.uploadFromVector(triangles, 0, triangles.length);
			
			const dataPerVertex:int = 6;
			var vertexData:Vector.<Number> = Vector.<Number>(
				[
					// x, y, z, r, g, b
					-0.5, -0.5, 0.0, 1.0, 0.0, 0.0,
					 0.5, -0.5, 0.0, 0.0, 1.0, 0.0,
					 0.0,  0.5, 0.0, 0.0, 0.0, 1.0
				]);
			vertexes = renderContext.createVertexBuffer(vertexData.length / dataPerVertex, dataPerVertex);
			vertexes.uploadFromVector(vertexData, 0, vertexData.length / dataPerVertex);
			
			renderContext.setVertexBufferAt(0, vertexes, 0, "float3");
			renderContext.setVertexBufferAt(1, vertexes, 3, "float3");
			
			programPair = renderContext.createProgram();
			programPair.upload(VERTEX_SHADER, FRAGMENT_SHADER);
			renderContext.setProgram(programPair);
			
			var timer:Timer = new Timer(16);
			timer.addEventListener(TimerEvent.TIMER, render);
			timer.start();
		}
		
		private function render(event:TimerEvent = null):void
		{
			renderContext.clear(0.3, 0.3, 0.3, 1);
			renderContext.drawTriangles(indexList, 0, 1);
			renderContext.present();
		}
	}
}