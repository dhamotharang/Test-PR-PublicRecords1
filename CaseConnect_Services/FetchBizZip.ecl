import doxie, autokeyb2, autokey, ut;

export FetchBizZip (String keyNameRoot, boolean aNoFail = true, set of string1 get_skip_set=[]) := FUNCTION

	companyIdSet := Functions.getCompanyIdSet();

	doxie.MAC_Header_Field_Declare ();

	//***** DECLARE KEYS
	kb2 := autokeyb2.key_zip(keyNameRoot);

	//***** INDEX READ
	kb2read := kb2(keyed (zip IN zip_value),
						keyed(cname_indic=comp_name_indic_value),
						keyed(cname_sec = comp_name_sec_value), 
							lookups in companyIdSet);
	
	outrec := autokeyb2.layout_fetch;
			
	pb2 := project(kb2read, outrec);

	nofail := aNoFail;
			
	//***** LIMIT
	Autokey.mac_Limits(pb2,p_ret);

	//***** NOW DO THE SAME FOR THE FUZZY ROUTE *****

	//***** INDEX READ
	fkb2read := kb2(keyed(zip IN zip_value),
					comp_name_indic_value<>'',
					keyed(AutokeyB2.is_CNameIndicMatch(cname_indic, comp_name_indic_value)),
						comp_name_value = '' or ut.CS100S.current(cname_indic, cname_sec, comp_name_indic_value, comp_name_sec_value) < 50, 
						lookups in companyIdSet);

	fpb2 := project(fkb2read, outrec);
			
	//***** LIMIT
	Autokey.mac_Limits (fpb2, fp_ret)	;
	result := fp_ret + p_ret;

	boolean cname_search := (comp_name_value <> '' or 'C' in get_skip_set) AND zip_value<>[] AND (pname_value='' OR addr_error_value);
	return if(cname_search, result);
end;