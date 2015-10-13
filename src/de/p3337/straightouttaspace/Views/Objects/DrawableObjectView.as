/**
 * @author Peter Hansen
 * @copyright p3337.de All rights reserved.
 */
package de.p3337.straightouttaspace.Views.Objects
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	import de.p3337.straightouttaspace.Objects.DrawableObject;
	
	/**
	 * The DrawableObjectView is the basic class for all view classes that have 
	 * logical game object representations. 
	 * These representation have to extend the DrawableObject class. 
	 */
	public class DrawableObjectView extends Sprite implements IDrawableObjectView
	{
		protected var _drawableObject:DrawableObject;
		protected var _texture:Bitmap;
		
		public function DrawableObjectView(drawableObject:DrawableObject)
		{
			super();
			this._drawableObject = drawableObject;
			this._texture = drawableObject.texture;
			addChild(this.texture);
		}
		
		/**
		 * @inheritDoc
		 */
		public function update():void {
			if(this._drawableObject != null) {
				x = this._drawableObject.position.x;
				y = this._drawableObject.position.y;
				width = this._drawableObject.dimensions.width;
				height = this._drawableObject.dimensions.height;
			}
		}

		public function get drawableObject():DrawableObject
		{
			return _drawableObject;
		}
		
		public function get texture():Bitmap
		{
			return _texture;
		}
		
		/**
		 * @inheritDoc
		 */
		public function destroy():void
		{	
			try {
				removeChild(this.texture);
			} catch(e:Error) {
				trace(e);
			}
			this._texture = null;
			this._drawableObject = null;
		}
	}
}