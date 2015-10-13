/**
 * @author Peter Hansen
 * @copyright p3337.de All rights reserved.
 */
package de.p3337.straightouttaspace.Objects.Players.AI
{
	import de.p3337.straightouttaspace.Objects.Spaceships.OpponentSpaceship;

	public interface IAttackStrategy
	{
		/**
		 * Initiated by the game's logic timer.
		 * @param ship An OpponentSpaceship that is to control.
		 */
		function update(ship:OpponentSpaceship):void;
		
		/**
		 * Destroys this object.
		 */
		function destroy():void;
		
		/**
		 * Sets the weapon to use.
		 * @param ship An OpponentSpaceship that is ready to fire
		 */
		function fire(ship:OpponentSpaceship):void;
		
		/**
		 * Controlls the ships movement.
		 * @param ship An OpponentSpaceship that has to be moved.
		 */
		function move(ship:OpponentSpaceship):void;
	}
}