package com.destroytoday.menu
{
	import flash.display.NativeMenuItem;
	
	import org.hamcrest.assertThat;

	public class MenuSeparatorTest
	{		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var separator:MenuSeparator;
		
		//--------------------------------------------------------------------------
		//
		//  Prep
		//
		//--------------------------------------------------------------------------
		
		[Before]
		public function setUp():void
		{
			separator = new MenuSeparator();
		}
		
		[After]
		public function tearDown():void
		{
			separator = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Tests
		//
		//--------------------------------------------------------------------------
		
		[Test]
		public function separator_is_native_menu_item():void
		{
			assertThat(separator is NativeMenuItem);
		}
		
		[Test]
		public function separator_is_separator():void
		{
			assertThat(separator.isSeparator);
		}
	}
}