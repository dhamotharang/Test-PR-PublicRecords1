import autokeyb2,doxie,ut;
export Fetch_Biz_Zip(
	string autokey_keyname,
	gl_autokey.autokey_interfaces.biz_zip in_parms) :=
		function

			i := autokeyb2.Key_Zip(autokey_keyname);

			doxie.layout_ref_bdid xt(i r) := TRANSFORM
																							SELF := r;
																			 END;

			pfe(string20 l, string20 r) := l[1..length(trim(datalib.preferredfirst(r)))]=datalib.preferredfirst(r);

			f_raw := i(in_parms.zip_value<>[] AND (in_parms.pname_value='' OR in_parms.addr_error_value),
						keyed(zip IN in_parms.zip_value),
						in_parms.comp_name_indic_value<>'',
						keyed(cname_indic[1..length(trim(in_parms.comp_name_indic_value))] = in_parms.comp_name_indic_value),
						in_parms.comp_name_value = '' or ut.CS100S(cname_indic, cname_sec, in_parms.comp_name_indic_value, in_parms.comp_name_sec_value) < 50,
						ut.bit_test(lookups, in_parms.lookup_value)
						);

			// output(f_raw,									named('f_raw'));									// DEBUG
			// output(zip_value,							named('zip_value'));							// DEBUG
			// output(pname_value,						named('pname_value'));						// DEBUG
			// output(addr_error_value, 			named('addr_error_value'));				// DEBUG
			// output(comp_name_indic_value,	named('comp_name_indic_value'));	// DEBUG
			// output(comp_name_value,				named('comp_name_value'));				// DEBUG

			f := project(f_raw, xt(left));
			
			nofail := in_parms.nofail;

			AutokeyB2.mac_Limits(f,f_ret)
													
			RETURN f_ret;

		END;