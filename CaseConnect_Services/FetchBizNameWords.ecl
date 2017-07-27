import CaseConnect_Services, doxie, AutoKeyb2, ut, Autokey, Business_Header_SS; 

export FetchBizNameWords (String keyNameRoot, boolean aNoFail = true) := function

	companyIdSet := Functions.getCompanyIdSet();

	doxie.MAC_Header_Field_Declare ();
	
	company_name_val_filt_no_the := if(company_name_val_filt[1..4]='THE ',company_name_val_filt[5..length(company_name_val_filt)],
																			company_name_val_filt);
																			
	comp_name_indic_value_no_the := if(comp_name_indic_value[1..4]='THE ',company_name_val_filt[5..length(company_name_val_filt)],
																			comp_name_indic_value);
																			
	fuzzy_search_val := trim(comp_name_indic_value_no_the + comp_name_sec_value,all);

	fuzzy_search_val2 := Business_Header_SS.Fn_SubstituteForAndString(comp_name_value,company_name_val_filt);

	len(STRING str) := LENGTH(TRIM(str));
	
	//***** DECLARE KEYS			
	kb2 := autokeyb2.key_nameWords(keyNameRoot);

	casted1 := ut.cast2keyfield(kb2.word, company_name_val_filt_no_the);
	casted2 := ut.cast2keyfield(kb2.word, company_name_val_filt2);
	
	//***** INDEX READ			
	kb2read:= kb2(keyed(casted1 = word[1..len(casted1)] or
				 (company_name_val_filt2 <> '' and casted2 = word[1..len(casted2)])), 
						 keyed(state_value = '' or state_value = state),
						 lookups in companyIdSet);

	outrec := autokeyb2.layout_fetch;
	pb2 := project(kb2read, outrec);

	nofail := aNofail;
			
	//***** LIMIT
	Autokey.mac_Limits(pb2,p_ret);

	//***** NOW DO THE SAME FOR THE FUZZY ROUTE *****

	castedfz1 := ut.cast2keyfield(kb2.word, fuzzy_search_val);
	castedfz2 := ut.cast2keyfield(kb2.word, fuzzy_search_val2);
		
	//***** INDEX READ
	fkb2read := kb2(keyed(castedfz1 = word[1..len(castedfz1)] or
							(fuzzy_search_val2 <> '' and castedfz2 = word[1..len(castedfz2)])),
						 keyed(state_value = '' or state_value = state), 
							lookups in companyIdSet);

	fpb2 := project(fkb2read, outrec);
			
	//***** LIMIT
	Autokey.mac_Limits (fpb2, fp_ret);
	
	result := if(exists(p_ret),p_ret,fp_ret); //prefer tight results and dont check error code becuase the fuzzy will doomed anyway if the tight fails
			
	args := AutoStandardI.GlobalModule();
	bdid_value := AutoStandardI.InterfaceTranslator.bdid_value.val(project(args,
	AutoStandardI.InterfaceTranslator.bdid_value.params));
		
	cname_search := bdid_value = 0 and length(trim(company_name_val_filt)) > 1;		
	return if(cname_search, result);
end;