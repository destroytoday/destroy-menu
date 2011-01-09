package com.destroytoday.support
{
	import com.destroytoday.menu.MenuGroup;
	
	import flash.display.NativeMenuItem;
	
	public class TestInvisibleMenuGroup extends MenuGroup
	{
		public function TestInvisibleMenuGroup()
		{
			addItem(new NativeMenuItem("Item 0"));
			addItem(new NativeMenuItem("Item 1"));
			addItem(new NativeMenuItem("Item 2"));
			
			visible = false;
		}
	}
}