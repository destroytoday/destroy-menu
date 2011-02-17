package com.destroytoday
{
	import com.destroytoday.menu.MenuGroupTest;
	import com.destroytoday.menu.MenuItemTest;
	import com.destroytoday.menu.MenuSeparatorTest;
	import com.destroytoday.menu.MenuTest;
	import com.destroytoday.menu.SeparatedMenuTest;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class DestroyMenuSuite
	{
		public var menuGroupTest:MenuGroupTest;
		
		public var menuItemTest:MenuItemTest;
		
		public var menuSeparatorTest:MenuSeparatorTest;
		
		public var menuTest:MenuTest;
		
		public var separatedMenuTest:SeparatedMenuTest;
	}
}