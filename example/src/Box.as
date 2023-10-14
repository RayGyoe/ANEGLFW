package
{
	import agl.shader.Shader;
	import agl.utils.Matrix4;
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
	public class Box extends Sprite
	{
		public var VAO:int;
		public var VBO:int;
		
		[Embed(source="assets/box/vs.glsl", mimeType="application/octet-stream")]
		private var vsHlsl:Class;
		
		[Embed(source="assets/box/fs.glsl", mimeType="application/octet-stream")]
		private var fsHlsl:Class;
		
		private var windowIntPtr:Number;
		private var shaderProgram:int;
		private var frame:int;
		
		private var glWidth:int = 800;
		private var glHeight:int = 450;
		private var note:flash.text.TextField;
		
		private var isAIRWindow:Boolean = true;
		
		private var perspectiveProjection:flash.geom.PerspectiveProjection;
		private var modelMat4:Matrix4;
		private var viewMat4:Matrix4;
		private var projectionMat4:Matrix4;
		private var shader:agl.shader.Shader;
		private var dragging:Boolean = false;
		private var lastX:Number;
		private var lastY:Number;
		private var rotateZ:Boolean;
		private var rotZ:Number = 0;
		private var rotX:Number = 0;
		private var rotY:Number = 0;
		private var mvpMatrix:Matrix4;
		
		public function Box():void
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
			
			Glfw.glfwSetCursorPosCallback(windowIntPtr, function(wIntPtr:Number,clientX:int, clientY:int):void
			{
				trace("glfwSetCursorPosCallback", x, y);
				
					var x:int = clientX;
					var y:int = clientY;
					if(dragging){
						var factor:Number = 100/stage.stageHeight;
						var dx:Number = factor * (x-lastX);
						var dy:Number = factor * (y-lastY);
						onDrag(dx, dy);
					}
					lastX = x;
					lastY = y;
			});
			Glfw.glfwSetMouseButtonCallback(windowIntPtr, function(wIntPtr:Number, button:int, action:int, mods:int):void
			{
				trace("glfwSetMouseButtonCallback", button, action, mods);
				
				dragging = button==0 && action;
			});
			
			if (!Gl.gladLoadGLLoader())
			{
				trace("GL error");
				return;
			}
			//Glfw.glfwSwapInterval(true);
			
			var vector:Vector.<Number> = new <Number>[-0.5, -0.5, -0.5, 1.0, 0.0, 0.0, 0.5, -0.5, -0.5, 1.0, 0.0, 0.0, 0.5, 0.5, -0.5, 1.0, 0.0, 0.0, 0.5, 0.5, -0.5, 1.0, 0.0, 0.0, -0.5, 0.5, -0.5, 1.0, 0.0, 0.0, -0.5, -0.5, -0.5, 1.0, 0.0, 0.0,
			
			-0.5, -0.5, 0.5, 0.0, 1.0, 0.0, 0.5, -0.5, 0.5, 0.0, 1.0, 0.0, 0.5, 0.5, 0.5, 0.0, 1.0, 0.0, 0.5, 0.5, 0.5, 0.0, 1.0, 0.0, -0.5, 0.5, 0.5, 0.0, 1.0, 0.0, -0.5, -0.5, 0.5, 0.0, 1.0, 0.0,
			
			-0.5, 0.5, 0.5, 0.0, 0.0, 1.0, -0.5, 0.5, -0.5, 0.0, 0.0, 1.0, -0.5, -0.5, -0.5, 0.0, 0.0, 1.0, -0.5, -0.5, -0.5, 0.0, 0.0, 1.0, -0.5, -0.5, 0.5, 0.0, 0.0, 1.0, -0.5, 0.5, 0.5, 0.0, 0.0, 1.0,
			
			0.5, 0.5, 0.5, 0.5, 0.0, 0.0, 0.5, 0.5, -0.5, 0.5, 0.0, 0.0, 0.5, -0.5, -0.5, 0.5, 0.0, 0.0, 0.5, -0.5, -0.5, 0.5, 0.0, 0.0, 0.5, -0.5, 0.5, 0.5, 0.0, 0.0, 0.5, 0.5, 0.5, 0.5, 0.0, 0.0,
			
			-0.5, -0.5, -0.5, 0.0, 0.5, 0.0, 0.5, -0.5, -0.5, 0.0, 0.5, 0.0, 0.5, -0.5, 0.5, 0.0, 0.5, 0.0, 0.5, -0.5, 0.5, 0.0, 0.5, 0.0, -0.5, -0.5, 0.5, 0.0, 0.5, 0.0, -0.5, -0.5, -0.5, 0.0, 0.5, 0.0,
			
			-0.5, 0.5, -0.5, 0.0, 0.0, 0.5, 0.5, 0.5, -0.5, 0.0, 0.0, 0.5, 0.5, 0.5, 0.5, 0.0, 0.0, 0.5, 0.5, 0.5, 0.5, 0.0, 0.0, 0.5, -0.5, 0.5, 0.5, 0.0, 0.0, 0.5, -0.5, 0.5, -0.5, 0.0, 0.0, 0.5];
			
			VAO = Gl.glGenVertexArrays(1);
			Gl.glBindVertexArray(VAO);
			
			VBO = Gl.glGenBuffers(1);
			Gl.glBindBuffer(Gl.GL_ARRAY_BUFFER, VBO);
			Gl.glBufferData(Gl.GL_ARRAY_BUFFER, 4 * vector.length, vector, Gl.GL_STATIC_DRAW);
			
			Gl.glVertexAttribPointer(0, 3, Gl.GL_FLOAT, Gl.GL_FALSE, 6 * 4, 0);
			Gl.glEnableVertexAttribArray(0);
			
			Gl.glVertexAttribPointer(1, 3, Gl.GL_FLOAT, Gl.GL_FALSE, 6 * 4, 3 * 4);
			Gl.glEnableVertexAttribArray(1);
			
			var vs:String = new vsHlsl();
			var fs:String = new fsHlsl();
			
			
			shader = new Shader(vs,fs);
			
			//Glfw.glfwSwapInterval(true);
			
			Gl.glEnable(Gl.GL_DEPTH_TEST);
			
			perspectiveProjection = new PerspectiveProjection();
			
			//
			//perspectiveProjection.fieldOfView = 0;
			//perspectiveProjection.projectionCenter = new Point(10,10);
			perspectiveProjection.focalLength = stage.stageWidth / stage.stageHeight;
			//
			
			modelMat4 = new Matrix4();
			//modelMat4.appendScale(0.5, 0.5, 0.5);
			viewMat4 = new Matrix4();
			viewMat4.setLookAt(.0, .0, 8.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);
			
			projectionMat4 = new Matrix4();
			projectionMat4.setPerspective(20.0, glWidth/glHeight, 1.0, 100.0);
			projectionMat4.multiply(viewMat4);
			
			mvpMatrix = projectionMat4.cloneMatrix4();
			
			
			addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function onDrag(dx:Number, dy:Number):void 
		{
			trace("onDrag", dx, dy, rotateZ);
			
			if(rotateZ){
				rotZ += dx;
			} else {
				rotX = Math.max(Math.min(rotX + dy, 90.0), -90.0);
				//rotX += dy;
				rotY += dx;
			}
			
			
			//modelMat4.appendRotation(rotZ, Vector3D.Z_AXIS);
			//modelMat4.appendRotation(rotY, Vector3D.Y_AXIS);
			//modelMat4.appendRotation(rotX, Vector3D.X_AXIS);
			
			modelMat4.setRotate(rotZ, 0, 0, 1); //rot around z-axis
			modelMat4.rotate(rotY, 0.0, 1.0, 0.0); //rot around y-axis
			modelMat4.rotate(rotX, 1.0, 0.0, 0.0); //rot around x-axis
			
			mvpMatrix = projectionMat4.cloneMatrix4();
			mvpMatrix.multiply(modelMat4);
			//modelMat4 = new Matrix4();
		}
		
		private function enterFrame(e:Event = null):void
		{
			if (!Glfw.glfwWindowShouldClose(windowIntPtr))
			{
				Gl.glClearColor(0, 0.3, 0.5);
				Gl.glClearDepth(1.0);
				Gl.glClear(Gl.GL_COLOR_BUFFER_BIT | Gl.GL_DEPTH_BUFFER_BIT);
				
				
				shader.useProgram();
				//Gl.glUniform3f(iResolutionPtr, glWidth, glHeight, 1);
				
				//Gl.glUniformMatrix4fv(projection_locationPtr,1, Gl.GL_FALSE, glm::value_ptr(model));//写入参数值
				
				//ANEGLFW.getInstance().context.call("ANE_render",model_locationPtr,view_locationPtr,projection_locationPtr);
				
				var perspectiveProjectionMat4:Matrix3D = perspectiveProjection.toMatrix3D();
				

				//modelMat4.appendRotation(1, Vector3D.Z_AXIS);
				//modelMat4.appendRotation(1, Vector3D.Y_AXIS);
				//modelMat4.appendRotation(1, Vector3D.X_AXIS);
				//trace(matrix3d);				
				//modelMat4.transpose();
				
				
				
				shader.setMatrix4fv("model", mvpMatrix);
				//shader.setMatrix4fv("view", viewMat4);
				//shader.setMatrix4fv("projection", projectionMat4);
				
				Gl.glBindVertexArray(VAO);
				Gl.glDrawArrays(Gl.GL_TRIANGLES, 0, 36);
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