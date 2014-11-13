package com.asgamer.basics1
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	
	public class Engine extends MovieClip
	{
		private var numStars:int = 80;
		public static var enemyList:Array = new Array();
		private var ourShip:Ship;
		
		private var scoreHUD:ScoreHUD;
		
		public function Engine() : void
		{
			ourShip = new Ship(stage);
			stage.addChild(ourShip);
			
			ourShip.x = stage.stageWidth / 2;
			ourShip.y = stage.stageHeight / 2;
			ourShip.addEventListener("hit", shipHit, false, 0, true);
			for (var i:int = 0; i<numStars; i++)
				
			scoreHUD = new ScoreHUD(stage);
			stage.addChild(scoreHUD);
			{
				stage.addChildAt(new Star(stage), stage.getChildIndex(ourShip));
			}
			
			addEventListener (Event.ENTER_FRAME, loop, false, 0, true);
		}
			private function loop(e:Event) : void
			{
				//run if condition is met.
				if (Math.floor(Math.random() * 90) == 5)
				{
					//create our enemy
					var enemy:Stinger = new Stinger(stage, ourShip);
					
					//listen for enemy being removed from stage
					enemy.addEventListener(Event.REMOVED_FROM_STAGE, removeEnemy, false, 0, true);
					
					enemy.addEventListener("killed", enemyKilled, false, 0, true);
					//add our enemy to the enemyList
					enemyList.push(enemy);
					
					stage.addChild(enemy);
				}
			}
			private function enemyKilled(e:Event) : void
			{
				scoreHUD.updateKills(1); //add 1 to enemy kills
				scoreHUD.updateScore(e.currentTarget.points); //add that points variable we created earlier
			}
			
			//run when an enemy is removed from stage
			private function removeEnemy(e:Event)
			{
				enemyList.splice(enemyList.indexOf(e.currentTarget), 1);
			}
			
			private function shipHit(e:Event) : void
			{
				scoreHUD.updateHits(1); //add 1 to number of hits
			}
			
			
		}
		
	}