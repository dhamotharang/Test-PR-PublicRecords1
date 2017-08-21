import crim_common;


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


														
																												
File_CrimSupp := dataset('~thor_data400::out::crim::cross_aoc_and_county::criminal_supplimental'+ crim_common.version_development, Layout_criminal_supplimental,
            						                                    CSV(SEPARATOR(['|#~|']), TERMINATOR(['\n','\r\n','\n\r']),QUOTE('[]')      ));		
																															
																												
output(File_CrimSupp(old_record_supplier_cd ='AKCR'),NAMED('AKCR'));
output(File_CrimSupp(old_record_supplier_cd ='ARCR'),NAMED('ARCR'));
output(File_CrimSupp(old_record_supplier_cd ='AZCR'),NAMED('AZCR'));
output(File_CrimSupp(old_record_supplier_cd ='CTCR'),NAMED('CTCR'));
output(File_CrimSupp(old_record_supplier_cd ='FLCR'),NAMED('FLCR'));
output(File_CrimSupp(old_record_supplier_cd ='GAGB'),NAMED('GAGB'));    
output(File_CrimSupp(old_record_supplier_cd ='IAOC'),NAMED('IAOC'));
output(File_CrimSupp(old_record_supplier_cd ='INCR'),NAMED('INCR'));
    
output(File_CrimSupp(old_record_supplier_cd ='MOCR'),NAMED('MOCR'));
output(File_CrimSupp(old_record_supplier_cd ='NCCR'),NAMED('NCCR'));
output(File_CrimSupp(old_record_supplier_cd ='NDCR'),NAMED('NDCR'));
output(File_CrimSupp(old_record_supplier_cd ='NJCR'),NAMED('NJCR'));
    
output(File_CrimSupp(old_record_supplier_cd ='OKCR'),NAMED('OKCR'));
output(File_CrimSupp(old_record_supplier_cd ='ORCR'),NAMED('ORCR'));
output(File_CrimSupp(old_record_supplier_cd ='PACR'),NAMED('PACR'));
output(File_CrimSupp(old_record_supplier_cd ='PACP'),NAMED('PACP'));
output(File_CrimSupp(old_record_supplier_cd ='RICR'),NAMED('RICR'));
output(File_CrimSupp(old_record_supplier_cd ='RITR'),NAMED('RITR'));
output(File_CrimSupp(old_record_supplier_cd ='TNCR'),NAMED('TNCR'));
output(File_CrimSupp(old_record_supplier_cd ='TXDP'),NAMED('TXDP'));
output(File_CrimSupp(old_record_supplier_cd ='UTCR'),NAMED('UTCR'));
output(File_CrimSupp(old_record_supplier_cd ='VACR'),NAMED('VACR'));
output(File_CrimSupp(old_record_supplier_cd ='WICR'),NAMED('WICR'));

output(File_CrimSupp(old_record_supplier_cd ='HICR'),NAMED('HICR'));
output(File_CrimSupp(old_record_supplier_cd ='MDCR'),NAMED('MDCR'));
output(File_CrimSupp(old_record_supplier_cd ='NMCR'),NAMED('NMCR'));


  output(MIN(File_CrimSupp,crsu_id));
	output(MIN(File_CrimSupp,ecl_cade_id));

  output(MAX(File_CrimSupp,crsu_id));
	output(MAX(File_CrimSupp,ecl_cade_id));


