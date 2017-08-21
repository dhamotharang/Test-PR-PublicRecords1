


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



														
File_CaseMaster := dataset('~thor_data400::out::crim::cross_aoc_and_county::case_master'+ crim_common.version_development, Layout_case_master,
            						                                        CSV(SEPARATOR(['|#~|']), TERMINATOR(['\n','\r\n','\n\r']),QUOTE('[]')      ));		
																														
output(File_CaseMaster(old_record_supplier_cd_c ='AKCR'),NAMED('AKCR'));
output(File_CaseMaster(old_record_supplier_cd_c ='ARCR'),NAMED('ARCR'));
output(File_CaseMaster(old_record_supplier_cd_c ='AZCR'),NAMED('AZCR'));
output(File_CaseMaster(old_record_supplier_cd_c ='CTCR'),NAMED('CTCR'));
output(File_CaseMaster(old_record_supplier_cd_c ='FLCR'),NAMED('FLCR'));
output(File_CaseMaster(old_record_supplier_cd_c ='GAGB'),NAMED('GAGB'));    
output(File_CaseMaster(old_record_supplier_cd_c ='IAOC'),NAMED('IAOC'));
output(File_CaseMaster(old_record_supplier_cd_c ='INCR'),NAMED('INCR'));
    
output(File_CaseMaster(old_record_supplier_cd_c ='MOCR'),NAMED('MOCR'));
output(File_CaseMaster(old_record_supplier_cd_c ='NCCR'),NAMED('NCCR'));
output(File_CaseMaster(old_record_supplier_cd_c ='NDCR'),NAMED('NDCR'));
output(File_CaseMaster(old_record_supplier_cd_c ='NJCR'),NAMED('NJCR'));
    
output(File_CaseMaster(old_record_supplier_cd_c ='OKCR'),NAMED('OKCR'));
output(File_CaseMaster(old_record_supplier_cd_c ='ORCR'),NAMED('ORCR'));
output(File_CaseMaster(old_record_supplier_cd_c ='PACR'),NAMED('PACR'));
output(File_CaseMaster(old_record_supplier_cd_c ='PACP'),NAMED('PACP'));
output(File_CaseMaster(old_record_supplier_cd_c ='RICR'),NAMED('RICR'));
output(File_CaseMaster(old_record_supplier_cd_c ='RITR'),NAMED('RITR'));
output(File_CaseMaster(old_record_supplier_cd_c ='TNCR'),NAMED('TNCR'));
output(File_CaseMaster(old_record_supplier_cd_c ='TXDP'),NAMED('TXDP'));
output(File_CaseMaster(old_record_supplier_cd_c ='UTCR'),NAMED('UTCR'));
output(File_CaseMaster(old_record_supplier_cd_c ='VACR'),NAMED('VACR'));
output(File_CaseMaster(old_record_supplier_cd_c ='WICR'),NAMED('WICR'));

output(File_CaseMaster(old_record_supplier_cd_c ='HICR'),NAMED('HICR'));
output(File_CaseMaster(old_record_supplier_cd_c ='MDCR'),NAMED('MDCR'));
output(File_CaseMaster(old_record_supplier_cd_c ='NMCR'),NAMED('NMCR'));


  output(MIN(File_CaseMaster,cama_id));
	output(MIN(File_CaseMaster,ecl_cade_id));

  output(MAX(File_CaseMaster,cama_id));
	output(MAX(File_CaseMaster,ecl_cade_id));
	
	
		output((File_CaseMaster(ecl_cade_id=0)));
	
	// output((File_CaseMaster(cama_id =167760417)));
	
	
	// output(choosen(File_CaseMaster(subject_last_name_c = ''),1000));						
 // output(count(File_CaseMaster(subject_last_name_c = '' and subject_type_flg_c = 'A')));																										
 // output(count(File_CaseMaster(subject_last_name_c = '' and subject_type_flg_c = '')));		
	



















