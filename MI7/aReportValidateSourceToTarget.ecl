


import ut;
import crim_common;


//Validate extracts //


//Remember to test hash version for cm.case_num //

Layout_case_master := RECORD
  integer8 cama_id;
  string2 case_type_cd;
  string4 record_supplier_cd_c;
  string1 jurisdiction_flg;
  string50 case_num_c;
  string30 subject_last_name_c;
  string25 subject_first_name_c;
  string25 subject_middle_name_c;
  string100 subject_name_suffix_c;
  string100 subject_full_name_c;
  string1 subject_type_flg_c;
  string50 source_uid_c;
  string2 source_state_cd_c;
  string5 source_county_cd_c;
  string70 source_county_name_c;
  string10 district_name_uid;
  integer8 ecl_cade_id;
  string10 case_subject_seq_c;
  string15 created_by;
  string8 creation_dt;
  string15 last_updated_by;
  string8 last_update_dt;
  string10 batch_number;
  string8 dob;
  string9 ssn;
  string4 old_record_supplier_cd_c;
  string15 subject_age;
  string20 nc_dob;
end;

Layout_case_details := RECORD
  integer8 ecl_cade_id;
  string8 case_dt_c;
  string1 case_suffix_flg;
  string2 case_category_cd_c;
  string4 case_year;
  string20 docket_seq_f;
  string100 orig_source_division_name;
  string100 document_number_f;
  string1 subject_status_flg;
  string25 subject_id;
  string30 subject_type;
  string9 subject_ssn_c;
  string8 subject_dob_c;
  string1 subject_sex_cd_c;
  string1 subject_race_cd_c;
  string70 subject_address_line_1_c;
  string40 subject_address_line_2_c;
  string30 subject_city_name_c;
  string2 subject_state_cd_c;
  string5 subject_zip_cd_c;
  string4 subject_zip_4;
  string30 case_disposition_message;
  integer8 crsu_crsu_id;
  string8 sentence_disposition_mod_dt_f;
  string8 case_disposition_dt_c;
  string15 created_by;
  string8 creation_dt;
  string15 last_updated_by;
  string8 last_update_dt;
  string4 record_supplier_cd;
  string10 batch_number;
  string7 subject_height_c;
  string7 subject_weight_c;
  string15 subject_eye_c;
  string15 subject_hair_c;
  string8 sentence_expiration_dt_c;
  string10 finger_print;
  string4 old_record_supplier_cd;
  string15 subject_skin;
  string15 subject_phone;
  string15 subject_age_c;
  string100 personal_info;
  string1000 oth_personal_info;
  string20 nc_case_dt;
  string20 nc_subject_dob;
  string100 scar_tattoo;
  string20 ethnicity;
  string20 case_build;
end;

Layout_criminal_supplimental := RECORD
  integer8 crsu_id;
  string50 assigned_judge;
  string50 referred_judge;
  string8 term_dt;
  string10 original_court_id;
  string8 arrest_dt_c;
  string8 arraign_dt_f;
  string8 first_court_dt_f;
  string8 jail_release_dt_c;
  string240 ticket_number;
  string15 arresting_agency_cd;
  string75 arresting_agency_place_c;
  string8 seized_property_number;
  string10 costs_ordered;
  string1 costs_imposed;
  string1 imprisoned_switch_flg;
  string50 commenced_by_cd;
  integer8 ecl_cade_id;
  string15 created_by;
  string8 creation_dt;
  string15 last_updated_by;
  string8 last_update_dt;
  string4 record_supplier_cd;
  string10 batch_number;
  string12 agency_case_number_f;
  string15 custodial_agency_id;
  string50 custodial_agency;
  string25 county_of_commitment_f;
  string350 custody_status;
  string40 charging_document;
  string30 judge_doc_entered_by;
  string8 judge_doc_entered_dt;
  string35 offender_legal_representer;
  string50 witness_name;
  string8 trial_dt_c;
  string8 case_served_dt;
  string4 old_record_supplier_cd;
  string15 trial_type;
  string75 warrant_info_f;
  string75 mtr_info;
  string1000 custody_info_case;
  string1000 probation_info;
  string50 custody_location;
end;

