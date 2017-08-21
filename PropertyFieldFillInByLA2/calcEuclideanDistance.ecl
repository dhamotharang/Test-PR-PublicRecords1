// Calculates distance in miles
EXPORT real calcEuclideanDistance( 
                                    string10 a_geo_lat
                                  , string11 a_geo_long
                                  , string10 b_geo_lat
                                  , string11 b_geo_long
                                 ) := FUNCTION
real Degrees2Radians( real degrees ) := FUNCTION
  real Deg2Rad := 0.0174532925199; //number of radians in a degree
return degrees * Deg2Rad;
END;
  real edistance := 
   sqrt( 
         power(69.1, 2) * power(((real)b_geo_lat - (real)a_geo_lat), 2) 
         + power((69.1*cos(Degrees2Radians((real)b_geo_lat))), 2) * power(((real)b_geo_long - (real)a_geo_long), 2)
		   );
return edistance;
END;
