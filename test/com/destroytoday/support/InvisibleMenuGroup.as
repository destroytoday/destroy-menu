package com.destroytoday.support
{
	import com.destroytoday.menu.MenuGroup;
	
	import flash.display.NativeMenuItem;
	
	public class InvisibleMenuGroup extends MenuGroup
	{
		public function InvisibleMenuGroup()
		{
			addItem(new NativeMenuItem("Item 0"));
			addItem(new NativeMenuItem("Item 1"));
			addItem(new NativeMenuItem("Item 2"));
			
			visible = false;
		}
	}
}