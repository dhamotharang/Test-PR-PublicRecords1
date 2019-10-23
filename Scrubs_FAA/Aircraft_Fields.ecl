IMPORT SALT38;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Aircraft_Fields := MODULE
 
EXPORT NumFields := 88;
 
// Processing for each FieldType
EXPORT SALT38.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Num','Invalid_Letter','Invalid_Year','Invalid_SSN','Invalid_Date','Invalid_Flag','Invalid_AlphaNum','Invalid_Type','Invalid_AlphaNumPunct');
EXPORT FieldTypeNum(SALT38.StrType fn) := CASE(fn,'Invalid_Num' => 1,'Invalid_Letter' => 2,'Invalid_Year' => 3,'Invalid_SSN' => 4,'Invalid_Date' => 5,'Invalid_Flag' => 6,'Invalid_AlphaNum' => 7,'Invalid_Type' => 8,'Invalid_AlphaNumPunct' => 9,0);
 
EXPORT MakeFT_Invalid_Num(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Letter(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Letter(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_Invalid_Letter(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Year(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Year(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4));
EXPORT InValidMessageFT_Invalid_Year(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789'),SALT38.HygieneErrors.NotLength('0,4'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_SSN(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_SSN(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_Invalid_SSN(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789'),SALT38.HygieneErrors.NotLength('0,9'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Date(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT38.StrType s) := WHICH(~Scrubs.fn_valid_date(s)>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Flag(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Flag(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['H','I','A']);
EXPORT InValidMessageFT_Invalid_Flag(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('H|I|A'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaNum(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AlphaNum(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 '))));
EXPORT InValidMessageFT_Invalid_AlphaNum(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 '),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Type(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Type(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['0','1','2','3','4','5','6','7','8','9','10','11','']);
EXPORT InValidMessageFT_Invalid_Type(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('0|1|2|3|4|5|6|7|8|9|10|11|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaNumPunct(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_AlphaNumPunct(SALT38.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_Invalid_AlphaNumPunct(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotLength('1..'),SALT38.HygieneErrors.Good);
 
EXPORT SALT38.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'d_score','best_ssn','did_out','bdid_out','date_first_seen','date_last_seen','current_flag','n_number','serial_number','mfr_mdl_code','eng_mfr_mdl','year_mfr','type_registrant','name','street','street2','city','state','zip_code','region','orig_county','country','last_action_date','cert_issue_date','certification','type_aircraft','type_engine','status_code','mode_s_code','fract_owner','aircraft_mfr_name','model_name','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','z4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','title','fname','mname','lname','name_suffix','compname','lf','source_rec_id','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight');
EXPORT SALT38.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'d_score','best_ssn','did_out','bdid_out','date_first_seen','date_last_seen','current_flag','n_number','serial_number','mfr_mdl_code','eng_mfr_mdl','year_mfr','type_registrant','name','street','street2','city','state','zip_code','region','orig_county','country','last_action_date','cert_issue_date','certification','type_aircraft','type_engine','status_code','mode_s_code','fract_owner','aircraft_mfr_name','model_name','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','z4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','title','fname','mname','lname','name_suffix','compname','lf','source_rec_id','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight');
EXPORT FieldNum(SALT38.StrType fn) := CASE(fn,'d_score' => 0,'best_ssn' => 1,'did_out' => 2,'bdid_out' => 3,'date_first_seen' => 4,'date_last_seen' => 5,'current_flag' => 6,'n_number' => 7,'serial_number' => 8,'mfr_mdl_code' => 9,'eng_mfr_mdl' => 10,'year_mfr' => 11,'type_registrant' => 12,'name' => 13,'street' => 14,'street2' => 15,'city' => 16,'state' => 17,'zip_code' => 18,'region' => 19,'orig_county' => 20,'country' => 21,'last_action_date' => 22,'cert_issue_date' => 23,'certification' => 24,'type_aircraft' => 25,'type_engine' => 26,'status_code' => 27,'mode_s_code' => 28,'fract_owner' => 29,'aircraft_mfr_name' => 30,'model_name' => 31,'prim_range' => 32,'predir' => 33,'prim_name' => 34,'addr_suffix' => 35,'postdir' => 36,'unit_desig' => 37,'sec_range' => 38,'p_city_name' => 39,'v_city_name' => 40,'st' => 41,'zip' => 42,'z4' => 43,'cart' => 44,'cr_sort_sz' => 45,'lot' => 46,'lot_order' => 47,'dpbc' => 48,'chk_digit' => 49,'rec_type' => 50,'ace_fips_st' => 51,'county' => 52,'geo_lat' => 53,'geo_long' => 54,'msa' => 55,'geo_blk' => 56,'geo_match' => 57,'err_stat' => 58,'title' => 59,'fname' => 60,'mname' => 61,'lname' => 62,'name_suffix' => 63,'compname' => 64,'lf' => 65,'source_rec_id' => 66,'dotid' => 67,'dotscore' => 68,'dotweight' => 69,'empid' => 70,'empscore' => 71,'empweight' => 72,'powid' => 73,'powscore' => 74,'powweight' => 75,'proxid' => 76,'proxscore' => 77,'proxweight' => 78,'seleid' => 79,'selescore' => 80,'seleweight' => 81,'orgid' => 82,'orgscore' => 83,'orgweight' => 84,'ultid' => 85,'ultscore' => 86,'ultweight' => 87,0);
EXPORT SET OF SALT38.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW','LENGTH'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ENUM'],['ALLOW'],['LENGTH'],['ALLOW'],['ALLOW'],['ALLOW','LENGTH'],['ENUM'],[],[],[],[],['ALLOW'],[],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ENUM'],['ENUM'],['ALLOW'],['ALLOW'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_d_score(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_d_score(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_d_score(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_best_ssn(SALT38.StrType s0) := MakeFT_Invalid_SSN(s0);
EXPORT InValid_best_ssn(SALT38.StrType s) := InValidFT_Invalid_SSN(s);
EXPORT InValidMessage_best_ssn(UNSIGNED1 wh) := InValidMessageFT_Invalid_SSN(wh);
 
EXPORT Make_did_out(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_did_out(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_did_out(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_bdid_out(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_bdid_out(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_bdid_out(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_date_first_seen(SALT38.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_date_first_seen(SALT38.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_date_first_seen(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_date_last_seen(SALT38.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_date_last_seen(SALT38.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_date_last_seen(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_current_flag(SALT38.StrType s0) := MakeFT_Invalid_Flag(s0);
EXPORT InValid_current_flag(SALT38.StrType s) := InValidFT_Invalid_Flag(s);
EXPORT InValidMessage_current_flag(UNSIGNED1 wh) := InValidMessageFT_Invalid_Flag(wh);
 
EXPORT Make_n_number(SALT38.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_n_number(SALT38.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_n_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_serial_number(SALT38.StrType s0) := MakeFT_Invalid_AlphaNumPunct(s0);
EXPORT InValid_serial_number(SALT38.StrType s) := InValidFT_Invalid_AlphaNumPunct(s);
EXPORT InValidMessage_serial_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumPunct(wh);
 
EXPORT Make_mfr_mdl_code(SALT38.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_mfr_mdl_code(SALT38.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_mfr_mdl_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_eng_mfr_mdl(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_eng_mfr_mdl(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_eng_mfr_mdl(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_year_mfr(SALT38.StrType s0) := MakeFT_Invalid_Year(s0);
EXPORT InValid_year_mfr(SALT38.StrType s) := InValidFT_Invalid_Year(s);
EXPORT InValidMessage_year_mfr(UNSIGNED1 wh) := InValidMessageFT_Invalid_Year(wh);
 
EXPORT Make_type_registrant(SALT38.StrType s0) := MakeFT_Invalid_Type(s0);
EXPORT InValid_type_registrant(SALT38.StrType s) := InValidFT_Invalid_Type(s);
EXPORT InValidMessage_type_registrant(UNSIGNED1 wh) := InValidMessageFT_Invalid_Type(wh);
 
EXPORT Make_name(SALT38.StrType s0) := s0;
EXPORT InValid_name(SALT38.StrType s) := 0;
EXPORT InValidMessage_name(UNSIGNED1 wh) := '';
 
EXPORT Make_street(SALT38.StrType s0) := s0;
EXPORT InValid_street(SALT38.StrType s) := 0;
EXPORT InValidMessage_street(UNSIGNED1 wh) := '';
 
EXPORT Make_street2(SALT38.StrType s0) := s0;
EXPORT InValid_street2(SALT38.StrType s) := 0;
EXPORT InValidMessage_street2(UNSIGNED1 wh) := '';
 
EXPORT Make_city(SALT38.StrType s0) := s0;
EXPORT InValid_city(SALT38.StrType s) := 0;
EXPORT InValidMessage_city(UNSIGNED1 wh) := '';
 
EXPORT Make_state(SALT38.StrType s0) := MakeFT_Invalid_Letter(s0);
EXPORT InValid_state(SALT38.StrType s) := InValidFT_Invalid_Letter(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_Letter(wh);
 
EXPORT Make_zip_code(SALT38.StrType s0) := s0;
EXPORT InValid_zip_code(SALT38.StrType s) := 0;
EXPORT InValidMessage_zip_code(UNSIGNED1 wh) := '';
 
EXPORT Make_region(SALT38.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_region(SALT38.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_region(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_orig_county(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_orig_county(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_orig_county(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_country(SALT38.StrType s0) := MakeFT_Invalid_Letter(s0);
EXPORT InValid_country(SALT38.StrType s) := InValidFT_Invalid_Letter(s);
EXPORT InValidMessage_country(UNSIGNED1 wh) := InValidMessageFT_Invalid_Letter(wh);
 
EXPORT Make_last_action_date(SALT38.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_last_action_date(SALT38.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_last_action_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_cert_issue_date(SALT38.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_cert_issue_date(SALT38.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_cert_issue_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_certification(SALT38.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_certification(SALT38.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_certification(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_type_aircraft(SALT38.StrType s0) := MakeFT_Invalid_Type(s0);
EXPORT InValid_type_aircraft(SALT38.StrType s) := InValidFT_Invalid_Type(s);
EXPORT InValidMessage_type_aircraft(UNSIGNED1 wh) := InValidMessageFT_Invalid_Type(wh);
 
EXPORT Make_type_engine(SALT38.StrType s0) := MakeFT_Invalid_Type(s0);
EXPORT InValid_type_engine(SALT38.StrType s) := InValidFT_Invalid_Type(s);
EXPORT InValidMessage_type_engine(UNSIGNED1 wh) := InValidMessageFT_Invalid_Type(wh);
 
EXPORT Make_status_code(SALT38.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_status_code(SALT38.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_status_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_mode_s_code(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_mode_s_code(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_mode_s_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_fract_owner(SALT38.StrType s0) := s0;
EXPORT InValid_fract_owner(SALT38.StrType s) := 0;
EXPORT InValidMessage_fract_owner(UNSIGNED1 wh) := '';
 
EXPORT Make_aircraft_mfr_name(SALT38.StrType s0) := s0;
EXPORT InValid_aircraft_mfr_name(SALT38.StrType s) := 0;
EXPORT InValidMessage_aircraft_mfr_name(UNSIGNED1 wh) := '';
 
EXPORT Make_model_name(SALT38.StrType s0) := s0;
EXPORT InValid_model_name(SALT38.StrType s) := 0;
EXPORT InValidMessage_model_name(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_range(SALT38.StrType s0) := s0;
EXPORT InValid_prim_range(SALT38.StrType s) := 0;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_predir(SALT38.StrType s0) := s0;
EXPORT InValid_predir(SALT38.StrType s) := 0;
EXPORT InValidMessage_predir(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_name(SALT38.StrType s0) := s0;
EXPORT InValid_prim_name(SALT38.StrType s) := 0;
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := '';
 
EXPORT Make_addr_suffix(SALT38.StrType s0) := s0;
EXPORT InValid_addr_suffix(SALT38.StrType s) := 0;
EXPORT InValidMessage_addr_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_postdir(SALT38.StrType s0) := s0;
EXPORT InValid_postdir(SALT38.StrType s) := 0;
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := '';
 
EXPORT Make_unit_desig(SALT38.StrType s0) := s0;
EXPORT InValid_unit_desig(SALT38.StrType s) := 0;
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := '';
 
EXPORT Make_sec_range(SALT38.StrType s0) := s0;
EXPORT InValid_sec_range(SALT38.StrType s) := 0;
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_p_city_name(SALT38.StrType s0) := s0;
EXPORT InValid_p_city_name(SALT38.StrType s) := 0;
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_v_city_name(SALT38.StrType s0) := s0;
EXPORT InValid_v_city_name(SALT38.StrType s) := 0;
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_st(SALT38.StrType s0) := s0;
EXPORT InValid_st(SALT38.StrType s) := 0;
EXPORT InValidMessage_st(UNSIGNED1 wh) := '';
 
EXPORT Make_zip(SALT38.StrType s0) := s0;
EXPORT InValid_zip(SALT38.StrType s) := 0;
EXPORT InValidMessage_zip(UNSIGNED1 wh) := '';
 
EXPORT Make_z4(SALT38.StrType s0) := s0;
EXPORT InValid_z4(SALT38.StrType s) := 0;
EXPORT InValidMessage_z4(UNSIGNED1 wh) := '';
 
EXPORT Make_cart(SALT38.StrType s0) := s0;
EXPORT InValid_cart(SALT38.StrType s) := 0;
EXPORT InValidMessage_cart(UNSIGNED1 wh) := '';
 
EXPORT Make_cr_sort_sz(SALT38.StrType s0) := s0;
EXPORT InValid_cr_sort_sz(SALT38.StrType s) := 0;
EXPORT InValidMessage_cr_sort_sz(UNSIGNED1 wh) := '';
 
EXPORT Make_lot(SALT38.StrType s0) := s0;
EXPORT InValid_lot(SALT38.StrType s) := 0;
EXPORT InValidMessage_lot(UNSIGNED1 wh) := '';
 
EXPORT Make_lot_order(SALT38.StrType s0) := s0;
EXPORT InValid_lot_order(SALT38.StrType s) := 0;
EXPORT InValidMessage_lot_order(UNSIGNED1 wh) := '';
 
EXPORT Make_dpbc(SALT38.StrType s0) := s0;
EXPORT InValid_dpbc(SALT38.StrType s) := 0;
EXPORT InValidMessage_dpbc(UNSIGNED1 wh) := '';
 
EXPORT Make_chk_digit(SALT38.StrType s0) := s0;
EXPORT InValid_chk_digit(SALT38.StrType s) := 0;
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := '';
 
EXPORT Make_rec_type(SALT38.StrType s0) := s0;
EXPORT InValid_rec_type(SALT38.StrType s) := 0;
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := '';
 
EXPORT Make_ace_fips_st(SALT38.StrType s0) := s0;
EXPORT InValid_ace_fips_st(SALT38.StrType s) := 0;
EXPORT InValidMessage_ace_fips_st(UNSIGNED1 wh) := '';
 
EXPORT Make_county(SALT38.StrType s0) := s0;
EXPORT InValid_county(SALT38.StrType s) := 0;
EXPORT InValidMessage_county(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_lat(SALT38.StrType s0) := s0;
EXPORT InValid_geo_lat(SALT38.StrType s) := 0;
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_long(SALT38.StrType s0) := s0;
EXPORT InValid_geo_long(SALT38.StrType s) := 0;
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := '';
 
EXPORT Make_msa(SALT38.StrType s0) := s0;
EXPORT InValid_msa(SALT38.StrType s) := 0;
EXPORT InValidMessage_msa(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_blk(SALT38.StrType s0) := s0;
EXPORT InValid_geo_blk(SALT38.StrType s) := 0;
EXPORT InValidMessage_geo_blk(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_match(SALT38.StrType s0) := s0;
EXPORT InValid_geo_match(SALT38.StrType s) := 0;
EXPORT InValidMessage_geo_match(UNSIGNED1 wh) := '';
 
EXPORT Make_err_stat(SALT38.StrType s0) := s0;
EXPORT InValid_err_stat(SALT38.StrType s) := 0;
EXPORT InValidMessage_err_stat(UNSIGNED1 wh) := '';
 
EXPORT Make_title(SALT38.StrType s0) := s0;
EXPORT InValid_title(SALT38.StrType s) := 0;
EXPORT InValidMessage_title(UNSIGNED1 wh) := '';
 
EXPORT Make_fname(SALT38.StrType s0) := s0;
EXPORT InValid_fname(SALT38.StrType s) := 0;
EXPORT InValidMessage_fname(UNSIGNED1 wh) := '';
 
EXPORT Make_mname(SALT38.StrType s0) := s0;
EXPORT InValid_mname(SALT38.StrType s) := 0;
EXPORT InValidMessage_mname(UNSIGNED1 wh) := '';
 
EXPORT Make_lname(SALT38.StrType s0) := s0;
EXPORT InValid_lname(SALT38.StrType s) := 0;
EXPORT InValidMessage_lname(UNSIGNED1 wh) := '';
 
EXPORT Make_name_suffix(SALT38.StrType s0) := s0;
EXPORT InValid_name_suffix(SALT38.StrType s) := 0;
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_compname(SALT38.StrType s0) := s0;
EXPORT InValid_compname(SALT38.StrType s) := 0;
EXPORT InValidMessage_compname(UNSIGNED1 wh) := '';
 
EXPORT Make_lf(SALT38.StrType s0) := s0;
EXPORT InValid_lf(SALT38.StrType s) := 0;
EXPORT InValidMessage_lf(UNSIGNED1 wh) := '';
 
EXPORT Make_source_rec_id(SALT38.StrType s0) := s0;
EXPORT InValid_source_rec_id(SALT38.StrType s) := 0;
EXPORT InValidMessage_source_rec_id(UNSIGNED1 wh) := '';
 
EXPORT Make_dotid(SALT38.StrType s0) := s0;
EXPORT InValid_dotid(SALT38.StrType s) := 0;
EXPORT InValidMessage_dotid(UNSIGNED1 wh) := '';
 
EXPORT Make_dotscore(SALT38.StrType s0) := s0;
EXPORT InValid_dotscore(SALT38.StrType s) := 0;
EXPORT InValidMessage_dotscore(UNSIGNED1 wh) := '';
 
EXPORT Make_dotweight(SALT38.StrType s0) := s0;
EXPORT InValid_dotweight(SALT38.StrType s) := 0;
EXPORT InValidMessage_dotweight(UNSIGNED1 wh) := '';
 
EXPORT Make_empid(SALT38.StrType s0) := s0;
EXPORT InValid_empid(SALT38.StrType s) := 0;
EXPORT InValidMessage_empid(UNSIGNED1 wh) := '';
 
EXPORT Make_empscore(SALT38.StrType s0) := s0;
EXPORT InValid_empscore(SALT38.StrType s) := 0;
EXPORT InValidMessage_empscore(UNSIGNED1 wh) := '';
 
EXPORT Make_empweight(SALT38.StrType s0) := s0;
EXPORT InValid_empweight(SALT38.StrType s) := 0;
EXPORT InValidMessage_empweight(UNSIGNED1 wh) := '';
 
EXPORT Make_powid(SALT38.StrType s0) := s0;
EXPORT InValid_powid(SALT38.StrType s) := 0;
EXPORT InValidMessage_powid(UNSIGNED1 wh) := '';
 
EXPORT Make_powscore(SALT38.StrType s0) := s0;
EXPORT InValid_powscore(SALT38.StrType s) := 0;
EXPORT InValidMessage_powscore(UNSIGNED1 wh) := '';
 
EXPORT Make_powweight(SALT38.StrType s0) := s0;
EXPORT InValid_powweight(SALT38.StrType s) := 0;
EXPORT InValidMessage_powweight(UNSIGNED1 wh) := '';
 
EXPORT Make_proxid(SALT38.StrType s0) := s0;
EXPORT InValid_proxid(SALT38.StrType s) := 0;
EXPORT InValidMessage_proxid(UNSIGNED1 wh) := '';
 
EXPORT Make_proxscore(SALT38.StrType s0) := s0;
EXPORT InValid_proxscore(SALT38.StrType s) := 0;
EXPORT InValidMessage_proxscore(UNSIGNED1 wh) := '';
 
EXPORT Make_proxweight(SALT38.StrType s0) := s0;
EXPORT InValid_proxweight(SALT38.StrType s) := 0;
EXPORT InValidMessage_proxweight(UNSIGNED1 wh) := '';
 
EXPORT Make_seleid(SALT38.StrType s0) := s0;
EXPORT InValid_seleid(SALT38.StrType s) := 0;
EXPORT InValidMessage_seleid(UNSIGNED1 wh) := '';
 
EXPORT Make_selescore(SALT38.StrType s0) := s0;
EXPORT InValid_selescore(SALT38.StrType s) := 0;
EXPORT InValidMessage_selescore(UNSIGNED1 wh) := '';
 
EXPORT Make_seleweight(SALT38.StrType s0) := s0;
EXPORT InValid_seleweight(SALT38.StrType s) := 0;
EXPORT InValidMessage_seleweight(UNSIGNED1 wh) := '';
 
EXPORT Make_orgid(SALT38.StrType s0) := s0;
EXPORT InValid_orgid(SALT38.StrType s) := 0;
EXPORT InValidMessage_orgid(UNSIGNED1 wh) := '';
 
EXPORT Make_orgscore(SALT38.StrType s0) := s0;
EXPORT InValid_orgscore(SALT38.StrType s) := 0;
EXPORT InValidMessage_orgscore(UNSIGNED1 wh) := '';
 
EXPORT Make_orgweight(SALT38.StrType s0) := s0;
EXPORT InValid_orgweight(SALT38.StrType s) := 0;
EXPORT InValidMessage_orgweight(UNSIGNED1 wh) := '';
 
EXPORT Make_ultid(SALT38.StrType s0) := s0;
EXPORT InValid_ultid(SALT38.StrType s) := 0;
EXPORT InValidMessage_ultid(UNSIGNED1 wh) := '';
 
EXPORT Make_ultscore(SALT38.StrType s0) := s0;
EXPORT InValid_ultscore(SALT38.StrType s) := 0;
EXPORT InValidMessage_ultscore(UNSIGNED1 wh) := '';
 
EXPORT Make_ultweight(SALT38.StrType s0) := s0;
EXPORT InValid_ultweight(SALT38.StrType s) := 0;
EXPORT InValidMessage_ultweight(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT38,Scrubs_FAA;
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
    BOOLEAN Diff_d_score;
    BOOLEAN Diff_best_ssn;
    BOOLEAN Diff_did_out;
    BOOLEAN Diff_bdid_out;
    BOOLEAN Diff_date_first_seen;
    BOOLEAN Diff_date_last_seen;
    BOOLEAN Diff_current_flag;
    BOOLEAN Diff_n_number;
    BOOLEAN Diff_serial_number;
    BOOLEAN Diff_mfr_mdl_code;
    BOOLEAN Diff_eng_mfr_mdl;
    BOOLEAN Diff_year_mfr;
    BOOLEAN Diff_type_registrant;
    BOOLEAN Diff_name;
    BOOLEAN Diff_street;
    BOOLEAN Diff_street2;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zip_code;
    BOOLEAN Diff_region;
    BOOLEAN Diff_orig_county;
    BOOLEAN Diff_country;
    BOOLEAN Diff_last_action_date;
    BOOLEAN Diff_cert_issue_date;
    BOOLEAN Diff_certification;
    BOOLEAN Diff_type_aircraft;
    BOOLEAN Diff_type_engine;
    BOOLEAN Diff_status_code;
    BOOLEAN Diff_mode_s_code;
    BOOLEAN Diff_fract_owner;
    BOOLEAN Diff_aircraft_mfr_name;
    BOOLEAN Diff_model_name;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_predir;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_addr_suffix;
    BOOLEAN Diff_postdir;
    BOOLEAN Diff_unit_desig;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_p_city_name;
    BOOLEAN Diff_v_city_name;
    BOOLEAN Diff_st;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_z4;
    BOOLEAN Diff_cart;
    BOOLEAN Diff_cr_sort_sz;
    BOOLEAN Diff_lot;
    BOOLEAN Diff_lot_order;
    BOOLEAN Diff_dpbc;
    BOOLEAN Diff_chk_digit;
    BOOLEAN Diff_rec_type;
    BOOLEAN Diff_ace_fips_st;
    BOOLEAN Diff_county;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_geo_match;
    BOOLEAN Diff_err_stat;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_compname;
    BOOLEAN Diff_lf;
    BOOLEAN Diff_source_rec_id;
    BOOLEAN Diff_dotid;
    BOOLEAN Diff_dotscore;
    BOOLEAN Diff_dotweight;
    BOOLEAN Diff_empid;
    BOOLEAN Diff_empscore;
    BOOLEAN Diff_empweight;
    BOOLEAN Diff_powid;
    BOOLEAN Diff_powscore;
    BOOLEAN Diff_powweight;
    BOOLEAN Diff_proxid;
    BOOLEAN Diff_proxscore;
    BOOLEAN Diff_proxweight;
    BOOLEAN Diff_seleid;
    BOOLEAN Diff_selescore;
    BOOLEAN Diff_seleweight;
    BOOLEAN Diff_orgid;
    BOOLEAN Diff_orgscore;
    BOOLEAN Diff_orgweight;
    BOOLEAN Diff_ultid;
    BOOLEAN Diff_ultscore;
    BOOLEAN Diff_ultweight;
    UNSIGNED Num_Diffs;
    SALT38.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_d_score := le.d_score <> ri.d_score;
    SELF.Diff_best_ssn := le.best_ssn <> ri.best_ssn;
    SELF.Diff_did_out := le.did_out <> ri.did_out;
    SELF.Diff_bdid_out := le.bdid_out <> ri.bdid_out;
    SELF.Diff_date_first_seen := le.date_first_seen <> ri.date_first_seen;
    SELF.Diff_date_last_seen := le.date_last_seen <> ri.date_last_seen;
    SELF.Diff_current_flag := le.current_flag <> ri.current_flag;
    SELF.Diff_n_number := le.n_number <> ri.n_number;
    SELF.Diff_serial_number := le.serial_number <> ri.serial_number;
    SELF.Diff_mfr_mdl_code := le.mfr_mdl_code <> ri.mfr_mdl_code;
    SELF.Diff_eng_mfr_mdl := le.eng_mfr_mdl <> ri.eng_mfr_mdl;
    SELF.Diff_year_mfr := le.year_mfr <> ri.year_mfr;
    SELF.Diff_type_registrant := le.type_registrant <> ri.type_registrant;
    SELF.Diff_name := le.name <> ri.name;
    SELF.Diff_street := le.street <> ri.street;
    SELF.Diff_street2 := le.street2 <> ri.street2;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zip_code := le.zip_code <> ri.zip_code;
    SELF.Diff_region := le.region <> ri.region;
    SELF.Diff_orig_county := le.orig_county <> ri.orig_county;
    SELF.Diff_country := le.country <> ri.country;
    SELF.Diff_last_action_date := le.last_action_date <> ri.last_action_date;
    SELF.Diff_cert_issue_date := le.cert_issue_date <> ri.cert_issue_date;
    SELF.Diff_certification := le.certification <> ri.certification;
    SELF.Diff_type_aircraft := le.type_aircraft <> ri.type_aircraft;
    SELF.Diff_type_engine := le.type_engine <> ri.type_engine;
    SELF.Diff_status_code := le.status_code <> ri.status_code;
    SELF.Diff_mode_s_code := le.mode_s_code <> ri.mode_s_code;
    SELF.Diff_fract_owner := le.fract_owner <> ri.fract_owner;
    SELF.Diff_aircraft_mfr_name := le.aircraft_mfr_name <> ri.aircraft_mfr_name;
    SELF.Diff_model_name := le.model_name <> ri.model_name;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_predir := le.predir <> ri.predir;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_addr_suffix := le.addr_suffix <> ri.addr_suffix;
    SELF.Diff_postdir := le.postdir <> ri.postdir;
    SELF.Diff_unit_desig := le.unit_desig <> ri.unit_desig;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_p_city_name := le.p_city_name <> ri.p_city_name;
    SELF.Diff_v_city_name := le.v_city_name <> ri.v_city_name;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_z4 := le.z4 <> ri.z4;
    SELF.Diff_cart := le.cart <> ri.cart;
    SELF.Diff_cr_sort_sz := le.cr_sort_sz <> ri.cr_sort_sz;
    SELF.Diff_lot := le.lot <> ri.lot;
    SELF.Diff_lot_order := le.lot_order <> ri.lot_order;
    SELF.Diff_dpbc := le.dpbc <> ri.dpbc;
    SELF.Diff_chk_digit := le.chk_digit <> ri.chk_digit;
    SELF.Diff_rec_type := le.rec_type <> ri.rec_type;
    SELF.Diff_ace_fips_st := le.ace_fips_st <> ri.ace_fips_st;
    SELF.Diff_county := le.county <> ri.county;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_geo_match := le.geo_match <> ri.geo_match;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_compname := le.compname <> ri.compname;
    SELF.Diff_lf := le.lf <> ri.lf;
    SELF.Diff_source_rec_id := le.source_rec_id <> ri.source_rec_id;
    SELF.Diff_dotid := le.dotid <> ri.dotid;
    SELF.Diff_dotscore := le.dotscore <> ri.dotscore;
    SELF.Diff_dotweight := le.dotweight <> ri.dotweight;
    SELF.Diff_empid := le.empid <> ri.empid;
    SELF.Diff_empscore := le.empscore <> ri.empscore;
    SELF.Diff_empweight := le.empweight <> ri.empweight;
    SELF.Diff_powid := le.powid <> ri.powid;
    SELF.Diff_powscore := le.powscore <> ri.powscore;
    SELF.Diff_powweight := le.powweight <> ri.powweight;
    SELF.Diff_proxid := le.proxid <> ri.proxid;
    SELF.Diff_proxscore := le.proxscore <> ri.proxscore;
    SELF.Diff_proxweight := le.proxweight <> ri.proxweight;
    SELF.Diff_seleid := le.seleid <> ri.seleid;
    SELF.Diff_selescore := le.selescore <> ri.selescore;
    SELF.Diff_seleweight := le.seleweight <> ri.seleweight;
    SELF.Diff_orgid := le.orgid <> ri.orgid;
    SELF.Diff_orgscore := le.orgscore <> ri.orgscore;
    SELF.Diff_orgweight := le.orgweight <> ri.orgweight;
    SELF.Diff_ultid := le.ultid <> ri.ultid;
    SELF.Diff_ultscore := le.ultscore <> ri.ultscore;
    SELF.Diff_ultweight := le.ultweight <> ri.ultweight;
    SELF.Val := (SALT38.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_d_score,1,0)+ IF( SELF.Diff_best_ssn,1,0)+ IF( SELF.Diff_did_out,1,0)+ IF( SELF.Diff_bdid_out,1,0)+ IF( SELF.Diff_date_first_seen,1,0)+ IF( SELF.Diff_date_last_seen,1,0)+ IF( SELF.Diff_current_flag,1,0)+ IF( SELF.Diff_n_number,1,0)+ IF( SELF.Diff_serial_number,1,0)+ IF( SELF.Diff_mfr_mdl_code,1,0)+ IF( SELF.Diff_eng_mfr_mdl,1,0)+ IF( SELF.Diff_year_mfr,1,0)+ IF( SELF.Diff_type_registrant,1,0)+ IF( SELF.Diff_name,1,0)+ IF( SELF.Diff_street,1,0)+ IF( SELF.Diff_street2,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zip_code,1,0)+ IF( SELF.Diff_region,1,0)+ IF( SELF.Diff_orig_county,1,0)+ IF( SELF.Diff_country,1,0)+ IF( SELF.Diff_last_action_date,1,0)+ IF( SELF.Diff_cert_issue_date,1,0)+ IF( SELF.Diff_certification,1,0)+ IF( SELF.Diff_type_aircraft,1,0)+ IF( SELF.Diff_type_engine,1,0)+ IF( SELF.Diff_status_code,1,0)+ IF( SELF.Diff_mode_s_code,1,0)+ IF( SELF.Diff_fract_owner,1,0)+ IF( SELF.Diff_aircraft_mfr_name,1,0)+ IF( SELF.Diff_model_name,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_z4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dpbc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_ace_fips_st,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_compname,1,0)+ IF( SELF.Diff_lf,1,0)+ IF( SELF.Diff_source_rec_id,1,0)+ IF( SELF.Diff_dotid,1,0)+ IF( SELF.Diff_dotscore,1,0)+ IF( SELF.Diff_dotweight,1,0)+ IF( SELF.Diff_empid,1,0)+ IF( SELF.Diff_empscore,1,0)+ IF( SELF.Diff_empweight,1,0)+ IF( SELF.Diff_powid,1,0)+ IF( SELF.Diff_powscore,1,0)+ IF( SELF.Diff_powweight,1,0)+ IF( SELF.Diff_proxid,1,0)+ IF( SELF.Diff_proxscore,1,0)+ IF( SELF.Diff_proxweight,1,0)+ IF( SELF.Diff_seleid,1,0)+ IF( SELF.Diff_selescore,1,0)+ IF( SELF.Diff_seleweight,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_orgscore,1,0)+ IF( SELF.Diff_orgweight,1,0)+ IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_ultscore,1,0)+ IF( SELF.Diff_ultweight,1,0);
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
    Count_Diff_d_score := COUNT(GROUP,%Closest%.Diff_d_score);
    Count_Diff_best_ssn := COUNT(GROUP,%Closest%.Diff_best_ssn);
    Count_Diff_did_out := COUNT(GROUP,%Closest%.Diff_did_out);
    Count_Diff_bdid_out := COUNT(GROUP,%Closest%.Diff_bdid_out);
    Count_Diff_date_first_seen := COUNT(GROUP,%Closest%.Diff_date_first_seen);
    Count_Diff_date_last_seen := COUNT(GROUP,%Closest%.Diff_date_last_seen);
    Count_Diff_current_flag := COUNT(GROUP,%Closest%.Diff_current_flag);
    Count_Diff_n_number := COUNT(GROUP,%Closest%.Diff_n_number);
    Count_Diff_serial_number := COUNT(GROUP,%Closest%.Diff_serial_number);
    Count_Diff_mfr_mdl_code := COUNT(GROUP,%Closest%.Diff_mfr_mdl_code);
    Count_Diff_eng_mfr_mdl := COUNT(GROUP,%Closest%.Diff_eng_mfr_mdl);
    Count_Diff_year_mfr := COUNT(GROUP,%Closest%.Diff_year_mfr);
    Count_Diff_type_registrant := COUNT(GROUP,%Closest%.Diff_type_registrant);
    Count_Diff_name := COUNT(GROUP,%Closest%.Diff_name);
    Count_Diff_street := COUNT(GROUP,%Closest%.Diff_street);
    Count_Diff_street2 := COUNT(GROUP,%Closest%.Diff_street2);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zip_code := COUNT(GROUP,%Closest%.Diff_zip_code);
    Count_Diff_region := COUNT(GROUP,%Closest%.Diff_region);
    Count_Diff_orig_county := COUNT(GROUP,%Closest%.Diff_orig_county);
    Count_Diff_country := COUNT(GROUP,%Closest%.Diff_country);
    Count_Diff_last_action_date := COUNT(GROUP,%Closest%.Diff_last_action_date);
    Count_Diff_cert_issue_date := COUNT(GROUP,%Closest%.Diff_cert_issue_date);
    Count_Diff_certification := COUNT(GROUP,%Closest%.Diff_certification);
    Count_Diff_type_aircraft := COUNT(GROUP,%Closest%.Diff_type_aircraft);
    Count_Diff_type_engine := COUNT(GROUP,%Closest%.Diff_type_engine);
    Count_Diff_status_code := COUNT(GROUP,%Closest%.Diff_status_code);
    Count_Diff_mode_s_code := COUNT(GROUP,%Closest%.Diff_mode_s_code);
    Count_Diff_fract_owner := COUNT(GROUP,%Closest%.Diff_fract_owner);
    Count_Diff_aircraft_mfr_name := COUNT(GROUP,%Closest%.Diff_aircraft_mfr_name);
    Count_Diff_model_name := COUNT(GROUP,%Closest%.Diff_model_name);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_predir := COUNT(GROUP,%Closest%.Diff_predir);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_addr_suffix := COUNT(GROUP,%Closest%.Diff_addr_suffix);
    Count_Diff_postdir := COUNT(GROUP,%Closest%.Diff_postdir);
    Count_Diff_unit_desig := COUNT(GROUP,%Closest%.Diff_unit_desig);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_p_city_name := COUNT(GROUP,%Closest%.Diff_p_city_name);
    Count_Diff_v_city_name := COUNT(GROUP,%Closest%.Diff_v_city_name);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_z4 := COUNT(GROUP,%Closest%.Diff_z4);
    Count_Diff_cart := COUNT(GROUP,%Closest%.Diff_cart);
    Count_Diff_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_cr_sort_sz);
    Count_Diff_lot := COUNT(GROUP,%Closest%.Diff_lot);
    Count_Diff_lot_order := COUNT(GROUP,%Closest%.Diff_lot_order);
    Count_Diff_dpbc := COUNT(GROUP,%Closest%.Diff_dpbc);
    Count_Diff_chk_digit := COUNT(GROUP,%Closest%.Diff_chk_digit);
    Count_Diff_rec_type := COUNT(GROUP,%Closest%.Diff_rec_type);
    Count_Diff_ace_fips_st := COUNT(GROUP,%Closest%.Diff_ace_fips_st);
    Count_Diff_county := COUNT(GROUP,%Closest%.Diff_county);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_geo_match := COUNT(GROUP,%Closest%.Diff_geo_match);
    Count_Diff_err_stat := COUNT(GROUP,%Closest%.Diff_err_stat);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_compname := COUNT(GROUP,%Closest%.Diff_compname);
    Count_Diff_lf := COUNT(GROUP,%Closest%.Diff_lf);
    Count_Diff_source_rec_id := COUNT(GROUP,%Closest%.Diff_source_rec_id);
    Count_Diff_dotid := COUNT(GROUP,%Closest%.Diff_dotid);
    Count_Diff_dotscore := COUNT(GROUP,%Closest%.Diff_dotscore);
    Count_Diff_dotweight := COUNT(GROUP,%Closest%.Diff_dotweight);
    Count_Diff_empid := COUNT(GROUP,%Closest%.Diff_empid);
    Count_Diff_empscore := COUNT(GROUP,%Closest%.Diff_empscore);
    Count_Diff_empweight := COUNT(GROUP,%Closest%.Diff_empweight);
    Count_Diff_powid := COUNT(GROUP,%Closest%.Diff_powid);
    Count_Diff_powscore := COUNT(GROUP,%Closest%.Diff_powscore);
    Count_Diff_powweight := COUNT(GROUP,%Closest%.Diff_powweight);
    Count_Diff_proxid := COUNT(GROUP,%Closest%.Diff_proxid);
    Count_Diff_proxscore := COUNT(GROUP,%Closest%.Diff_proxscore);
    Count_Diff_proxweight := COUNT(GROUP,%Closest%.Diff_proxweight);
    Count_Diff_seleid := COUNT(GROUP,%Closest%.Diff_seleid);
    Count_Diff_selescore := COUNT(GROUP,%Closest%.Diff_selescore);
    Count_Diff_seleweight := COUNT(GROUP,%Closest%.Diff_seleweight);
    Count_Diff_orgid := COUNT(GROUP,%Closest%.Diff_orgid);
    Count_Diff_orgscore := COUNT(GROUP,%Closest%.Diff_orgscore);
    Count_Diff_orgweight := COUNT(GROUP,%Closest%.Diff_orgweight);
    Count_Diff_ultid := COUNT(GROUP,%Closest%.Diff_ultid);
    Count_Diff_ultscore := COUNT(GROUP,%Closest%.Diff_ultscore);
    Count_Diff_ultweight := COUNT(GROUP,%Closest%.Diff_ultweight);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
