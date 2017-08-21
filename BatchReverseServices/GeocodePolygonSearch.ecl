IMPORT Advo,ut;

EXPORT GeocodePolygonSearch(
	DATASET(GeocodeSearch_Layouts.LatLong) in_points) := FUNCTION
	
	temp_mod := module(GeocodeSearch_Interfaces.Records)
		EXPORT BOOLEAN exclude_persons := FALSE : STORED('ExcludePersons');             // Includes people in the output.
		EXPORT BOOLEAN exclude_businesses := FALSE : STORED('ExcludeBusinesses');          // Includes businesses in the output.
		
		EXPORT UNSIGNED3 dt_range_start := 0 : STORED('DateRangeStart');                // YYYYMM format, or 0.
		EXPORT UNSIGNED3 dt_range_end := 0 : STORED('DateRangeEnd');                  // YYYYMM format, or 0.
		
		EXPORT BOOLEAN exclude_if_match_is_best := FALSE : STORED('ExcludeIfMatchIsBest');    // Don't return if the found record matches best record
		EXPORT BOOLEAN exclude_if_match_isnt_best := FALSE : STORED('ExcludeIfMatchIsntBest');  // Don't return if the found record doesn't match best record
	end;
	
	// Get the extrema first
	real min_latitude  := MIN(in_points,latitude);
	real max_latitude  := MAX(in_points,latitude);
	real min_longitude := MIN(in_points,longitude);
	real max_longitude := MAX(in_points,longitude);

	// Need to turn the points into a shape... so we copy the first point down to the bottom and then iterate
	points_plus_counter := PROJECT(in_points,TRANSFORM(
		{GeocodeSearch_Layouts.LatLong ll1;GeocodeSearch_Layouts.LatLong ll2;unsigned seq;},
		SELF.seq := COUNTER,
		SELF.ll2 := LEFT,
		SELF := []));
	
	copy_first_record := PROJECT(points_plus_counter(seq = 1),TRANSFORM(
		RECORDOF(points_plus_counter),
		SELF.seq := LEFT.seq + count(points_plus_counter),
		SELF := LEFT));
	
	all_points := SORT(points_plus_counter + copy_first_record,seq);
	
	line_segments := ITERATE(all_points,TRANSFORM(
		RECORDOF(all_points),
		SELF.ll1 := LEFT.ll2,
		SELF.ll2 := RIGHT.ll2,
		SELF := RIGHT))[2..];
	
	// Prep the ADVO file by DEDUPing down to one record per address
	advo_prep := DEDUP(SORT(
		DISTRIBUTE(Advo.Files().File_Cleaned_Base(
			(real)geo_lat between min_latitude and max_latitude and
			(real)geo_long between min_longitude and max_longitude),
			HASH64(zip,zip4,prim_name,addr_suffix,predir,postdir,prim_range,sec_range)),
		zip,zip4,prim_name,addr_suffix,predir,postdir,prim_range,sec_range,geo_match,-date_last_seen,record,local),
		zip,zip4,prim_name,addr_suffix,predir,postdir,prim_range,sec_range,local);
	
	// Find all addresses, inside our extrema box, where a line drawn in one direction from them will
	// pass through one of the line segments.  This helps us to calculate "insideness".
	pre_matching_addresses := JOIN(
		advo_prep,
		line_segments,
		((right.ll2.longitude - right.ll1.longitude) / (right.ll2.latitude - right.ll1.latitude) * ((real)left.geo_lat - right.ll1.latitude)) + right.ll1.longitude > (real)left.geo_long and
		((real)left.geo_lat between right.ll1.latitude and right.ll2.latitude or (real)left.geo_lat between right.ll2.latitude and right.ll1.latitude),
		transform(left),
		lookup,all);
	
	// Only those addresses where a ray passes through an odd number of line segments should be counted.
	matching_addresses := table(pre_matching_addresses,
		{zip,zip4,prim_name,addr_suffix,predir,postdir,prim_range,sec_range,geo_lat,geo_long,geo_match,cnt:=count(group)},
		zip,zip4,prim_name,addr_suffix,predir,postdir,prim_range,sec_range,geo_lat,geo_long,geo_match)(cnt % 2 = 1);
	
	// Records
	matching_records := GeocodeSearch_Records(PROJECT(matching_addresses,TRANSFORM(
		GeocodeSearch_Layouts.Address,
		SELF.geo_lat := (REAL)LEFT.geo_lat,
		SELF.geo_long := (REAL)LEFT.geo_long,
		SELF := LEFT)),temp_mod);
	
	RETURN matching_records;
	
END;
