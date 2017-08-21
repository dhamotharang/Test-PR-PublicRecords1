


import crim_common;

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

File_CrimCharges := dataset('~thor_data400::out::crim::cross_soff::criminal_charges'+ crim_common.version_development, Layout_criminal_charges,
            						                                      CSV(SEPARATOR(['|#~|']), TERMINATOR(['\n','\r\n','\n\r']),QUOTE('[]')));				
																															
File_CaseMaster := dedup(dataset('~thor_data400::out::crim::cross_soff::case_master'+ crim_common.version_development, Layout_case_master,
            						                                        CSV(SEPARATOR(['|#~|']), TERMINATOR(['\n','\r\n','\n\r']),QUOTE('[]'))),ecl_cade_id);																																
  

Layout_criminal_charges   tr_get_crim_charges(File_CrimCharges L , File_CaseMaster R) := TRANSFORM
SELF := L;
END;																										
																																
		output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340017' and source_state_cd_c = 'AK'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('AK'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340016' and source_state_cd_c = 'AL'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('AL'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340203' and source_state_cd_c = 'AR'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('AR'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340019' and source_state_cd_c = 'AZ'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('AZ'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340329' and source_state_cd_c = 'CA'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('CA'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340021' and source_state_cd_c = 'CO'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('CO'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340091' and source_state_cd_c = 'CT'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('CT'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340024' and source_state_cd_c = 'DC'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('DC'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340023' and source_state_cd_c = 'DE'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('DE'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340026' and source_state_cd_c = 'FL'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('FL'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340029' and source_state_cd_c = 'GA'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('GA'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340330' and source_state_cd_c = 'HI'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('HI'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340036' and source_state_cd_c = 'IA'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('IA'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340093' and source_state_cd_c = 'ID'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('ID'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340032' and source_state_cd_c = 'IL'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('IL'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340034' and source_state_cd_c = 'IN'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('IN'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340038' and source_state_cd_c = 'KS'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('KS'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340040' and source_state_cd_c = 'KY'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('KY'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340041' and source_state_cd_c = 'LA'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('LA'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340324' and source_state_cd_c = 'MA'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('MA'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340046' and source_state_cd_c = 'MD'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('MD'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340196' and source_state_cd_c = 'ME'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('ME'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340047' and source_state_cd_c = 'MI'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('MI'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340094' and source_state_cd_c = 'MN'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('MN'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340365' and source_state_cd_c = 'MO'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('MO'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340375' and source_state_cd_c = 'MS'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('MS'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340052' and source_state_cd_c = 'MT'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('MT'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340067' and source_state_cd_c = 'NC'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('NC'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340068' and source_state_cd_c = 'ND'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('ND'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340054' and source_state_cd_c = 'NE'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('NE'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340056' and source_state_cd_c = 'NH'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('NH'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340092' and source_state_cd_c = 'NJ'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('NJ'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340061' and source_state_cd_c = 'NM'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('NM'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340366' and source_state_cd_c = 'NV'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('NV'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340064' and source_state_cd_c = 'NY'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('NY'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340197' and source_state_cd_c = 'OH'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('OH'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340071' and source_state_cd_c = 'OK'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('OK'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340371' and source_state_cd_c = 'OR'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('OR'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340205' and source_state_cd_c = 'PA'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('PA'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340367' and source_state_cd_c = 'RI'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('RI'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340075' and source_state_cd_c = 'SC'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('SC'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340372' and source_state_cd_c = 'SD'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('SD'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340077' and source_state_cd_c = 'TN'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('TN'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340079' and source_state_cd_c = 'TX'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('TX'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340204' and source_state_cd_c = 'UT'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('UT'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340083' and source_state_cd_c = 'VA'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('VA'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340332' and source_state_cd_c = 'VT'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('VT'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340323' and source_state_cd_c = 'WA'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('WA'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340089' and source_state_cd_c = 'WI'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('WI'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340087' and source_state_cd_c = 'WV'), LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('WV'));
    output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340090' and source_state_cd_c = 'WY'),LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('WY'));
	
	  
		 output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340431' and source_state_cd_c = 'GA'),LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('GA_GBI'));
	   output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340368' and source_state_cd_c = 'GU'),LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('GU'));
	   output(join(File_CrimCharges,File_CaseMaster(source_uid_c = '340388' and source_state_cd_c = 'PR'),LEFT.cama_case_num = RIGHT.case_num_c and LEFT.cama_source_uid = RIGHT.source_uid_c and LEFT.record_supplier_cd_c = RIGHT.record_supplier_cd_c and  LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd_c and  LEFT.cama_case_subject_seq= RIGHT.case_subject_seq_c, tr_get_crim_charges(LEFT,RIGHT)),NAMED('PR'));
	
	 
	 
	 
	


//output(File_CrimCharges(ecl_charge_id = 7374));
//output(File_CrimCharges(ecl_charge_id = 179542573));


//output(File_CrimCharges(ecl_charge_id = 179542574));


  output(MIN(File_CrimCharges,ecl_charge_id));

   output(MAX(File_CrimCharges,ecl_charge_id));
	
	
	 output((File_CrimCharges(ecl_charge_id= 0)));

