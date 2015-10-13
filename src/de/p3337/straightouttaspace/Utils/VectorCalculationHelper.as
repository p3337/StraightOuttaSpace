/**
 * @author Peter Hansen
 * @copyright p3337.de All rights reserved.
 */
package de.p3337.straightouttaspace.Utils
{
	import flash.geom.Point;

	public class VectorCalculationHelper
	{
		public static function calcUnitVector(pointA:Point, pointB:Point):Point
		{
			var vector:Point = new Point(pointB.x - pointA.x, pointB.y - pointA.y);
			var factor:Number = calcVectorLength(vector);
			if(factor > 0)
			{
				vector.x /= factor;
				vector.y /= factor;
			}
			return vector; 
		}
		
		public static function calcVectorLength(point:Point):Number
		{
			return Math.sqrt(Math.pow(point.x, 2) + Math.pow(point.y, 2));
		}
		
		public static function calcDistanzBetween2Points(pointA:Point, pointB:Point):Number
		{
			return Math.sqrt(Math.pow(pointB.x - pointA.x, 2) + Math.pow(pointB.y - pointA.y, 2));
		}
	}
}