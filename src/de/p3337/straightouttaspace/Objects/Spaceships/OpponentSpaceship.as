/**
 * @author Peter Hansen
 * @copyright p3337.de All rights reserved.
 */
package de.p3337.straightouttaspace.Objects.Spaceships
{
	import flash.geom.Point;
	
	import de.p3337.straightouttaspace.Objects.Players.Opponent;
	import de.p3337.straightouttaspace.Objects.Players.PlayerObject;
	import de.p3337.straightouttaspace.Utils.Dimensions;
	
	/**
	 * The OpponentSpaceship is owned by the game's Opponent player.
	 */
	public class OpponentSpaceship extends Spaceship
	{
		private var _velocity:Number;
		private var _hasFired:Boolean;
		
		public function OpponentSpaceship(parent:PlayerObject, position:Point, 
										  dimensions:Dimensions)
		{
			super(parent, position, dimensions);
			
			this._velocity = 2;
			this._hasFired = false;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function update():void
		{	
			// move ship
			(this._parent as Opponent).attackStrategy.move(this);
			
			// check if passed screen boarders
			if (this.position.y - this.dimensions.height > 
				parent.parent.parent.main.stage.stageHeight)
			{
				toBeDestroyed = true;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function fire():void
		{	
			this._hasFired = true;
			(this._parent as Opponent).attackStrategy.fire(this);
		}

		public function get hasFired():Boolean
		{
			return _hasFired;
		}

		public function get velocity():Number
		{
			return _velocity;
		}

		public function set velocity(value:Number):void
		{
			_velocity = value;
		}
	}
}