package com.destroytoday.menu
{
	import com.destroytoday.invalidation.InvalidationManager;
	import com.destroytoday.support.TestInvisibleMenuGroup;
	import com.destroytoday.support.TestOneItemMenuGroup;
	import com.destroytoday.support.TestValidateCountingSeparatedMenu;
	
	import flash.display.NativeMenuItem;
	import flash.events.Event;
	
	import mockolate.nice;
	import mockolate.prepare;
	import mockolate.received;
	
	import org.flexunit.async.Async;
	import org.hamcrest.assertThat;
	import org.hamcrest.collection.hasItem;
	import org.hamcrest.core.not;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.notNullValue;
	import org.hamcrest.object.strictlyEqualTo;
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
			menu = new SeparatedMenu();
			
			assertThat(menu.groupList, notNullValue());
		}
		
		[Test]
		public function menu_can_add_group():void
		{
			menu = new SeparatedMenu();
			var group:IMenuGroup = new MenuGroup();
			
			menu.addGroup(group);
			
			assertThat(menu.groupList, hasItem(group));
		}
		
		[Test]
		public function adding_group_returns_group():void
		{
			menu = new SeparatedMenu();
			var group:IMenuGroup = new MenuGroup();
			
			assertThat(menu.addGroup(group), equalTo(group));
		}
		
		[Test]
		public function adding_group_dispatches_group_list_changed():void
		{
			menu = new SeparatedMenu();
			menu.groupListChanged = nice(Signal);
			
			menu.addGroup(new MenuGroup());
			
			assertThat(menu.groupListChanged, received().method('dispatch').once());
		}
		
		[Test]
		public function adding_duplicate_group_silently_fails():void
		{
			menu = new SeparatedMenu();
			var group:IMenuGroup = new MenuGroup();
			menu.addGroup(group);
			
			menu.groupListChanged = nice(Signal);
			
			menu.addGroup(group);
			
			assertThat(menu.groupListChanged, received().method('dispatch').never());
		}
		
		[Test]
		public function menu_can_remove_group():void
		{
			menu = new SeparatedMenu();
			var group:IMenuGroup = new MenuGroup();
			
			menu.addGroup(group);
			menu.removeGroup(group);
			
			assertThat(menu.groupList, not(hasItem(group)));
		}
		
		[Test]
		public function removing_group_returns_group():void
		{
			menu = new SeparatedMenu();
			var group:IMenuGroup = new MenuGroup();

			assertThat(menu.removeGroup(group), equalTo(group));
		}
		
		[Test]
		public function removing_non_existant_group_silently_fails():void
		{
			menu = new SeparatedMenu();
			menu.groupListChanged = nice(Signal);
			
			menu.removeGroup(new MenuGroup());
			
			assertThat(menu.groupListChanged, received().method('dispatch').never());
		}
		
		[Test]
		public function menu_adds_separator_between_groups():void
		{
			menu = new SeparatedMenu();
			
			menu.addGroup(new TestOneItemMenuGroup());
			menu.addGroup(new TestOneItemMenuGroup());
			
			assertThat(menu.getItemAt(1).isSeparator);
		}
		
		[Test]
		public function menu_adds_item_when_adding_group_with_item():void
		{
			menu = new SeparatedMenu();
			var group:TestOneItemMenuGroup = menu.addGroup(new TestOneItemMenuGroup()) as TestOneItemMenuGroup;
			
			assertThat(menu.items, hasItem(group.item));
		}
		
		[Test]
		public function menu_adds_item_when_group_adds_item():void
		{
			menu = new SeparatedMenu();
			var group:IMenuGroup = menu.addGroup(new MenuGroup());
			var item:NativeMenuItem = group.addItem(new NativeMenuItem());
			
			assertThat(menu.items, hasItem(item));
		}
		
		[Test]
		public function menu_removes_item_when_group_removes_item():void
		{
			menu = new SeparatedMenu();
			var group:TestOneItemMenuGroup = menu.addGroup(new TestOneItemMenuGroup()) as TestOneItemMenuGroup;
			var item:NativeMenuItem = group.removeItem(group.item);
			
			assertThat(menu.items, not(hasItem(item)));
		}
		
		[Test]
		public function menu_adds_items_when_group_replaces_item_list():void
		{
			menu = new SeparatedMenu();
			var group:IMenuGroup = menu.addGroup(new MenuGroup());
			var item0:NativeMenuItem = new NativeMenuItem();
			var item1:NativeMenuItem = new NativeMenuItem();
			var item2:NativeMenuItem = new NativeMenuItem();
			
			group.itemList = [item0, item1, item2];
			
			assertThat(menu.items, hasItem(item0));
			assertThat(menu.items, hasItem(item1));
			assertThat(menu.items, hasItem(item2));
		}
		
		[Test]
		public function menu_ignores_invisible_groups():void
		{
			menu = new SeparatedMenu();
			
			menu.addGroup(new TestInvisibleMenuGroup());
			
			assertThat(menu.numItems, equalTo(0));
		}
		
		[Test]
		public function menu_removes_items_when_group_becomes_invisible():void
		{
			menu = new SeparatedMenu();
			var group:IMenuGroup = menu.addGroup(new TestOneItemMenuGroup());
			
			group.visible = false;
			
			assertThat(menu.numItems, equalTo(0));
		}
		
		[Test]
		public function menu_adds_items_when_group_becomes_visible():void
		{
			menu = new SeparatedMenu();
			var group:IMenuGroup = menu.addGroup(new TestInvisibleMenuGroup());
			
			group.visible = true;
			
			assertThat(menu.numItems, equalTo(group.numItems));
		}
		
		[Test]
		public function invalidation_manager_constructor_argument_populates_invalidation_manager():void
		{
			var invalidationManager:InvalidationManager = new InvalidationManager();
			menu = new SeparatedMenu(invalidationManager);
			
			assertThat(menu.invalidationManager, strictlyEqualTo(invalidationManager));
		}
		
		[Test]
		public function menu_without_invalidation_manager_does_not_use_invalidation():void
		{
			menu = new TestValidateCountingSeparatedMenu();
			var mockMenu:TestValidateCountingSeparatedMenu = menu as TestValidateCountingSeparatedMenu;
			var group:IMenuGroup = new MenuGroup();
			
			menu.groupList = [new MenuGroup()];
			menu.addGroup(group);
			menu.removeGroup(group);

			assertThat(mockMenu.validateCount, equalTo(3));
		}
		
		[Test(async, timeout=1000)]
		public function menu_with_invalidation_manager_uses_invalidation():void
		{
			menu = new TestValidateCountingSeparatedMenu(new InvalidationManager());
			var mockMenu:TestValidateCountingSeparatedMenu = menu as TestValidateCountingSeparatedMenu;
			var group:IMenuGroup = new MenuGroup();
			
			menu.groupList = [new MenuGroup()];
			menu.addGroup(group);
			menu.removeGroup(group);

			Async.delayCall(this, function():void
			{
				assertThat(mockMenu.validateCount, equalTo(1));
			}, 500);
		}
	}
}