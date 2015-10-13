/**
 * @author Peter Hansen
 * @copyright p3337.de All rights reserved.
 */
package de.p3337.straightouttaspace.Objects.Spaceships
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	
	import de.p3337.straightouttaspace.Objects.Board;
	import de.p3337.straightouttaspace.Utils.Dimensions;
	import de.p3337.straightouttaspace.Utils.SizeEnum;
	import de.p3337.straightouttaspace.Views.Objects.Spaceships.OpponentSpaceshipView;
	import de.p3337.straightouttaspace.Views.Objects.Spaceships.PlayerSpaceshipView;

	/**
	 * This factory is to build new spaceships for the different players of this
	 * game. 
	 */
	public class SpaceshipFactory
	{	
		[Embed(source='/de/p3337/straightouttaspace/resources/spaceshooter/PNG/playerShip3_blue.png')]
		private var PlayerClass:Class;
		
		[Embed(source='/de/p3337/straightouttaspace/resources/spaceshooter/PNG/Enemies/enemyGreen3.png')]
		private var EnemyGreenClass:Class;
		
		[Embed(source='/de/p3337/straightouttaspace/resources/spaceshooter/PNG/Enemies/enemyRed3.png')]
		private var EnemyRedClass:Class;
		
		[Embed(source='/de/p3337/straightouttaspace/resources/spaceshooter/PNG/Enemies/enemyBlack3.png')]
		private var EnemyBlackClass:Class;
		
		private var parent:Board;
		
		public function SpaceshipFactory(parent:Board)
		{
			this.parent = parent;
		}
		
		/**
		 * Creates and returns a new player's spaceship in different sizes.
		 * Also creates a new view for this ship.
		 * 
		 * @param position Start position of the new ship.
		 * @param size Size of the new ship.
		 * @return The created (Player)Spaceship.
		 */
		public function createPlayerSpaceship(position:Point, size:SizeEnum):Spaceship {
			var dimensions:Dimensions;
			var weaponPower:int = 1;
			var shieldStrength:int;
			var texture:Bitmap = new PlayerClass();
			
			switch(size)
			{
				case SizeEnum.SMALL:
				{
					dimensions = new Dimensions(40, 31);
					shieldStrength = 1;
				}
				break;
				case SizeEnum.MEDIUM:
				{
					dimensions = new Dimensions(59, 45);
					shieldStrength = 2;
					
				}
				break;
				case SizeEnum.LARGE:
				{
					dimensions = new Dimensions(98, 75);
					shieldStrength = 5;	
				}
				break;
			}
			
			texture.width = dimensions.width;
			texture.height = dimensions.height;
			
			var spaceship:Spaceship = new PlayerSpaceship(parent.player, position, dimensions);
			spaceship.weaponPower = weaponPower;
			spaceship.shieldStrength = shieldStrength;
			spaceship.texture = texture;
			
			// create a corresponding view for this new ship
			var view:PlayerSpaceshipView = new PlayerSpaceshipView(spaceship);
			var wasAdded:Boolean = parent.parent.screen.addDrawableObjectView(view);
			
			return spaceship;
		}
		
		/**
		 * Creates and returns a new opponents's spaceship in different sizes.
		 * Also creates a new view for this ship.
		 * 
		 * @param position Start position of the new ship.
		 * @param size Size of the new ship.
		 * @return The created (Opponent)Spaceship.
		 */
		public function createOpponentSpaceship(position:Point, size:SizeEnum):Spaceship {
			var dimensions:Dimensions;
			var weaponPower:int = 1;
			var shieldStrength:int = 0;
			var points:uint = 0;
			var texture:Bitmap;
			
			switch(size)
			{
				case SizeEnum.SMALL:
				{
					dimensions = new Dimensions(41, 34);
					shieldStrength = 1;
					points = 10;
					texture = new EnemyGreenClass();
				}
				break;
				case SizeEnum.MEDIUM:
				{
					dimensions = new Dimensions(62, 50);
					shieldStrength = 2;
					points = 20;
					texture = new EnemyRedClass();
				}
				break;
				case SizeEnum.LARGE:
				{
					dimensions = new Dimensions(103, 84);
					shieldStrength = 6;
					points = 50;
					texture = new EnemyBlackClass();
				}
				break;
			}
			
			texture.width = dimensions.width;
			texture.height = dimensions.height;
			
			var spaceship:OpponentSpaceship = new OpponentSpaceship(parent.opponent, position, dimensions);
			spaceship.weaponPower = weaponPower;
			spaceship.shieldStrength = shieldStrength;
			spaceship.texture = texture;
			spaceship.points = points;			
			
			// create a corresponding view for this new ship
			var view:OpponentSpaceshipView = new OpponentSpaceshipView(spaceship);
			var wasAdded:Boolean = parent.parent.screen.addDrawableObjectView(view);
			
			return spaceship;
		}
		
		/**
		 * Destroys this object.
		 */
		public function destroy():void
		{
			this.parent = null;
			this.EnemyGreenClass = null;
			this.EnemyRedClass = null;
			this.EnemyBlackClass = null;
			this.PlayerClass = null;
		}
	}
}