Layout_criminal_charges := RECORD
  integer8 ecl_charge_id;
  string30 original_charge_c_a_x;
  string10 original_charge_number_occur;
  string200 original_charge_f;
  string15 original_charge_short;
  string30 original_code_section;
  string2 original_case_type_c;
  string1 original_charge_qualifier_flg;
  string1 original_charge_class_flg_f;
  string30 amended_charge_c_a_x;
  string10 amended_charge_number_occur;
  string1000 amended_charge_c;
  string15 amended_charge_short;
  string30 amended_code_section;
  string2 amended_case_type;
  string1 amended_charge_qualifier_flg;
  string1 amended_charge_class_flg;
  string1 charge_deletion_flg;
  string100 disposition;
  string8 disposition_dt;
  string2100 disposition_msg;
  string50 count_type;
  string10 charge_count;
  string8 appeal_dt_f;
  string8 offense_dt_c;
  string35 offense_town_c;
  string50 offense_description_c;
  string10 offense_level_num;
  string2 orig_plea_cd;
  string8 orig_plea_dt;
  string8 plea_withdrawn_dt;
  string2 new_plea_cd;
  string45 concluded_by_cd;
  string25 drivers_license_number_f;
  string2 drivers_license_state_cd_f;
  string50 cama_case_num;
  string50 cama_source_uid;
  string10 cama_case_subject_seq;
  string15 created_by;
  string8 creation_dt;
  string15 last_updated_by;
  string8 last_update_dt;
  string4 record_supplier_cd_c;
  string10 batch_number;
  string8 arrest_disposition_dt_f;
  string100 arrest_disposition_msg_f;
  string30 court_location_c;
  string20 cause_number_c;
  string100 court_provision_c;
  string40 disposition_during_appeal;
  string25 final_decision_on_appeal;
  string8 sentence_status_chg_dt_c;
  string29 agency_receiving_custody;
  string30 prosecutor_location;
  string30 prosecutor_case_reffer_to;
  string8 charge_rejected_dt;
  string100 prosecutor_action;
  string100 prosecutor_offense;
  string2 prosecution_case_type;
  string30 prosecute_general_offense_char;
  string100 other_conviction_offense;
  string100 prim_indictment_offense;
  string20 prim_indictment_class;
  string50 arraigned_offense;
  string2 arraigned_case_type_c;
  string20 arraigned_code_section_c;
  string8 called_and_failed_dt;
  string8 failure_to_appear_dt;
  string2 method_of_disposition_cd;
  string8 non_mv_fail_to_comply_dt;
  string8 mv_failure_to_comply_dt;
  string8 show_cause_order_dt;
  string15 offender_type;
  string4 old_record_supplier_cd;
  string8 charge_file_dt;
  string20 prosecutor_code_section;
  string8 capias_dt;
  string8 rearrest_dt;
  string8 bond_hearing_dt;
  string8 pros_decision_dt;
  string8 charge_reopen_dt;
  string8 chg_reopen_close_dt;
  string15 prim_indictment_number;
  string100 reopen_reason;
  string8 checked_dt_c;
  string8 closeout_dt_c;
  string15 reference_info;
  string8 custody_dt_c;
  string8 admit_dt_c;
  string8 release_dt_c;
  string8 convict_dt_c;
  string20 nc_offense_dt;
  string20 nc_disposition_dt;
  string1000 charge_info;
  string1000 custody_info;
  string40 offense_status;
end;

Layout_CriminalSentences := RECORD
  integer8 crse_id;
  string10 sentence_amt_c;
  string2000 sentence_comment_c;
  integer8 ecl_charge_id;
  string2 sety_sentence_type_cd_c;
  string15 created_by;
  string8 creation_dt;
  string15 last_updated_by;
  string8 last_update_dt;
  string4 record_supplier_cd;
  string10 batch_number;
  string4 old_record_supplier_cd;
end;
       

														
File_CaseMaster := dataset('~thor_data400::out::crim::cross_aoc_and_county::case_master'+ crim_common.version_development, Layout_case_master,
            						                                  CSV(SEPARATOR(['|#~|']), TERMINATOR(['\n','\r\n','\n\r']),QUOTE('[]')      ));		
																														
File_CaseDetails := dataset('~thor_data400::out::crim::cross_aoc_and_county::case_details'+ crim_common.version_development, Layout_case_details,
            						                                      CSV(SEPARATOR(['|#~|']), TERMINATOR(['\n','\r\n','\n\r']),QUOTE('[]')      ));		
																															
