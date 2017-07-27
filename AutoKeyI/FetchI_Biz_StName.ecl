import ut,doxie,AutokeyB2,AutoKeyb,autokey,AutoStandardI;
export FetchI_Biz_StName := module
	export old := module
		export params := module
			export base := interface
				export string comp_name_value;
				export string comp_name_indic_value;
				export string comp_name_sec_value;
				export string city_value;
				export string state_value;
				export set of integer4 zip_value;
				export unsigned4 lookup_value;
			end;
			export full := interface(base)
				export string autokey_keyname_root;
				export boolean workHard;
				export boolean noFail := true;
				export boolean useAllLookups := false;
			end;
		end;
		export do(params.full in_mod) := function

			//***** MACRO FOR INDEX READ
			indexread(i,f) :=
			MACRO
			f := i (keyed (st=in_mod.state_value),
											keyed(cname_indic=in_mod.comp_name_indic_value),
											keyed (cname_sec = in_mod.comp_name_sec_value));						
			ENDMACRO;

			//***** DECLARE KEYS
			kb 	:= autokeyb.Key_StName(in_mod.autokey_keyname_root);
			kb2 := autokeyb2.Key_StName(in_mod.autokey_keyname_root);

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




			//***** NOW DO THE SAME FOR THE FUZZY ROUTE *****

			//***** MACRO FOR INDEX READ
			findexread(i,f) :=
			MACRO
			f := i(
						keyed(st=in_mod.state_value),
						in_mod.comp_name_indic_value<>'',
						keyed(AutokeyB2.is_CNameIndicMatch(cname_indic, in_mod.comp_name_indic_value)),
						ut.CS100S.current(cname_indic, cname_sec, in_mod.comp_name_indic_value, in_mod.comp_name_sec_value) < 50);
			ENDMACRO;


			//***** INDEX READ
			findexread(kb, fkbread);
			findexread(kb2,fkb2read);

			//***** INTO OUTREC AND CHECK LOOKUP IN B2
			fpb 	:= project(fkbread,
										 outrec);
			fpb2 := project(fkb2read(ut.bit_test(lookups, in_mod.lookup_value)),
										 outrec);

			//***** PICK YOUR PATH
			fp := if(in_mod.useAllLookups, fpb2, fpb);

			//***** LIMIT
			Autokey.mac_Limits (fp, fp_ret)	


			result := if(exists(fp_ret(error_code > 0)), p_ret, fp_ret); //only go the strict route when the fuzzy one returns so many that it errors

			boolean cname_search := in_mod.comp_name_value != '' AND in_mod.state_value <> '' AND in_mod.city_value='' AND in_mod.zip_value=[];
			return if(cname_search, result);
		end;
	end;
 	export new := module
		export params := module
			export base := interface(
				AutoStandardI.InterfaceTranslator.comp_name_value.params,
				AutoStandardI.InterfaceTranslator.comp_name_indic_value.params,
				AutoStandardI.InterfaceTranslator.comp_name_sec_value.params,
				AutoStandardI.InterfaceTranslator.city_value.params,
				AutoStandardI.InterfaceTranslator.state_value.params,
				AutoStandardI.InterfaceTranslator.zip_value.params,
				AutoStandardI.InterfaceTranslator.lookup_value.params)
			end;
			export full := interface(base)
				export string autokey_keyname_root;
				export boolean workHard;
				export boolean noFail := true;
				export boolean useAllLookups := false;
			end;
		end;
		export do(params.full in_mod) := function
			tempmod := module(old.params.full)
				export string autokey_keyname_root := in_mod.autokey_keyname_root;
				export boolean workHard := in_mod.workHard;
				export boolean noFail := in_mod.noFail;
				export boolean useAllLookups := in_mod.useAllLookups;
				export string comp_name_value := AutoStandardI.InterfaceTranslator.comp_name_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.comp_name_value.params));
				export string comp_name_indic_value := AutoStandardI.InterfaceTranslator.comp_name_indic_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.comp_name_indic_value.params));
				export string comp_name_sec_value := AutoStandardI.InterfaceTranslator.comp_name_sec_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.comp_name_sec_value.params));
				export string city_value := AutoStandardI.InterfaceTranslator.city_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.city_value.params));
				export string state_value := AutoStandardI.InterfaceTranslator.state_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.state_value.params));
				export set of integer4 zip_value := AutoStandardI.InterfaceTranslator.zip_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.zip_value.params));
				export unsigned4 lookup_value := AutoStandardI.InterfaceTranslator.lookup_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.lookup_value.params));
			end;
			return old.do(tempmod);
		end;
	end;
end;
