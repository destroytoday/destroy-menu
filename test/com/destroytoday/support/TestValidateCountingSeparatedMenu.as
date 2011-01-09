package com.destroytoday.support
{
	import com.destroytoday.invalidation.IInvalidationManager;
	import com.destroytoday.menu.SeparatedMenu;
	
	public class TestValidateCountingSeparatedMenu extends SeparatedMenu
	{
		public var validateCount:int;
		
		public function TestValidateCountingSeparatedMenu(invalidationManager:IInvalidationManager = null)
		{
			super(invalidationManager);
		}
		
		override public function validate():void
		{
			validateCount++;
		}
	}
}