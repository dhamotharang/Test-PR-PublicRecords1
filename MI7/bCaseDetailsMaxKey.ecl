
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

File_CaseDetails := dataset('~thor_data400::out::crim_cp_ln::case_details_shadow_load'+ crim_common.version_development, Layout_case_details,
            						                                      CSV(heading(1),SEPARATOR(['|','|\'']), TERMINATOR(['\n','\r\n','\n\r'])));	

// export bCaseDetailsMaxKey := MAX(File_CaseDetails,ecl_cade_id)
                                                   // : persist ('~thor_data400::persist::out::crim::cross::case_details_max_key');	
			
			
export bCaseDetailsMaxKey :=	8505470965;//8500000000;

																									 
																									 
																									 
																									 
																									 