package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import ui.components.Button;
	import ui.containers.Container;
	import ui.layout.LinearLayout;
	import ui.layout.CenterLayout;
	
	/**
	 * Button布局测试类
	 * 用于验证Button组件使用CenterLayout布局管理器实现文本完全居中的修复效果
	 */
	public class ButtonLayoutTest extends Sprite
	{
		private var _container:Container;
		
		/**
		 * 构造函数
		 */
		public function ButtonLayoutTest()
		{
			super();
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		/**
		 * 初始化测试
		 */
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			// 创建主容器
			_container = new Container();
			_container.x = 50;
			_container.y = 50;
			_container.width = 400;
			_container.height = 300;
			
			// 设置垂直线性布局
			var layout:LinearLayout = new LinearLayout(LinearLayout.VERTICAL, LinearLayout.ALIGN_CENTER);
			layout.spacing = 20;
			_container.setLayoutManager(layout);
			
			addChild(_container);
			
			// 创建测试按钮
			createTestButtons();
		}
		
		/**
		 * 创建测试按钮
		 * 创建多个不同尺寸的Button来测试CenterLayout文本完全居中效果
		 */
		private function createTestButtons():void
		{
			// 测试按钮1 - 标准尺寸
			var button1:Button = new Button();
			button1.setText("标准按钮");
			button1.width = 120;
			button1.height = 40;
			_container.addChild(button1);
			
			// 测试按钮2 - 宽按钮
			var button2:Button = new Button();
			button2.setText("宽按钮测试");
			button2.width = 200;
			button2.height = 40;
			_container.addChild(button2);
			
			// 测试按钮3 - 高按钮
			var button3:Button = new Button();
			button3.setText("高按钮");
			button3.width = 100;
			button3.height = 60;
			_container.addChild(button3);
			
			// 测试按钮4 - 小按钮
			var button4:Button = new Button();
			button4.setText("小");
			button4.width = 60;
			button4.height = 30;
			_container.addChild(button4);
			
			// 测试按钮5 - 长文本按钮
			var button5:Button = new Button();
			button5.setText("这是一个很长的按钮文本");
			button5.width = 250;
			button5.height = 45;
			_container.addChild(button5);
			
			trace("ButtonLayoutTest: 已创建5个测试按钮，验证文本居中效果");
			trace("预期结果: 所有按钮的文本都应该在按钮中心位置显示");
		}
	}
}