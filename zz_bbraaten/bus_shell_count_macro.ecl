EXPORT bus_shell_count_macro (ds, at_name) := FUNCTIONMACRO

	// Attributes in which don't use <blank>, -99, -98, or -97 in calculating stats.  Use this when zero is a valid response.  eg Number of loans can be 0-99
	
	INTEGER full_count := COUNT(ds);
	
	ds_slim := ds( (STRING) #expand(at_name) NOT IN ['', '-99', '-98', '-97']);
	
	slim_count := COUNT(ds_slim);
	INTEGER mid_count := full_count / 2;
	sorted_ds := SORT(ds_slim, -#expand(at_name));
	medn := sorted_ds[slim_count];
	
	stats_layout := RECORD
		STRING name;
		REAL zero_count;
		REAL neg_ninetynine_count;
		REAL neg_ninetyeight_count;
		REAL neg_ninetyseven_count;
		real pos_value_count;

	END;


	
	stats_layout add_stats(ut.ds_oneRecord le) :=  TRANSFORM
		SELF.name := at_name;		
		SELF.zero_count := COUNT( ds( (STRING) #expand(at_name) = '0')) ;              // #zero/Full Count
		SELF.neg_ninetynine_count := COUNT( ds( (STRING) #expand(at_name) = '-99'));  // #-99/Full Count 
		SELF.neg_ninetyeight_count := COUNT( ds( (STRING) #expand(at_name) = '-98')) ; // #-98/Full Count 
		SELF.neg_ninetyseven_count := COUNT( ds( (STRING) #expand(at_name) = '-97')); // #-97/Full Count 
		SELF.pos_value_count := COUNT( ds( (STRING) #expand(at_name) <> '-97' and <> '98' and <> '-99' and <> '0' and <> '')); // #-97/Full Count 
	
	END;                                                                                    
	dset := project(ut.ds_oneRecord, add_stats(left);

	return dset;
endmacro;