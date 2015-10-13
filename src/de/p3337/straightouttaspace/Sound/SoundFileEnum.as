/**
 * @author Peter Hansen
 * @copyright p3337.de All rights reserved.
 */
package de.p3337.straightouttaspace.Sound
{
	import de.p3337.straightouttaspace.Utils.CStringUtils;
	
	/**
	 * This class provides a list of all available sound files that can be passed to the Jukebox:
	 * FIRE, PAUSE, RESUME, LOSE, START
	 */
	public class SoundFileEnum {
		
		public var Text:String;
		{CStringUtils.InitEnumConstants(SoundFileEnum);} // static ctor
		
		public static const FIRE:SoundFileEnum = new SoundFileEnum();
		public static const PAUSE:SoundFileEnum = new SoundFileEnum();
		public static const RESUME:SoundFileEnum = new SoundFileEnum();
		public static const LOSE:SoundFileEnum = new SoundFileEnum();
		public static const START:SoundFileEnum = new SoundFileEnum();
	}
}