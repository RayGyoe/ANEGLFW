package {
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
	import flash.text.TextField;
	import flash.text.TextFormat;
    
    /**
     * ...
     * @author Ray.lei
     */
    public class Main extends Sprite {
        public var VAO:int;
        public var VBO:int;
        [Embed(source = "../assets/vs.hlsl", mimeType = "application/octet-stream")]
        private var vsHlsl:Class;
        
        [Embed(source = "../assets/Ms2SDc.hlsl", mimeType = "application/octet-stream")]
		//[Embed(source="../assets/3lsSzf.hlsl", mimeType="application/octet-stream")]
		//[Embed(source="../assets/Ms2SD1.hlsl", mimeType="application/octet-stream")]
		//[Embed(source="../assets/tsXBzS.hlsl", mimeType="application/octet-stream")]
        private var fsHlsl:Class;
        
        private var windowIntPtr:Number;
        private var shaderProgram:int;
		private var frame:int;
		
		
		private var glWidth:int = 800;
		private var glHeight:int = 450;
		private var note:flash.text.TextField;
        
		
		private var isAIRWindow:Boolean = true;
		
        public function Main():void {
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;
            // entry point
            
            stage.nativeWindow.addEventListener(Event.CLOSING, closeApp);
			stage.addEventListener(Event.RESIZE, stageResize);
            
            if (ANEGLFW.getInstance().isSupported) {
				
				note = new TextField();
				note.defaultTextFormat = new TextFormat(null, 14, 0xffffff);
				note.text = "click start";
				addChild(note);
				
				note.x =  200;
				note.y = 20;
				
                ANEGLFW.getInstance().debug = false;
                stage.addEventListener(MouseEvent.CLICK, click);
            }
            addChild(new Fps());
        }
		
		private function stageResize(e:Event):void 
		{
			if (isAIRWindow && frame)
			{
				Glfw.glfwSetWindowPos(windowIntPtr, 0, 60);
				Glfw.glfwSetWindowSize(windowIntPtr, stage.stageWidth * Screen.mainScreen.contentsScaleFactor, stage.stageHeight * Screen.mainScreen.contentsScaleFactor);				
			}
		}
        
		private function framebuffer_size_callback(wIntPtr:Number,width:int,height:int):void{
			//trace("glfwSetWindowSizeCallback", wIntPtr, width, height);
			glWidth = width;
			glHeight = height;
			Gl.glViewport(0, 0, width, height);
		}
        private function click(e:MouseEvent):void {
            
			removeChild(note);
            stage.removeEventListener(MouseEvent.CLICK, click);
            
            Glfw.glfwInit();
            Glfw.glfwWindowHint(Glfw.GLFW_SAMPLES, 4);
            Glfw.glfwWindowHint(Glfw.GLFW_CONTEXT_VERSION_MAJOR, 3);
            Glfw.glfwWindowHint(Glfw.GLFW_CONTEXT_VERSION_MINOR, 3);
            Glfw.glfwWindowHint(Glfw.GLFW_OPENGL_PROFILE, Glfw.GLFW_OPENGL_CORE_PROFILE);
            Glfw.glfwWindowHint(Glfw.GLFW_OPENGL_FORWARD_COMPAT, 1);
			
			//bind air window
			if (isAIRWindow){
				Glfw.glfwWindowHint(Glfw.GLFW_DECORATED, 0);
				Glfw.glfwWindowHint(Glfw.GLFW_FOCUSED, 0);
				Glfw.glfwWindowHint(Glfw.GLFW_RESIZABLE, 0);
				Glfw.glfwWindowHint(Glfw.GLFW_VISIBLE, 0);
			}

            windowIntPtr = Glfw.glfwCreateWindow(glWidth, glHeight, "Test");
            trace("intptr", windowIntPtr);
            if (!windowIntPtr) return;
			
			if (isAIRWindow){
				var hwnd:int = Glfw.glfwGetWin32Window(windowIntPtr);
				if (hwnd)
				{
					ANEGLFW.getInstance().openGLToNativeWindow(hwnd, stage.nativeWindow);
					Glfw.glfwSetWindowPos(windowIntPtr, 100, 100);
				}
			}
			
            Glfw.glfwMakeContextCurrent(windowIntPtr);
			Glfw.glfwSetWindowSizeCallback(windowIntPtr, framebuffer_size_callback);
            
            if (!Gl.gladLoadGLLoader()) {
                trace("GL error");
                return;
            }
            
            var vector:Vector.<Number> = new <Number>[
													-1.0, -1.0, 0.0, 0.0, 
													-1.0, 1.0, 0.0, 1.0, 
													1.0, -1.0, 1.0, 0.0,
													
													1.0, -1.0, 1.0, 0.0, 
													-1.0, 1.0, 0.0, 1.0, 
													1.0, 1.0, 1.0, 1.0];
            
            VAO = Gl.glGenVertexArrays(1);
            Gl.glBindVertexArray(VAO);
            
            VBO = Gl.glGenBuffers(1);
            Gl.glBindBuffer(Gl.GL_ARRAY_BUFFER, VBO);
            Gl.glBufferData(Gl.GL_ARRAY_BUFFER, 4 * vector.length, vector, Gl.GL_STATIC_DRAW);
            
            Gl.glVertexAttribPointer(0, 2, Gl.GL_FLOAT, Gl.GL_FALSE, 4 * 4, 0);
            Gl.glEnableVertexAttribArray(0);
            
            Gl.glVertexAttribPointer(1, 2, Gl.GL_FLOAT, Gl.GL_FALSE, 4 * 4, 2 * 4);
            Gl.glEnableVertexAttribArray(1);
            
            var vs:String = new vsHlsl();
            var fs:String = new fsHlsl();
            
            //vertex shader
            var vertexShader:int = Gl.glCreateShader(Gl.GL_VERTEX_SHADER);
            Gl.glShaderSource(vertexShader, 1, vs);
            Gl.glCompileShader(vertexShader);
            
            //fragment shader
            var fragmentShader:int = Gl.glCreateShader(Gl.GL_FRAGMENT_SHADER);
            Gl.glShaderSource(fragmentShader, 1, fs);
            Gl.glCompileShader(fragmentShader);
            
            // link shaders			
            shaderProgram = Gl.glCreateProgram();
            Gl.glAttachShader(shaderProgram, vertexShader);
            Gl.glAttachShader(shaderProgram, fragmentShader);
            Gl.glLinkProgram(shaderProgram);
            // check for linking errors
            
            Gl.glDeleteShader(vertexShader);
            Gl.glDeleteShader(fragmentShader);
            
			Glfw.glfwSwapInterval(true);
			//enterFrame();
            addEventListener(Event.ENTER_FRAME, enterFrame);
        }
        
        private function enterFrame(e:Event = null):void {
            if (!Glfw.glfwWindowShouldClose(windowIntPtr)) {
                
                Gl.glClearColor(0, 0, 0);
                Gl.glClear(Gl.GL_COLOR_BUFFER_BIT | Gl.GL_DEPTH_BUFFER_BIT);
                
                Gl.glUseProgram(shaderProgram);
                Gl.glUniform3f(Gl.glGetUniformLocation(shaderProgram, "iResolution"), glWidth, glHeight, 1);
                Gl.glUniform1f(Gl.glGetUniformLocation(shaderProgram, "iTime"), Gl.glfwGetTime());
				Gl.glUniform1f(Gl.glGetUniformLocation(shaderProgram, "iFrame"), frame);
                Gl.glDrawArrays(Gl.GL_TRIANGLES, 0, 6);
                
                Glfw.glfwSwapBuffers(windowIntPtr);
                Glfw.glfwPollEvents();
				
				frame++;
            }
        }
        
        private function closeApp(e:Event):void {
			
            removeEventListener(Event.ENTER_FRAME, enterFrame);
            Glfw.glfwSetWindowShouldClose(windowIntPtr, true);
			Glfw.glfwDestroyWindow(windowIntPtr);
			
            ANEGLFW.getInstance().dispose();
        }
    
    }

}