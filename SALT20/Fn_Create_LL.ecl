export Fn_Create_LL(string lat,string long,unsigned divisions) := FUNCTION
r(string l) := (real)l;
pck(string l) := (real)truncate(r(l) * divisions) / divisions + (1 / (2 * divisions) * if(r(l) < 0.0,-1,1));
pad(string l) := (STRING10)pck(l);
good := r(lat) <= 90 and r(lat) >= -90 and r(long) >= -180 and r(long) <= 180 and (r(lat)<>0 or r(long)<>0);
return if ( good, pad(lat)+pad(long), '' );
end;
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
