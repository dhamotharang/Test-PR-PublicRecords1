EXPORT Layout_Overrides := RECORD


	SET OF STRING20 ADVO_correct_ffid {maxlength(2100)} := [];
	SET OF STRING100 ADVO_correct_record_id {maxlength(10100)} := [];
	
	SET OF STRING20 air_correct_ffid {maxlength(2100)} := [];
	SET OF STRING100 air_correct_record_id {maxlength(10100)} := [];
	
	SET OF STRING20 avm_correct_ffid {maxlength(2100)} := [];
	SET OF STRING100 avm_correct_record_id {maxlength(10100)} := [];	
	
	SET OF STRING20 avm_medians_correct_ffid {maxlength(2100)} := [];
	SET OF STRING100 avm_medians_correct_record_id {maxlength(10100)} := [];
	
	SET OF STRING55	bankrupt_correct_cccn {maxlength(5600)} := [];
	SET OF STRING55	bankrupt_correct_RECORD_ID {maxlength(5600)} := [];
	SET OF STRING20	bankrupt_correct_ffid {maxlength(2100)} := [];
	
	SET OF STRING55	crim_correct_ofk {maxlength(33000)} := [];
	SET OF STRING20	crim_correct_ffid {maxlength(5250)} := [];
	
	SET OF STRING20	Death_correct_ffid {maxlength(2100)} := [];
	SET OF STRING100 Death_correct_record_id {maxlength(10100)} := [];

	SET OF STRING20 email_data_correct_ffid {maxlength(2100)} := [];
	SET OF STRING100 email_data_correct_record_id {maxlength(10100)} := [];

	SET OF STRING20 gong_correct_ffid {maxlength(2100)} := [];
	SET OF STRING38 gong_correct_record_id {maxlength(3900)} := [];

	// Allowing for 200 header corrections
	SET OF STRING100 header_correct_record_id {maxlength(20100)} := [];

	SET OF STRING20 infutor_correct_ffid {maxlength(2100)} := [];
	SET OF STRING38 infutor_correct_record_id {maxlength(3900)} := [];

	SET OF STRING20 inquiries_correct_ffid {maxlength(2100)} := [];
	SET OF STRING100 inquiries_correct_record_id {maxlength(10100)} := [];
	
	SET OF STRING100 lien_correct_tmsid_rmsid {maxlength(20200)} := [];
	SET OF STRING20	lien_correct_ffid {maxlength(5250)} := [];	

	SET OF STRING20 proflic_correct_ffid {maxlength(2100)} := [];
	SET OF STRING100 proflic_correct_record_id {maxlength(10100)} := [];
	
	SET OF STRING100 prop_correct_lnfare {maxlength(10100)} := [];//needs to be longer for persistentid mapped to search
	SET OF STRING20	prop_correct_ffid {maxlength(2100)} := [];	
	
	SET OF STRING20 student_correct_ffid {maxlength(2100)} := [];
	SET OF STRING100 student_correct_record_id {maxlength(10100)} := [];

	// SET OF STRING20 ssn_correct_ffid {maxlength(2100)} := [];
	// SET OF STRING100 ssn_correct_record_id {maxlength(10100)} := [];	
	
	SET OF STRING20 water_correct_ffid {maxlength(2100)} := [];
	SET OF STRING100 water_correct_record_id {maxlength(10100)} := [];	
	
	SET OF STRING20 thrive_correct_ffid {maxlength(2100)} := [];
	SET OF STRING100 thrive_correct_record_id {maxlength(10100)} := [];
	
	SET OF STRING20 SexOffender_correct_ffid {maxlength(2100)} := [];
	SET OF STRING100 SexOffender_correct_record_id {maxlength(10100)} := [];	
	
END;
