/*
 * This function calculates the Geographical distance in miles between two
 * latitude/longitude points.  This caps the distance at 9999.
 */

IMPORT ut;

EXPORT UNSIGNED2 calculateGeoDistance (REAL latitude1, REAL longitude1, REAL latitude2, REAL longitude2) := FUNCTION
	distance := ROUND(ut.LL_Dist(latitude1, longitude1, latitude2, longitude2));
	
	final := IF(distance > 9999, 9999, distance);
	
	RETURN(final);
END;