/**
 * @author Peter Hansen
 * @copyright p3337.de All rights reserved.
 */
package de.p3337.straightouttaspace.Main
{
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.system.fscommand;
	import flash.ui.Keyboard;
	
	import de.p3337.straightouttaspace.Objects.Game;
	import de.p3337.straightouttaspace.Objects.Highscore;
	import de.p3337.straightouttaspace.Sound.Jukebox;
	import de.p3337.straightouttaspace.Sound.SoundFileEnum;
	import de.p3337.straightouttaspace.Views.Screens.GameOverScreen;
	import de.p3337.straightouttaspace.Views.Screens.IScreen;
	import de.p3337.straightouttaspace.Views.Screens.PlayScreen;
	import de.p3337.straightouttaspace.Views.Screens.StartScreen;
	
	[SWF(frameRate="60", width="600", height="800", backgroundColor = "#000000")]
	public class StraightOuttaSpace extends Sprite
	{
		public static const SOS_PADDING:uint = 75;
		
		private var _currentScreen:IScreen;
		private var game:Game;
		private var _highscore:Highscore;
		
		public function StraightOuttaSpace()
		{
			mouseChildren = false;
			mouseEnabled = false;
			
			this._highscore = new Highscore();
			
			initializeScreen();
		}
		
		/**
		 * Draws an initial start or game over screen and adds an event listener
		 * to wait for user input in order to start a new game. 
		 * @param gameOver True is a current game exists and has ended.
		 */		
		public function initializeScreen(gameOver:Boolean = false):void
		{
			// delete current game if any
			if(game)
			{
				game.destroy();
				game = null;
			}
			
			if(gameOver) loadScreen("gameOver");
			else loadScreen("start");
			
			// wait for user input to start a new game
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDownListener);
		}
		
		/**
		 * Creates a new screen and destorys a previos one if any.
		 * @param screen The name of the screen to show 
		 */
		private function loadScreen(screen:String):void
		{
			if(currentScreen) 
			{
				currentScreen.destroy();
				removeChild(currentScreen.view);
				currentScreen = null;
			}
			
			switch(screen)
			{
				case "start": currentScreen = new StartScreen(stage); break;
				case "play": currentScreen = new PlayScreen(stage); break;
				case "gameOver": currentScreen = new GameOverScreen(stage, this); break;
			}
			addChild(currentScreen.view);
		}
		
		/**
		 * Event to listen for user input to start or exit this game.
		 * @param e A Keyboard event
		 */
		private function onKeyDownListener(e:KeyboardEvent):void
		{
			var key:uint = e.keyCode;
			if(key == Keyboard.SPACE) {
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDownListener);
				this._highscore.lastScore = 0;
				loadScreen("play");
				Jukebox.getInstance().play(SoundFileEnum.START);
				this.game = new Game(this);
			} 
			else if(key == Keyboard.ESCAPE)
			{
				try {
					NativeApplication.nativeApplication.exit();
				}
				catch(e:Error)
				{
					fscommand("quit");
				}
			}
		}

		public function get currentScreen():IScreen
		{
			return _currentScreen;
		}

		public function set currentScreen(value:IScreen):void
		{
			_currentScreen = value;
		}
		
		public function get highscore():Highscore
		{
			return _highscore;
		}
		
		public function set highscore(value:Highscore):void
		{
			_highscore = value;
		}
	}
}