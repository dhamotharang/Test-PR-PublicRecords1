import ut,marriage_divorce_v2;

// transform that maps the raw input files into an intermediate layout.
marriage_divorce_v2.layout_mar_div_intermediate t_map_to_common( marriage_divorce_v2.File_Marriage_CT_In le) := transform
 
 					
 //Not relevant because there's no address information
 self.dt_first_seen            := 0;
 self.dt_last_seen             := 0;
 self.dt_vendor_first_reported := 0;
 self.dt_vendor_last_reported  := 0;
 
//marriage filing info
 self.filing_type  					:= '3';
 self.vendor       					:= 'CTMAR';
 self.source_file  					:= 'CT DEPT OF HEALTH';
 self.process_date 					:= marriage_divorce_v2.process_date;
 self.state_origin 					:= 'CT';

//husband 
 self.party1_type        		:= 'G';
 self.party1_name_format 		:= 'L';
 self.party1_name        		:= stringlib.stringcleanspaces( if(trim(le.groom_last_name)='' or trim(le.groom_first_name)='',
														'UNKNOWN',
														trim(le.groom_last_name)+', '+le.groom_first_name+' '+le.groom_middle_name ));	
 
 self.party1_age						:=le.groom_age;
 
self.party1_csz				 		:= if(trim(le.groom_res_town) <> '',trim(le.groom_res_town)+','+marriage_divorce_v2.get_ct_states(stringlib.stringtouppercase(le.groom_res_st)),marriage_divorce_v2.get_ct_states(stringlib.stringtouppercase(le.groom_res_st)));
self.party1_previous_marital_status := case(trim(le.groom_last_mar),'M'=>'MARRIAGE','C'=>'CIVIL UNION','CU'=>'CIVIL UNION','');

self.party1_how_marriage_ended := case(le.groom_how_last_mar,'DE'=>'DECEASE','DI'=>'DIVORCED','PC'=>'PREVIOUSCU',
																									'AN'=>'ANNULLED','');
self.party1_times_married := if(le.groom_numb_civil = '0',le.groom_numb_mar,le.groom_numb_civil);

//wife
 self.party2_type        		:= 'B';
 self.party2_name_format 		:= 'L';
 self.party2_name           := stringlib.stringcleanspaces( if(trim(le.bride_last_name)='' or trim(le.bride_first_name)='',
														'UNKNOWN',
														trim(le.bride_last_name)+', '+le.bride_first_name+' '+le.bride_middle_name/*+' '+le.bride_maiden_surname*/));	
 
 self.party2_age						:=le.bride_age;
 
 self.party2_csz         	  := if(trim(le.bride_res_town) <> '',trim(le.bride_res_town)+','+marriage_divorce_v2.get_ct_states(stringlib.stringtouppercase(trim(le.bride_res_st))),marriage_divorce_v2.get_ct_states(stringlib.stringtouppercase(trim(le.bride_res_st)))) ;
 self.party2_previous_marital_status := case(trim(le.bride_last_mar),'M'=>'MARRIAGE','C'=>'CIVIL UNION','CU'=>'CIVIL UNION','');

 self.party2_how_marriage_ended := case(le.bride_how_last_mar,'DE'=>'DECEASE','DI'=>'DIVORCED','PC'=>'PREVIOUSCU',
																									'AN'=>'ANNULLED','');
 self.party2_times_married := if(le.bride_numb_civil = '0',le.bride_numb_mar,le.bride_numb_civil);
 

 //marriage info
 // self.marriage_dt     			:= (string)ut.date_slashed_MMDDYYYY_to_YYYYMMDD(le.marriage_dt);
 self.marriage_dt     			:= IF(regexfind('-',le.marriage_dt), (string)ut.DateTimeToYYYYMMDD(le.marriage_dt),
                                  (string)ut.date_slashed_MMDDYYYY_to_YYYYMMDD(le.marriage_dt)); 
																	
 self.marriage_filing_number := trim(le.state_filing_nbr);
 self.marriage_city 				 := trim(le.occ_town);
 
 self := [];

 
end;

export mapping_ct_marriage := project(marriage_divorce_v2.File_Marriage_CT_In,t_map_to_common(left));// : persist('mar_div_fl_mar');















