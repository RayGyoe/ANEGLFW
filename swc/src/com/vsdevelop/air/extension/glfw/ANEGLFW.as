package com.vsdevelop.air.extension.glfw
{
	
	import flash.display.NativeWindow;
	import flash.display.Stage;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	/**
	 * ANEGLFW扩展主类，提供GLFW库的ActionScript接口
	 * @author Ray.lei
	 */
	public class ANEGLFW {
		
		private static var _instance:ANEGLFW;
		private var _extCtx:ExtensionContext;
		private var _isSupported:Boolean;
		
		
		private var _debug:Boolean = false;
		
		
		/**
	 * 构造函数，初始化ANEGLFW扩展
	 */
	public function ANEGLFW() 
	{
		if (!_instance)
		{
			_extCtx = ExtensionContext.createExtensionContext("com.vsdevelop.air.extension.glfw", null);
			
			if (_extCtx != null)
			{
				
				_isSupported = _extCtx.call("isSupported") as Boolean;
				
				if(_isSupported)
				{
					_extCtx.actionScriptData = {
													callback:{
														
													}
												};
				}
				
				_extCtx.addEventListener(StatusEvent.STATUS, onStatus);
			} else
			{
				trace('extCtx is null.'); 
			}
			_instance = this;
		}
		else
		{
			throw Error( 'This is a singleton, use getInstance, do not call the constructor directly');
		}
	}
		
		public function get actionScriptData():Object
		{
			return _extCtx.actionScriptData;
		}
		
		/**
	 * 获取ANEGLFW单例实例
	 * @return ANEGLFW实例
	 */
	public static function getInstance() : ANEGLFW
	{
		return _instance ? _instance : new ANEGLFW();
	}
		
		/**
	 * 检查当前平台是否支持ANEGLFW扩展
	 * @return 如果支持返回true，否则返回false
	 */
	public function get isSupported():Boolean
	{
		return _isSupported;
	}

		
		
		/**
		 * 获取扩展上下文对象
		 * @return ExtensionContext扩展上下文
		 */
		public function get context():ExtensionContext{
			
			if(_isSupported)return _extCtx;
			return null;
		}
		
		/**
	 * 获取调试模式状态
	 * @return 如果开启调试模式返回true，否则返回false
	 */
	public function get debug():Boolean 
	{
		return _debug;
	}
		
		/**
	 * 设置调试模式状态
	 * @param value 调试模式开关
	 */
	public function set debug(value:Boolean):void 
	{
		_debug = value;
		
		if (_isSupported){
			_extCtx.call("debug",_debug);
		}
	}
		
		/**
		 * 处理扩展状态事件
		 * @param e 状态事件对象
		 */
		private function onStatus(e:StatusEvent):void 
		{
			if(_debug)trace(e.code, e.level);
			
			var arr:Array;
			switch (e.code) 
			{
				case "WindowSizeCallback":
				case "CursorPosCallback":
					arr = e.level.split("||");
					if (actionScriptData.callback[e.code+"_"+arr[0]]){
						actionScriptData.callback[e.code+"_"+arr[0]](Number(arr[0]), int(arr[1]), int(arr[2]));
					}
				break;
				case "MouseButtonCallback":
					arr = e.level.split("||");
					if (actionScriptData.callback[e.code+"_"+arr[0]]){
						actionScriptData.callback[e.code+"_"+arr[0]](Number(arr[0]), int(arr[1]), int(arr[2]), int(arr[3]));
					}
					break;
				case "ErrorCallback":
					arr = e.level.split("||");
					if (actionScriptData.callback[e.code]){
						actionScriptData.callback[e.code](int(arr[0]), arr[1]);
					}
					
					break;
			}
		}
		
		
		
		/**
		 * 获取窗口句柄
		 * @param nativeWindow 原生窗口对象
		 * @return 窗口句柄值，如果不支持返回0
		 */
		public function getHwnd(nativeWindow:NativeWindow):int{
			if (_isSupported){
				return int(_extCtx.call("AIRWindowHwnd", nativeWindow));
			}
			return 0;
		}
		
		
		/**
		 * 设置窗口父级
		 * @param hwnd 子窗口句柄
		 * @param phwnd 父窗口句柄
		 */
		public function SetParent(hwnd:int, phwnd:int):void{
			if (_isSupported){
				_extCtx.call("SetParent", hwnd, phwnd);
			}
		}
		
		/**
		 * 将OpenGL渲染绑定到原生窗口
		 * @param hwnd 窗口句柄
		 * @param nativeWindow 原生窗口对象
		 */
		public function openGLToNativeWindow(hwnd:int, nativeWindow:NativeWindow):void{
			if (_isSupported){
				_extCtx.call("openGLToNativeWindow", hwnd, nativeWindow);
			}
		}
		
		
		
		/**
		 * 释放扩展资源
		 */
		public function dispose():void
		{
			if (_extCtx){
				_extCtx.removeEventListener(StatusEvent.STATUS, onStatus);
				_extCtx.dispose();
			}
		}
		
	}
	
}