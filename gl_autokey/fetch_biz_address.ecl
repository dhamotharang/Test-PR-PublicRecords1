import autokeyb2,doxie,ut;
export Fetch_Biz_Address(
	string autokey_keyname,
	gl_autokey.autokey_interfaces.biz_address in_parms) :=
		function

			i := AutoKeyB2.key_address(autokey_keyname);

			doxie.Layout_ref_bdid xt(i r) := TRANSFORM
																			SELF := r;
																			 END;

			f :=
				 project(
							 i(in_parms.pname_value != '',
					 keyed(prim_name=in_parms.pname_value), 
					 keyed((in_parms.workHard and (in_parms.prange_value = '' OR in_parms.addr_loose)) OR in_parms.prange_value=prim_range),
					 keyed(hash((qstring25)in_parms.city_value)=city_code OR (in_parms.city_value='' and in_parms.workHard)), 
					 keyed(in_parms.state_value=st OR (in_parms.state_value='' and in_parms.workHard)), 
					 in_parms.sec_range_value='' or in_parms.sec_range_value=sec_range,
					 in_parms.comp_name_value = '' or ut.CS100S(cname_indic, cname_sec, in_parms.comp_name_indic_value, in_parms.comp_name_sec_value) < 50,
					 ut.bit_test(lookups, in_parms.lookup_value)
						), xt(LEFT));
					 
			nofail := in_parms.nofail;
					 
			AutokeyB2.mac_Limits(f,f_ret)	
												
			RETURN f_ret;

		END;