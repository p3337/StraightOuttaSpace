/**
 * @author Peter Hansen
 * @copyright p3337.de All rights reserved.
 */
package de.p3337.straightouttaspace.Objects.Players
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	import de.p3337.straightouttaspace.Objects.Board;
	import de.p3337.straightouttaspace.Objects.Spaceships.PlayerSpaceship;
	import de.p3337.straightouttaspace.Objects.Spaceships.Spaceship;
	import de.p3337.straightouttaspace.Objects.Spaceships.SpaceshipFactory;
	import de.p3337.straightouttaspace.Sound.Jukebox;
	import de.p3337.straightouttaspace.Sound.SoundFileEnum;
	import de.p3337.straightouttaspace.Utils.SizeEnum;

	/**
	 * This Player class mainly serves as a controller to check the user input 
	 * in order to control the player's spaceship movement:
	 * 
	 * - To move your spaceship use either W, A, S, D or the arrow keys.
	 * - To shoot press SPACE.
	 * - To pause the game press ENTER
	 * - To exit the game press ESC 
	 */
	public class Player extends PlayerObject
	{
		private var stage:Stage;
		
		// key status
		private var keyMoveUp:Boolean;
		private var keyMoveDown:Boolean;
		private var keyMoveLeft:Boolean;
		private var keyMoveRight:Boolean;
		private var keyFireWeapon:Boolean;
		
		// movement
		private var velocity:Number = 0.5;
		private var velocityX:Number = 0;
		private var velocityY:Number = 0;
		private var friction:Number = 0.9;
		private var maxspeed:Number = 8;
		
		public function Player(parent:Board, spaceshipFactory:SpaceshipFactory)
		{
			super(parent, spaceshipFactory);
			
			this.stage = parent.parent.main.stage;
			
			// add keyboard event listener to move spaceship
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPress);
			this.stage.addEventListener(KeyboardEvent.KEY_UP, keyRelease);			
		}
		
		/**
		 * @inheritDoc
		 */
		override public function createSpaceships():void
		{
			// create spaceship
			var bottomCenter:Point = new Point(this.stage.stageWidth / 2, this.stage.stageHeight - 100);
			var size:SizeEnum = SizeEnum.LARGE;
			
			this.spaceshipVector = new Vector.<Spaceship>(1, true);
			this.spaceshipVector[0] = parent.spaceshipFactory.createPlayerSpaceship(bottomCenter, size);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function update():void
		{
			super.update();
			
			// either end game if ship was destroyed or update its position
			var spaceship:PlayerSpaceship = this.spaceshipVector[0] as PlayerSpaceship;
			if(spaceship.toBeDestroyed)
			{
				parent.parent.isGameOver = true;
			}
			else
			{
				spaceship.update();
			
				// keypresses
				if (keyMoveLeft) velocityX -= velocity;
				else if (keyMoveRight) velocityX += velocity;
				else velocityX *= friction;
				
				if (keyMoveUp) velocityY -= velocity;
				else if (keyMoveDown) velocityY += velocity;
				else velocityY *= friction;
				
				if (keyFireWeapon) spaceship.fire();
				
				// update position
				spaceship.position.x += velocityX;
				spaceship.position.y += velocityY;
				
				// speed adjustment
				if (velocityX > maxspeed) velocityX = maxspeed;
				else if (velocityX < -maxspeed) velocityX = -maxspeed;
				if (velocityY > maxspeed) velocityY = maxspeed;
				else if (velocityY < -maxspeed) velocityY = -maxspeed;
				
				// spaceship side movement effect
				spaceship.rotation = velocityX;
				spaceship.scaleX = (maxspeed - Math.abs(velocityX)) / (maxspeed * 4) + 0.75;
				
				// stay inside screen
				if (spaceship.position.x > this.stage.stageWidth)
				{
					spaceship.position.x = this.stage.stageWidth;
					velocityX = -velocityX;
				}
				else if (spaceship.position.x < 0) 
				{
					spaceship.position.x = 0;
					velocityX = -velocityX;
				}
				
				if (spaceship.position.y + spaceship.dimensions.height / 2 > this.stage.stageHeight)
				{
					spaceship.position.y = this.stage.stageHeight - spaceship.dimensions.height / 2;
					velocityY = -velocityY;
				}
				else if (spaceship.position.y - spaceship.dimensions.height / 2 < 0) 
				{
					spaceship.position.y = spaceship.dimensions.height / 2;
					velocityY = -velocityY;
				}
			}
		}
		
		private function keyPress(e:KeyboardEvent):void
		{	
			if(!parent.parent.isPaused) {
				var key:uint = e.keyCode;
				if (key == Keyboard.A || key == Keyboard.LEFT) {keyMoveLeft = true;}
				if (key == Keyboard.D || key == Keyboard.RIGHT) {keyMoveRight = true;}
				if (key == Keyboard.W || key == Keyboard.UP) {keyMoveUp = true;}
				if (key == Keyboard.S || key == Keyboard.DOWN) {keyMoveDown = true;}
				if (key == Keyboard.SPACE) {keyFireWeapon = true;}
			}
		}
		
		private function keyRelease(e:KeyboardEvent):void
		{	
			var key:uint = e.keyCode;
			if (key == Keyboard.A || key == Keyboard.LEFT) {keyMoveLeft = false;}
			if (key == Keyboard.D || key == Keyboard.RIGHT) {keyMoveRight = false;}
			if (key == Keyboard.W || key == Keyboard.UP) {keyMoveUp = false;}
			if (key == Keyboard.S || key == Keyboard.DOWN) {keyMoveDown = false;}
			if (key == Keyboard.SPACE) {keyFireWeapon = false;}
			if (key == Keyboard.ENTER)
			{
				if(parent.parent.isPaused) Jukebox.getInstance().play(SoundFileEnum.RESUME);
				else Jukebox.getInstance().play(SoundFileEnum.PAUSE);
				parent.parent.isPaused = !parent.parent.isPaused;
				if(parent.opponent.attackStrategy.attackTimer.running) {
					parent.opponent.attackStrategy.attackTimer.stop();
				} else {
					parent.opponent.attackStrategy.attackTimer.start();
				}
			}
			if (key == Keyboard.ESCAPE)
			{
				Jukebox.getInstance().play(SoundFileEnum.LOSE);
				parent.parent.main.initializeScreen(true);
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function destroy():void
		{
			super.destroy();
			this.stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyPress);
			this.stage.removeEventListener(KeyboardEvent.KEY_UP, keyRelease);
			this.stage = null;
		}
	}
}