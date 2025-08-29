package com.vsdevelop.display
{
	import com.vsdevelop.air.extension.glfw.ANEGLFW;
	import com.vsdevelop.air.extension.glfw.Gl;
	import com.vsdevelop.air.extension.glfw.Glfw;
	import com.vsdevelop.display3D.Context3D;
	import flash.display.Screen;
	import flash.display.Stage;
	import flash.utils.setTimeout;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class Stage3D extends EventDispatcher
	{
		private var _context3D:Context3D;
		private var _visible:Boolean = true;
		private var _x:Number = 0;
		private var _y:Number = 0;
		private var _stage:Stage;
		
		public function get activeWindow():int
		{
			return _activeWindow;
		}
		
		private var _activeWindow:int;
		
		public function Stage3D(stage:Stage)
		{
			_stage = stage;
		}
		
		public function get context3D():Context3D
		{
			return _context3D;
		}
		
		public function requestContext3D():void
		{
			if (!_context3D)
			{
				
				Glfw.glfwInit();
				
				// 设置OpenGL版本和配置
				
				with (Glfw)
				{
					glfwWindowHint(Glfw.GLFW_SAMPLES, 4);
					glfwWindowHint(Glfw.GLFW_CONTEXT_VERSION_MAJOR, 3);
					glfwWindowHint(Glfw.GLFW_CONTEXT_VERSION_MINOR, 3);
					glfwWindowHint(Glfw.GLFW_OPENGL_PROFILE, Glfw.GLFW_OPENGL_CORE_PROFILE);
					glfwWindowHint(Glfw.GLFW_OPENGL_FORWARD_COMPAT, 1);
					glfwWindowHint(Glfw.GLFW_DECORATED, 0);
					glfwWindowHint(Glfw.GLFW_FOCUSED, 0);
					glfwWindowHint(Glfw.GLFW_RESIZABLE, 0);
					glfwWindowHint(Glfw.GLFW_VISIBLE, 0);
				}
				_context3D = new Context3D(this);
				
				var glWidth:int = _stage.stageWidth * _stage.contentsScaleFactor;
				var glHeight:int = _stage.stageHeight * _stage.contentsScaleFactor;
				// 创建窗口
				_activeWindow = Glfw.glfwCreateWindow(glWidth, glHeight, "opengl-for-adobe-air");
				var hwnd:int = Glfw.glfwGetWin32Window(_activeWindow);
				if (hwnd)
				{
					ANEGLFW.getInstance().openGLToNativeWindow(hwnd, _stage.nativeWindow);
					Glfw.glfwSetWindowPos(_activeWindow, 0, 0);
				}
				
				// 设置OpenGL上下文
				Glfw.glfwMakeContextCurrent(_activeWindow);
				
				// 设置回调函数
				//setupCallbacks();
				
				// 加载OpenGL函数
				if (!Gl.gladLoadGLLoader())
				{
					trace("加载OpenGL函数失败");
				}
				
				// Simulate async creation and dispatch event
				
				dispatchEvent(new Event(Event.CONTEXT3D_CREATE));
			}
		}
		
		public function get visible():Boolean
		{
			return _visible;
		}
		
		public function set visible(value:Boolean):void
		{
			_visible = value;
		}
		
		public function get x():Number
		{
			return _x;
		}
		
		public function set x(value:Number):void
		{
			_x = value;
		}
		
		public function get y():Number
		{
			return _y;
		}
		
		public function set y(value:Number):void
		{
			_y = value;
		}
	}
}