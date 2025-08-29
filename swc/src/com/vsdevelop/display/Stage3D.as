package com.vsdevelop.display
{
	import com.vsdevelop.display3D.Context3D;
	
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
		
		public function Stage3D()
		{
		}
		
		public function get context3D():Context3D
		{
			return _context3D;
		}
		
		public function requestContext3D():void
		{
			if (!_context3D)
			{
				_context3D = new Context3D();
				// Simulate async creation and dispatch event
				var timer:Timer = new Timer(1, 1);
				timer.addEventListener(TimerEvent.TIMER_COMPLETE, function(e:TimerEvent):void {
					dispatchEvent(new Event(Event.CONTEXT3D_CREATE));
				});
				timer.start();
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