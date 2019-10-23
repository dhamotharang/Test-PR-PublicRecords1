IMPORT PRTE2_PhoneFinderUpdateRules, PromoteSupers, PRTE2_PhoneFraud;

EXPORT proc_build_base(String filedate) := FUNCTION
/*
		 DF-20815 PRCT Project - Phone Finder (Phase 3) - Requirement V
	  For the most current phone records in the ported_metadata table, 
			if the phone number is in Appendix A reference list, 
		 update several date and time fields to the current date and time

			Appendix A reference table was saved to PRTE2_PhoneFinderUpdateRules.Files.file_phonefinder_update_rules_base for easy lookup and maintenance
*/

		current_date := PRTE2_PhoneFinderUpdateRules.fn_GetDate.current_date;
	 current_time := (string) PRTE2_PhoneFinderUpdateRules.fn_GetDate.current_time;
	
		//get lookup table to determine which records to update 
 	df_phonefinder_update_rules_base := DEDUP(SORT(PRTE2_PhoneFinderUpdateRules.Files.phonefinder_update_rules_base(TRIM(last_port_dt_rule)='current_date_monthly'), phone_number), phone_number);
		set_numbers_to_update := SET(df_phonefinder_update_rules_base, phone_number);
		

		df_phones_ported_metadata_in	:= DISTRIBUTE(Files.phones_ported_metadata_base_in, HASH32(phone));

		layout_phones_ported_metadata_temp := RECORD
				Layouts.layout_phones_ported_metadata_base_ext;
				INTEGER4 my_unique_id := 0;
		END;
		
		//add sequence number as unique record identifier and save off original values for event date and time
		layout_phones_ported_metadata_temp AddUniqueID(df_phones_ported_metadata_in L, integer C) := TRANSFORM
				SELF.my_unique_id := C;
				SELF.orig_dt_last_reported										:= L.dt_last_reported;
				SELF.orig_porting_dt																:= L.porting_dt;
				SELF.orig_porting_time														:= L.porting_time;
				SELF.orig_vendor_last_reported_dt			:= L.vendor_last_reported_dt;
				SELF.orig_vendor_last_reported_time	:= L.vendor_last_reported_time;
				SELF.orig_port_start_dt													:= L.port_start_dt;
				SELF.orig_port_start_time											:= L.port_start_time;
				SELF.orig_port_end_dt															:= L.port_end_dt;
				SELF.orig_port_end_time													:= L.port_end_time;
				SELF.orig_deact_start_dt												:= L.deact_start_dt;
				SELF.orig_deact_start_time										:= L.deact_start_time;
				SELF.orig_deact_end_dt														:= L.deact_end_dt;
				SELF.orig_deact_end_time												:= L.deact_end_time;
				SELF.orig_react_start_dt												:= L.react_start_dt;
				SELF.orig_react_start_time										:= L.react_start_time;
				SELF.orig_react_end_dt														:= L.react_end_dt;
				SELF.orig_react_end_time												:= L.react_end_time;
 			SELF := L; 
				SELF := [];
		END;
		
	 df_phones_ported_metadata_seq := PROJECT(df_phones_ported_metadata_in, AddUniqueID(LEFT, COUNTER));			
		
		//get the latest event by phone number
		df_phones_ported_metadata_lastest_recs_by_number := DEDUP(SORT(df_phones_ported_metadata_seq(phone in set_numbers_to_update), phone, - dt_last_reported, local),phone, local);
	
			//update event_date and event_time to current date/time for matching recs
		df_phones_ported_metadata_recs_updated:= JOIN(df_phones_ported_metadata_seq,
																																df_phones_ported_metadata_lastest_recs_by_number, 
																																LEFT.phone = RIGHT.phone
																																AND LEFT.dt_last_reported = RIGHT.dt_last_reported,	
																																TRANSFORM( layout_phones_ported_metadata_temp,
																																											SELF.dt_last_reported 									:= current_date;
																																											SELF.porting_dt																:= current_date;
																																											SELF.porting_time														:= current_time;
																																											SELF.vendor_last_reported_dt			:= current_date;
																																											SELF.vendor_last_reported_time	:= current_time;
																																											SELF.port_start_dt													:= current_date;
																																											SELF.port_start_time											:= current_time;
																																											SELF.port_end_dt															:= current_date;
																																											SELF.port_end_time													:= current_time;
																																											SELF.deact_start_dt												:= current_date;
																																											SELF.deact_start_time										:= current_time;
																																											SELF.deact_end_dt														:= current_date;
																																											SELF.deact_end_time												:= current_time;
																																											SELF.react_start_dt												:= current_date;
																																											SELF.react_start_time										:= current_time;
																																											SELF.react_end_dt														:= current_date;
																																											SELF.react_end_time												:= current_time;
																																											SELF := LEFT;
																																									),
																																INNER);
	
		//join original file to the updated records by unique record identifier and select only those that don't match																						
		df_phones_ported_metadata_recs_not_updated := JOIN(df_phones_ported_metadata_seq,
																																df_phones_ported_metadata_recs_updated, 
																																LEFT.my_unique_id = RIGHT.my_unique_id,
																																TRANSFORM( layout_phones_ported_metadata_temp,
																																											SELF := LEFT;
																																									),
																																LEFT ONLY, local);																								
 
		//combine updated and non-updated records for combined base file
		df_phones_ported_metadata_combined := df_phones_ported_metadata_recs_updated + df_phones_ported_metadata_recs_not_updated;
 
		//project to final layout
		df_phones_ported_metadata_final := PROJECT(df_phones_ported_metadata_combined, Layouts.layout_phones_ported_metadata_base_ext);
   
  PromoteSupers.MAC_SF_BuildProcess(df_phones_ported_metadata_final, Constants.base_phones_ported_metadata, writefile_phones_ported_metadata,,,true,filedate);
 
			//for carrier_reference file, just do a copy from prod
		PromoteSupers.MAC_SF_BuildProcess(Files.carrier_reference_base_in, Constants.base_carrier_reference, writefile_carrier_reference,,,,filedate);
	  
  RETURN  PARALLEL(writefile_phones_ported_metadata, writefile_carrier_reference);	

END;