IMPORT SALT311;
IMPORT Scrubs_PhoneFinder; // Import modules for FieldTypes attribute definitions
EXPORT Transactions_Fields := MODULE
 
EXPORT NumFields := 36;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Binary','Invalid_No','Invalid_ID','Invalid_Code','Invalid_Alpha','Invalid_AlphaChar','Invalid_Risk','Invalid_Phone_Type','Invalid_Phone_Status','Invalid_Forward','Invalid_State','Invalid_Zip','Invalid_Phone','Invalid_Date','Invalid_File');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_Binary' => 1,'Invalid_No' => 2,'Invalid_ID' => 3,'Invalid_Code' => 4,'Invalid_Alpha' => 5,'Invalid_AlphaChar' => 6,'Invalid_Risk' => 7,'Invalid_Phone_Type' => 8,'Invalid_Phone_Status' => 9,'Invalid_Forward' => 10,'Invalid_State' => 11,'Invalid_Zip' => 12,'Invalid_Phone' => 13,'Invalid_Date' => 14,'Invalid_File' => 15,0);
 
EXPORT MakeFT_Invalid_Binary(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'01\\\\N'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Binary(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'01\\\\N'))));
EXPORT InValidMessageFT_Invalid_Binary(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('01\\\\N'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_No(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789\\\\N'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_No(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789\\\\N'))));
EXPORT InValidMessageFT_Invalid_No(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789\\\\N'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_ID(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789R\\\\N'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_ID(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789R\\\\N'))));
EXPORT InValidMessageFT_Invalid_ID(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789R\\\\N'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Code(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789(). -\\\\N'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Code(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789(). -\\\\N'))));
EXPORT InValidMessageFT_Invalid_Code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789(). -\\\\N'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Alpha(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz\\\\ '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Alpha(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz\\\\ '))));
EXPORT InValidMessageFT_Invalid_Alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz\\\\ '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaChar(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\\(\\)_[] .,:;#/-&\\\\\'*'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AlphaChar(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\\(\\)_[] .,:;#/-&\\\\\'*'))));
EXPORT InValidMessageFT_Invalid_AlphaChar(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\\(\\)_[] .,:;#/-&\\\\\'*'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Risk(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Risk(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['PASS','FAIL','WARN','\\N','']);
EXPORT InValidMessageFT_Invalid_Risk(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('PASS|FAIL|WARN|\\N|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Phone_Type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Phone_Type(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['POSSIBLE WIRELESS','LANDLINE','POSSIBLE VOIP','OTHER UNKNOWN','PAGER','CABLE','OTHER/UNKNOWN','\\N','']);
EXPORT InValidMessageFT_Invalid_Phone_Type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('POSSIBLE WIRELESS|LANDLINE|POSSIBLE VOIP|OTHER UNKNOWN|PAGER|CABLE|OTHER/UNKNOWN|\\N|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Phone_Status(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Phone_Status(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['ACTIVE','INACTIVE','NOT AVAILABLE','\\N','']);
EXPORT InValidMessageFT_Invalid_Phone_Status(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('ACTIVE|INACTIVE|NOT AVAILABLE|\\N|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Forward(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Forward(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['FORWARDED','NOT FORWARDED','\\N','']);
EXPORT InValidMessageFT_Invalid_Forward(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('FORWARDED|NOT FORWARDED|\\N|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_State(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz\\\\ '); // Only allow valid symbols
  RETURN  MakeFT_Invalid_Alpha(s1);
END;
EXPORT InValidFT_Invalid_State(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz\\\\ '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_Invalid_State(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz\\\\ '),SALT311.HygieneErrors.NotLength('0,2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Zip(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789\\\\N'); // Only allow valid symbols
  RETURN  MakeFT_Invalid_No(s1);
END;
EXPORT InValidFT_Invalid_Zip(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789\\\\N'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 5));
EXPORT InValidMessageFT_Invalid_Zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789\\\\N'),SALT311.HygieneErrors.NotLength('0,2,5'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Phone(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789\\\\N'); // Only allow valid symbols
  RETURN  MakeFT_Invalid_No(s1);
END;
EXPORT InValidFT_Invalid_Phone(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789\\\\N'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_Invalid_Phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789\\\\N'),SALT311.HygieneErrors.NotLength('0,2,9,10'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT311.StrType s) := WHICH(~Scrubs_PhoneFinder.Functions.Split_Date(s)>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_PhoneFinder.Functions.Split_Date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_File(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_File(SALT311.StrType s) := WHICH(~Scrubs_PhoneFinder.Functions.Check_File(s)>0);
EXPORT InValidMessageFT_Invalid_File(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_PhoneFinder.Functions.Check_File'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'transaction_id','transaction_date','user_id','product_code','company_id','source_code','batch_job_id','batch_acctno','response_time','reference_code','phonefinder_type','submitted_lexid','submitted_phonenumber','submitted_firstname','submitted_lastname','submitted_middlename','submitted_streetaddress1','submitted_city','submitted_state','submitted_zip','phonenumber','data_source','royalty_used','carrier','risk_indicator','phone_type','phone_status','ported_count','last_ported_date','otp_count','last_otp_date','spoof_count','last_spoof_date','phone_forwarded','date_added','filename');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'transaction_id','transaction_date','user_id','product_code','company_id','source_code','batch_job_id','batch_acctno','response_time','reference_code','phonefinder_type','submitted_lexid','submitted_phonenumber','submitted_firstname','submitted_lastname','submitted_middlename','submitted_streetaddress1','submitted_city','submitted_state','submitted_zip','phonenumber','data_source','royalty_used','carrier','risk_indicator','phone_type','phone_status','ported_count','last_ported_date','otp_count','last_otp_date','spoof_count','last_spoof_date','phone_forwarded','date_added','filename');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'transaction_id' => 0,'transaction_date' => 1,'user_id' => 2,'product_code' => 3,'company_id' => 4,'source_code' => 5,'batch_job_id' => 6,'batch_acctno' => 7,'response_time' => 8,'reference_code' => 9,'phonefinder_type' => 10,'submitted_lexid' => 11,'submitted_phonenumber' => 12,'submitted_firstname' => 13,'submitted_lastname' => 14,'submitted_middlename' => 15,'submitted_streetaddress1' => 16,'submitted_city' => 17,'submitted_state' => 18,'submitted_zip' => 19,'phonenumber' => 20,'data_source' => 21,'royalty_used' => 22,'carrier' => 23,'risk_indicator' => 24,'phone_type' => 25,'phone_status' => 26,'ported_count' => 27,'last_ported_date' => 28,'otp_count' => 29,'last_otp_date' => 30,'spoof_count' => 31,'last_spoof_date' => 32,'phone_forwarded' => 33,'date_added' => 34,'filename' => 35,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['CUSTOM'],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW'],['ENUM'],['ENUM'],['ENUM'],['ALLOW'],['CUSTOM'],['ALLOW'],['CUSTOM'],['ALLOW'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_transaction_id(SALT311.StrType s0) := MakeFT_Invalid_ID(s0);
EXPORT InValid_transaction_id(SALT311.StrType s) := InValidFT_Invalid_ID(s);
EXPORT InValidMessage_transaction_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_ID(wh);
 
EXPORT Make_transaction_date(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_transaction_date(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_transaction_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_user_id(SALT311.StrType s0) := s0;
EXPORT InValid_user_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_user_id(UNSIGNED1 wh) := '';
 
EXPORT Make_product_code(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_product_code(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_product_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_company_id(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_company_id(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_company_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_source_code(SALT311.StrType s0) := MakeFT_Invalid_Code(s0);
EXPORT InValid_source_code(SALT311.StrType s) := InValidFT_Invalid_Code(s);
EXPORT InValidMessage_source_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_Code(wh);
 
EXPORT Make_batch_job_id(SALT311.StrType s0) := MakeFT_Invalid_Code(s0);
EXPORT InValid_batch_job_id(SALT311.StrType s) := InValidFT_Invalid_Code(s);
EXPORT InValidMessage_batch_job_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_Code(wh);
 
EXPORT Make_batch_acctno(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_batch_acctno(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_batch_acctno(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_response_time(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_response_time(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_response_time(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_reference_code(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_reference_code(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_reference_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_phonefinder_type(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_phonefinder_type(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_phonefinder_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_submitted_lexid(SALT311.StrType s0) := MakeFT_Invalid_Code(s0);
EXPORT InValid_submitted_lexid(SALT311.StrType s) := InValidFT_Invalid_Code(s);
EXPORT InValidMessage_submitted_lexid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Code(wh);
 
EXPORT Make_submitted_phonenumber(SALT311.StrType s0) := MakeFT_Invalid_Code(s0);
EXPORT InValid_submitted_phonenumber(SALT311.StrType s) := InValidFT_Invalid_Code(s);
EXPORT InValidMessage_submitted_phonenumber(UNSIGNED1 wh) := InValidMessageFT_Invalid_Code(wh);
 
EXPORT Make_submitted_firstname(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_submitted_firstname(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_submitted_firstname(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_submitted_lastname(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_submitted_lastname(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_submitted_lastname(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_submitted_middlename(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_submitted_middlename(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_submitted_middlename(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_submitted_streetaddress1(SALT311.StrType s0) := s0;
EXPORT InValid_submitted_streetaddress1(SALT311.StrType s) := 0;
EXPORT InValidMessage_submitted_streetaddress1(UNSIGNED1 wh) := '';
 
EXPORT Make_submitted_city(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_submitted_city(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_submitted_city(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_submitted_state(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_submitted_state(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_submitted_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_submitted_zip(SALT311.StrType s0) := MakeFT_Invalid_Zip(s0);
EXPORT InValid_submitted_zip(SALT311.StrType s) := InValidFT_Invalid_Zip(s);
EXPORT InValidMessage_submitted_zip(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zip(wh);
 
EXPORT Make_phonenumber(SALT311.StrType s0) := MakeFT_Invalid_Phone(s0);
EXPORT InValid_phonenumber(SALT311.StrType s) := InValidFT_Invalid_Phone(s);
EXPORT InValidMessage_phonenumber(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone(wh);
 
EXPORT Make_data_source(SALT311.StrType s0) := MakeFT_Invalid_Binary(s0);
EXPORT InValid_data_source(SALT311.StrType s) := InValidFT_Invalid_Binary(s);
EXPORT InValidMessage_data_source(UNSIGNED1 wh) := InValidMessageFT_Invalid_Binary(wh);
 
EXPORT Make_royalty_used(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_royalty_used(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_royalty_used(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_carrier(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_carrier(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_carrier(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_risk_indicator(SALT311.StrType s0) := MakeFT_Invalid_Risk(s0);
EXPORT InValid_risk_indicator(SALT311.StrType s) := InValidFT_Invalid_Risk(s);
EXPORT InValidMessage_risk_indicator(UNSIGNED1 wh) := InValidMessageFT_Invalid_Risk(wh);
 
EXPORT Make_phone_type(SALT311.StrType s0) := MakeFT_Invalid_Phone_Type(s0);
EXPORT InValid_phone_type(SALT311.StrType s) := InValidFT_Invalid_Phone_Type(s);
EXPORT InValidMessage_phone_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone_Type(wh);
 
EXPORT Make_phone_status(SALT311.StrType s0) := MakeFT_Invalid_Phone_Status(s0);
EXPORT InValid_phone_status(SALT311.StrType s) := InValidFT_Invalid_Phone_Status(s);
EXPORT InValidMessage_phone_status(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone_Status(wh);
 
EXPORT Make_ported_count(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_ported_count(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_ported_count(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_last_ported_date(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_last_ported_date(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_last_ported_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_otp_count(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_otp_count(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_otp_count(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_last_otp_date(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_last_otp_date(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_last_otp_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_spoof_count(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_spoof_count(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_spoof_count(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_last_spoof_date(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_last_spoof_date(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_last_spoof_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_phone_forwarded(SALT311.StrType s0) := MakeFT_Invalid_Forward(s0);
EXPORT InValid_phone_forwarded(SALT311.StrType s) := InValidFT_Invalid_Forward(s);
EXPORT InValidMessage_phone_forwarded(UNSIGNED1 wh) := InValidMessageFT_Invalid_Forward(wh);
 
EXPORT Make_date_added(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_date_added(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_date_added(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_filename(SALT311.StrType s0) := MakeFT_Invalid_File(s0);
EXPORT InValid_filename(SALT311.StrType s) := InValidFT_Invalid_File(s);
EXPORT InValidMessage_filename(UNSIGNED1 wh) := InValidMessageFT_Invalid_File(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_PhoneFinder;
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
    BOOLEAN Diff_transaction_id;
    BOOLEAN Diff_transaction_date;
    BOOLEAN Diff_user_id;
    BOOLEAN Diff_product_code;
    BOOLEAN Diff_company_id;
    BOOLEAN Diff_source_code;
    BOOLEAN Diff_batch_job_id;
    BOOLEAN Diff_batch_acctno;
    BOOLEAN Diff_response_time;
    BOOLEAN Diff_reference_code;
    BOOLEAN Diff_phonefinder_type;
    BOOLEAN Diff_submitted_lexid;
    BOOLEAN Diff_submitted_phonenumber;
    BOOLEAN Diff_submitted_firstname;
    BOOLEAN Diff_submitted_lastname;
    BOOLEAN Diff_submitted_middlename;
    BOOLEAN Diff_submitted_streetaddress1;
    BOOLEAN Diff_submitted_city;
    BOOLEAN Diff_submitted_state;
    BOOLEAN Diff_submitted_zip;
    BOOLEAN Diff_phonenumber;
    BOOLEAN Diff_data_source;
    BOOLEAN Diff_royalty_used;
    BOOLEAN Diff_carrier;
    BOOLEAN Diff_risk_indicator;
    BOOLEAN Diff_phone_type;
    BOOLEAN Diff_phone_status;
    BOOLEAN Diff_ported_count;
    BOOLEAN Diff_last_ported_date;
    BOOLEAN Diff_otp_count;
    BOOLEAN Diff_last_otp_date;
    BOOLEAN Diff_spoof_count;
    BOOLEAN Diff_last_spoof_date;
    BOOLEAN Diff_phone_forwarded;
    BOOLEAN Diff_date_added;
    BOOLEAN Diff_filename;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_transaction_id := le.transaction_id <> ri.transaction_id;
    SELF.Diff_transaction_date := le.transaction_date <> ri.transaction_date;
    SELF.Diff_user_id := le.user_id <> ri.user_id;
    SELF.Diff_product_code := le.product_code <> ri.product_code;
    SELF.Diff_company_id := le.company_id <> ri.company_id;
    SELF.Diff_source_code := le.source_code <> ri.source_code;
    SELF.Diff_batch_job_id := le.batch_job_id <> ri.batch_job_id;
    SELF.Diff_batch_acctno := le.batch_acctno <> ri.batch_acctno;
    SELF.Diff_response_time := le.response_time <> ri.response_time;
    SELF.Diff_reference_code := le.reference_code <> ri.reference_code;
    SELF.Diff_phonefinder_type := le.phonefinder_type <> ri.phonefinder_type;
    SELF.Diff_submitted_lexid := le.submitted_lexid <> ri.submitted_lexid;
    SELF.Diff_submitted_phonenumber := le.submitted_phonenumber <> ri.submitted_phonenumber;
    SELF.Diff_submitted_firstname := le.submitted_firstname <> ri.submitted_firstname;
    SELF.Diff_submitted_lastname := le.submitted_lastname <> ri.submitted_lastname;
    SELF.Diff_submitted_middlename := le.submitted_middlename <> ri.submitted_middlename;
    SELF.Diff_submitted_streetaddress1 := le.submitted_streetaddress1 <> ri.submitted_streetaddress1;
    SELF.Diff_submitted_city := le.submitted_city <> ri.submitted_city;
    SELF.Diff_submitted_state := le.submitted_state <> ri.submitted_state;
    SELF.Diff_submitted_zip := le.submitted_zip <> ri.submitted_zip;
    SELF.Diff_phonenumber := le.phonenumber <> ri.phonenumber;
    SELF.Diff_data_source := le.data_source <> ri.data_source;
    SELF.Diff_royalty_used := le.royalty_used <> ri.royalty_used;
    SELF.Diff_carrier := le.carrier <> ri.carrier;
    SELF.Diff_risk_indicator := le.risk_indicator <> ri.risk_indicator;
    SELF.Diff_phone_type := le.phone_type <> ri.phone_type;
    SELF.Diff_phone_status := le.phone_status <> ri.phone_status;
    SELF.Diff_ported_count := le.ported_count <> ri.ported_count;
    SELF.Diff_last_ported_date := le.last_ported_date <> ri.last_ported_date;
    SELF.Diff_otp_count := le.otp_count <> ri.otp_count;
    SELF.Diff_last_otp_date := le.last_otp_date <> ri.last_otp_date;
    SELF.Diff_spoof_count := le.spoof_count <> ri.spoof_count;
    SELF.Diff_last_spoof_date := le.last_spoof_date <> ri.last_spoof_date;
    SELF.Diff_phone_forwarded := le.phone_forwarded <> ri.phone_forwarded;
    SELF.Diff_date_added := le.date_added <> ri.date_added;
    SELF.Diff_filename := le.filename <> ri.filename;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_transaction_id,1,0)+ IF( SELF.Diff_transaction_date,1,0)+ IF( SELF.Diff_user_id,1,0)+ IF( SELF.Diff_product_code,1,0)+ IF( SELF.Diff_company_id,1,0)+ IF( SELF.Diff_source_code,1,0)+ IF( SELF.Diff_batch_job_id,1,0)+ IF( SELF.Diff_batch_acctno,1,0)+ IF( SELF.Diff_response_time,1,0)+ IF( SELF.Diff_reference_code,1,0)+ IF( SELF.Diff_phonefinder_type,1,0)+ IF( SELF.Diff_submitted_lexid,1,0)+ IF( SELF.Diff_submitted_phonenumber,1,0)+ IF( SELF.Diff_submitted_firstname,1,0)+ IF( SELF.Diff_submitted_lastname,1,0)+ IF( SELF.Diff_submitted_middlename,1,0)+ IF( SELF.Diff_submitted_streetaddress1,1,0)+ IF( SELF.Diff_submitted_city,1,0)+ IF( SELF.Diff_submitted_state,1,0)+ IF( SELF.Diff_submitted_zip,1,0)+ IF( SELF.Diff_phonenumber,1,0)+ IF( SELF.Diff_data_source,1,0)+ IF( SELF.Diff_royalty_used,1,0)+ IF( SELF.Diff_carrier,1,0)+ IF( SELF.Diff_risk_indicator,1,0)+ IF( SELF.Diff_phone_type,1,0)+ IF( SELF.Diff_phone_status,1,0)+ IF( SELF.Diff_ported_count,1,0)+ IF( SELF.Diff_last_ported_date,1,0)+ IF( SELF.Diff_otp_count,1,0)+ IF( SELF.Diff_last_otp_date,1,0)+ IF( SELF.Diff_spoof_count,1,0)+ IF( SELF.Diff_last_spoof_date,1,0)+ IF( SELF.Diff_phone_forwarded,1,0)+ IF( SELF.Diff_date_added,1,0)+ IF( SELF.Diff_filename,1,0);
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
    Count_Diff_transaction_id := COUNT(GROUP,%Closest%.Diff_transaction_id);
    Count_Diff_transaction_date := COUNT(GROUP,%Closest%.Diff_transaction_date);
    Count_Diff_user_id := COUNT(GROUP,%Closest%.Diff_user_id);
    Count_Diff_product_code := COUNT(GROUP,%Closest%.Diff_product_code);
    Count_Diff_company_id := COUNT(GROUP,%Closest%.Diff_company_id);
    Count_Diff_source_code := COUNT(GROUP,%Closest%.Diff_source_code);
    Count_Diff_batch_job_id := COUNT(GROUP,%Closest%.Diff_batch_job_id);
    Count_Diff_batch_acctno := COUNT(GROUP,%Closest%.Diff_batch_acctno);
    Count_Diff_response_time := COUNT(GROUP,%Closest%.Diff_response_time);
    Count_Diff_reference_code := COUNT(GROUP,%Closest%.Diff_reference_code);
    Count_Diff_phonefinder_type := COUNT(GROUP,%Closest%.Diff_phonefinder_type);
    Count_Diff_submitted_lexid := COUNT(GROUP,%Closest%.Diff_submitted_lexid);
    Count_Diff_submitted_phonenumber := COUNT(GROUP,%Closest%.Diff_submitted_phonenumber);
    Count_Diff_submitted_firstname := COUNT(GROUP,%Closest%.Diff_submitted_firstname);
    Count_Diff_submitted_lastname := COUNT(GROUP,%Closest%.Diff_submitted_lastname);
    Count_Diff_submitted_middlename := COUNT(GROUP,%Closest%.Diff_submitted_middlename);
    Count_Diff_submitted_streetaddress1 := COUNT(GROUP,%Closest%.Diff_submitted_streetaddress1);
    Count_Diff_submitted_city := COUNT(GROUP,%Closest%.Diff_submitted_city);
    Count_Diff_submitted_state := COUNT(GROUP,%Closest%.Diff_submitted_state);
    Count_Diff_submitted_zip := COUNT(GROUP,%Closest%.Diff_submitted_zip);
    Count_Diff_phonenumber := COUNT(GROUP,%Closest%.Diff_phonenumber);
    Count_Diff_data_source := COUNT(GROUP,%Closest%.Diff_data_source);
    Count_Diff_royalty_used := COUNT(GROUP,%Closest%.Diff_royalty_used);
    Count_Diff_carrier := COUNT(GROUP,%Closest%.Diff_carrier);
    Count_Diff_risk_indicator := COUNT(GROUP,%Closest%.Diff_risk_indicator);
    Count_Diff_phone_type := COUNT(GROUP,%Closest%.Diff_phone_type);
    Count_Diff_phone_status := COUNT(GROUP,%Closest%.Diff_phone_status);
    Count_Diff_ported_count := COUNT(GROUP,%Closest%.Diff_ported_count);
    Count_Diff_last_ported_date := COUNT(GROUP,%Closest%.Diff_last_ported_date);
    Count_Diff_otp_count := COUNT(GROUP,%Closest%.Diff_otp_count);
    Count_Diff_last_otp_date := COUNT(GROUP,%Closest%.Diff_last_otp_date);
    Count_Diff_spoof_count := COUNT(GROUP,%Closest%.Diff_spoof_count);
    Count_Diff_last_spoof_date := COUNT(GROUP,%Closest%.Diff_last_spoof_date);
    Count_Diff_phone_forwarded := COUNT(GROUP,%Closest%.Diff_phone_forwarded);
    Count_Diff_date_added := COUNT(GROUP,%Closest%.Diff_date_added);
    Count_Diff_filename := COUNT(GROUP,%Closest%.Diff_filename);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
