package com.destroytoday.support
{
	import com.destroytoday.menu.MenuGroup;
	
	import flash.display.NativeMenuItem;
	
	public class OneItemMenuGroup extends MenuGroup
	{
		public var item:NativeMenuItem;
		
		public function OneItemMenuGroup()
		{
			item = addItem(new NativeMenuItem("Item"));
		}
	}
}