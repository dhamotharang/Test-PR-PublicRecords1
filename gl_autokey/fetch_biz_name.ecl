import autokeyb2,doxie,ut;
export Fetch_Biz_Name(
	string autokey_keyname,
	gl_autokey.autokey_interfaces.biz_name in_parms) :=
		function

			i := autokeyb2.key_name(autokey_keyname);

			doxie.layout_ref_bdid xt(i r) := TRANSFORM
																							SELF := r;
																			 END;

			f := 
				 project( 
						 i(in_parms.bdid_value = 0 and in_parms.comp_name_indic_value != '' AND in_parms.state_value = '' AND in_parms.city_value = '' AND in_parms.zip_value = [],
						keyed(cname_indic = in_parms.comp_name_indic_value),
						ut.CS100S(cname_indic, cname_sec, in_parms.comp_name_indic_value, in_parms.comp_name_sec_value) < 50,
						ut.bit_test(lookups, in_parms.lookup_value)
						 ) 
					, xt(LEFT));
			
			nofail := in_parms.nofail;

			AutokeyB2.mac_Limits(f,f_ret)
													
			RETURN f_ret;

		END;