import doxie, autokeyb2, AutoKey, ut, AutoStandardI;

export FetchBizName  (String keyNameRoot, boolean aNoFail = true) := function

	companyIdSet := Functions.getCompanyIdSet();

	doxie.MAC_Header_Field_Declare ();

	//***** DECLARE KEYS
			
	kb2 := autokeyb2.key_name(keyNameRoot);

	//***** INDEX READ
			
	kb2read := kb2(keyed(cname_indic=comp_name_indic_value),
									keyed (cname_sec = comp_name_sec_value));
	
	outrec := autokeyb2.layout_fetch;
			
	nofail := aNofail;
	
	//***** NOW DO THE SAME FOR THE FUZZY ROUTE *****

	//***** INDEX READ
			
	fkb2read := kb2(
				keyed(AutokeyB2.is_CNameIndicMatch(cname_indic, comp_name_indic_value)),
				ut.CS100S.current(cname_indic, cname_sec, comp_name_indic_value, comp_name_sec_value) < 50,
				lookups in CompanyIdSet);

	//***** INTO OUTREC AND CHECK LOOKUP IN B2
	fpb2 := project(fkb2read,	 outrec);
			
	//***** LIMIT
	Autokey.mac_Limits (fpb2, fp_ret);

	// only return the fuzzy one cause and disregard strict.
	// strict was being used previous to this.
	
  result := fp_ret;
	args := AutoStandardI.GlobalModule();
	bdid_value := AutoStandardI.InterfaceTranslator.bdid_value.val(project(args,
		AutoStandardI.InterfaceTranslator.bdid_value.params));
	boolean cname_search := bdid_value = 0 and comp_name_indic_value != '' AND state_value = '' 
					AND city_value = '' AND zip_value = [] AND can_poscode_value = '';
	return if(cname_search, result);
end;