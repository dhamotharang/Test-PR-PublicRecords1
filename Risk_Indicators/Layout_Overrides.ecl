﻿export Layout_Overrides :=
RECORD
	SET OF STRING55  veh_correct_vin {maxlength(5600)} := [];
	SET OF STRING20  veh_correct_ffid {maxlength(2100)} := [];
	SET OF STRING55  bankrupt_correct_cccn {maxlength(5600)} := [];
	SET OF STRING20  bankrupt_correct_ffid {maxlength(2100)} := [];
	SET OF STRING100 lien_correct_tmsid_rmsid {maxlength(20200)} := [];
	SET OF STRING20  lien_correct_ffid {maxlength(5250)} := [];	
	SET OF STRING100 crim_correct_ofk {maxlength(33000)} := [];
	SET OF STRING20  crim_correct_ffid {maxlength(5250)} := [];

  // type of property record (assess./deeds/mortgage) can be identified by ln_fare_id, if needed.
	SET OF STRING12 prop_correct_lnfare {maxlength(2600)} := [];
	SET OF STRING20	prop_correct_ffid {maxlength(2100)} := [];
	// SET OF STRING12 assess_correct_lnfare;
	// SET OF STRING20	assess_correct_ffid;
	// SET OF STRING12 deed_correct_lnfare;
	// SET OF STRING20	deed_correct_ffid;
	SET OF STRING20 water_correct_ffid {maxlength(2100)} := [];
	SET OF STRING20 proflic_correct_ffid {maxlength(2100)} := [];
	SET OF STRING20 student_correct_ffid {maxlength(2100)} := [];
	SET OF STRING20 air_correct_ffid {maxlength(2100)} := [];
	SET OF STRING20 avm_correct_ffid {maxlength(2100)} := [];
	
	SET OF STRING100 water_correct_record_id {maxlength(10100)} := [];
	SET OF STRING100 proflic_correct_record_id {maxlength(10100)} := [];
	SET OF STRING100 student_correct_record_id {maxlength(10100)} := [];
	SET OF STRING100 air_correct_record_id {maxlength(10100)} := [];
	SET OF STRING100 avm_correct_record_id {maxlength(10100)} := [];
	
	SET OF STRING20 infutor_correct_ffid {maxlength(2100)} := [];
	SET OF STRING38 infutor_correct_record_id {maxlength(3900)} := [];
	SET OF STRING28 impulse_correct_record_id {maxlength(2900)} := [];
	SET OF STRING20 impulse_correct_ffid {maxlength(2100)} := [];
	SET OF STRING20 gong_correct_ffid {maxlength(2100)} := [];
	SET OF STRING38 gong_correct_record_id {maxlength(3900)} := [];
	
	// leaving room for 100 corrections of each
	SET OF STRING20 ADVO_correct_ffid {maxlength(2100)} := [];
	SET OF STRING100 ADVO_correct_record_id {maxlength(10100)} := [];
	SET OF STRING20 PAW_correct_ffid {maxlength(2100)} := [];
	SET OF STRING100 PAW_correct_record_id {maxlength(10100)} := [];
	SET OF STRING20 email_data_correct_ffid {maxlength(2100)} := [];
	SET OF STRING100 email_data_correct_record_id {maxlength(10100)} := [];
	SET OF STRING20 inquiries_correct_ffid {maxlength(2100)} := [];
	SET OF STRING100 inquiries_correct_record_id {maxlength(10100)} := [];
	
	SET OF STRING20 ssn_correct_ffid {maxlength(2100)} := [];
	SET OF STRING100 ssn_correct_record_id {maxlength(10100)} := [];

	// Allowing for 200 header corrections
	SET OF STRING100 header_correct_record_id {maxlength(20100)} := [];
	
	SET OF STRING20 ibehavior_correct_ffid {maxlength(2100)} := [];
	SET OF STRING100 ibehavior_correct_record_id {maxlength(10100)} := [];

END;
