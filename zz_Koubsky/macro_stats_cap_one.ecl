EXPORT macro_stats_cap_one(ds, at_name) := FUNCTIONMACRO

	// Attributes in which don't use <blank>, -1, 0 in calculating stats
	// all attributes not included just exclude <blank>, -1
	// this is for future use.
	// mod_stats := ['VerifiedSSN', 'SSNNotFound', 'RelativesPropOwnedTaxTotal'];
	// BOOLEAN normal_stats := at_name NOT IN mod_stats;
	
	BOOLEAN normal_stats := TRUE;
	// BOOLEAN normal_stats := FALSE;
	INTEGER full_count := COUNT(ds);
	// NICK is just excluding <blank> and -1.
	ds_slim := IF(normal_stats,
									ds( TRIM((STRING) #expand(at_name), LEFT, RIGHT) NOT IN ['', '-1', '-']),
									ds( TRIM((STRING) #expand(at_name), LEFT, RIGHT) NOT IN ['', '-1', '0']));
	
	slim_count := COUNT(ds_slim);
	INTEGER mid_count := slim_count / 2;
	sorted_ds := SORT(ds_slim, -(REAL)#expand(at_name));
	medn := sorted_ds[mid_count];	
	
	stats_layout := RECORD
		STRING name;
		REAL mean;
		REAL median;
		REAL std_dev;
		REAL miss_rate;
		REAL zero_rate;
		REAL neg_one_rate;
		REAL hit_rate;
	END;

	stats_layout add_stats(ut.ds_oneRecord le) :=  TRANSFORM
		SELF.name := at_name;
		SELF.mean := table(ds_slim, {temp_mean := AVE(group, (REAL)ds.#expand(at_name))} )[1].temp_mean;
		SELF.median := (REAL)medn.#expand(at_name);
		SELF.std_dev := SQRT( VARIANCE(ds_slim, (REAL) #expand(at_name)));
		SELF.miss_rate := COUNT( ds( (STRING) #expand(at_name) = '')) / full_count;
		SELF.zero_rate := COUNT( ds( (STRING) #expand(at_name) = '0')) / full_count;
		SELF.neg_one_rate := COUNT( ds( (STRING) #expand(at_name) = '-1')) / full_count;
		SELF.hit_rate := 	(full_count -
											COUNT( ds( (STRING) #expand(at_name) = '')) -
											COUNT( ds( (STRING) #expand(at_name) = '0')) -
											COUNT( ds( (STRING) #expand(at_name) = '-1')) )
											/ full_count;		
	END;

	dset := project(ut.ds_oneRecord, add_stats(left));

	return dset;
endmacro;