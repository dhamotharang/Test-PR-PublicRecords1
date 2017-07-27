import CaseConnect_Services, doxie, Autokeyb2, Autokey, ut;

export FetchBizPhone (String keyNameRoot, boolean aNoFail = true) := function

	companyIdSet := Functions.getCompanyIdSet();

	doxie.MAC_Header_Field_Declare ();
	
	//***** DECLARE KEYS			
	kb2 := autokeyb2.key_phone(keyNameRoot);

	//***** INDEX READ
	kb2read := kb2(phone_value<>'',
			keyed(p7=IF(length(trim(phone_value))=10,phone_value[4..10],(STRING7)phone_value)),
			keyed(p3=phone_value[1..3] OR length(trim(phone_value)) <> 10),
			comp_name_value = '' or ut.CS100S.current(cname_indic, cname_sec, comp_name_indic_value, comp_name_sec_value) < 50, 
			lookups in companyIdSet);

	outrec := autokeyb2.layout_fetch;
	pb2 := project(kb2read,	 outrec);
			
	nofail := aNoFail;
			
	//***** LIMIT
	Autokey.mac_Limits(pb2,p_ret);

	return p_ret;
end;