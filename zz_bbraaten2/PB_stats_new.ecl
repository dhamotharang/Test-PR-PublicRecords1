EXPORT PB_stats_new (ds_p, ds_c, at_name) := FUNCTIONMACRO

	// Attributes in which don't use <blank>, -99, -98, or -97 in calculating stats.  Use this when zero is a valid response.  eg Number of loans can be 0-99
	
	INTEGER full_count_p := COUNT(ds_p);
	INTEGER full_count_c := COUNT(ds_C);
	
	
// output(count(	full_count_p), named('full_count_p'));
// output(count(	full_count_c), named('full_count_c'));	
	
	ds_slim_p := ds_p( (STRING) #expand(at_name) NOT IN ['', '-1']);
	ds_slim2_P := ds_p( (STRING) #expand(at_name) NOT IN ['']);
	
	ds_slim_c := ds_c( (STRING) #expand(at_name) NOT IN ['', '-1']);
	ds_slim2_c := ds_c( (STRING) #expand(at_name) NOT IN ['']);

	
	
	slim_count_p := COUNT(ds_slim_p);
	slim_count2_p := COUNT(ds_slim2_P);
	
	slim_count_c := COUNT(ds_slim_c);
		slim_count2_c := COUNT(ds_slim2_c);

	
	sorted_ds_p := SORT(ds_slim_p, -#expand(at_name));
	sorted_ds2_p := SORT(ds_p, -#expand(at_name));
	
		sorted_ds_c := SORT(ds_slim_c, -#expand(at_name));
	sorted_ds2_c := SORT(ds_c, -#expand(at_name));
	
	stats_layout := RECORD
		STRING name;
		decimal20_4 mean_p;
		decimal20_4 mean_c;
		decimal20_4 mean_diff;
		decimal20_4 Percent_Ave_Diff;
		decimal20_4 miss_rate_flag;
		decimal20_4 neg_one_rate_flag;
   	decimal20_4 hit_rate_flag;
		// decimal20_4 outlier_count;
		decimal20_4 std_dev;
		decimal20_4 mean_abs_dev;
	END;

	temp_mean_p := table(ds_slim_p, {temp_mean_p := AVE(group, (real)ds_p.#expand(at_name))} )[1].temp_mean_p;
	temp_mean2_p := table(ds_p, {temp_mean2_p := AVE(group, (real)ds_p.#expand(at_name))} )[1].temp_mean2_p;
			
	temp_mean_c := table(ds_slim_c, {temp_mean_c := AVE(group, (real)ds_c.#expand(at_name))} )[1].temp_mean_c;
	temp_mean2_c := table(ds_c, {temp_mean2_c := AVE(group, (real)ds_c.#expand(at_name))} )[1].temp_mean2_c;
		
			
			
	temp_std_dev_p := SQRT( VARIANCE(ds_slim_p, (REAL) #expand(at_name)));
	temp_std_dev_c := SQRT( VARIANCE(ds_slim_c, (REAL) #expand(at_name)));

	
	thresh_c := MAX( 2 * temp_std_dev_c, 2);
	thresh_p := MAX( 2 * temp_std_dev_p, 2);
	
	// miss_rate_c := (COUNT( ds_c( (STRING) #expand(at_name) = '')) / full_count_c );
	// miss_rate_p := (COUNT( ds_p( (STRING) #expand(at_name) = '')) / full_count_p) ;
	
	// neg_one_rate_c := (COUNT( ds_c( (STRING) #expand(at_name) = '-1')) / full_count_c); 
	// neg_one_rate_p := (COUNT( ds_p( (STRING) #expand(at_name) = '-1')) / full_count_p); 
	
// output(count(	neg_one_rate_c), named('neg_one_rate_c'));
// output(count(	neg_one_rate_p), named('neg_one_rate_p'));
	
	// hit_rate_c := ((full_count_c -COUNT( ds_c( (STRING) #expand(at_name) = '')) - COUNT( ds_c( (STRING) #expand(at_name) = '-1')))/ full_count_c);
	// hit_rate_p := ((full_count_p -COUNT( ds_p( (STRING) #expand(at_name) = '')) - COUNT( ds_p( (STRING) #expand(at_name) = '-1')))/ full_count_p);
	
	// outlier_count_c := COUNT( ds_slim_c( (REAL) #expand(at_name) <> 0 AND ( (REAL) #expand(at_name) > (temp_mean_c + thresh_c) OR (REAL) #expand(at_name) < (temp_mean_c - thresh_c))));
	// outlier_count_p := COUNT( ds_slim_p( (REAL) #expand(at_name) <> 0 AND ( (REAL) #expand(at_name) > (temp_mean_p + thresh_p) OR (REAL) #expand(at_name) < (temp_mean_p - thresh_p))));
	
	stats_layout add_stats(ut.ds_oneRecord le) :=  TRANSFORM
		SELF.name := at_name;
		self.mean_p := temp_mean_p;
		self.mean_c := temp_mean_c;
		// SELF.mean_diff := temp_mean_c - temp_mean_p;                                                                   //AVG of all except blank, -99, -98, and -97
		SELF.mean_diff :=if( abs(temp_mean_c - temp_mean_p) >= 0.00001, temp_mean_c - temp_mean_p, 0);                                                              //AVG of all except blank, -99, -98, and -97
		self.Percent_Ave_Diff := ((temp_mean_c - temp_mean_p)/temp_mean_p)*100;
		SELF.std_dev := temp_std_dev_c;                 																		 	 	    //SQRT(Variance(of all except: blank, -99, -98, and -97))
		SELF.miss_rate_flag := ((COUNT( ds_c( (STRING) #expand(at_name) = '')) / full_count_c ) - (COUNT( ds_p( (STRING) #expand(at_name) = '')) / full_count_p));              // #blank/Full Count
		// SELF.neg_one_rate_flag := if( (neg_one_rate_c <> neg_one_rate_p) , (neg_one_rate_c - neg_one_rate_p)*full_count_p, 0);   // #-99/Full Count 
		SELF.neg_one_rate_flag := ((COUNT( ds_c( (STRING) #expand(at_name) = '-1')) / full_count_c) - (COUNT( ds_p( (STRING) #expand(at_name) = '-1')) / full_count_p));   // #-99/Full Count 
		SELF.hit_rate_flag := 	(((full_count_c -COUNT( ds_c( (STRING) #expand(at_name) = '')) - COUNT( ds_c( (STRING) #expand(at_name) = '-1')))/ full_count_c) - ((full_count_p -COUNT( ds_p( (STRING) #expand(at_name) = '')) - COUNT( ds_p( (STRING) #expand(at_name) = '-1')))/ full_count_p)); 
		
		// SELF.outlier_count := if( abs(outlier_count_c - outlier_count_p) >= 62,outlier_count_c - outlier_count_p, 0); 
		self.mean_abs_dev := 	(1/full_count_p)*sum(ds_p, abs((REAL) #expand(at_name) - temp_mean2_p));
	
	END;                                                                                       


	dset := project(ut.ds_oneRecord, add_stats(left));

	return dset;
endmacro;

// v1_prospectgender