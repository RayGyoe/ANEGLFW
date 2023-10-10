package {
    //import flash.desktop.NativeApplication;
    import com.vsdevelop.air.extension.glfw.ANEGLFW;
    import com.vsdevelop.air.extension.glfw.Gl;
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
    import flash.display.BitmapData;
    
    /**
     * ...
     * @author Ray.lei
     */
    public class Main extends Sprite {
        public var VAO:int;
        public var VBO:int;
        [Embed(source = "../assets/vs.hlsl", mimeType = "application/octet-stream")]
        private var vsHlsl:Class;
        
        [Embed(source = "../assets/fs.hlsl", mimeType = "application/octet-stream")]
        private var fsHlsl:Class;
        
        private var windowIntPtr:int;
        private var shaderProgram:int;
		private var frame:int;
        
        public function Main():void {
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;
            // entry point
            
            stage.nativeWindow.addEventListener(Event.CLOSING, closeApp);
            
            if (ANEGLFW.getInstance().isSupported) {
                ANEGLFW.getInstance().debug = false;
                stage.addEventListener(MouseEvent.CLICK, click);
                initTest();
            }
            addChild(new Fps());
        }
        
        private function initTest():void {
            //var vector:Vector.<Number> = new <Number>[
            //-1.0, -1.0,     0.0, 0.0,
            //-1.0, 1.0,      0.0, 1.0,
            //1.0, -1.0,      1.0, 0.0,
            //
            //1.0, -1.0,      1.0, 0.0,
            //-1.0, 1.0,      0.0, 1.0,
            //1.0, 1.0,       1.0, 1.0
            //];
            //ANEGLFW.getInstance().context.call("glBufferData",1,vector,2);
        }
        
        private function click(e:MouseEvent):void {
            
            stage.removeEventListener(MouseEvent.CLICK, click);
            
            if (!Glfw.glfwInit()) {
                trace("glfw init error！");
                return;
            }
            
            Glfw.glfwWindowHint(Glfw.GLFW_SAMPLES, 4);
            Glfw.glfwWindowHint(Glfw.GLFW_CONTEXT_VERSION_MAJOR, 3);
            Glfw.glfwWindowHint(Glfw.GLFW_CONTEXT_VERSION_MINOR, 3);
            Glfw.glfwWindowHint(Glfw.GLFW_OPENGL_PROFILE, Glfw.GLFW_OPENGL_CORE_PROFILE);
            Glfw.glfwWindowHint(Glfw.GLFW_OPENGL_FORWARD_COMPAT, 1);
            windowIntPtr = Glfw.glfwCreateWindow(800, 450, "Test");
            trace("intptr", windowIntPtr);
            if (!windowIntPtr) return;
            Glfw.glfwMakeContextCurrent(windowIntPtr);
			
			
			Glfw.glfwSetWindowSizeCallback(windowIntPtr, function(wIntPtr:int,width:int,height:int):void{
				trace("glfwSetWindowSizeCallback",wIntPtr, width, height);
			});
            
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
            
			
			enterFrame();
            addEventListener(Event.ENTER_FRAME, enterFrame);
        }
        
        private function enterFrame(e:Event = null):void {
            if (!Glfw.glfwWindowShouldClose(windowIntPtr)) {
                
                Gl.glClearColor(0, 0, 0);
                Gl.glClear(Gl.GL_COLOR_BUFFER_BIT | Gl.GL_DEPTH_BUFFER_BIT);
                
                Gl.glUseProgram(shaderProgram);
                Gl.glUniform3f(Gl.glGetUniformLocation(shaderProgram, "iResolution"), 800, 450, 1);
                Gl.glUniform1f(Gl.glGetUniformLocation(shaderProgram, "iTime"), Gl.glfwGetTime());
				Gl.glUniform1f(Gl.glGetUniformLocation(shaderProgram, "iFrame"), frame);
                Gl.glDrawArrays(Gl.GL_TRIANGLES, 0, 6);
                
                Glfw.glfwSwapBuffers(windowIntPtr);
                Glfw.glfwPollEvents();
				
				frame++;
            }
        }
        
        private function closeApp(e:Event):void {
            Glfw.glfwSetWindowShouldClose(windowIntPtr, true);
            removeEventListener(Event.ENTER_FRAME, enterFrame);
            ANEGLFW.getInstance().dispose();
        }
    
    }

}