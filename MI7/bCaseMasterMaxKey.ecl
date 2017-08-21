
import crim_common;

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


														
File_CaseMaster := dataset('~thor_data400::out::crim_cp_ln::case_master_shadow_load'+ crim_common.version_development, Layout_case_master,
            						                                      CSV(heading(1),SEPARATOR(['|','|\'']), TERMINATOR(['\n','\r\n','\n\r'])));

// export bCaseMasterMaxKey := MAX(File_CaseMaster,cama_id)
                                                   // : persist ('~thor_data400::persist::out::crim::cross::case_master_max_key');	
																									 
																									 
export bCaseMasterMaxKey := 8513001853; //8500000000;
