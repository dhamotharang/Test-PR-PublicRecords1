import ut, doxie, business_header_ss, autokeyb2, Autokeyb, autokey, AutoStandardI;
export FetchI_Biz_NameWords := module
	export old := module
		export params := module
			export base := interface
				export string comp_name_value;
				export string comp_name_indic_value;
				export string comp_name_sec_value;
				export string120 company_name_val_filt;
				export string120 company_name_val_filt2;
				export string city_value;
				export string state_value;
				export set of integer4 zip_value;
				export unsigned6 bdid_value;
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
      // company_name_val_filt has all spaces removed
			company_name_val_filt_no_the := if(in_mod.comp_name_value[1..4]='THE ',in_mod.company_name_val_filt[4..length(in_mod.company_name_val_filt)],
																			in_mod.company_name_val_filt);
      
      comp_name_indic_value_no_the := if(in_mod.comp_name_indic_value[1..4]='THE ',in_mod.comp_name_indic_value[5..length(in_mod.comp_name_indic_value)],
																			in_mod.comp_name_indic_value);
																			
			fuzzy_search_val := trim(comp_name_indic_value_no_the + in_mod.comp_name_sec_value,all);

			fuzzy_search_val2 := Business_Header_SS.Fn_SubstituteForAndString(in_mod.comp_name_value,in_mod.company_name_val_filt);
																			

			len(STRING str) := LENGTH(TRIM(str));
			
			//***** MACRO FOR INDEX READ
			indexread(i) :=
			FUNCTIONMACRO
        local casted1 := ut.cast2keyfield(i.word, company_name_val_filt_no_the);
        local casted2 := ut.cast2keyfield(i.word, in_mod.company_name_val_filt2);
        
        RETURN i(						
               keyed(casted1 = word[1..len(casted1)] or
                   (in_mod.company_name_val_filt2 <> '' and casted2 = word[1..len(casted2)])
                ), 
               keyed(in_mod.state_value = '' or in_mod.state_value = state)
               ) ;						
			ENDMACRO;

			//***** DECLARE KEYS
			kb 	:= autokeyb.key_nameWords(in_mod.autokey_keyname_root);
			kb2 := autokeyb2.key_nameWords(in_mod.autokey_keyname_root);

			//***** INDEX READ
			kbread := indexread(kb);
			kb2read := indexread(kb2);

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
			findexread(i) :=
			FUNCTIONMACRO
        local casted1 := ut.cast2keyfield(i.word, fuzzy_search_val);
        local casted2 := ut.cast2keyfield(i.word, fuzzy_search_val2);
        
        RETURN i(keyed(casted1 = word[1..len(casted1)] or
                (fuzzy_search_val2 <> '' and casted2 = word[1..len(casted2)])),
               keyed(in_mod.state_value = '' or in_mod.state_value = state)
               );
			ENDMACRO;


			//***** INDEX READ
			fkbread := findexread(kb);
			fkb2read := findexread(kb2);

			//***** INTO OUTREC AND CHECK LOOKUP IN B2
			fpb 	:= project(fkbread,
										 outrec);
			fpb2 := project(fkb2read(ut.bit_test(lookups, in_mod.lookup_value)),
										 outrec);

			//***** PICK YOUR PATH
			fp := if(in_mod.useAllLookups, fpb2, fpb);

			//***** LIMIT
			Autokey.mac_Limits (fp, fp_ret)	

			result := if(exists(p_ret),p_ret,fp_ret); //prefer tight results and dont check error code becuase the fuzzy will doomed anyway if the tight fails

			cname_search := in_mod.bdid_value = 0 and length(trim(in_mod.company_name_val_filt)) > 1;		
			return if(cname_search, result);
		end;
	end;
	export new := module
		export params := module
			export base := interface(
				AutoStandardI.InterfaceTranslator.comp_name_value.params,
				AutoStandardI.InterfaceTranslator.comp_name_indic_value.params,
				AutoStandardI.InterfaceTranslator.comp_name_sec_value.params,
				AutoStandardI.InterfaceTranslator.company_name_val_filt.params,
				AutoStandardI.InterfaceTranslator.company_name_val_filt2.params,
				AutoStandardI.InterfaceTranslator.city_value.params,
				AutoStandardI.InterfaceTranslator.state_value.params,
				AutoStandardI.InterfaceTranslator.zip_value.params,
				AutoStandardI.InterfaceTranslator.bdid_value.params,
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
				export string120 company_name_val_filt := AutoStandardI.InterfaceTranslator.company_name_val_filt.val(project(in_mod,AutoStandardI.InterfaceTranslator.company_name_val_filt.params));
				export string120 company_name_val_filt2 := AutoStandardI.InterfaceTranslator.company_name_val_filt2.val(project(in_mod,AutoStandardI.InterfaceTranslator.company_name_val_filt2.params));
				export string city_value := AutoStandardI.InterfaceTranslator.city_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.city_value.params));
				export string state_value := AutoStandardI.InterfaceTranslator.state_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.state_value.params));
				export set of integer4 zip_value := AutoStandardI.InterfaceTranslator.zip_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.zip_value.params));
				export unsigned6 bdid_value := AutoStandardI.InterfaceTranslator.bdid_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.bdid_value.params));
				export unsigned4 lookup_value := AutoStandardI.InterfaceTranslator.lookup_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.lookup_value.params));
			end;
			return old.do(tempmod);
		end;
	end;
end;