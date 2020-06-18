IMPORT SALT311;
IMPORT Scrubs,Scrubs_Crim; // Import modules for FieldTypes attribute definitions
EXPORT Moxie_Court_Offenses_Dev_Fields := MODULE
 
EXPORT NumFields := 97;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Current_Date','Invalid_Future_Date','Non_Blank','Invalid_Char','Invalid_Data_Type','Invalid_FCRAConFlag','Invalid_FCRATrafficFlag','Invalid_FCRADateFlag','Invalid_ConOverDateFlag','Invalid_OffenseScore','Invalid_Num','Invalid_CourtOffLev','Invalid_ArrOffLev');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_Current_Date' => 1,'Invalid_Future_Date' => 2,'Non_Blank' => 3,'Invalid_Char' => 4,'Invalid_Data_Type' => 5,'Invalid_FCRAConFlag' => 6,'Invalid_FCRATrafficFlag' => 7,'Invalid_FCRADateFlag' => 8,'Invalid_ConOverDateFlag' => 9,'Invalid_OffenseScore' => 10,'Invalid_Num' => 11,'Invalid_CourtOffLev' => 12,'Invalid_ArrOffLev' => 13,0);
 
EXPORT MakeFT_Invalid_Current_Date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Current_Date(SALT311.StrType s) := WHICH(~Scrubs.fn_valid_date(s)>0);
EXPORT InValidMessageFT_Invalid_Current_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Future_Date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Future_Date(SALT311.StrType s) := WHICH(~Scrubs.fn_valid_date(s,'future')>0);
EXPORT InValidMessageFT_Invalid_Future_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Non_Blank(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Non_Blank(SALT311.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_Non_Blank(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLength('1..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Char(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Char(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_Invalid_Char(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Data_Type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Data_Type(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['2','5']);
EXPORT InValidMessageFT_Invalid_Data_Type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('2|5'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_FCRAConFlag(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_FCRAConFlag(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['Y','N','U','']);
EXPORT InValidMessageFT_Invalid_FCRAConFlag(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('Y|N|U|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_FCRATrafficFlag(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_FCRATrafficFlag(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['N','Y','']);
EXPORT InValidMessageFT_Invalid_FCRATrafficFlag(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('N|Y|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_FCRADateFlag(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_FCRADateFlag(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['S','D','M','F','']);
EXPORT InValidMessageFT_Invalid_FCRADateFlag(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('S|D|M|F|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_ConOverDateFlag(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_ConOverDateFlag(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['D','F','O','A','S','M','']);
EXPORT InValidMessageFT_Invalid_ConOverDateFlag(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('D|F|O|A|S|M|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_OffenseScore(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_OffenseScore(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['U','F','M','I','']);
EXPORT InValidMessageFT_Invalid_OffenseScore(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('U|F|M|I|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Num(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_CourtOffLev(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_CourtOffLev(SALT311.StrType s) := WHICH(~Scrubs_Crim.fn_v3Code_check(s,'COURT_OFF_LEV','COURT_OFFENSES')>0);
EXPORT InValidMessageFT_Invalid_CourtOffLev(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Crim.fn_v3Code_check'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_ArrOffLev(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_ArrOffLev(SALT311.StrType s) := WHICH(~Scrubs_Crim.fn_v3Code_check(s,'ARR_OFF_LEV','COURT_OFFENSES')>0);
EXPORT InValidMessageFT_Invalid_ArrOffLev(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Crim.fn_v3Code_check'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'process_date','offender_key','vendor','state_origin','source_file','data_type','off_comp','off_delete_flag','off_date','arr_date','num_of_counts','le_agency_cd','le_agency_desc','le_agency_case_number','traffic_ticket_number','traffic_dl_no','traffic_dl_st','arr_off_code','arr_off_desc_1','arr_off_desc_2','arr_off_type_cd','arr_off_type_desc','arr_off_lev','arr_statute','arr_statute_desc','arr_disp_date','arr_disp_code','arr_disp_desc_1','arr_disp_desc_2','pros_refer_cd','pros_refer','pros_assgn_cd','pros_assgn','pros_chg_rej','pros_off_code','pros_off_desc_1','pros_off_desc_2','pros_off_type_cd','pros_off_type_desc','pros_off_lev','pros_act_filed','court_case_number','court_cd','court_desc','court_appeal_flag','court_final_plea','court_off_code','court_off_desc_1','court_off_desc_2','court_off_type_cd','court_off_type_desc','court_off_lev','court_statute','court_additional_statutes','court_statute_desc','court_disp_date','court_disp_code','court_disp_desc_1','court_disp_desc_2','sent_date','sent_jail','sent_susp_time','sent_court_cost','sent_court_fine','sent_susp_court_fine','sent_probation','sent_addl_prov_code','sent_addl_prov_desc_1','sent_addl_prov_desc_2','sent_consec','sent_agency_rec_cust_ori','sent_agency_rec_cust','appeal_date','appeal_off_disp','appeal_final_decision','convict_dt','offense_town','cty_conv','restitution','community_service','parole','addl_sent_dates','probation_desc2','court_dt','court_county','arr_off_lev_mapped','court_off_lev_mapped','fcra_offense_key','fcra_conviction_flag','fcra_traffic_flag','fcra_date','fcra_date_type','conviction_override_date','conviction_override_date_type','offense_score','offense_persistent_id','offense_category');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'process_date','offender_key','vendor','state_origin','source_file','data_type','off_comp','off_delete_flag','off_date','arr_date','num_of_counts','le_agency_cd','le_agency_desc','le_agency_case_number','traffic_ticket_number','traffic_dl_no','traffic_dl_st','arr_off_code','arr_off_desc_1','arr_off_desc_2','arr_off_type_cd','arr_off_type_desc','arr_off_lev','arr_statute','arr_statute_desc','arr_disp_date','arr_disp_code','arr_disp_desc_1','arr_disp_desc_2','pros_refer_cd','pros_refer','pros_assgn_cd','pros_assgn','pros_chg_rej','pros_off_code','pros_off_desc_1','pros_off_desc_2','pros_off_type_cd','pros_off_type_desc','pros_off_lev','pros_act_filed','court_case_number','court_cd','court_desc','court_appeal_flag','court_final_plea','court_off_code','court_off_desc_1','court_off_desc_2','court_off_type_cd','court_off_type_desc','court_off_lev','court_statute','court_additional_statutes','court_statute_desc','court_disp_date','court_disp_code','court_disp_desc_1','court_disp_desc_2','sent_date','sent_jail','sent_susp_time','sent_court_cost','sent_court_fine','sent_susp_court_fine','sent_probation','sent_addl_prov_code','sent_addl_prov_desc_1','sent_addl_prov_desc_2','sent_consec','sent_agency_rec_cust_ori','sent_agency_rec_cust','appeal_date','appeal_off_disp','appeal_final_decision','convict_dt','offense_town','cty_conv','restitution','community_service','parole','addl_sent_dates','probation_desc2','court_dt','court_county','arr_off_lev_mapped','court_off_lev_mapped','fcra_offense_key','fcra_conviction_flag','fcra_traffic_flag','fcra_date','fcra_date_type','conviction_override_date','conviction_override_date_type','offense_score','offense_persistent_id','offense_category');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'process_date' => 0,'offender_key' => 1,'vendor' => 2,'state_origin' => 3,'source_file' => 4,'data_type' => 5,'off_comp' => 6,'off_delete_flag' => 7,'off_date' => 8,'arr_date' => 9,'num_of_counts' => 10,'le_agency_cd' => 11,'le_agency_desc' => 12,'le_agency_case_number' => 13,'traffic_ticket_number' => 14,'traffic_dl_no' => 15,'traffic_dl_st' => 16,'arr_off_code' => 17,'arr_off_desc_1' => 18,'arr_off_desc_2' => 19,'arr_off_type_cd' => 20,'arr_off_type_desc' => 21,'arr_off_lev' => 22,'arr_statute' => 23,'arr_statute_desc' => 24,'arr_disp_date' => 25,'arr_disp_code' => 26,'arr_disp_desc_1' => 27,'arr_disp_desc_2' => 28,'pros_refer_cd' => 29,'pros_refer' => 30,'pros_assgn_cd' => 31,'pros_assgn' => 32,'pros_chg_rej' => 33,'pros_off_code' => 34,'pros_off_desc_1' => 35,'pros_off_desc_2' => 36,'pros_off_type_cd' => 37,'pros_off_type_desc' => 38,'pros_off_lev' => 39,'pros_act_filed' => 40,'court_case_number' => 41,'court_cd' => 42,'court_desc' => 43,'court_appeal_flag' => 44,'court_final_plea' => 45,'court_off_code' => 46,'court_off_desc_1' => 47,'court_off_desc_2' => 48,'court_off_type_cd' => 49,'court_off_type_desc' => 50,'court_off_lev' => 51,'court_statute' => 52,'court_additional_statutes' => 53,'court_statute_desc' => 54,'court_disp_date' => 55,'court_disp_code' => 56,'court_disp_desc_1' => 57,'court_disp_desc_2' => 58,'sent_date' => 59,'sent_jail' => 60,'sent_susp_time' => 61,'sent_court_cost' => 62,'sent_court_fine' => 63,'sent_susp_court_fine' => 64,'sent_probation' => 65,'sent_addl_prov_code' => 66,'sent_addl_prov_desc_1' => 67,'sent_addl_prov_desc_2' => 68,'sent_consec' => 69,'sent_agency_rec_cust_ori' => 70,'sent_agency_rec_cust' => 71,'appeal_date' => 72,'appeal_off_disp' => 73,'appeal_final_decision' => 74,'convict_dt' => 75,'offense_town' => 76,'cty_conv' => 77,'restitution' => 78,'community_service' => 79,'parole' => 80,'addl_sent_dates' => 81,'probation_desc2' => 82,'court_dt' => 83,'court_county' => 84,'arr_off_lev_mapped' => 85,'court_off_lev_mapped' => 86,'fcra_offense_key' => 87,'fcra_conviction_flag' => 88,'fcra_traffic_flag' => 89,'fcra_date' => 90,'fcra_date_type' => 91,'conviction_override_date' => 92,'conviction_override_date_type' => 93,'offense_score' => 94,'offense_persistent_id' => 95,'offense_category' => 96,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['LENGTHS'],['LENGTHS'],['ALLOW'],['LENGTHS'],[],[],[],['CUSTOM'],['CUSTOM'],[],[],[],[],[],[],[],[],[],[],[],[],['CUSTOM'],[],[],['CUSTOM'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],['CUSTOM'],[],[],[],['CUSTOM'],[],[],[],['CUSTOM'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],['CUSTOM'],[],[],[],[],[],[],[],['CUSTOM'],[],[],[],[],['ENUM'],['ENUM'],['CUSTOM'],['ENUM'],['CUSTOM'],['ENUM'],['ENUM'],['ALLOW'],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_process_date(SALT311.StrType s0) := MakeFT_Invalid_Current_Date(s0);
EXPORT InValid_process_date(SALT311.StrType s) := InValidFT_Invalid_Current_Date(s);
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Current_Date(wh);
 
EXPORT Make_offender_key(SALT311.StrType s0) := MakeFT_Non_Blank(s0);
EXPORT InValid_offender_key(SALT311.StrType s) := InValidFT_Non_Blank(s);
EXPORT InValidMessage_offender_key(UNSIGNED1 wh) := InValidMessageFT_Non_Blank(wh);
 
EXPORT Make_vendor(SALT311.StrType s0) := MakeFT_Non_Blank(s0);
EXPORT InValid_vendor(SALT311.StrType s) := InValidFT_Non_Blank(s);
EXPORT InValidMessage_vendor(UNSIGNED1 wh) := InValidMessageFT_Non_Blank(wh);
 
EXPORT Make_state_origin(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_state_origin(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_state_origin(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_source_file(SALT311.StrType s0) := MakeFT_Non_Blank(s0);
EXPORT InValid_source_file(SALT311.StrType s) := InValidFT_Non_Blank(s);
EXPORT InValidMessage_source_file(UNSIGNED1 wh) := InValidMessageFT_Non_Blank(wh);
 
EXPORT Make_data_type(SALT311.StrType s0) := s0;
EXPORT InValid_data_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_data_type(UNSIGNED1 wh) := '';
 
EXPORT Make_off_comp(SALT311.StrType s0) := s0;
EXPORT InValid_off_comp(SALT311.StrType s) := 0;
EXPORT InValidMessage_off_comp(UNSIGNED1 wh) := '';
 
EXPORT Make_off_delete_flag(SALT311.StrType s0) := s0;
EXPORT InValid_off_delete_flag(SALT311.StrType s) := 0;
EXPORT InValidMessage_off_delete_flag(UNSIGNED1 wh) := '';
 
EXPORT Make_off_date(SALT311.StrType s0) := MakeFT_Invalid_Current_Date(s0);
EXPORT InValid_off_date(SALT311.StrType s) := InValidFT_Invalid_Current_Date(s);
EXPORT InValidMessage_off_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Current_Date(wh);
 
EXPORT Make_arr_date(SALT311.StrType s0) := MakeFT_Invalid_Current_Date(s0);
EXPORT InValid_arr_date(SALT311.StrType s) := InValidFT_Invalid_Current_Date(s);
EXPORT InValidMessage_arr_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Current_Date(wh);
 
EXPORT Make_num_of_counts(SALT311.StrType s0) := s0;
EXPORT InValid_num_of_counts(SALT311.StrType s) := 0;
EXPORT InValidMessage_num_of_counts(UNSIGNED1 wh) := '';
 
EXPORT Make_le_agency_cd(SALT311.StrType s0) := s0;
EXPORT InValid_le_agency_cd(SALT311.StrType s) := 0;
EXPORT InValidMessage_le_agency_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_le_agency_desc(SALT311.StrType s0) := s0;
EXPORT InValid_le_agency_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_le_agency_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_le_agency_case_number(SALT311.StrType s0) := s0;
EXPORT InValid_le_agency_case_number(SALT311.StrType s) := 0;
EXPORT InValidMessage_le_agency_case_number(UNSIGNED1 wh) := '';
 
EXPORT Make_traffic_ticket_number(SALT311.StrType s0) := s0;
EXPORT InValid_traffic_ticket_number(SALT311.StrType s) := 0;
EXPORT InValidMessage_traffic_ticket_number(UNSIGNED1 wh) := '';
 
EXPORT Make_traffic_dl_no(SALT311.StrType s0) := s0;
EXPORT InValid_traffic_dl_no(SALT311.StrType s) := 0;
EXPORT InValidMessage_traffic_dl_no(UNSIGNED1 wh) := '';
 
EXPORT Make_traffic_dl_st(SALT311.StrType s0) := s0;
EXPORT InValid_traffic_dl_st(SALT311.StrType s) := 0;
EXPORT InValidMessage_traffic_dl_st(UNSIGNED1 wh) := '';
 
EXPORT Make_arr_off_code(SALT311.StrType s0) := s0;
EXPORT InValid_arr_off_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_arr_off_code(UNSIGNED1 wh) := '';
 
EXPORT Make_arr_off_desc_1(SALT311.StrType s0) := s0;
EXPORT InValid_arr_off_desc_1(SALT311.StrType s) := 0;
EXPORT InValidMessage_arr_off_desc_1(UNSIGNED1 wh) := '';
 
EXPORT Make_arr_off_desc_2(SALT311.StrType s0) := s0;
EXPORT InValid_arr_off_desc_2(SALT311.StrType s) := 0;
EXPORT InValidMessage_arr_off_desc_2(UNSIGNED1 wh) := '';
 
EXPORT Make_arr_off_type_cd(SALT311.StrType s0) := s0;
EXPORT InValid_arr_off_type_cd(SALT311.StrType s) := 0;
EXPORT InValidMessage_arr_off_type_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_arr_off_type_desc(SALT311.StrType s0) := s0;
EXPORT InValid_arr_off_type_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_arr_off_type_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_arr_off_lev(SALT311.StrType s0) := MakeFT_Invalid_ArrOffLev(s0);
EXPORT InValid_arr_off_lev(SALT311.StrType s) := InValidFT_Invalid_ArrOffLev(s);
EXPORT InValidMessage_arr_off_lev(UNSIGNED1 wh) := InValidMessageFT_Invalid_ArrOffLev(wh);
 
EXPORT Make_arr_statute(SALT311.StrType s0) := s0;
EXPORT InValid_arr_statute(SALT311.StrType s) := 0;
EXPORT InValidMessage_arr_statute(UNSIGNED1 wh) := '';
 
EXPORT Make_arr_statute_desc(SALT311.StrType s0) := s0;
EXPORT InValid_arr_statute_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_arr_statute_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_arr_disp_date(SALT311.StrType s0) := MakeFT_Invalid_Current_Date(s0);
EXPORT InValid_arr_disp_date(SALT311.StrType s) := InValidFT_Invalid_Current_Date(s);
EXPORT InValidMessage_arr_disp_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Current_Date(wh);
 
EXPORT Make_arr_disp_code(SALT311.StrType s0) := s0;
EXPORT InValid_arr_disp_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_arr_disp_code(UNSIGNED1 wh) := '';
 
EXPORT Make_arr_disp_desc_1(SALT311.StrType s0) := s0;
EXPORT InValid_arr_disp_desc_1(SALT311.StrType s) := 0;
EXPORT InValidMessage_arr_disp_desc_1(UNSIGNED1 wh) := '';
 
EXPORT Make_arr_disp_desc_2(SALT311.StrType s0) := s0;
EXPORT InValid_arr_disp_desc_2(SALT311.StrType s) := 0;
EXPORT InValidMessage_arr_disp_desc_2(UNSIGNED1 wh) := '';
 
EXPORT Make_pros_refer_cd(SALT311.StrType s0) := s0;
EXPORT InValid_pros_refer_cd(SALT311.StrType s) := 0;
EXPORT InValidMessage_pros_refer_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_pros_refer(SALT311.StrType s0) := s0;
EXPORT InValid_pros_refer(SALT311.StrType s) := 0;
EXPORT InValidMessage_pros_refer(UNSIGNED1 wh) := '';
 
EXPORT Make_pros_assgn_cd(SALT311.StrType s0) := s0;
EXPORT InValid_pros_assgn_cd(SALT311.StrType s) := 0;
EXPORT InValidMessage_pros_assgn_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_pros_assgn(SALT311.StrType s0) := s0;
EXPORT InValid_pros_assgn(SALT311.StrType s) := 0;
EXPORT InValidMessage_pros_assgn(UNSIGNED1 wh) := '';
 
EXPORT Make_pros_chg_rej(SALT311.StrType s0) := s0;
EXPORT InValid_pros_chg_rej(SALT311.StrType s) := 0;
EXPORT InValidMessage_pros_chg_rej(UNSIGNED1 wh) := '';
 
EXPORT Make_pros_off_code(SALT311.StrType s0) := s0;
EXPORT InValid_pros_off_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_pros_off_code(UNSIGNED1 wh) := '';
 
EXPORT Make_pros_off_desc_1(SALT311.StrType s0) := s0;
EXPORT InValid_pros_off_desc_1(SALT311.StrType s) := 0;
EXPORT InValidMessage_pros_off_desc_1(UNSIGNED1 wh) := '';
 
EXPORT Make_pros_off_desc_2(SALT311.StrType s0) := s0;
EXPORT InValid_pros_off_desc_2(SALT311.StrType s) := 0;
EXPORT InValidMessage_pros_off_desc_2(UNSIGNED1 wh) := '';
 
EXPORT Make_pros_off_type_cd(SALT311.StrType s0) := s0;
EXPORT InValid_pros_off_type_cd(SALT311.StrType s) := 0;
EXPORT InValidMessage_pros_off_type_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_pros_off_type_desc(SALT311.StrType s0) := s0;
EXPORT InValid_pros_off_type_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_pros_off_type_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_pros_off_lev(SALT311.StrType s0) := s0;
EXPORT InValid_pros_off_lev(SALT311.StrType s) := 0;
EXPORT InValidMessage_pros_off_lev(UNSIGNED1 wh) := '';
 
EXPORT Make_pros_act_filed(SALT311.StrType s0) := s0;
EXPORT InValid_pros_act_filed(SALT311.StrType s) := 0;
EXPORT InValidMessage_pros_act_filed(UNSIGNED1 wh) := '';
 
EXPORT Make_court_case_number(SALT311.StrType s0) := s0;
EXPORT InValid_court_case_number(SALT311.StrType s) := 0;
EXPORT InValidMessage_court_case_number(UNSIGNED1 wh) := '';
 
EXPORT Make_court_cd(SALT311.StrType s0) := s0;
EXPORT InValid_court_cd(SALT311.StrType s) := 0;
EXPORT InValidMessage_court_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_court_desc(SALT311.StrType s0) := s0;
EXPORT InValid_court_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_court_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_court_appeal_flag(SALT311.StrType s0) := s0;
EXPORT InValid_court_appeal_flag(SALT311.StrType s) := 0;
EXPORT InValidMessage_court_appeal_flag(UNSIGNED1 wh) := '';
 
EXPORT Make_court_final_plea(SALT311.StrType s0) := s0;
EXPORT InValid_court_final_plea(SALT311.StrType s) := 0;
EXPORT InValidMessage_court_final_plea(UNSIGNED1 wh) := '';
 
EXPORT Make_court_off_code(SALT311.StrType s0) := s0;
EXPORT InValid_court_off_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_court_off_code(UNSIGNED1 wh) := '';
 
EXPORT Make_court_off_desc_1(SALT311.StrType s0) := s0;
EXPORT InValid_court_off_desc_1(SALT311.StrType s) := 0;
EXPORT InValidMessage_court_off_desc_1(UNSIGNED1 wh) := '';
 
EXPORT Make_court_off_desc_2(SALT311.StrType s0) := s0;
EXPORT InValid_court_off_desc_2(SALT311.StrType s) := 0;
EXPORT InValidMessage_court_off_desc_2(UNSIGNED1 wh) := '';
 
EXPORT Make_court_off_type_cd(SALT311.StrType s0) := s0;
EXPORT InValid_court_off_type_cd(SALT311.StrType s) := 0;
EXPORT InValidMessage_court_off_type_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_court_off_type_desc(SALT311.StrType s0) := s0;
EXPORT InValid_court_off_type_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_court_off_type_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_court_off_lev(SALT311.StrType s0) := MakeFT_Invalid_CourtOffLev(s0);
EXPORT InValid_court_off_lev(SALT311.StrType s) := InValidFT_Invalid_CourtOffLev(s);
EXPORT InValidMessage_court_off_lev(UNSIGNED1 wh) := InValidMessageFT_Invalid_CourtOffLev(wh);
 
EXPORT Make_court_statute(SALT311.StrType s0) := s0;
EXPORT InValid_court_statute(SALT311.StrType s) := 0;
EXPORT InValidMessage_court_statute(UNSIGNED1 wh) := '';
 
EXPORT Make_court_additional_statutes(SALT311.StrType s0) := s0;
EXPORT InValid_court_additional_statutes(SALT311.StrType s) := 0;
EXPORT InValidMessage_court_additional_statutes(UNSIGNED1 wh) := '';
 
EXPORT Make_court_statute_desc(SALT311.StrType s0) := s0;
EXPORT InValid_court_statute_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_court_statute_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_court_disp_date(SALT311.StrType s0) := MakeFT_Invalid_Future_Date(s0);
EXPORT InValid_court_disp_date(SALT311.StrType s) := InValidFT_Invalid_Future_Date(s);
EXPORT InValidMessage_court_disp_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Future_Date(wh);
 
EXPORT Make_court_disp_code(SALT311.StrType s0) := s0;
EXPORT InValid_court_disp_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_court_disp_code(UNSIGNED1 wh) := '';
 
EXPORT Make_court_disp_desc_1(SALT311.StrType s0) := s0;
EXPORT InValid_court_disp_desc_1(SALT311.StrType s) := 0;
EXPORT InValidMessage_court_disp_desc_1(UNSIGNED1 wh) := '';
 
EXPORT Make_court_disp_desc_2(SALT311.StrType s0) := s0;
EXPORT InValid_court_disp_desc_2(SALT311.StrType s) := 0;
EXPORT InValidMessage_court_disp_desc_2(UNSIGNED1 wh) := '';
 
EXPORT Make_sent_date(SALT311.StrType s0) := MakeFT_Invalid_Future_Date(s0);
EXPORT InValid_sent_date(SALT311.StrType s) := InValidFT_Invalid_Future_Date(s);
EXPORT InValidMessage_sent_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Future_Date(wh);
 
EXPORT Make_sent_jail(SALT311.StrType s0) := s0;
EXPORT InValid_sent_jail(SALT311.StrType s) := 0;
EXPORT InValidMessage_sent_jail(UNSIGNED1 wh) := '';
 
EXPORT Make_sent_susp_time(SALT311.StrType s0) := s0;
EXPORT InValid_sent_susp_time(SALT311.StrType s) := 0;
EXPORT InValidMessage_sent_susp_time(UNSIGNED1 wh) := '';
 
EXPORT Make_sent_court_cost(SALT311.StrType s0) := s0;
EXPORT InValid_sent_court_cost(SALT311.StrType s) := 0;
EXPORT InValidMessage_sent_court_cost(UNSIGNED1 wh) := '';
 
EXPORT Make_sent_court_fine(SALT311.StrType s0) := s0;
EXPORT InValid_sent_court_fine(SALT311.StrType s) := 0;
EXPORT InValidMessage_sent_court_fine(UNSIGNED1 wh) := '';
 
EXPORT Make_sent_susp_court_fine(SALT311.StrType s0) := s0;
EXPORT InValid_sent_susp_court_fine(SALT311.StrType s) := 0;
EXPORT InValidMessage_sent_susp_court_fine(UNSIGNED1 wh) := '';
 
EXPORT Make_sent_probation(SALT311.StrType s0) := s0;
EXPORT InValid_sent_probation(SALT311.StrType s) := 0;
EXPORT InValidMessage_sent_probation(UNSIGNED1 wh) := '';
 
EXPORT Make_sent_addl_prov_code(SALT311.StrType s0) := s0;
EXPORT InValid_sent_addl_prov_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_sent_addl_prov_code(UNSIGNED1 wh) := '';
 
EXPORT Make_sent_addl_prov_desc_1(SALT311.StrType s0) := s0;
EXPORT InValid_sent_addl_prov_desc_1(SALT311.StrType s) := 0;
EXPORT InValidMessage_sent_addl_prov_desc_1(UNSIGNED1 wh) := '';
 
EXPORT Make_sent_addl_prov_desc_2(SALT311.StrType s0) := s0;
EXPORT InValid_sent_addl_prov_desc_2(SALT311.StrType s) := 0;
EXPORT InValidMessage_sent_addl_prov_desc_2(UNSIGNED1 wh) := '';
 
EXPORT Make_sent_consec(SALT311.StrType s0) := s0;
EXPORT InValid_sent_consec(SALT311.StrType s) := 0;
EXPORT InValidMessage_sent_consec(UNSIGNED1 wh) := '';
 
EXPORT Make_sent_agency_rec_cust_ori(SALT311.StrType s0) := s0;
EXPORT InValid_sent_agency_rec_cust_ori(SALT311.StrType s) := 0;
EXPORT InValidMessage_sent_agency_rec_cust_ori(UNSIGNED1 wh) := '';
 
EXPORT Make_sent_agency_rec_cust(SALT311.StrType s0) := s0;
EXPORT InValid_sent_agency_rec_cust(SALT311.StrType s) := 0;
EXPORT InValidMessage_sent_agency_rec_cust(UNSIGNED1 wh) := '';
 
EXPORT Make_appeal_date(SALT311.StrType s0) := s0;
EXPORT InValid_appeal_date(SALT311.StrType s) := 0;
EXPORT InValidMessage_appeal_date(UNSIGNED1 wh) := '';
 
EXPORT Make_appeal_off_disp(SALT311.StrType s0) := s0;
EXPORT InValid_appeal_off_disp(SALT311.StrType s) := 0;
EXPORT InValidMessage_appeal_off_disp(UNSIGNED1 wh) := '';
 
EXPORT Make_appeal_final_decision(SALT311.StrType s0) := s0;
EXPORT InValid_appeal_final_decision(SALT311.StrType s) := 0;
EXPORT InValidMessage_appeal_final_decision(UNSIGNED1 wh) := '';
 
EXPORT Make_convict_dt(SALT311.StrType s0) := MakeFT_Invalid_Current_Date(s0);
EXPORT InValid_convict_dt(SALT311.StrType s) := InValidFT_Invalid_Current_Date(s);
EXPORT InValidMessage_convict_dt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Current_Date(wh);
 
EXPORT Make_offense_town(SALT311.StrType s0) := s0;
EXPORT InValid_offense_town(SALT311.StrType s) := 0;
EXPORT InValidMessage_offense_town(UNSIGNED1 wh) := '';
 
EXPORT Make_cty_conv(SALT311.StrType s0) := s0;
EXPORT InValid_cty_conv(SALT311.StrType s) := 0;
EXPORT InValidMessage_cty_conv(UNSIGNED1 wh) := '';
 
EXPORT Make_restitution(SALT311.StrType s0) := s0;
EXPORT InValid_restitution(SALT311.StrType s) := 0;
EXPORT InValidMessage_restitution(UNSIGNED1 wh) := '';
 
EXPORT Make_community_service(SALT311.StrType s0) := s0;
EXPORT InValid_community_service(SALT311.StrType s) := 0;
EXPORT InValidMessage_community_service(UNSIGNED1 wh) := '';
 
EXPORT Make_parole(SALT311.StrType s0) := s0;
EXPORT InValid_parole(SALT311.StrType s) := 0;
EXPORT InValidMessage_parole(UNSIGNED1 wh) := '';
 
EXPORT Make_addl_sent_dates(SALT311.StrType s0) := s0;
EXPORT InValid_addl_sent_dates(SALT311.StrType s) := 0;
EXPORT InValidMessage_addl_sent_dates(UNSIGNED1 wh) := '';
 
EXPORT Make_probation_desc2(SALT311.StrType s0) := s0;
EXPORT InValid_probation_desc2(SALT311.StrType s) := 0;
EXPORT InValidMessage_probation_desc2(UNSIGNED1 wh) := '';
 
EXPORT Make_court_dt(SALT311.StrType s0) := MakeFT_Invalid_Future_Date(s0);
EXPORT InValid_court_dt(SALT311.StrType s) := InValidFT_Invalid_Future_Date(s);
EXPORT InValidMessage_court_dt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Future_Date(wh);
 
EXPORT Make_court_county(SALT311.StrType s0) := s0;
EXPORT InValid_court_county(SALT311.StrType s) := 0;
EXPORT InValidMessage_court_county(UNSIGNED1 wh) := '';
 
EXPORT Make_arr_off_lev_mapped(SALT311.StrType s0) := s0;
EXPORT InValid_arr_off_lev_mapped(SALT311.StrType s) := 0;
EXPORT InValidMessage_arr_off_lev_mapped(UNSIGNED1 wh) := '';
 
EXPORT Make_court_off_lev_mapped(SALT311.StrType s0) := s0;
EXPORT InValid_court_off_lev_mapped(SALT311.StrType s) := 0;
EXPORT InValidMessage_court_off_lev_mapped(UNSIGNED1 wh) := '';
 
EXPORT Make_fcra_offense_key(SALT311.StrType s0) := s0;
EXPORT InValid_fcra_offense_key(SALT311.StrType s) := 0;
EXPORT InValidMessage_fcra_offense_key(UNSIGNED1 wh) := '';
 
EXPORT Make_fcra_conviction_flag(SALT311.StrType s0) := MakeFT_Invalid_FCRAConFlag(s0);
EXPORT InValid_fcra_conviction_flag(SALT311.StrType s) := InValidFT_Invalid_FCRAConFlag(s);
EXPORT InValidMessage_fcra_conviction_flag(UNSIGNED1 wh) := InValidMessageFT_Invalid_FCRAConFlag(wh);
 
EXPORT Make_fcra_traffic_flag(SALT311.StrType s0) := MakeFT_Invalid_FCRATrafficFlag(s0);
EXPORT InValid_fcra_traffic_flag(SALT311.StrType s) := InValidFT_Invalid_FCRATrafficFlag(s);
EXPORT InValidMessage_fcra_traffic_flag(UNSIGNED1 wh) := InValidMessageFT_Invalid_FCRATrafficFlag(wh);
 
EXPORT Make_fcra_date(SALT311.StrType s0) := MakeFT_Invalid_Current_Date(s0);
EXPORT InValid_fcra_date(SALT311.StrType s) := InValidFT_Invalid_Current_Date(s);
EXPORT InValidMessage_fcra_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Current_Date(wh);
 
EXPORT Make_fcra_date_type(SALT311.StrType s0) := MakeFT_Invalid_FCRADateFlag(s0);
EXPORT InValid_fcra_date_type(SALT311.StrType s) := InValidFT_Invalid_FCRADateFlag(s);
EXPORT InValidMessage_fcra_date_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_FCRADateFlag(wh);
 
EXPORT Make_conviction_override_date(SALT311.StrType s0) := MakeFT_Invalid_Future_Date(s0);
EXPORT InValid_conviction_override_date(SALT311.StrType s) := InValidFT_Invalid_Future_Date(s);
EXPORT InValidMessage_conviction_override_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Future_Date(wh);
 
EXPORT Make_conviction_override_date_type(SALT311.StrType s0) := MakeFT_Invalid_ConOverDateFlag(s0);
EXPORT InValid_conviction_override_date_type(SALT311.StrType s) := InValidFT_Invalid_ConOverDateFlag(s);
EXPORT InValidMessage_conviction_override_date_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_ConOverDateFlag(wh);
 
EXPORT Make_offense_score(SALT311.StrType s0) := MakeFT_Invalid_OffenseScore(s0);
EXPORT InValid_offense_score(SALT311.StrType s) := InValidFT_Invalid_OffenseScore(s);
EXPORT InValidMessage_offense_score(UNSIGNED1 wh) := InValidMessageFT_Invalid_OffenseScore(wh);
 
EXPORT Make_offense_persistent_id(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_offense_persistent_id(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_offense_persistent_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_offense_category(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_offense_category(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_offense_category(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Crim;
//Find those highly occuring pivot values to remove them from consideration
#uniquename(tr)
  %tr% := table(in_left+in_right,{ val := pivot_exp; });
#uniquename(r1)
  %r1% := record
    %tr%.val;    unsigned Cnt := COUNT(GROUP);
  end;
#uniquename(t1)
  %t1% := table(%tr%,%r1%,val,local); // Pre-aggregate before distribute
#uniquename(r2)
  %r2% := record
    %t1%.val;    unsigned Cnt := SUM(GROUP,%t1%.Cnt);
  end;
#uniquename(t2)
  %t2% := table(%t1%,%r2%,val); // Now do global aggregate
Bad_Pivots := %t2%(Cnt>100);
#uniquename(dl)
  %dl% := RECORD
    BOOLEAN Diff_process_date;
    BOOLEAN Diff_offender_key;
    BOOLEAN Diff_vendor;
    BOOLEAN Diff_state_origin;
    BOOLEAN Diff_source_file;
    BOOLEAN Diff_data_type;
    BOOLEAN Diff_off_comp;
    BOOLEAN Diff_off_delete_flag;
    BOOLEAN Diff_off_date;
    BOOLEAN Diff_arr_date;
    BOOLEAN Diff_num_of_counts;
    BOOLEAN Diff_le_agency_cd;
    BOOLEAN Diff_le_agency_desc;
    BOOLEAN Diff_le_agency_case_number;
    BOOLEAN Diff_traffic_ticket_number;
    BOOLEAN Diff_traffic_dl_no;
    BOOLEAN Diff_traffic_dl_st;
    BOOLEAN Diff_arr_off_code;
    BOOLEAN Diff_arr_off_desc_1;
    BOOLEAN Diff_arr_off_desc_2;
    BOOLEAN Diff_arr_off_type_cd;
    BOOLEAN Diff_arr_off_type_desc;
    BOOLEAN Diff_arr_off_lev;
    BOOLEAN Diff_arr_statute;
    BOOLEAN Diff_arr_statute_desc;
    BOOLEAN Diff_arr_disp_date;
    BOOLEAN Diff_arr_disp_code;
    BOOLEAN Diff_arr_disp_desc_1;
    BOOLEAN Diff_arr_disp_desc_2;
    BOOLEAN Diff_pros_refer_cd;
    BOOLEAN Diff_pros_refer;
    BOOLEAN Diff_pros_assgn_cd;
    BOOLEAN Diff_pros_assgn;
    BOOLEAN Diff_pros_chg_rej;
    BOOLEAN Diff_pros_off_code;
    BOOLEAN Diff_pros_off_desc_1;
    BOOLEAN Diff_pros_off_desc_2;
    BOOLEAN Diff_pros_off_type_cd;
    BOOLEAN Diff_pros_off_type_desc;
    BOOLEAN Diff_pros_off_lev;
    BOOLEAN Diff_pros_act_filed;
    BOOLEAN Diff_court_case_number;
    BOOLEAN Diff_court_cd;
    BOOLEAN Diff_court_desc;
    BOOLEAN Diff_court_appeal_flag;
    BOOLEAN Diff_court_final_plea;
    BOOLEAN Diff_court_off_code;
    BOOLEAN Diff_court_off_desc_1;
    BOOLEAN Diff_court_off_desc_2;
    BOOLEAN Diff_court_off_type_cd;
    BOOLEAN Diff_court_off_type_desc;
    BOOLEAN Diff_court_off_lev;
    BOOLEAN Diff_court_statute;
    BOOLEAN Diff_court_additional_statutes;
    BOOLEAN Diff_court_statute_desc;
    BOOLEAN Diff_court_disp_date;
    BOOLEAN Diff_court_disp_code;
    BOOLEAN Diff_court_disp_desc_1;
    BOOLEAN Diff_court_disp_desc_2;
    BOOLEAN Diff_sent_date;
    BOOLEAN Diff_sent_jail;
    BOOLEAN Diff_sent_susp_time;
    BOOLEAN Diff_sent_court_cost;
    BOOLEAN Diff_sent_court_fine;
    BOOLEAN Diff_sent_susp_court_fine;
    BOOLEAN Diff_sent_probation;
    BOOLEAN Diff_sent_addl_prov_code;
    BOOLEAN Diff_sent_addl_prov_desc_1;
    BOOLEAN Diff_sent_addl_prov_desc_2;
    BOOLEAN Diff_sent_consec;
    BOOLEAN Diff_sent_agency_rec_cust_ori;
    BOOLEAN Diff_sent_agency_rec_cust;
    BOOLEAN Diff_appeal_date;
    BOOLEAN Diff_appeal_off_disp;
    BOOLEAN Diff_appeal_final_decision;
    BOOLEAN Diff_convict_dt;
    BOOLEAN Diff_offense_town;
    BOOLEAN Diff_cty_conv;
    BOOLEAN Diff_restitution;
    BOOLEAN Diff_community_service;
    BOOLEAN Diff_parole;
    BOOLEAN Diff_addl_sent_dates;
    BOOLEAN Diff_probation_desc2;
    BOOLEAN Diff_court_dt;
    BOOLEAN Diff_court_county;
    BOOLEAN Diff_arr_off_lev_mapped;
    BOOLEAN Diff_court_off_lev_mapped;
    BOOLEAN Diff_fcra_offense_key;
    BOOLEAN Diff_fcra_conviction_flag;
    BOOLEAN Diff_fcra_traffic_flag;
    BOOLEAN Diff_fcra_date;
    BOOLEAN Diff_fcra_date_type;
    BOOLEAN Diff_conviction_override_date;
    BOOLEAN Diff_conviction_override_date_type;
    BOOLEAN Diff_offense_score;
    BOOLEAN Diff_offense_persistent_id;
    BOOLEAN Diff_offense_category;
    SALT311.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_offender_key := le.offender_key <> ri.offender_key;
    SELF.Diff_vendor := le.vendor <> ri.vendor;
    SELF.Diff_state_origin := le.state_origin <> ri.state_origin;
    SELF.Diff_source_file := le.source_file <> ri.source_file;
    SELF.Diff_data_type := le.data_type <> ri.data_type;
    SELF.Diff_off_comp := le.off_comp <> ri.off_comp;
    SELF.Diff_off_delete_flag := le.off_delete_flag <> ri.off_delete_flag;
    SELF.Diff_off_date := le.off_date <> ri.off_date;
    SELF.Diff_arr_date := le.arr_date <> ri.arr_date;
    SELF.Diff_num_of_counts := le.num_of_counts <> ri.num_of_counts;
    SELF.Diff_le_agency_cd := le.le_agency_cd <> ri.le_agency_cd;
    SELF.Diff_le_agency_desc := le.le_agency_desc <> ri.le_agency_desc;
    SELF.Diff_le_agency_case_number := le.le_agency_case_number <> ri.le_agency_case_number;
    SELF.Diff_traffic_ticket_number := le.traffic_ticket_number <> ri.traffic_ticket_number;
    SELF.Diff_traffic_dl_no := le.traffic_dl_no <> ri.traffic_dl_no;
    SELF.Diff_traffic_dl_st := le.traffic_dl_st <> ri.traffic_dl_st;
    SELF.Diff_arr_off_code := le.arr_off_code <> ri.arr_off_code;
    SELF.Diff_arr_off_desc_1 := le.arr_off_desc_1 <> ri.arr_off_desc_1;
    SELF.Diff_arr_off_desc_2 := le.arr_off_desc_2 <> ri.arr_off_desc_2;
    SELF.Diff_arr_off_type_cd := le.arr_off_type_cd <> ri.arr_off_type_cd;
    SELF.Diff_arr_off_type_desc := le.arr_off_type_desc <> ri.arr_off_type_desc;
    SELF.Diff_arr_off_lev := le.arr_off_lev <> ri.arr_off_lev;
    SELF.Diff_arr_statute := le.arr_statute <> ri.arr_statute;
    SELF.Diff_arr_statute_desc := le.arr_statute_desc <> ri.arr_statute_desc;
    SELF.Diff_arr_disp_date := le.arr_disp_date <> ri.arr_disp_date;
    SELF.Diff_arr_disp_code := le.arr_disp_code <> ri.arr_disp_code;
    SELF.Diff_arr_disp_desc_1 := le.arr_disp_desc_1 <> ri.arr_disp_desc_1;
    SELF.Diff_arr_disp_desc_2 := le.arr_disp_desc_2 <> ri.arr_disp_desc_2;
    SELF.Diff_pros_refer_cd := le.pros_refer_cd <> ri.pros_refer_cd;
    SELF.Diff_pros_refer := le.pros_refer <> ri.pros_refer;
    SELF.Diff_pros_assgn_cd := le.pros_assgn_cd <> ri.pros_assgn_cd;
    SELF.Diff_pros_assgn := le.pros_assgn <> ri.pros_assgn;
    SELF.Diff_pros_chg_rej := le.pros_chg_rej <> ri.pros_chg_rej;
    SELF.Diff_pros_off_code := le.pros_off_code <> ri.pros_off_code;
    SELF.Diff_pros_off_desc_1 := le.pros_off_desc_1 <> ri.pros_off_desc_1;
    SELF.Diff_pros_off_desc_2 := le.pros_off_desc_2 <> ri.pros_off_desc_2;
    SELF.Diff_pros_off_type_cd := le.pros_off_type_cd <> ri.pros_off_type_cd;
    SELF.Diff_pros_off_type_desc := le.pros_off_type_desc <> ri.pros_off_type_desc;
    SELF.Diff_pros_off_lev := le.pros_off_lev <> ri.pros_off_lev;
    SELF.Diff_pros_act_filed := le.pros_act_filed <> ri.pros_act_filed;
    SELF.Diff_court_case_number := le.court_case_number <> ri.court_case_number;
    SELF.Diff_court_cd := le.court_cd <> ri.court_cd;
    SELF.Diff_court_desc := le.court_desc <> ri.court_desc;
    SELF.Diff_court_appeal_flag := le.court_appeal_flag <> ri.court_appeal_flag;
    SELF.Diff_court_final_plea := le.court_final_plea <> ri.court_final_plea;
    SELF.Diff_court_off_code := le.court_off_code <> ri.court_off_code;
    SELF.Diff_court_off_desc_1 := le.court_off_desc_1 <> ri.court_off_desc_1;
    SELF.Diff_court_off_desc_2 := le.court_off_desc_2 <> ri.court_off_desc_2;
    SELF.Diff_court_off_type_cd := le.court_off_type_cd <> ri.court_off_type_cd;
    SELF.Diff_court_off_type_desc := le.court_off_type_desc <> ri.court_off_type_desc;
    SELF.Diff_court_off_lev := le.court_off_lev <> ri.court_off_lev;
    SELF.Diff_court_statute := le.court_statute <> ri.court_statute;
    SELF.Diff_court_additional_statutes := le.court_additional_statutes <> ri.court_additional_statutes;
    SELF.Diff_court_statute_desc := le.court_statute_desc <> ri.court_statute_desc;
    SELF.Diff_court_disp_date := le.court_disp_date <> ri.court_disp_date;
    SELF.Diff_court_disp_code := le.court_disp_code <> ri.court_disp_code;
    SELF.Diff_court_disp_desc_1 := le.court_disp_desc_1 <> ri.court_disp_desc_1;
    SELF.Diff_court_disp_desc_2 := le.court_disp_desc_2 <> ri.court_disp_desc_2;
    SELF.Diff_sent_date := le.sent_date <> ri.sent_date;
    SELF.Diff_sent_jail := le.sent_jail <> ri.sent_jail;
    SELF.Diff_sent_susp_time := le.sent_susp_time <> ri.sent_susp_time;
    SELF.Diff_sent_court_cost := le.sent_court_cost <> ri.sent_court_cost;
    SELF.Diff_sent_court_fine := le.sent_court_fine <> ri.sent_court_fine;
    SELF.Diff_sent_susp_court_fine := le.sent_susp_court_fine <> ri.sent_susp_court_fine;
    SELF.Diff_sent_probation := le.sent_probation <> ri.sent_probation;
    SELF.Diff_sent_addl_prov_code := le.sent_addl_prov_code <> ri.sent_addl_prov_code;
    SELF.Diff_sent_addl_prov_desc_1 := le.sent_addl_prov_desc_1 <> ri.sent_addl_prov_desc_1;
    SELF.Diff_sent_addl_prov_desc_2 := le.sent_addl_prov_desc_2 <> ri.sent_addl_prov_desc_2;
    SELF.Diff_sent_consec := le.sent_consec <> ri.sent_consec;
    SELF.Diff_sent_agency_rec_cust_ori := le.sent_agency_rec_cust_ori <> ri.sent_agency_rec_cust_ori;
    SELF.Diff_sent_agency_rec_cust := le.sent_agency_rec_cust <> ri.sent_agency_rec_cust;
    SELF.Diff_appeal_date := le.appeal_date <> ri.appeal_date;
    SELF.Diff_appeal_off_disp := le.appeal_off_disp <> ri.appeal_off_disp;
    SELF.Diff_appeal_final_decision := le.appeal_final_decision <> ri.appeal_final_decision;
    SELF.Diff_convict_dt := le.convict_dt <> ri.convict_dt;
    SELF.Diff_offense_town := le.offense_town <> ri.offense_town;
    SELF.Diff_cty_conv := le.cty_conv <> ri.cty_conv;
    SELF.Diff_restitution := le.restitution <> ri.restitution;
    SELF.Diff_community_service := le.community_service <> ri.community_service;
    SELF.Diff_parole := le.parole <> ri.parole;
    SELF.Diff_addl_sent_dates := le.addl_sent_dates <> ri.addl_sent_dates;
    SELF.Diff_probation_desc2 := le.probation_desc2 <> ri.probation_desc2;
    SELF.Diff_court_dt := le.court_dt <> ri.court_dt;
    SELF.Diff_court_county := le.court_county <> ri.court_county;
    SELF.Diff_arr_off_lev_mapped := le.arr_off_lev_mapped <> ri.arr_off_lev_mapped;
    SELF.Diff_court_off_lev_mapped := le.court_off_lev_mapped <> ri.court_off_lev_mapped;
    SELF.Diff_fcra_offense_key := le.fcra_offense_key <> ri.fcra_offense_key;
    SELF.Diff_fcra_conviction_flag := le.fcra_conviction_flag <> ri.fcra_conviction_flag;
    SELF.Diff_fcra_traffic_flag := le.fcra_traffic_flag <> ri.fcra_traffic_flag;
    SELF.Diff_fcra_date := le.fcra_date <> ri.fcra_date;
    SELF.Diff_fcra_date_type := le.fcra_date_type <> ri.fcra_date_type;
    SELF.Diff_conviction_override_date := le.conviction_override_date <> ri.conviction_override_date;
    SELF.Diff_conviction_override_date_type := le.conviction_override_date_type <> ri.conviction_override_date_type;
    SELF.Diff_offense_score := le.offense_score <> ri.offense_score;
    SELF.Diff_offense_persistent_id := le.offense_persistent_id <> ri.offense_persistent_id;
    SELF.Diff_offense_category := le.offense_category <> ri.offense_category;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.vendor;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_offender_key,1,0)+ IF( SELF.Diff_vendor,1,0)+ IF( SELF.Diff_state_origin,1,0)+ IF( SELF.Diff_source_file,1,0)+ IF( SELF.Diff_data_type,1,0)+ IF( SELF.Diff_off_comp,1,0)+ IF( SELF.Diff_off_delete_flag,1,0)+ IF( SELF.Diff_off_date,1,0)+ IF( SELF.Diff_arr_date,1,0)+ IF( SELF.Diff_num_of_counts,1,0)+ IF( SELF.Diff_le_agency_cd,1,0)+ IF( SELF.Diff_le_agency_desc,1,0)+ IF( SELF.Diff_le_agency_case_number,1,0)+ IF( SELF.Diff_traffic_ticket_number,1,0)+ IF( SELF.Diff_traffic_dl_no,1,0)+ IF( SELF.Diff_traffic_dl_st,1,0)+ IF( SELF.Diff_arr_off_code,1,0)+ IF( SELF.Diff_arr_off_desc_1,1,0)+ IF( SELF.Diff_arr_off_desc_2,1,0)+ IF( SELF.Diff_arr_off_type_cd,1,0)+ IF( SELF.Diff_arr_off_type_desc,1,0)+ IF( SELF.Diff_arr_off_lev,1,0)+ IF( SELF.Diff_arr_statute,1,0)+ IF( SELF.Diff_arr_statute_desc,1,0)+ IF( SELF.Diff_arr_disp_date,1,0)+ IF( SELF.Diff_arr_disp_code,1,0)+ IF( SELF.Diff_arr_disp_desc_1,1,0)+ IF( SELF.Diff_arr_disp_desc_2,1,0)+ IF( SELF.Diff_pros_refer_cd,1,0)+ IF( SELF.Diff_pros_refer,1,0)+ IF( SELF.Diff_pros_assgn_cd,1,0)+ IF( SELF.Diff_pros_assgn,1,0)+ IF( SELF.Diff_pros_chg_rej,1,0)+ IF( SELF.Diff_pros_off_code,1,0)+ IF( SELF.Diff_pros_off_desc_1,1,0)+ IF( SELF.Diff_pros_off_desc_2,1,0)+ IF( SELF.Diff_pros_off_type_cd,1,0)+ IF( SELF.Diff_pros_off_type_desc,1,0)+ IF( SELF.Diff_pros_off_lev,1,0)+ IF( SELF.Diff_pros_act_filed,1,0)+ IF( SELF.Diff_court_case_number,1,0)+ IF( SELF.Diff_court_cd,1,0)+ IF( SELF.Diff_court_desc,1,0)+ IF( SELF.Diff_court_appeal_flag,1,0)+ IF( SELF.Diff_court_final_plea,1,0)+ IF( SELF.Diff_court_off_code,1,0)+ IF( SELF.Diff_court_off_desc_1,1,0)+ IF( SELF.Diff_court_off_desc_2,1,0)+ IF( SELF.Diff_court_off_type_cd,1,0)+ IF( SELF.Diff_court_off_type_desc,1,0)+ IF( SELF.Diff_court_off_lev,1,0)+ IF( SELF.Diff_court_statute,1,0)+ IF( SELF.Diff_court_additional_statutes,1,0)+ IF( SELF.Diff_court_statute_desc,1,0)+ IF( SELF.Diff_court_disp_date,1,0)+ IF( SELF.Diff_court_disp_code,1,0)+ IF( SELF.Diff_court_disp_desc_1,1,0)+ IF( SELF.Diff_court_disp_desc_2,1,0)+ IF( SELF.Diff_sent_date,1,0)+ IF( SELF.Diff_sent_jail,1,0)+ IF( SELF.Diff_sent_susp_time,1,0)+ IF( SELF.Diff_sent_court_cost,1,0)+ IF( SELF.Diff_sent_court_fine,1,0)+ IF( SELF.Diff_sent_susp_court_fine,1,0)+ IF( SELF.Diff_sent_probation,1,0)+ IF( SELF.Diff_sent_addl_prov_code,1,0)+ IF( SELF.Diff_sent_addl_prov_desc_1,1,0)+ IF( SELF.Diff_sent_addl_prov_desc_2,1,0)+ IF( SELF.Diff_sent_consec,1,0)+ IF( SELF.Diff_sent_agency_rec_cust_ori,1,0)+ IF( SELF.Diff_sent_agency_rec_cust,1,0)+ IF( SELF.Diff_appeal_date,1,0)+ IF( SELF.Diff_appeal_off_disp,1,0)+ IF( SELF.Diff_appeal_final_decision,1,0)+ IF( SELF.Diff_convict_dt,1,0)+ IF( SELF.Diff_offense_town,1,0)+ IF( SELF.Diff_cty_conv,1,0)+ IF( SELF.Diff_restitution,1,0)+ IF( SELF.Diff_community_service,1,0)+ IF( SELF.Diff_parole,1,0)+ IF( SELF.Diff_addl_sent_dates,1,0)+ IF( SELF.Diff_probation_desc2,1,0)+ IF( SELF.Diff_court_dt,1,0)+ IF( SELF.Diff_court_county,1,0)+ IF( SELF.Diff_arr_off_lev_mapped,1,0)+ IF( SELF.Diff_court_off_lev_mapped,1,0)+ IF( SELF.Diff_fcra_offense_key,1,0)+ IF( SELF.Diff_fcra_conviction_flag,1,0)+ IF( SELF.Diff_fcra_traffic_flag,1,0)+ IF( SELF.Diff_fcra_date,1,0)+ IF( SELF.Diff_fcra_date_type,1,0)+ IF( SELF.Diff_conviction_override_date,1,0)+ IF( SELF.Diff_conviction_override_date_type,1,0)+ IF( SELF.Diff_offense_score,1,0)+ IF( SELF.Diff_offense_persistent_id,1,0)+ IF( SELF.Diff_offense_category,1,0);
  END;
// Now need to remove bad pivots from comparison
#uniquename(L)
  %L% := JOIN(in_left,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(R)
  %R% := JOIN(in_right,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(DiffL)
  %DiffL% := JOIN(%L%,%R%,evaluate(left,pivot_exp)=evaluate(right,pivot_exp),%fd%(left,right),hash);
#uniquename(Closest)
  %Closest% := DEDUP(SORT(%DiffL%,Val,Num_Diffs,local),Val,local); // Join will have distributed by pivot_exp
#uniquename(AggRec)
  %AggRec% := RECORD
    Count_Diff_process_date := COUNT(GROUP,%Closest%.Diff_process_date);
    Count_Diff_offender_key := COUNT(GROUP,%Closest%.Diff_offender_key);
    Count_Diff_vendor := COUNT(GROUP,%Closest%.Diff_vendor);
    Count_Diff_state_origin := COUNT(GROUP,%Closest%.Diff_state_origin);
    Count_Diff_source_file := COUNT(GROUP,%Closest%.Diff_source_file);
    Count_Diff_data_type := COUNT(GROUP,%Closest%.Diff_data_type);
    Count_Diff_off_comp := COUNT(GROUP,%Closest%.Diff_off_comp);
    Count_Diff_off_delete_flag := COUNT(GROUP,%Closest%.Diff_off_delete_flag);
    Count_Diff_off_date := COUNT(GROUP,%Closest%.Diff_off_date);
    Count_Diff_arr_date := COUNT(GROUP,%Closest%.Diff_arr_date);
    Count_Diff_num_of_counts := COUNT(GROUP,%Closest%.Diff_num_of_counts);
    Count_Diff_le_agency_cd := COUNT(GROUP,%Closest%.Diff_le_agency_cd);
    Count_Diff_le_agency_desc := COUNT(GROUP,%Closest%.Diff_le_agency_desc);
    Count_Diff_le_agency_case_number := COUNT(GROUP,%Closest%.Diff_le_agency_case_number);
    Count_Diff_traffic_ticket_number := COUNT(GROUP,%Closest%.Diff_traffic_ticket_number);
    Count_Diff_traffic_dl_no := COUNT(GROUP,%Closest%.Diff_traffic_dl_no);
    Count_Diff_traffic_dl_st := COUNT(GROUP,%Closest%.Diff_traffic_dl_st);
    Count_Diff_arr_off_code := COUNT(GROUP,%Closest%.Diff_arr_off_code);
    Count_Diff_arr_off_desc_1 := COUNT(GROUP,%Closest%.Diff_arr_off_desc_1);
    Count_Diff_arr_off_desc_2 := COUNT(GROUP,%Closest%.Diff_arr_off_desc_2);
    Count_Diff_arr_off_type_cd := COUNT(GROUP,%Closest%.Diff_arr_off_type_cd);
    Count_Diff_arr_off_type_desc := COUNT(GROUP,%Closest%.Diff_arr_off_type_desc);
    Count_Diff_arr_off_lev := COUNT(GROUP,%Closest%.Diff_arr_off_lev);
    Count_Diff_arr_statute := COUNT(GROUP,%Closest%.Diff_arr_statute);
    Count_Diff_arr_statute_desc := COUNT(GROUP,%Closest%.Diff_arr_statute_desc);
    Count_Diff_arr_disp_date := COUNT(GROUP,%Closest%.Diff_arr_disp_date);
    Count_Diff_arr_disp_code := COUNT(GROUP,%Closest%.Diff_arr_disp_code);
    Count_Diff_arr_disp_desc_1 := COUNT(GROUP,%Closest%.Diff_arr_disp_desc_1);
    Count_Diff_arr_disp_desc_2 := COUNT(GROUP,%Closest%.Diff_arr_disp_desc_2);
    Count_Diff_pros_refer_cd := COUNT(GROUP,%Closest%.Diff_pros_refer_cd);
    Count_Diff_pros_refer := COUNT(GROUP,%Closest%.Diff_pros_refer);
    Count_Diff_pros_assgn_cd := COUNT(GROUP,%Closest%.Diff_pros_assgn_cd);
    Count_Diff_pros_assgn := COUNT(GROUP,%Closest%.Diff_pros_assgn);
    Count_Diff_pros_chg_rej := COUNT(GROUP,%Closest%.Diff_pros_chg_rej);
    Count_Diff_pros_off_code := COUNT(GROUP,%Closest%.Diff_pros_off_code);
    Count_Diff_pros_off_desc_1 := COUNT(GROUP,%Closest%.Diff_pros_off_desc_1);
    Count_Diff_pros_off_desc_2 := COUNT(GROUP,%Closest%.Diff_pros_off_desc_2);
    Count_Diff_pros_off_type_cd := COUNT(GROUP,%Closest%.Diff_pros_off_type_cd);
    Count_Diff_pros_off_type_desc := COUNT(GROUP,%Closest%.Diff_pros_off_type_desc);
    Count_Diff_pros_off_lev := COUNT(GROUP,%Closest%.Diff_pros_off_lev);
    Count_Diff_pros_act_filed := COUNT(GROUP,%Closest%.Diff_pros_act_filed);
    Count_Diff_court_case_number := COUNT(GROUP,%Closest%.Diff_court_case_number);
    Count_Diff_court_cd := COUNT(GROUP,%Closest%.Diff_court_cd);
    Count_Diff_court_desc := COUNT(GROUP,%Closest%.Diff_court_desc);
    Count_Diff_court_appeal_flag := COUNT(GROUP,%Closest%.Diff_court_appeal_flag);
    Count_Diff_court_final_plea := COUNT(GROUP,%Closest%.Diff_court_final_plea);
    Count_Diff_court_off_code := COUNT(GROUP,%Closest%.Diff_court_off_code);
    Count_Diff_court_off_desc_1 := COUNT(GROUP,%Closest%.Diff_court_off_desc_1);
    Count_Diff_court_off_desc_2 := COUNT(GROUP,%Closest%.Diff_court_off_desc_2);
    Count_Diff_court_off_type_cd := COUNT(GROUP,%Closest%.Diff_court_off_type_cd);
    Count_Diff_court_off_type_desc := COUNT(GROUP,%Closest%.Diff_court_off_type_desc);
    Count_Diff_court_off_lev := COUNT(GROUP,%Closest%.Diff_court_off_lev);
    Count_Diff_court_statute := COUNT(GROUP,%Closest%.Diff_court_statute);
    Count_Diff_court_additional_statutes := COUNT(GROUP,%Closest%.Diff_court_additional_statutes);
    Count_Diff_court_statute_desc := COUNT(GROUP,%Closest%.Diff_court_statute_desc);
    Count_Diff_court_disp_date := COUNT(GROUP,%Closest%.Diff_court_disp_date);
    Count_Diff_court_disp_code := COUNT(GROUP,%Closest%.Diff_court_disp_code);
    Count_Diff_court_disp_desc_1 := COUNT(GROUP,%Closest%.Diff_court_disp_desc_1);
    Count_Diff_court_disp_desc_2 := COUNT(GROUP,%Closest%.Diff_court_disp_desc_2);
    Count_Diff_sent_date := COUNT(GROUP,%Closest%.Diff_sent_date);
    Count_Diff_sent_jail := COUNT(GROUP,%Closest%.Diff_sent_jail);
    Count_Diff_sent_susp_time := COUNT(GROUP,%Closest%.Diff_sent_susp_time);
    Count_Diff_sent_court_cost := COUNT(GROUP,%Closest%.Diff_sent_court_cost);
    Count_Diff_sent_court_fine := COUNT(GROUP,%Closest%.Diff_sent_court_fine);
    Count_Diff_sent_susp_court_fine := COUNT(GROUP,%Closest%.Diff_sent_susp_court_fine);
    Count_Diff_sent_probation := COUNT(GROUP,%Closest%.Diff_sent_probation);
    Count_Diff_sent_addl_prov_code := COUNT(GROUP,%Closest%.Diff_sent_addl_prov_code);
    Count_Diff_sent_addl_prov_desc_1 := COUNT(GROUP,%Closest%.Diff_sent_addl_prov_desc_1);
    Count_Diff_sent_addl_prov_desc_2 := COUNT(GROUP,%Closest%.Diff_sent_addl_prov_desc_2);
    Count_Diff_sent_consec := COUNT(GROUP,%Closest%.Diff_sent_consec);
    Count_Diff_sent_agency_rec_cust_ori := COUNT(GROUP,%Closest%.Diff_sent_agency_rec_cust_ori);
    Count_Diff_sent_agency_rec_cust := COUNT(GROUP,%Closest%.Diff_sent_agency_rec_cust);
    Count_Diff_appeal_date := COUNT(GROUP,%Closest%.Diff_appeal_date);
    Count_Diff_appeal_off_disp := COUNT(GROUP,%Closest%.Diff_appeal_off_disp);
    Count_Diff_appeal_final_decision := COUNT(GROUP,%Closest%.Diff_appeal_final_decision);
    Count_Diff_convict_dt := COUNT(GROUP,%Closest%.Diff_convict_dt);
    Count_Diff_offense_town := COUNT(GROUP,%Closest%.Diff_offense_town);
    Count_Diff_cty_conv := COUNT(GROUP,%Closest%.Diff_cty_conv);
    Count_Diff_restitution := COUNT(GROUP,%Closest%.Diff_restitution);
    Count_Diff_community_service := COUNT(GROUP,%Closest%.Diff_community_service);
    Count_Diff_parole := COUNT(GROUP,%Closest%.Diff_parole);
    Count_Diff_addl_sent_dates := COUNT(GROUP,%Closest%.Diff_addl_sent_dates);
    Count_Diff_probation_desc2 := COUNT(GROUP,%Closest%.Diff_probation_desc2);
    Count_Diff_court_dt := COUNT(GROUP,%Closest%.Diff_court_dt);
    Count_Diff_court_county := COUNT(GROUP,%Closest%.Diff_court_county);
    Count_Diff_arr_off_lev_mapped := COUNT(GROUP,%Closest%.Diff_arr_off_lev_mapped);
    Count_Diff_court_off_lev_mapped := COUNT(GROUP,%Closest%.Diff_court_off_lev_mapped);
    Count_Diff_fcra_offense_key := COUNT(GROUP,%Closest%.Diff_fcra_offense_key);
    Count_Diff_fcra_conviction_flag := COUNT(GROUP,%Closest%.Diff_fcra_conviction_flag);
    Count_Diff_fcra_traffic_flag := COUNT(GROUP,%Closest%.Diff_fcra_traffic_flag);
    Count_Diff_fcra_date := COUNT(GROUP,%Closest%.Diff_fcra_date);
    Count_Diff_fcra_date_type := COUNT(GROUP,%Closest%.Diff_fcra_date_type);
    Count_Diff_conviction_override_date := COUNT(GROUP,%Closest%.Diff_conviction_override_date);
    Count_Diff_conviction_override_date_type := COUNT(GROUP,%Closest%.Diff_conviction_override_date_type);
    Count_Diff_offense_score := COUNT(GROUP,%Closest%.Diff_offense_score);
    Count_Diff_offense_persistent_id := COUNT(GROUP,%Closest%.Diff_offense_persistent_id);
    Count_Diff_offense_category := COUNT(GROUP,%Closest%.Diff_offense_category);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
END;
