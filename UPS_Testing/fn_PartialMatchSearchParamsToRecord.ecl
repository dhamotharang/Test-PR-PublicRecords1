import doxie;

export fn_PartialMatchSearchParamsToRecord(UPS_Testing.IF_PartialMatchSearchParams in_mod) := FUNCTION
	key := doxie.key_header;

	outLayout := RECORD
		TYPEOF(key.fname) fname := '';						// -search +score
		TYPEOF(key.mname) mname := '';						// -search +score
		TYPEOF(key.lname) lname := '';						// +search +score
		STRING120 streetaddr := '';
		TYPEOF(key.prim_range) prim_range := '';	// +search +score
		TYPEOF(key.predir) predir := '';					// -search +score
		TYPEOF(key.prim_name) prim_name := '';		// +search +score
		TYPEOF(key.postdir) postdir := '';				// -search +score
		TYPEOF(key.suffix) suffix := '';					// -search +score
		TYPEOF(key.unit_desig) unit_desig := '';	// -search -score
		TYPEOF(key.sec_range) sec_range := '';		// -search +score
		TYPEOF(key.city_name) city_name := '';		// +search +score
		TYPEOF(key.st) st := '';									// +search +score
		TYPEOF(key.zip) zip := '';								// +search +score
		TYPEOF(key.zip4) zip4 := '';							// -search -score
		TYPEOF(key.phone) phone := '';						// +search +score
		UNSIGNED4 scoreThreshold := 0;						// scores below this value are not returned (0 = disabled)
		UNSIGNED4 maxResults := 100;							// max number of partial matches returned.
		BOOLEAN   searchStreetCityState := true;	// unlocks prim_name + street + city/state and prim_range + street + city/state
		BOOLEAN   searchStreetZip := true;				// unlocks prim_name + street + zip and prim_range + street + zip
		BOOLEAN   searchNameCityState := true;		// unlocks name + city/state search
		BOOLEAN   searchNameZip := true;					// unlocks name + zip search
		BOOLEAN   searchPhone := true;						// unlocks name + zip search
	END;
	
	outRec := ROW( {in_mod.fname,
									in_mod.mname,
									in_mod.lname,
									in_mod.streetaddr,
									in_mod.prim_range,
									in_mod.predir,
									in_mod.prim_name,
									in_mod.postdir,
									in_mod.suffix,
									in_mod.unit_desig,
									in_mod.sec_range,
									in_mod.city_name,
									in_mod.st,
									in_mod.zip,
									in_mod.zip4,
									in_mod.phone,
									in_mod.scoreThreshold,
									in_mod.maxResults,
									in_mod.searchStreetCityState,
									in_mod.searchNameCityState,
									in_mod.searchNameZip,
									in_mod.searchPhone }, outLayout);
	
	outds := DATASET( [ outRec ], outLayout);
	return outds;
END;