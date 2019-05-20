import ut, doxie, dx_header;

i := dx_header.key_wild_address_loose();

doxie.layout_references xt(i r) := TRANSFORM
      SELF := r;
END;

export Fetch_Address_MOXIE_LastTry_Function(string10 prange_value
								    ,string28 pname_value
								    ,string25 city_value
								    ,string2 state_value
								    ,string5 zip_val
								    ,unsigned2 zip_radius_value
								    ,string8 sec_range_value
								    ,string20 lname_value
								    ,string20 fname_value
								    ,string20 mname_value
								    ,boolean phonetics
								    )
:= function

     city_zip_value := ziplib.CityToZip5(state_value, city_value);
     zip_value := IF(zip_val<>'', IF(ziplib.ZipsWithinRadius(zip_val, zip_radius_value)=[],
	 			  						           [(INTEGER4)zip_val],
												 ziplib.ZipsWithinRadius(zip_val, zip_radius_value)),
			   IF(state_value<>'' AND city_value<>'' AND zip_radius_value>0, ziplib.ZipsWithinRadius(city_zip_value, zip_radius_value),
			      []));

	ids :=i(
	      keyed(lname=lname_value),
		 keyed(fname=fname_value),
		 keyed(st=state_value),
		  //zip_value=[] or (integer4)zip IN zip_value,
		 prim_name=pname_value, 
		 prim_range=prange_value,
		 sec_range=sec_range_value,
		 ut.nneq(mname, mname_value));
 
	outrecs := project(LIMIT(LIMIT(ids, 250, SKIP, keyed),250, SKIP), xt(LEFT));

	return outrecs;
	
END;
