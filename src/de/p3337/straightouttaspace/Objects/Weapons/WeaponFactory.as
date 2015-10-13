/**
 * @author Peter Hansen
 * @copyright p3337.de All rights reserved.
 */
package de.p3337.straightouttaspace.Objects.Weapons
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	
	import de.p3337.straightouttaspace.Objects.Players.PlayerObject;
	import de.p3337.straightouttaspace.Objects.Spaceships.Spaceship;
	import de.p3337.straightouttaspace.Utils.Dimensions;
	import de.p3337.straightouttaspace.Utils.VectorCalculationHelper;
	import de.p3337.straightouttaspace.Views.Objects.Weapons.BlueLaserView;
	import de.p3337.straightouttaspace.Views.Objects.Weapons.RedLaserView;

	/**
	 * This factory is to build new weapons for the different players and their 
	 * spaceships of this game. 
	 */
	public class WeaponFactory
	{
		[Embed(source='/de/p3337/straightouttaspace/resources/spaceshooter/PNG/Lasers/laserBlue03.png')]
		private var LaserBlueClass:Class;
		private var laserBlueBitmap:Bitmap;
		
		[Embed(source='/de/p3337/straightouttaspace/resources/spaceshooter/PNG/Lasers/laserRed10.png')]
		private var LaserRedClass:Class;
		private var laserRedBitmap:Bitmap;
		
		private var parent:PlayerObject;
		
		public function WeaponFactory(parent:PlayerObject)
		{
			this.parent = parent;
			this.laserBlueBitmap = new LaserBlueClass();
			this.laserRedBitmap = new LaserRedClass();
		}
		
		/**
		 * Creates and returns a new blue Laser for the player's spaceship.
		 * Also creates a new view for this weapon.
		 * 
		 * @param position Start position of the new ship.
		 * @param power The amount of damage it causes on hit.
		 * @return The created weapon.
		 */
		public function createBlueLaser(position:Point, power:uint):Weapon
		{
			var playersSpaceship:Spaceship = parent.parent.player.spaceshipVector[0];
			var dimensions:Dimensions = new Dimensions(9, 37);
			position.y -= dimensions.height / 2;
			
			var laser:Laser = new Laser(parent, position, dimensions, power);
			laser.texture = new Bitmap(this.laserBlueBitmap.bitmapData);
			laser.direction.y = -1;
			
			// create a corresponding view for this new weapon
			var laserView:BlueLaserView = new BlueLaserView(laser);
			var wasAdded:Boolean = parent.parent.parent.screen.addDrawableObjectView(laserView);
			
			return laser;
		}
		
		/**
		 * Creates and returns a new red Laser for the opponent's spaceships.
		 * Also creates a new view for this weapon.
		 * 
		 * @param position Start position of the new ship.
		 * @param power The amount of damage it causes on hit.
		 * @return The created weapon.
		 */
		public function createRedLaser(position:Point, power:uint):Weapon
		{
			var dimensions:Dimensions = new Dimensions(10, 9);
			position.y -= dimensions.height / 2;
			
			var laser:Laser = new Laser(parent, position, dimensions, power);
			var playersSpaceship:Spaceship = parent.parent.player.spaceshipVector[0];
			var playersSpaceshipPosition:Point = playersSpaceship.position.clone();
			playersSpaceshipPosition.y += playersSpaceship.texture.height;
			laser.texture = new Bitmap(this.laserRedBitmap.bitmapData);
			laser.direction = VectorCalculationHelper.calcUnitVector(position, playersSpaceshipPosition);
			laser.velocity = 5;
			
			// create a corresponding view for this new weapon
			var laserView:RedLaserView = new RedLaserView(laser);
			var wasAdded:Boolean = parent.parent.parent.screen.addDrawableObjectView(laserView);
			return laser;
		}
		
		/**
		 * Destroys this object.
		 */
		public function destroy():void
		{
			this.parent = null;
			this.LaserBlueClass = null;
			this.LaserRedClass = null;
		}
	}
}