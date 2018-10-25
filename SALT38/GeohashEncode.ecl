/*
 Encode a pair of latitude and longitude into geohash. The third argument is optional, 
 you can specify a length of this hash string, which also affect on the precision of the geohash.
*/
EXPORT GeohashEncode(REAL latitude, REAL longitude, UNSIGNED precision=12) := 
	 saltlib.GeohashLatLongEncode(latitude, longitude, precision);
