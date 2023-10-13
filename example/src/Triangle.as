package
{
	import agl.shader.Shader;
	import com.vsdevelop.air.extension.glfw.ANEGLFW;
	import com.vsdevelop.air.extension.glfw.Gl;
	import com.vsdevelop.air.extension.glfw.Glfw;
	import com.vsdevelop.controls.Fps;
	import flash.display.Screen;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.geom.Matrix3D;
	import flash.geom.PerspectiveProjection;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Ray.lei
	 */
	public class Triangle extends Sprite
	{
		public var VAO:int;
		public var VBO:int;
		
		[Embed(source="assets/sphere/task3.vs", mimeType="application/octet-stream")]
		private var vsHlsl:Class;
		
		[Embed(source="assets/sphere/task3.fs", mimeType="application/octet-stream")]
		private var fsHlsl:Class;
		
		private var windowIntPtr:Number;
		private var shaderProgram:int;
		private var frame:int;
		
		private var glWidth:int = 800;
		private var glHeight:int = 450;
		private var note:flash.text.TextField;
		
		private var isAIRWindow:Boolean = true;
		
		private var perspectiveProjection:flash.geom.PerspectiveProjection;
		private var modelMat4:flash.geom.Matrix3D;
		private var viewMat4:flash.geom.Matrix3D;
		private var projectionMat4:flash.geom.Matrix3D;
		private var shader:agl.shader.Shader;
		
		public function Triangle():void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			// entry point
			
			stage.nativeWindow.addEventListener(Event.CLOSING, closeApp);
			stage.addEventListener(Event.RESIZE, stageResize);
			
			if (ANEGLFW.getInstance().isSupported)
			{
				
				trace(Glfw.glfwGetVersionString());
				
				Glfw.glfwSetErrorCallback(function(error_code:int, description:String):void
				{
					trace("ErrorCallback", error_code, description);
				});
				
				note = new TextField();
				note.defaultTextFormat = new TextFormat(null, 14, 0xffffff);
				note.text = "click start";
				addChild(note);
				
				note.x = 200;
				note.y = 20;
				
				ANEGLFW.getInstance().debug = true;
				stage.addEventListener(MouseEvent.CLICK, click);
			}
			addChild(new Fps());
		}
		
		private function stageResize(e:Event):void
		{
			if (isAIRWindow && frame)
			{
				Glfw.glfwSetWindowPos(windowIntPtr, 0, 0);
				Glfw.glfwSetWindowSize(windowIntPtr, stage.stageWidth * Screen.mainScreen.contentsScaleFactor, stage.stageHeight * Screen.mainScreen.contentsScaleFactor);
			}
		}
		
		private function click(e:MouseEvent):void
		{
			removeChild(note);
			stage.removeEventListener(MouseEvent.CLICK, click);
			
			Glfw.glfwInit();
			Glfw.glfwWindowHint(Glfw.GLFW_SAMPLES, 4);
			Glfw.glfwWindowHint(Glfw.GLFW_CONTEXT_VERSION_MAJOR, 3);
			Glfw.glfwWindowHint(Glfw.GLFW_CONTEXT_VERSION_MINOR, 3);
			Glfw.glfwWindowHint(Glfw.GLFW_OPENGL_PROFILE, Glfw.GLFW_OPENGL_CORE_PROFILE);
			Glfw.glfwWindowHint(Glfw.GLFW_OPENGL_FORWARD_COMPAT, 1);
			
			//bind air window
			if (isAIRWindow)
			{
				Glfw.glfwWindowHint(Glfw.GLFW_DECORATED, 0);
				Glfw.glfwWindowHint(Glfw.GLFW_FOCUSED, 0);
				Glfw.glfwWindowHint(Glfw.GLFW_RESIZABLE, 0);
				Glfw.glfwWindowHint(Glfw.GLFW_VISIBLE, 0);
			}
			
			windowIntPtr = Glfw.glfwCreateWindow(glWidth, glHeight, "Test");
			trace("intptr", windowIntPtr);
			if (!windowIntPtr) return;
			
			if (isAIRWindow)
			{
				var hwnd:int = Glfw.glfwGetWin32Window(windowIntPtr);
				if (hwnd)
				{
					ANEGLFW.getInstance().openGLToNativeWindow(hwnd, stage.nativeWindow);
					Glfw.glfwSetWindowPos(windowIntPtr, 200, 200);
				}
			}
			
			Glfw.glfwMakeContextCurrent(windowIntPtr);
			Glfw.glfwSetWindowSizeCallback(windowIntPtr, function(wIntPtr:Number, width:int, height:int):void
			{
				glWidth = width;
				glHeight = height;
				Gl.glViewport(0, 0, width, height);
			});
			
			//Glfw.glfwSetInputMode(windowIntPtr, Glfw.GLFW_CURSOR, Glfw.GLFW_CURSOR_DISABLED);
			//Glfw.glfwSetInputMode(windowIntPtr, Glfw.GLFW_CURSOR, Glfw.GLFW_CURSOR_HIDDEN);
			
			Glfw.glfwSetCursorPosCallback(windowIntPtr, function(wIntPtr:Number, x:int, y:int):void
			{
				trace("glfwSetCursorPosCallback", x, y);
			});
			Glfw.glfwSetMouseButtonCallback(windowIntPtr, function(wIntPtr:Number, button:int, action:int, mods:int):void
			{
				trace("glfwSetMouseButtonCallback", button, action, mods);
			});
			
			if (!Gl.gladLoadGLLoader())
			{
				trace("GL error");
				return;
			}
			
			
			var vector:Vector.<Number> = new <Number>[
			//     ---- 位置 ----    
				 -0.5, -0.5, 0.0,   // 左下
				  0.5, -0.5, 0.0,   // 右下
				  0.0,  0.5, 0.0    // 正上
			];
			
			VAO = Gl.glGenVertexArrays(1);
			Gl.glBindVertexArray(VAO);
			
			VBO = Gl.glGenBuffers(1);
			Gl.glBindBuffer(Gl.GL_ARRAY_BUFFER, VBO);
			Gl.glBufferData(Gl.GL_ARRAY_BUFFER, 3 * vector.length, vector, Gl.GL_STATIC_DRAW);
			
			Gl.glVertexAttribPointer(0, 3, Gl.GL_FLOAT, Gl.GL_FALSE, 3 * 4, 0);
			Gl.glEnableVertexAttribArray(0);
			
			
			var vs:String = new vsHlsl();
			var fs:String = new fsHlsl();			
			shader = new Shader(vs,fs);
			
			//Glfw.glfwSwapInterval(true);
			
			//Gl.glEnable(Gl.GL_DEPTH_TEST);
			
			addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function enterFrame(e:Event = null):void
		{
			if (!Glfw.glfwWindowShouldClose(windowIntPtr))
			{
				Gl.glClearColor(0, 0.3, 0.5);
				Gl.glClear(Gl.GL_COLOR_BUFFER_BIT);
				
				
				shader.useProgram();
				
				Gl.glBindVertexArray(VAO);
				Gl.glDrawArrays(Gl.GL_TRIANGLES, 0, 3);
				Gl.glBindVertexArray(0);
				
				Glfw.glfwSwapBuffers(windowIntPtr);
				//Glfw.glfwPollEvents();
				
				frame++;
				
				if (frame % 10 == 0)
				{
					//var point:Point = Glfw.glfwGetCursorPos(windowIntPtr);
					//trace(point);
				}
			}
		}
		
		private function closeApp(e:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, enterFrame);
			Glfw.glfwSetWindowShouldClose(windowIntPtr, true);
			Glfw.glfwDestroyWindow(windowIntPtr);
			Glfw.glfwTerminate();
			ANEGLFW.getInstance().dispose();
		}
	
	}

}