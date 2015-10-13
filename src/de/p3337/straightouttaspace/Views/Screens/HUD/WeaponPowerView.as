/**
 * @author Peter Hansen
 * @copyright p3337.de All rights reserved.
 */
package de.p3337.straightouttaspace.Views.Screens.HUD
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.Stage;
	
	public class WeaponPowerView extends Sprite
	{
		[Embed(source='/de/p3337/straightouttaspace/resources/spaceshooter/PNG/Lasers/laserBlue03.png')]
		private var WeaponClass:Class;
		private var weaponBitmap:Bitmap;
		
		private var stageRef:Stage;
		
		public function WeaponPowerView(stageRef:Stage)
		{
			super();
			
			this.stageRef = stageRef;
			
			graphics.beginFill(0xFF0000, 0);
			graphics.drawRect(0, 0, this.stageRef.stageWidth / 3, 30);
			graphics.endFill();
			
			weaponBitmap = new WeaponClass();
			updateWeaponPower(1);
		}
		
		public function updateWeaponPower(value:int):void
		{
			if(value < 0) value = 0;
			
			removeChildren();
			var bm:Bitmap;
			for(var i:int = value - 1; i >= 0; i--)
			{
				bm = new Bitmap(weaponBitmap.bitmapData);
				bm.width = 2;
				bm.height = 25;
				bm.x = this.width - (5 * i);
				addChild(bm);
			}
		}
		
		public function destroy():void
		{
			this.WeaponClass = null;
			this.weaponBitmap = null;
			this.stageRef = null;
			removeChildren();
		}
	}
}