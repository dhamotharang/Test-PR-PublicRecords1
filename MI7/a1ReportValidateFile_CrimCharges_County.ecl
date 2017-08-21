




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

   
																															
File_CrimCharges := dataset('~thor_data400::out::crim::cross_aoc_and_county::criminal_charges200'+ crim_common.version_development, Layout_criminal_charges,
            						                                      CSV(SEPARATOR(['|#~|']), TERMINATOR(['\n','\r\n','\n\r']),QUOTE('[]')      ));		
																															


//output(File_CrimCharges(ecl_charge_id = 179535199));


//output(count(File_CrimCharges(old_record_supplier_cd ='NCDO')));

//output(File_CrimCharges(_validate.date.fIsValid(l.ADMIT_DT_C)=false);

//output(File_CrimCharges(ecl_charge_id =118311910));


// output(count(File_CrimCharges(_validate.date.fIsValid(l.ADMIT_DT_C)=false  
                                           // or   _validate.date.fIsValid(l.CONVICT_DT_C)=true ));
																					 
// output(count(File_CrimCharges(_validate.date.fIsValid(l.ADMIT_DT_C)=true  
                                           // or   _validate.date.fIsValid(l.CONVICT_DT_C)=false ));																				 


output(File_CrimCharges(old_record_supplier_cd ='AZGI'),NAMED('AZGI'));
output(File_CrimCharges(old_record_supplier_cd ='AZMC'),NAMED('AZMC'));
output(File_CrimCharges(old_record_supplier_cd ='AZPI'),NAMED('AZPI'));
output(File_CrimCharges(old_record_supplier_cd ='CACO'),NAMED('CACO'));
output(File_CrimCharges(old_record_supplier_cd ='CAFR'),NAMED('CAFR'));
output(File_CrimCharges(old_record_supplier_cd ='CALA'),NAMED('CALA'));
output(File_CrimCharges(old_record_supplier_cd ='CAMA'),NAMED('CAMA'));
output(File_CrimCharges(old_record_supplier_cd ='CAOR'),NAMED('CAOR'));
output(File_CrimCharges(old_record_supplier_cd ='CARI'),NAMED('CARI'));
output(File_CrimCharges(old_record_supplier_cd ='CAIN'),NAMED('CAIN'));
output(File_CrimCharges(old_record_supplier_cd ='CABA'),NAMED('CABA'));
output(File_CrimCharges(old_record_supplier_cd ='CACL'),NAMED('CACL'));
output(File_CrimCharges(old_record_supplier_cd ='CASC'),NAMED('CASC'));
output(File_CrimCharges(old_record_supplier_cd ='CASB'),NAMED('CASB'));
output(File_CrimCharges(old_record_supplier_cd ='CASD'),NAMED('CASD'));
output(File_CrimCharges(old_record_supplier_cd ='CAVE'),NAMED('CAVE'));
output(File_CrimCharges(old_record_supplier_cd ='FLAN'),NAMED('FLAN'));
output(File_CrimCharges(old_record_supplier_cd ='FLBA'),NAMED('FLBA'));
output(File_CrimCharges(old_record_supplier_cd ='FLBR'),NAMED('FLBR'));
output(File_CrimCharges(old_record_supplier_cd ='FLBO'),NAMED('FLBO'));
output(File_CrimCharges(old_record_supplier_cd ='FLCH'),NAMED('FLCH'));
output(File_CrimCharges(old_record_supplier_cd ='FLDA'),NAMED('FLDA'));
output(File_CrimCharges(old_record_supplier_cd ='FLDU'),NAMED('FLDU'));
output(File_CrimCharges(old_record_supplier_cd ='FLHE'),NAMED('FLHE'));
output(File_CrimCharges(old_record_supplier_cd ='FLHI'),NAMED('FLHI'));
output(File_CrimCharges(old_record_supplier_cd ='FLHL'),NAMED('FLHL'));
output(File_CrimCharges(old_record_supplier_cd ='FLLE'),NAMED('FLLE'));
output(File_CrimCharges(old_record_supplier_cd ='FLLN'),NAMED('FLLN'));
output(File_CrimCharges(old_record_supplier_cd ='FLMR'),NAMED('FLMR'));
output(File_CrimCharges(old_record_supplier_cd ='FLME'),NAMED('FLME'));
output(File_CrimCharges(old_record_supplier_cd ='FLOR'),NAMED('FLOR'));
output(File_CrimCharges(old_record_supplier_cd ='FLOS'),NAMED('FLOS'));
output(File_CrimCharges(old_record_supplier_cd ='FLPB'),NAMED('FLPB'));
output(File_CrimCharges(old_record_supplier_cd ='FLPI'),NAMED('FLPI'));
output(File_CrimCharges(old_record_supplier_cd ='FLSA'),NAMED('FLSA'));
output(File_CrimCharges(old_record_supplier_cd ='GACB'),NAMED('GACB'));
output(File_CrimCharges(old_record_supplier_cd ='GAGW'),NAMED('GAGW'));
output(File_CrimCharges(old_record_supplier_cd ='ILCK'),NAMED('ILCK'));
output(File_CrimCharges(old_record_supplier_cd ='LAST'),NAMED('LAST'));
output(File_CrimCharges(old_record_supplier_cd ='MIWA'),NAMED('MIWA'));
output(File_CrimCharges(old_record_supplier_cd ='MSHN'),NAMED('MSHN'));
output(File_CrimCharges(old_record_supplier_cd ='OHLE'),NAMED('OHLE'));
output(File_CrimCharges(old_record_supplier_cd ='OHVA'),NAMED('OHVA'));
output(File_CrimCharges(old_record_supplier_cd ='OHDA'),NAMED('OHDA'));
output(File_CrimCharges(old_record_supplier_cd ='OHFL'),NAMED('OHFL'));
output(File_CrimCharges(old_record_supplier_cd ='OHNE'),NAMED('OHNE'));
output(File_CrimCharges(old_record_supplier_cd ='OHAX'),NAMED('OHAX'));
output(File_CrimCharges(old_record_supplier_cd ='OHAL'),NAMED('OHAL'));
output(File_CrimCharges(old_record_supplier_cd ='OHAT'),NAMED('OHAT'));
output(File_CrimCharges(old_record_supplier_cd ='OHBR'),NAMED('OHBR'));
output(File_CrimCharges(old_record_supplier_cd ='OHBU'),NAMED('OHBU'));
output(File_CrimCharges(old_record_supplier_cd ='OHCL'),NAMED('OHCL'));
output(File_CrimCharges(old_record_supplier_cd ='OHCT'),NAMED('OHCT'));
output(File_CrimCharges(old_record_supplier_cd ='OHCM'),NAMED('OHCM'));
output(File_CrimCharges(old_record_supplier_cd ='OHBE'),NAMED('OHBE'));
output(File_CrimCharges(old_record_supplier_cd ='OHEU'),NAMED('OHEU'));
output(File_CrimCharges(old_record_supplier_cd ='OHDE'),NAMED('OHDE'));
output(File_CrimCharges(old_record_supplier_cd ='OHFR'),NAMED('OHFR'));
output(File_CrimCharges(old_record_supplier_cd ='OHFK'),NAMED('OHFK'));
output(File_CrimCharges(old_record_supplier_cd ='OHFU'),NAMED('OHFU'));
output(File_CrimCharges(old_record_supplier_cd ='OHGR'),NAMED('OHGR'));
output(File_CrimCharges(old_record_supplier_cd ='OHXE'),NAMED('OHXE'));
output(File_CrimCharges(old_record_supplier_cd ='OHLA'),NAMED('OHLA'));
output(File_CrimCharges(old_record_supplier_cd ='OHLI'),NAMED('OHLI'));
output(File_CrimCharges(old_record_supplier_cd ='OHHU'),NAMED('OHHU'));
output(File_CrimCharges(old_record_supplier_cd ='OHKE'),NAMED('OHKE'));
output(File_CrimCharges(old_record_supplier_cd ='OHMO'),NAMED('OHMO'));
output(File_CrimCharges(old_record_supplier_cd ='OHPO'),NAMED('OHPO'));
output(File_CrimCharges(old_record_supplier_cd ='OHRO'),NAMED('OHRO'));
output(File_CrimCharges(old_record_supplier_cd ='OHRC'),NAMED('OHRC'));
output(File_CrimCharges(old_record_supplier_cd ='OHSR'),NAMED('OHSR'));
output(File_CrimCharges(old_record_supplier_cd ='OHST'),NAMED('OHST'));
output(File_CrimCharges(old_record_supplier_cd ='OHAK'),NAMED('OHAK'));
output(File_CrimCharges(old_record_supplier_cd ='OHSM'),NAMED('OHSM'));
output(File_CrimCharges(old_record_supplier_cd ='OHBA'),NAMED('OHBA'));
output(File_CrimCharges(old_record_supplier_cd ='OHTR'),NAMED('OHTR'));
output(File_CrimCharges(old_record_supplier_cd ='OHTU'),NAMED('OHTU'));
output(File_CrimCharges(old_record_supplier_cd ='OHWA'),NAMED('OHWA'));
output(File_CrimCharges(old_record_supplier_cd ='OHWR'),NAMED('OHWR'));
output(File_CrimCharges(old_record_supplier_cd ='OHMA'),NAMED('OHMA'));
output(File_CrimCharges(old_record_supplier_cd ='SCRI'),NAMED('SCRI'));
output(File_CrimCharges(old_record_supplier_cd ='TXBE'),NAMED('TXBE'));
output(File_CrimCharges(old_record_supplier_cd ='TXBR'),NAMED('TXBR'));
output(File_CrimCharges(old_record_supplier_cd ='TXCL'),NAMED('TXCL'));
output(File_CrimCharges(old_record_supplier_cd ='TXDL'),NAMED('TXDL'));
output(File_CrimCharges(old_record_supplier_cd ='TXDT'),NAMED('TXDT'));
output(File_CrimCharges(old_record_supplier_cd ='TXEP'),NAMED('TXEP'));
output(File_CrimCharges(old_record_supplier_cd ='TXFB'),NAMED('TXFB'));
output(File_CrimCharges(old_record_supplier_cd ='TXGR'),NAMED('TXGR'));
output(File_CrimCharges(old_record_supplier_cd ='TXHR'),NAMED('TXHR'));
output(File_CrimCharges(old_record_supplier_cd ='TXJE'),NAMED('TXJE'));
output(File_CrimCharges(old_record_supplier_cd ='TXJO'),NAMED('TXJO'));
output(File_CrimCharges(old_record_supplier_cd ='TXMD'),NAMED('TXMD'));
output(File_CrimCharges(old_record_supplier_cd ='TXMG'),NAMED('TXMG'));
output(File_CrimCharges(old_record_supplier_cd ='TXPO'),NAMED('TXPO'));
output(File_CrimCharges(old_record_supplier_cd ='TXVC'),NAMED('TXVC'));
output(File_CrimCharges(old_record_supplier_cd ='VAFA'),NAMED('VAFA'));



//output(File_CrimCharges(ecl_charge_id = 7374));
//output(File_CrimCharges(ecl_charge_id = 179542573));


//output(File_CrimCharges(ecl_charge_id = 179542574));


 output(MIN(File_CrimCharges,ecl_charge_id));

  output(MAX(File_CrimCharges,ecl_charge_id));
	
	
	  output((File_CrimCharges(ecl_charge_id= 0)));

