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

   
																															
File_CrimCharges := dataset('~thor_data400::out::crim::cross_aoc_and_county::criminal_charges'+ crim_common.version_development, Layout_criminal_charges,
            						                                      CSV(SEPARATOR(['|#~|']), TERMINATOR(['\n','\r\n','\n\r']),QUOTE('[]')      ));		
																															


//output(File_CrimCharges(ecl_charge_id = 179535199));


//output(count(File_CrimCharges(old_record_supplier_cd ='NCDO')));

//output(File_CrimCharges(_validate.date.fIsValid(l.ADMIT_DT_C)=false);

//output(File_CrimCharges(ecl_charge_id =118311910));


// output(count(File_CrimCharges(_validate.date.fIsValid(l.ADMIT_DT_C)=false  
                                           // or   _validate.date.fIsValid(l.CONVICT_DT_C)=true ));
																					 
// output(count(File_CrimCharges(_validate.date.fIsValid(l.ADMIT_DT_C)=true  
                                           // or   _validate.date.fIsValid(l.CONVICT_DT_C)=false ));																				 


output(File_CrimCharges(old_record_supplier_cd ='AKCR'),NAMED('AKCR'));
output(File_CrimCharges(old_record_supplier_cd ='ARCR'),NAMED('ARCR'));
output(File_CrimCharges(old_record_supplier_cd ='AZCR'),NAMED('AZCR'));
output(File_CrimCharges(old_record_supplier_cd ='CTCR'),NAMED('CTCR'));
output(File_CrimCharges(old_record_supplier_cd ='FLCR'),NAMED('FLCR'));
output(File_CrimCharges(old_record_supplier_cd ='GAGB'),NAMED('GAGB'));    
output(File_CrimCharges(old_record_supplier_cd ='IAOC'),NAMED('IAOC'));
output(File_CrimCharges(old_record_supplier_cd ='INCR'),NAMED('INCR'));
    
output(File_CrimCharges(old_record_supplier_cd ='MOCR'),NAMED('MOCR'));
output(File_CrimCharges(old_record_supplier_cd ='NCCR'),NAMED('NCCR'));
output(File_CrimCharges(old_record_supplier_cd ='NDCR'),NAMED('NDCR'));
output(File_CrimCharges(old_record_supplier_cd ='NJCR'),NAMED('NJCR'));
    
output(File_CrimCharges(old_record_supplier_cd ='OKCR'),NAMED('OKCR'));
output(File_CrimCharges(old_record_supplier_cd ='ORCR'),NAMED('ORCR'));
output(File_CrimCharges(old_record_supplier_cd ='PACR'),NAMED('PACR'));
output(File_CrimCharges(old_record_supplier_cd ='PACP'),NAMED('PACP'));
output(File_CrimCharges(old_record_supplier_cd ='RICR'),NAMED('RICR'));
output(File_CrimCharges(old_record_supplier_cd ='RITR'),NAMED('RITR'));
output(File_CrimCharges(old_record_supplier_cd ='TNCR'),NAMED('TNCR'));
output(File_CrimCharges(old_record_supplier_cd ='TXDP'),NAMED('TXDP'));
output(File_CrimCharges(old_record_supplier_cd ='UTCR'),NAMED('UTCR'));
output(File_CrimCharges(old_record_supplier_cd ='VACR'),NAMED('VACR'));
output(File_CrimCharges(old_record_supplier_cd ='WICR'),NAMED('WICR'));

output(File_CrimCharges(old_record_supplier_cd ='HICR'),NAMED('HICR'));
output(File_CrimCharges(old_record_supplier_cd ='MDCR'),NAMED('MDCR'));
output(File_CrimCharges(old_record_supplier_cd ='NMCR'),NAMED('NMCR'));



//output(File_CrimCharges(ecl_charge_id = 7374));
//output(File_CrimCharges(ecl_charge_id = 179542573));


//output(File_CrimCharges(ecl_charge_id = 179542574));


  output(MIN(File_CrimCharges,ecl_charge_id));

   output(MAX(File_CrimCharges,ecl_charge_id));
	
	
	 // output((File_CrimCharges(ecl_charge_id= 0)));

