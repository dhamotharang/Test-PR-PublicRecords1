import autokeyb2,doxie,ut;
export Fetch_Biz_Name_Words(
	string autokey_keyname,
	gl_autokey.autokey_interfaces.biz_name_words in_parms) :=
		function

			i := autokeyb2.key_nameWords(autokey_keyname);

			doxie.layout_ref_bdid xt(i r) := TRANSFORM
																							SELF := r;
																			 END;

			f := 
				 project(
						 i(in_parms.bdid_value = 0 and length(trim(in_parms.company_name_val_filt)) > 1 /*AND state_value = ''*/ AND in_parms.city_value = '' AND in_parms.zip_value = [],
						
						 keyed(in_parms.company_name_val_filt = word[1..LENGTH(TRIM(in_parms.company_name_val_filt))] or
								 (in_parms.company_name_val_filt2 <> '' and in_parms.company_name_val_filt2 = word[1..LENGTH(TRIM(in_parms.company_name_val_filt2))])
								), 
						 keyed(in_parms.state_value = '' or in_parms.state_value = state),
						 ut.bit_test(lookups, in_parms.lookup_value)
						 ) 
					, xt(LEFT));
			
			nofail := in_parms.nofail;

			AutokeyB2.mac_Limits(f,f_ret)
													
			RETURN f_ret;

		END;