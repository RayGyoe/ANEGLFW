package agl 
{
<<<<<<< HEAD
	import agl.core.Mesh;
	import com.vsdevelop.air.extension.glfw.ANEGLFW;
	import com.vsdevelop.air.extension.glfw.Gl;
	import com.vsdevelop.air.extension.glfw.Glfw;
	import flash.display.Screen;
	import flash.display.Stage;
	import flash.events.Event;
=======
	import com.vsdevelop.air.extension.glfw.ANEGLFW;
	import com.vsdevelop.air.extension.glfw.Gl;
	import com.vsdevelop.air.extension.glfw.Glfw;
	import flash.display.Stage;
>>>>>>> a06a60f3db15f644b949939c977d4e683c1a161c
	/**
	 * ...
	 * @author Ray.lei
	 */
	public class AirGl 
	{
		public static const VERSION:String = "1.0.0";
		
		
		
		private var windowIntPtr:Number;
		private var _stage:Stage;
<<<<<<< HEAD
		private var renders:Array = [];
=======
>>>>>>> a06a60f3db15f644b949939c977d4e683c1a161c
		
		
		public function AirGl(stage:Stage) 
		{
			_stage = stage;
			
			if (!ANEGLFW.getInstance().isSupported)
			{
				trace("not Support opengl");
				return;
			}
<<<<<<< HEAD
			_stage.addEventListener(Event.RESIZE, stageResize);
			
			trace(Glfw.glfwGetVersionString());
			
			Glfw.glfwSetErrorCallback(function(error_code:int,description:String):void{
				trace("ErrorCallback",error_code, description);
			});
=======
			
>>>>>>> a06a60f3db15f644b949939c977d4e683c1a161c
			
			Glfw.glfwInit();
			Glfw.glfwWindowHint(Glfw.GLFW_SAMPLES, 4);
			Glfw.glfwWindowHint(Glfw.GLFW_CONTEXT_VERSION_MAJOR, 3);
			Glfw.glfwWindowHint(Glfw.GLFW_CONTEXT_VERSION_MINOR, 3);
			Glfw.glfwWindowHint(Glfw.GLFW_OPENGL_PROFILE, Glfw.GLFW_OPENGL_CORE_PROFILE);
			Glfw.glfwWindowHint(Glfw.GLFW_OPENGL_FORWARD_COMPAT, 1);
			
			Glfw.glfwWindowHint(Glfw.GLFW_DECORATED, 0);
			Glfw.glfwWindowHint(Glfw.GLFW_FOCUSED, 0);
			Glfw.glfwWindowHint(Glfw.GLFW_RESIZABLE, 0);
			Glfw.glfwWindowHint(Glfw.GLFW_VISIBLE, 0);
			
			
			windowIntPtr = Glfw.glfwCreateWindow(_stage.stageWidth, _stage.stageHeight, "Test");
			trace("intptr", windowIntPtr);
			if (!windowIntPtr) return;
			
			var hwnd:int = Glfw.glfwGetWin32Window(windowIntPtr);
			ANEGLFW.getInstance().openGLToNativeWindow(hwnd, stage.nativeWindow);
			
			
			Glfw.glfwMakeContextCurrent(windowIntPtr);
			
<<<<<<< HEAD
			
			Glfw.glfwSetWindowSizeCallback(windowIntPtr, function(wIntPtr:Number, width:int, height:int):void
			{
				Glfw.glfwSetWindowSize(windowIntPtr, _stage.stageWidth * Screen.mainScreen.contentsScaleFactor, _stage.stageHeight * Screen.mainScreen.contentsScaleFactor);
=======
			Glfw.glfwSetWindowSizeCallback(windowIntPtr, function(wIntPtr:Number, width:int, height:int):void
			{
>>>>>>> a06a60f3db15f644b949939c977d4e683c1a161c
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
			//Glfw.glfwSwapInterval(true);
			trace("init AirGl",VERSION);
<<<<<<< HEAD
			trace("stage frameRate", _stage.frameRate);
			
			
			Gl.glClearColor(0, 0, 0);
			Gl.glClearDepth(1.0);
			Gl.glEnable(Gl.GL_DEPTH_TEST);
		}
		
		private function stageResize(e:Event):void 
		{
			Glfw.glfwSetWindowPos(windowIntPtr, 0, 0);
			Glfw.glfwSetWindowSize(windowIntPtr, _stage.stageWidth * Screen.mainScreen.contentsScaleFactor, _stage.stageHeight * Screen.mainScreen.contentsScaleFactor);
=======
			trace("stage frameRate",_stage.frameRate);
>>>>>>> a06a60f3db15f644b949939c977d4e683c1a161c
		}
		
		public function render():void 
		{
			if (!windowIntPtr) return;
			
			//Glfw.glfwMakeContextCurrent(windowIntPtr);
			Gl.glClear(Gl.GL_COLOR_BUFFER_BIT | Gl.GL_DEPTH_BUFFER_BIT);
			//Gl.glClearColor(0, 0, 0);
<<<<<<< HEAD
			
			for (var i:int = 0; i < renders.length; i++ ){
				renders[i]['render']();
			}
=======
					
>>>>>>> a06a60f3db15f644b949939c977d4e683c1a161c
				
			Glfw.glfwSwapBuffers(windowIntPtr);
		}
		
<<<<<<< HEAD
		public function addRender(mesh:agl.core.Mesh):void 
		{
			renders[renders.length] = mesh;
		}
		
=======
>>>>>>> a06a60f3db15f644b949939c977d4e683c1a161c
	}

}