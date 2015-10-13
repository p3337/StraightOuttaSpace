/**
 * @author Peter Hansen
 * @copyright p3337.de All rights reserved.
 */
package de.p3337.straightouttaspace.Views.Screens
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.text.AntiAliasType;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import de.p3337.straightouttaspace.Main.StraightOuttaSpace;

	public class GameOverScreen implements IScreen
	{
		private var _view:Sprite = new Sprite();
		private var stage:Stage;
		private var main:StraightOuttaSpace;
		
		public function GameOverScreen(stage:Stage, main:StraightOuttaSpace)
		{
			this.stage = stage;
			this.main = main;
			draw();
		}
		
		private function draw():void
		{
			// draw background image 
			[Embed(source='/de/p3337/straightouttaspace/resources/spaceshooter/Backgrounds/darkPurple.png')]
			var BgImageClass:Class;
			var bgImage:Bitmap = new BgImageClass();
			_view.graphics.beginBitmapFill(bgImage.bitmapData);
			_view.graphics.drawRect(0, 0, this.stage.stageWidth, this.stage.stageHeight);
			_view.graphics.endFill();
			
			// add title image
			var gameOverLabelSheet:StyleSheet = new StyleSheet();
			gameOverLabelSheet.setStyle(".label", {color:'#FFFFFF', fontWeight:'bold', fontSize:'50', fontFamily:'Courier New'});
			
			var gameOverLabel:TextField = new TextField();
			gameOverLabel.styleSheet = gameOverLabelSheet;
			gameOverLabel.htmlText = "<span class='label'>GAME OVER</span>";
			gameOverLabel.x = stage.stageWidth / 2 - gameOverLabel.textWidth / 2;
			gameOverLabel.y = stage.stageHeight / 4;
			gameOverLabel.antiAliasType = AntiAliasType.ADVANCED;
			gameOverLabel.autoSize = TextFieldAutoSize.LEFT;
			gameOverLabel.mouseEnabled = false;
			_view.addChild(gameOverLabel);
			
			var myScoreLabelSheet:StyleSheet = new StyleSheet();
			myScoreLabelSheet.setStyle(".label", {color:'#FFFFFF', fontWeight:'bold', fontSize:'22', fontFamily:'Courier New'});
			
			var myScoreLabel:TextField = new TextField();
			myScoreLabel.styleSheet = myScoreLabelSheet;
			myScoreLabel.htmlText = "<span class='label'>Your score: "+ main.highscore.lastScore +"</span>";
			myScoreLabel.height = 25;
			myScoreLabel.x = stage.stageWidth / 2 - myScoreLabel.width / 2;
			myScoreLabel.y = gameOverLabel.y + gameOverLabel.height + StraightOuttaSpace.SOS_PADDING;
			myScoreLabel.antiAliasType = AntiAliasType.ADVANCED;
			myScoreLabel.autoSize = TextFieldAutoSize.CENTER;
			myScoreLabel.mouseEnabled = false;
			_view.addChild(myScoreLabel);
			
			var highScoreLabel:TextField = new TextField();
			highScoreLabel.styleSheet = myScoreLabelSheet;
			highScoreLabel.htmlText = "<span class='label'>High Score: "+ main.highscore.getScore() +"</span>";
			highScoreLabel.height = 30;
			highScoreLabel.x = stage.stageWidth / 2 - highScoreLabel.width / 2;
			highScoreLabel.y = myScoreLabel.y + myScoreLabel.height + StraightOuttaSpace.SOS_PADDING / 2;
			highScoreLabel.antiAliasType = AntiAliasType.ADVANCED;
			highScoreLabel.autoSize = TextFieldAutoSize.CENTER;
			highScoreLabel.mouseEnabled = false;
			_view.addChild(highScoreLabel);
			
			// add start text
			[Embed(source='/de/p3337/straightouttaspace/resources/HitSpaceTextTween.swf')]
			var HitSpaceTextTweenClass:Class;
			var hitSpaceTextTweenAsset:MovieClip = new HitSpaceTextTweenClass();
			hitSpaceTextTweenAsset.x = stage.stageWidth / 2 - hitSpaceTextTweenAsset.width / 2;
			hitSpaceTextTweenAsset.y = highScoreLabel.y + highScoreLabel.height + StraightOuttaSpace.SOS_PADDING;
			hitSpaceTextTweenAsset.mouseChildren = false;
			_view.addChild(hitSpaceTextTweenAsset);
		}
		
		/**
		 * @inheritDoc
		 */
		public function update():void {}
		
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
		public function destroy():void {
			this._view.removeChildren();
			this.stage = null;
			this.main = null;
		}
	}
}