IMPORT PRTE2_PhoneFinderUpdateRules, PromoteSupers, PRTE2_PhoneFraud;

EXPORT proc_build_base(String filedate) := FUNCTION
/*
		 DF-20815 PRCT Project - Phone Finder (Phase 3) - Requirement W
	  For the most current phone record in the phone raud otp and spoofing tables, 
			if the phone number is in Appendix A reference list, 
			set event_date = current date and event_time = current time.

			Appendix A reference table was saved to PRTE2_PhoneFinderUpdateRules.Files.file_phonefinder_update_rules_base for easy lookup and maintenance
*/

		current_date := (string) PRTE2_PhoneFinderUpdateRules.fn_GetDate.current_date;
	 current_time := (string) PRTE2_PhoneFinderUpdateRules.fn_GetDate.current_time;
	
		//get lookup table to determine which records to update 
 	df_phonefinder_update_rules_base := DEDUP(SORT(PRTE2_PhoneFinderUpdateRules.Files.phonefinder_update_rules_base(TRIM(last_spoof_dt_rule)='current_date_monthly'), phone_number), phone_number);
		set_numbers_to_update := SET(df_phonefinder_update_rules_base, phone_number);
		
//------------------------------------------------------------------------------------------------
// OTP BASE
//------------------------------------------------------------------------------------------------
		df_otp_in	:= DISTRIBUTE(Files.phonefraud_otp_base_in, HASH32(otp_phone));

		layout_otp_temp := RECORD
				Layouts.layout_phonefraud_otp_base_ext;
				INTEGER4 my_unique_id := 0;
		END;
		
		//add sequence number as unique record identifier and save off original values for event date and time
		layout_otp_temp AddUniqueID_otp(df_otp_in L, integer C) := TRANSFORM
				SELF.my_unique_id := C;
				SELF.orig_event_date := L.event_date;
				SELF.orig_event_time := L.event_time;				
				SELF := L; 
				SELF := [];
		END;
		
	 df_otp_seq := PROJECT(df_otp_in, AddUniqueID_otp(LEFT, COUNTER));			
		
		//get the latest event by phone number
		df_otp_lastest_recs_by_number := DEDUP(SORT(df_otp_seq(otp_phone in set_numbers_to_update), otp_phone, - event_date, - event_time, local),otp_phone, local);
	
			//update event_date and event_time to current date/time for matching recs
		df_otp_recs_updated:= JOIN(df_otp_seq,
																																df_otp_lastest_recs_by_number, 
																																LEFT.otp_phone = RIGHT.otp_phone
																																AND LEFT.event_date = RIGHT.event_date
																																AND LEFT.event_time = RIGHT.event_time,	
																																TRANSFORM( layout_otp_temp,
																																											SELF.event_date := current_date;
																																											SELF.event_time := current_time;
																																											SELF := LEFT;
																																									),
																																INNER);
	
		//join original file to the updated records by unique record identifier and select only those that don't match																						
		df_otp_recs_not_updated := JOIN(df_otp_seq,
																																df_otp_recs_updated, 
																																LEFT.my_unique_id = RIGHT.my_unique_id,
																																TRANSFORM( layout_otp_temp,
																																											SELF := LEFT;
																																									),
																																LEFT ONLY, local);																								
 
		//combine updated and non-updated records for combined base file
		df_otp_combined := df_otp_recs_updated + df_otp_recs_not_updated;
 
		//project to final layout
		df_otp_final := PROJECT(df_otp_combined, Layouts.layout_phonefraud_otp_base_ext);
 


//------------------------------------------------------------------------------------------------
// SPOOFING BASE
//------------------------------------------------------------------------------------------------
		 df_spoofing_in	:= DISTRIBUTE(Files.phonefraud_spoofing_base_in, HASH32(phone));

		 layout_spoofing_temp := RECORD
				Layouts.layout_phonefraud_spoofing_base_ext;
				INTEGER4 my_unique_id := 0;
		END;
		
		//add sequence number as unique record identifier and save off original values for event date and time
		layout_spoofing_temp AddUniqueID_spoofing(df_spoofing_in L, integer C) := TRANSFORM
				SELF.my_unique_id := C;
				SELF.orig_event_date := L.event_date;
				SELF.orig_event_time := L.event_time;
				SELF := L; 
				SELF := [];
		END;
	
	 df_spoofing_seq := PROJECT(df_spoofing_in, AddUniqueID_spoofing(LEFT, COUNTER));			
		
		//get the latest event by phone number
	 df_spoofing_latest_recs_by_number := DEDUP(SORT(df_spoofing_seq(phone in set_numbers_to_update), phone, - event_date, - event_time, local), phone, local);
	
		//update event_date and event_time to current date/time for matching recs
	 df_spoofing_recs_updated := JOIN(df_spoofing_seq,
																																			df_spoofing_latest_recs_by_number, 
																																			LEFT.phone = RIGHT.phone
																																			AND LEFT.event_date = RIGHT.event_date
																																			AND LEFT.event_time = RIGHT.event_time,																																					
																																			TRANSFORM( layout_spoofing_temp,
																																														SELF.event_date := current_date;
																																														SELF.event_time := current_time;
																																														SELF := LEFT;
																																												),
																																					INNER);
	
		//join original file to the updated records by unique record identifier and select only those that don't match																						
	 df_spoofing_recs_not_updated := JOIN(df_spoofing_seq,
																																					df_spoofing_recs_updated, 
																																					LEFT.my_unique_id = RIGHT.my_unique_id,
																																					TRANSFORM( layout_spoofing_temp,
																																																SELF := LEFT;
																																														),
																																					LEFT ONLY, local);																								
 
		//combine updated and non-updated records for combined base file
  df_spoofing_combined := df_spoofing_recs_updated + df_spoofing_recs_not_updated;
 
		//project to final layout
		df_spoofing_final := PROJECT(df_spoofing_combined, Layouts.layout_phonefraud_spoofing_base_ext);


  PromoteSupers.MAC_SF_BuildProcess(df_otp_final, Constants.base_phonefraud_otp, writefile_otp,,,true,filedate);
  PromoteSupers.MAC_SF_BuildProcess(df_spoofing_final, Constants.base_phonefraud_spoofing, writefile_spoofing,,,true,filedate);  
  
  RETURN SEQUENTIAL(writefile_otp, writefile_spoofing);	

END;