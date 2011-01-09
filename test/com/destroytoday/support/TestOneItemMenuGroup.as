package com.destroytoday.support
{
	import com.destroytoday.menu.MenuGroup;
	
	import flash.display.NativeMenuItem;
	
	public class TestOneItemMenuGroup extends MenuGroup
	{
		public var item:NativeMenuItem;
		
		public function TestOneItemMenuGroup()
		{
			item = addItem(new NativeMenuItem("Item"));
		}
	}
}