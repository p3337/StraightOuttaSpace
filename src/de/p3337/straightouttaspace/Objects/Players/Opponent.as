/**
 * @author Peter Hansen
 * @copyright p3337.de All rights reserved.
 */
package de.p3337.straightouttaspace.Objects.Players
{
	import flash.display.Stage;
	
	import de.p3337.straightouttaspace.Objects.Board;
	import de.p3337.straightouttaspace.Objects.Players.AI.AttackStrategy;
	import de.p3337.straightouttaspace.Objects.Players.AI.SimpleAttackStrategy;
	import de.p3337.straightouttaspace.Objects.Spaceships.OpponentSpaceship;
	import de.p3337.straightouttaspace.Objects.Spaceships.Spaceship;
	import de.p3337.straightouttaspace.Objects.Spaceships.SpaceshipFactory;

	/**
	 * The Opponent uses a certain "AttackStrategy" to build different number 
	 * and sizes of spaceships to attack the users spaceship. For now a simple 
	 * one was implemented. 
	 */
	public class Opponent extends PlayerObject
	{
		private var _stage:Stage;
		private var _attackStrategy:AttackStrategy;
		
		public function Opponent(parent:Board, spaceshipFactory:SpaceshipFactory)
		{
			super(parent, spaceshipFactory);
			this.spaceshipVector = new Vector.<Spaceship>();
			this._stage = parent.parent.main.stage;
			this._attackStrategy = new SimpleAttackStrategy(this, 7000);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function createSpaceships():void
		{
			this._attackStrategy.sendNewSpaceshipWave();
			this._attackStrategy.attackTimer.start();
		}
		
		/**
		 * @inheritDoc
		 */
		override public function update():void
		{
			super.update();
			
			// check if ship was destroyed and remove it or update the attack 
			// strategy for this ship
			var x:uint = this._spaceshipVector.length;
			while (--x > -1)
			{
				var ship:OpponentSpaceship = this._spaceshipVector[x] as OpponentSpaceship; 
				if(ship.toBeDestroyed) {
					ship = null;
					this._spaceshipVector.splice(x,1);
				} else {
					ship.update();
					this._attackStrategy.update(ship);
				}
			}	
		}
		
		public function get attackStrategy():AttackStrategy
		{
			return _attackStrategy;
		}
		
		public function get stage():Stage
		{
			return _stage;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function destroy():void
		{
			super.destroy();
			this._attackStrategy.destroy();
			this._attackStrategy = null;
			this._stage = null;
		}
	}
}