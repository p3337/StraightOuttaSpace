/**
 * @author Peter Hansen
 * @copyright p3337.de All rights reserved.
 */
package de.p3337.straightouttaspace.Objects.Players.AI
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import de.p3337.straightouttaspace.Objects.Players.Opponent;
	import de.p3337.straightouttaspace.Objects.Spaceships.OpponentSpaceship;

	/**
	 * Abstract class for implementing opponent attack strategies.
	 * 
	 * This class has an attackTimer that is for creating new waves of opponent 
	 * spaceships for every tick.
	 * The fire function is to set which weapon to use.
	 * The move function is to contol the spaceship movement.
	 */
	public class AttackStrategy implements IAttackStrategy
	{
		protected var _attackTimer:Timer;
		protected var parent:Opponent;
		
		public function AttackStrategy(parent:Opponent, attackInterval:uint)
		{
			this.parent = parent;
			
			this._attackTimer = new Timer(attackInterval);
			this._attackTimer.addEventListener(TimerEvent.TIMER, onAttackTimer);
		}
		
		/**
		 * TimerEvent that will be used to send new attacks
		 * @param e A Timer event
		 */
		protected function onAttackTimer(e:TimerEvent):void {}
		
		/**
		 * @inheritDoc
		 */
		public function update(ship:OpponentSpaceship):void {}
		
		/**
		 * @inheritDoc
		 */
		public function fire(ship:OpponentSpaceship):void {}
		
		public function sendNewSpaceshipWave():void {}
		
		/**
		 * @inheritDoc
		 */
		public function move(ship:OpponentSpaceship):void {}
		
		public function get attackTimer():Timer
		{
			return _attackTimer;
		}
		
		public function set attackTimer(value:Timer):void
		{
			_attackTimer = value;
		}
		
		/**
		 * @inheritDoc
		 */
		public function destroy():void
		{
			this._attackTimer.stop();
			this._attackTimer.removeEventListener(TimerEvent.TIMER, onAttackTimer);
			this._attackTimer = null;
		}
		
	}
}