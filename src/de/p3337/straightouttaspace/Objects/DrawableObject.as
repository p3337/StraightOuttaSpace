/**
 * @author Peter Hansen
 * @copyright p3337.de All rights reserved.
 */
package de.p3337.straightouttaspace.Objects
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	
	import de.p3337.straightouttaspace.Utils.Dimensions;

	/**
	 * The DrawableObject is the basic class for all classes that have visual
	 * representations and will be drawn on the "PlayScreen". 
	 * These representation have to extend the DrawableObjectView class. 
	 */
	public class DrawableObject
	{
		protected var _position:Point;
		protected var _texture:Bitmap;
		protected var _dimensions:Dimensions;
		protected var _rotation:Number;
		protected var _scaleX:Number;
		protected var _toBeDestroyed:Boolean; 
		
		public function DrawableObject(position:Point, dimensions:Dimensions)
		{
			this._position = position;
			this._dimensions = dimensions;
			this._rotation = 0;
			this._scaleX = 1;
			this._toBeDestroyed = false;
		}
		
		/**
		 * Initiated by the game's logic timer.
		 */
		public function update():void {}
		
		public function get position():Point
		{
			return _position;
		}
		
		public function get dimensions():Dimensions
		{
			return _dimensions;
		}
		
		public function set position(value:Point):void
		{
			_position = value;
		}

		public function get rotation():Number
		{
			return _rotation;
		}

		public function set rotation(value:Number):void
		{
			_rotation = value;
		}

		public function get scaleX():Number
		{
			return _scaleX;
		}

		public function set scaleX(value:Number):void
		{
			_scaleX = value;
		}

		public function get toBeDestroyed():Boolean
		{
			return _toBeDestroyed;
		}

		public function set toBeDestroyed(value:Boolean):void
		{
			_toBeDestroyed = value;
		}
		
		public function get texture():Bitmap
		{
			return _texture;
		}
		
		public function set texture(value:Bitmap):void
		{
			_texture = value;
		}
	}
}