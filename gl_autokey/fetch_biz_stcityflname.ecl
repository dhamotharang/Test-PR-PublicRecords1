import autokeyb2,doxie,ut;
export Fetch_Biz_StCityFLName(
	string autokey_keyname,
	gl_autokey.autokey_interfaces.biz_stcityflname in_parms) :=
		function

			i := autokeyb2.Key_CityStName(autokey_keyname);

			doxie.layout_ref_bdid xt(i r) := TRANSFORM
																			SELF := r;
																			 END;

			f := 
				 project(
								i(in_parms.comp_name_value <> '' AND in_parms.city_value != '' AND (in_parms.pname_value='' OR in_parms.addr_error_value),
						keyed(city_code=hash((qstring25)in_parms.city_value)),
						keyed(st=in_parms.state_value OR (in_parms.state_value='' and in_parms.workHard)), 
						in_parms.comp_name_indic_value<>'',
						keyed(cname_indic[1..length(trim(in_parms.comp_name_indic_value))] = in_parms.comp_name_indic_value),
						ut.CS100S(cname_indic, cname_sec, in_parms.comp_name_indic_value, in_parms.comp_name_sec_value) < 50,
						ut.bit_test(lookups, in_parms.lookup_value)
					), xt(LEFT));
			
			nofail := in_parms.nofail;
					
			AutokeyB2.mac_Limits(f,f_ret)
													
			RETURN f_ret;

		END;