package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import ui.components.Image;
	import ui.core.UIManager;
	import ui.events.UIEvent;
	import com.vsdevelop.air.extension.glfw.Gl;
	import com.vsdevelop.air.extension.glfw.Glfw;
	import com.vsdevelop.display3D.Context3D;
import com.vsdevelop.display.Stage3D;

	/**
	 * Image组件测试类
	 * 测试不同的缩放模式和图片更新功能
	 */
	public class ImageTest extends Sprite
	{
		private var _stage3D:Stage3D;
	private var _context3D:Context3D;
		private var _uiManager:UIManager;
		private var _testImage:Image;
		private var _currentScaleMode:int = 0;
		private var _scaleModes:Array = [
			Image.SCALE_MODE_STRETCH,
			Image.SCALE_MODE_FIT,
			Image.SCALE_MODE_FILL,
			Image.SCALE_MODE_NONE
		];
		private var _scaleModeNames:Array = [
			"STRETCH",
			"FIT",
			"FILL",
			"NONE"
		];

		public function ImageTest()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			initialize();
		}

		private function initialize():void
		{
			// 初始化Stage3D
			_stage3D = new Stage3D(stage);
			_stage3D.addEventListener(Event.CONTEXT3D_CREATE, onContextCreated);
			_stage3D.requestContext3D();


		}

		private function onContextCreated(event:Event):void
		{
			_context3D = _stage3D.context3D;
			_context3D.configureBackBuffer(stage.stageWidth, stage.stageHeight, 0, false);

			// 初始化UI管理器
			_uiManager = UIManager.getInstance();
			_uiManager.setViewport(stage.stageWidth, stage.stageHeight);

			// 创建测试图片
			createTestImage();

			// 添加键盘事件监听
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);

			// 开始渲染循环
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);

			trace("Image Scale Mode Test Started");
			trace("Press SPACE to cycle through scale modes");
			trace("Press R to refresh image");
			trace("Press S to change image size");
			trace("Press P to change image position");
			trace("Current scale mode: " + _scaleModeNames[_currentScaleMode]);
		}

		private function createTestImage():void
		{
			// 创建图片组件（居中显示，300x200大小）
			_testImage = new Image(250, 200, 300, 200, "assets/test.png");
			_testImage.scaleMode = _scaleModes[_currentScaleMode];
			
			// 监听图片加载事件
			_testImage.addEventListener(UIEvent.COMPLETE, onImageLoaded);
			_testImage.addEventListener(UIEvent.ERROR, onImageError);

			// 添加到UI管理器
			_uiManager.addComponent(_testImage);
		}

		private function onImageLoaded(event:UIEvent):void
		{
			trace("Image loaded successfully. Size: " + _testImage.textureWidth + "x" + _testImage.textureHeight);
		}

		private function onImageError(event:UIEvent):void
		{
			trace("Image load error: " + event.data);
		}

		private function onKeyDown(event:KeyboardEvent):void
		{
			switch (event.keyCode)
			{
				case Keyboard.SPACE:
					// 切换缩放模式
					_currentScaleMode = (_currentScaleMode + 1) % _scaleModes.length;
					_testImage.scaleMode = _scaleModes[_currentScaleMode];
					trace("Scale mode changed to: " + _scaleModeNames[_currentScaleMode]);
					break;

				case Keyboard.R:
					// 刷新图片
					_testImage.refresh();
					trace("Image refreshed");
					break;

				case Keyboard.S:
					// 改变图片大小
					var newWidth:Number = 200 + Math.random() * 400;
					var newHeight:Number = 150 + Math.random() * 300;
					_testImage.width = newWidth;
					_testImage.height = newHeight;
					trace("Image size changed to: " + newWidth + "x" + newHeight);
					break;

				case Keyboard.P:
					// 改变图片位置
					var newX:Number = Math.random() * 500;
					var newY:Number = Math.random() * 400;
					_testImage.x = newX;
					_testImage.y = newY;
					trace("Image position changed to: (" + newX + ", " + newY + ")");
					break;
			}
		}

		private function onEnterFrame(event:Event):void
		{
			// 清除屏幕
			_context3D.clear(0.2, 0.3, 0.4, 1.0);

			// 渲染UI
			_uiManager.render();

			// 呈现到屏幕
			_context3D.present();
		}
	}
}