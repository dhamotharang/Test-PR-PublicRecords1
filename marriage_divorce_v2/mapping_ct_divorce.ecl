import ut;

// transform that maps the raw input files into an intermediate layout.
marriage_divorce_v2.layout_mar_div_intermediate t_map_to_common(marriage_divorce_v2.File_Divorce_CT_In le) := transform
 
 					
 //Not relevant because there's no address information
 self.dt_first_seen            := 0;
 self.dt_last_seen             := 0;
 self.dt_vendor_first_reported := 0;
 self.dt_vendor_last_reported  := 0;
 
//divorce filing info
  self.filing_type  := '7';
 
 self.filing_subtype := if(le.type_of_decree='1','DIVORCE GRANTED TO WIFE',
                        if(le.type_of_decree='2','ANNULMENT GRANTED TO WIFE',
												if(le.type_of_decree='3','DIVORCE GRANTED TO HUSBAND',
												if(le.type_of_decree='4','ANNULMENT GRANTED TO HUSBAND',
												if(le.type_of_decree='5','DIVORCE , NO GRANTEE STATED',
												if(le.type_of_decree='6','ANNULMENT, NO GRANTEE STATED',
												if(le.type_of_decree='7','GRANTEE WIFE, TYPE UNSTATED',
												if(le.type_of_decree='8','GRANTEE husbdAND, TYPE UNSTATED',
												if(le.type_of_decree='9','GRANTEE AND TYPE UNSTATED',
						'')))))))));;
 
 
 self.vendor       					:= 'CTDIV';
 self.source_file  					:= 'CT DEPT OF HEALTH';
 self.process_date 					:= marriage_divorce_v2.process_date;
 self.state_origin 					:= 'CT';

//husbdand 
 self.party1_type        		:= 'H';
 self.party1_name_format 		:= 'L';
 self.party1_name           := stringlib.stringcleanspaces( if(trim(le.husbd_CL_name)='' or trim(le.husbd_CF_name)='',
														' ',
														trim(le.husbd_CL_name)+', '+le.husbd_CF_name+' '+le.husbd_CM_name));	
 self.party1_dob           := trim(le.husbd_birth_yr) + marriage_divorce_v2.get_ct_mth(le.husbd_birth_mth);
 
 self.party1_birth_state    := stringlib.stringtouppercase(marriage_divorce_v2.get_ct_states(trim(le.husbd_birth_state)));;
 self.party1_age         := if(le.husbd_age_div<>'',le.husbd_age_div,'');
 self.party1_race        := case(le.husbd_race,'1'=>'WHITE','3'=>'BLACK','4'=>'INDIAN','5'=>'CHINESE, JAPANESE & OTHER NON-WHITE','9'=>'NOT STATED','');
 self.party1_county        := case(le.husbd_res_county,'1'=> 'HARTFORD','2'=>'NEW HAVEN','3'=> 'NEW LONDON','4'=>'FAIRFIELD','5'=>'WINDHAM','6'=>'LITCHFIELD','7'=>'MIDDLESEX','8'=>'TOLLAND','');
 self.party1_csz				 		:= stringlib.stringtouppercase(marriage_divorce_v2.get_ct_states(trim(le.husbd_res_state_code)));
 self.party1_times_married  := le.husbd_time_married;

//wife
 self.party2_type        		:= 'W';
 self.party2_name_format 		:= 'F';
 self.party2_name           := stringlib.stringcleanspaces( if(trim(le.wife_CF_name)='',
														'',le.wife_CF_name));	
self.party2_dob           := trim(le.wife_birth_yr)+marriage_divorce_v2.get_ct_mth(le.wife_birth_month);
 self.party2_race        := case(le.wife_race,'1'=>'WHITE','3'=>'BLACK','4'=>'INDIAN','5'=>'CHINESE, JAPANESE & OTHER NON-WHITE','9'=>'NOT STATED','');
 self.party2_age         := if(le.wife_age_div<>'',le.wife_age_div,'');
 self.party2_birth_state    := stringlib.stringtouppercase(marriage_divorce_v2.get_ct_states(trim(le.wife_birth_state)));;
 self.party2_county        := case(le.wife_res_county,'1'=> 'HARTFORD','2'=>'NEW HAVEN','3'=> 'NEW LONDON','4'=>'FAIRFIELD','5'=>'WINDHAM','6'=>'LITCHFIELD','7'=>'MIDDLESEX','8'=>'TOLLAND','');
 self.party2_csz         		:= stringlib.stringtouppercase(marriage_divorce_v2.get_ct_states(trim(le.wife_res_state_code)));
 self.party2_times_married  := le.wife_time_married;
 
 //marriage info
 self.number_of_children 		:= if(le.living_child_under18 = '99','',le.living_child_under18);
 self.marriage_dt     			:= if(le.date_of_marriage_year <> '',le.date_of_marriage_year,'');
 self.place_of_marriage 		:= stringlib.stringtouppercase(marriage_divorce_v2.get_ct_states(le.marriage_state_code));

 //divorce info

 self.divorce_dt        		:= if(le.decree_dt_YYYY <> '',trim(le.decree_dt_YYYY) ,'');
 self.divorce_filing_number := le.certnumber;
 
 self.divorce_county        := case(le.court_name,'1' => 'HARTFORD','2' => 'NEW HAVEN','3' => 'NEW LONDON','4'=> 'FAIRFIELD',
                                     '5' => 'WINDHAM','6' => 'LITCHFIELD','7' => 'MIDDLESEX','8' => 'TOLLAND','B' => 'WATERBURY','D' => 'STAMFORD','');
 self.divorce_docket_volume := trim(le.court_doc_number);
 self.grounds_for_divorce   := case(le.divorce_ground,'01' => 'ADULTERY','02' => 'CONVICTION OF CRIME','03' => 'CRUELTY','04' => 'DESERTION',
                                    '05' => 'FRADULENT CONTRACT','06' => 'HABITUAL INTEMPERANCE','07' => 'INSANITY, IMBECILITY','08' => 'VIOLATION OF CONJUGAL DUTY','09' => 'OTHER','');

 self := [];

 
end;

export mapping_ct_divorce := project(marriage_divorce_v2.File_Divorce_CT_In,t_map_to_common(left));// : persist('mar_div_fl_div');