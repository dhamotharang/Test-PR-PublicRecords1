IMPORT SALT311;
IMPORT Scrubs,Scrubs_Crim; // Import modules for FieldTypes attribute definitions
EXPORT Moxie_DOC_Offenses_Dev_Fields := MODULE
 
EXPORT NumFields := 79;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Current_Date','Invalid_Future_Date','Non_Blank','Invalid_Num','Invalid_Off_Typ','Invalid_Char','Invalid_CtyConvCd','Invalid_FCRAConFlag','Invalid_FCRATrafficFlag','Invalid_FCRADateFlag','Invalid_ConOverDateFlag','Invalid_OffenseScore','Invalid_OffLev');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_Current_Date' => 1,'Invalid_Future_Date' => 2,'Non_Blank' => 3,'Invalid_Num' => 4,'Invalid_Off_Typ' => 5,'Invalid_Char' => 6,'Invalid_CtyConvCd' => 7,'Invalid_FCRAConFlag' => 8,'Invalid_FCRATrafficFlag' => 9,'Invalid_FCRADateFlag' => 10,'Invalid_ConOverDateFlag' => 11,'Invalid_OffenseScore' => 12,'Invalid_OffLev' => 13,0);
 
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
 
EXPORT MakeFT_Invalid_Num(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Off_Typ(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Off_Typ(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['F','M','I',' ']);
EXPORT InValidMessageFT_Invalid_Off_Typ(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('F|M|I| '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Char(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz012456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Char(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz012456789'))));
EXPORT InValidMessageFT_Invalid_Char(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz012456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_CtyConvCd(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_CtyConvCd(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['AA','99','17','PA','27','32','06','31','39','34','00','18','08','03','21','37','13','04','14','29','11','']);
EXPORT InValidMessageFT_Invalid_CtyConvCd(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('AA|99|17|PA|27|32|06|31|39|34|00|18|08|03|21|37|13|04|14|29|11|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_FCRAConFlag(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_FCRAConFlag(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['D','U','']);
EXPORT InValidMessageFT_Invalid_FCRAConFlag(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('D|U|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_FCRATrafficFlag(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'N'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_FCRATrafficFlag(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'N'))));
EXPORT InValidMessageFT_Invalid_FCRATrafficFlag(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('N'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_FCRADateFlag(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_FCRADateFlag(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['S','I','D','B','']);
EXPORT InValidMessageFT_Invalid_FCRADateFlag(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('S|I|D|B|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_ConOverDateFlag(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_ConOverDateFlag(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['O','I','D','A','']);
EXPORT InValidMessageFT_Invalid_ConOverDateFlag(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('O|I|D|A|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_OffenseScore(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_OffenseScore(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['U','F','M','']);
EXPORT InValidMessageFT_Invalid_OffenseScore(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('U|F|M|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_OffLev(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_OffLev(SALT311.StrType s) := WHICH(~Scrubs_Crim.fn_v3Code_Check(s,'OFF_LEV','DOC_OFFENSE')>0);
EXPORT InValidMessageFT_Invalid_OffLev(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Crim.fn_v3Code_Check'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'process_date','offender_key','vendor','county_of_origin','source_file','data_type','record_type','orig_state','offense_key','off_date','arr_date','case_num','total_num_of_offenses','num_of_counts','off_code','chg','chg_typ_flg','off_of_record','off_desc_1','off_desc_2','add_off_cd','add_off_desc','off_typ','off_lev','arr_disp_date','arr_disp_cd','arr_disp_desc_1','arr_disp_desc_2','arr_disp_desc_3','court_cd','court_desc','ct_dist','ct_fnl_plea_cd','ct_fnl_plea','ct_off_code','ct_chg','ct_chg_typ_flg','ct_off_desc_1','ct_off_desc_2','ct_addl_desc_cd','ct_off_lev','ct_disp_dt','ct_disp_cd','ct_disp_desc_1','ct_disp_desc_2','cty_conv_cd','cty_conv','adj_wthd','stc_dt','stc_cd','stc_comp','stc_desc_1','stc_desc_2','stc_desc_3','stc_desc_4','stc_lgth','stc_lgth_desc','inc_adm_dt','min_term','min_term_desc','max_term','max_term_desc','parole','probation','offensetown','convict_dt','court_county','fcra_offense_key','fcra_conviction_flag','fcra_traffic_flag','fcra_date','fcra_date_type','conviction_override_date','conviction_override_date_type','offense_score','offense_persistent_id','offense_category','hyg_classification_code','old_ln_offense_score');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'process_date','offender_key','vendor','county_of_origin','source_file','data_type','record_type','orig_state','offense_key','off_date','arr_date','case_num','total_num_of_offenses','num_of_counts','off_code','chg','chg_typ_flg','off_of_record','off_desc_1','off_desc_2','add_off_cd','add_off_desc','off_typ','off_lev','arr_disp_date','arr_disp_cd','arr_disp_desc_1','arr_disp_desc_2','arr_disp_desc_3','court_cd','court_desc','ct_dist','ct_fnl_plea_cd','ct_fnl_plea','ct_off_code','ct_chg','ct_chg_typ_flg','ct_off_desc_1','ct_off_desc_2','ct_addl_desc_cd','ct_off_lev','ct_disp_dt','ct_disp_cd','ct_disp_desc_1','ct_disp_desc_2','cty_conv_cd','cty_conv','adj_wthd','stc_dt','stc_cd','stc_comp','stc_desc_1','stc_desc_2','stc_desc_3','stc_desc_4','stc_lgth','stc_lgth_desc','inc_adm_dt','min_term','min_term_desc','max_term','max_term_desc','parole','probation','offensetown','convict_dt','court_county','fcra_offense_key','fcra_conviction_flag','fcra_traffic_flag','fcra_date','fcra_date_type','conviction_override_date','conviction_override_date_type','offense_score','offense_persistent_id','offense_category','hyg_classification_code','old_ln_offense_score');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'process_date' => 0,'offender_key' => 1,'vendor' => 2,'county_of_origin' => 3,'source_file' => 4,'data_type' => 5,'record_type' => 6,'orig_state' => 7,'offense_key' => 8,'off_date' => 9,'arr_date' => 10,'case_num' => 11,'total_num_of_offenses' => 12,'num_of_counts' => 13,'off_code' => 14,'chg' => 15,'chg_typ_flg' => 16,'off_of_record' => 17,'off_desc_1' => 18,'off_desc_2' => 19,'add_off_cd' => 20,'add_off_desc' => 21,'off_typ' => 22,'off_lev' => 23,'arr_disp_date' => 24,'arr_disp_cd' => 25,'arr_disp_desc_1' => 26,'arr_disp_desc_2' => 27,'arr_disp_desc_3' => 28,'court_cd' => 29,'court_desc' => 30,'ct_dist' => 31,'ct_fnl_plea_cd' => 32,'ct_fnl_plea' => 33,'ct_off_code' => 34,'ct_chg' => 35,'ct_chg_typ_flg' => 36,'ct_off_desc_1' => 37,'ct_off_desc_2' => 38,'ct_addl_desc_cd' => 39,'ct_off_lev' => 40,'ct_disp_dt' => 41,'ct_disp_cd' => 42,'ct_disp_desc_1' => 43,'ct_disp_desc_2' => 44,'cty_conv_cd' => 45,'cty_conv' => 46,'adj_wthd' => 47,'stc_dt' => 48,'stc_cd' => 49,'stc_comp' => 50,'stc_desc_1' => 51,'stc_desc_2' => 52,'stc_desc_3' => 53,'stc_desc_4' => 54,'stc_lgth' => 55,'stc_lgth_desc' => 56,'inc_adm_dt' => 57,'min_term' => 58,'min_term_desc' => 59,'max_term' => 60,'max_term_desc' => 61,'parole' => 62,'probation' => 63,'offensetown' => 64,'convict_dt' => 65,'court_county' => 66,'fcra_offense_key' => 67,'fcra_conviction_flag' => 68,'fcra_traffic_flag' => 69,'fcra_date' => 70,'fcra_date_type' => 71,'conviction_override_date' => 72,'conviction_override_date_type' => 73,'offense_score' => 74,'offense_persistent_id' => 75,'offense_category' => 76,'hyg_classification_code' => 77,'old_ln_offense_score' => 78,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['LENGTHS'],[],[],['LENGTHS'],[],[],['ALLOW'],['LENGTHS'],['CUSTOM'],['CUSTOM'],[],['ALLOW'],['ALLOW'],[],[],[],[],[],[],[],[],['ENUM'],['CUSTOM'],['CUSTOM'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],['CUSTOM'],[],[],[],['ENUM'],[],[],['CUSTOM'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],['CUSTOM'],[],[],['ENUM'],['ALLOW'],['CUSTOM'],['ENUM'],['CUSTOM'],['ENUM'],[],['ALLOW'],['ALLOW'],['ALLOW'],['ENUM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_process_date(SALT311.StrType s0) := MakeFT_Invalid_Current_Date(s0);
EXPORT InValid_process_date(SALT311.StrType s) := InValidFT_Invalid_Current_Date(s);
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Current_Date(wh);
 
EXPORT Make_offender_key(SALT311.StrType s0) := MakeFT_Non_Blank(s0);
EXPORT InValid_offender_key(SALT311.StrType s) := InValidFT_Non_Blank(s);
EXPORT InValidMessage_offender_key(UNSIGNED1 wh) := InValidMessageFT_Non_Blank(wh);
 
EXPORT Make_vendor(SALT311.StrType s0) := s0;
EXPORT InValid_vendor(SALT311.StrType s) := 0;
EXPORT InValidMessage_vendor(UNSIGNED1 wh) := '';
 
EXPORT Make_county_of_origin(SALT311.StrType s0) := s0;
EXPORT InValid_county_of_origin(SALT311.StrType s) := 0;
EXPORT InValidMessage_county_of_origin(UNSIGNED1 wh) := '';
 
EXPORT Make_source_file(SALT311.StrType s0) := MakeFT_Non_Blank(s0);
EXPORT InValid_source_file(SALT311.StrType s) := InValidFT_Non_Blank(s);
EXPORT InValidMessage_source_file(UNSIGNED1 wh) := InValidMessageFT_Non_Blank(wh);
 
EXPORT Make_data_type(SALT311.StrType s0) := s0;
EXPORT InValid_data_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_data_type(UNSIGNED1 wh) := '';
 
EXPORT Make_record_type(SALT311.StrType s0) := s0;
EXPORT InValid_record_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_state(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_orig_state(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_orig_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_offense_key(SALT311.StrType s0) := MakeFT_Non_Blank(s0);
EXPORT InValid_offense_key(SALT311.StrType s) := InValidFT_Non_Blank(s);
EXPORT InValidMessage_offense_key(UNSIGNED1 wh) := InValidMessageFT_Non_Blank(wh);
 
EXPORT Make_off_date(SALT311.StrType s0) := MakeFT_Invalid_Current_Date(s0);
EXPORT InValid_off_date(SALT311.StrType s) := InValidFT_Invalid_Current_Date(s);
EXPORT InValidMessage_off_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Current_Date(wh);
 
EXPORT Make_arr_date(SALT311.StrType s0) := MakeFT_Invalid_Current_Date(s0);
EXPORT InValid_arr_date(SALT311.StrType s) := InValidFT_Invalid_Current_Date(s);
EXPORT InValidMessage_arr_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Current_Date(wh);
 
EXPORT Make_case_num(SALT311.StrType s0) := s0;
EXPORT InValid_case_num(SALT311.StrType s) := 0;
EXPORT InValidMessage_case_num(UNSIGNED1 wh) := '';
 
EXPORT Make_total_num_of_offenses(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_total_num_of_offenses(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_total_num_of_offenses(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_num_of_counts(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_num_of_counts(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_num_of_counts(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_off_code(SALT311.StrType s0) := s0;
EXPORT InValid_off_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_off_code(UNSIGNED1 wh) := '';
 
EXPORT Make_chg(SALT311.StrType s0) := s0;
EXPORT InValid_chg(SALT311.StrType s) := 0;
EXPORT InValidMessage_chg(UNSIGNED1 wh) := '';
 
EXPORT Make_chg_typ_flg(SALT311.StrType s0) := s0;
EXPORT InValid_chg_typ_flg(SALT311.StrType s) := 0;
EXPORT InValidMessage_chg_typ_flg(UNSIGNED1 wh) := '';
 
EXPORT Make_off_of_record(SALT311.StrType s0) := s0;
EXPORT InValid_off_of_record(SALT311.StrType s) := 0;
EXPORT InValidMessage_off_of_record(UNSIGNED1 wh) := '';
 
EXPORT Make_off_desc_1(SALT311.StrType s0) := s0;
EXPORT InValid_off_desc_1(SALT311.StrType s) := 0;
EXPORT InValidMessage_off_desc_1(UNSIGNED1 wh) := '';
 
EXPORT Make_off_desc_2(SALT311.StrType s0) := s0;
EXPORT InValid_off_desc_2(SALT311.StrType s) := 0;
EXPORT InValidMessage_off_desc_2(UNSIGNED1 wh) := '';
 
EXPORT Make_add_off_cd(SALT311.StrType s0) := s0;
EXPORT InValid_add_off_cd(SALT311.StrType s) := 0;
EXPORT InValidMessage_add_off_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_add_off_desc(SALT311.StrType s0) := s0;
EXPORT InValid_add_off_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_add_off_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_off_typ(SALT311.StrType s0) := MakeFT_Invalid_Off_Typ(s0);
EXPORT InValid_off_typ(SALT311.StrType s) := InValidFT_Invalid_Off_Typ(s);
EXPORT InValidMessage_off_typ(UNSIGNED1 wh) := InValidMessageFT_Invalid_Off_Typ(wh);
 
EXPORT Make_off_lev(SALT311.StrType s0) := MakeFT_Invalid_OffLev(s0);
EXPORT InValid_off_lev(SALT311.StrType s) := InValidFT_Invalid_OffLev(s);
EXPORT InValidMessage_off_lev(UNSIGNED1 wh) := InValidMessageFT_Invalid_OffLev(wh);
 
EXPORT Make_arr_disp_date(SALT311.StrType s0) := MakeFT_Invalid_Current_Date(s0);
EXPORT InValid_arr_disp_date(SALT311.StrType s) := InValidFT_Invalid_Current_Date(s);
EXPORT InValidMessage_arr_disp_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Current_Date(wh);
 
EXPORT Make_arr_disp_cd(SALT311.StrType s0) := s0;
EXPORT InValid_arr_disp_cd(SALT311.StrType s) := 0;
EXPORT InValidMessage_arr_disp_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_arr_disp_desc_1(SALT311.StrType s0) := s0;
EXPORT InValid_arr_disp_desc_1(SALT311.StrType s) := 0;
EXPORT InValidMessage_arr_disp_desc_1(UNSIGNED1 wh) := '';
 
EXPORT Make_arr_disp_desc_2(SALT311.StrType s0) := s0;
EXPORT InValid_arr_disp_desc_2(SALT311.StrType s) := 0;
EXPORT InValidMessage_arr_disp_desc_2(UNSIGNED1 wh) := '';
 
EXPORT Make_arr_disp_desc_3(SALT311.StrType s0) := s0;
EXPORT InValid_arr_disp_desc_3(SALT311.StrType s) := 0;
EXPORT InValidMessage_arr_disp_desc_3(UNSIGNED1 wh) := '';
 
EXPORT Make_court_cd(SALT311.StrType s0) := s0;
EXPORT InValid_court_cd(SALT311.StrType s) := 0;
EXPORT InValidMessage_court_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_court_desc(SALT311.StrType s0) := s0;
EXPORT InValid_court_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_court_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_ct_dist(SALT311.StrType s0) := s0;
EXPORT InValid_ct_dist(SALT311.StrType s) := 0;
EXPORT InValidMessage_ct_dist(UNSIGNED1 wh) := '';
 
EXPORT Make_ct_fnl_plea_cd(SALT311.StrType s0) := s0;
EXPORT InValid_ct_fnl_plea_cd(SALT311.StrType s) := 0;
EXPORT InValidMessage_ct_fnl_plea_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_ct_fnl_plea(SALT311.StrType s0) := s0;
EXPORT InValid_ct_fnl_plea(SALT311.StrType s) := 0;
EXPORT InValidMessage_ct_fnl_plea(UNSIGNED1 wh) := '';
 
EXPORT Make_ct_off_code(SALT311.StrType s0) := s0;
EXPORT InValid_ct_off_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_ct_off_code(UNSIGNED1 wh) := '';
 
EXPORT Make_ct_chg(SALT311.StrType s0) := s0;
EXPORT InValid_ct_chg(SALT311.StrType s) := 0;
EXPORT InValidMessage_ct_chg(UNSIGNED1 wh) := '';
 
EXPORT Make_ct_chg_typ_flg(SALT311.StrType s0) := s0;
EXPORT InValid_ct_chg_typ_flg(SALT311.StrType s) := 0;
EXPORT InValidMessage_ct_chg_typ_flg(UNSIGNED1 wh) := '';
 
EXPORT Make_ct_off_desc_1(SALT311.StrType s0) := s0;
EXPORT InValid_ct_off_desc_1(SALT311.StrType s) := 0;
EXPORT InValidMessage_ct_off_desc_1(UNSIGNED1 wh) := '';
 
EXPORT Make_ct_off_desc_2(SALT311.StrType s0) := s0;
EXPORT InValid_ct_off_desc_2(SALT311.StrType s) := 0;
EXPORT InValidMessage_ct_off_desc_2(UNSIGNED1 wh) := '';
 
EXPORT Make_ct_addl_desc_cd(SALT311.StrType s0) := s0;
EXPORT InValid_ct_addl_desc_cd(SALT311.StrType s) := 0;
EXPORT InValidMessage_ct_addl_desc_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_ct_off_lev(SALT311.StrType s0) := s0;
EXPORT InValid_ct_off_lev(SALT311.StrType s) := 0;
EXPORT InValidMessage_ct_off_lev(UNSIGNED1 wh) := '';
 
EXPORT Make_ct_disp_dt(SALT311.StrType s0) := MakeFT_Invalid_Current_Date(s0);
EXPORT InValid_ct_disp_dt(SALT311.StrType s) := InValidFT_Invalid_Current_Date(s);
EXPORT InValidMessage_ct_disp_dt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Current_Date(wh);
 
EXPORT Make_ct_disp_cd(SALT311.StrType s0) := s0;
EXPORT InValid_ct_disp_cd(SALT311.StrType s) := 0;
EXPORT InValidMessage_ct_disp_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_ct_disp_desc_1(SALT311.StrType s0) := s0;
EXPORT InValid_ct_disp_desc_1(SALT311.StrType s) := 0;
EXPORT InValidMessage_ct_disp_desc_1(UNSIGNED1 wh) := '';
 
EXPORT Make_ct_disp_desc_2(SALT311.StrType s0) := s0;
EXPORT InValid_ct_disp_desc_2(SALT311.StrType s) := 0;
EXPORT InValidMessage_ct_disp_desc_2(UNSIGNED1 wh) := '';
 
EXPORT Make_cty_conv_cd(SALT311.StrType s0) := MakeFT_Invalid_CtyConvCd(s0);
EXPORT InValid_cty_conv_cd(SALT311.StrType s) := InValidFT_Invalid_CtyConvCd(s);
EXPORT InValidMessage_cty_conv_cd(UNSIGNED1 wh) := InValidMessageFT_Invalid_CtyConvCd(wh);
 
EXPORT Make_cty_conv(SALT311.StrType s0) := s0;
EXPORT InValid_cty_conv(SALT311.StrType s) := 0;
EXPORT InValidMessage_cty_conv(UNSIGNED1 wh) := '';
 
EXPORT Make_adj_wthd(SALT311.StrType s0) := s0;
EXPORT InValid_adj_wthd(SALT311.StrType s) := 0;
EXPORT InValidMessage_adj_wthd(UNSIGNED1 wh) := '';
 
EXPORT Make_stc_dt(SALT311.StrType s0) := MakeFT_Invalid_Future_Date(s0);
EXPORT InValid_stc_dt(SALT311.StrType s) := InValidFT_Invalid_Future_Date(s);
EXPORT InValidMessage_stc_dt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Future_Date(wh);
 
EXPORT Make_stc_cd(SALT311.StrType s0) := s0;
EXPORT InValid_stc_cd(SALT311.StrType s) := 0;
EXPORT InValidMessage_stc_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_stc_comp(SALT311.StrType s0) := s0;
EXPORT InValid_stc_comp(SALT311.StrType s) := 0;
EXPORT InValidMessage_stc_comp(UNSIGNED1 wh) := '';
 
EXPORT Make_stc_desc_1(SALT311.StrType s0) := s0;
EXPORT InValid_stc_desc_1(SALT311.StrType s) := 0;
EXPORT InValidMessage_stc_desc_1(UNSIGNED1 wh) := '';
 
EXPORT Make_stc_desc_2(SALT311.StrType s0) := s0;
EXPORT InValid_stc_desc_2(SALT311.StrType s) := 0;
EXPORT InValidMessage_stc_desc_2(UNSIGNED1 wh) := '';
 
EXPORT Make_stc_desc_3(SALT311.StrType s0) := s0;
EXPORT InValid_stc_desc_3(SALT311.StrType s) := 0;
EXPORT InValidMessage_stc_desc_3(UNSIGNED1 wh) := '';
 
EXPORT Make_stc_desc_4(SALT311.StrType s0) := s0;
EXPORT InValid_stc_desc_4(SALT311.StrType s) := 0;
EXPORT InValidMessage_stc_desc_4(UNSIGNED1 wh) := '';
 
EXPORT Make_stc_lgth(SALT311.StrType s0) := s0;
EXPORT InValid_stc_lgth(SALT311.StrType s) := 0;
EXPORT InValidMessage_stc_lgth(UNSIGNED1 wh) := '';
 
EXPORT Make_stc_lgth_desc(SALT311.StrType s0) := s0;
EXPORT InValid_stc_lgth_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_stc_lgth_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_inc_adm_dt(SALT311.StrType s0) := s0;
EXPORT InValid_inc_adm_dt(SALT311.StrType s) := 0;
EXPORT InValidMessage_inc_adm_dt(UNSIGNED1 wh) := '';
 
EXPORT Make_min_term(SALT311.StrType s0) := s0;
EXPORT InValid_min_term(SALT311.StrType s) := 0;
EXPORT InValidMessage_min_term(UNSIGNED1 wh) := '';
 
EXPORT Make_min_term_desc(SALT311.StrType s0) := s0;
EXPORT InValid_min_term_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_min_term_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_max_term(SALT311.StrType s0) := s0;
EXPORT InValid_max_term(SALT311.StrType s) := 0;
EXPORT InValidMessage_max_term(UNSIGNED1 wh) := '';
 
EXPORT Make_max_term_desc(SALT311.StrType s0) := s0;
EXPORT InValid_max_term_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_max_term_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_parole(SALT311.StrType s0) := s0;
EXPORT InValid_parole(SALT311.StrType s) := 0;
EXPORT InValidMessage_parole(UNSIGNED1 wh) := '';
 
EXPORT Make_probation(SALT311.StrType s0) := s0;
EXPORT InValid_probation(SALT311.StrType s) := 0;
EXPORT InValidMessage_probation(UNSIGNED1 wh) := '';
 
EXPORT Make_offensetown(SALT311.StrType s0) := s0;
EXPORT InValid_offensetown(SALT311.StrType s) := 0;
EXPORT InValidMessage_offensetown(UNSIGNED1 wh) := '';
 
EXPORT Make_convict_dt(SALT311.StrType s0) := MakeFT_Invalid_Current_Date(s0);
EXPORT InValid_convict_dt(SALT311.StrType s) := InValidFT_Invalid_Current_Date(s);
EXPORT InValidMessage_convict_dt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Current_Date(wh);
 
EXPORT Make_court_county(SALT311.StrType s0) := s0;
EXPORT InValid_court_county(SALT311.StrType s) := 0;
EXPORT InValidMessage_court_county(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_offense_score(SALT311.StrType s0) := s0;
EXPORT InValid_offense_score(SALT311.StrType s) := 0;
EXPORT InValidMessage_offense_score(UNSIGNED1 wh) := '';
 
EXPORT Make_offense_persistent_id(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_offense_persistent_id(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_offense_persistent_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_offense_category(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_offense_category(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_offense_category(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_hyg_classification_code(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_hyg_classification_code(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_hyg_classification_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_old_ln_offense_score(SALT311.StrType s0) := MakeFT_Invalid_OffenseScore(s0);
EXPORT InValid_old_ln_offense_score(SALT311.StrType s) := InValidFT_Invalid_OffenseScore(s);
EXPORT InValidMessage_old_ln_offense_score(UNSIGNED1 wh) := InValidMessageFT_Invalid_OffenseScore(wh);
 
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
    BOOLEAN Diff_county_of_origin;
    BOOLEAN Diff_source_file;
    BOOLEAN Diff_data_type;
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_orig_state;
    BOOLEAN Diff_offense_key;
    BOOLEAN Diff_off_date;
    BOOLEAN Diff_arr_date;
    BOOLEAN Diff_case_num;
    BOOLEAN Diff_total_num_of_offenses;
    BOOLEAN Diff_num_of_counts;
    BOOLEAN Diff_off_code;
    BOOLEAN Diff_chg;
    BOOLEAN Diff_chg_typ_flg;
    BOOLEAN Diff_off_of_record;
    BOOLEAN Diff_off_desc_1;
    BOOLEAN Diff_off_desc_2;
    BOOLEAN Diff_add_off_cd;
    BOOLEAN Diff_add_off_desc;
    BOOLEAN Diff_off_typ;
    BOOLEAN Diff_off_lev;
    BOOLEAN Diff_arr_disp_date;
    BOOLEAN Diff_arr_disp_cd;
    BOOLEAN Diff_arr_disp_desc_1;
    BOOLEAN Diff_arr_disp_desc_2;
    BOOLEAN Diff_arr_disp_desc_3;
    BOOLEAN Diff_court_cd;
    BOOLEAN Diff_court_desc;
    BOOLEAN Diff_ct_dist;
    BOOLEAN Diff_ct_fnl_plea_cd;
    BOOLEAN Diff_ct_fnl_plea;
    BOOLEAN Diff_ct_off_code;
    BOOLEAN Diff_ct_chg;
    BOOLEAN Diff_ct_chg_typ_flg;
    BOOLEAN Diff_ct_off_desc_1;
    BOOLEAN Diff_ct_off_desc_2;
    BOOLEAN Diff_ct_addl_desc_cd;
    BOOLEAN Diff_ct_off_lev;
    BOOLEAN Diff_ct_disp_dt;
    BOOLEAN Diff_ct_disp_cd;
    BOOLEAN Diff_ct_disp_desc_1;
    BOOLEAN Diff_ct_disp_desc_2;
    BOOLEAN Diff_cty_conv_cd;
    BOOLEAN Diff_cty_conv;
    BOOLEAN Diff_adj_wthd;
    BOOLEAN Diff_stc_dt;
    BOOLEAN Diff_stc_cd;
    BOOLEAN Diff_stc_comp;
    BOOLEAN Diff_stc_desc_1;
    BOOLEAN Diff_stc_desc_2;
    BOOLEAN Diff_stc_desc_3;
    BOOLEAN Diff_stc_desc_4;
    BOOLEAN Diff_stc_lgth;
    BOOLEAN Diff_stc_lgth_desc;
    BOOLEAN Diff_inc_adm_dt;
    BOOLEAN Diff_min_term;
    BOOLEAN Diff_min_term_desc;
    BOOLEAN Diff_max_term;
    BOOLEAN Diff_max_term_desc;
    BOOLEAN Diff_parole;
    BOOLEAN Diff_probation;
    BOOLEAN Diff_offensetown;
    BOOLEAN Diff_convict_dt;
    BOOLEAN Diff_court_county;
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
    BOOLEAN Diff_hyg_classification_code;
    BOOLEAN Diff_old_ln_offense_score;
    SALT311.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_offender_key := le.offender_key <> ri.offender_key;
    SELF.Diff_vendor := le.vendor <> ri.vendor;
    SELF.Diff_county_of_origin := le.county_of_origin <> ri.county_of_origin;
    SELF.Diff_source_file := le.source_file <> ri.source_file;
    SELF.Diff_data_type := le.data_type <> ri.data_type;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_orig_state := le.orig_state <> ri.orig_state;
    SELF.Diff_offense_key := le.offense_key <> ri.offense_key;
    SELF.Diff_off_date := le.off_date <> ri.off_date;
    SELF.Diff_arr_date := le.arr_date <> ri.arr_date;
    SELF.Diff_case_num := le.case_num <> ri.case_num;
    SELF.Diff_total_num_of_offenses := le.total_num_of_offenses <> ri.total_num_of_offenses;
    SELF.Diff_num_of_counts := le.num_of_counts <> ri.num_of_counts;
    SELF.Diff_off_code := le.off_code <> ri.off_code;
    SELF.Diff_chg := le.chg <> ri.chg;
    SELF.Diff_chg_typ_flg := le.chg_typ_flg <> ri.chg_typ_flg;
    SELF.Diff_off_of_record := le.off_of_record <> ri.off_of_record;
    SELF.Diff_off_desc_1 := le.off_desc_1 <> ri.off_desc_1;
    SELF.Diff_off_desc_2 := le.off_desc_2 <> ri.off_desc_2;
    SELF.Diff_add_off_cd := le.add_off_cd <> ri.add_off_cd;
    SELF.Diff_add_off_desc := le.add_off_desc <> ri.add_off_desc;
    SELF.Diff_off_typ := le.off_typ <> ri.off_typ;
    SELF.Diff_off_lev := le.off_lev <> ri.off_lev;
    SELF.Diff_arr_disp_date := le.arr_disp_date <> ri.arr_disp_date;
    SELF.Diff_arr_disp_cd := le.arr_disp_cd <> ri.arr_disp_cd;
    SELF.Diff_arr_disp_desc_1 := le.arr_disp_desc_1 <> ri.arr_disp_desc_1;
    SELF.Diff_arr_disp_desc_2 := le.arr_disp_desc_2 <> ri.arr_disp_desc_2;
    SELF.Diff_arr_disp_desc_3 := le.arr_disp_desc_3 <> ri.arr_disp_desc_3;
    SELF.Diff_court_cd := le.court_cd <> ri.court_cd;
    SELF.Diff_court_desc := le.court_desc <> ri.court_desc;
    SELF.Diff_ct_dist := le.ct_dist <> ri.ct_dist;
    SELF.Diff_ct_fnl_plea_cd := le.ct_fnl_plea_cd <> ri.ct_fnl_plea_cd;
    SELF.Diff_ct_fnl_plea := le.ct_fnl_plea <> ri.ct_fnl_plea;
    SELF.Diff_ct_off_code := le.ct_off_code <> ri.ct_off_code;
    SELF.Diff_ct_chg := le.ct_chg <> ri.ct_chg;
    SELF.Diff_ct_chg_typ_flg := le.ct_chg_typ_flg <> ri.ct_chg_typ_flg;
    SELF.Diff_ct_off_desc_1 := le.ct_off_desc_1 <> ri.ct_off_desc_1;
    SELF.Diff_ct_off_desc_2 := le.ct_off_desc_2 <> ri.ct_off_desc_2;
    SELF.Diff_ct_addl_desc_cd := le.ct_addl_desc_cd <> ri.ct_addl_desc_cd;
    SELF.Diff_ct_off_lev := le.ct_off_lev <> ri.ct_off_lev;
    SELF.Diff_ct_disp_dt := le.ct_disp_dt <> ri.ct_disp_dt;
    SELF.Diff_ct_disp_cd := le.ct_disp_cd <> ri.ct_disp_cd;
    SELF.Diff_ct_disp_desc_1 := le.ct_disp_desc_1 <> ri.ct_disp_desc_1;
    SELF.Diff_ct_disp_desc_2 := le.ct_disp_desc_2 <> ri.ct_disp_desc_2;
    SELF.Diff_cty_conv_cd := le.cty_conv_cd <> ri.cty_conv_cd;
    SELF.Diff_cty_conv := le.cty_conv <> ri.cty_conv;
    SELF.Diff_adj_wthd := le.adj_wthd <> ri.adj_wthd;
    SELF.Diff_stc_dt := le.stc_dt <> ri.stc_dt;
    SELF.Diff_stc_cd := le.stc_cd <> ri.stc_cd;
    SELF.Diff_stc_comp := le.stc_comp <> ri.stc_comp;
    SELF.Diff_stc_desc_1 := le.stc_desc_1 <> ri.stc_desc_1;
    SELF.Diff_stc_desc_2 := le.stc_desc_2 <> ri.stc_desc_2;
    SELF.Diff_stc_desc_3 := le.stc_desc_3 <> ri.stc_desc_3;
    SELF.Diff_stc_desc_4 := le.stc_desc_4 <> ri.stc_desc_4;
    SELF.Diff_stc_lgth := le.stc_lgth <> ri.stc_lgth;
    SELF.Diff_stc_lgth_desc := le.stc_lgth_desc <> ri.stc_lgth_desc;
    SELF.Diff_inc_adm_dt := le.inc_adm_dt <> ri.inc_adm_dt;
    SELF.Diff_min_term := le.min_term <> ri.min_term;
    SELF.Diff_min_term_desc := le.min_term_desc <> ri.min_term_desc;
    SELF.Diff_max_term := le.max_term <> ri.max_term;
    SELF.Diff_max_term_desc := le.max_term_desc <> ri.max_term_desc;
    SELF.Diff_parole := le.parole <> ri.parole;
    SELF.Diff_probation := le.probation <> ri.probation;
    SELF.Diff_offensetown := le.offensetown <> ri.offensetown;
    SELF.Diff_convict_dt := le.convict_dt <> ri.convict_dt;
    SELF.Diff_court_county := le.court_county <> ri.court_county;
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
    SELF.Diff_hyg_classification_code := le.hyg_classification_code <> ri.hyg_classification_code;
    SELF.Diff_old_ln_offense_score := le.old_ln_offense_score <> ri.old_ln_offense_score;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.vendor;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_offender_key,1,0)+ IF( SELF.Diff_vendor,1,0)+ IF( SELF.Diff_county_of_origin,1,0)+ IF( SELF.Diff_source_file,1,0)+ IF( SELF.Diff_data_type,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_orig_state,1,0)+ IF( SELF.Diff_offense_key,1,0)+ IF( SELF.Diff_off_date,1,0)+ IF( SELF.Diff_arr_date,1,0)+ IF( SELF.Diff_case_num,1,0)+ IF( SELF.Diff_total_num_of_offenses,1,0)+ IF( SELF.Diff_num_of_counts,1,0)+ IF( SELF.Diff_off_code,1,0)+ IF( SELF.Diff_chg,1,0)+ IF( SELF.Diff_chg_typ_flg,1,0)+ IF( SELF.Diff_off_of_record,1,0)+ IF( SELF.Diff_off_desc_1,1,0)+ IF( SELF.Diff_off_desc_2,1,0)+ IF( SELF.Diff_add_off_cd,1,0)+ IF( SELF.Diff_add_off_desc,1,0)+ IF( SELF.Diff_off_typ,1,0)+ IF( SELF.Diff_off_lev,1,0)+ IF( SELF.Diff_arr_disp_date,1,0)+ IF( SELF.Diff_arr_disp_cd,1,0)+ IF( SELF.Diff_arr_disp_desc_1,1,0)+ IF( SELF.Diff_arr_disp_desc_2,1,0)+ IF( SELF.Diff_arr_disp_desc_3,1,0)+ IF( SELF.Diff_court_cd,1,0)+ IF( SELF.Diff_court_desc,1,0)+ IF( SELF.Diff_ct_dist,1,0)+ IF( SELF.Diff_ct_fnl_plea_cd,1,0)+ IF( SELF.Diff_ct_fnl_plea,1,0)+ IF( SELF.Diff_ct_off_code,1,0)+ IF( SELF.Diff_ct_chg,1,0)+ IF( SELF.Diff_ct_chg_typ_flg,1,0)+ IF( SELF.Diff_ct_off_desc_1,1,0)+ IF( SELF.Diff_ct_off_desc_2,1,0)+ IF( SELF.Diff_ct_addl_desc_cd,1,0)+ IF( SELF.Diff_ct_off_lev,1,0)+ IF( SELF.Diff_ct_disp_dt,1,0)+ IF( SELF.Diff_ct_disp_cd,1,0)+ IF( SELF.Diff_ct_disp_desc_1,1,0)+ IF( SELF.Diff_ct_disp_desc_2,1,0)+ IF( SELF.Diff_cty_conv_cd,1,0)+ IF( SELF.Diff_cty_conv,1,0)+ IF( SELF.Diff_adj_wthd,1,0)+ IF( SELF.Diff_stc_dt,1,0)+ IF( SELF.Diff_stc_cd,1,0)+ IF( SELF.Diff_stc_comp,1,0)+ IF( SELF.Diff_stc_desc_1,1,0)+ IF( SELF.Diff_stc_desc_2,1,0)+ IF( SELF.Diff_stc_desc_3,1,0)+ IF( SELF.Diff_stc_desc_4,1,0)+ IF( SELF.Diff_stc_lgth,1,0)+ IF( SELF.Diff_stc_lgth_desc,1,0)+ IF( SELF.Diff_inc_adm_dt,1,0)+ IF( SELF.Diff_min_term,1,0)+ IF( SELF.Diff_min_term_desc,1,0)+ IF( SELF.Diff_max_term,1,0)+ IF( SELF.Diff_max_term_desc,1,0)+ IF( SELF.Diff_parole,1,0)+ IF( SELF.Diff_probation,1,0)+ IF( SELF.Diff_offensetown,1,0)+ IF( SELF.Diff_convict_dt,1,0)+ IF( SELF.Diff_court_county,1,0)+ IF( SELF.Diff_fcra_offense_key,1,0)+ IF( SELF.Diff_fcra_conviction_flag,1,0)+ IF( SELF.Diff_fcra_traffic_flag,1,0)+ IF( SELF.Diff_fcra_date,1,0)+ IF( SELF.Diff_fcra_date_type,1,0)+ IF( SELF.Diff_conviction_override_date,1,0)+ IF( SELF.Diff_conviction_override_date_type,1,0)+ IF( SELF.Diff_offense_score,1,0)+ IF( SELF.Diff_offense_persistent_id,1,0)+ IF( SELF.Diff_offense_category,1,0)+ IF( SELF.Diff_hyg_classification_code,1,0)+ IF( SELF.Diff_old_ln_offense_score,1,0);
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
    Count_Diff_county_of_origin := COUNT(GROUP,%Closest%.Diff_county_of_origin);
    Count_Diff_source_file := COUNT(GROUP,%Closest%.Diff_source_file);
    Count_Diff_data_type := COUNT(GROUP,%Closest%.Diff_data_type);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_orig_state := COUNT(GROUP,%Closest%.Diff_orig_state);
    Count_Diff_offense_key := COUNT(GROUP,%Closest%.Diff_offense_key);
    Count_Diff_off_date := COUNT(GROUP,%Closest%.Diff_off_date);
    Count_Diff_arr_date := COUNT(GROUP,%Closest%.Diff_arr_date);
    Count_Diff_case_num := COUNT(GROUP,%Closest%.Diff_case_num);
    Count_Diff_total_num_of_offenses := COUNT(GROUP,%Closest%.Diff_total_num_of_offenses);
    Count_Diff_num_of_counts := COUNT(GROUP,%Closest%.Diff_num_of_counts);
    Count_Diff_off_code := COUNT(GROUP,%Closest%.Diff_off_code);
    Count_Diff_chg := COUNT(GROUP,%Closest%.Diff_chg);
    Count_Diff_chg_typ_flg := COUNT(GROUP,%Closest%.Diff_chg_typ_flg);
    Count_Diff_off_of_record := COUNT(GROUP,%Closest%.Diff_off_of_record);
    Count_Diff_off_desc_1 := COUNT(GROUP,%Closest%.Diff_off_desc_1);
    Count_Diff_off_desc_2 := COUNT(GROUP,%Closest%.Diff_off_desc_2);
    Count_Diff_add_off_cd := COUNT(GROUP,%Closest%.Diff_add_off_cd);
    Count_Diff_add_off_desc := COUNT(GROUP,%Closest%.Diff_add_off_desc);
    Count_Diff_off_typ := COUNT(GROUP,%Closest%.Diff_off_typ);
    Count_Diff_off_lev := COUNT(GROUP,%Closest%.Diff_off_lev);
    Count_Diff_arr_disp_date := COUNT(GROUP,%Closest%.Diff_arr_disp_date);
    Count_Diff_arr_disp_cd := COUNT(GROUP,%Closest%.Diff_arr_disp_cd);
    Count_Diff_arr_disp_desc_1 := COUNT(GROUP,%Closest%.Diff_arr_disp_desc_1);
    Count_Diff_arr_disp_desc_2 := COUNT(GROUP,%Closest%.Diff_arr_disp_desc_2);
    Count_Diff_arr_disp_desc_3 := COUNT(GROUP,%Closest%.Diff_arr_disp_desc_3);
    Count_Diff_court_cd := COUNT(GROUP,%Closest%.Diff_court_cd);
    Count_Diff_court_desc := COUNT(GROUP,%Closest%.Diff_court_desc);
    Count_Diff_ct_dist := COUNT(GROUP,%Closest%.Diff_ct_dist);
    Count_Diff_ct_fnl_plea_cd := COUNT(GROUP,%Closest%.Diff_ct_fnl_plea_cd);
    Count_Diff_ct_fnl_plea := COUNT(GROUP,%Closest%.Diff_ct_fnl_plea);
    Count_Diff_ct_off_code := COUNT(GROUP,%Closest%.Diff_ct_off_code);
    Count_Diff_ct_chg := COUNT(GROUP,%Closest%.Diff_ct_chg);
    Count_Diff_ct_chg_typ_flg := COUNT(GROUP,%Closest%.Diff_ct_chg_typ_flg);
    Count_Diff_ct_off_desc_1 := COUNT(GROUP,%Closest%.Diff_ct_off_desc_1);
    Count_Diff_ct_off_desc_2 := COUNT(GROUP,%Closest%.Diff_ct_off_desc_2);
    Count_Diff_ct_addl_desc_cd := COUNT(GROUP,%Closest%.Diff_ct_addl_desc_cd);
    Count_Diff_ct_off_lev := COUNT(GROUP,%Closest%.Diff_ct_off_lev);
    Count_Diff_ct_disp_dt := COUNT(GROUP,%Closest%.Diff_ct_disp_dt);
    Count_Diff_ct_disp_cd := COUNT(GROUP,%Closest%.Diff_ct_disp_cd);
    Count_Diff_ct_disp_desc_1 := COUNT(GROUP,%Closest%.Diff_ct_disp_desc_1);
    Count_Diff_ct_disp_desc_2 := COUNT(GROUP,%Closest%.Diff_ct_disp_desc_2);
    Count_Diff_cty_conv_cd := COUNT(GROUP,%Closest%.Diff_cty_conv_cd);
    Count_Diff_cty_conv := COUNT(GROUP,%Closest%.Diff_cty_conv);
    Count_Diff_adj_wthd := COUNT(GROUP,%Closest%.Diff_adj_wthd);
    Count_Diff_stc_dt := COUNT(GROUP,%Closest%.Diff_stc_dt);
    Count_Diff_stc_cd := COUNT(GROUP,%Closest%.Diff_stc_cd);
    Count_Diff_stc_comp := COUNT(GROUP,%Closest%.Diff_stc_comp);
    Count_Diff_stc_desc_1 := COUNT(GROUP,%Closest%.Diff_stc_desc_1);
    Count_Diff_stc_desc_2 := COUNT(GROUP,%Closest%.Diff_stc_desc_2);
    Count_Diff_stc_desc_3 := COUNT(GROUP,%Closest%.Diff_stc_desc_3);
    Count_Diff_stc_desc_4 := COUNT(GROUP,%Closest%.Diff_stc_desc_4);
    Count_Diff_stc_lgth := COUNT(GROUP,%Closest%.Diff_stc_lgth);
    Count_Diff_stc_lgth_desc := COUNT(GROUP,%Closest%.Diff_stc_lgth_desc);
    Count_Diff_inc_adm_dt := COUNT(GROUP,%Closest%.Diff_inc_adm_dt);
    Count_Diff_min_term := COUNT(GROUP,%Closest%.Diff_min_term);
    Count_Diff_min_term_desc := COUNT(GROUP,%Closest%.Diff_min_term_desc);
    Count_Diff_max_term := COUNT(GROUP,%Closest%.Diff_max_term);
    Count_Diff_max_term_desc := COUNT(GROUP,%Closest%.Diff_max_term_desc);
    Count_Diff_parole := COUNT(GROUP,%Closest%.Diff_parole);
    Count_Diff_probation := COUNT(GROUP,%Closest%.Diff_probation);
    Count_Diff_offensetown := COUNT(GROUP,%Closest%.Diff_offensetown);
    Count_Diff_convict_dt := COUNT(GROUP,%Closest%.Diff_convict_dt);
    Count_Diff_court_county := COUNT(GROUP,%Closest%.Diff_court_county);
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
    Count_Diff_hyg_classification_code := COUNT(GROUP,%Closest%.Diff_hyg_classification_code);
    Count_Diff_old_ln_offense_score := COUNT(GROUP,%Closest%.Diff_old_ln_offense_score);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
END;