File_CrimSupp := dataset('~thor_data400::out::crim::cross_aoc_and_county::criminal_supplimental'+ crim_common.version_development, Layout_criminal_supplimental,
            						                                      CSV(SEPARATOR(['|#~|']), TERMINATOR(['\n','\r\n','\n\r']),QUOTE('[]')      ));		
																															
File_CrimCharges := dataset('~thor_data400::out::crim::cross_aoc_and_county::criminal_charges'+ crim_common.version_development, Layout_criminal_charges,
            						                                      CSV(SEPARATOR(['|#~|']), TERMINATOR(['\n','\r\n','\n\r']),QUOTE('[]')      ));		
																															
File_CrimSent := dataset('~thor_data400::out::crim::cross_aoc_and_county::criminal_sentences'+ crim_common.version_development, Layout_CriminalSentences,
            						                               CSV(SEPARATOR(['|#~|']), TERMINATOR(['\n','\r\n','\n\r']),QUOTE('[]')      ));																						
                                                   

//case_num := (String) HASH('CR-2009-08439-D'+ '');
//case_num := '4275151287'; 

//case_num := '2737285021'; 

// 42764855953501                                    
// 19044773683512                                    

                 
//case_num := '1904477368'; 		

//PENROD                        	DENNIS                   
						                                     
// and subject_last_name = 'LEWIS'
// and subject_first_name = 'WILLIAM'
// and dob = '19611012';																								 


// and subject_last_name = 'JAMES'
// and subject_first_name = 'WILLIAM'
// and dob = '19550901';

// and subject_last_name = 'JENKINS'
// and subject_first_name = 'JOHN'
// and dob = '19691124';


//ALDAZ                         	CHRISTOPHER              	S        AKCR                
//FOSTER 	DONEPH  ARCR
//BREITINGER                    	ROBERT         AZCR 9011          
//ALVARADO                      	STEPHEN            CTCR 0              


// '9038'  'GOSHA'  'MARION'  '19531207'  'GAGB';

     
 


//*** case master validation  *********************************************

//CM_Primary := File_CaseMaster(subject_full_name_c = '' and old_record_supplier_cd_c = '');
//CM_Primary := File_CaseMaster(stringlib.stringwildmatch(CASE_NUM_C, case_num + '*', false));



CM_Primary := File_CaseMaster(subject_last_name_c = 'GOSHA'  
                                          and subject_first_name_c = 'MARION'  
																					and old_record_supplier_cd_c = 'GAGB'
																					and  record_supplier_cd_c = '9038'
																				and dob = '19531207'
																					);



OUTPUT(sort(CM_Primary,ecl_cade_id,subject_type_flg_c), NAMED('MapPrimOffenderToCaseMaster'));

//*** case details validation  *********************************************

OUTPUT(sort(JOIN(File_CaseDetails,CM_Primary, LEFT.ecl_cade_id = RIGHT.ecl_cade_id,TRANSFORM(Layout_case_details,SELF := LEFT),lookup),ecl_cade_id),NAMED('MapPrimOffenderToCaseDetails'));

//*** criminal supplimental validation  **************************************

OUTPUT(sort(JOIN(File_CrimSupp, CM_Primary, LEFT.ecl_cade_id = RIGHT.ecl_cade_id,TRANSFORM(Layout_criminal_supplimental,SELF := LEFT),lookup),ecl_cade_id),NAMED('MapOffenderToCriminalSupplimental'));


//*** criminal charges validation  *****************************************

  
CC:= JOIN(File_CrimCharges , CM_Primary, 
                                    LEFT.cama_case_num = RIGHT.case_num_c and 
								                    LEFT.cama_source_uid = RIGHT.source_uid_c and 
																		LEFT.cama_case_subject_seq = RIGHT.case_subject_seq_c and 
																		LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c,
								                         TRANSFORM(Layout_criminal_charges,SELF := LEFT),lookup);

OUTPUT(CC,NAMED('MapCourtOffensesToCriminalCharges'));      

//*** criminal sentence validation  ***************************************

 OUTPUT(JOIN(File_CrimSent, CC, LEFT.ecl_charge_id = RIGHT.ecl_charge_id,TRANSFORM(Layout_CriminalSentences,SELF := LEFT),lookup),NAMED('MapCourtOffensesToCriminalSentences'));


