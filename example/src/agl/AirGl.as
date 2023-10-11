package agl 
{
	import com.vsdevelop.air.extension.glfw.ANEGLFW;
	import com.vsdevelop.air.extension.glfw.Gl;
	import com.vsdevelop.air.extension.glfw.Glfw;
	import flash.display.Stage;
	/**
	 * ...
	 * @author Ray.lei
	 */
	public class AirGl 
	{
		public static const VERSION:String = "1.0.0";
		
		
		
		private var windowIntPtr:Number;
		private var _stage:Stage;
		
		
		public function AirGl(stage:Stage) 
		{
			_stage = stage;
			
			if (!ANEGLFW.getInstance().isSupported)
			{
				trace("not Support opengl");
				return;
			}
			
			
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
			
			Glfw.glfwSetWindowSizeCallback(windowIntPtr, function(wIntPtr:Number, width:int, height:int):void
			{
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
			trace("stage frameRate",_stage.frameRate);
		}
		
		public function render():void 
		{
			if (!windowIntPtr) return;
			
			//Glfw.glfwMakeContextCurrent(windowIntPtr);
			Gl.glClear(Gl.GL_COLOR_BUFFER_BIT | Gl.GL_DEPTH_BUFFER_BIT);
			//Gl.glClearColor(0, 0, 0);
					
				
			Glfw.glfwSwapBuffers(windowIntPtr);
		}
		
	}

}