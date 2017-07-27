import ut;


marriage_divorce_v2.layout_mar_div_intermediate t_map_to_common(marriage_divorce_v2.Layout_Marriage_KY_In le) := transform
 
					
 //Not relevant because there's no address information
 self.dt_first_seen            := 0;
 self.dt_last_seen             := 0;
 self.dt_vendor_first_reported := 0;
 self.dt_vendor_last_reported  := 0;
 
 
 self.vendor       := 'KYMAR';
 self.source_file  := 'DEPT FOR PUBLIC HEALTH';
 self.process_date := marriage_divorce_v2.process_date;
 self.state_origin := 'KY';

 self.filing_type  :='3';
 
 //husband
 self.party1_type           := 'G';
 self.party1_name_format    := 'L';
 self.party1_name           := stringlib.stringcleanspaces( if(trim(le.groom_name_last)='' or trim(le.groom_name_first)='',
														'UNKNOWN',
														trim(le.groom_name_last)+', '+le.groom_name_first+' '+le.groom_name_middle_initial));	
 self.party1_age            := le.groom_age;
 self.party1_county         := stringlib.stringtouppercase(marriage_divorce_v2.get_ky_county(le.groom_place_of_residence));
 self.party1_race           := case(le.groom_race,'1'=>'WHITE','2'=>'NEGRO','3'=>'OTHER','9'=>'UNKNOWN','');
 self.party1_times_married  := le.groom_nbr_prev_marriages;

//wife
 self.party2_type           := 'W';
 self.party2_name_format    := 'L';
 self.party2_name           := stringlib.stringcleanspaces( if(trim(le.bride_name_last)='' or trim(le.bride_name_first)='',
														'UNKNOWN',
														trim(le.bride_name_last)+', '+le.bride_name_first+' '+le.bride_name_middle_initial));	
 self.party2_age            := le.bride_age;
 self.party2_county         := stringlib.stringtouppercase(marriage_divorce_v2.get_ky_county(le.bride_place_of_residence));
 self.party2_race           := case(le.bride_race,'1'=>'WHITE','2'=>'NEGRO','3'=>'OTHER','9'=>'UNKNOWN','');
 self.party2_times_married  := le.bride_nbr_prev_marriages;
 
 self.marriage_dt     			:= (string)ut.Date_MMDDYYYY_i2(le.date_of_marriage);
          
 self.marriage_county 			:= stringlib.stringtouppercase(marriage_divorce_v2.get_ky_county(le.county_place_of_license));
 self.marriage_filing_number :=le.certificate_nbr;
 self.marriage_docket_volume  := le.volume_nbr;
 self 										  := [];


end;

export mapping_ky_marriage := project(marriage_divorce_v2.File_Marriage_KY_In,t_map_to_common(left)) : persist('mar_div_ky_mar');