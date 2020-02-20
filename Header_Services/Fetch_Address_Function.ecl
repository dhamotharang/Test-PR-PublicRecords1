import ut,autokey, doxie, NID, dx_header;

i := dx_header.key_address();

doxie.layout_references xt(i r) := TRANSFORM
                                SELF := r;
                                 END;

export Fetch_Address_Function (string10 prange_value
															,string28 pname_value
															,string25 city_value
															,string2 state_value
															,string5 zip_val
															,unsigned2 zip_radius_value
															,string8 sec_range_value
															,string20 lname_value
															,string20 fname_value
															,boolean phonetics
															)
:=
MODULE
city_zip_value := ziplib.CityToZip5(state_value, city_value);
 zip_value := IF(zip_val<>'', IF(ziplib.ZipsWithinRadius(zip_val, zip_radius_value)=[],
																															[(INTEGER4)zip_val],
																															ziplib.ZipsWithinRadius(zip_val, zip_radius_value)),
			 IF(state_value<>'' AND city_value<>'' AND zip_radius_value>0, ziplib.ZipsWithinRadius(city_zip_value, zip_radius_value),
			  []));

	shared ids :=i(
		 (prim_name=pname_value), 
		 (prange_value = '' OR 
			  prange_value=prim_range ),
		 (city_code in doxie.Make_CityCodes(city_value).rox OR city_value=''), 
		 (state_value=st OR state_value=''), 
		 zip_value=[] or (integer4)zip IN zip_value,
		 (sec_range_value='' or sec_range_value=sec_range),
		  (lname_value='' OR lname=lname_value OR phonetics),
		  (lname_value='' or dph_lname=metaphonelib.DMetaPhone1(lname_value)),
		  LENGTH(TRIM(fname_value))<2 or NID.mod_PFirstTools.RinPFL(fname_value, pfname)
			);
 
	shared idsp := project(LIMIT(LIMIT(ids, 100000, SKIP, keyed),9000, SKIP), xt(LEFT));

 	EXPORT lafn := if(count(idsp) != 0
						, false
						,	if(count(ids) = 0
								, false
								, true
								)
						);
	EXPORT outrecs := idsp;
END;
