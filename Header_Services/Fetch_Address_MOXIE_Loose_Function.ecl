import ut, doxie, dx_header;

i := dx_header.key_wild_address_loose();

doxie.layout_references xt(i r) := TRANSFORM
      SELF := r;
END;

export Fetch_Address_MOXIE_Loose_Function(string10 prange_value
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

	ids1 :=i(
	      keyed(lname=lname_value),
		 keyed(fname=fname_value),
		 keyed(st=state_value),
		 keyed(city_code in doxie.Make_CityCodes(city_value).rox ),
		  //zip_value=[] or (integer4)zip IN zip_value,
		 prim_name=pname_value, 
		 prim_range=prange_value or    
		 abs((integer)prim_range-(integer)prange_value)<10 or 
		 datalib.stringsimilar100(prim_range,prange_value)*MAX(length(trim(prim_range)),length(trim(prange_value)))<101,
		 ut.nneq(mname, mname_value));
 
	idsp1 := project(LIMIT(LIMIT(ids1, 1000, SKIP, keyed),1000, SKIP), xt(LEFT));

	ids2 :=i(
	      keyed(lname=lname_value),
		 keyed(fname=fname_value),
		 keyed(st=state_value),
		 keyed(city_code in doxie.Make_CityCodes(city_value).rox),
		 prim_name=pname_value or
		 moxie_lname_typo.r1(prim_name, pname_value) or 
		 moxie_lname_typo.r2(prim_name, pname_value) or 
		 moxie_lname_typo.r3(prim_name, pname_value) or 
		 moxie_lname_typo.r4(prim_name, pname_value) or 
		 moxie_lname_typo.r5(prim_name, pname_value) or
		 moxie_lname_typo.r6(prim_name, pname_value) or 
		 moxie_lname_typo.r7(prim_name, pname_value), 
		 prim_range=prange_value,
		 ut.nneq(mname, mname_value));
 
	idsp2 := project(LIMIT(LIMIT(ids2, 1000, SKIP, keyed),1000, SKIP), xt(LEFT));
     
 	outrecs := idsp1 + idsp2;
	
	return outrecs;
	
END;

