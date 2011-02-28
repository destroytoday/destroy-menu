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
	import flash.display.NativeMenuItem;
	
	import org.osflash.signals.Signal;

	public class MenuGroup implements IMenuGroup
	{
		//--------------------------------------------------------------------------
		//
		//  Signals
		//
		//--------------------------------------------------------------------------
		
		protected var _itemListChanged:Signal;
		
		protected var _visibleChanged:Signal;
		
		public function get itemListChanged():Signal
		{
			return _itemListChanged ||= new Signal();
		}
		
		public function set itemListChanged(value:Signal):void
		{
			_itemListChanged = value;
		}
		
		public function get visibleChanged():Signal
		{
			return _visibleChanged ||= new Signal();
		}
		
		public function set visibleChanged(value:Signal):void
		{
			_visibleChanged = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var _itemList:Array;
		
		protected var _visible:Boolean = true;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function MenuGroup()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		public function get itemList():Array
		{
			return _itemList ||= new Array();
		}
		
		public function set itemList(value:Array):void
		{
			if (value == _itemList) return;
			
			_itemList = value;
			
			itemListChanged.dispatch();
		}
		
		public function get numItems():int
		{
			return itemList.length;
		}
		
		public function get visible():Boolean
		{
			return _visible;
		}
		
		public function set visible(value:Boolean):void
		{
			if (value == _visible) return;
			
			_visible = value;
			
			visibleChanged.dispatch();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		public function addItem(item:NativeMenuItem):NativeMenuItem
		{
			if (itemList.indexOf(item) == -1)
			{
				itemList[itemList.length] = item;
				
				itemListChanged.dispatch();
			}
			
			return item;
		}
		
		public function removeItem(item:NativeMenuItem):NativeMenuItem
		{
			var index:int = itemList.indexOf(item);
			
			if (index != -1)
			{
				itemList.splice(index, 1);
				
				itemListChanged.dispatch();
			}
			
			return item;
		}
	}
}