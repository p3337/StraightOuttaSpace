/**
 * @author Peter Hansen
 * @copyright p3337.de All rights reserved.
 */
package de.p3337.straightouttaspace.Views.Screens.ScrollingStars
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import de.p3337.straightouttaspace.Utils.SizeEnum;
	import de.p3337.straightouttaspace.Views.Screens.IScreen;
	
	public class ScrollingStarsScreen implements IScreen
	{
		private var _view:Sprite = new Sprite();
		
		private var stage:Stage;
		
		private var bitmap:Bitmap;
		private var bitmapData:BitmapData;
		
		private var width:uint;
		private var height:uint;
		private var bgColor:uint;
		private var speed:uint;
		private var starPos:Point;
		
		private var numberOfStars:uint;
		private var starSizesVector:Vector.<StarBitmapData>;
		private var starVector:Vector.<Rectangle>;
		
		public function ScrollingStarsScreen(stage:Stage, numberOfStars:uint = 100)
		{
			this.stage = stage;
			this.width = stage.stageWidth;
			this.height = stage.stageHeight;
			this.numberOfStars = numberOfStars;
			this.bgColor = 0x00000000;
			this.speed = 2;
			this.starPos = new Point();
			
			createDifferentStarSizes();
			fillStarArray();
			
			this.bitmapData = new BitmapData(this.width, this.height, true, this.bgColor);
			this.bitmap = new Bitmap(this.bitmapData);
			_view.addChild(this.bitmap);
			_view.mouseChildren = false;
			_view.mouseEnabled = false;
			
			update();
		}
		
		private function createDifferentStarSizes():void
		{
			this.starSizesVector = new Vector.<StarBitmapData>(SizeEnum.count(), true);
			var sizes:Array = SizeEnum.toArray();
			for (var i:uint = 0; i < this.starSizesVector.length; i++)
			{
				this.starSizesVector[i] = new StarBitmapData(sizes[i], this.bgColor);
			}
		}
		
		private function fillStarArray():void
		{
			this.starVector = new Vector.<Rectangle>(this.numberOfStars, true);
			var x:Number = 5;
			var y:Number = 5;
			var size:Number = 1;
			
			var i:uint = 0;
			while (i < this.numberOfStars) {
				this.starVector[i] = new Rectangle(x, y, size, size);;
				x = Math.random() * this.width;
				y = Math.random() * this.height;
				size = (Math.round((Math.random() * 2)) + 1);
				i++;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function get view():Sprite
		{
			return _view;
		}
		
		/**
		 * @inheritDoc
		 */
		public function update():void
		{
			var size:uint = 0;
			var offset:Number = 0;
			
			// clear bitmapdata
			this.bitmapData.fillRect(bitmapData.rect, 0);
			
			// lock screen holding bitmapdata and render stars
			this.bitmapData.lock();
			var i:uint = 0;
			var rec:Rectangle;
			while (i < this.numberOfStars) {
				rec = this.starVector[i];
				size = (rec.width - 1);
				this.starPos.x = rec.x;
				this.starPos.y = rec.y;
				this.bitmapData.copyPixels(this.starSizesVector[size], this.starSizesVector[size].rect, this.starPos, null, null, true);
				if (rec.y < -10){
					rec.y = (this.height + 10);
					this.changeSize(i);
				} else {
					if (rec.y > (this.height + 10)){
						rec.y = -10;
						this.changeSize(i);
					};
				};
				offset = (this.speed + (this.speed * (size * 0.5)));
				rec.y = (rec.y + offset);
				i++;
			}
			
			// unlock screen
			this.bitmapData.unlock();
		}
		
		private function changeSize(pos:int):void
		{
			var newSize:int = (Math.round((Math.random() * 2)) + 1);
			this.starVector[pos].width = newSize;
			this.starVector[pos].height = newSize;
		}
		
		/**
		 * @inheritDoc
		 */
		public function destroy():void {
			this.bitmapData.dispose();
			this.bitmap = null;
			this._view.removeChildren();
			this.starSizesVector = null;
			this.starVector = null;
			this.stage = null;
		}
	}
}