import autokey,doxie,ut;
export Fetch_Address(
	string autokey_keyname,
	gl_autokey.autokey_interfaces.address in_parms) :=
		function

			i := autokey.key_address(autokey_keyname);

			doxie.layout_references xt(i r) := TRANSFORM
																			SELF := r;
																			 END;

			set_city_codes := [doxie.Make_CityCode(in_parms.city_value)] + ut.ZipToCities(in_parms.zip_val).set_codes;

			f :=
				 project(
							 i(in_parms.pname_value != '',
					 keyed(prim_name=in_parms.pname_value), 
					 keyed((in_parms.workHard and (in_parms.prange_value = '' OR in_parms.addr_loose)) OR in_parms.prange_value=prim_range),
					 keyed(city_code in set_city_codes OR (in_parms.city_value='' and set_city_codes = [] and in_parms.workHard)), 
					 keyed(in_parms.state_value=st OR (in_parms.state_value='' and in_parms.workHard)), 
					 in_parms.sec_range_value='' or in_parms.sec_range_value=sec_range, // todo:make keyed
						in_parms.prev_state_val1='' or ut.bit_test(states,ut.St2Code(in_parms.prev_state_val1)),
						in_parms.prev_state_val2='' or ut.bit_test(states,ut.St2Code(in_parms.prev_state_val2)),
						in_parms.lname_value='' or metaphonelib.DMetaPhone1(lname)=metaphonelib.DMetaPhone1(in_parms.lname_value),
						in_parms.other_lname_value1[1]='' or ut.bit_test(lname1,ut.Chr2Code(in_parms.other_lname_value1[1])),
						in_parms.other_lname_value1[2]='' or ut.bit_test(lname2,ut.Chr2Code(in_parms.other_lname_value1[2])),
						in_parms.other_lname_value1[3]='' or ut.bit_test(lname3,ut.Chr2Code(in_parms.other_lname_value1[3])),
						ut.bit_test(lookups, in_parms.lookup_value))

							, xt(LEFT));
			
			nofail := in_parms.nofail;
					 
			AutoKey.mac_Limits(f,f_ret)	
												
			RETURN f_ret;

		END;