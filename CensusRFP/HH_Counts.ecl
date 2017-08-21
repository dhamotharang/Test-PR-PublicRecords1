EXPORT HH_Counts(dataset(layouts_census.layout_out) ds) := 

	TABLE(ds, {
		ds.   addr_curr_st;
		ds.   addr_curr_zip;
		ds.  addr_curr_prim_name;
		ds.  addr_curr_prim_range;
		ds.   addr_curr_predir;
		ds.   addr_curr_suffix;
		ds.   addr_curr_postdir;
		ds.   addr_curr_sec_range;
		n := count(group)},
		   addr_curr_st,
		   addr_curr_zip,
		   addr_curr_prim_name,
				addr_curr_prim_range,
		   addr_curr_predir,
		   addr_curr_suffix,
		   addr_curr_postdir,
		   addr_curr_sec_range
			 ) : PERSIST('~thor::census_rfp::householdcounts');
