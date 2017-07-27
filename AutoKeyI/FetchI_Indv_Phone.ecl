import ut,doxie,AutoStandardI,autokey, lib_metaphone;
export FetchI_Indv_Phone := module
	export old := module
		export params := module
			export base := interface
				export string lname_value;
				export string10 phone_value;
				export unsigned4 lookup_value;
			end;
			export full := interface(base)
				export string autokey_keyname_root;
				export boolean noFail := true;
				export boolean useAllLookups := false;
			end;
		end;
		export do(params.full in_mod) := function

			//***** DECLARE KEYS
			k 	:= autokey.key_phone(in_mod.autokey_keyname_root);
			k2 	:= autokey.key_phone2(in_mod.autokey_keyname_root);

			//***** INDEX READ
			kread := k (in_mod.phone_value<>'',
					keyed(p7=IF(length(trim(in_mod.phone_value))=10,in_mod.phone_value[4..10],(STRING7)in_mod.phone_value)),
					keyed(p3=in_mod.phone_value[1..3] OR length(trim(in_mod.phone_value)) <> 10),
					keyed(in_mod.lname_value='' or dph_lname=(string6)metaphonelib.DMetaPhone1(in_mod.lname_value)[1..6])
          );

			k2read := k2 (in_mod.phone_value<>'',
					keyed(p7=IF(length(trim(in_mod.phone_value))=10,in_mod.phone_value[4..10],(STRING7)in_mod.phone_value)),
					keyed(p3=in_mod.phone_value[1..3] OR length(trim(in_mod.phone_value)) <> 10),
					keyed(in_mod.lname_value='' or dph_lname=(string6)metaphonelib.DMetaPhone1(in_mod.lname_value)[1..6]),
          ut.bit_test(lookups, in_mod.lookup_value)
          );

			//***** INTO OUTREC AND CHECK LOOKUP IN B2
			outrec := autokey.layout_fetch;
			pb 	:= project(kread, outrec);
			pb2 := project(k2read, outrec);

			//***** PICK YOUR PATH
			p := if(in_mod.useAllLookups, pb2, pb);
			
			nofail := in_mod.nofail;
			
			//***** LIMIT
			Autokey.mac_Limits(p,p_ret)

			return p_ret;
		end;
	end;
	export new := module
		export params := module
			export base := interface(
				AutoStandardI.InterfaceTranslator.lname_value.params,
				AutoStandardI.InterfaceTranslator.phone_value.params,
				AutoStandardI.InterfaceTranslator.lookup_value.params)
			end;
			export full := interface(base)
				export string autokey_keyname_root;
				export boolean noFail := true;
				export boolean useAllLookups := false;
			end;
		end;
		export do(params.full in_mod) := function
			tempmod := module(old.params.full)
				export string autokey_keyname_root := in_mod.autokey_keyname_root;
				export boolean noFail := in_mod.noFail;
				export boolean useAllLookups := in_mod.useAllLookups;
				export string lname_value := AutoStandardI.InterfaceTranslator.lname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.lname_value.params));
				export string10 phone_value := AutoStandardI.InterfaceTranslator.phone_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.phone_value.params));
				export unsigned4 lookup_value := AutoStandardI.InterfaceTranslator.lookup_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.lookup_value.params));
			end;
			return old.do(tempmod);
		end;
	end;
end;
