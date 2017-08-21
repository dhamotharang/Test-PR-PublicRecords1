import autokey,doxie,ut;
export Fetch_StCityFLName(
	string autokey_keyname,
	gl_autokey.autokey_interfaces.stcityflname in_parms) :=
		function

			i := autokey.Key_CityStName(autokey_keyname);

			doxie.layout_references xt(i r) := TRANSFORM
																			SELF := r;
																			 END;
			smok(string2 st) := st='' or ut.bit_test(i.states,ut.St2Code(st));

			f := 
				 project(
								i(in_parms.city_value != '' AND (in_parms.pname_value='' OR in_parms.addr_error_value) AND ((in_parms.workHard and not in_parms.isCRS) or (in_parms.lname_value <> '')),
						keyed(city_code=hash((qstring25)in_parms.city_value)),
						keyed(st=in_parms.state_value OR (in_parms.state_value='' and in_parms.workHard)),   
						keyed(dph_lname=(string6)metaphonelib.DMetaPhone1(in_parms.lname_value) OR (in_parms.lname_value='' and in_parms.workHard)),
									keyed(lname=in_parms.lname_value OR ((in_parms.phonetics OR in_parms.lname_value='') and in_parms.workHard)),
									keyed(pfname[1..length(trim(datalib.preferredfirst(in_parms.fname_value)))]=datalib.preferredfirst(in_parms.fname_value) OR (LENGTH(TRIM(in_parms.fname_value))<2 and in_parms.workHard)),
									keyed(fname[1..length(trim(in_parms.fname_value))]=in_parms.fname_value OR in_parms.nicknames),           
						in_parms.prev_state_val1='' or ut.bit_test(states,ut.St2Code(in_parms.prev_state_val1)),
						in_parms.prev_state_val2='' or ut.bit_test(states,ut.St2Code(in_parms.prev_state_val2)),
						in_parms.other_lname_value1[1]='' or ut.bit_test(lname1,ut.Chr2Code(in_parms.other_lname_value1[1])),
						in_parms.other_lname_value1[2]='' or ut.bit_test(lname2,ut.Chr2Code(in_parms.other_lname_value1[2])),
						in_parms.other_lname_value1[3]='' or ut.bit_test(lname3,ut.Chr2Code(in_parms.other_lname_value1[3])),
						in_parms.other_city_value[1]='' or ut.bit_test(city1,ut.Chr2Code(in_parms.other_city_value[1])),
						in_parms.other_city_value[2]='' or ut.bit_test(city2,ut.Chr2Code(in_parms.other_city_value[2])),
						in_parms.other_city_value[3]='' or ut.bit_test(city3,ut.Chr2Code(in_parms.other_city_value[3])),
						in_parms.rel_fname_value1[1]='' or ut.bit_test(rel_fname1,ut.Chr2Code(in_parms.rel_fname_value1[1])),
						in_parms.rel_fname_value1[2]='' or ut.bit_test(rel_fname2,ut.Chr2Code(in_parms.rel_fname_value1[2])),
						in_parms.rel_fname_value1[3]='' or ut.bit_test(rel_fname3,ut.Chr2Code(in_parms.rel_fname_value1[3])),
						in_parms.rel_fname_value2[1]='' or ut.bit_test(rel_fname1,ut.Chr2Code(in_parms.rel_fname_value2[1])),
						in_parms.rel_fname_value2[2]='' or ut.bit_test(rel_fname2,ut.Chr2Code(in_parms.rel_fname_value2[2])),
						in_parms.rel_fname_value2[3]='' or ut.bit_test(rel_fname3,ut.Chr2Code(in_parms.rel_fname_value2[3])),
						in_parms.find_year_low=0 or dob div 10000>=in_parms.find_year_low,in_parms.find_year_high=0 or dob div 10000<=in_parms.find_year_high,
						ut.bit_test(lookups, in_parms.lookup_value))
								, xt(LEFT));
			
			nofail := in_parms.nofail;
					
			AutoKey.mac_Limits(f,f_ret)	
												
			RETURN f_ret;

		END;