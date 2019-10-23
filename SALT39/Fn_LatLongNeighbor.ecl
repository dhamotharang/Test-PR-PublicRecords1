/*
  Find neighbor of a geohash string in certain direction. Direction is defined by direction0 and direction1
  where 1,0 means north, and -1,-1 means southwest.
*/
EXPORT STRING Fn_LatLongNeighbor(STRING hash_string, INTEGER direction0, INTEGER direction1) := FUNCTION
	DecodedHash := {REAL latitude,REAL longitude,REAL latitude_err,REAL longitude_err};
	out := PROJECT(Fn_LatLongDecode(hash_string), 
		TRANSFORM(DecodedHash, SELF.latitude:=LEFT.latitude+direction0*LEFT.latitude_err*2,
		                       SELF.longitude:=LEFT.longitude+direction1*LEFT.longitude_err*2, SELF:=LEFT ));
RETURN Fn_LatLongEncode(out[1].latitude, out[1].longitude, LENGTH(TRIM(hash_string)));
END;
