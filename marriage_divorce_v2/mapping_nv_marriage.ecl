import ut;
/*d
 string25 orig_Name1;
 string1  orig_Record_Indicator;
 string4 orig_Control_Year;
 string6 orig_Micro_film_Control_Number;
 string1 orig_Control_Alias; 
 string2 orig_Bride_or_groom_state1; 
 string25 orig_Name2;
 string2 orig_bride_or_groom_state2;  
 string8 orig_data_of_marriage; 
 string3 orig_city_County_of_marriage;
 string1 orig_officant; 
 string8 orig_marriage_recorded_date; 
 string3 orig_city_county_of_recording; 
 string4 orig_county_book; 
 string7 orig_county_page; 
 string10 orig_county_instrument_number;

*/
marriage_divorce_v2.layout_mar_div_intermediate t_map_to_common(marriage_divorce_v2.Layout_Marriage_NV_In le) := transform
 
		
 //Not relevant because there's no address information
 self.dt_first_seen            := 0;
 self.dt_last_seen             := 0;
 self.dt_vendor_first_reported := 0;
 self.dt_vendor_last_reported  := 0;
 
 self.filing_type  					:= '3';
 self.vendor       					:= 'NVMAR';
 self.source_file  					:= 'NV VITAL STATISTICS';
 self.process_date 					:= marriage_divorce_v2.process_date;
 self.state_origin 					:= 'NV';

 
//Can be either Groom or Bride
 
 self.party1_type 					:= 'G';
 self.party1_name_format 		:= 'L';
 self.party1_name        		:= if(le.orig_record_indicator='G' ,le.orig_Name1,le.orig_Name2);	 
 //self.party1_alias					:= le.orig_control_alias; 
 self.party1_csz						:= if(le.orig_record_indicator='G',get_nv_states(le.orig_Bride_or_groom_state1),get_nv_states(le.orig_Bride_or_groom_state2));	
 //it is opposite of whatever the above party1_type is.
 self.party2_type 					:= 'B';
 self.party2_name_format 		:= 'L';
 self.party2_name        		:= if(le.orig_record_indicator='G',le.orig_Name2,le.orig_Name1);
 self.party2_csz						:= if(le.orig_record_indicator='G',get_nv_states(le.orig_Bride_or_groom_state2),get_nv_states(le.orig_Bride_or_groom_state1));	

 //marriage info
 self.marriage_dt        		 := le.orig_data_of_marriage;
 self.marriage_filing_dt		 :=	le.orig_marriage_recorded_date;
 self.marriage_filing_number := if(trim(le.orig_county_instrument_number)='0000000000','',le.orig_county_instrument_number);
 self.marriage_docket_volume := le.orig_Micro_film_Control_Number; 
 self.marriage_county        := get_nv_counties(le.orig_city_county_of_recording);

 self := [];

 
end;

export mapping_nv_marriage := project(marriage_divorce_v2.File_Marriage_NV_In,t_map_to_common(left));