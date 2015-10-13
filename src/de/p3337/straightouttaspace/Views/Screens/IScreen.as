/**
 * @author Peter Hansen
 * @copyright p3337.de All rights reserved.
 */
package de.p3337.straightouttaspace.Views.Screens
{
	import flash.display.Sprite;

	public interface IScreen
	{	
		
		/**
		 * Every Screen has to use "view" to place all visible elements on.
		 * @return The Screen-Sprite.
		 */
		function get view():Sprite;
		
		/**
		 * Initiated by the game's graphic timer.
		 */
		function update():void;
		
		/**
		 * Destroys this object.
		 */
		function destroy():void;
	}
}