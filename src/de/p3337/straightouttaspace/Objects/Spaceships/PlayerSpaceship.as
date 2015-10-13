/**
 * @author Peter Hansen
 * @copyright p3337.de All rights reserved.
 */
package de.p3337.straightouttaspace.Objects.Spaceships
{
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import de.p3337.straightouttaspace.Objects.DrawableObject;
	import de.p3337.straightouttaspace.Objects.Players.PlayerObject;
	import de.p3337.straightouttaspace.Utils.CollisionCalculationHelper;
	import de.p3337.straightouttaspace.Utils.Dimensions;
	
	/**
	 * The PlayerSpaceship is owned by the game's Player player.
	 * It has a fireTimer to limit the bullet rate at a time.
	 */
	public class PlayerSpaceship extends Spaceship
	{
		//fire related variables
		private var fireTimer:Timer;
		private var isShooting:Boolean;
		
		public function PlayerSpaceship(parent:PlayerObject, position:Point, 
										dimensions:Dimensions)
		{
			super(parent, position, dimensions);
			
			//setup fireTimer and attach a listener to it.
			isShooting = false;
			fireTimer = new Timer(250, 1);
			fireTimer.addEventListener(TimerEvent.TIMER, fireTimerHandler, false, 0, true);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function update():void
		{
			super.update();
			
			if(checkSpaceshipCollision())
			{
				this.shieldStrength--;
				if(this.shieldStrength <= 0)
				{
					this.toBeDestroyed = true;
				}
			}
		}
		
		/**
		 * Checks for collisions with opponent spaceships.
		 * On hit it reduces the corresponding spaceship shield strengths and 
		 * sets them ready to remove if there is none left.
		 * @return True if there is a collision 
		 */
		private function checkSpaceshipCollision():Boolean
		{
			var collisionVector:Vector.<DrawableObject> = new Vector.<DrawableObject>();
			var opponentSpaceships:Vector.<Spaceship> = parent.parent.opponent.spaceshipVector;
			for each(var opponentSpaceship:Spaceship in opponentSpaceships)
			{
				if(CollisionCalculationHelper.checkShipShipCollision(this, opponentSpaceship))
				{ 
					collisionVector.push(opponentSpaceship);
				}
			}
			
			for each(var hardHitSpaceship:Spaceship in collisionVector)
			{
				hardHitSpaceship.toBeDestroyed = true;
				parent.score += hardHitSpaceship.points;
			}
			
			if(collisionVector.length > 0) return true;
			else return false;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function fire():void
		{
			if(!isShooting)
			{
				isShooting = true;
				
				// create new weapon / bullets
				var position:Point = this.position.clone();
				position.y -= this._dimensions.height / 2;
				parent.weaponVector.push(
					parent.weaponFactory.createBlueLaser(position, this.weaponPower)
				);
				
				fireTimer.start();
			}
		}
		
		private function fireTimerHandler(e:TimerEvent):void
		{
			isShooting = false;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function destroy():void
		{
			super.destroy();
			this.fireTimer.stop();
			this.fireTimer.removeEventListener(TimerEvent.TIMER, fireTimerHandler);
			this.fireTimer = null;
		}
	}
}