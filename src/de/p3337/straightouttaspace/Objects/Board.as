/**
 * @author Peter Hansen
 * @copyright p3337.de All rights reserved.
 */
package de.p3337.straightouttaspace.Objects
{
	import de.p3337.straightouttaspace.Objects.Players.Opponent;
	import de.p3337.straightouttaspace.Objects.Players.Player;
	import de.p3337.straightouttaspace.Objects.Spaceships.SpaceshipFactory;

	/**
	 * The Board is the main model containing all further models to create a
	 * vertical scrolling shooter like players and a spaceshipFactory of this game.
	 */
	public class Board
	{
		private var _parent:Game;
		private var _spaceshipFactory:SpaceshipFactory;
		
		// players
		private var _player:Player;
		private var _opponent:Opponent;
		
		public function Board(parent:Game)
		{
			this._parent = parent;
			this._spaceshipFactory = new SpaceshipFactory(this);
			this._player = new Player(this, this._spaceshipFactory);
			this._player.createSpaceships();
			this._opponent = new Opponent(this, this._spaceshipFactory);
			this._opponent.createSpaceships();
		}
		
		/**
		 * Initiated by the game's logic timer.
		 */
		public function update():void
		{
			this._player.update();
			this._opponent.update();
		}
		
		public function get player():Player
		{
			return _player;
		}
		
		public function get opponent():Opponent
		{
			return _opponent;
		}
		
		public function get parent():Game
		{
			return _parent;
		}
		
		public function get spaceshipFactory():SpaceshipFactory
		{
			return _spaceshipFactory;
		}
		
		/**
		 * Destroys this object.
		 */
		public function destroy():void
		{
			this._spaceshipFactory.destroy();
			this._spaceshipFactory = null;
			this._player.destroy();
			this._player = null;
			this._opponent.destroy();
			this._opponent = null;
			this._parent = null;
		}
	}
}