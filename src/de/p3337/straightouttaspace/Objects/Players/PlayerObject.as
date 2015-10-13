/**
 * @author Peter Hansen
 * @copyright p3337.de All rights reserved.
 */
package de.p3337.straightouttaspace.Objects.Players
{
	import de.p3337.straightouttaspace.Objects.Board;
	import de.p3337.straightouttaspace.Objects.Spaceships.Spaceship;
	import de.p3337.straightouttaspace.Objects.Spaceships.SpaceshipFactory;
	import de.p3337.straightouttaspace.Objects.Weapons.Weapon;
	import de.p3337.straightouttaspace.Objects.Weapons.WeaponFactory;

	/**
	 * Abstract class for implementing a player.
	 * 
	 * Every player can have a number of spaceships.
	 * These spaceships have certain weapons to fire bullets against opponent 
	 * spaceships. These bullets are the drawable objects that are also stored 
	 * here. Furthermore a player can also have a score.
	 */
	public class PlayerObject implements IPlayerObject
	{
		protected var _spaceshipFactory:SpaceshipFactory;
		protected var _spaceshipVector:Vector.<Spaceship>;
		
		protected var _weaponVector:Vector.<Weapon>;
		protected var _weaponFactory:WeaponFactory
		
		protected var _score:uint;
		protected var _parent:Board;
		
		public function PlayerObject(parent:Board, spaceshipFactory:SpaceshipFactory)
		{
			this._parent = parent;
			
			this._spaceshipFactory = spaceshipFactory;
			this._weaponFactory = new WeaponFactory(this);
			this._weaponVector = new Vector.<Weapon>();
		}
		
		/**
		 * @inheritDoc
		 */
		public function update():void {
			
			// check if a weapon was destroyed / disapeared. If so, remove it
			var x:uint = weaponVector.length;
			var weapon:Weapon;
			while (--x > -1) 
			{
				weapon = weaponVector[x];
				if(weapon.toBeDestroyed) {
					weapon = null;
					weaponVector.splice(x,1);
				} else {
					weapon.update();
				}
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function createSpaceships():void {}

		public function get spaceshipVector():Vector.<Spaceship>
		{
			return _spaceshipVector;
		}

		public function set spaceshipVector(value:Vector.<Spaceship>):void
		{
			_spaceshipVector = value;
		}
		
		public function get parent():Board
		{
			return _parent;
		}
		
		public function get weaponFactory():WeaponFactory
		{
			return _weaponFactory;
		}
		
		public function get weaponVector():Vector.<Weapon>
		{
			return _weaponVector;
		}
		
		public function set weaponVector(value:Vector.<Weapon>):void
		{
			_weaponVector = value;
		}
		
		public function get score():uint
		{
			return _score;
		}
		
		public function set score(value:uint):void
		{
			_score = value;
			parent.parent.main.highscore.setScore(value);
		}
		
		/**
		 * @inheritDoc
		 */
		public function destroy():void
		{
			this._spaceshipFactory = null;
			
			for each (var spaceship:Spaceship in this._spaceshipVector) {
				spaceship.destroy();
			}
			this._spaceshipVector = null;
			
			this._weaponFactory.destroy();
			this._weaponFactory = null;
			for each (var weapon:Weapon in this.weaponVector) {
				weapon.destroy();
			}
			this.weaponVector = null;
			
			this._parent = null;
		}
	}
}