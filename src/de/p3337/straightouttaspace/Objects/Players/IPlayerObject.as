/**
 * @author Peter Hansen
 * @copyright p3337.de All rights reserved.
 */
package de.p3337.straightouttaspace.Objects.Players
{
	public interface IPlayerObject
	{
		/**
		 * Initiated by the game's logic timer.
		 */
		function update():void;
		
		/**
		 * Creates this player's spaceships
		 */
		function createSpaceships():void;
		
		/**
		 * Destroys this object.
		 */
		function destroy():void;
	}
}