/**
 * @author Peter Hansen
 * @copyright p3337.de All rights reserved.
 */
package de.p3337.straightouttaspace.Views.Screens.HUD
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.Stage;
	
	public class PlayerLivesView extends Sprite
	{
		[Embed(source='/de/p3337/straightouttaspace/resources/spaceshooter/PNG/UI/playerLife3_blue.png')]
		private var LivesClass:Class;
		private var livesBitmap:Bitmap;
		
		private var stageRef:Stage;
		
		public function PlayerLivesView(stageRef:Stage)
		{
			super();

			this.stageRef = stageRef;
			
			graphics.beginFill(0xFF0000, 0);
			graphics.drawRect(0, 0, this.stageRef.stageWidth / 3, 30);
			graphics.endFill();
			
			livesBitmap = new LivesClass();
			updatePlayerLives(0);
		}
		
		public function updatePlayerLives(value:int):void
		{
			if(value < 0) value = 0;
			
			removeChildren();
			
			var bm:Bitmap;
			for(var i:uint = 0; i < value; i++)
			{
				bm = new Bitmap(livesBitmap.bitmapData);
				bm.width = 26;
				bm.height = 20;
				bm.x = 30 * i;
				addChild(bm);
			}
		}
		
		public function destroy():void
		{
			this.LivesClass = null;
			this.livesBitmap = null;
			this.stageRef = null;
			removeChildren();
		}
	}
}