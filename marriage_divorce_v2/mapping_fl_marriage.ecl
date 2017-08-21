import ut;

// transform that maps the raw input files into an intermediate layout.
marriage_divorce_v2.layout_mar_div_intermediate t_map_to_common(marriage_divorce_v2.Layouts_Marriage_FL_In.Layout_Marriage_FL_In le) := transform
 
 					
 //Not relevant because there's no address information
 self.dt_first_seen            := 0;
 self.dt_last_seen             := 0;
 self.dt_vendor_first_reported := 0;
 self.dt_vendor_last_reported  := 0;
 
//marriage filing info
 self.filing_type  					:= '3';
 self.vendor       					:= 'FLMAR';
 self.source_file  					:= 'FLORIDA DEPT OF HEALTH';
 self.process_date 					:= marriage_divorce_v2.process_date;
 self.state_origin 					:= 'FL';

//husband 
 self.party1_type        		:= 'G';
 self.party1_name_format 		:= 'L';
 self.party1_name        		:= stringlib.stringcleanspaces( if(trim(le.groom_name_last)='' or trim(le.groom_name_first)='',
														'UNKNOWN',
														trim(le.groom_name_last)+', '+le.groom_name_first+' '+le.groom_name_middle+' '+le.groom_name_suffix));	
 self.party1_dob						:=trim(le.groom_DOB_year,LEFT,RIGHT)+trim(le.groom_DOB_month,LEFT,RIGHT)+trim(le.groom_DOB_day,LEFT,RIGHT);
 self.party1_age						:=le.groom_age;
 self.party1_race						:= case(le.groom_race_code,'1'=>'WHITE','2'=>'NEGRO','3'=>'INDIAN',
																									'4'=>'CHINESE','5'=>'JAPANESE','6'=>'HAWAIIAN',
																									'7'=>'OTHER NON WHITE','8'=>'FILIPINO','9'=>'UNKNOWN',
																									'0'=>'OTHER ASIAN/PACFIC ISLANDER','');
self.party1_csz				 		:= stringlib.stringtouppercase(marriage_divorce_v2.get_fl_states(trim(le.groom_res_state_code)));
self.party1_birth_state		:= stringlib.stringtouppercase(marriage_divorce_v2.get_fl_states(trim(le.groom_bir_state_code)));	
self.party1_previous_marital_status := case(le.groom_marr_end_how_code,'1'=>'SINGLE NEVER MARRIED','2'=>'DEATH','3'=>'DIVORCE,DISSOLUTION',
																									'4'=>'MARRIAGE ANNULED','5'=>'UNKNOWN,NOT STATED','');
self.party1_times_married := le.groom_marriage_number;
self.party1_last_marriage_end_dt := if(trim(le.groom_date_marr_end_year,LEFT,RIGHT)+trim(le.groom_date_marr_end_month,LEFT,RIGHT)+trim(le.groom_date_marr_end_day,LEFT,RIGHT) != '88888888',trim(le.groom_date_marr_end_year,LEFT,RIGHT)+trim(le.groom_date_marr_end_month,LEFT,RIGHT)+trim(le.groom_date_marr_end_day,LEFT,RIGHT),'');

//wife
 self.party2_type        		:= 'B';
 self.party2_name_format 		:= 'L';
 self.party2_name           := stringlib.stringcleanspaces( if(trim(le.bride_name_last)='' or trim(le.bride_name_first)='',
														'UNKNOWN',
														trim(le.bride_name_last)+', '+le.bride_name_first+' '+le.bride_name_middle/*+' '+le.bride_maiden_surname*/));	
 self.party2_dob						:=trim(le.bride_DOB_year,LEFT,RIGHT)+trim(le.bride_DOB_month,LEFT,RIGHT)+trim(le.bride_DOB_day,LEFT,RIGHT);
 self.party2_age						:=le.bride_age;
 self.party2_race						:= case(le.bride_race_code,'1'=>'WHITE','2'=>'NEGRO','3'=>'INDIAN',
																									'4'=>'CHINESE','5'=>'JAPANESE','6'=>'HAWAIIAN',
																									'7'=>'OTHER NON WHITE','8'=>'FILIPINO','9'=>'UNKNOWN',
																									'0'=>'OTHER ASIAN/PACFIC ISLANDER','');
 self.party2_csz         	  := stringlib.stringtouppercase(marriage_divorce_v2.get_fl_states(trim(le.bride_res_state_code)));
 self.party2_birth_state		:= stringlib.stringtouppercase(marriage_divorce_v2.get_fl_states(trim(le.bride_bir_state_code)));	
 self.party2_previous_marital_status := case(le.bride_marr_end_how_code,'1'=>'SINGLE NEVER MARRIED','2'=>'DEATH','3'=>'DIVORCE,DISSOLUTION',
																									'4'=>'MARRIAGE ANNULED','5'=>'UNKNOWN,NOT STATED','');
 self.party2_times_married := le.bride_marriage_number;
 self.party2_last_marriage_end_dt := if(trim(le.bride_date_marr_end_year,LEFT,RIGHT)+trim(le.bride_date_marr_end_month,LEFT,RIGHT)+trim(le.bride_date_marr_end_day,LEFT,RIGHT) != '88888888',trim(le.bride_date_marr_end_year,LEFT,RIGHT)+trim(le.bride_date_marr_end_month,LEFT,RIGHT)+trim(le.bride_date_marr_end_day,LEFT,RIGHT),'');

 //marriage info
 self.marriage_dt     			:= trim(le.date_of_marriage_year,LEFT,RIGHT)+trim(le.date_of_marriage_month,LEFT,RIGHT)+trim(le.date_of_marriage_day,LEFT,RIGHT);
 self.type_of_ceremony			:= case(trim(le.type_ceremony_code),'1'=>'RELIGIOUS','2'=>'CIVIL CODE',
 																		'3'=>'UNKNOWN, NOT STATED','');
 self.marriage_filing_number := trim(le.certnumber);
 self.marriage_city 					:= trim(le.city_of_marriage);
 self.marriage_county  				:= stringlib.stringtouppercase(marriage_divorce_v2.get_fl_county(trim(le.county_issuing_lic_code)));
 
 
 self := [];

 
end;

export mapping_fl_marriage := project(marriage_divorce_v2.File_Marriage_FL_In(regexfind('[a-z,-]',groom_age) = false),t_map_to_common(left));// : persist('mar_div_fl_mar');