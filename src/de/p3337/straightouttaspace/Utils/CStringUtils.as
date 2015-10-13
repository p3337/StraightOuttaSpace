/**
 * @author Peter Hansen
 * @copyright p3337.de All rights reserved.
 */
package de.p3337.straightouttaspace.Utils
{
	import flash.utils.describeType;

	/**
	 * A helper class for faking enums
	 * @see http://scottbilas.com/blog/faking-enums-in-as3/
	 */
	public class CStringUtils {
		
		/**
		 * Function to call for each enum type declared and in static init.
		 */
		public static function InitEnumConstants(inType:*):void {
			var type:XML = describeType(inType);
			for each (var constant:XML in type.constant)
			inType[constant.@name].Text = constant.@name;
		}
	}
}