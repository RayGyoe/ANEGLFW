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
	public class Sphere extends Sprite
	{
		public var VAO:int;
		public var VBO:int;
		public var EBO:int;
		
		
		[Embed(source="assets/sphere/task3.vs", mimeType="application/octet-stream")]
		private var vsHlsl:Class;
		
		[Embed(source="assets/sphere/task3.fs", mimeType="application/octet-stream")]
		private var fsHlsl:Class;
		
		private var windowIntPtr:Number;
		private var shaderProgram:int;
		private var frame:int;
		
		private var glWidth:int = 800;
		private var glHeight:int = 800;
		
		private var note:flash.text.TextField;
		
		private var isAIRWindow:Boolean = true;
		
		private var perspectiveProjection:flash.geom.PerspectiveProjection;
		private var modelMat4:flash.geom.Matrix3D;
		private var viewMat4:flash.geom.Matrix3D;
		private var projectionMat4:flash.geom.Matrix3D;
		private var shader:agl.shader.Shader;
		
			//将球横纵划分成50X50的网格
		private	const Y_SEGMENTS:int = 50;
		private	const X_SEGMENTS:int = 50;
			
		public function Sphere() 
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
			//Glfw.glfwWindowHint(Glfw.GLFW_SAMPLES, 4);
			Glfw.glfwWindowHint(Glfw.GLFW_CONTEXT_VERSION_MAJOR, 3);// OpenGL版本为3.3，主次版本号均设为3
			Glfw.glfwWindowHint(Glfw.GLFW_CONTEXT_VERSION_MINOR, 3);
			Glfw.glfwWindowHint(Glfw.GLFW_OPENGL_PROFILE, Glfw.GLFW_OPENGL_CORE_PROFILE);// 使用核心模式(无需向后兼容性)
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
			
			Gl.glViewport(0, 0, glWidth, glHeight);
			
			shader = new Shader(new vsHlsl(),new fsHlsl());
			
			
			var sphereVertices:Vector.<Number> = new Vector.<Number>();
			for (var y:int = 0; y <= Y_SEGMENTS; y++)
			{
				for (var x:int = 0; x <= X_SEGMENTS; x++)
				{
					var xSegment:Number = x / X_SEGMENTS;
					var ySegment:Number = y / Y_SEGMENTS;
					var xPos:Number = Math.cos(xSegment * 2.0 * Math.PI) * Math.sin(ySegment * Math.PI);
					var yPos:Number = Math.cos(ySegment * Math.PI);
					var zPos:Number = Math.sin(xSegment * 2.0 * Math.PI) * Math.sin(ySegment * Math.PI);
					
					sphereVertices.push(xPos);
					sphereVertices.push(yPos);
					sphereVertices.push(zPos);
				}
			}
			
			// 生成球的Indices
			var sphereIndices:Vector.<Number> = new Vector.<Number>();
			for (var i:int = 0; i < Y_SEGMENTS; i++)
			{
				for (var j:int = 0; j < X_SEGMENTS; j++)
				{
					sphereIndices.push(int(i * (X_SEGMENTS+1) + j));
					sphereIndices.push(int((i + 1) * (X_SEGMENTS + 1) + j));
					sphereIndices.push(int((i + 1) * (X_SEGMENTS + 1) + j + 1));

					sphereIndices.push(int(i * (X_SEGMENTS + 1) + j));
					sphereIndices.push(int((i + 1) * (X_SEGMENTS + 1) + j + 1));
					sphereIndices.push(int(i * (X_SEGMENTS + 1) + j + 1));
				}
			}
			
			
			VAO = Gl.glGenVertexArrays(1);
			Gl.glBindVertexArray(VAO);
			
			VBO = Gl.glGenBuffers(1);
			Gl.glBindBuffer(Gl.GL_ARRAY_BUFFER, VBO);
			Gl.glBufferData(Gl.GL_ARRAY_BUFFER, 4 * sphereVertices.length, sphereVertices, Gl.GL_STATIC_DRAW);
			
			EBO = Gl.glGenBuffers(1);
			Gl.glBindBuffer(Gl.GL_ELEMENT_ARRAY_BUFFER, EBO);
			Gl.glBufferData(Gl.GL_ELEMENT_ARRAY_BUFFER, 4 * sphereIndices.length, sphereIndices, Gl.GL_STATIC_DRAW);
			
			
			// 设置顶点属性指针
			Gl.glVertexAttribPointer(0, 3, Gl.GL_FLOAT, Gl.GL_FALSE, 3 * 4, 0);
			Gl.glEnableVertexAttribArray(0);
			
			// 解绑VAO和VBO
			Gl.glBindBuffer(Gl.GL_ARRAY_BUFFER, 0);
			Gl.glBindVertexArray(0);
			
			
			//Glfw.glfwSwapInterval(true);
			
			
			addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function enterFrame(e:Event = null):void
		{
			if (!Glfw.glfwWindowShouldClose(windowIntPtr))
			{
				Gl.glClearColor(0.0, 0.34, 0.57, 1.0);
				Gl.glClear(Gl.GL_COLOR_BUFFER_BIT);
				
				
				shader.useProgram();
				
				//绘制球
				//开启面剔除(只需要展示一个面，否则会有重合)
				Gl.glEnable(Gl.GL_CULL_FACE);
				Gl.glCullFace(Gl.GL_BACK);
				Gl.glBindVertexArray(VAO);
				
				//使用线框模式绘制
				Gl.glPolygonMode(Gl.GL_FRONT_AND_BACK, Gl.GL_LINE);
				Gl.glDrawElements(Gl.GL_TRIANGLES, X_SEGMENTS * Y_SEGMENTS * 6, Gl.GL_UNSIGNED_INT, 0);

				
				//点阵模式绘制
				//Gl.glPointSize(5);
				//Gl.glDrawElements(Gl.GL_POINTS, X_SEGMENTS*Y_SEGMENTS*6, Gl.GL_UNSIGNED_INT, 0);
						
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