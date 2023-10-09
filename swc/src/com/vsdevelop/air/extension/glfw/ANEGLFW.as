package com.vsdevelop.air.extension.glfw
{
	
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
		
		private var _actionScriptData:Object = {};
		
		
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
						_extCtx.actionScriptData = actionScriptData;
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
			return _actionScriptData;
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