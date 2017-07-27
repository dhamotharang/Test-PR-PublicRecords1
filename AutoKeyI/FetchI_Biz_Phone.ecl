import ut,doxie,autokeyb2,Autokeyb,autokey,AutoStandardI;
export FetchI_Biz_Phone := module
	export old := module
		export params := module
			export base := interface
				export string comp_name_value;
				export string comp_name_indic_value;
				export string comp_name_sec_value;
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

			//***** MACRO FOR INDEX READ
			indexread(i,f) :=
			MACRO
			f := i(in_mod.phone_value<>'',
					keyed(p7=IF(length(trim(in_mod.phone_value))=10,in_mod.phone_value[4..10],(STRING7)in_mod.phone_value)),
					keyed(p3=in_mod.phone_value[1..3] OR length(trim(in_mod.phone_value)) <> 10),
					in_mod.comp_name_value = '' or ut.CS100S.current(cname_indic, cname_sec, in_mod.comp_name_indic_value, in_mod.comp_name_sec_value) < 50);
			ENDMACRO;

			//***** DECLARE KEYS
			kb 	:= autokeyb.key_phone(in_mod.autokey_keyname_root);
			kb2 := autokeyb2.key_phone(in_mod.autokey_keyname_root);

			//***** INDEX READ
			indexread(kb, kbread);
			indexread(kb2,kb2read);

			//***** INTO OUTREC AND CHECK LOOKUP IN B2
			outrec := autokeyb2.layout_fetch;
			pb 	:= project(kbread,
										 outrec);
			pb2 := project(kb2read(ut.bit_test(lookups, in_mod.lookup_value)),
										 outrec);

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
				AutoStandardI.InterfaceTranslator.comp_name_value.params,
				AutoStandardI.InterfaceTranslator.comp_name_indic_value.params,
				AutoStandardI.InterfaceTranslator.comp_name_sec_value.params,
				AutoStandardI.InterfaceTranslator.phone_value.params,
				AutoStandardI.InterfaceTranslator.lookup_value.params)
			end;
			export full := interface(base)
				export string autokey_keyname_root;
				export boolean nofail := true;
				export boolean useAllLookups := false;
			end;
		end;
		export do(params.full in_mod) := function
			tempmod := module(old.params.full)
				export string autokey_keyname_root := in_mod.autokey_keyname_root;
				export boolean noFail := in_mod.noFail;
				export boolean useAllLookups := in_mod.useAllLookups;
				export string comp_name_value := AutoStandardI.InterfaceTranslator.comp_name_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.comp_name_value.params));
				export string comp_name_indic_value := AutoStandardI.InterfaceTranslator.comp_name_indic_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.comp_name_indic_value.params));
				export string comp_name_sec_value := AutoStandardI.InterfaceTranslator.comp_name_sec_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.comp_name_sec_value.params));
				export string10 phone_value := AutoStandardI.InterfaceTranslator.phone_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.phone_value.params));
				export unsigned4 lookup_value := AutoStandardI.InterfaceTranslator.lookup_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.lookup_value.params));
			end;
			return old.do(tempmod);
		end;
	end;
end;
