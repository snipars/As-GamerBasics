package com.asgamer.basics1
{
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	
	public class SmallImplosion extends MovieClip
	{
		
		private var stageRef:Stage;
		
		public function SmallImplosion(stageRef:Stage, x:Number, y:Number)
		{
			this.stageRef = stageRef;
			this.x = x;
			this.y = y;
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
		}
		
		private function loop(e:Event)
		{
			if (currentFrame == totalFrames)
				removeSelf();
		}
		
		private function removeSelf() : void
		{
			removeEventListener(Event.ENTER_FRAME, loop);
			
			if (stageRef.contains(this))
				stageRef.removeChild(this);
		}
		
	}
	
}

