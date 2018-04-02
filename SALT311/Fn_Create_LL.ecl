EXPORT Fn_Create_LL(StrType lat,StrType long,UNSIGNED divisions) := FUNCTION
  r(StrType l) := (REAL)l;
  pck(StrType l) := (REAL)TRUNCATE(r(l) * divisions) / divisions + (1 / (2 * divisions) * IF(r(l) < 0.0,-1,1));
  pad(StrType l) := (Str10Type)(StrType)pck(l);
  good := r(lat) <= 90 AND r(lat) >= -90 AND r(long) >= -180 AND r(long) <= 180 AND (r(lat)<>0 OR r(long)<>0);
  RETURN IF ( good, pad(lat)+pad(long), '' );
END;
/* From l'hereux
	projected_inrecs := project(inrecs,transform(temp_georecs,
		self.lat := (real)left.geo_lat,
		self.long := (real)left.geo_long));
		
	// filter out bad data
	filtered_inrecs := projected_inrecs(
		lat >= -90.0 and lat <= 90.0 and long >= -180.0 and long <= 180.0 and
		(lat != 0.0 or long != 0.0));
	
	// now, grid these up
	gridded_inrecs := project(filtered_inrecs,transform(temp_georecs,
		self.lat := (real)truncate(left.lat * divisions) / divisions + (1 / (2 * divisions) * if(left.lat < 0.0,-1,1)),
		self.long := (real)truncate(left.long * divisions) / divisions + (1 / (2 * divisions) * if(left.long < 0.0,-1,1))));
*/
