
import crim_common;



export layout_cross_additional_information := RECORD
INTEGER 	ADIN_ID;
String600 NARRATIVE_INFORMATION;
INTEGER 	ecl_cade_id;
String15	CREATED_BY;
STRING8 	CREATION_DT;
String15 	LAST_UPDATED_BY;
STRING8 	LAST_UPDATE_DT;
String4 	RECORD_SUPPLIER_CD;
string10 	BATCH_NUMBER;
String4   OLD_RECORD_SUPPLIER_CD;
END;


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

																												
File_AddInfo := dataset('~thor_data400::out::crim::cross_soff::additional_information'+ crim_common.version_development, layout_cross_additional_information,
            						                                    CSV(SEPARATOR(['|#~|']), TERMINATOR(['\n','\r\n','\n\r']),QUOTE('[]')));		
																																																										
																								
File_CaseMaster := dedup(dataset('~thor_data400::out::crim::cross_soff::case_master'+ crim_common.version_development, Layout_case_master,
            						                                        CSV(SEPARATOR(['|#~|']), TERMINATOR(['\n','\r\n','\n\r']),QUOTE('[]'))),ecl_cade_id);		
 
 
 layout_cross_additional_information   tr_get_add_info(File_AddInfo L , File_CaseMaster R) := TRANSFORM
SELF := L;
END;																												
		
		output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340017' and source_state_cd_c = 'AK'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('AK'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340016' and source_state_cd_c = 'AL'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('AL'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340203' and source_state_cd_c = 'AR'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('AR'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340019' and source_state_cd_c = 'AZ'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('AZ'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340329' and source_state_cd_c = 'CA'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('CA'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340021' and source_state_cd_c = 'CO'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('CO'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340091' and source_state_cd_c = 'CT'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('CT'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340024' and source_state_cd_c = 'DC'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('DC'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340023' and source_state_cd_c = 'DE'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('DE'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340026' and source_state_cd_c = 'FL'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('FL'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340029' and source_state_cd_c = 'GA'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('GA'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340330' and source_state_cd_c = 'HI'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('HI'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340036' and source_state_cd_c = 'IA'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('IA'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340093' and source_state_cd_c = 'ID'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('ID'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340032' and source_state_cd_c = 'IL'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('IL'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340034' and source_state_cd_c = 'IN'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('IN'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340038' and source_state_cd_c = 'KS'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('KS'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340040' and source_state_cd_c = 'KY'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('KY'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340041' and source_state_cd_c = 'LA'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('LA'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340324' and source_state_cd_c = 'MA'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('MA'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340046' and source_state_cd_c = 'MD'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('MD'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340196' and source_state_cd_c = 'ME'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('ME'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340047' and source_state_cd_c = 'MI'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('MI'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340094' and source_state_cd_c = 'MN'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('MN'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340365' and source_state_cd_c = 'MO'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('MO'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340375' and source_state_cd_c = 'MS'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('MS'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340052' and source_state_cd_c = 'MT'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('MT'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340067' and source_state_cd_c = 'NC'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('NC'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340068' and source_state_cd_c = 'ND'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('ND'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340054' and source_state_cd_c = 'NE'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('NE'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340056' and source_state_cd_c = 'NH'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('NH'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340092' and source_state_cd_c = 'NJ'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('NJ'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340061' and source_state_cd_c = 'NM'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('NM'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340366' and source_state_cd_c = 'NV'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('NV'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340064' and source_state_cd_c = 'NY'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('NY'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340197' and source_state_cd_c = 'OH'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('OH'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340071' and source_state_cd_c = 'OK'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('OK'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340371' and source_state_cd_c = 'OR'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('OR'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340205' and source_state_cd_c = 'PA'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('PA'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340367' and source_state_cd_c = 'RI'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('RI'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340075' and source_state_cd_c = 'SC'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('SC'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340372' and source_state_cd_c = 'SD'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('SD'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340077' and source_state_cd_c = 'TN'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('TN'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340079' and source_state_cd_c = 'TX'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('TX'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340204' and source_state_cd_c = 'UT'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('UT'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340083' and source_state_cd_c = 'VA'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('VA'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340332' and source_state_cd_c = 'VT'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('VT'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340323' and source_state_cd_c = 'WA'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('WA'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340089' and source_state_cd_c = 'WI'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('WI'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340087' and source_state_cd_c = 'WV'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('WV'));
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340090' and source_state_cd_c = 'WY'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('WY'));
																																
    output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340431' and source_state_cd_c = 'GA'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('GA_GBI'));
		output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340368' and source_state_cd_c = 'GU'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('GU'));
		output(join(File_AddInfo,File_CaseMaster(source_uid_c = '340388' and source_state_cd_c = 'PR'), LEFT.ecl_cade_id = RIGHT.ecl_cade_id, tr_get_add_info(LEFT,RIGHT)),NAMED('PR'));
		
		
 output(MIN(File_AddInfo,ecl_cade_id));  
 output(MIN(File_AddInfo,ADIN_ID));

 output(MAX(File_AddInfo,ecl_cade_id));
 output(MAX(File_AddInfo,ADIN_ID));
	
 output(File_AddInfo(ecl_cade_id = 0));
 output(File_AddInfo(ADIN_ID = 0));

