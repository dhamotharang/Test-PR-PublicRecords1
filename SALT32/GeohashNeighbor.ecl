/*
  Find neighbor of a geohash string in certain direction. Direction is defined by direction0 and direction1
  where 1,0 means north, and -1,-1 means southwest.
*/
EXPORT STRING GeohashNeighbor(STRING hash_string, INTEGER direction0, INTEGER direction1) := 
	Fn_LatLongNeighbor(hash_string, direction0, direction1);
	//saltlib.GeohashNeighbor(hash_string, direction0, direction1);
