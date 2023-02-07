package utils;

class Random{
    public static function randomRangeFloat(min:Float, max:Float):Float {
		return Math.floor(Math.random() * (1 + max - min)) + min;
	}
}