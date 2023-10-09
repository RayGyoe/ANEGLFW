package
{
	//import flash.desktop.NativeApplication;
	import com.vsdevelop.air.extension.glfw.ANEGLFW;
	import com.vsdevelop.air.extension.glfw.Glfw;
	import com.vsdevelop.controls.Fps;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.external.ExtensionContext;
	import flash.filesystem.File;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	/**
	 * ...
	 * @author Ray.lei
	 */
	public class Main extends Sprite
	{
		[Embed(source="../assets/vs.hlsl", mimeType="application/octet-stream")]
		private var vsHlsl:Class;
		
		[Embed(source="../assets/fs2.hlsl", mimeType="application/octet-stream")]
		private var fsHlsl:Class;
		
		private var windowIntPtr:int;
		private var shaderProgram:int;
		
		public function Main():void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			// entry point
			
			stage.nativeWindow.addEventListener(Event.CLOSING, closeApp);
			
			if (ANEGLFW.getInstance().isSupported)
			{
				ANEGLFW.getInstance().debug = false;
				stage.addEventListener(MouseEvent.CLICK, click);
			}
			addChild(new Fps());
		}
		
		private function click(e:MouseEvent):void
		{
			
			stage.removeEventListener(MouseEvent.CLICK, click);			
			//OpenGL  Direct3D11   Direct3D12
			
			if (!Glfw.glfwInit()){
				trace("glfw init error！");
				return;
			}
			
			Glfw.glfwWindowHint(Glfw.GLFW_SAMPLES, 4);
			Glfw.glfwWindowHint(Glfw.GLFW_CONTEXT_VERSION_MAJOR, 3);
			Glfw.glfwWindowHint(Glfw.GLFW_CONTEXT_VERSION_MINOR, 3);
			Glfw.glfwWindowHint(Glfw.GLFW_OPENGL_PROFILE, Glfw.GLFW_OPENGL_CORE_PROFILE);
			Glfw.glfwWindowHint(Glfw.GLFW_OPENGL_FORWARD_COMPAT, 1);
			
			windowIntPtr = ANEGLFW.getInstance().context.call("glfwCreateWindow", 800, 450, "Test") as int;
			trace("intptr", windowIntPtr);
			if (windowIntPtr){
				
				
				var fs:String = new fsHlsl();
				trace(fs);
				var vs:String = new vsHlsl();
				trace(vs);
				shaderProgram = ANEGLFW.getInstance().context.call("ANE_glinit", vs, fs) as int;
				trace("shaderProgram", shaderProgram);
				
				
				if (shaderProgram){
					addEventListener(Event.ENTER_FRAME, enterFrame);
				}
			}
		}
		
		private function enterFrame(e:Event):void 
		{
			if (!Glfw.glfwWindowShouldClose(windowIntPtr))
			{
				ANEGLFW.getInstance().context.call("ANE_render", shaderProgram);
				
				Glfw.glfwSwapBuffers(windowIntPtr);
				Glfw.glfwPollEvents();
			}
		}
		
		private function closeApp(e:Event):void
		{
			Glfw.glfwSetWindowShouldClose(windowIntPtr, true);
			removeEventListener(Event.ENTER_FRAME, enterFrame);
			ANEGLFW.getInstance().dispose();
		}
		
	}

}