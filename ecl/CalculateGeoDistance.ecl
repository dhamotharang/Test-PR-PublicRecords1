//-- Returns the distance in miles b/w two sets of Lat/Long

real q1(real longx1, real longx2) :=  cos(0.01745 * (longx1 - longx2));

real q2(real latx1, real latx2) := cos(0.01745 * (latx1 - latx2));

real q3(real latx1, real latx2) := cos(0.01745 * (latx1 + latx2));

export real CalculateGeoDistance(real latx1, real longx1, real latx2, real longx2) := 
 3963.3453 * acos ( ( (1 + q1(longx1, longx2)) * q2(latx1, latx2) - (1 - q1(longx1, longx2)) * q3(latx1, latx2)) / 2);
