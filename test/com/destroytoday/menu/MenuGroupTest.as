package com.destroytoday.menu
{
	import flash.display.NativeMenuItem;
	import flash.events.Event;
	
	import mockolate.nice;
	import mockolate.prepare;
	import mockolate.received;
	
	import org.flexunit.async.Async;
	import org.hamcrest.assertThat;
	import org.hamcrest.collection.arrayWithSize;
	import org.hamcrest.collection.hasItem;
	import org.hamcrest.core.isA;
	import org.hamcrest.core.not;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.notNullValue;
	import org.osflash.signals.Signal;

	public class MenuGroupTest
	{		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var group:MenuGroup;
		
		//--------------------------------------------------------------------------
		//
		//  Prep
		//
		//--------------------------------------------------------------------------
		
		[Before(async, timeout=5000)]
		public function setUp():void
		{
			group = new MenuGroup();
			
			Async.proceedOnEvent(this, prepare(Signal), Event.COMPLETE);
		}
		
		[After]
		public function tearDown():void
		{
			group = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Tests
		//
		//--------------------------------------------------------------------------
		
		[Test]
		public function group_implements_interface():void
		{
			assertThat(group, isA(IMenuGroup));
		}
		
		[Test]
		public function group_creates_item_list_if_it_doesnt_exist():void
		{
			assertThat(group.itemList, arrayWithSize(0));
		}
		
		[Test]
		public function group_creates_item_list_changed_signal_if_it_doesnt_exist():void
		{
			assertThat(group.itemListChanged, notNullValue());
		}
		
		[Test]
		public function setting_item_list_dispatches_item_list_changed_signal():void
		{
			group.itemListChanged = nice(Signal);
			
			group.itemList = [];
			
			assertThat(group.itemListChanged, received().method('dispatch').once());
		}
		
		[Test]
		public function group_can_add_item():void
		{
			var item:NativeMenuItem = new NativeMenuItem();
			
			group.addItem(item);
			
			assertThat(group.itemList, hasItem(item));
		}
		
		[Test]
		public function adding_item_returns_item():void
		{
			var item:NativeMenuItem = new NativeMenuItem();
			
			assertThat(group.addItem(item), item);
		}
		
		[Test]
		public function adding_item_dispatches_item_list_changed_signal():void
		{
			group.itemListChanged = nice(Signal);
			
			group.addItem(new NativeMenuItem());
			
			assertThat(group.itemListChanged, received().method('dispatch').once());
		}
		
		[Test]
		public function adding_item_that_already_exists_does_not_dispatch_item_list_changed_signal():void
		{
			var item:NativeMenuItem = group.addItem(new NativeMenuItem());
			group.itemListChanged = nice(Signal);
			
			group.addItem(item);
			
			assertThat(group.itemListChanged, received().method('dispatch').never());
		}
		
		[Test]
		public function group_can_remove_item():void
		{
			var item:NativeMenuItem = group.addItem(new NativeMenuItem());
			
			group.removeItem(item);
			
			assertThat(group.itemList, not(hasItem(item)));
		}
		
		[Test]
		public function removing_item_returns_item():void
		{
			var item:NativeMenuItem = group.addItem(new NativeMenuItem());
			
			assertThat(group.removeItem(item), equalTo(item));
		}
		
		[Test]
		public function removing_item_dispatches_item_list_changed_signal():void
		{
			var item:NativeMenuItem = group.addItem(new NativeMenuItem());
			group.itemListChanged = nice(Signal);
			
			group.removeItem(item);
			
			assertThat(group.itemListChanged, received().method('dispatch').once());
		}
		
		[Test]
		public function removing_item_that_does_not_exist_does_not_dispatch_item_list_changed_signal():void
		{
			group.itemListChanged = nice(Signal);
			
			group.removeItem(new NativeMenuItem());
			
			assertThat(group.itemListChanged, received().method('dispatch').never());
		}
		
		[Test]
		public function group_returns_number_of_items():void
		{
			group.addItem(new NativeMenuItem());
			group.addItem(new NativeMenuItem());
			group.addItem(new NativeMenuItem());
			
			assertThat(group.numItems, equalTo(3));
		}
	}
}