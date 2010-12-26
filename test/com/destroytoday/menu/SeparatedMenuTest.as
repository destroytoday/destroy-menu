package com.destroytoday.menu
{
	import com.destroytoday.support.InvisibleMenuGroup;
	import com.destroytoday.support.OneItemMenuGroup;
	
	import flash.display.NativeMenuItem;
	import flash.events.Event;
	
	import mockolate.nice;
	import mockolate.prepare;
	import mockolate.received;
	
	import org.flexunit.async.Async;
	import org.hamcrest.assertThat;
	import org.hamcrest.collection.hasItem;
	import org.hamcrest.collection.hasItems;
	import org.hamcrest.core.not;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.notNullValue;
	import org.osflash.signals.Signal;

	public class SeparatedMenuTest
	{		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var menu:SeparatedMenu;
		
		//--------------------------------------------------------------------------
		//
		//  Prep
		//
		//--------------------------------------------------------------------------
		
		[Before(async, timeout=5000)]
		public function setUp():void
		{
			menu = new SeparatedMenu();
			
			Async.proceedOnEvent(this, prepare(Signal), Event.COMPLETE);
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
		public function menu_instantiates_item_group_list_if_not_exists():void
		{
			assertThat(menu.groupList, notNullValue());
		}
		
		[Test]
		public function menu_can_add_group():void
		{
			var group:IMenuGroup = new MenuGroup();
			
			menu.addGroup(group);
			
			assertThat(menu.groupList, hasItem(group));
		}
		
		[Test]
		public function adding_group_returns_group():void
		{
			var group:IMenuGroup = new MenuGroup();
			
			assertThat(menu.addGroup(group), equalTo(group));
		}
		
		[Test]
		public function adding_group_dispatches_group_list_changed():void
		{
			menu.groupListChanged = nice(Signal);
			
			menu.addGroup(new MenuGroup());
			
			assertThat(menu.groupListChanged, received().method('dispatch').once());
		}
		
		[Test]
		public function adding_duplicate_group_silently_fails():void
		{
			var group:IMenuGroup = new MenuGroup();
			menu.addGroup(group);
			
			menu.groupListChanged = nice(Signal);
			
			menu.addGroup(group);
			
			assertThat(menu.groupListChanged, received().method('dispatch').never());
		}
		
		[Test]
		public function menu_can_remove_group():void
		{
			var group:IMenuGroup = new MenuGroup();
			
			menu.addGroup(group);
			menu.removeGroup(group);
			
			assertThat(menu.groupList, not(hasItem(group)));
		}
		
		[Test]
		public function removing_group_returns_group():void
		{
			var group:IMenuGroup = new MenuGroup();

			assertThat(menu.removeGroup(group), equalTo(group));
		}
		
		[Test]
		public function removing_non_existant_group_silently_fails():void
		{
			menu.groupListChanged = nice(Signal);
			
			menu.removeGroup(new MenuGroup());
			
			assertThat(menu.groupListChanged, received().method('dispatch').never());
		}
		
		[Test]
		public function menu_adds_separator_between_groups():void
		{
			menu.addGroup(new OneItemMenuGroup());
			menu.addGroup(new OneItemMenuGroup());
			
			assertThat(menu.getItemAt(1).isSeparator);
		}
		
		[Test]
		public function menu_adds_item_when_adding_group_with_item():void
		{
			var group:OneItemMenuGroup = menu.addGroup(new OneItemMenuGroup()) as OneItemMenuGroup;
			
			assertThat(menu.items, hasItem(group.item));
		}
		
		[Test]
		public function menu_adds_item_when_group_adds_item():void
		{
			var group:IMenuGroup = menu.addGroup(new MenuGroup());
			var item:NativeMenuItem = group.addItem(new NativeMenuItem());
			
			assertThat(menu.items, hasItem(item));
		}
		
		[Test]
		public function menu_removes_item_when_group_removes_item():void
		{
			var group:OneItemMenuGroup = menu.addGroup(new OneItemMenuGroup()) as OneItemMenuGroup;
			var item:NativeMenuItem = group.removeItem(group.item);
			
			assertThat(menu.items, not(hasItem(item)));
		}
		
		[Test]
		public function menu_adds_items_when_group_replaces_item_list():void
		{
			var group:IMenuGroup = menu.addGroup(new MenuGroup());
			var item0:NativeMenuItem = new NativeMenuItem();
			var item1:NativeMenuItem = new NativeMenuItem();
			var item2:NativeMenuItem = new NativeMenuItem();
			
			group.itemList = [item0, item1, item2];
			
			assertThat(menu.items, hasItems(item0, item1, item2));
		}
		
		[Test]
		public function menu_ignores_invisible_groups():void
		{
			menu.addGroup(new InvisibleMenuGroup());
			
			assertThat(menu.numItems, equalTo(0));
		}
		
		[Test]
		public function menu_removes_items_when_group_becomes_invisible():void
		{
			var group:IMenuGroup = menu.addGroup(new OneItemMenuGroup());
			
			group.visible = false;
			
			assertThat(menu.numItems, equalTo(0));
		}
		
		[Test]
		public function menu_adds_items_when_group_becomes_visible():void
		{
			var group:IMenuGroup = menu.addGroup(new InvisibleMenuGroup());
			
			group.visible = true;
			
			assertThat(menu.numItems, equalTo(group.numItems));
		}
	}
}