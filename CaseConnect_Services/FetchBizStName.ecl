import doxie, autokeyb2, autokey, ut;

export FetchBizStName (String keyNameRoot, boolean aNoFail = true) := FUNCTION

	companyIdSet := Functions.getCompanyIdSet();

	doxie.MAC_Header_Field_Declare ();
	
	//***** DECLARE KEYS
	kb2 := autokeyb2.Key_StName(keyNameRoot);

	//***** INDEX READ			
	kb2read:= kb2(keyed (st=state_value),
									keyed(cname_indic=comp_name_indic_value),
									keyed (cname_sec = comp_name_sec_value),
									lookups in companyIdSet);

	outrec := autokeyb2.layout_fetch;			
	pb2 := project(kb2read, outrec);

	nofail := aNoFail;
			
	//***** LIMIT
	Autokey.mac_Limits(pb2,p_ret);

	//***** NOW DO THE SAME FOR THE FUZZY ROUTE *****

	//***** INDEX READ
	fkb2read := kb2(keyed(st=state_value),
				comp_name_indic_value<>'',
				keyed(AutokeyB2.is_CNameIndicMatch(cname_indic, comp_name_indic_value)),
				ut.CS100S.current(cname_indic, cname_sec, comp_name_indic_value, comp_name_sec_value) < 50, 
				lookups in companyIdSet);

	fpb2 := project(fkb2read, outrec);

	//***** LIMIT
	Autokey.mac_Limits (fpb2, fp_ret)	;

	result := if(exists(fp_ret(error_code > 0)), p_ret, fp_ret); //only go the strict route when the fuzzy one returns so many that it errors

	boolean cname_search := comp_name_value != '' AND state_value <> '' AND city_value='' AND zip_value=[];
	return if(cname_search, result);
end;