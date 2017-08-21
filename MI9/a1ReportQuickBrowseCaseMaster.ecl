





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

														
File_CaseMaster := dataset('~thor_data400::out::crim::cross_soff::case_master'+ crim_common.version_development, Layout_case_master,
            						                                        CSV(SEPARATOR(['|#~|']), TERMINATOR(['\n','\r\n','\n\r']),QUOTE('[]')));																																	
																																
    output(File_CaseMaster(source_uid_c = '340017' and 	source_state_cd_c = 'AK'),NAMED('AK'));
    output(File_CaseMaster(source_uid_c = '340016' and 	source_state_cd_c = 'AL'),NAMED('AL'));
    output(File_CaseMaster(source_uid_c = '340203' and source_state_cd_c = 'AR'),NAMED('AR'));
    output(File_CaseMaster(source_uid_c = '340019' and 	source_state_cd_c = 'AZ'),NAMED('AZ'));
    output(File_CaseMaster(source_uid_c = '340329' and 	source_state_cd_c = 'CA'),NAMED('CA'));
    output(File_CaseMaster(source_uid_c = '340021' and 	source_state_cd_c = 'CO'),NAMED('CO'));
    output(File_CaseMaster(source_uid_c = '340091' and 	source_state_cd_c = 'CT'),NAMED('CT'));
    output(File_CaseMaster(source_uid_c = '340024' and 	source_state_cd_c = 'DC'),NAMED('DC'));
    output(File_CaseMaster(source_uid_c = '340023' and 	source_state_cd_c = 'DE'),NAMED('DE'));
    output(File_CaseMaster(source_uid_c = '340026' and 	source_state_cd_c = 'FL'),NAMED('FL'));
    output(File_CaseMaster(source_uid_c = '340029' and 	source_state_cd_c = 'GA'),NAMED('GA'));
    output(File_CaseMaster(source_uid_c = '340330' and 	source_state_cd_c = 'HI'),NAMED('HI'));
    output(File_CaseMaster(source_uid_c = '340036' and 	source_state_cd_c = 'IA'),NAMED('IA'));
    output(File_CaseMaster(source_uid_c = '340093' and 	source_state_cd_c = 'ID'),NAMED('ID'));
    output(File_CaseMaster(source_uid_c = '340032' and 	source_state_cd_c = 'IL'),NAMED('IL'));
    output(File_CaseMaster(source_uid_c = '340034' and 	source_state_cd_c = 'IN'),NAMED('IN'));
    output(File_CaseMaster(source_uid_c = '340038' and 	source_state_cd_c = 'KS'),NAMED('KS'));
    output(File_CaseMaster(source_uid_c = '340040' and 	source_state_cd_c = 'KY'),NAMED('KY'));
    output(File_CaseMaster(source_uid_c = '340041' and 	source_state_cd_c = 'LA'),NAMED('LA'));
    output(File_CaseMaster(source_uid_c = '340324' and 	source_state_cd_c = 'MA'),NAMED('MA'));
    output(File_CaseMaster(source_uid_c = '340046' and 	source_state_cd_c = 'MD'),NAMED('MD'));
    output(File_CaseMaster(source_uid_c = '340196' and 	source_state_cd_c = 'ME'),NAMED('ME'));
    output(File_CaseMaster(source_uid_c = '340047' and 	source_state_cd_c = 'MI'),NAMED('MI'));
    output(File_CaseMaster(source_uid_c = '340094' and 	source_state_cd_c = 'MN'),NAMED('MN'));
    output(File_CaseMaster(source_uid_c = '340365' and 	source_state_cd_c = 'MO'),NAMED('MO'));
    output(File_CaseMaster(source_uid_c = '340375' and 	source_state_cd_c = 'MS'),NAMED('MS'));
    output(File_CaseMaster(source_uid_c = '340052' and 	source_state_cd_c = 'MT'),NAMED('MT'));
    output(File_CaseMaster(source_uid_c = '340067' and 	source_state_cd_c = 'NC'),NAMED('NC'));
    output(File_CaseMaster(source_uid_c = '340068' and 	source_state_cd_c = 'ND'),NAMED('ND'));
    output(File_CaseMaster(source_uid_c = '340054' and 	source_state_cd_c = 'NE'),NAMED('NE'));
    output(File_CaseMaster(source_uid_c = '340056' and 	source_state_cd_c = 'NH'),NAMED('NH'));
    output(File_CaseMaster(source_uid_c = '340092' and 	source_state_cd_c = 'NJ'),NAMED('NJ'));
    output(File_CaseMaster(source_uid_c = '340061' and 	source_state_cd_c = 'NM'),NAMED('NM'));
    output(File_CaseMaster(source_uid_c = '340366' and 	source_state_cd_c = 'NV'),NAMED('NV'));
    output(File_CaseMaster(source_uid_c = '340064' and 	source_state_cd_c = 'NY'),NAMED('NY'));
    output(File_CaseMaster(source_uid_c = '340197' and 	source_state_cd_c = 'OH'),NAMED('OH'));
    output(File_CaseMaster(source_uid_c = '340071' and 	source_state_cd_c = 'OK'),NAMED('OK'));
    output(File_CaseMaster(source_uid_c = '340371' and 	source_state_cd_c = 'OR'),NAMED('OR'));
    output(File_CaseMaster(source_uid_c = '340205' and 	source_state_cd_c = 'PA'),NAMED('PA'));
    output(File_CaseMaster(source_uid_c = '340367' and 	source_state_cd_c = 'RI'),NAMED('RI'));
    output(File_CaseMaster(source_uid_c = '340075' and 	source_state_cd_c = 'SC'),NAMED('SC'));
    output(File_CaseMaster(source_uid_c = '340372' and 	source_state_cd_c = 'SD'),NAMED('SD'));
    output(File_CaseMaster(source_uid_c = '340077' and 	source_state_cd_c = 'TN'),NAMED('TN'));
    output(File_CaseMaster(source_uid_c = '340079' and 	source_state_cd_c = 'TX'),NAMED('TX'));
    output(File_CaseMaster(source_uid_c = '340204' and 	source_state_cd_c = 'UT'),NAMED('UT'));
    output(File_CaseMaster(source_uid_c = '340083' and 	source_state_cd_c = 'VA'),NAMED('VA'));
    output(File_CaseMaster(source_uid_c = '340332' and 	source_state_cd_c = 'VT'),NAMED('VT'));
    output(File_CaseMaster(source_uid_c = '340323' and 	source_state_cd_c = 'WA'),NAMED('WA'));
    output(File_CaseMaster(source_uid_c = '340089' and 	source_state_cd_c = 'WI'),NAMED('WI'));
    output(File_CaseMaster(source_uid_c = '340087' and 	source_state_cd_c = 'WV'),NAMED('WV'));
    output(File_CaseMaster(source_uid_c = '340090' and 	source_state_cd_c = 'WY'),NAMED('WY'));
		
		output(File_CaseMaster(source_uid_c = '340431' and 	source_state_cd_c = 'GA'),NAMED('GA_GBI'));
		output(File_CaseMaster(source_uid_c = '340368' and 	source_state_cd_c = 'GU'),NAMED('GU'));
		output(File_CaseMaster(source_uid_c = '340388' and 	source_state_cd_c = 'PR'),NAMED('PR'));
		


  output(MIN(File_CaseMaster,cama_id));
	output(MIN(File_CaseMaster,ecl_cade_id));

  output(MAX(File_CaseMaster,cama_id));
	output(MAX(File_CaseMaster,ecl_cade_id));
	
	
		// output((File_CaseMaster(ecl_cade_id=0)));
	
	// output((File_CaseMaster(cama_id =167760417)));
	
	
	// output(choosen(File_CaseMaster(subject_last_name_c = ''),1000));						
 // output(count(File_CaseMaster(subject_last_name_c = '' and subject_type_flg_c = 'A')));																										
 // output(count(File_CaseMaster(subject_last_name_c = '' and subject_type_flg_c = '')));		
	






























