package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import ui.containers.Container;
	import ui.components.Button;
	import ui.components.Image;
	import ui.layout.BorderLayout;
	import ui.layout.LinearLayout;
	import ui.layout.GridLayout;
	import ui.core.UIComponent;
	
	/**
	 * 布局感知组件测试示例
	 * 演示Button和Image组件的布局约束增强功能
	 * 
	 * @author UI Framework Team
	 * @version 1.0
	 */
	public class LayoutTestExample extends Sprite
	{
		private var _mainContainer:Container;
		private var _borderContainer:Container;
		private var _linearContainer:Container;
		private var _gridContainer:Container;
		
		/**
		 * 构造函数
		 */
		public function LayoutTestExample()
		{
			super();
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		/**
		 * 初始化
		 * @param e 事件对象
		 */
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			// 创建主容器
			_mainContainer = new Container();
			_mainContainer.x = 50;
			_mainContainer.y = 50;
			_mainContainer.width = 700;
			_mainContainer.height = 500;
			addChild(_mainContainer);
			
			// 设置线性布局
			var mainLayout:LinearLayout = new LinearLayout();
			mainLayout.orientation = LinearLayout.VERTICAL;
			mainLayout.gap = 20;
			_mainContainer.setLayoutManager(mainLayout);
			
			// 测试各种布局
			testBorderLayout();
			testLinearLayout();
			testGridLayout();
			testAutoSizing();
		}
		
		/**
		 * 测试边界布局
		 */
		private function testBorderLayout():void
		{
			// 创建边界布局容器
			_borderContainer = new Container();
			_borderContainer.width = 300;
			_borderContainer.height = 200;
			_borderContainer.setLayoutManager(new BorderLayout());
			
			// 创建按钮并设置边界布局约束
			var topButton:Button = new Button();
			topButton.text = "顶部按钮";
			topButton.setLayoutConstraints({borderRegion: BorderLayout.NORTH});
			_borderContainer.addChildWithConstraints(topButton, {borderRegion: BorderLayout.NORTH});
			
			var leftButton:Button = new Button();
			leftButton.text = "左侧";
			leftButton.setLayoutConstraints({borderRegion: BorderLayout.WEST});
			_borderContainer.addChildWithConstraints(leftButton, {borderRegion: BorderLayout.WEST});
			
			var centerImage:Image = new Image();
			centerImage.source = "assets/test.png"; // 假设有测试图片
			centerImage.setLayoutConstraints({borderRegion: BorderLayout.CENTER});
			_borderContainer.addChildWithConstraints(centerImage, {borderRegion: BorderLayout.CENTER});
			
			var rightButton:Button = new Button();
			rightButton.text = "右侧";
			rightButton.setLayoutConstraints({borderRegion: BorderLayout.EAST});
			_borderContainer.addChildWithConstraints(rightButton, {borderRegion: BorderLayout.EAST});
			
			var bottomButton:Button = new Button();
			bottomButton.text = "底部按钮";
			bottomButton.setLayoutConstraints({borderRegion: BorderLayout.SOUTH});
			_borderContainer.addChildWithConstraints(bottomButton, {borderRegion: BorderLayout.SOUTH});
			
			_mainContainer.addChild(_borderContainer);
		}
		
		/**
		 * 测试线性布局
		 */
		private function testLinearLayout():void
		{
			// 创建水平线性布局容器
			_linearContainer = new Container();
			_linearContainer.width = 400;
			_linearContainer.height = 80;
			
			var linearLayout:LinearLayout = new LinearLayout();
			linearLayout.orientation = LinearLayout.HORIZONTAL;
			linearLayout.gap = 10;
			_linearContainer.setLayoutManager(linearLayout);
			
			// 创建不同权重的按钮
			var button1:Button = new Button();
			button1.text = "权重1";
			button1.setLayoutConstraints({layoutWeight: 1});
			_linearContainer.addChildWithConstraints(button1, {layoutWeight: 1});
			
			var button2:Button = new Button();
			button2.text = "权重2";
			button2.setLayoutConstraints({layoutWeight: 2});
			_linearContainer.addChildWithConstraints(button2, {layoutWeight: 2});
			
			var button3:Button = new Button();
			button3.text = "权重1";
			button3.setLayoutConstraints({layoutWeight: 1});
			_linearContainer.addChildWithConstraints(button3, {layoutWeight: 1});
			
			_mainContainer.addChild(_linearContainer);
		}
		
		/**
		 * 测试网格布局
		 */
		private function testGridLayout():void
		{
			// 创建网格布局容器
			_gridContainer = new Container();
			_gridContainer.width = 300;
			_gridContainer.height = 150;
			
			var gridLayout:GridLayout = new GridLayout();
			gridLayout.rows = 2;
			gridLayout.cols = 3;
			gridLayout.hgap = 5;
			gridLayout.vgap = 5;
			_gridContainer.setLayoutManager(gridLayout);
			
			// 创建网格中的按钮
			for (var row:int = 0; row < 2; row++)
			{
				for (var col:int = 0; col < 3; col++)
				{
					var gridButton:Button = new Button();
					gridButton.text = "(" + row + "," + col + ")";
					gridButton.setLayoutConstraints({
						row: row,
						col: col,
						rowSpan: 1,
						colSpan: 1
					});
					_gridContainer.addChildWithConstraints(gridButton, {
						row: row,
						col: col
					});
				}
			}
			
			_mainContainer.addChild(_gridContainer);
		}
		
		/**
		 * 测试自动尺寸功能
		 */
		private function testAutoSizing():void
		{
			// 创建自动尺寸容器
			var autoSizeContainer:Container = new Container();
			autoSizeContainer.width = 500;
			autoSizeContainer.height = 100;
			
			var autoLayout:LinearLayout = new LinearLayout();
			autoLayout.orientation = LinearLayout.HORIZONTAL;
			autoLayout.gap = 15;
			autoSizeContainer.setLayoutManager(autoLayout);
			
			// 创建自动尺寸按钮
			var autoButton1:Button = new Button();
			autoButton1.text = "短文本";
			autoButton1.autoSize = true;
			autoButton1.setPadding(10, 5, 10, 5);
			autoSizeContainer.addChild(autoButton1);
			
			var autoButton2:Button = new Button();
			autoButton2.text = "这是一个很长的按钮文本";
			autoButton2.autoSize = true;
			autoButton2.setPadding(15, 8, 15, 8);
			autoSizeContainer.addChild(autoButton2);
			
			// 创建自动尺寸图片（如果有图片资源）
			var autoImage:Image = new Image();
			autoImage.source = "assets/icon.png"; // 假设有图标
			autoImage.autoSize = true;
			autoImage.setPadding(5, 5, 5, 5);
			autoSizeContainer.addChild(autoImage);
			
			// 测试尺寸约束
			var constrainedButton:Button = new Button();
			constrainedButton.text = "约束按钮";
			constrainedButton.setLayoutConstraints({
				minWidth: 80,
				maxWidth: 150,
				minHeight: 30,
				maxHeight: 50,
				preferredWidth: 120,
				preferredHeight: 35
			});
			autoSizeContainer.addChild(constrainedButton);
			
			_mainContainer.addChild(autoSizeContainer);
		}
		
		/**
		 * 获取测试结果信息
		 * @return 测试结果描述
		 */
		public function getTestInfo():String
		{
			var info:String = "布局感知组件测试:\n";
			info += "1. 边界布局测试 - 按钮分布在容器的五个区域\n";
			info += "2. 线性布局测试 - 按钮按权重水平排列\n";
			info += "3. 网格布局测试 - 按钮排列在2x3网格中\n";
			info += "4. 自动尺寸测试 - 组件根据内容自动调整尺寸\n";
			info += "\n请检查各个容器中的组件是否正确布局和显示。";
			return info;
		}
	}
}