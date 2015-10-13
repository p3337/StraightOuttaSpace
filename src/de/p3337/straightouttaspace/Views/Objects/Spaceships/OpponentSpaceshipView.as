/**
 * @author Peter Hansen
 * @copyright p3337.de All rights reserved.
 */
package de.p3337.straightouttaspace.Views.Objects.Spaceships
{
	import de.p3337.straightouttaspace.Objects.DrawableObject;
	import de.p3337.straightouttaspace.Views.Objects.DrawableObjectView;
	
	public class OpponentSpaceshipView extends DrawableObjectView
	{
		public function OpponentSpaceshipView(drawableObject:DrawableObject)
		{
			super(drawableObject);
			texture.rotation = 180;
			texture.scaleX = -1;
			texture.x -= texture.width / 2;
			texture.y += texture.height / 2;
		}
	}
}