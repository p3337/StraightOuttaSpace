/**
 * @author Peter Hansen
 * @copyright p3337.de All rights reserved.
 */
package de.p3337.straightouttaspace.Views.Objects.Weapons
{
	import de.p3337.straightouttaspace.Objects.DrawableObject;
	import de.p3337.straightouttaspace.Views.Objects.DrawableObjectView;
	
	public class BlueLaserView extends DrawableObjectView
	{	
		public function BlueLaserView(drawableObject:DrawableObject)
		{
			super(drawableObject);
			
			texture.x -= texture.width / 2;
			texture.y -= texture.height / 2;
		}
	}
}