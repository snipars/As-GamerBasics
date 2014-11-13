

package com.asgamer.basics1
{
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	
	public class Stinger extends MovieClip
	{
		
		private var stageRef:Stage;
		private var vy:Number = 4;
		private var ay:Number = .2;
		private var target:Ship;
		
		public var points:int = 1020;
		
		public function Stinger(stageRef:Stage, target:Ship) : void
		{
			stop();
			this.stageRef = stageRef;
			this.target = target;
			
			x = Math.random() * stageRef.stageWidth;
			y = -5;
			
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
		}
		
		private function loop(e:Event) : void
		{
			if (currentLabel != "destroyed")
			{
			vy += ay;
			y += vy;
			
			if (y > stageRef.stageHeight)
				removeSelf();
			
			if (y - 15 < target.y && y + 15 > target.y)
				fireWeapon();
		}
			if (currentLabel == "destroyedComplete")
				removeSelf();
		}
		
		private function fireWeapon() : void
		{
			stageRef.addChild(new StingerBullet(stageRef, target, x, y, -8));
			stageRef.addChild(new StingerBullet(stageRef, target, x, y, 8));
		}
		
		private function removeSelf() : void {
			
			removeEventListener(Event.ENTER_FRAME, loop);
			
			if (stageRef.contains(this))
				stageRef.removeChild(this);
			
		}
		
		public function takeHit() : void
		{
			if (currentLabel != "destroyed" && currentLabel != "destroyedComplete") { //make sure out ship isn't destroyed
				{
				dispatchEvent(new Event("killed"));
				rotation = Math.random() * 360; //make the parts seem to fly in random directions
				gotoAndPlay("destroyed"); //start playing at our destroyed frame
				}
			}
		
		}
	
	}
}


