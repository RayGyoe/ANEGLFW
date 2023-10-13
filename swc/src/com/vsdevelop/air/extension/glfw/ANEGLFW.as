package com.vsdevelop.air.extension.glfw
{
	
	import flash.display.NativeWindow;
	import flash.display.Stage;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	/**
	 * ...
	 * @author Ray.lei
	 */
	public class ANEGLFW {
		
		private static var _instance:ANEGLFW;
		private var _extCtx:ExtensionContext;
		private var _isSupported:Boolean;
		
		
		private var _debug:Boolean = false;
		
		
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
		
		public static function getInstance() : ANEGLFW
		{
			return _instance ? _instance : new ANEGLFW();
		}
		
		public function get isSupported():Boolean
		{
			return _isSupported;
		}

		
		
		public function get context():ExtensionContext{
			
			if(_isSupported)return _extCtx;
			return null;
		}
		
		public function get debug():Boolean 
		{
			return _debug;
		}
		
		public function set debug(value:Boolean):void 
		{
			_debug = value;
			
			if (_isSupported){
				_extCtx.call("debug",_debug);
			}
		}
		
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
		
		
		
		public function getHwnd(nativeWindow:NativeWindow):int{
			if (_isSupported){
				return int(_extCtx.call("AIRWindowHwnd", nativeWindow));
			}
			return 0;
		}
		
		
		public function SetParent(hwnd:int, phwnd:int):void{
			if (_isSupported){
				_extCtx.call("SetParent", hwnd, phwnd);
			}
		}
		
		public function openGLToNativeWindow(hwnd:int, nativeWindow:NativeWindow):void{
			if (_isSupported){
				_extCtx.call("openGLToNativeWindow", hwnd, nativeWindow);
			}
		}
		
		
		
		public function dispose():void
		{
			if (_extCtx){
				_extCtx.removeEventListener(StatusEvent.STATUS, onStatus);
				_extCtx.dispose();
			}
		}
		
	}
	
}