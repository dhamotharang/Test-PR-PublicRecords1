IMPORT BatchReverseServices, Header,Watchdog,Business_Header;

// This attribute accepts a set of addresses and returns the pertinent information
EXPORT DATASET(Layouts_census.Final) georges_GeocodeSearch_Records(
	DATASET(Layouts_census.Address) in_addresses,
	Census_Options in_options) := FUNCTION
	
	// First, distribute, sort, and dedup the addresses
	deduped_addresses := DEDUP(SORT(
		DISTRIBUTE(in_addresses,HASH64((STRING5)zip,(STRING4)zip4,(STRING28)prim_name,(STRING10)prim_range,(STRING8)sec_range)),
		zip,zip4,prim_name,prim_range,sec_range,LOCAL),
		zip,zip4,prim_name,prim_range,sec_range,LOCAL);
	
	// Next, join the addresses to the person header
	person_records := JOIN(
		deduped_addresses,
		DISTRIBUTE(Header.File_Headers,HASH64((STRING5)zip,(STRING4)zip4,(STRING28)prim_name,(STRING10)prim_range,(STRING8)sec_range)),
		LEFT.zip = RIGHT.zip AND
		LEFT.zip4 = RIGHT.zip4 AND
		LEFT.prim_name = RIGHT.prim_name AND
		LEFT.prim_range = RIGHT.prim_range AND
		LEFT.sec_range = RIGHT.sec_range AND
		(in_options.dt_range_end = 0 OR RIGHT.dt_first_seen <= in_options.dt_range_end) AND
		(in_options.dt_range_start = 0 OR RIGHT.dt_last_seen >= in_options.dt_range_start),
		TRANSFORM(Layouts_census.Final,
			SELF.bi_ind := 'I',
			SELF.id := RIGHT.did,
			SELF.company_name := '',
			SELF.geo_lat := LEFT.geo_lat,
			SELF.geo_long := LEFT.geo_long,
			SELF.geo_match := LEFT.geo_match,
			SELF.dob := (STRING8)RIGHT.dob,
			SELF := RIGHT,
			SELF := []),
		LOCAL);
	
	// Join the person data to get best info.
	//warning('LHEUREUX: Not sure if Watchdog.File_Best_nonglb is correct.'); this is ok
	person_records_plus_best := JOIN(
		DISTRIBUTE(person_records,HASH64(id)),
		DISTRIBUTE(Watchdog.File_Best,HASH64(did)),
		LEFT.id = RIGHT.did,
		TRANSFORM(Layouts_census.Final,
			SELF.ssn := RIGHT.ssn,
			SELF.dob := IF( RIGHT.dob = 0, '', (STRING8)RIGHT.dob ),
			SELF.dod := RIGHT.dod,
			SELF.same_address :=
				LEFT.zip = RIGHT.zip AND LEFT.zip4 = RIGHT.zip4 AND
				LEFT.prim_name = RIGHT.prim_name AND 
				LEFT.prim_range = RIGHT.prim_range AND 
				LEFT.sec_range = RIGHT.sec_range,
			SELF.best_title := RIGHT.title,
			SELF.best_fname := RIGHT.fname,
			SELF.best_mname := RIGHT.mname,
			SELF.best_lname := RIGHT.lname,
			SELF.best_name_suffix := RIGHT.name_suffix,
			SELF.best_prim_range := RIGHT.prim_range,
			SELF.best_predir := RIGHT.predir,
			SELF.best_prim_name := RIGHT.prim_name,
			SELF.best_suffix := RIGHT.suffix,
			SELF.best_postdir := RIGHT.postdir,
			SELF.best_unit_desig := RIGHT.unit_desig,
			SELF.best_sec_range := RIGHT.sec_range,
			SELF.best_city_name := RIGHT.city_name,
			SELF.best_st := RIGHT.st,
			SELF.best_zip := RIGHT.zip,
			SELF.best_zip4 := RIGHT.zip4,
			SELF := LEFT),
		LOCAL);
	
	// Now, join the addresses to the business header
	business_records := JOIN(
		deduped_addresses,
		DISTRIBUTE(Business_Header.File_Business_Header_Base_Plus,HASH64((STRING5)INTFORMAT(zip,5,1),(STRING4)INTFORMAT(zip4,4,1),(STRING28)prim_name,(STRING10)prim_range,(STRING8)sec_range)),
		LEFT.zip = INTFORMAT(RIGHT.zip,5,1) AND
		LEFT.zip4 = INTFORMAT(RIGHT.zip4,4,1) AND
		LEFT.prim_name = RIGHT.prim_name AND
		LEFT.prim_range = RIGHT.prim_range AND
		LEFT.sec_range = RIGHT.sec_range AND
		(in_options.dt_range_end = 0 OR RIGHT.dt_first_seen DIV 100 <= in_options.dt_range_end) AND
		(in_options.dt_range_start = 0 OR RIGHT.dt_last_seen DIV 100 >= in_options.dt_range_start),
		TRANSFORM(Layouts_census.Final,
			SELF.bi_ind := 'B',
			SELF.id := RIGHT.bdid,
			SELF.title := '',
			SELF.fname := '',
			SELF.mname := '',
			SELF.lname := '',
			SELF.name_suffix := '',
			SELF.suffix := RIGHT.addr_suffix,
			SELF.city_name := RIGHT.city,
			SELF.st := RIGHT.state,
			SELF.zip := INTFORMAT(RIGHT.zip,5,1),
			SELF.zip4 := INTFORMAT(RIGHT.zip4,4,1),
			SELF.geo_lat := LEFT.geo_lat,
			SELF.geo_long := LEFT.geo_long,
			SELF.geo_match := LEFT.geo_match,
			SELF := RIGHT,
			SELF := []),
		LOCAL);

	// Join the business data to get best info.
	business_records_plus_best := JOIN(
		DISTRIBUTE(business_records,HASH64(id)),
		DISTRIBUTE(Business_Header.File_Business_Header_Best_Plus,HASH64(bdid)),
		LEFT.id = RIGHT.bdid,
		TRANSFORM(Layouts_census.Final,
			SELF.same_address :=
				LEFT.zip = INTFORMAT(RIGHT.zip,5,1) AND LEFT.zip4 = INTFORMAT(RIGHT.zip4,4,1) AND
				LEFT.prim_name = RIGHT.prim_name AND LEFT.prim_range = RIGHT.prim_range AND LEFT.sec_range = RIGHT.sec_range,
			SELF.best_company_name := RIGHT.company_name,
			SELF.best_prim_range := RIGHT.prim_range,
			SELF.best_predir := RIGHT.predir,
			SELF.best_prim_name := RIGHT.prim_name,
			SELF.best_suffix := RIGHT.addr_suffix,
			SELF.best_postdir := RIGHT.postdir,
			SELF.best_unit_desig := RIGHT.unit_desig,
			SELF.best_sec_range := RIGHT.sec_range,
			SELF.best_city_name := RIGHT.city,
			SELF.best_st := RIGHT.state,
			SELF.best_zip := INTFORMAT(RIGHT.zip,5,1),
			SELF.best_zip4 := INTFORMAT(RIGHT.zip4,4,1),
			SELF := LEFT),
		LOCAL);
	
	// Combine the records.
	combined_records := 
		IF(NOT in_options.exclude_persons,person_records_plus_best) +
		IF(NOT in_options.exclude_businesses,business_records_plus_best);
		
	match_is_best := combined_records(same_address);
	match_isnt_best := combined_records(NOT same_address);
	
	selected_records :=
		IF(NOT in_options.exclude_if_match_is_best,match_is_best) +
		IF(NOT in_options.exclude_if_match_isnt_best,match_isnt_best);
	
	deduped_records := DEDUP(
		SORT(
			selected_records,
			bi_ind,id,zip,zip4,prim_name,prim_range,sec_range,-dt_last_seen,-dt_first_seen,record,LOCAL),
		bi_ind,id,zip,zip4,prim_name,prim_range,sec_range,LOCAL);
	
	RETURN deduped_records;

END;
