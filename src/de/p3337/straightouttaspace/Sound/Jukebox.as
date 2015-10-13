/**
 * @author Peter Hansen
 * @copyright p3337.de All rights reserved.
 */
package de.p3337.straightouttaspace.Sound
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	import de.p3337.straightouttaspace.Sound.SoundFileEnum;
	
	/**
	 * This class provides a global playback to sound all effects.
	 */
	public final class Jukebox {
		
		private static var _instance:Jukebox;
		
		[Embed(source="de/p3337/straightouttaspace/resources/spaceshooter/Bonus/sfx_laser2.mp3")]
		private var LaserClass:Class;
		private var laserSound:Sound;
		
		[Embed(source="de/p3337/straightouttaspace/resources/spaceshooter/Bonus/sfx_twoTone.mp3")]
		private var PauseClass:Class;
		private var pauseSound:Sound;
		
		[Embed(source="de/p3337/straightouttaspace/resources/spaceshooter/Bonus/sfx_twoTone_rev.mp3")]
		private var ResumeClass:Class;
		private var resumeSound:Sound;
		
		[Embed(source="de/p3337/straightouttaspace/resources/spaceshooter/Bonus/sfx_lose.mp3")]
		private var LoseClass:Class;
		private var loseSound:Sound;
		
		[Embed(source="de/p3337/straightouttaspace/resources/plasterbrain-start.mp3")]
		private var StartClass:Class;
		private var startSound:Sound;
		
		// This game uses these sounds from freesound:
		// sound1 by user1 ( http://freesound.org/people/user1/ )
		
		private var soundChannel:SoundChannel;
		
		private var currentSoundFile:SoundFileEnum;
		
		public function Jukebox() {
			if(_instance){
				throw new Error("Singleton... use getInstance()");
			} 
			_instance = this;
			
			soundChannel = new SoundChannel();
			
			initSounds();
		}
		
		public static function getInstance():Jukebox {
			if(!_instance){
				new Jukebox();
			} 
			return _instance;
		}
		
		private function initSounds():void {
			laserSound = new LaserClass();
			pauseSound = new PauseClass();
			resumeSound = new ResumeClass();
			loseSound = new LoseClass();
			startSound = new StartClass();
		}
		
		public function play(soundFile:SoundFileEnum):void {
			currentSoundFile = soundFile;
			
			switch(soundFile) {
				case SoundFileEnum.FIRE:
					soundChannel = laserSound.play();
					break;
				case SoundFileEnum.PAUSE:
					soundChannel = pauseSound.play();
					break;
				case SoundFileEnum.RESUME:
					soundChannel = resumeSound.play();
					break;
				case SoundFileEnum.LOSE:
					soundChannel = loseSound.play();
					break;
				case SoundFileEnum.START:
					soundChannel = startSound.play();
					break;
			}
		}
		
		public function stop():void {
			soundChannel.stop();
		}
	}
}