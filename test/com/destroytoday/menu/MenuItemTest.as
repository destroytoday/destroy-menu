package com.destroytoday.menu
{
	import flash.display.NativeMenuItem;
	import flash.ui.Keyboard;
	
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;

	public class MenuItemTest
	{		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var item:MenuItem;
		
		//--------------------------------------------------------------------------
		//
		//  Prep
		//
		//--------------------------------------------------------------------------
		
		[Before]
		public function setUp():void
		{
		}
		
		[After]
		public function tearDown():void
		{
			item = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Tests
		//
		//--------------------------------------------------------------------------
		
		[Test]
		public function item_is_native_menu_item():void
		{
			item = new MenuItem("Item");
			
			assertThat(item is NativeMenuItem);
		}
		
		[Test]
		public function item_sets_label_with_constructor_argument():void
		{
			item = new MenuItem("Item");
			
			assertThat(item.label, equalTo("Item"));
		}
		
		[Test]
		public function item_sets_key_modifiers_with_constructor_argument():void
		{
			var keyModifierList:Array = [Keyboard.COMMAND, Keyboard.SHIFT];

			item = new MenuItem("Item", keyModifierList);
			
			assertThat(item.keyEquivalentModifiers, equalTo(keyModifierList));
		}
		
		[Test]
		public function item_sets_key_equivalent_with_constructor_argument():void
		{
			item = new MenuItem("Item", null, "@");
			
			assertThat(item.keyEquivalent, equalTo("@"));
		}
	}
}