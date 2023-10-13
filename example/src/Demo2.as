package
{
	import agl.AirGl;
	import agl.core.Mesh;
	import agl.shader.Shader;
	import agl.core.VertexFormat;
	import agl.utils.VertexSemantic;
<<<<<<< HEAD
	import com.vsdevelop.air.extension.glfw.Gl;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
=======
	import flash.display.Sprite;
>>>>>>> a06a60f3db15f644b949939c977d4e683c1a161c
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
<<<<<<< HEAD
		private var mesh:agl.core.Mesh;
		
		public function Demo2()
		{
		
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
=======
		
		public function Demo2()
		{
>>>>>>> a06a60f3db15f644b949939c977d4e683c1a161c
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
			
<<<<<<< HEAD
			
					
			// cube
			//       ^ Y
			//       | 
			//       |
			//       / -------> X 
			//      /
			//     v
			//    Z
			//
			//    v6----- v5
			//   /|      /|
			//  v1------v0|
			//  | |     | |
			//  | |v7---|-|v4
			//  |/      |/
			//  v2------v3

			mesh = new Mesh(format);
			mesh.shader = shader;
			
			var position_data:Vector.<Number> = new <Number>[
				//v0-v1-v2-v3 front (0,1,2,3)
				1.0, 1.0, 1.0,  -1.0, 1.0, 1.0,  -1.0, -1.0, 1.0,  1.0, -1.0, 1.0,
				//v0-v3-v4-v5 right (4,5,6,7)
				1.0, 1.0, 1.0,  1.0, -1.0, 1.0,  1.0, -1.0, -1.0,  1.0, 1.0, -1.0,
				//v0-v5-v6-v1 top (8,9,10,11)
				1.0, 1.0, 1.0,  1.0, 1.0, -1.0,  -1.0, 1.0, -1.0, -1.0, 1.0, 1.0,
				//v1-v6-v7-v2 left (12,13,14,15)
				-1.0, 1.0, 1.0,  -1.0, 1.0, -1.0,  -1.0, -1.0, -1.0,  -1.0, -1.0, 1.0,
				//v7-v4-v3-v2 bottom (16,17,18,19)
				-1.0, -1.0, -1.0,  1.0, -1.0, -1.0,  1.0, -1.0, 1.0,  -1.0, -1.0, 1.0,
				//v4-v7-v6-v5 back (20,21,22,23)
				1.0, -1.0, -1.0,  -1.0, -1.0, -1.0,  -1.0, 1.0, -1.0,  1.0, 1.0, -1.0        
			];
			var color_data:Vector.<Number> = new <Number>[
				//v0-v1-v2-v3 front (blue)
				0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0,
				//v0-v3-v4-v5 right (green)
				0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0,
				//v0-v5-v6-v1 top (red)
				1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0,
				//v1-v6-v7-v2 left (yellow)
				1.0, 1.0, 0.0, 1.0, 1.0, 0.0, 1.0, 1.0, 0.0, 1.0, 1.0, 0.0,
				//v7-v4-v3-v2 bottom (white)
				1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
				//v4-v7-v6-v5 back
				0.0, 1.0, 1.0, 0.0, 1.0, 1.0, 0.0, 1.0, 1.0, 0.0, 1.0, 1.0
			];

			var triangels:Vector.<Number> = new <Number>[
				0,1,2, 0,2,3,       //front
				4,5,6, 4,6,7,       //right
				8,9,10, 8,10,11,    //top
				12,13,14, 12,14,15, //left
				16,17,18, 16,18,19, //bottom
				20,21,22, 20,22,23  //back
			]


			mesh.setVertexData(VertexSemantic.POSITION, position_data);    
			mesh.setVertexData(VertexSemantic.COLOR, color_data);   
			mesh.setTriangles(triangels);
			mesh.upload();
			
					
			//shader.setUniform('u_mvpMatrix', mvpMatrix.elements);

			airgl.addRender(mesh);
		    
			
			
			trace("ENTER_FRAME");
			//render();
			addEventListener(Event.ENTER_FRAME, render);
		}
		
		private function render(e:Event = null):void
		{
			airgl.render();
=======
			new Mesh(format);
			
			trace("ENTER_FRAME");
			addEventListener(Event.ENTER_FRAME, render);
		}
		
		private function render(e:Event):void
		{
			//airgl.render();
>>>>>>> a06a60f3db15f644b949939c977d4e683c1a161c
		}
	
	}

}