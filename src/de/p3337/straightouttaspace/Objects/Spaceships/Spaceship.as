/**
 * @author Peter Hansen
 * @copyright p3337.de All rights reserved.
 */
package de.p3337.straightouttaspace.Objects.Spaceships
{
	import flash.geom.Point;
	
	import de.p3337.straightouttaspace.Objects.DrawableObject;
	import de.p3337.straightouttaspace.Objects.Players.PlayerObject;
	import de.p3337.straightouttaspace.Utils.Dimensions;

	/**
	 * Abstract class for implementing a spaceship.
	 * 
	 * Every spaceship has certain lives - here represented by "shieldStength".
	 * Furthermore a spaceship can fire with a certain power, which is 
	 * represented by "weaponPower". If a ship is destroyed, "points" is holding
	 * the amount of point the user is getting for it.
	 */
	public class Spaceship extends DrawableObject implements ISpaceship
	{
		protected var _parent:PlayerObject;
		protected var _shieldStrength:int;
		protected var _weaponPower:int;
		protected var _points:uint;
		
		public function Spaceship(parent:PlayerObject, position:Point, dimensions:Dimensions)
		{
			super(position, dimensions);
			this._parent = parent;
		}
		
		/**
		 * @inheritDoc
		 */
		public function fire():void {}

		public function get shieldStrength():int
		{
			return _shieldStrength;
		}

		public function set shieldStrength(value:int):void
		{
			_shieldStrength = value;
		}

		public function get weaponPower():int
		{
			return _weaponPower;
		}

		public function set weaponPower(value:int):void
		{
			_weaponPower = value;
		}
		
		public function get parent():PlayerObject
		{
			return _parent;
		}
		
		public function get points():uint
		{
			return _points;
		}
		
		public function set points(value:uint):void
		{
			_points = value;
		}
		
		/**
		 * @inheritDoc
		 */
		public function destroy():void
		{
			this._parent = null;
		}
	}
}