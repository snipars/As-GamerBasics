package com.asgamer.basics1{
	
	import com.senocular.utils.KeyObject;
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	public class Ship extends MovieClip{
		
		private var stageRef:Stage;
		private var key:KeyObject;
		private var speed:Number = 0.5;
		private var vx:Number = 0;
		private var vy:Number = 0;
		private var friction:Number = 0.93;
		private var maxspeed:Number= 8;
		private var fireTimer:Timer;
		private var canFire:Boolean = true;
		
		public function Ship(stageRef:Stage)
		{
			this.stageRef = stageRef;
			key = new KeyObject(stageRef);
			
			fireTimer = new Timer(300, 1);
			fireTimer.addEventListener(TimerEvent.TIMER, fireTimerHandler, false, 0, true);
			
			addEventListener(Event.ENTER_FRAME, loop, false, 0 ,true);
		}
		private function fireBullet() : void
		{
			if (canFire)
			{
			stageRef.addChild(new LaserBlue(stageRef, x+vx, y - 10));
			canFire = false;
			fireTimer.start();
			}
		}
		private function fireTimerHandler(e:TimerEvent) : void
		{
			canFire = true;
		}
		public function takeHit() : void
		{
			dispatchEvent(new Event("hit"));
		}

		
		public function loop (e:Event) : void
		{
			if (key.isDown(Keyboard.LEFT))
				vx -= speed;
			else if (key.isDown(Keyboard.RIGHT))
				vx += speed;
			else
				vx *= friction;
			
			if (key.isDown(Keyboard.UP))
				vy -= speed;
			else if (key.isDown(Keyboard.DOWN))
				vy += speed;
			else
				vy *= friction;
			
			if (key.isDown(Keyboard.SPACE))
				fireBullet();
			
			x += vx;
			y += vy;
			
			rotation = vx;
			
			if (vx > maxspeed)
				vx = maxspeed;
			else if (vx< -maxspeed)
				vx = -maxspeed;
			
			if (vy> maxspeed)
				vy = maxspeed;
			else if (vy < -maxspeed)
				vy = -maxspeed
					scaleX = (maxspeed - Math.abs(vx))/(maxspeed*4) + 0.75;
			//
			if (x> stageRef.stageWidth)
			{
				x = stageRef.stageWidth;
				vx = -vx
			}
			else if (x<0)
			{
				x = 0;
				vx = -vx;
			}
			
			if (y>stageRef.stageHeight)
			{
				y = stageRef.stageHeight;
				vy = -vy;
			}
			else if (y<0)
			{
				y=0
					vy = -vy
			}


		}
	}
}