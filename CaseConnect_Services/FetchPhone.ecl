IMPORT ut, doxie, autokey, AutoKeyI;

export FetchPhone  (String keyNameRoot,boolean aNoFail = true) := FUNCTION
	
	companyIdSet := Functions.getCompanyIdSet();
	
	doxie.MAC_Header_Field_Declare ();

	//***** DECLARE KEYS			
	kb2 := autokey.key_phone2(keyNameRoot);

	outrec := autokey.layout_fetch;
			
	pb2 := project(kb2(phone_value<>'',
			keyed(p7=IF(length(trim(phone_value))=10,phone_value[4..10],(STRING7)phone_value)),
			keyed(p3=phone_value[1..3] OR length(trim(phone_value)) <> 10),
			keyed(lname_value='' or dph_lname=(string6)metaphonelib.DMetaPhone1(lname_value)[1..6]),
			lookups in companyIdSet),
								 outrec);
			
	nofail := aNoFail;
			
	//***** LIMIT
	Autokey.mac_Limits(pb2,p_ret)

	return p_ret;
		
end;