/**
 * @author Peter Hansen
 * @copyright p3337.de All rights reserved.
 */
package de.p3337.straightouttaspace.Views.Objects
{
	public interface IDrawableObjectView
	{
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