package com.destroytoday.menu
{
	import flash.display.NativeMenuItem;
	
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.nullValue;

	public class MenuTest
	{		
		//--------------------------------------------------------------------------
		//
		//  Prep
		//
		//--------------------------------------------------------------------------
		
		protected var menu:Menu;
		
		//--------------------------------------------------------------------------
		//
		//  Prep
		//
		//--------------------------------------------------------------------------
		
		[Before]
		public function setUp():void
		{
			menu = new Menu();
		}
		
		[After]
		public function tearDown():void
		{
			menu = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Tests
		//
		//--------------------------------------------------------------------------
		
		[Test]
		public function menu_can_add_separator():void
		{
			menu.addSeparator();
			
			assertThat(menu.getItemAt(0) is MenuSeparator);
		}
		
		[Test]
		public function adding_separator_returns_separator():void
		{
			var separator:NativeMenuItem = menu.addSeparator();
			
			assertThat(menu.getItemAt(0), equalTo(separator));
		}
		
		[Test]
		public function swapping_items_replaces_current_item_with_new_item():void
		{
			var currentItem:NativeMenuItem = menu.addItem(new NativeMenuItem("Current"));
			var newItem:NativeMenuItem = new NativeMenuItem("New");
			
			menu.swapItems(currentItem, newItem);
			
			assertThat(menu.getItemAt(0), equalTo(newItem));
		}
		
		[Test]
		public function swapping_items_removes_old_item_reference_to_menu():void
		{
			var oldItem:NativeMenuItem = menu.addItem(new NativeMenuItem("Current"));
			var newItem:NativeMenuItem = new NativeMenuItem("New");
			
			menu.swapItems(oldItem, newItem);
			
			assertThat(oldItem.menu, nullValue());
		}
		
		[Test]
		public function swapping_items_returns_new_item():void
		{
			var currentItem:NativeMenuItem = menu.addItem(new NativeMenuItem("Current"));
			var newItem:NativeMenuItem = new NativeMenuItem("New");
			
			assertThat(menu.swapItems(currentItem, newItem), equalTo(newItem));
		}
		
		[Test]
		public function swapping_items_replaces_item_at_its_index():void
		{
			menu.addItem(new NativeMenuItem("Existing Item"));
			
			var currentItem:NativeMenuItem = menu.addItem(new NativeMenuItem("Current"));
			var newItem:NativeMenuItem = new NativeMenuItem("New");
			
			menu.swapItems(currentItem, newItem);
			
			assertThat(menu.getItemAt(1), equalTo(newItem));
		}
	}
}