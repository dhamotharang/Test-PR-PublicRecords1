IMPORT SALT311;
IMPORT Scrubs_DL_CT; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
EXPORT NumFields := 40;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_credentialstate','invalid_credentialnumber','invalid_name','invalid_sex','invalid_height','invalid_eye_color','invalid_past_date','invalid_general_date','invalid_city','invalid_street','invalid_state','invalid_zip','invalid_credentialtype','invalid_class','invalid_endorsements','invalid_restrictions','invalid_status','invalid_status_cdl','invalid_clean_name');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_credentialstate' => 1,'invalid_credentialnumber' => 2,'invalid_name' => 3,'invalid_sex' => 4,'invalid_height' => 5,'invalid_eye_color' => 6,'invalid_past_date' => 7,'invalid_general_date' => 8,'invalid_city' => 9,'invalid_street' => 10,'invalid_state' => 11,'invalid_zip' => 12,'invalid_credentialtype' => 13,'invalid_class' => 14,'invalid_endorsements' => 15,'invalid_restrictions' => 16,'invalid_status' => 17,'invalid_status_cdl' => 18,'invalid_clean_name' => 19,0);
 
EXPORT MakeFT_invalid_credentialstate(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_credentialstate(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['CT','CT']);
EXPORT InValidMessageFT_invalid_credentialstate(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('CT|CT'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_credentialnumber(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_credentialnumber(SALT311.StrType s) := WHICH(~Scrubs_DL_CT.Functions.fn_check_dl_number(s,9)>0);
EXPORT InValidMessageFT_invalid_credentialnumber(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_DL_CT.Functions.fn_check_dl_number'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_name(SALT311.StrType s,SALT311.StrType firstname,SALT311.StrType middleinitial) := WHICH(~Scrubs_DL_CT.Functions.fn_valid_name(s,firstname,middleinitial)>0);
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_DL_CT.Functions.fn_valid_name'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sex(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_sex(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['F','M','U','']);
EXPORT InValidMessageFT_invalid_sex(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('F|M|U|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_height(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_height(SALT311.StrType s) := WHICH(~Scrubs_DL_CT.Functions.fn_verify_height(s)>0);
EXPORT InValidMessageFT_invalid_height(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_DL_CT.Functions.fn_verify_height'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_eye_color(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_eye_color(SALT311.StrType s) := WHICH(~Scrubs_DL_CT.Functions.fn_check_eye_color(s)>0);
EXPORT InValidMessageFT_invalid_eye_color(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_DL_CT.Functions.fn_check_eye_color'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_past_date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_past_date(SALT311.StrType s) := WHICH(~Scrubs_DL_CT.Functions.fn_check_past_date(s)>0);
EXPORT InValidMessageFT_invalid_past_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_DL_CT.Functions.fn_check_past_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_general_date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_general_date(SALT311.StrType s) := WHICH(~Scrubs_DL_CT.Functions.fn_check_general_date(s)>0);
EXPORT InValidMessageFT_invalid_general_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_DL_CT.Functions.fn_check_general_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_city(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'\\ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_city(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'\\ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_invalid_city(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('\\ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_street(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'/\\#-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_street(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'/\\#-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_invalid_street(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('/\\#-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_state(SALT311.StrType s) := WHICH(~Scrubs_DL_CT.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_DL_CT.Functions.fn_verify_state'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip(SALT311.StrType s) := WHICH(~Scrubs_DL_CT.Functions.fn_verify_zip(s)>0);
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_DL_CT.Functions.fn_verify_zip'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_credentialtype(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_credentialtype(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['CDL','ID','LP','LIC','']);
EXPORT InValidMessageFT_invalid_credentialtype(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('CDL|ID|LP|LIC|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_class(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_class(SALT311.StrType s) := WHICH(~Scrubs_DL_CT.Functions.fn_class(s)>0);
EXPORT InValidMessageFT_invalid_class(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_DL_CT.Functions.fn_class'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_endorsements(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'AFHMNPQSTVX '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_endorsements(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'AFHMNPQSTVX '))));
EXPORT InValidMessageFT_invalid_endorsements(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('AFHMNPQSTVX '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_restrictions(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'3BCDEFGJKLMNOQRTUVWYZ '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_restrictions(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'3BCDEFGJKLMNOQRTUVWYZ '))));
EXPORT InValidMessageFT_invalid_restrictions(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('3BCDEFGJKLMNOQRTUVWYZ '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_status(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_status(SALT311.StrType s) := WHICH(~Scrubs_DL_CT.Functions.fn_check_status_code(s)>0);
EXPORT InValidMessageFT_invalid_status(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_DL_CT.Functions.fn_check_status_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_status_cdl(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_status_cdl(SALT311.StrType s) := WHICH(~Scrubs_DL_CT.Functions.fn_check_cdl_status_code(s)>0);
EXPORT InValidMessageFT_invalid_status_cdl(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_DL_CT.Functions.fn_check_cdl_status_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_clean_name(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_clean_name(SALT311.StrType s,SALT311.StrType clean_name_first,SALT311.StrType clean_name_middle) := WHICH(~Scrubs_DL_CT.Functions.fn_valid_name(s,clean_name_first,clean_name_middle)>0);
EXPORT InValidMessageFT_invalid_clean_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_DL_CT.Functions.fn_valid_name'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'append_process_date','credentialstate','credentialnumber','lastname','firstname','middleinitial','gender','height','eyecolor','date_birth','resiaddrstreet','residencycity','residencystate','residencyzip','mailaddrstreet','mailingcity','mailingstate','mailingzip','credentialtype','credential_class','endorsements','restrictions','expdate','lastissuerenewaldate','date_noncdl','originaldate_cdl','statusnoncdl','licensestatuscdl','originaldate_lp','originaldate_id','cancelstate','canceldate','cdlmedicertissuedate','cdlmedicertexpdate','clean_name_prefix','clean_name_first','clean_name_middle','clean_name_last','clean_name_suffix','clean_name_score');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'append_process_date','credentialstate','credentialnumber','lastname','firstname','middleinitial','gender','height','eyecolor','date_birth','resiaddrstreet','residencycity','residencystate','residencyzip','mailaddrstreet','mailingcity','mailingstate','mailingzip','credentialtype','credential_class','endorsements','restrictions','expdate','lastissuerenewaldate','date_noncdl','originaldate_cdl','statusnoncdl','licensestatuscdl','originaldate_lp','originaldate_id','cancelstate','canceldate','cdlmedicertissuedate','cdlmedicertexpdate','clean_name_prefix','clean_name_first','clean_name_middle','clean_name_last','clean_name_suffix','clean_name_score');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'append_process_date' => 0,'credentialstate' => 1,'credentialnumber' => 2,'lastname' => 3,'firstname' => 4,'middleinitial' => 5,'gender' => 6,'height' => 7,'eyecolor' => 8,'date_birth' => 9,'resiaddrstreet' => 10,'residencycity' => 11,'residencystate' => 12,'residencyzip' => 13,'mailaddrstreet' => 14,'mailingcity' => 15,'mailingstate' => 16,'mailingzip' => 17,'credentialtype' => 18,'credential_class' => 19,'endorsements' => 20,'restrictions' => 21,'expdate' => 22,'lastissuerenewaldate' => 23,'date_noncdl' => 24,'originaldate_cdl' => 25,'statusnoncdl' => 26,'licensestatuscdl' => 27,'originaldate_lp' => 28,'originaldate_id' => 29,'cancelstate' => 30,'canceldate' => 31,'cdlmedicertissuedate' => 32,'cdlmedicertexpdate' => 33,'clean_name_prefix' => 34,'clean_name_first' => 35,'clean_name_middle' => 36,'clean_name_last' => 37,'clean_name_suffix' => 38,'clean_name_score' => 39,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],[],[],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],[],[],['CUSTOM'],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_append_process_date(SALT311.StrType s0) := MakeFT_invalid_past_date(s0);
EXPORT InValid_append_process_date(SALT311.StrType s) := InValidFT_invalid_past_date(s);
EXPORT InValidMessage_append_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_past_date(wh);
 
EXPORT Make_credentialstate(SALT311.StrType s0) := MakeFT_invalid_credentialstate(s0);
EXPORT InValid_credentialstate(SALT311.StrType s) := InValidFT_invalid_credentialstate(s);
EXPORT InValidMessage_credentialstate(UNSIGNED1 wh) := InValidMessageFT_invalid_credentialstate(wh);
 
EXPORT Make_credentialnumber(SALT311.StrType s0) := MakeFT_invalid_credentialnumber(s0);
EXPORT InValid_credentialnumber(SALT311.StrType s) := InValidFT_invalid_credentialnumber(s);
EXPORT InValidMessage_credentialnumber(UNSIGNED1 wh) := InValidMessageFT_invalid_credentialnumber(wh);
 
EXPORT Make_lastname(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_lastname(SALT311.StrType s,SALT311.StrType firstname,SALT311.StrType middleinitial) := InValidFT_invalid_name(s,firstname,middleinitial);
EXPORT InValidMessage_lastname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_firstname(SALT311.StrType s0) := s0;
EXPORT InValid_firstname(SALT311.StrType s) := 0;
EXPORT InValidMessage_firstname(UNSIGNED1 wh) := '';
 
EXPORT Make_middleinitial(SALT311.StrType s0) := s0;
EXPORT InValid_middleinitial(SALT311.StrType s) := 0;
EXPORT InValidMessage_middleinitial(UNSIGNED1 wh) := '';
 
EXPORT Make_gender(SALT311.StrType s0) := MakeFT_invalid_sex(s0);
EXPORT InValid_gender(SALT311.StrType s) := InValidFT_invalid_sex(s);
EXPORT InValidMessage_gender(UNSIGNED1 wh) := InValidMessageFT_invalid_sex(wh);
 
EXPORT Make_height(SALT311.StrType s0) := MakeFT_invalid_height(s0);
EXPORT InValid_height(SALT311.StrType s) := InValidFT_invalid_height(s);
EXPORT InValidMessage_height(UNSIGNED1 wh) := InValidMessageFT_invalid_height(wh);
 
EXPORT Make_eyecolor(SALT311.StrType s0) := MakeFT_invalid_eye_color(s0);
EXPORT InValid_eyecolor(SALT311.StrType s) := InValidFT_invalid_eye_color(s);
EXPORT InValidMessage_eyecolor(UNSIGNED1 wh) := InValidMessageFT_invalid_eye_color(wh);
 
EXPORT Make_date_birth(SALT311.StrType s0) := MakeFT_invalid_past_date(s0);
EXPORT InValid_date_birth(SALT311.StrType s) := InValidFT_invalid_past_date(s);
EXPORT InValidMessage_date_birth(UNSIGNED1 wh) := InValidMessageFT_invalid_past_date(wh);
 
EXPORT Make_resiaddrstreet(SALT311.StrType s0) := MakeFT_invalid_street(s0);
EXPORT InValid_resiaddrstreet(SALT311.StrType s) := InValidFT_invalid_street(s);
EXPORT InValidMessage_resiaddrstreet(UNSIGNED1 wh) := InValidMessageFT_invalid_street(wh);
 
EXPORT Make_residencycity(SALT311.StrType s0) := MakeFT_invalid_city(s0);
EXPORT InValid_residencycity(SALT311.StrType s) := InValidFT_invalid_city(s);
EXPORT InValidMessage_residencycity(UNSIGNED1 wh) := InValidMessageFT_invalid_city(wh);
 
EXPORT Make_residencystate(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_residencystate(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_residencystate(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_residencyzip(SALT311.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_residencyzip(SALT311.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_residencyzip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_mailaddrstreet(SALT311.StrType s0) := MakeFT_invalid_street(s0);
EXPORT InValid_mailaddrstreet(SALT311.StrType s) := InValidFT_invalid_street(s);
EXPORT InValidMessage_mailaddrstreet(UNSIGNED1 wh) := InValidMessageFT_invalid_street(wh);
 
EXPORT Make_mailingcity(SALT311.StrType s0) := MakeFT_invalid_city(s0);
EXPORT InValid_mailingcity(SALT311.StrType s) := InValidFT_invalid_city(s);
EXPORT InValidMessage_mailingcity(UNSIGNED1 wh) := InValidMessageFT_invalid_city(wh);
 
EXPORT Make_mailingstate(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_mailingstate(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_mailingstate(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_mailingzip(SALT311.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_mailingzip(SALT311.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_mailingzip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_credentialtype(SALT311.StrType s0) := MakeFT_invalid_credentialtype(s0);
EXPORT InValid_credentialtype(SALT311.StrType s) := InValidFT_invalid_credentialtype(s);
EXPORT InValidMessage_credentialtype(UNSIGNED1 wh) := InValidMessageFT_invalid_credentialtype(wh);
 
EXPORT Make_credential_class(SALT311.StrType s0) := MakeFT_invalid_class(s0);
EXPORT InValid_credential_class(SALT311.StrType s) := InValidFT_invalid_class(s);
EXPORT InValidMessage_credential_class(UNSIGNED1 wh) := InValidMessageFT_invalid_class(wh);
 
EXPORT Make_endorsements(SALT311.StrType s0) := MakeFT_invalid_endorsements(s0);
EXPORT InValid_endorsements(SALT311.StrType s) := InValidFT_invalid_endorsements(s);
EXPORT InValidMessage_endorsements(UNSIGNED1 wh) := InValidMessageFT_invalid_endorsements(wh);
 
EXPORT Make_restrictions(SALT311.StrType s0) := MakeFT_invalid_restrictions(s0);
EXPORT InValid_restrictions(SALT311.StrType s) := InValidFT_invalid_restrictions(s);
EXPORT InValidMessage_restrictions(UNSIGNED1 wh) := InValidMessageFT_invalid_restrictions(wh);
 
EXPORT Make_expdate(SALT311.StrType s0) := MakeFT_invalid_general_date(s0);
EXPORT InValid_expdate(SALT311.StrType s) := InValidFT_invalid_general_date(s);
EXPORT InValidMessage_expdate(UNSIGNED1 wh) := InValidMessageFT_invalid_general_date(wh);
 
EXPORT Make_lastissuerenewaldate(SALT311.StrType s0) := MakeFT_invalid_past_date(s0);
EXPORT InValid_lastissuerenewaldate(SALT311.StrType s) := InValidFT_invalid_past_date(s);
EXPORT InValidMessage_lastissuerenewaldate(UNSIGNED1 wh) := InValidMessageFT_invalid_past_date(wh);
 
EXPORT Make_date_noncdl(SALT311.StrType s0) := MakeFT_invalid_past_date(s0);
EXPORT InValid_date_noncdl(SALT311.StrType s) := InValidFT_invalid_past_date(s);
EXPORT InValidMessage_date_noncdl(UNSIGNED1 wh) := InValidMessageFT_invalid_past_date(wh);
 
EXPORT Make_originaldate_cdl(SALT311.StrType s0) := MakeFT_invalid_past_date(s0);
EXPORT InValid_originaldate_cdl(SALT311.StrType s) := InValidFT_invalid_past_date(s);
EXPORT InValidMessage_originaldate_cdl(UNSIGNED1 wh) := InValidMessageFT_invalid_past_date(wh);
 
EXPORT Make_statusnoncdl(SALT311.StrType s0) := MakeFT_invalid_status(s0);
EXPORT InValid_statusnoncdl(SALT311.StrType s) := InValidFT_invalid_status(s);
EXPORT InValidMessage_statusnoncdl(UNSIGNED1 wh) := InValidMessageFT_invalid_status(wh);
 
EXPORT Make_licensestatuscdl(SALT311.StrType s0) := MakeFT_invalid_status_cdl(s0);
EXPORT InValid_licensestatuscdl(SALT311.StrType s) := InValidFT_invalid_status_cdl(s);
EXPORT InValidMessage_licensestatuscdl(UNSIGNED1 wh) := InValidMessageFT_invalid_status_cdl(wh);
 
EXPORT Make_originaldate_lp(SALT311.StrType s0) := MakeFT_invalid_past_date(s0);
EXPORT InValid_originaldate_lp(SALT311.StrType s) := InValidFT_invalid_past_date(s);
EXPORT InValidMessage_originaldate_lp(UNSIGNED1 wh) := InValidMessageFT_invalid_past_date(wh);
 
EXPORT Make_originaldate_id(SALT311.StrType s0) := MakeFT_invalid_past_date(s0);
EXPORT InValid_originaldate_id(SALT311.StrType s) := InValidFT_invalid_past_date(s);
EXPORT InValidMessage_originaldate_id(UNSIGNED1 wh) := InValidMessageFT_invalid_past_date(wh);
 
EXPORT Make_cancelstate(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_cancelstate(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_cancelstate(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_canceldate(SALT311.StrType s0) := MakeFT_invalid_past_date(s0);
EXPORT InValid_canceldate(SALT311.StrType s) := InValidFT_invalid_past_date(s);
EXPORT InValidMessage_canceldate(UNSIGNED1 wh) := InValidMessageFT_invalid_past_date(wh);
 
EXPORT Make_cdlmedicertissuedate(SALT311.StrType s0) := MakeFT_invalid_past_date(s0);
EXPORT InValid_cdlmedicertissuedate(SALT311.StrType s) := InValidFT_invalid_past_date(s);
EXPORT InValidMessage_cdlmedicertissuedate(UNSIGNED1 wh) := InValidMessageFT_invalid_past_date(wh);
 
EXPORT Make_cdlmedicertexpdate(SALT311.StrType s0) := MakeFT_invalid_general_date(s0);
EXPORT InValid_cdlmedicertexpdate(SALT311.StrType s) := InValidFT_invalid_general_date(s);
EXPORT InValidMessage_cdlmedicertexpdate(UNSIGNED1 wh) := InValidMessageFT_invalid_general_date(wh);
 
EXPORT Make_clean_name_prefix(SALT311.StrType s0) := s0;
EXPORT InValid_clean_name_prefix(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_name_prefix(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_name_first(SALT311.StrType s0) := s0;
EXPORT InValid_clean_name_first(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_name_first(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_name_middle(SALT311.StrType s0) := s0;
EXPORT InValid_clean_name_middle(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_name_middle(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_name_last(SALT311.StrType s0) := MakeFT_invalid_clean_name(s0);
EXPORT InValid_clean_name_last(SALT311.StrType s,SALT311.StrType clean_name_first,SALT311.StrType clean_name_middle) := InValidFT_invalid_clean_name(s,clean_name_first,clean_name_middle);
EXPORT InValidMessage_clean_name_last(UNSIGNED1 wh) := InValidMessageFT_invalid_clean_name(wh);
 
EXPORT Make_clean_name_suffix(SALT311.StrType s0) := s0;
EXPORT InValid_clean_name_suffix(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_name_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_name_score(SALT311.StrType s0) := s0;
EXPORT InValid_clean_name_score(SALT311.StrType s) := 0;
EXPORT InValidMessage_clean_name_score(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_DL_CT;
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
    BOOLEAN Diff_append_process_date;
    BOOLEAN Diff_credentialstate;
    BOOLEAN Diff_credentialnumber;
    BOOLEAN Diff_lastname;
    BOOLEAN Diff_firstname;
    BOOLEAN Diff_middleinitial;
    BOOLEAN Diff_gender;
    BOOLEAN Diff_height;
    BOOLEAN Diff_eyecolor;
    BOOLEAN Diff_date_birth;
    BOOLEAN Diff_resiaddrstreet;
    BOOLEAN Diff_residencycity;
    BOOLEAN Diff_residencystate;
    BOOLEAN Diff_residencyzip;
    BOOLEAN Diff_mailaddrstreet;
    BOOLEAN Diff_mailingcity;
    BOOLEAN Diff_mailingstate;
    BOOLEAN Diff_mailingzip;
    BOOLEAN Diff_credentialtype;
    BOOLEAN Diff_credential_class;
    BOOLEAN Diff_endorsements;
    BOOLEAN Diff_restrictions;
    BOOLEAN Diff_expdate;
    BOOLEAN Diff_lastissuerenewaldate;
    BOOLEAN Diff_date_noncdl;
    BOOLEAN Diff_originaldate_cdl;
    BOOLEAN Diff_statusnoncdl;
    BOOLEAN Diff_licensestatuscdl;
    BOOLEAN Diff_originaldate_lp;
    BOOLEAN Diff_originaldate_id;
    BOOLEAN Diff_cancelstate;
    BOOLEAN Diff_canceldate;
    BOOLEAN Diff_cdlmedicertissuedate;
    BOOLEAN Diff_cdlmedicertexpdate;
    BOOLEAN Diff_clean_name_prefix;
    BOOLEAN Diff_clean_name_first;
    BOOLEAN Diff_clean_name_middle;
    BOOLEAN Diff_clean_name_last;
    BOOLEAN Diff_clean_name_suffix;
    BOOLEAN Diff_clean_name_score;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_append_process_date := le.append_process_date <> ri.append_process_date;
    SELF.Diff_credentialstate := le.credentialstate <> ri.credentialstate;
    SELF.Diff_credentialnumber := le.credentialnumber <> ri.credentialnumber;
    SELF.Diff_lastname := le.lastname <> ri.lastname;
    SELF.Diff_firstname := le.firstname <> ri.firstname;
    SELF.Diff_middleinitial := le.middleinitial <> ri.middleinitial;
    SELF.Diff_gender := le.gender <> ri.gender;
    SELF.Diff_height := le.height <> ri.height;
    SELF.Diff_eyecolor := le.eyecolor <> ri.eyecolor;
    SELF.Diff_date_birth := le.date_birth <> ri.date_birth;
    SELF.Diff_resiaddrstreet := le.resiaddrstreet <> ri.resiaddrstreet;
    SELF.Diff_residencycity := le.residencycity <> ri.residencycity;
    SELF.Diff_residencystate := le.residencystate <> ri.residencystate;
    SELF.Diff_residencyzip := le.residencyzip <> ri.residencyzip;
    SELF.Diff_mailaddrstreet := le.mailaddrstreet <> ri.mailaddrstreet;
    SELF.Diff_mailingcity := le.mailingcity <> ri.mailingcity;
    SELF.Diff_mailingstate := le.mailingstate <> ri.mailingstate;
    SELF.Diff_mailingzip := le.mailingzip <> ri.mailingzip;
    SELF.Diff_credentialtype := le.credentialtype <> ri.credentialtype;
    SELF.Diff_credential_class := le.credential_class <> ri.credential_class;
    SELF.Diff_endorsements := le.endorsements <> ri.endorsements;
    SELF.Diff_restrictions := le.restrictions <> ri.restrictions;
    SELF.Diff_expdate := le.expdate <> ri.expdate;
    SELF.Diff_lastissuerenewaldate := le.lastissuerenewaldate <> ri.lastissuerenewaldate;
    SELF.Diff_date_noncdl := le.date_noncdl <> ri.date_noncdl;
    SELF.Diff_originaldate_cdl := le.originaldate_cdl <> ri.originaldate_cdl;
    SELF.Diff_statusnoncdl := le.statusnoncdl <> ri.statusnoncdl;
    SELF.Diff_licensestatuscdl := le.licensestatuscdl <> ri.licensestatuscdl;
    SELF.Diff_originaldate_lp := le.originaldate_lp <> ri.originaldate_lp;
    SELF.Diff_originaldate_id := le.originaldate_id <> ri.originaldate_id;
    SELF.Diff_cancelstate := le.cancelstate <> ri.cancelstate;
    SELF.Diff_canceldate := le.canceldate <> ri.canceldate;
    SELF.Diff_cdlmedicertissuedate := le.cdlmedicertissuedate <> ri.cdlmedicertissuedate;
    SELF.Diff_cdlmedicertexpdate := le.cdlmedicertexpdate <> ri.cdlmedicertexpdate;
    SELF.Diff_clean_name_prefix := le.clean_name_prefix <> ri.clean_name_prefix;
    SELF.Diff_clean_name_first := le.clean_name_first <> ri.clean_name_first;
    SELF.Diff_clean_name_middle := le.clean_name_middle <> ri.clean_name_middle;
    SELF.Diff_clean_name_last := le.clean_name_last <> ri.clean_name_last;
    SELF.Diff_clean_name_suffix := le.clean_name_suffix <> ri.clean_name_suffix;
    SELF.Diff_clean_name_score := le.clean_name_score <> ri.clean_name_score;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_append_process_date,1,0)+ IF( SELF.Diff_credentialstate,1,0)+ IF( SELF.Diff_credentialnumber,1,0)+ IF( SELF.Diff_lastname,1,0)+ IF( SELF.Diff_firstname,1,0)+ IF( SELF.Diff_middleinitial,1,0)+ IF( SELF.Diff_gender,1,0)+ IF( SELF.Diff_height,1,0)+ IF( SELF.Diff_eyecolor,1,0)+ IF( SELF.Diff_date_birth,1,0)+ IF( SELF.Diff_resiaddrstreet,1,0)+ IF( SELF.Diff_residencycity,1,0)+ IF( SELF.Diff_residencystate,1,0)+ IF( SELF.Diff_residencyzip,1,0)+ IF( SELF.Diff_mailaddrstreet,1,0)+ IF( SELF.Diff_mailingcity,1,0)+ IF( SELF.Diff_mailingstate,1,0)+ IF( SELF.Diff_mailingzip,1,0)+ IF( SELF.Diff_credentialtype,1,0)+ IF( SELF.Diff_credential_class,1,0)+ IF( SELF.Diff_endorsements,1,0)+ IF( SELF.Diff_restrictions,1,0)+ IF( SELF.Diff_expdate,1,0)+ IF( SELF.Diff_lastissuerenewaldate,1,0)+ IF( SELF.Diff_date_noncdl,1,0)+ IF( SELF.Diff_originaldate_cdl,1,0)+ IF( SELF.Diff_statusnoncdl,1,0)+ IF( SELF.Diff_licensestatuscdl,1,0)+ IF( SELF.Diff_originaldate_lp,1,0)+ IF( SELF.Diff_originaldate_id,1,0)+ IF( SELF.Diff_cancelstate,1,0)+ IF( SELF.Diff_canceldate,1,0)+ IF( SELF.Diff_cdlmedicertissuedate,1,0)+ IF( SELF.Diff_cdlmedicertexpdate,1,0)+ IF( SELF.Diff_clean_name_prefix,1,0)+ IF( SELF.Diff_clean_name_first,1,0)+ IF( SELF.Diff_clean_name_middle,1,0)+ IF( SELF.Diff_clean_name_last,1,0)+ IF( SELF.Diff_clean_name_suffix,1,0)+ IF( SELF.Diff_clean_name_score,1,0);
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
    Count_Diff_append_process_date := COUNT(GROUP,%Closest%.Diff_append_process_date);
    Count_Diff_credentialstate := COUNT(GROUP,%Closest%.Diff_credentialstate);
    Count_Diff_credentialnumber := COUNT(GROUP,%Closest%.Diff_credentialnumber);
    Count_Diff_lastname := COUNT(GROUP,%Closest%.Diff_lastname);
    Count_Diff_firstname := COUNT(GROUP,%Closest%.Diff_firstname);
    Count_Diff_middleinitial := COUNT(GROUP,%Closest%.Diff_middleinitial);
    Count_Diff_gender := COUNT(GROUP,%Closest%.Diff_gender);
    Count_Diff_height := COUNT(GROUP,%Closest%.Diff_height);
    Count_Diff_eyecolor := COUNT(GROUP,%Closest%.Diff_eyecolor);
    Count_Diff_date_birth := COUNT(GROUP,%Closest%.Diff_date_birth);
    Count_Diff_resiaddrstreet := COUNT(GROUP,%Closest%.Diff_resiaddrstreet);
    Count_Diff_residencycity := COUNT(GROUP,%Closest%.Diff_residencycity);
    Count_Diff_residencystate := COUNT(GROUP,%Closest%.Diff_residencystate);
    Count_Diff_residencyzip := COUNT(GROUP,%Closest%.Diff_residencyzip);
    Count_Diff_mailaddrstreet := COUNT(GROUP,%Closest%.Diff_mailaddrstreet);
    Count_Diff_mailingcity := COUNT(GROUP,%Closest%.Diff_mailingcity);
    Count_Diff_mailingstate := COUNT(GROUP,%Closest%.Diff_mailingstate);
    Count_Diff_mailingzip := COUNT(GROUP,%Closest%.Diff_mailingzip);
    Count_Diff_credentialtype := COUNT(GROUP,%Closest%.Diff_credentialtype);
    Count_Diff_credential_class := COUNT(GROUP,%Closest%.Diff_credential_class);
    Count_Diff_endorsements := COUNT(GROUP,%Closest%.Diff_endorsements);
    Count_Diff_restrictions := COUNT(GROUP,%Closest%.Diff_restrictions);
    Count_Diff_expdate := COUNT(GROUP,%Closest%.Diff_expdate);
    Count_Diff_lastissuerenewaldate := COUNT(GROUP,%Closest%.Diff_lastissuerenewaldate);
    Count_Diff_date_noncdl := COUNT(GROUP,%Closest%.Diff_date_noncdl);
    Count_Diff_originaldate_cdl := COUNT(GROUP,%Closest%.Diff_originaldate_cdl);
    Count_Diff_statusnoncdl := COUNT(GROUP,%Closest%.Diff_statusnoncdl);
    Count_Diff_licensestatuscdl := COUNT(GROUP,%Closest%.Diff_licensestatuscdl);
    Count_Diff_originaldate_lp := COUNT(GROUP,%Closest%.Diff_originaldate_lp);
    Count_Diff_originaldate_id := COUNT(GROUP,%Closest%.Diff_originaldate_id);
    Count_Diff_cancelstate := COUNT(GROUP,%Closest%.Diff_cancelstate);
    Count_Diff_canceldate := COUNT(GROUP,%Closest%.Diff_canceldate);
    Count_Diff_cdlmedicertissuedate := COUNT(GROUP,%Closest%.Diff_cdlmedicertissuedate);
    Count_Diff_cdlmedicertexpdate := COUNT(GROUP,%Closest%.Diff_cdlmedicertexpdate);
    Count_Diff_clean_name_prefix := COUNT(GROUP,%Closest%.Diff_clean_name_prefix);
    Count_Diff_clean_name_first := COUNT(GROUP,%Closest%.Diff_clean_name_first);
    Count_Diff_clean_name_middle := COUNT(GROUP,%Closest%.Diff_clean_name_middle);
    Count_Diff_clean_name_last := COUNT(GROUP,%Closest%.Diff_clean_name_last);
    Count_Diff_clean_name_suffix := COUNT(GROUP,%Closest%.Diff_clean_name_suffix);
    Count_Diff_clean_name_score := COUNT(GROUP,%Closest%.Diff_clean_name_score);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
