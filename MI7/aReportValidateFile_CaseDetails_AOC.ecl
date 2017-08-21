


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

  

																												
File_CaseDetails := dataset('~thor_data400::out::crim::cross_aoc_and_county::case_details'+ crim_common.version_development, Layout_case_details,
            						                                     CSV(SEPARATOR(['|#~|']), TERMINATOR(['\n','\r\n','\n\r']),QUOTE('[]')      ));		
																															
																								
output(File_CaseDetails(old_record_supplier_cd ='AKCR'),NAMED('AKCR'));
output(File_CaseDetails(old_record_supplier_cd ='ARCR'),NAMED('ARCR'));
output(File_CaseDetails(old_record_supplier_cd ='AZCR'),NAMED('AZCR'));
output(File_CaseDetails(old_record_supplier_cd ='CTCR'),NAMED('CTCR'));
output(File_CaseDetails(old_record_supplier_cd ='FLCR'),NAMED('FLCR'));
output(File_CaseDetails(old_record_supplier_cd ='GAGB'),NAMED('GAGB'));    
output(File_CaseDetails(old_record_supplier_cd ='IAOC'),NAMED('IAOC'));
output(File_CaseDetails(old_record_supplier_cd ='INCR'),NAMED('INCR'));
    
output(File_CaseDetails(old_record_supplier_cd ='MOCR'),NAMED('MOCR'));
output(File_CaseDetails(old_record_supplier_cd ='NCCR'),NAMED('NCCR'));
output(File_CaseDetails(old_record_supplier_cd ='NDCR'),NAMED('NDCR'));
output(File_CaseDetails(old_record_supplier_cd ='NJCR'),NAMED('NJCR'));
    
output(File_CaseDetails(old_record_supplier_cd ='OKCR'),NAMED('OKCR'));
output(File_CaseDetails(old_record_supplier_cd ='ORCR'),NAMED('ORCR'));
output(File_CaseDetails(old_record_supplier_cd ='PACR'),NAMED('PACR'));
output(File_CaseDetails(old_record_supplier_cd ='PACP'),NAMED('PACP'));
output(File_CaseDetails(old_record_supplier_cd ='RICR'),NAMED('RICR'));
output(File_CaseDetails(old_record_supplier_cd ='RITR'),NAMED('RITR'));
output(File_CaseDetails(old_record_supplier_cd ='TNCR'),NAMED('TNCR'));
output(File_CaseDetails(old_record_supplier_cd ='TXDP'),NAMED('TXDP'));
output(File_CaseDetails(old_record_supplier_cd ='UTCR'),NAMED('UTCR'));
output(File_CaseDetails(old_record_supplier_cd ='VACR'),NAMED('VACR'));
output(File_CaseDetails(old_record_supplier_cd ='WICR'),NAMED('WICR'));


output(File_CaseDetails(old_record_supplier_cd ='HICR'),NAMED('HICR'));
output(File_CaseDetails(old_record_supplier_cd ='MDCR'),NAMED('MDCR'));
output(File_CaseDetails(old_record_supplier_cd ='NMCR'),NAMED('NMCR'));





	

  output(MIN(File_CaseDetails,ecl_cade_id));
	output(MIN(File_CaseDetails,crsu_crsu_id));

  output(MAX(File_CaseDetails,ecl_cade_id));
	output(MAX(File_CaseDetails,crsu_crsu_id));
	
	output(File_CaseDetails(ecl_cade_id = 0));
	output(File_CaseDetails(crsu_crsu_id = 0));

       