import _control;

#IF(_control.Environment.onThor_LeadIntegrity)  // slim the layout for nonfcra leadintegrity thor job
	export Layout_Overrides := RECORD
		SET OF STRING1 bankrupt_correct_cccn  := [];
		SET OF STRING1 bankrupt_correct_ffid  := [];
		SET OF STRING1 lien_correct_tmsid_rmsid  := [];
		SET OF STRING1 lien_correct_ffid  := [];	
		SET OF STRING1 crim_correct_ofk  := [];
		SET OF STRING1 crim_correct_ffid  := [];

		SET OF STRING1 prop_correct_lnfare  := [];
		SET OF STRING1 prop_correct_ffid  := [];

		SET OF STRING1 water_correct_ffid  := [];
		SET OF STRING1 proflic_correct_ffid  := [];
		SET OF STRING1 student_correct_ffid  := [];
		SET OF STRING1 air_correct_ffid  := [];
		SET OF STRING1 avm_correct_ffid  := [];
		
		SET OF STRING1 water_correct_record_id  := [];
		SET OF STRING1 proflic_correct_record_id  := [];
		SET OF STRING1 student_correct_record_id  := [];
		SET OF STRING1 air_correct_record_id  := [];
		SET OF STRING1 avm_correct_record_id  := [];
		
		SET OF STRING1 infutor_correct_ffid  := [];
		SET OF STRING1 infutor_correct_record_id  := [];
		SET OF STRING1 impulse_correct_record_id  := [];
		SET OF STRING1 impulse_correct_ffid  := [];
		SET OF STRING1 gong_correct_ffid  := [];
		SET OF STRING1 gong_correct_record_id  := [];
		
		SET OF STRING1 ADVO_correct_ffid  := [];
		SET OF STRING1 ADVO_correct_record_id  := [];
		SET OF STRING1 PAW_correct_ffid  := [];
		SET OF STRING1 PAW_correct_record_id  := [];
		SET OF STRING1 email_data_correct_ffid  := [];
		SET OF STRING1 email_data_correct_record_id  := [];
		SET OF STRING1 inquiries_correct_ffid  := [];
		SET OF STRING1 inquiries_correct_record_id  := [];
		
		SET OF STRING1 ssn_correct_ffid  := [];
		SET OF STRING1 ssn_correct_record_id  := [];	

		SET OF STRING1 death_correct_ffid  := []; 
		SET OF STRING1 death_correct_record_id  := []; 

		SET OF STRING1 header_correct_record_id  := [];
	END;				
#ELSE			
	export Layout_Overrides := RECORD
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

		SET OF STRING20  death_correct_ffid {maxlength(5250)} := []; // need to verify length
		SET OF STRING100 death_correct_record_id {maxlength(33000)} := []; //need to verify length


		// Allowing for 200 header corrections
		SET OF STRING100 header_correct_record_id {maxlength(20100)} := [];

	END;
#END
