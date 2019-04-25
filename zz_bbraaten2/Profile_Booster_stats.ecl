EXPORT Profile_Booster_stats (ds, at_name) := FUNCTIONMACRO

	// Attributes in which don't use <blank>, -99, -98, or -97 in calculating stats.  Use this when zero is a valid response.  eg Number of loans can be 0-99
	
	INTEGER full_count := COUNT(ds);
	
// output(count(	full_count));
	
	ds_slim := ds( (STRING) #expand(at_name) NOT IN ['', '-1']);
	ds_slim2 := ds( (STRING) #expand(at_name) NOT IN ['']);
	
	slim_count := COUNT(ds_slim);
	slim_count2 := COUNT(ds_slim2);
	INTEGER mid_count := slim_count / 2;
	INTEGER mid_count2 := slim_count2 / 2;
	sorted_ds := SORT(ds_slim, -#expand(at_name));
	sorted_ds2 := SORT(ds, -#expand(at_name));
	medn := sorted_ds[mid_count];
	medn2 := sorted_ds2[mid_count2];
	
	stats_layout := RECORD
		STRING name;
		REAL mean;
		REAL median;
		REAL maximum;
		REAL minimum;
		REAL std_dev;
		REAL miss_rate;
		// REAL zero_rate;
		REAL neg_one_rate;
		// REAL neg_ninetyeight_rate;
		// REAL neg_ninetyseven_rate;
		REAL hit_rate;
		REAL outlier_count;
		real mean_abs_dev;
		real median_abs_dev;
	END;

	temp_mean := table(ds_slim, {temp_mean := AVE(group, (real)ds.#expand(at_name))} )[1].temp_mean;
	temp_mean2 := table(ds, {temp_mean2 := AVE(group, (real)ds.#expand(at_name))} )[1].temp_mean2;
	temp_median := (REAL)medn.#expand(at_name);			
	temp_median2 := (REAL)medn2.#expand(at_name);			
	temp_std_dev := SQRT( VARIANCE(ds_slim, (REAL) #expand(at_name)));
	thresh := MAX( 2 * temp_std_dev, 2);
	
	stats_layout add_stats(ut.ds_oneRecord le) :=  TRANSFORM
		SELF.name := at_name;
		SELF.mean := temp_mean;                                                                   //AVG of all except blank, -99, -98, and -97
		SELF.median := temp_median;				                                      	//median value of all except blank, -99, -98, and -97
		SELF.maximum := max(ds_slim, (REAL)ds_slim.#expand(at_name));
		SELF.minimum := min(ds_slim, (REAL)ds_slim.#expand(at_name));
		SELF.std_dev := temp_std_dev;                 																		 	 	    //SQRT(Variance(of all except: blank, -99, -98, and -97))
		SELF.miss_rate := COUNT( ds( (STRING) #expand(at_name) = '')) / full_count;               // #blank/Full Count
		// SELF.zero_rate := COUNT( ds( (STRING) #expand(at_name) = '0')) / full_count;              // #zero/Full Count
		SELF.neg_one_rate := COUNT( ds( (STRING) #expand(at_name) = '-1')) / full_count;  // #-99/Full Count 
		// SELF.neg_ninetyeight_rate := COUNT( ds( (STRING) #expand(at_name) = '-98')) / full_count; // #-98/Full Count 
		// SELF.neg_ninetyseven_rate := COUNT( ds( (STRING) #expand(at_name) = '-97')) / full_count; // #-97/Full Count 
		SELF.hit_rate := 	(full_count -																														// Full Count-#(blank, -99, -98, and -97)/Full Count
											COUNT( ds( (STRING) #expand(at_name) = '')) -
											COUNT( ds( (STRING) #expand(at_name) = '-1'))) 
											// COUNT( ds( (STRING) #expand(at_name) = '-98')) -
											// COUNT( ds( (STRING) #expand(at_name) = '-97')) )
											/ full_count;
		SELF.outlier_count := COUNT( ds_slim( (REAL) #expand(at_name) <> 0 AND ( (REAL) #expand(at_name) > (temp_mean + thresh) OR (REAL) #expand(at_name) < (temp_mean - thresh))));
		self.mean_abs_dev := 	(1/full_count)*sum(ds, abs((REAL) #expand(at_name) - temp_mean2));
		self.median_abs_dev := 	(1/full_count)*sum(ds, abs((REAL) #expand(at_name) - temp_median2));
	
	END;                                                                                        // count number of obs that are not zero and outside of 2 std deviations or just 2 from the mean on either side 


	
	// outliers := ds_slim( (REAL) #expand(at_name) <> 0 AND ( (REAL) #expand(at_name) > (temp_mean + thresh) OR (REAL) #expand(at_name) < (temp_mean - thresh)));
	// is_null := COUNT(outliers) <> 0;
	
	// IF(is_null, OUTPUT(CHOOSEN(outliers, 25), NAMED(at_name + '_outliers')));

	dset := project(ut.ds_oneRecord, add_stats(left));

	return dset;
endmacro;

// v1_prospectgender