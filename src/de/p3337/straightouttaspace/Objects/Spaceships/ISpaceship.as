package de.p3337.straightouttaspace.Objects.Spaceships
{
	public interface ISpaceship
	{
		/**
		 * Creates a weapon and fires it.
		 */
		function fire():void;
		
		/**
		 * Destroys this object.
		 */
		function destroy():void;
	}
}