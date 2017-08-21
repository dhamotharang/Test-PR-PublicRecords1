import doxie;
EXPORT MergeLatLong(ds,
						_st, _zip, _prim_name, _prim_range, _predir, _suffix, _geo_lat, _geo_long) := FUNCTIONMACRO

	d1 := DISTRIBUTE(ds(_geo_lat='' OR _geo_long=''),
										hash32(_st, _zip));
	
	geo := DISTRIBUTE(LatLongData, hash32(st, zip));
	
	d2 := JOIN(d1, geo, left._st=right.st AND left._zip=right.zip AND
							left._prim_name = right.prim_name AND left._prim_range=right.prim_range AND
							left._predir=right.predir AND left._suffix=right.addr_suffix, 
							TRANSFORM(Layout_2015,
								self._geo_lat := right.geo_lat;
								self._geo_long := right.geo_long;
								self := LEFT;), LEFT OUTER, KEEP(1), LOCAL);
								
	d2ok := d2(_geo_lat<>'',_geo_long<>'');
	d2notok := ds(_geo_lat='' OR _geo_long='');
	
//	d2fixed := PROJECT(d2notok, TRANSFORM(recordof(ds),
//								clean_address := '';

/*
					doxie.cleanaddress182( 
							IF( TRIM(LEFT.prim_range) != '', TRIM(LEFT.prim_range) + ' ', '' ) +
							IF( TRIM(LEFT.predir) != '', TRIM(LEFT.predir) + ' ', '' ) +
							IF( TRIM(LEFT.prim_name) != '', TRIM(LEFT.prim_name) + ' ', '' ) +
							IF( TRIM(LEFT.suffix) != '', TRIM(LEFT.suffix) + ' ', '' ) +
							IF( TRIM(LEFT.postdir) != '', TRIM(LEFT.postdir) + ' ', '' ) +
							IF( TRIM(LEFT.unit_desig) != '', TRIM(LEFT.unit_desig) + ' ', '' ) +
							IF( TRIM(LEFT.sec_range) != '', TRIM(LEFT.sec_range), '' )
							, 
							TRIM(LEFT.city_name) + ' ' + TRIM(LEFT.st) + ' ' + TRIM(LEFT.zip) 
							),*/
	
	

	d3 := ds(_geo_lat<>'',_geo_long<>'');
	d4 := d2 + d3;

	return d4;

ENDMACRO;