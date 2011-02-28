/*
Copyright (c) 2011 Jonnie Hallman

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

package com.destroytoday.menu
{
	import com.destroytoday.invalidation.IInvalidatable;
	import com.destroytoday.invalidation.IInvalidationManager;
	
	import org.osflash.signals.Signal;

	public class SeparatedMenu extends Menu implements IInvalidatable
	{
		//--------------------------------------------------------------------------
		//
		//  Signals
		//
		//--------------------------------------------------------------------------
		
		protected var _groupListChanged:Signal;
		
		public function get groupListChanged():Signal
		{
			return _groupListChanged ||= new Signal();
		}
		
		public function set groupListChanged(value:Signal):void
		{
			_groupListChanged = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var _groupList:Array;
		
		protected var _invalidationManager:IInvalidationManager;
		
		//--------------------------------------------------------------------------
		//
		//  Flags
		//
		//--------------------------------------------------------------------------
		
		protected var isGroupListDirty:Boolean;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function SeparatedMenu(invalidationManager:IInvalidationManager = null)
		{
			this.invalidationManager = invalidationManager;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		public function get groupList():Array
		{
			return _groupList ||= new Array();
		}
		
		public function set groupList(value:Array):void
		{
			if (value == _groupList) return;
			
			_groupList = value;
			
			isGroupListDirty = true;
			invalidate();
		}
		
		public function get invalidationManager():IInvalidationManager
		{
			return _invalidationManager;
		}
		
		public function set invalidationManager(value:IInvalidationManager):void
		{
			_invalidationManager = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		public function addGroup(group:IMenuGroup):IMenuGroup
		{
			if (groupList.indexOf(group) == -1)
			{
				groupList[groupList.length] = group;
				
				group.itemListChanged.add(groupItemListChangedHandler);
				group.visibleChanged.add(groupVisibleChangedHandler);

				isGroupListDirty = true;
				invalidate();
			}
			
			return group;
		}
		
		public function removeGroup(group:IMenuGroup):IMenuGroup
		{
			var index:int = groupList.indexOf(group);
			
			if (index != -1)
			{
				groupList.splice(index, 1);
				
				group.itemListChanged.remove(groupItemListChangedHandler);
				group.visibleChanged.remove(groupVisibleChangedHandler);
				
				isGroupListDirty = true;
				invalidate();
			}
			
			return group;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Invalidation
		//
		//--------------------------------------------------------------------------
		
		public function invalidate():void
		{
			if (invalidationManager)
			{
				invalidationManager.invalidateObject(this);
			}
			else
			{
				validate();
			}
		}
		
		public function validate():void
		{
			if (isGroupListDirty)
			{
				isGroupListDirty = false;
				
				var itemList:Array = [];
			
				for each (var group:IMenuGroup in groupList)
				{
					var visible:Boolean = (group.visible && group.numItems > 0);
					
					if (visible && itemList.length > 0)
					{
						itemList = itemList.concat(new MenuSeparator(), group.itemList);
					}
					else if (visible)
					{
						itemList = itemList.concat(group.itemList);
					}
				}
	
				items = itemList;
				
				groupListChanged.dispatch();
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Handlers
		//
		//--------------------------------------------------------------------------
		
		protected function groupItemListChangedHandler():void
		{
			isGroupListDirty = true;
			invalidate();
		}
		
		protected function groupVisibleChangedHandler():void
		{
			isGroupListDirty = true;
			invalidate();
		}
	}
}