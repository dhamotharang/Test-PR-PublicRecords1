



import crim_common;

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


File_CaseDetails := dataset('~thor_data400::out::crim::cross_soff::case_details'+ crim_common.version_development, Layout_case_details,
            						                                     CSV(SEPARATOR(['|#~|']), TERMINATOR(['\n','\r\n','\n\r']),QUOTE('[]')));																																	
																								
File_CaseMaster := dedup(dataset('~thor_data400::out::crim::cross_soff::case_master'+ crim_common.version_development, Layout_case_master,
            						                                        CSV(SEPARATOR(['|#~|']), TERMINATOR(['\n','\r\n','\n\r']),QUOTE('[]'))),ecl_cade_id);		

Layout_case_details   tr_get_case_details(File_CaseDetails L , File_CaseMaster R) := TRANSFORM
SELF := L;
END;																												
		
		output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340017' and source_state_cd_c = 'AK'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('AK'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340016' and source_state_cd_c = 'AL'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('AL'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340203' and source_state_cd_c = 'AR'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('AR'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340019' and source_state_cd_c = 'AZ'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('AZ'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340329' and source_state_cd_c = 'CA'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('CA'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340021' and source_state_cd_c = 'CO'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('CO'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340091' and source_state_cd_c = 'CT'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('CT'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340024' and source_state_cd_c = 'DC'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('DC'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340023' and source_state_cd_c = 'DE'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('DE'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340026' and source_state_cd_c = 'FL'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('FL'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340029' and source_state_cd_c = 'GA'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('GA'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340330' and source_state_cd_c = 'HI'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('HI'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340036' and source_state_cd_c = 'IA'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('IA'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340093' and source_state_cd_c = 'ID'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('ID'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340032' and source_state_cd_c = 'IL'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('IL'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340034' and source_state_cd_c = 'IN'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('IN'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340038' and source_state_cd_c = 'KS'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('KS'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340040' and source_state_cd_c = 'KY'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('KY'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340041' and source_state_cd_c = 'LA'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('LA'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340324' and source_state_cd_c = 'MA'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('MA'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340046' and source_state_cd_c = 'MD'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('MD'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340196' and source_state_cd_c = 'ME'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('ME'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340047' and source_state_cd_c = 'MI'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('MI'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340094' and source_state_cd_c = 'MN'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('MN'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340365' and source_state_cd_c = 'MO'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('MO'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340375' and source_state_cd_c = 'MS'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('MS'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340052' and source_state_cd_c = 'MT'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('MT'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340067' and source_state_cd_c = 'NC'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('NC'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340068' and source_state_cd_c = 'ND'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('ND'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340054' and source_state_cd_c = 'NE'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('NE'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340056' and source_state_cd_c = 'NH'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('NH'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340092' and source_state_cd_c = 'NJ'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('NJ'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340061' and source_state_cd_c = 'NM'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('NM'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340366' and source_state_cd_c = 'NV'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('NV'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340064' and source_state_cd_c = 'NY'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('NY'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340197' and source_state_cd_c = 'OH'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('OH'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340071' and source_state_cd_c = 'OK'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('OK'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340371' and source_state_cd_c = 'OR'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('OR'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340205' and source_state_cd_c = 'PA'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('PA'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340367' and source_state_cd_c = 'RI'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('RI'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340075' and source_state_cd_c = 'SC'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('SC'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340372' and source_state_cd_c = 'SD'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('SD'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340077' and source_state_cd_c = 'TN'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('TN'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340079' and source_state_cd_c = 'TX'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('TX'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340204' and source_state_cd_c = 'UT'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('UT'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340083' and source_state_cd_c = 'VA'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('VA'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340332' and source_state_cd_c = 'VT'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('VT'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340323' and source_state_cd_c = 'WA'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('WA'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340089' and source_state_cd_c = 'WI'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('WI'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340087' and source_state_cd_c = 'WV'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('WV'));
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340090' and source_state_cd_c = 'WY'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('WY'));
																																
    output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340431' and 	source_state_cd_c = 'GA'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('GA_GBI'));
		output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340368' and 	source_state_cd_c = 'GU'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('GU'));
		output(join(File_CaseDetails,File_CaseMaster(source_uid_c = '340388' and 	source_state_cd_c = 'PR'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_case_details(LEFT,RIGHT)),NAMED('PR'));
		


  output(MIN(File_CaseDetails,ecl_cade_id));
	output(MIN(File_CaseDetails,crsu_crsu_id));

  output(MAX(File_CaseDetails,ecl_cade_id));
	output(MAX(File_CaseDetails,crsu_crsu_id));
	
	output(File_CaseDetails(ecl_cade_id = 0));
	output(File_CaseDetails(crsu_crsu_id = 0));

       