package
{
	import agl.AirGl;
	import agl.core.Mesh;
	import agl.shader.Shader;
	import agl.core.VertexFormat;
	import agl.utils.VertexSemantic;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ray.lei
	 */
	public class Demo2 extends Sprite
	{
		private var airgl:AirGl;
		private var shader:agl.shader.Shader;
		
		[Embed(source = "assets/vs.glsl", mimeType = "application/octet-stream")]
		private var VSHADER_SOURCE:Class;
		[Embed(source = "assets/fs.glsl", mimeType = "application/octet-stream")]
		private var FSHADER_SOURCE:Class;
		
		public function Demo2()
		{
			airgl = new AirGl(stage);
			
			shader = new Shader();
			if (!shader.create(new VSHADER_SOURCE(), new FSHADER_SOURCE()))
			{
				trace("Failed to initialize shaders");
				return;
			}
			shader.mapAttributeSemantic(VertexSemantic.POSITION, 'a_Position');
			shader.mapAttributeSemantic(VertexSemantic.COLOR, 'a_Color');
			shader.useProgram();
			
			var format:VertexFormat = new VertexFormat();
			format.addAttrib(VertexSemantic.POSITION, 3);
			format.addAttrib(VertexSemantic.COLOR, 3); // cube
			
			new Mesh(format);
			
			trace("ENTER_FRAME");
			addEventListener(Event.ENTER_FRAME, render);
		}
		
		private function render(e:Event):void
		{
			//airgl.render();
		}
	
	}

}