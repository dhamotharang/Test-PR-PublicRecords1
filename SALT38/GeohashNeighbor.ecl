/*
  Find neighbor of a geohash string in certain direction. Direction is defined by direction0 and direction1
  where 1,0 means north, and -1,-1 means southwest.
	  INTEGER1 Dir0 := MAP ( dir IN ['N ','NE','NW'] => 1, dir IN ['S ','SW','SE'] => -1, 0 );
		INTEGER1 Dir1 := MAP ( dir IN ['E ','NE','SE'] => 1, dir IN ['W ','SW','NW'] => -1, 0 );
N  : 1,0
NE : 1,1
E  : 0,1
SE :-1,1
S  :-1,0
SW :-1,-1
W  : 0,-1
NW : 1,-1 
*/
EXPORT STRING GeohashNeighbor(STRING hash_string, INTEGER direction0, INTEGER direction1) := 
	//Fn_LatLongNeighbor(hash_string, direction0, direction1);
	saltlib.GeohashNeighbor(hash_string, direction0, direction1);
