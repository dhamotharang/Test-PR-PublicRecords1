import autokeyb2,doxie,ut;
export Fetch_Biz_Phone(
	string autokey_keyname,
	gl_autokey.autokey_interfaces.biz_phone in_parms) :=
		function

			i := autokeyb2.key_phone(autokey_keyname);

			doxie.layout_ref_bdid xt(i r) := 
			TRANSFORM
				SELF := r;
			END;

			pfe(string20 l, string20 r) := l[1..length(trim(datalib.preferredfirst(r)))]=(STRING20)datalib.preferredfirst(r);

			f := project(
							i(in_parms.phone_value<>'',
					keyed(p7=IF(length(trim(in_parms.phone_value))=10,in_parms.phone_value[4..10],(STRING7)in_parms.phone_value)),
					keyed(p3=in_parms.phone_value[1..3] OR length(trim(in_parms.phone_value)) <> 10),
					in_parms.comp_name_value = '' or ut.CS100S(cname_indic, cname_sec, in_parms.comp_name_indic_value, in_parms.comp_name_sec_value) < 50,
					ut.bit_test(lookups, in_parms.lookup_value)
					)
					, xt(LEFT));
			
			nofail := in_parms.nofail;

			AutokeyB2.mac_Limits(f,f_ret)
													
			RETURN f_ret;
					
		END;