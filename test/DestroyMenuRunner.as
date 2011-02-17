package
{
	import com.destroytoday.DestroyMenuSuite;
	
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.UncaughtErrorEvent;
	
	import org.flexunit.internals.TraceListener;
	import org.flexunit.listeners.CIListener;
	import org.flexunit.runner.FlexUnitCore;
	import org.flexunit.runner.notification.async.XMLListener;
	
	public class DestroyMenuRunner extends Sprite
	{
		public var core:FlexUnitCore;
		
		public function DestroyMenuRunner()
		{
			core = new FlexUnitCore();
			
            core.addListener(new TraceListener());
            core.addListener(new CIListener());
            core.addListener(new XMLListener());
			
            core.run(DestroyMenuSuite);
			
			core.addEventListener(FlexUnitCore.TESTS_COMPLETE, completeHandler);
		}
		
		protected function completeHandler(event:Event):void
		{
			NativeApplication.nativeApplication.exit();
		}
	}
}