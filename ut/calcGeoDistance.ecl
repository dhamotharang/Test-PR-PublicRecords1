import Address;
/* 

EXAMPLE USAGE
z1:='600102112';
z2:='600930001';
d := calcGeoDistance( z1, z2 );

name := 'Distance_between_'+z1+'_and_'+z2;
output(d,named(name));

This function outputs distance (in miles) between the 2
inputted 9 digit zip codes, i.e. zip_zip4.

No check is made to assure inputs are in the correct
format.
*/

getLatLon( string zip9 ) := FUNCTION
x := Address.Zip9toGeo34(zip9);
set of real set_x := [ (real) x[1..10], (real) x[11..20]];
return set_x;
END;

export calcGeoDistance( string zip9_1, string zip9_2 ) := FUNCTION

zip9_1a := trim(zip9_1,left,right);
zip9_2a := trim(zip9_2,left,right);
z1 := IF(length(zip9_1a)=9,zip9_1a,IF(length(zip9_1a)=5, zip9_1a+'0000', ''));
z2 := IF(length(zip9_2a)=9,zip9_2a,IF(length(zip9_2a)=5, zip9_2a+'0000', ''));

x := getLatLon( z1 );

y := getLatLon( z2 );

dist := ut.ll_dist(x[1], x[2], y[1], y[2]);
return IF((length(z1)<>9) or (length(z2)<>9), 9999999999, dist);
END;
