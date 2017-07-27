import ut,doxie,AutokeyB2,Autokeyb,autokey,AutoStandardI;
export FetchI_Biz_Zip := module
	export old := module
		export params := module
			export base := interface
				export string comp_name_value;
				export string comp_name_indic_value;
				export string comp_name_sec_value;
				export string pname_value;
				export boolean addr_error_value;
				export set of integer4 zip_value;
				export unsigned4 lookup_value;
			end;
			export full := interface(base)
				export string autokey_keyname_root;
				export boolean workHard;
				export boolean noFail;
				export boolean useAllLookups := false;
				export set of string1 get_skip_set := [];
			end;
		end;
		export do(params.full in_mod) := function

			//***** MACRO FOR INDEX READ
			indexread(i,f) :=
			MACRO
			f := i (keyed (zip IN in_mod.zip_value),
											keyed(cname_indic=in_mod.comp_name_indic_value),
											keyed(cname_sec = in_mod.comp_name_sec_value));						
			ENDMACRO;

			//***** DECLARE KEYS
			kb 	:= autokeyb.key_zip(in_mod.autokey_keyname_root);
			kb2 := autokeyb2.key_zip(in_mod.autokey_keyname_root);

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
			f :=
							 i(
						keyed(zip IN in_mod.zip_value),
						in_mod.comp_name_indic_value<>'',
						keyed(AutokeyB2.is_CNameIndicMatch(cname_indic, in_mod.comp_name_indic_value)),
						in_mod.comp_name_value = '' or ut.CS100S.current(cname_indic, cname_sec, in_mod.comp_name_indic_value, in_mod.comp_name_sec_value) < 50);
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


			result := fp_ret + p_ret;

			boolean cname_search := (in_mod.comp_name_value <> '' or 'C' in in_mod.get_skip_set) AND in_mod.zip_value<>[] AND (in_mod.pname_value='' OR in_mod.addr_error_value);
			return if(cname_search, result);
		end;
	end;
	export new := module
		export params := module
			export base := interface(
				AutoStandardI.InterfaceTranslator.comp_name_value.params,
				AutoStandardI.InterfaceTranslator.comp_name_indic_value.params,
				AutoStandardI.InterfaceTranslator.comp_name_sec_value.params,
				AutoStandardI.InterfaceTranslator.pname_value.params,
				AutoStandardI.InterfaceTranslator.addr_error_value.params,
				AutoStandardI.InterfaceTranslator.zip_value.params,
				AutoStandardI.InterfaceTranslator.lookup_value.params)
			end;
			export full := interface(base)
				export string autokey_keyname_root;
				export boolean workHard;
				export boolean noFail;
				export boolean useAllLookups := false;
				export set of string1 get_skip_set := [];
			end;
		end;
		export do(params.full in_mod) := function
			tempmod := module(old.params.full)
				export string autokey_keyname_root := in_mod.autokey_keyname_root;
				export boolean workHard := in_mod.workHard;
				export boolean noFail := in_mod.noFail;
				export boolean useAllLookups := in_mod.useAllLookups;
				export set of string1 get_skip_set := in_mod.get_skip_set;
				export string comp_name_value := AutoStandardI.InterfaceTranslator.comp_name_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.comp_name_value.params));
				export string comp_name_indic_value := AutoStandardI.InterfaceTranslator.comp_name_indic_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.comp_name_indic_value.params));
				export string comp_name_sec_value := AutoStandardI.InterfaceTranslator.comp_name_sec_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.comp_name_sec_value.params));
				export string pname_value := AutoStandardI.InterfaceTranslator.pname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.pname_value.params));
				export boolean addr_error_value := AutoStandardI.InterfaceTranslator.addr_error_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.addr_error_value.params));
				export set of integer4 zip_value := AutoStandardI.InterfaceTranslator.zip_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.zip_value.params));
				export unsigned4 lookup_value := AutoStandardI.InterfaceTranslator.lookup_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.lookup_value.params));
			end;
			return old.do(tempmod);
		end;
	end;
end;
