IMPORT SALT36;
IMPORT Scrubs_BusReg,Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT36.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_ofc1_title','invalid_ofc1_gender','invalid_county','invalid_corpcode','invalid_sos_code','invalid_filing_code','invalid_status','invalid_filing_num','invalid_date','invalid_alphablank');
EXPORT FieldTypeNum(SALT36.StrType fn) := CASE(fn,'invalid_ofc1_title' => 1,'invalid_ofc1_gender' => 2,'invalid_county' => 3,'invalid_corpcode' => 4,'invalid_sos_code' => 5,'invalid_filing_code' => 6,'invalid_status' => 7,'invalid_filing_num' => 8,'invalid_date' => 9,'invalid_alphablank' => 10,0);
 
EXPORT MakeFT_invalid_ofc1_title(SALT36.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_ofc1_title(SALT36.StrType s) := WHICH(((SALT36.StrType) s) NOT IN Scrubs_BusReg.Functions.set_valid_off_title);
EXPORT InValidMessageFT_invalid_ofc1_title(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotInEnum('Scrubs_BusReg.Functions.set_valid_off_title'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_ofc1_gender(SALT36.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_ofc1_gender(SALT36.StrType s) := WHICH(((SALT36.StrType) s) NOT IN Scrubs_BusReg.Functions.set_valid_gender_codes);
EXPORT InValidMessageFT_invalid_ofc1_gender(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotInEnum('Scrubs_BusReg.Functions.set_valid_gender_codes'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_county(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,' -ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_county(SALT36.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,' -ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_county(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotInChars(' -ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_corpcode(SALT36.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_corpcode(SALT36.StrType s) := WHICH(((SALT36.StrType) s) NOT IN Scrubs_BusReg.Functions.set_valid_corp_codes);
EXPORT InValidMessageFT_invalid_corpcode(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotInEnum('Scrubs_BusReg.Functions.set_valid_corp_codes'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sos_code(SALT36.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_sos_code(SALT36.StrType s) := WHICH(((SALT36.StrType) s) NOT IN Scrubs_BusReg.Functions.set_valid_sos_codes);
EXPORT InValidMessageFT_invalid_sos_code(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotInEnum('Scrubs_BusReg.Functions.set_valid_sos_codes'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_filing_code(SALT36.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_filing_code(SALT36.StrType s) := WHICH(((SALT36.StrType) s) NOT IN Scrubs_BusReg.Functions.set_valid_filing_codes);
EXPORT InValidMessageFT_invalid_filing_code(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotInEnum('Scrubs_BusReg.Functions.set_valid_filing_codes'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_status(SALT36.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_status(SALT36.StrType s) := WHICH(((SALT36.StrType) s) NOT IN Scrubs_BusReg.Functions.set_valid_status_codes);
EXPORT InValidMessageFT_invalid_status(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotInEnum('Scrubs_BusReg.Functions.set_valid_status_codes'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_filing_num(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ-/ '); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_filing_num(SALT36.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ-/ '))));
EXPORT InValidMessageFT_invalid_filing_num(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotInChars(' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ-/ '),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_date(SALT36.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_GeneralDate(s)>0);
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotInChars('0123456789'),SALT36.HygieneErrors.CustomFail('Scrubs.fn_valid_GeneralDate'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphablank(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alphablank(SALT36.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_alphablank(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT36.HygieneErrors.Good);
 
EXPORT SALT36.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'ofc1_name','ofc1_title','ofc1_gender','ofc1_add','ofc1_suite','ofc1_city','ofc1_state','ofc1_zip','ofc1_ac','ofc1_phone','ofc1_fein','ofc1_ssn','ofc1_type','company','mail_add','mail_suite','mail_city','mail_state','mail_zip','mail_zip4','mail_key','county','country','district','biz_ac','biz_phone','sic','naics','descript','emp_size','own_size','corpcode','sos_code','filing_cod','state_code','status','filing_num','ctrl_num','start_date','file_date','form_date','exp_date','disol_date','rpt_date','chang_date','loc_add','loc_suite','loc_city','loc_state','loc_zip','loc_zip4','ofc2_name','ofc2_title','ofc2_add','ofc2_csz','ofc2_fein','ofc2_ssn','ofc3_name','ofc3_title','ofc3_add','ofc3_csz','ofc3_fein','ofc3_ssn','ofc4_name','ofc4_title','ofc4_add','ofc4_csz','ofc4_fein','ofc4_ssn','ofc5_name','ofc5_title','ofc5_add','ofc5_csz','ofc5_fein','ofc5_ssn','ofc6_name','ofc6_title','ofc6_add','ofc6_csz','ofc6_fein','ofc6_ssn','fee','fee_2','tax_cl','perm_type','page','volume','comments','jurisdiction','adcrecordno','crlf');
EXPORT FieldNum(SALT36.StrType fn) := CASE(fn,'ofc1_name' => 0,'ofc1_title' => 1,'ofc1_gender' => 2,'ofc1_add' => 3,'ofc1_suite' => 4,'ofc1_city' => 5,'ofc1_state' => 6,'ofc1_zip' => 7,'ofc1_ac' => 8,'ofc1_phone' => 9,'ofc1_fein' => 10,'ofc1_ssn' => 11,'ofc1_type' => 12,'company' => 13,'mail_add' => 14,'mail_suite' => 15,'mail_city' => 16,'mail_state' => 17,'mail_zip' => 18,'mail_zip4' => 19,'mail_key' => 20,'county' => 21,'country' => 22,'district' => 23,'biz_ac' => 24,'biz_phone' => 25,'sic' => 26,'naics' => 27,'descript' => 28,'emp_size' => 29,'own_size' => 30,'corpcode' => 31,'sos_code' => 32,'filing_cod' => 33,'state_code' => 34,'status' => 35,'filing_num' => 36,'ctrl_num' => 37,'start_date' => 38,'file_date' => 39,'form_date' => 40,'exp_date' => 41,'disol_date' => 42,'rpt_date' => 43,'chang_date' => 44,'loc_add' => 45,'loc_suite' => 46,'loc_city' => 47,'loc_state' => 48,'loc_zip' => 49,'loc_zip4' => 50,'ofc2_name' => 51,'ofc2_title' => 52,'ofc2_add' => 53,'ofc2_csz' => 54,'ofc2_fein' => 55,'ofc2_ssn' => 56,'ofc3_name' => 57,'ofc3_title' => 58,'ofc3_add' => 59,'ofc3_csz' => 60,'ofc3_fein' => 61,'ofc3_ssn' => 62,'ofc4_name' => 63,'ofc4_title' => 64,'ofc4_add' => 65,'ofc4_csz' => 66,'ofc4_fein' => 67,'ofc4_ssn' => 68,'ofc5_name' => 69,'ofc5_title' => 70,'ofc5_add' => 71,'ofc5_csz' => 72,'ofc5_fein' => 73,'ofc5_ssn' => 74,'ofc6_name' => 75,'ofc6_title' => 76,'ofc6_add' => 77,'ofc6_csz' => 78,'ofc6_fein' => 79,'ofc6_ssn' => 80,'fee' => 81,'fee_2' => 82,'tax_cl' => 83,'perm_type' => 84,'page' => 85,'volume' => 86,'comments' => 87,'jurisdiction' => 88,'adcrecordno' => 89,'crlf' => 90,0);
 
//Individual field level validation
 
EXPORT Make_ofc1_name(SALT36.StrType s0) := s0;
EXPORT InValid_ofc1_name(SALT36.StrType s) := 0;
EXPORT InValidMessage_ofc1_name(UNSIGNED1 wh) := '';
 
EXPORT Make_ofc1_title(SALT36.StrType s0) := MakeFT_invalid_ofc1_title(s0);
EXPORT InValid_ofc1_title(SALT36.StrType s) := InValidFT_invalid_ofc1_title(s);
EXPORT InValidMessage_ofc1_title(UNSIGNED1 wh) := InValidMessageFT_invalid_ofc1_title(wh);
 
EXPORT Make_ofc1_gender(SALT36.StrType s0) := MakeFT_invalid_ofc1_gender(s0);
EXPORT InValid_ofc1_gender(SALT36.StrType s) := InValidFT_invalid_ofc1_gender(s);
EXPORT InValidMessage_ofc1_gender(UNSIGNED1 wh) := InValidMessageFT_invalid_ofc1_gender(wh);
 
EXPORT Make_ofc1_add(SALT36.StrType s0) := s0;
EXPORT InValid_ofc1_add(SALT36.StrType s) := 0;
EXPORT InValidMessage_ofc1_add(UNSIGNED1 wh) := '';
 
EXPORT Make_ofc1_suite(SALT36.StrType s0) := s0;
EXPORT InValid_ofc1_suite(SALT36.StrType s) := 0;
EXPORT InValidMessage_ofc1_suite(UNSIGNED1 wh) := '';
 
EXPORT Make_ofc1_city(SALT36.StrType s0) := s0;
EXPORT InValid_ofc1_city(SALT36.StrType s) := 0;
EXPORT InValidMessage_ofc1_city(UNSIGNED1 wh) := '';
 
EXPORT Make_ofc1_state(SALT36.StrType s0) := s0;
EXPORT InValid_ofc1_state(SALT36.StrType s) := 0;
EXPORT InValidMessage_ofc1_state(UNSIGNED1 wh) := '';
 
EXPORT Make_ofc1_zip(SALT36.StrType s0) := s0;
EXPORT InValid_ofc1_zip(SALT36.StrType s) := 0;
EXPORT InValidMessage_ofc1_zip(UNSIGNED1 wh) := '';
 
EXPORT Make_ofc1_ac(SALT36.StrType s0) := s0;
EXPORT InValid_ofc1_ac(SALT36.StrType s) := 0;
EXPORT InValidMessage_ofc1_ac(UNSIGNED1 wh) := '';
 
EXPORT Make_ofc1_phone(SALT36.StrType s0) := s0;
EXPORT InValid_ofc1_phone(SALT36.StrType s) := 0;
EXPORT InValidMessage_ofc1_phone(UNSIGNED1 wh) := '';
 
EXPORT Make_ofc1_fein(SALT36.StrType s0) := s0;
EXPORT InValid_ofc1_fein(SALT36.StrType s) := 0;
EXPORT InValidMessage_ofc1_fein(UNSIGNED1 wh) := '';
 
EXPORT Make_ofc1_ssn(SALT36.StrType s0) := s0;
EXPORT InValid_ofc1_ssn(SALT36.StrType s) := 0;
EXPORT InValidMessage_ofc1_ssn(UNSIGNED1 wh) := '';
 
EXPORT Make_ofc1_type(SALT36.StrType s0) := s0;
EXPORT InValid_ofc1_type(SALT36.StrType s) := 0;
EXPORT InValidMessage_ofc1_type(UNSIGNED1 wh) := '';
 
EXPORT Make_company(SALT36.StrType s0) := s0;
EXPORT InValid_company(SALT36.StrType s) := 0;
EXPORT InValidMessage_company(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_add(SALT36.StrType s0) := s0;
EXPORT InValid_mail_add(SALT36.StrType s) := 0;
EXPORT InValidMessage_mail_add(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_suite(SALT36.StrType s0) := s0;
EXPORT InValid_mail_suite(SALT36.StrType s) := 0;
EXPORT InValidMessage_mail_suite(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_city(SALT36.StrType s0) := s0;
EXPORT InValid_mail_city(SALT36.StrType s) := 0;
EXPORT InValidMessage_mail_city(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_state(SALT36.StrType s0) := s0;
EXPORT InValid_mail_state(SALT36.StrType s) := 0;
EXPORT InValidMessage_mail_state(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_zip(SALT36.StrType s0) := s0;
EXPORT InValid_mail_zip(SALT36.StrType s) := 0;
EXPORT InValidMessage_mail_zip(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_zip4(SALT36.StrType s0) := s0;
EXPORT InValid_mail_zip4(SALT36.StrType s) := 0;
EXPORT InValidMessage_mail_zip4(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_key(SALT36.StrType s0) := s0;
EXPORT InValid_mail_key(SALT36.StrType s) := 0;
EXPORT InValidMessage_mail_key(UNSIGNED1 wh) := '';
 
EXPORT Make_county(SALT36.StrType s0) := MakeFT_invalid_county(s0);
EXPORT InValid_county(SALT36.StrType s) := InValidFT_invalid_county(s);
EXPORT InValidMessage_county(UNSIGNED1 wh) := InValidMessageFT_invalid_county(wh);
 
EXPORT Make_country(SALT36.StrType s0) := s0;
EXPORT InValid_country(SALT36.StrType s) := 0;
EXPORT InValidMessage_country(UNSIGNED1 wh) := '';
 
EXPORT Make_district(SALT36.StrType s0) := s0;
EXPORT InValid_district(SALT36.StrType s) := 0;
EXPORT InValidMessage_district(UNSIGNED1 wh) := '';
 
EXPORT Make_biz_ac(SALT36.StrType s0) := s0;
EXPORT InValid_biz_ac(SALT36.StrType s) := 0;
EXPORT InValidMessage_biz_ac(UNSIGNED1 wh) := '';
 
EXPORT Make_biz_phone(SALT36.StrType s0) := s0;
EXPORT InValid_biz_phone(SALT36.StrType s) := 0;
EXPORT InValidMessage_biz_phone(UNSIGNED1 wh) := '';
 
EXPORT Make_sic(SALT36.StrType s0) := s0;
EXPORT InValid_sic(SALT36.StrType s) := 0;
EXPORT InValidMessage_sic(UNSIGNED1 wh) := '';
 
EXPORT Make_naics(SALT36.StrType s0) := s0;
EXPORT InValid_naics(SALT36.StrType s) := 0;
EXPORT InValidMessage_naics(UNSIGNED1 wh) := '';
 
EXPORT Make_descript(SALT36.StrType s0) := s0;
EXPORT InValid_descript(SALT36.StrType s) := 0;
EXPORT InValidMessage_descript(UNSIGNED1 wh) := '';
 
EXPORT Make_emp_size(SALT36.StrType s0) := s0;
EXPORT InValid_emp_size(SALT36.StrType s) := 0;
EXPORT InValidMessage_emp_size(UNSIGNED1 wh) := '';
 
EXPORT Make_own_size(SALT36.StrType s0) := s0;
EXPORT InValid_own_size(SALT36.StrType s) := 0;
EXPORT InValidMessage_own_size(UNSIGNED1 wh) := '';
 
EXPORT Make_corpcode(SALT36.StrType s0) := MakeFT_invalid_corpcode(s0);
EXPORT InValid_corpcode(SALT36.StrType s) := InValidFT_invalid_corpcode(s);
EXPORT InValidMessage_corpcode(UNSIGNED1 wh) := InValidMessageFT_invalid_corpcode(wh);
 
EXPORT Make_sos_code(SALT36.StrType s0) := MakeFT_invalid_sos_code(s0);
EXPORT InValid_sos_code(SALT36.StrType s) := InValidFT_invalid_sos_code(s);
EXPORT InValidMessage_sos_code(UNSIGNED1 wh) := InValidMessageFT_invalid_sos_code(wh);
 
EXPORT Make_filing_cod(SALT36.StrType s0) := MakeFT_invalid_filing_code(s0);
EXPORT InValid_filing_cod(SALT36.StrType s) := InValidFT_invalid_filing_code(s);
EXPORT InValidMessage_filing_cod(UNSIGNED1 wh) := InValidMessageFT_invalid_filing_code(wh);
 
EXPORT Make_state_code(SALT36.StrType s0) := s0;
EXPORT InValid_state_code(SALT36.StrType s) := 0;
EXPORT InValidMessage_state_code(UNSIGNED1 wh) := '';
 
EXPORT Make_status(SALT36.StrType s0) := MakeFT_invalid_status(s0);
EXPORT InValid_status(SALT36.StrType s) := InValidFT_invalid_status(s);
EXPORT InValidMessage_status(UNSIGNED1 wh) := InValidMessageFT_invalid_status(wh);
 
EXPORT Make_filing_num(SALT36.StrType s0) := MakeFT_invalid_filing_num(s0);
EXPORT InValid_filing_num(SALT36.StrType s) := InValidFT_invalid_filing_num(s);
EXPORT InValidMessage_filing_num(UNSIGNED1 wh) := InValidMessageFT_invalid_filing_num(wh);
 
EXPORT Make_ctrl_num(SALT36.StrType s0) := s0;
EXPORT InValid_ctrl_num(SALT36.StrType s) := 0;
EXPORT InValidMessage_ctrl_num(UNSIGNED1 wh) := '';
 
EXPORT Make_start_date(SALT36.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_start_date(SALT36.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_start_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_file_date(SALT36.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_file_date(SALT36.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_file_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_form_date(SALT36.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_form_date(SALT36.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_form_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_exp_date(SALT36.StrType s0) := s0;
EXPORT InValid_exp_date(SALT36.StrType s) := 0;
EXPORT InValidMessage_exp_date(UNSIGNED1 wh) := '';
 
EXPORT Make_disol_date(SALT36.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_disol_date(SALT36.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_disol_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_rpt_date(SALT36.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_rpt_date(SALT36.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_rpt_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_chang_date(SALT36.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_chang_date(SALT36.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_chang_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_loc_add(SALT36.StrType s0) := s0;
EXPORT InValid_loc_add(SALT36.StrType s) := 0;
EXPORT InValidMessage_loc_add(UNSIGNED1 wh) := '';
 
EXPORT Make_loc_suite(SALT36.StrType s0) := s0;
EXPORT InValid_loc_suite(SALT36.StrType s) := 0;
EXPORT InValidMessage_loc_suite(UNSIGNED1 wh) := '';
 
EXPORT Make_loc_city(SALT36.StrType s0) := s0;
EXPORT InValid_loc_city(SALT36.StrType s) := 0;
EXPORT InValidMessage_loc_city(UNSIGNED1 wh) := '';
 
EXPORT Make_loc_state(SALT36.StrType s0) := s0;
EXPORT InValid_loc_state(SALT36.StrType s) := 0;
EXPORT InValidMessage_loc_state(UNSIGNED1 wh) := '';
 
EXPORT Make_loc_zip(SALT36.StrType s0) := s0;
EXPORT InValid_loc_zip(SALT36.StrType s) := 0;
EXPORT InValidMessage_loc_zip(UNSIGNED1 wh) := '';
 
EXPORT Make_loc_zip4(SALT36.StrType s0) := s0;
EXPORT InValid_loc_zip4(SALT36.StrType s) := 0;
EXPORT InValidMessage_loc_zip4(UNSIGNED1 wh) := '';
 
EXPORT Make_ofc2_name(SALT36.StrType s0) := s0;
EXPORT InValid_ofc2_name(SALT36.StrType s) := 0;
EXPORT InValidMessage_ofc2_name(UNSIGNED1 wh) := '';
 
EXPORT Make_ofc2_title(SALT36.StrType s0) := MakeFT_invalid_ofc1_title(s0);
EXPORT InValid_ofc2_title(SALT36.StrType s) := InValidFT_invalid_ofc1_title(s);
EXPORT InValidMessage_ofc2_title(UNSIGNED1 wh) := InValidMessageFT_invalid_ofc1_title(wh);
 
EXPORT Make_ofc2_add(SALT36.StrType s0) := s0;
EXPORT InValid_ofc2_add(SALT36.StrType s) := 0;
EXPORT InValidMessage_ofc2_add(UNSIGNED1 wh) := '';
 
EXPORT Make_ofc2_csz(SALT36.StrType s0) := s0;
EXPORT InValid_ofc2_csz(SALT36.StrType s) := 0;
EXPORT InValidMessage_ofc2_csz(UNSIGNED1 wh) := '';
 
EXPORT Make_ofc2_fein(SALT36.StrType s0) := s0;
EXPORT InValid_ofc2_fein(SALT36.StrType s) := 0;
EXPORT InValidMessage_ofc2_fein(UNSIGNED1 wh) := '';
 
EXPORT Make_ofc2_ssn(SALT36.StrType s0) := s0;
EXPORT InValid_ofc2_ssn(SALT36.StrType s) := 0;
EXPORT InValidMessage_ofc2_ssn(UNSIGNED1 wh) := '';
 
EXPORT Make_ofc3_name(SALT36.StrType s0) := s0;
EXPORT InValid_ofc3_name(SALT36.StrType s) := 0;
EXPORT InValidMessage_ofc3_name(UNSIGNED1 wh) := '';
 
EXPORT Make_ofc3_title(SALT36.StrType s0) := MakeFT_invalid_ofc1_title(s0);
EXPORT InValid_ofc3_title(SALT36.StrType s) := InValidFT_invalid_ofc1_title(s);
EXPORT InValidMessage_ofc3_title(UNSIGNED1 wh) := InValidMessageFT_invalid_ofc1_title(wh);
 
EXPORT Make_ofc3_add(SALT36.StrType s0) := s0;
EXPORT InValid_ofc3_add(SALT36.StrType s) := 0;
EXPORT InValidMessage_ofc3_add(UNSIGNED1 wh) := '';
 
EXPORT Make_ofc3_csz(SALT36.StrType s0) := s0;
EXPORT InValid_ofc3_csz(SALT36.StrType s) := 0;
EXPORT InValidMessage_ofc3_csz(UNSIGNED1 wh) := '';
 
EXPORT Make_ofc3_fein(SALT36.StrType s0) := s0;
EXPORT InValid_ofc3_fein(SALT36.StrType s) := 0;
EXPORT InValidMessage_ofc3_fein(UNSIGNED1 wh) := '';
 
EXPORT Make_ofc3_ssn(SALT36.StrType s0) := s0;
EXPORT InValid_ofc3_ssn(SALT36.StrType s) := 0;
EXPORT InValidMessage_ofc3_ssn(UNSIGNED1 wh) := '';
 
EXPORT Make_ofc4_name(SALT36.StrType s0) := s0;
EXPORT InValid_ofc4_name(SALT36.StrType s) := 0;
EXPORT InValidMessage_ofc4_name(UNSIGNED1 wh) := '';
 
EXPORT Make_ofc4_title(SALT36.StrType s0) := MakeFT_invalid_ofc1_title(s0);
EXPORT InValid_ofc4_title(SALT36.StrType s) := InValidFT_invalid_ofc1_title(s);
EXPORT InValidMessage_ofc4_title(UNSIGNED1 wh) := InValidMessageFT_invalid_ofc1_title(wh);
 
EXPORT Make_ofc4_add(SALT36.StrType s0) := s0;
EXPORT InValid_ofc4_add(SALT36.StrType s) := 0;
EXPORT InValidMessage_ofc4_add(UNSIGNED1 wh) := '';
 
EXPORT Make_ofc4_csz(SALT36.StrType s0) := s0;
EXPORT InValid_ofc4_csz(SALT36.StrType s) := 0;
EXPORT InValidMessage_ofc4_csz(UNSIGNED1 wh) := '';
 
EXPORT Make_ofc4_fein(SALT36.StrType s0) := s0;
EXPORT InValid_ofc4_fein(SALT36.StrType s) := 0;
EXPORT InValidMessage_ofc4_fein(UNSIGNED1 wh) := '';
 
EXPORT Make_ofc4_ssn(SALT36.StrType s0) := s0;
EXPORT InValid_ofc4_ssn(SALT36.StrType s) := 0;
EXPORT InValidMessage_ofc4_ssn(UNSIGNED1 wh) := '';
 
EXPORT Make_ofc5_name(SALT36.StrType s0) := s0;
EXPORT InValid_ofc5_name(SALT36.StrType s) := 0;
EXPORT InValidMessage_ofc5_name(UNSIGNED1 wh) := '';
 
EXPORT Make_ofc5_title(SALT36.StrType s0) := MakeFT_invalid_ofc1_title(s0);
EXPORT InValid_ofc5_title(SALT36.StrType s) := InValidFT_invalid_ofc1_title(s);
EXPORT InValidMessage_ofc5_title(UNSIGNED1 wh) := InValidMessageFT_invalid_ofc1_title(wh);
 
EXPORT Make_ofc5_add(SALT36.StrType s0) := s0;
EXPORT InValid_ofc5_add(SALT36.StrType s) := 0;
EXPORT InValidMessage_ofc5_add(UNSIGNED1 wh) := '';
 
EXPORT Make_ofc5_csz(SALT36.StrType s0) := s0;
EXPORT InValid_ofc5_csz(SALT36.StrType s) := 0;
EXPORT InValidMessage_ofc5_csz(UNSIGNED1 wh) := '';
 
EXPORT Make_ofc5_fein(SALT36.StrType s0) := s0;
EXPORT InValid_ofc5_fein(SALT36.StrType s) := 0;
EXPORT InValidMessage_ofc5_fein(UNSIGNED1 wh) := '';
 
EXPORT Make_ofc5_ssn(SALT36.StrType s0) := s0;
EXPORT InValid_ofc5_ssn(SALT36.StrType s) := 0;
EXPORT InValidMessage_ofc5_ssn(UNSIGNED1 wh) := '';
 
EXPORT Make_ofc6_name(SALT36.StrType s0) := s0;
EXPORT InValid_ofc6_name(SALT36.StrType s) := 0;
EXPORT InValidMessage_ofc6_name(UNSIGNED1 wh) := '';
 
EXPORT Make_ofc6_title(SALT36.StrType s0) := MakeFT_invalid_ofc1_title(s0);
EXPORT InValid_ofc6_title(SALT36.StrType s) := InValidFT_invalid_ofc1_title(s);
EXPORT InValidMessage_ofc6_title(UNSIGNED1 wh) := InValidMessageFT_invalid_ofc1_title(wh);
 
EXPORT Make_ofc6_add(SALT36.StrType s0) := s0;
EXPORT InValid_ofc6_add(SALT36.StrType s) := 0;
EXPORT InValidMessage_ofc6_add(UNSIGNED1 wh) := '';
 
EXPORT Make_ofc6_csz(SALT36.StrType s0) := s0;
EXPORT InValid_ofc6_csz(SALT36.StrType s) := 0;
EXPORT InValidMessage_ofc6_csz(UNSIGNED1 wh) := '';
 
EXPORT Make_ofc6_fein(SALT36.StrType s0) := s0;
EXPORT InValid_ofc6_fein(SALT36.StrType s) := 0;
EXPORT InValidMessage_ofc6_fein(UNSIGNED1 wh) := '';
 
EXPORT Make_ofc6_ssn(SALT36.StrType s0) := s0;
EXPORT InValid_ofc6_ssn(SALT36.StrType s) := 0;
EXPORT InValidMessage_ofc6_ssn(UNSIGNED1 wh) := '';
 
EXPORT Make_fee(SALT36.StrType s0) := s0;
EXPORT InValid_fee(SALT36.StrType s) := 0;
EXPORT InValidMessage_fee(UNSIGNED1 wh) := '';
 
EXPORT Make_fee_2(SALT36.StrType s0) := s0;
EXPORT InValid_fee_2(SALT36.StrType s) := 0;
EXPORT InValidMessage_fee_2(UNSIGNED1 wh) := '';
 
EXPORT Make_tax_cl(SALT36.StrType s0) := s0;
EXPORT InValid_tax_cl(SALT36.StrType s) := 0;
EXPORT InValidMessage_tax_cl(UNSIGNED1 wh) := '';
 
EXPORT Make_perm_type(SALT36.StrType s0) := s0;
EXPORT InValid_perm_type(SALT36.StrType s) := 0;
EXPORT InValidMessage_perm_type(UNSIGNED1 wh) := '';
 
EXPORT Make_page(SALT36.StrType s0) := s0;
EXPORT InValid_page(SALT36.StrType s) := 0;
EXPORT InValidMessage_page(UNSIGNED1 wh) := '';
 
EXPORT Make_volume(SALT36.StrType s0) := s0;
EXPORT InValid_volume(SALT36.StrType s) := 0;
EXPORT InValidMessage_volume(UNSIGNED1 wh) := '';
 
EXPORT Make_comments(SALT36.StrType s0) := s0;
EXPORT InValid_comments(SALT36.StrType s) := 0;
EXPORT InValidMessage_comments(UNSIGNED1 wh) := '';
 
EXPORT Make_jurisdiction(SALT36.StrType s0) := s0;
EXPORT InValid_jurisdiction(SALT36.StrType s) := 0;
EXPORT InValidMessage_jurisdiction(UNSIGNED1 wh) := '';
 
EXPORT Make_adcrecordno(SALT36.StrType s0) := s0;
EXPORT InValid_adcrecordno(SALT36.StrType s) := 0;
EXPORT InValidMessage_adcrecordno(UNSIGNED1 wh) := '';
 
EXPORT Make_crlf(SALT36.StrType s0) := s0;
EXPORT InValid_crlf(SALT36.StrType s) := 0;
EXPORT InValidMessage_crlf(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT36,Scrubs_BusReg;
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
    BOOLEAN Diff_ofc1_name;
    BOOLEAN Diff_ofc1_title;
    BOOLEAN Diff_ofc1_gender;
    BOOLEAN Diff_ofc1_add;
    BOOLEAN Diff_ofc1_suite;
    BOOLEAN Diff_ofc1_city;
    BOOLEAN Diff_ofc1_state;
    BOOLEAN Diff_ofc1_zip;
    BOOLEAN Diff_ofc1_ac;
    BOOLEAN Diff_ofc1_phone;
    BOOLEAN Diff_ofc1_fein;
    BOOLEAN Diff_ofc1_ssn;
    BOOLEAN Diff_ofc1_type;
    BOOLEAN Diff_company;
    BOOLEAN Diff_mail_add;
    BOOLEAN Diff_mail_suite;
    BOOLEAN Diff_mail_city;
    BOOLEAN Diff_mail_state;
    BOOLEAN Diff_mail_zip;
    BOOLEAN Diff_mail_zip4;
    BOOLEAN Diff_mail_key;
    BOOLEAN Diff_county;
    BOOLEAN Diff_country;
    BOOLEAN Diff_district;
    BOOLEAN Diff_biz_ac;
    BOOLEAN Diff_biz_phone;
    BOOLEAN Diff_sic;
    BOOLEAN Diff_naics;
    BOOLEAN Diff_descript;
    BOOLEAN Diff_emp_size;
    BOOLEAN Diff_own_size;
    BOOLEAN Diff_corpcode;
    BOOLEAN Diff_sos_code;
    BOOLEAN Diff_filing_cod;
    BOOLEAN Diff_state_code;
    BOOLEAN Diff_status;
    BOOLEAN Diff_filing_num;
    BOOLEAN Diff_ctrl_num;
    BOOLEAN Diff_start_date;
    BOOLEAN Diff_file_date;
    BOOLEAN Diff_form_date;
    BOOLEAN Diff_exp_date;
    BOOLEAN Diff_disol_date;
    BOOLEAN Diff_rpt_date;
    BOOLEAN Diff_chang_date;
    BOOLEAN Diff_loc_add;
    BOOLEAN Diff_loc_suite;
    BOOLEAN Diff_loc_city;
    BOOLEAN Diff_loc_state;
    BOOLEAN Diff_loc_zip;
    BOOLEAN Diff_loc_zip4;
    BOOLEAN Diff_ofc2_name;
    BOOLEAN Diff_ofc2_title;
    BOOLEAN Diff_ofc2_add;
    BOOLEAN Diff_ofc2_csz;
    BOOLEAN Diff_ofc2_fein;
    BOOLEAN Diff_ofc2_ssn;
    BOOLEAN Diff_ofc3_name;
    BOOLEAN Diff_ofc3_title;
    BOOLEAN Diff_ofc3_add;
    BOOLEAN Diff_ofc3_csz;
    BOOLEAN Diff_ofc3_fein;
    BOOLEAN Diff_ofc3_ssn;
    BOOLEAN Diff_ofc4_name;
    BOOLEAN Diff_ofc4_title;
    BOOLEAN Diff_ofc4_add;
    BOOLEAN Diff_ofc4_csz;
    BOOLEAN Diff_ofc4_fein;
    BOOLEAN Diff_ofc4_ssn;
    BOOLEAN Diff_ofc5_name;
    BOOLEAN Diff_ofc5_title;
    BOOLEAN Diff_ofc5_add;
    BOOLEAN Diff_ofc5_csz;
    BOOLEAN Diff_ofc5_fein;
    BOOLEAN Diff_ofc5_ssn;
    BOOLEAN Diff_ofc6_name;
    BOOLEAN Diff_ofc6_title;
    BOOLEAN Diff_ofc6_add;
    BOOLEAN Diff_ofc6_csz;
    BOOLEAN Diff_ofc6_fein;
    BOOLEAN Diff_ofc6_ssn;
    BOOLEAN Diff_fee;
    BOOLEAN Diff_fee_2;
    BOOLEAN Diff_tax_cl;
    BOOLEAN Diff_perm_type;
    BOOLEAN Diff_page;
    BOOLEAN Diff_volume;
    BOOLEAN Diff_comments;
    BOOLEAN Diff_jurisdiction;
    BOOLEAN Diff_adcrecordno;
    BOOLEAN Diff_crlf;
    UNSIGNED Num_Diffs;
    SALT36.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_ofc1_name := le.ofc1_name <> ri.ofc1_name;
    SELF.Diff_ofc1_title := le.ofc1_title <> ri.ofc1_title;
    SELF.Diff_ofc1_gender := le.ofc1_gender <> ri.ofc1_gender;
    SELF.Diff_ofc1_add := le.ofc1_add <> ri.ofc1_add;
    SELF.Diff_ofc1_suite := le.ofc1_suite <> ri.ofc1_suite;
    SELF.Diff_ofc1_city := le.ofc1_city <> ri.ofc1_city;
    SELF.Diff_ofc1_state := le.ofc1_state <> ri.ofc1_state;
    SELF.Diff_ofc1_zip := le.ofc1_zip <> ri.ofc1_zip;
    SELF.Diff_ofc1_ac := le.ofc1_ac <> ri.ofc1_ac;
    SELF.Diff_ofc1_phone := le.ofc1_phone <> ri.ofc1_phone;
    SELF.Diff_ofc1_fein := le.ofc1_fein <> ri.ofc1_fein;
    SELF.Diff_ofc1_ssn := le.ofc1_ssn <> ri.ofc1_ssn;
    SELF.Diff_ofc1_type := le.ofc1_type <> ri.ofc1_type;
    SELF.Diff_company := le.company <> ri.company;
    SELF.Diff_mail_add := le.mail_add <> ri.mail_add;
    SELF.Diff_mail_suite := le.mail_suite <> ri.mail_suite;
    SELF.Diff_mail_city := le.mail_city <> ri.mail_city;
    SELF.Diff_mail_state := le.mail_state <> ri.mail_state;
    SELF.Diff_mail_zip := le.mail_zip <> ri.mail_zip;
    SELF.Diff_mail_zip4 := le.mail_zip4 <> ri.mail_zip4;
    SELF.Diff_mail_key := le.mail_key <> ri.mail_key;
    SELF.Diff_county := le.county <> ri.county;
    SELF.Diff_country := le.country <> ri.country;
    SELF.Diff_district := le.district <> ri.district;
    SELF.Diff_biz_ac := le.biz_ac <> ri.biz_ac;
    SELF.Diff_biz_phone := le.biz_phone <> ri.biz_phone;
    SELF.Diff_sic := le.sic <> ri.sic;
    SELF.Diff_naics := le.naics <> ri.naics;
    SELF.Diff_descript := le.descript <> ri.descript;
    SELF.Diff_emp_size := le.emp_size <> ri.emp_size;
    SELF.Diff_own_size := le.own_size <> ri.own_size;
    SELF.Diff_corpcode := le.corpcode <> ri.corpcode;
    SELF.Diff_sos_code := le.sos_code <> ri.sos_code;
    SELF.Diff_filing_cod := le.filing_cod <> ri.filing_cod;
    SELF.Diff_state_code := le.state_code <> ri.state_code;
    SELF.Diff_status := le.status <> ri.status;
    SELF.Diff_filing_num := le.filing_num <> ri.filing_num;
    SELF.Diff_ctrl_num := le.ctrl_num <> ri.ctrl_num;
    SELF.Diff_start_date := le.start_date <> ri.start_date;
    SELF.Diff_file_date := le.file_date <> ri.file_date;
    SELF.Diff_form_date := le.form_date <> ri.form_date;
    SELF.Diff_exp_date := le.exp_date <> ri.exp_date;
    SELF.Diff_disol_date := le.disol_date <> ri.disol_date;
    SELF.Diff_rpt_date := le.rpt_date <> ri.rpt_date;
    SELF.Diff_chang_date := le.chang_date <> ri.chang_date;
    SELF.Diff_loc_add := le.loc_add <> ri.loc_add;
    SELF.Diff_loc_suite := le.loc_suite <> ri.loc_suite;
    SELF.Diff_loc_city := le.loc_city <> ri.loc_city;
    SELF.Diff_loc_state := le.loc_state <> ri.loc_state;
    SELF.Diff_loc_zip := le.loc_zip <> ri.loc_zip;
    SELF.Diff_loc_zip4 := le.loc_zip4 <> ri.loc_zip4;
    SELF.Diff_ofc2_name := le.ofc2_name <> ri.ofc2_name;
    SELF.Diff_ofc2_title := le.ofc2_title <> ri.ofc2_title;
    SELF.Diff_ofc2_add := le.ofc2_add <> ri.ofc2_add;
    SELF.Diff_ofc2_csz := le.ofc2_csz <> ri.ofc2_csz;
    SELF.Diff_ofc2_fein := le.ofc2_fein <> ri.ofc2_fein;
    SELF.Diff_ofc2_ssn := le.ofc2_ssn <> ri.ofc2_ssn;
    SELF.Diff_ofc3_name := le.ofc3_name <> ri.ofc3_name;
    SELF.Diff_ofc3_title := le.ofc3_title <> ri.ofc3_title;
    SELF.Diff_ofc3_add := le.ofc3_add <> ri.ofc3_add;
    SELF.Diff_ofc3_csz := le.ofc3_csz <> ri.ofc3_csz;
    SELF.Diff_ofc3_fein := le.ofc3_fein <> ri.ofc3_fein;
    SELF.Diff_ofc3_ssn := le.ofc3_ssn <> ri.ofc3_ssn;
    SELF.Diff_ofc4_name := le.ofc4_name <> ri.ofc4_name;
    SELF.Diff_ofc4_title := le.ofc4_title <> ri.ofc4_title;
    SELF.Diff_ofc4_add := le.ofc4_add <> ri.ofc4_add;
    SELF.Diff_ofc4_csz := le.ofc4_csz <> ri.ofc4_csz;
    SELF.Diff_ofc4_fein := le.ofc4_fein <> ri.ofc4_fein;
    SELF.Diff_ofc4_ssn := le.ofc4_ssn <> ri.ofc4_ssn;
    SELF.Diff_ofc5_name := le.ofc5_name <> ri.ofc5_name;
    SELF.Diff_ofc5_title := le.ofc5_title <> ri.ofc5_title;
    SELF.Diff_ofc5_add := le.ofc5_add <> ri.ofc5_add;
    SELF.Diff_ofc5_csz := le.ofc5_csz <> ri.ofc5_csz;
    SELF.Diff_ofc5_fein := le.ofc5_fein <> ri.ofc5_fein;
    SELF.Diff_ofc5_ssn := le.ofc5_ssn <> ri.ofc5_ssn;
    SELF.Diff_ofc6_name := le.ofc6_name <> ri.ofc6_name;
    SELF.Diff_ofc6_title := le.ofc6_title <> ri.ofc6_title;
    SELF.Diff_ofc6_add := le.ofc6_add <> ri.ofc6_add;
    SELF.Diff_ofc6_csz := le.ofc6_csz <> ri.ofc6_csz;
    SELF.Diff_ofc6_fein := le.ofc6_fein <> ri.ofc6_fein;
    SELF.Diff_ofc6_ssn := le.ofc6_ssn <> ri.ofc6_ssn;
    SELF.Diff_fee := le.fee <> ri.fee;
    SELF.Diff_fee_2 := le.fee_2 <> ri.fee_2;
    SELF.Diff_tax_cl := le.tax_cl <> ri.tax_cl;
    SELF.Diff_perm_type := le.perm_type <> ri.perm_type;
    SELF.Diff_page := le.page <> ri.page;
    SELF.Diff_volume := le.volume <> ri.volume;
    SELF.Diff_comments := le.comments <> ri.comments;
    SELF.Diff_jurisdiction := le.jurisdiction <> ri.jurisdiction;
    SELF.Diff_adcrecordno := le.adcrecordno <> ri.adcrecordno;
    SELF.Diff_crlf := le.crlf <> ri.crlf;
    SELF.Val := (SALT36.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_ofc1_name,1,0)+ IF( SELF.Diff_ofc1_title,1,0)+ IF( SELF.Diff_ofc1_gender,1,0)+ IF( SELF.Diff_ofc1_add,1,0)+ IF( SELF.Diff_ofc1_suite,1,0)+ IF( SELF.Diff_ofc1_city,1,0)+ IF( SELF.Diff_ofc1_state,1,0)+ IF( SELF.Diff_ofc1_zip,1,0)+ IF( SELF.Diff_ofc1_ac,1,0)+ IF( SELF.Diff_ofc1_phone,1,0)+ IF( SELF.Diff_ofc1_fein,1,0)+ IF( SELF.Diff_ofc1_ssn,1,0)+ IF( SELF.Diff_ofc1_type,1,0)+ IF( SELF.Diff_company,1,0)+ IF( SELF.Diff_mail_add,1,0)+ IF( SELF.Diff_mail_suite,1,0)+ IF( SELF.Diff_mail_city,1,0)+ IF( SELF.Diff_mail_state,1,0)+ IF( SELF.Diff_mail_zip,1,0)+ IF( SELF.Diff_mail_zip4,1,0)+ IF( SELF.Diff_mail_key,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_country,1,0)+ IF( SELF.Diff_district,1,0)+ IF( SELF.Diff_biz_ac,1,0)+ IF( SELF.Diff_biz_phone,1,0)+ IF( SELF.Diff_sic,1,0)+ IF( SELF.Diff_naics,1,0)+ IF( SELF.Diff_descript,1,0)+ IF( SELF.Diff_emp_size,1,0)+ IF( SELF.Diff_own_size,1,0)+ IF( SELF.Diff_corpcode,1,0)+ IF( SELF.Diff_sos_code,1,0)+ IF( SELF.Diff_filing_cod,1,0)+ IF( SELF.Diff_state_code,1,0)+ IF( SELF.Diff_status,1,0)+ IF( SELF.Diff_filing_num,1,0)+ IF( SELF.Diff_ctrl_num,1,0)+ IF( SELF.Diff_start_date,1,0)+ IF( SELF.Diff_file_date,1,0)+ IF( SELF.Diff_form_date,1,0)+ IF( SELF.Diff_exp_date,1,0)+ IF( SELF.Diff_disol_date,1,0)+ IF( SELF.Diff_rpt_date,1,0)+ IF( SELF.Diff_chang_date,1,0)+ IF( SELF.Diff_loc_add,1,0)+ IF( SELF.Diff_loc_suite,1,0)+ IF( SELF.Diff_loc_city,1,0)+ IF( SELF.Diff_loc_state,1,0)+ IF( SELF.Diff_loc_zip,1,0)+ IF( SELF.Diff_loc_zip4,1,0)+ IF( SELF.Diff_ofc2_name,1,0)+ IF( SELF.Diff_ofc2_title,1,0)+ IF( SELF.Diff_ofc2_add,1,0)+ IF( SELF.Diff_ofc2_csz,1,0)+ IF( SELF.Diff_ofc2_fein,1,0)+ IF( SELF.Diff_ofc2_ssn,1,0)+ IF( SELF.Diff_ofc3_name,1,0)+ IF( SELF.Diff_ofc3_title,1,0)+ IF( SELF.Diff_ofc3_add,1,0)+ IF( SELF.Diff_ofc3_csz,1,0)+ IF( SELF.Diff_ofc3_fein,1,0)+ IF( SELF.Diff_ofc3_ssn,1,0)+ IF( SELF.Diff_ofc4_name,1,0)+ IF( SELF.Diff_ofc4_title,1,0)+ IF( SELF.Diff_ofc4_add,1,0)+ IF( SELF.Diff_ofc4_csz,1,0)+ IF( SELF.Diff_ofc4_fein,1,0)+ IF( SELF.Diff_ofc4_ssn,1,0)+ IF( SELF.Diff_ofc5_name,1,0)+ IF( SELF.Diff_ofc5_title,1,0)+ IF( SELF.Diff_ofc5_add,1,0)+ IF( SELF.Diff_ofc5_csz,1,0)+ IF( SELF.Diff_ofc5_fein,1,0)+ IF( SELF.Diff_ofc5_ssn,1,0)+ IF( SELF.Diff_ofc6_name,1,0)+ IF( SELF.Diff_ofc6_title,1,0)+ IF( SELF.Diff_ofc6_add,1,0)+ IF( SELF.Diff_ofc6_csz,1,0)+ IF( SELF.Diff_ofc6_fein,1,0)+ IF( SELF.Diff_ofc6_ssn,1,0)+ IF( SELF.Diff_fee,1,0)+ IF( SELF.Diff_fee_2,1,0)+ IF( SELF.Diff_tax_cl,1,0)+ IF( SELF.Diff_perm_type,1,0)+ IF( SELF.Diff_page,1,0)+ IF( SELF.Diff_volume,1,0)+ IF( SELF.Diff_comments,1,0)+ IF( SELF.Diff_jurisdiction,1,0)+ IF( SELF.Diff_adcrecordno,1,0)+ IF( SELF.Diff_crlf,1,0);
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
    Count_Diff_ofc1_name := COUNT(GROUP,%Closest%.Diff_ofc1_name);
    Count_Diff_ofc1_title := COUNT(GROUP,%Closest%.Diff_ofc1_title);
    Count_Diff_ofc1_gender := COUNT(GROUP,%Closest%.Diff_ofc1_gender);
    Count_Diff_ofc1_add := COUNT(GROUP,%Closest%.Diff_ofc1_add);
    Count_Diff_ofc1_suite := COUNT(GROUP,%Closest%.Diff_ofc1_suite);
    Count_Diff_ofc1_city := COUNT(GROUP,%Closest%.Diff_ofc1_city);
    Count_Diff_ofc1_state := COUNT(GROUP,%Closest%.Diff_ofc1_state);
    Count_Diff_ofc1_zip := COUNT(GROUP,%Closest%.Diff_ofc1_zip);
    Count_Diff_ofc1_ac := COUNT(GROUP,%Closest%.Diff_ofc1_ac);
    Count_Diff_ofc1_phone := COUNT(GROUP,%Closest%.Diff_ofc1_phone);
    Count_Diff_ofc1_fein := COUNT(GROUP,%Closest%.Diff_ofc1_fein);
    Count_Diff_ofc1_ssn := COUNT(GROUP,%Closest%.Diff_ofc1_ssn);
    Count_Diff_ofc1_type := COUNT(GROUP,%Closest%.Diff_ofc1_type);
    Count_Diff_company := COUNT(GROUP,%Closest%.Diff_company);
    Count_Diff_mail_add := COUNT(GROUP,%Closest%.Diff_mail_add);
    Count_Diff_mail_suite := COUNT(GROUP,%Closest%.Diff_mail_suite);
    Count_Diff_mail_city := COUNT(GROUP,%Closest%.Diff_mail_city);
    Count_Diff_mail_state := COUNT(GROUP,%Closest%.Diff_mail_state);
    Count_Diff_mail_zip := COUNT(GROUP,%Closest%.Diff_mail_zip);
    Count_Diff_mail_zip4 := COUNT(GROUP,%Closest%.Diff_mail_zip4);
    Count_Diff_mail_key := COUNT(GROUP,%Closest%.Diff_mail_key);
    Count_Diff_county := COUNT(GROUP,%Closest%.Diff_county);
    Count_Diff_country := COUNT(GROUP,%Closest%.Diff_country);
    Count_Diff_district := COUNT(GROUP,%Closest%.Diff_district);
    Count_Diff_biz_ac := COUNT(GROUP,%Closest%.Diff_biz_ac);
    Count_Diff_biz_phone := COUNT(GROUP,%Closest%.Diff_biz_phone);
    Count_Diff_sic := COUNT(GROUP,%Closest%.Diff_sic);
    Count_Diff_naics := COUNT(GROUP,%Closest%.Diff_naics);
    Count_Diff_descript := COUNT(GROUP,%Closest%.Diff_descript);
    Count_Diff_emp_size := COUNT(GROUP,%Closest%.Diff_emp_size);
    Count_Diff_own_size := COUNT(GROUP,%Closest%.Diff_own_size);
    Count_Diff_corpcode := COUNT(GROUP,%Closest%.Diff_corpcode);
    Count_Diff_sos_code := COUNT(GROUP,%Closest%.Diff_sos_code);
    Count_Diff_filing_cod := COUNT(GROUP,%Closest%.Diff_filing_cod);
    Count_Diff_state_code := COUNT(GROUP,%Closest%.Diff_state_code);
    Count_Diff_status := COUNT(GROUP,%Closest%.Diff_status);
    Count_Diff_filing_num := COUNT(GROUP,%Closest%.Diff_filing_num);
    Count_Diff_ctrl_num := COUNT(GROUP,%Closest%.Diff_ctrl_num);
    Count_Diff_start_date := COUNT(GROUP,%Closest%.Diff_start_date);
    Count_Diff_file_date := COUNT(GROUP,%Closest%.Diff_file_date);
    Count_Diff_form_date := COUNT(GROUP,%Closest%.Diff_form_date);
    Count_Diff_exp_date := COUNT(GROUP,%Closest%.Diff_exp_date);
    Count_Diff_disol_date := COUNT(GROUP,%Closest%.Diff_disol_date);
    Count_Diff_rpt_date := COUNT(GROUP,%Closest%.Diff_rpt_date);
    Count_Diff_chang_date := COUNT(GROUP,%Closest%.Diff_chang_date);
    Count_Diff_loc_add := COUNT(GROUP,%Closest%.Diff_loc_add);
    Count_Diff_loc_suite := COUNT(GROUP,%Closest%.Diff_loc_suite);
    Count_Diff_loc_city := COUNT(GROUP,%Closest%.Diff_loc_city);
    Count_Diff_loc_state := COUNT(GROUP,%Closest%.Diff_loc_state);
    Count_Diff_loc_zip := COUNT(GROUP,%Closest%.Diff_loc_zip);
    Count_Diff_loc_zip4 := COUNT(GROUP,%Closest%.Diff_loc_zip4);
    Count_Diff_ofc2_name := COUNT(GROUP,%Closest%.Diff_ofc2_name);
    Count_Diff_ofc2_title := COUNT(GROUP,%Closest%.Diff_ofc2_title);
    Count_Diff_ofc2_add := COUNT(GROUP,%Closest%.Diff_ofc2_add);
    Count_Diff_ofc2_csz := COUNT(GROUP,%Closest%.Diff_ofc2_csz);
    Count_Diff_ofc2_fein := COUNT(GROUP,%Closest%.Diff_ofc2_fein);
    Count_Diff_ofc2_ssn := COUNT(GROUP,%Closest%.Diff_ofc2_ssn);
    Count_Diff_ofc3_name := COUNT(GROUP,%Closest%.Diff_ofc3_name);
    Count_Diff_ofc3_title := COUNT(GROUP,%Closest%.Diff_ofc3_title);
    Count_Diff_ofc3_add := COUNT(GROUP,%Closest%.Diff_ofc3_add);
    Count_Diff_ofc3_csz := COUNT(GROUP,%Closest%.Diff_ofc3_csz);
    Count_Diff_ofc3_fein := COUNT(GROUP,%Closest%.Diff_ofc3_fein);
    Count_Diff_ofc3_ssn := COUNT(GROUP,%Closest%.Diff_ofc3_ssn);
    Count_Diff_ofc4_name := COUNT(GROUP,%Closest%.Diff_ofc4_name);
    Count_Diff_ofc4_title := COUNT(GROUP,%Closest%.Diff_ofc4_title);
    Count_Diff_ofc4_add := COUNT(GROUP,%Closest%.Diff_ofc4_add);
    Count_Diff_ofc4_csz := COUNT(GROUP,%Closest%.Diff_ofc4_csz);
    Count_Diff_ofc4_fein := COUNT(GROUP,%Closest%.Diff_ofc4_fein);
    Count_Diff_ofc4_ssn := COUNT(GROUP,%Closest%.Diff_ofc4_ssn);
    Count_Diff_ofc5_name := COUNT(GROUP,%Closest%.Diff_ofc5_name);
    Count_Diff_ofc5_title := COUNT(GROUP,%Closest%.Diff_ofc5_title);
    Count_Diff_ofc5_add := COUNT(GROUP,%Closest%.Diff_ofc5_add);
    Count_Diff_ofc5_csz := COUNT(GROUP,%Closest%.Diff_ofc5_csz);
    Count_Diff_ofc5_fein := COUNT(GROUP,%Closest%.Diff_ofc5_fein);
    Count_Diff_ofc5_ssn := COUNT(GROUP,%Closest%.Diff_ofc5_ssn);
    Count_Diff_ofc6_name := COUNT(GROUP,%Closest%.Diff_ofc6_name);
    Count_Diff_ofc6_title := COUNT(GROUP,%Closest%.Diff_ofc6_title);
    Count_Diff_ofc6_add := COUNT(GROUP,%Closest%.Diff_ofc6_add);
    Count_Diff_ofc6_csz := COUNT(GROUP,%Closest%.Diff_ofc6_csz);
    Count_Diff_ofc6_fein := COUNT(GROUP,%Closest%.Diff_ofc6_fein);
    Count_Diff_ofc6_ssn := COUNT(GROUP,%Closest%.Diff_ofc6_ssn);
    Count_Diff_fee := COUNT(GROUP,%Closest%.Diff_fee);
    Count_Diff_fee_2 := COUNT(GROUP,%Closest%.Diff_fee_2);
    Count_Diff_tax_cl := COUNT(GROUP,%Closest%.Diff_tax_cl);
    Count_Diff_perm_type := COUNT(GROUP,%Closest%.Diff_perm_type);
    Count_Diff_page := COUNT(GROUP,%Closest%.Diff_page);
    Count_Diff_volume := COUNT(GROUP,%Closest%.Diff_volume);
    Count_Diff_comments := COUNT(GROUP,%Closest%.Diff_comments);
    Count_Diff_jurisdiction := COUNT(GROUP,%Closest%.Diff_jurisdiction);
    Count_Diff_adcrecordno := COUNT(GROUP,%Closest%.Diff_adcrecordno);
    Count_Diff_crlf := COUNT(GROUP,%Closest%.Diff_crlf);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
