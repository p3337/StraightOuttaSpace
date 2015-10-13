/**
 * @author Peter Hansen
 * @copyright p3337.de All rights reserved.
 */
package de.p3337.straightouttaspace.Objects
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import de.p3337.straightouttaspace.Main.StraightOuttaSpace;
	import de.p3337.straightouttaspace.Sound.Jukebox;
	import de.p3337.straightouttaspace.Sound.SoundFileEnum;
	import de.p3337.straightouttaspace.Views.Screens.PlayScreen;

	/**
	 * The Game is the main class for creating a new game.
	 * 
	 * It has a Board which is containing the models like players and a
	 * spaceshipFactory of this game.
	 * 
	 * It has two timers: On for constantly updating the game logic and one to 
	 * refresh the graphical representation.
	 */
	public class Game
	{
		private var logicTimer:Timer;
		private var graphicTimer:Timer;
		
		private var _main:StraightOuttaSpace;
		private var _board:Board;
		private var _screen:PlayScreen;
		private var _isPaused:Boolean;
		private var _level:uint;
		
		private var _isGameOver:Boolean;
		
		public function Game(main:StraightOuttaSpace)
		{
			this._main = main;
			this._screen = (main.currentScreen as PlayScreen);
			this._screen.game = this;
			this._isPaused = false;
			this._level = 1;
			this._isGameOver = false;
			this._board = new Board(this);
			
			// create Timer
			logicTimer = new Timer(1000 / (this._main.stage.frameRate));
			logicTimer.addEventListener(TimerEvent.TIMER, onLogicTimer);
			
			graphicTimer = new Timer(1000 / this._main.stage.frameRate);
			graphicTimer.addEventListener(TimerEvent.TIMER, onGraphicTimer);
			
			logicTimer.start();
			graphicTimer.start();
		}
		
		protected function onLogicTimer(event:TimerEvent):void
		{
			if(this._isGameOver)
			{
				Jukebox.getInstance().play(SoundFileEnum.LOSE);
				this._main.initializeScreen(this._isGameOver);
			}
			else if(!isPaused)
			{
				this._board.update();
			}
		}
		
		protected function onGraphicTimer(event:TimerEvent):void
		{
			if(!isPaused)
			{
				this._main.currentScreen.update();
			}
		}

		public function get board():Board
		{
			return _board;
		}
		
		public function get main():StraightOuttaSpace
		{
			return _main;
		}

		public function get screen():PlayScreen
		{
			return _screen;
		}

		public function get isPaused():Boolean
		{
			return _isPaused;
		}

		public function set isPaused(value:Boolean):void
		{
			_isPaused = value;
		}

		public function get level():uint
		{
			return _level;
		}

		public function set level(value:uint):void
		{
			_level = value;
		}
		
		public function get isGameOver():Boolean
		{
			return _isGameOver;
		}
		
		public function set isGameOver(value:Boolean):void
		{
			_isGameOver = value;
		}
		
		/**
		 * Destroys this object.
		 */
		public function destroy():void
		{
			this.logicTimer.stop();
			this.logicTimer.removeEventListener(TimerEvent.TIMER, onLogicTimer);
			this.logicTimer = null;
			this.graphicTimer.stop();
			this.graphicTimer.removeEventListener(TimerEvent.TIMER, onGraphicTimer);
			this.graphicTimer = null;
			this._board.destroy();
			this._board = null;
			this._screen = null;
			this._main = null;
		}
	}
}