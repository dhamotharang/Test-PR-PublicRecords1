//-- Returns the distance in miles b/w two sets of Lat/Long
REAL q1(REAL longx1, REAL longx2) :=  COS(0.01745 * (longx1 - longx2));
REAL q2(REAL latx1, REAL latx2) := COS(0.01745 * (latx1 - latx2));
REAL q3(REAL latx1, REAL latx2) := COS(0.01745 * (latx1 + latx2));
EXPORT REAL utLL_Dist(REAL latx1, REAL longx1, REAL latx2, REAL longx2) := 
 3963.3453 * ACOS(( (1 + q1(longx1, longx2)) * q2(latx1, latx2) - (1 - q1(longx1, longx2)) * q3(latx1, latx2)) / 2);
/*
double q1(double longx1, double longx2)
{
return cos(0.01745 * (longx1 - longx2));
}
double q2(double latx1, double latx2)
{
return cos(0.01745 * (latx1 - latx2));
}
double q3(double latx1, double latx2)
{
return cos(0.01745 * (latx1 + latx2));
}
double distance(double latx1, double longx1, double latx2, double longx2) 
{
return 3963.3453 * acos ( ( (1 + q1(longx1, longx2)) * q2(latx1, latx2) - (1 - q1(longx1, longx2)) * q3(latx1, latx2)) / 2);
}
*/
