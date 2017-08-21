






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



														
File_CaseMaster := dataset('~thor_data400::out::crim::cross_aoc_and_county::case_master200'+ crim_common.version_development, Layout_case_master,
            						                                        CSV(SEPARATOR(['|#~|']), TERMINATOR(['\n','\r\n','\n\r']),QUOTE('[]')      ));		

	
output(File_CaseMaster(old_record_supplier_cd_c ='AZGI'),NAMED('AZGI'));
output(File_CaseMaster(old_record_supplier_cd_c ='AZMC'),NAMED('AZMC'));
output(File_CaseMaster(old_record_supplier_cd_c ='AZPI'),NAMED('AZPI'));
output(File_CaseMaster(old_record_supplier_cd_c ='CACO'),NAMED('CACO'));
output(File_CaseMaster(old_record_supplier_cd_c ='CAFR'),NAMED('CAFR'));
output(File_CaseMaster(old_record_supplier_cd_c ='CALA'),NAMED('CALA'));
output(File_CaseMaster(old_record_supplier_cd_c ='CAMA'),NAMED('CAMA'));
output(File_CaseMaster(old_record_supplier_cd_c ='CAOR'),NAMED('CAOR'));
output(File_CaseMaster(old_record_supplier_cd_c ='CARI'),NAMED('CARI'));
output(File_CaseMaster(old_record_supplier_cd_c ='CAIN'),NAMED('CAIN'));
output(File_CaseMaster(old_record_supplier_cd_c ='CABA'),NAMED('CABA'));
output(File_CaseMaster(old_record_supplier_cd_c ='CACL'),NAMED('CACL'));
output(File_CaseMaster(old_record_supplier_cd_c ='CASC'),NAMED('CASC'));
output(File_CaseMaster(old_record_supplier_cd_c ='CASB'),NAMED('CASB'));
output(File_CaseMaster(old_record_supplier_cd_c ='CASD'),NAMED('CASD'));
output(File_CaseMaster(old_record_supplier_cd_c ='CAVE'),NAMED('CAVE'));
output(File_CaseMaster(old_record_supplier_cd_c ='FLAN'),NAMED('FLAN'));
output(File_CaseMaster(old_record_supplier_cd_c ='FLBA'),NAMED('FLBA'));
output(File_CaseMaster(old_record_supplier_cd_c ='FLBR'),NAMED('FLBR'));
output(File_CaseMaster(old_record_supplier_cd_c ='FLBO'),NAMED('FLBO'));
output(File_CaseMaster(old_record_supplier_cd_c ='FLCH'),NAMED('FLCH'));
output(File_CaseMaster(old_record_supplier_cd_c ='FLDA'),NAMED('FLDA'));
output(File_CaseMaster(old_record_supplier_cd_c ='FLDU'),NAMED('FLDU'));
output(File_CaseMaster(old_record_supplier_cd_c ='FLHE'),NAMED('FLHE'));
output(File_CaseMaster(old_record_supplier_cd_c ='FLHI'),NAMED('FLHI'));
output(File_CaseMaster(old_record_supplier_cd_c ='FLHL'),NAMED('FLHL'));
output(File_CaseMaster(old_record_supplier_cd_c ='FLLE'),NAMED('FLLE'));
output(File_CaseMaster(old_record_supplier_cd_c ='FLLN'),NAMED('FLLN'));
output(File_CaseMaster(old_record_supplier_cd_c ='FLMR'),NAMED('FLMR'));
output(File_CaseMaster(old_record_supplier_cd_c ='FLME'),NAMED('FLME'));
output(File_CaseMaster(old_record_supplier_cd_c ='FLOR'),NAMED('FLOR'));
output(File_CaseMaster(old_record_supplier_cd_c ='FLOS'),NAMED('FLOS'));
output(File_CaseMaster(old_record_supplier_cd_c ='FLPB'),NAMED('FLPB'));
output(File_CaseMaster(old_record_supplier_cd_c ='FLPI'),NAMED('FLPI'));
output(File_CaseMaster(old_record_supplier_cd_c ='FLSA'),NAMED('FLSA'));
output(File_CaseMaster(old_record_supplier_cd_c ='GACB'),NAMED('GACB'));
output(File_CaseMaster(old_record_supplier_cd_c ='GAGW'),NAMED('GAGW'));
output(File_CaseMaster(old_record_supplier_cd_c ='ILCK'),NAMED('ILCK'));
output(File_CaseMaster(old_record_supplier_cd_c ='LAST'),NAMED('LAST'));
output(File_CaseMaster(old_record_supplier_cd_c ='MIWA'),NAMED('MIWA'));
output(File_CaseMaster(old_record_supplier_cd_c ='MSHN'),NAMED('MSHN'));
output(File_CaseMaster(old_record_supplier_cd_c ='OHLE'),NAMED('OHLE'));
output(File_CaseMaster(old_record_supplier_cd_c ='OHVA'),NAMED('OHVA'));
output(File_CaseMaster(old_record_supplier_cd_c ='OHDA'),NAMED('OHDA'));
output(File_CaseMaster(old_record_supplier_cd_c ='OHFL'),NAMED('OHFL'));
output(File_CaseMaster(old_record_supplier_cd_c ='OHNE'),NAMED('OHNE'));
output(File_CaseMaster(old_record_supplier_cd_c ='OHAX'),NAMED('OHAX'));
output(File_CaseMaster(old_record_supplier_cd_c ='OHAL'),NAMED('OHAL'));
output(File_CaseMaster(old_record_supplier_cd_c ='OHAT'),NAMED('OHAT'));
output(File_CaseMaster(old_record_supplier_cd_c ='OHBR'),NAMED('OHBR'));
output(File_CaseMaster(old_record_supplier_cd_c ='OHBU'),NAMED('OHBU'));
output(File_CaseMaster(old_record_supplier_cd_c ='OHCL'),NAMED('OHCL'));
output(File_CaseMaster(old_record_supplier_cd_c ='OHCT'),NAMED('OHCT'));
output(File_CaseMaster(old_record_supplier_cd_c ='OHCM'),NAMED('OHCM'));
output(File_CaseMaster(old_record_supplier_cd_c ='OHBE'),NAMED('OHBE'));
output(File_CaseMaster(old_record_supplier_cd_c ='OHEU'),NAMED('OHEU'));
output(File_CaseMaster(old_record_supplier_cd_c ='OHDE'),NAMED('OHDE'));
output(File_CaseMaster(old_record_supplier_cd_c ='OHFR'),NAMED('OHFR'));
output(File_CaseMaster(old_record_supplier_cd_c ='OHFK'),NAMED('OHFK'));
output(File_CaseMaster(old_record_supplier_cd_c ='OHFU'),NAMED('OHFU'));
output(File_CaseMaster(old_record_supplier_cd_c ='OHGR'),NAMED('OHGR'));
output(File_CaseMaster(old_record_supplier_cd_c ='OHXE'),NAMED('OHXE'));
output(File_CaseMaster(old_record_supplier_cd_c ='OHLA'),NAMED('OHLA'));
output(File_CaseMaster(old_record_supplier_cd_c ='OHLI'),NAMED('OHLI'));
output(File_CaseMaster(old_record_supplier_cd_c ='OHHU'),NAMED('OHHU'));
output(File_CaseMaster(old_record_supplier_cd_c ='OHKE'),NAMED('OHKE'));
output(File_CaseMaster(old_record_supplier_cd_c ='OHMO'),NAMED('OHMO'));
output(File_CaseMaster(old_record_supplier_cd_c ='OHPO'),NAMED('OHPO'));
output(File_CaseMaster(old_record_supplier_cd_c ='OHRO'),NAMED('OHRO'));
output(File_CaseMaster(old_record_supplier_cd_c ='OHRC'),NAMED('OHRC'));
output(File_CaseMaster(old_record_supplier_cd_c ='OHSR'),NAMED('OHSR'));
output(File_CaseMaster(old_record_supplier_cd_c ='OHST'),NAMED('OHST'));
output(File_CaseMaster(old_record_supplier_cd_c ='OHAK'),NAMED('OHAK'));
output(File_CaseMaster(old_record_supplier_cd_c ='OHSM'),NAMED('OHSM'));
output(File_CaseMaster(old_record_supplier_cd_c ='OHBA'),NAMED('OHBA'));
output(File_CaseMaster(old_record_supplier_cd_c ='OHTR'),NAMED('OHTR'));
output(File_CaseMaster(old_record_supplier_cd_c ='OHTU'),NAMED('OHTU'));
output(File_CaseMaster(old_record_supplier_cd_c ='OHWA'),NAMED('OHWA'));
output(File_CaseMaster(old_record_supplier_cd_c ='OHWR'),NAMED('OHWR'));
output(File_CaseMaster(old_record_supplier_cd_c ='OHMA'),NAMED('OHMA'));
output(File_CaseMaster(old_record_supplier_cd_c ='SCRI'),NAMED('SCRI'));
output(File_CaseMaster(old_record_supplier_cd_c ='TXBE'),NAMED('TXBE'));
output(File_CaseMaster(old_record_supplier_cd_c ='TXBR'),NAMED('TXBR'));
output(File_CaseMaster(old_record_supplier_cd_c ='TXCL'),NAMED('TXCL'));
output(File_CaseMaster(old_record_supplier_cd_c ='TXDL'),NAMED('TXDL'));
output(File_CaseMaster(old_record_supplier_cd_c ='TXDT'),NAMED('TXDT'));
output(File_CaseMaster(old_record_supplier_cd_c ='TXEP'),NAMED('TXEP'));
output(File_CaseMaster(old_record_supplier_cd_c ='TXFB'),NAMED('TXFB'));
output(File_CaseMaster(old_record_supplier_cd_c ='TXGR'),NAMED('TXGR'));
output(File_CaseMaster(old_record_supplier_cd_c ='TXHR'),NAMED('TXHR'));
output(File_CaseMaster(old_record_supplier_cd_c ='TXJE'),NAMED('TXJE'));
output(File_CaseMaster(old_record_supplier_cd_c ='TXJO'),NAMED('TXJO'));
output(File_CaseMaster(old_record_supplier_cd_c ='TXMD'),NAMED('TXMD'));
output(File_CaseMaster(old_record_supplier_cd_c ='TXMG'),NAMED('TXMG'));
output(File_CaseMaster(old_record_supplier_cd_c ='TXPO'),NAMED('TXPO'));
output(File_CaseMaster(old_record_supplier_cd_c ='TXVC'),NAMED('TXVC'));
output(File_CaseMaster(old_record_supplier_cd_c ='VAFA'),NAMED('VAFA'));
    
																														
  output(MIN(File_CaseMaster,cama_id));
	output(MIN(File_CaseMaster,ecl_cade_id));

  output(MAX(File_CaseMaster,cama_id));
	output(MAX(File_CaseMaster,ecl_cade_id));
	
		 output((File_CaseMaster(cama_id=0)));
	 output((File_CaseMaster(ecl_cade_id=0)));
	
	// output((File_CaseMaster(cama_id =167760417)));
	
	output(File_CaseMaster(subject_type_flg_c = 'A'));
	
	// output(choosen(File_CaseMaster(subject_last_name_c = ''),1000));						
 // output(count(File_CaseMaster(subject_last_name_c = '' and subject_type_flg_c = 'A')));																										
 // output(count(File_CaseMaster(subject_last_name_c = '' and subject_type_flg_c = '')));		



















