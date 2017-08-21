IMPORT ut,SALT33;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT BaseFile_Fields := MODULE
// Processing for each FieldType
EXPORT SALT33.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Phone','Invalid_Source','Invalid_Date','Invalid_Future_Date','Invalid_Phone_Type','Invalid_Num','Invalid_Num_Blank','Invalid_Char','Invalid_State','Invalid_Dial_Type','Invalid_ISO2','Invalid_Zero_Three','Invalid_Deact','Invalid_Num_In_Service','Invalid_YN');
EXPORT FieldTypeNum(SALT33.StrType fn) := CASE(fn,'Invalid_Phone' => 1,'Invalid_Source' => 2,'Invalid_Date' => 3,'Invalid_Future_Date' => 4,'Invalid_Phone_Type' => 5,'Invalid_Num' => 6,'Invalid_Num_Blank' => 7,'Invalid_Char' => 8,'Invalid_State' => 9,'Invalid_Dial_Type' => 10,'Invalid_ISO2' => 11,'Invalid_Zero_Three' => 12,'Invalid_Deact' => 13,'Invalid_Num_In_Service' => 14,'Invalid_YN' => 15,0);
EXPORT MakeFT_Invalid_Phone(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Phone(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_Phone(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_Invalid_Source(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Source(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['PX','PK','PJ','PO','PB'],~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_Invalid_Source(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('PX|PK|PJ|PO|PB'),SALT33.HygieneErrors.NotLength('1..'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_Invalid_Date(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT33.StrType s) := WHICH(~Scrubs.fn_valid_date(s)>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_Invalid_Future_Date(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Future_Date(SALT33.StrType s) := WHICH(~Scrubs.fn_valid_date(s,'future')>0);
EXPORT InValidMessageFT_Invalid_Future_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_Invalid_Phone_Type(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Phone_Type(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['LC','CL',' ']);
EXPORT InValidMessageFT_Invalid_Phone_Type(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('LC|CL| '),SALT33.HygieneErrors.Good);
EXPORT MakeFT_Invalid_Num(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_Invalid_Num_Blank(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789 \\t '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num_Blank(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789 \\t '))));
EXPORT InValidMessageFT_Invalid_Num_Blank(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789 \\t '),SALT33.HygieneErrors.Good);
EXPORT MakeFT_Invalid_Char(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .-:*&/_;\'"()!+,@|#'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Char(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .-:*&/_;\'"()!+,@|#'))));
EXPORT InValidMessageFT_Invalid_Char(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .-:*&/_;\'"()!+,@|#'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_Invalid_State(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_State(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))));
EXPORT InValidMessageFT_Invalid_State(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT33.HygieneErrors.Good);
EXPORT MakeFT_Invalid_Dial_Type(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'TBN '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Dial_Type(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'TBN '))));
EXPORT InValidMessageFT_Invalid_Dial_Type(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('TBN '),SALT33.HygieneErrors.Good);
EXPORT MakeFT_Invalid_ISO2(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_ISO2(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_Invalid_ISO2(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_Invalid_Zero_Three(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Zero_Three(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123'))));
EXPORT InValidMessageFT_Invalid_Zero_Three(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_Invalid_Deact(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Deact(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['DE','SU',' ']);
EXPORT InValidMessageFT_Invalid_Deact(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('DE|SU| '),SALT33.HygieneErrors.Good);
EXPORT MakeFT_Invalid_Num_In_Service(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789AIU'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num_In_Service(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789AIU'))));
EXPORT InValidMessageFT_Invalid_Num_In_Service(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789AIU'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_Invalid_YN(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'PYN0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_YN(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'PYN0123456789 '))));
EXPORT InValidMessageFT_Invalid_YN(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('PYN0123456789 '),SALT33.HygieneErrors.Good);
EXPORT SALT33.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'reference_id','source','dt_first_reported','dt_last_reported','phone','phonetype','reply_code','local_routing_number','account_owner','carrier_name','carrier_category','local_area_transport_area','point_code','country_code','dial_type','routing_code','porting_dt','porting_time','country_abbr','vendor_first_reported_dt','vendor_first_reported_time','vendor_last_reported_dt','vendor_last_reported_time','port_start_dt','port_start_time','port_end_dt','port_end_time','remove_port_dt','is_ported','serv','line','spid','operator_fullname','number_in_service','high_risk_indicator','prepaid','phone_swap','swap_start_dt','swap_start_time','swap_end_dt','swap_end_time','deact_code','deact_start_dt','deact_start_time','deact_end_dt','deact_end_time','react_start_dt','react_start_time','react_end_dt','react_end_time','is_deact','is_react','call_forward_dt','caller_id','subpoena_company_name','subpoena_contact_name','subpoena_carrier_address','subpoena_carrier_city','subpoena_carrier_state','subpoena_carrier_zip','subpoena_email','subpoena_contact_phone','subpoena_contact_fax');
EXPORT FieldNum(SALT33.StrType fn) := CASE(fn,'reference_id' => 0,'source' => 1,'dt_first_reported' => 2,'dt_last_reported' => 3,'phone' => 4,'phonetype' => 5,'reply_code' => 6,'local_routing_number' => 7,'account_owner' => 8,'carrier_name' => 9,'carrier_category' => 10,'local_area_transport_area' => 11,'point_code' => 12,'country_code' => 13,'dial_type' => 14,'routing_code' => 15,'porting_dt' => 16,'porting_time' => 17,'country_abbr' => 18,'vendor_first_reported_dt' => 19,'vendor_first_reported_time' => 20,'vendor_last_reported_dt' => 21,'vendor_last_reported_time' => 22,'port_start_dt' => 23,'port_start_time' => 24,'port_end_dt' => 25,'port_end_time' => 26,'remove_port_dt' => 27,'is_ported' => 28,'serv' => 29,'line' => 30,'spid' => 31,'operator_fullname' => 32,'number_in_service' => 33,'high_risk_indicator' => 34,'prepaid' => 35,'phone_swap' => 36,'swap_start_dt' => 37,'swap_start_time' => 38,'swap_end_dt' => 39,'swap_end_time' => 40,'deact_code' => 41,'deact_start_dt' => 42,'deact_start_time' => 43,'deact_end_dt' => 44,'deact_end_time' => 45,'react_start_dt' => 46,'react_start_time' => 47,'react_end_dt' => 48,'react_end_time' => 49,'is_deact' => 50,'is_react' => 51,'call_forward_dt' => 52,'caller_id' => 53,'subpoena_company_name' => 54,'subpoena_contact_name' => 55,'subpoena_carrier_address' => 56,'subpoena_carrier_city' => 57,'subpoena_carrier_state' => 58,'subpoena_carrier_zip' => 59,'subpoena_email' => 60,'subpoena_contact_phone' => 61,'subpoena_contact_fax' => 62,0);
//Individual field level validation
EXPORT Make_reference_id(SALT33.StrType s0) := s0;
EXPORT InValid_reference_id(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_reference_id(UNSIGNED1 wh) := '';
EXPORT Make_source(SALT33.StrType s0) := MakeFT_Invalid_Source(s0);
EXPORT InValid_source(SALT33.StrType s) := InValidFT_Invalid_Source(s);
EXPORT InValidMessage_source(UNSIGNED1 wh) := InValidMessageFT_Invalid_Source(wh);
EXPORT Make_dt_first_reported(SALT33.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dt_first_reported(SALT33.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dt_first_reported(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
EXPORT Make_dt_last_reported(SALT33.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dt_last_reported(SALT33.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dt_last_reported(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
EXPORT Make_phone(SALT33.StrType s0) := MakeFT_Invalid_Phone(s0);
EXPORT InValid_phone(SALT33.StrType s) := InValidFT_Invalid_Phone(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone(wh);
EXPORT Make_phonetype(SALT33.StrType s0) := MakeFT_Invalid_Phone_Type(s0);
EXPORT InValid_phonetype(SALT33.StrType s) := InValidFT_Invalid_Phone_Type(s);
EXPORT InValidMessage_phonetype(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone_Type(wh);
EXPORT Make_reply_code(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_reply_code(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_reply_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_local_routing_number(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_local_routing_number(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_local_routing_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_account_owner(SALT33.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_account_owner(SALT33.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_account_owner(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
EXPORT Make_carrier_name(SALT33.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_carrier_name(SALT33.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_carrier_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
EXPORT Make_carrier_category(SALT33.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_carrier_category(SALT33.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_carrier_category(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
EXPORT Make_local_area_transport_area(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_local_area_transport_area(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_local_area_transport_area(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_point_code(SALT33.StrType s0) := s0;
EXPORT InValid_point_code(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_point_code(UNSIGNED1 wh) := '';
EXPORT Make_country_code(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_country_code(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_country_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_dial_type(SALT33.StrType s0) := MakeFT_Invalid_Dial_Type(s0);
EXPORT InValid_dial_type(SALT33.StrType s) := InValidFT_Invalid_Dial_Type(s);
EXPORT InValidMessage_dial_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_Dial_Type(wh);
EXPORT Make_routing_code(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_routing_code(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_routing_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_porting_dt(SALT33.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_porting_dt(SALT33.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_porting_dt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
EXPORT Make_porting_time(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_porting_time(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_porting_time(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_country_abbr(SALT33.StrType s0) := MakeFT_Invalid_ISO2(s0);
EXPORT InValid_country_abbr(SALT33.StrType s) := InValidFT_Invalid_ISO2(s);
EXPORT InValidMessage_country_abbr(UNSIGNED1 wh) := InValidMessageFT_Invalid_ISO2(wh);
EXPORT Make_vendor_first_reported_dt(SALT33.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_vendor_first_reported_dt(SALT33.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_vendor_first_reported_dt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
EXPORT Make_vendor_first_reported_time(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_vendor_first_reported_time(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_vendor_first_reported_time(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_vendor_last_reported_dt(SALT33.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_vendor_last_reported_dt(SALT33.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_vendor_last_reported_dt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
EXPORT Make_vendor_last_reported_time(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_vendor_last_reported_time(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_vendor_last_reported_time(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_port_start_dt(SALT33.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_port_start_dt(SALT33.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_port_start_dt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
EXPORT Make_port_start_time(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_port_start_time(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_port_start_time(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_port_end_dt(SALT33.StrType s0) := MakeFT_Invalid_Future_Date(s0);
EXPORT InValid_port_end_dt(SALT33.StrType s) := InValidFT_Invalid_Future_Date(s);
EXPORT InValidMessage_port_end_dt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Future_Date(wh);
EXPORT Make_port_end_time(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_port_end_time(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_port_end_time(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_remove_port_dt(SALT33.StrType s0) := MakeFT_Invalid_Future_Date(s0);
EXPORT InValid_remove_port_dt(SALT33.StrType s) := InValidFT_Invalid_Future_Date(s);
EXPORT InValidMessage_remove_port_dt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Future_Date(wh);
EXPORT Make_is_ported(SALT33.StrType s0) := s0;
EXPORT InValid_is_ported(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_is_ported(UNSIGNED1 wh) := '';
EXPORT Make_serv(SALT33.StrType s0) := MakeFT_Invalid_Zero_Three(s0);
EXPORT InValid_serv(SALT33.StrType s) := InValidFT_Invalid_Zero_Three(s);
EXPORT InValidMessage_serv(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zero_Three(wh);
EXPORT Make_line(SALT33.StrType s0) := MakeFT_Invalid_Zero_Three(s0);
EXPORT InValid_line(SALT33.StrType s) := InValidFT_Invalid_Zero_Three(s);
EXPORT InValidMessage_line(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zero_Three(wh);
EXPORT Make_spid(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_spid(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_spid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_operator_fullname(SALT33.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_operator_fullname(SALT33.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_operator_fullname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
EXPORT Make_number_in_service(SALT33.StrType s0) := MakeFT_Invalid_Num_In_Service(s0);
EXPORT InValid_number_in_service(SALT33.StrType s) := InValidFT_Invalid_Num_In_Service(s);
EXPORT InValidMessage_number_in_service(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num_In_Service(wh);
EXPORT Make_high_risk_indicator(SALT33.StrType s0) := MakeFT_Invalid_YN(s0);
EXPORT InValid_high_risk_indicator(SALT33.StrType s) := InValidFT_Invalid_YN(s);
EXPORT InValidMessage_high_risk_indicator(UNSIGNED1 wh) := InValidMessageFT_Invalid_YN(wh);
EXPORT Make_prepaid(SALT33.StrType s0) := MakeFT_Invalid_YN(s0);
EXPORT InValid_prepaid(SALT33.StrType s) := InValidFT_Invalid_YN(s);
EXPORT InValidMessage_prepaid(UNSIGNED1 wh) := InValidMessageFT_Invalid_YN(wh);
EXPORT Make_phone_swap(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_phone_swap(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_phone_swap(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_swap_start_dt(SALT33.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_swap_start_dt(SALT33.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_swap_start_dt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
EXPORT Make_swap_start_time(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_swap_start_time(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_swap_start_time(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_swap_end_dt(SALT33.StrType s0) := MakeFT_Invalid_Future_Date(s0);
EXPORT InValid_swap_end_dt(SALT33.StrType s) := InValidFT_Invalid_Future_Date(s);
EXPORT InValidMessage_swap_end_dt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Future_Date(wh);
EXPORT Make_swap_end_time(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_swap_end_time(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_swap_end_time(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_deact_code(SALT33.StrType s0) := MakeFT_Invalid_Deact(s0);
EXPORT InValid_deact_code(SALT33.StrType s) := InValidFT_Invalid_Deact(s);
EXPORT InValidMessage_deact_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_Deact(wh);
EXPORT Make_deact_start_dt(SALT33.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_deact_start_dt(SALT33.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_deact_start_dt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
EXPORT Make_deact_start_time(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_deact_start_time(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_deact_start_time(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_deact_end_dt(SALT33.StrType s0) := MakeFT_Invalid_Future_Date(s0);
EXPORT InValid_deact_end_dt(SALT33.StrType s) := InValidFT_Invalid_Future_Date(s);
EXPORT InValidMessage_deact_end_dt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Future_Date(wh);
EXPORT Make_deact_end_time(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_deact_end_time(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_deact_end_time(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_react_start_dt(SALT33.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_react_start_dt(SALT33.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_react_start_dt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
EXPORT Make_react_start_time(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_react_start_time(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_react_start_time(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_react_end_dt(SALT33.StrType s0) := MakeFT_Invalid_Future_Date(s0);
EXPORT InValid_react_end_dt(SALT33.StrType s) := InValidFT_Invalid_Future_Date(s);
EXPORT InValidMessage_react_end_dt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Future_Date(wh);
EXPORT Make_react_end_time(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_react_end_time(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_react_end_time(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_is_deact(SALT33.StrType s0) := MakeFT_Invalid_YN(s0);
EXPORT InValid_is_deact(SALT33.StrType s) := InValidFT_Invalid_YN(s);
EXPORT InValidMessage_is_deact(UNSIGNED1 wh) := InValidMessageFT_Invalid_YN(wh);
EXPORT Make_is_react(SALT33.StrType s0) := MakeFT_Invalid_YN(s0);
EXPORT InValid_is_react(SALT33.StrType s) := InValidFT_Invalid_YN(s);
EXPORT InValidMessage_is_react(UNSIGNED1 wh) := InValidMessageFT_Invalid_YN(wh);
EXPORT Make_call_forward_dt(SALT33.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_call_forward_dt(SALT33.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_call_forward_dt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
EXPORT Make_caller_id(SALT33.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_caller_id(SALT33.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_caller_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
EXPORT Make_subpoena_company_name(SALT33.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_subpoena_company_name(SALT33.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_subpoena_company_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
EXPORT Make_subpoena_contact_name(SALT33.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_subpoena_contact_name(SALT33.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_subpoena_contact_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
EXPORT Make_subpoena_carrier_address(SALT33.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_subpoena_carrier_address(SALT33.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_subpoena_carrier_address(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
EXPORT Make_subpoena_carrier_city(SALT33.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_subpoena_carrier_city(SALT33.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_subpoena_carrier_city(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
EXPORT Make_subpoena_carrier_state(SALT33.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_subpoena_carrier_state(SALT33.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_subpoena_carrier_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
EXPORT Make_subpoena_carrier_zip(SALT33.StrType s0) := MakeFT_Invalid_Num_Blank(s0);
EXPORT InValid_subpoena_carrier_zip(SALT33.StrType s) := InValidFT_Invalid_Num_Blank(s);
EXPORT InValidMessage_subpoena_carrier_zip(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num_Blank(wh);
EXPORT Make_subpoena_email(SALT33.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_subpoena_email(SALT33.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_subpoena_email(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
EXPORT Make_subpoena_contact_phone(SALT33.StrType s0) := MakeFT_Invalid_Phone(s0);
EXPORT InValid_subpoena_contact_phone(SALT33.StrType s) := InValidFT_Invalid_Phone(s);
EXPORT InValidMessage_subpoena_contact_phone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone(wh);
EXPORT Make_subpoena_contact_fax(SALT33.StrType s0) := MakeFT_Invalid_Phone(s0);
EXPORT InValid_subpoena_contact_fax(SALT33.StrType s) := InValidFT_Invalid_Phone(s);
EXPORT InValidMessage_subpoena_contact_fax(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone(wh);
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT33,Scrubs_PhonesInfo;
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
    BOOLEAN Diff_reference_id;
    BOOLEAN Diff_source;
    BOOLEAN Diff_dt_first_reported;
    BOOLEAN Diff_dt_last_reported;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_phonetype;
    BOOLEAN Diff_reply_code;
    BOOLEAN Diff_local_routing_number;
    BOOLEAN Diff_account_owner;
    BOOLEAN Diff_carrier_name;
    BOOLEAN Diff_carrier_category;
    BOOLEAN Diff_local_area_transport_area;
    BOOLEAN Diff_point_code;
    BOOLEAN Diff_country_code;
    BOOLEAN Diff_dial_type;
    BOOLEAN Diff_routing_code;
    BOOLEAN Diff_porting_dt;
    BOOLEAN Diff_porting_time;
    BOOLEAN Diff_country_abbr;
    BOOLEAN Diff_vendor_first_reported_dt;
    BOOLEAN Diff_vendor_first_reported_time;
    BOOLEAN Diff_vendor_last_reported_dt;
    BOOLEAN Diff_vendor_last_reported_time;
    BOOLEAN Diff_port_start_dt;
    BOOLEAN Diff_port_start_time;
    BOOLEAN Diff_port_end_dt;
    BOOLEAN Diff_port_end_time;
    BOOLEAN Diff_remove_port_dt;
    BOOLEAN Diff_is_ported;
    BOOLEAN Diff_serv;
    BOOLEAN Diff_line;
    BOOLEAN Diff_spid;
    BOOLEAN Diff_operator_fullname;
    BOOLEAN Diff_number_in_service;
    BOOLEAN Diff_high_risk_indicator;
    BOOLEAN Diff_prepaid;
    BOOLEAN Diff_phone_swap;
    BOOLEAN Diff_swap_start_dt;
    BOOLEAN Diff_swap_start_time;
    BOOLEAN Diff_swap_end_dt;
    BOOLEAN Diff_swap_end_time;
    BOOLEAN Diff_deact_code;
    BOOLEAN Diff_deact_start_dt;
    BOOLEAN Diff_deact_start_time;
    BOOLEAN Diff_deact_end_dt;
    BOOLEAN Diff_deact_end_time;
    BOOLEAN Diff_react_start_dt;
    BOOLEAN Diff_react_start_time;
    BOOLEAN Diff_react_end_dt;
    BOOLEAN Diff_react_end_time;
    BOOLEAN Diff_is_deact;
    BOOLEAN Diff_is_react;
    BOOLEAN Diff_call_forward_dt;
    BOOLEAN Diff_caller_id;
    BOOLEAN Diff_subpoena_company_name;
    BOOLEAN Diff_subpoena_contact_name;
    BOOLEAN Diff_subpoena_carrier_address;
    BOOLEAN Diff_subpoena_carrier_city;
    BOOLEAN Diff_subpoena_carrier_state;
    BOOLEAN Diff_subpoena_carrier_zip;
    BOOLEAN Diff_subpoena_email;
    BOOLEAN Diff_subpoena_contact_phone;
    BOOLEAN Diff_subpoena_contact_fax;
    UNSIGNED Num_Diffs;
    SALT33.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_reference_id := le.reference_id <> ri.reference_id;
    SELF.Diff_source := le.source <> ri.source;
    SELF.Diff_dt_first_reported := le.dt_first_reported <> ri.dt_first_reported;
    SELF.Diff_dt_last_reported := le.dt_last_reported <> ri.dt_last_reported;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_phonetype := le.phonetype <> ri.phonetype;
    SELF.Diff_reply_code := le.reply_code <> ri.reply_code;
    SELF.Diff_local_routing_number := le.local_routing_number <> ri.local_routing_number;
    SELF.Diff_account_owner := le.account_owner <> ri.account_owner;
    SELF.Diff_carrier_name := le.carrier_name <> ri.carrier_name;
    SELF.Diff_carrier_category := le.carrier_category <> ri.carrier_category;
    SELF.Diff_local_area_transport_area := le.local_area_transport_area <> ri.local_area_transport_area;
    SELF.Diff_point_code := le.point_code <> ri.point_code;
    SELF.Diff_country_code := le.country_code <> ri.country_code;
    SELF.Diff_dial_type := le.dial_type <> ri.dial_type;
    SELF.Diff_routing_code := le.routing_code <> ri.routing_code;
    SELF.Diff_porting_dt := le.porting_dt <> ri.porting_dt;
    SELF.Diff_porting_time := le.porting_time <> ri.porting_time;
    SELF.Diff_country_abbr := le.country_abbr <> ri.country_abbr;
    SELF.Diff_vendor_first_reported_dt := le.vendor_first_reported_dt <> ri.vendor_first_reported_dt;
    SELF.Diff_vendor_first_reported_time := le.vendor_first_reported_time <> ri.vendor_first_reported_time;
    SELF.Diff_vendor_last_reported_dt := le.vendor_last_reported_dt <> ri.vendor_last_reported_dt;
    SELF.Diff_vendor_last_reported_time := le.vendor_last_reported_time <> ri.vendor_last_reported_time;
    SELF.Diff_port_start_dt := le.port_start_dt <> ri.port_start_dt;
    SELF.Diff_port_start_time := le.port_start_time <> ri.port_start_time;
    SELF.Diff_port_end_dt := le.port_end_dt <> ri.port_end_dt;
    SELF.Diff_port_end_time := le.port_end_time <> ri.port_end_time;
    SELF.Diff_remove_port_dt := le.remove_port_dt <> ri.remove_port_dt;
    SELF.Diff_is_ported := le.is_ported <> ri.is_ported;
    SELF.Diff_serv := le.serv <> ri.serv;
    SELF.Diff_line := le.line <> ri.line;
    SELF.Diff_spid := le.spid <> ri.spid;
    SELF.Diff_operator_fullname := le.operator_fullname <> ri.operator_fullname;
    SELF.Diff_number_in_service := le.number_in_service <> ri.number_in_service;
    SELF.Diff_high_risk_indicator := le.high_risk_indicator <> ri.high_risk_indicator;
    SELF.Diff_prepaid := le.prepaid <> ri.prepaid;
    SELF.Diff_phone_swap := le.phone_swap <> ri.phone_swap;
    SELF.Diff_swap_start_dt := le.swap_start_dt <> ri.swap_start_dt;
    SELF.Diff_swap_start_time := le.swap_start_time <> ri.swap_start_time;
    SELF.Diff_swap_end_dt := le.swap_end_dt <> ri.swap_end_dt;
    SELF.Diff_swap_end_time := le.swap_end_time <> ri.swap_end_time;
    SELF.Diff_deact_code := le.deact_code <> ri.deact_code;
    SELF.Diff_deact_start_dt := le.deact_start_dt <> ri.deact_start_dt;
    SELF.Diff_deact_start_time := le.deact_start_time <> ri.deact_start_time;
    SELF.Diff_deact_end_dt := le.deact_end_dt <> ri.deact_end_dt;
    SELF.Diff_deact_end_time := le.deact_end_time <> ri.deact_end_time;
    SELF.Diff_react_start_dt := le.react_start_dt <> ri.react_start_dt;
    SELF.Diff_react_start_time := le.react_start_time <> ri.react_start_time;
    SELF.Diff_react_end_dt := le.react_end_dt <> ri.react_end_dt;
    SELF.Diff_react_end_time := le.react_end_time <> ri.react_end_time;
    SELF.Diff_is_deact := le.is_deact <> ri.is_deact;
    SELF.Diff_is_react := le.is_react <> ri.is_react;
    SELF.Diff_call_forward_dt := le.call_forward_dt <> ri.call_forward_dt;
    SELF.Diff_caller_id := le.caller_id <> ri.caller_id;
    SELF.Diff_subpoena_company_name := le.subpoena_company_name <> ri.subpoena_company_name;
    SELF.Diff_subpoena_contact_name := le.subpoena_contact_name <> ri.subpoena_contact_name;
    SELF.Diff_subpoena_carrier_address := le.subpoena_carrier_address <> ri.subpoena_carrier_address;
    SELF.Diff_subpoena_carrier_city := le.subpoena_carrier_city <> ri.subpoena_carrier_city;
    SELF.Diff_subpoena_carrier_state := le.subpoena_carrier_state <> ri.subpoena_carrier_state;
    SELF.Diff_subpoena_carrier_zip := le.subpoena_carrier_zip <> ri.subpoena_carrier_zip;
    SELF.Diff_subpoena_email := le.subpoena_email <> ri.subpoena_email;
    SELF.Diff_subpoena_contact_phone := le.subpoena_contact_phone <> ri.subpoena_contact_phone;
    SELF.Diff_subpoena_contact_fax := le.subpoena_contact_fax <> ri.subpoena_contact_fax;
    SELF.Val := (SALT33.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_reference_id,1,0)+ IF( SELF.Diff_source,1,0)+ IF( SELF.Diff_dt_first_reported,1,0)+ IF( SELF.Diff_dt_last_reported,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_phonetype,1,0)+ IF( SELF.Diff_reply_code,1,0)+ IF( SELF.Diff_local_routing_number,1,0)+ IF( SELF.Diff_account_owner,1,0)+ IF( SELF.Diff_carrier_name,1,0)+ IF( SELF.Diff_carrier_category,1,0)+ IF( SELF.Diff_local_area_transport_area,1,0)+ IF( SELF.Diff_point_code,1,0)+ IF( SELF.Diff_country_code,1,0)+ IF( SELF.Diff_dial_type,1,0)+ IF( SELF.Diff_routing_code,1,0)+ IF( SELF.Diff_porting_dt,1,0)+ IF( SELF.Diff_porting_time,1,0)+ IF( SELF.Diff_country_abbr,1,0)+ IF( SELF.Diff_vendor_first_reported_dt,1,0)+ IF( SELF.Diff_vendor_first_reported_time,1,0)+ IF( SELF.Diff_vendor_last_reported_dt,1,0)+ IF( SELF.Diff_vendor_last_reported_time,1,0)+ IF( SELF.Diff_port_start_dt,1,0)+ IF( SELF.Diff_port_start_time,1,0)+ IF( SELF.Diff_port_end_dt,1,0)+ IF( SELF.Diff_port_end_time,1,0)+ IF( SELF.Diff_remove_port_dt,1,0)+ IF( SELF.Diff_is_ported,1,0)+ IF( SELF.Diff_serv,1,0)+ IF( SELF.Diff_line,1,0)+ IF( SELF.Diff_spid,1,0)+ IF( SELF.Diff_operator_fullname,1,0)+ IF( SELF.Diff_number_in_service,1,0)+ IF( SELF.Diff_high_risk_indicator,1,0)+ IF( SELF.Diff_prepaid,1,0)+ IF( SELF.Diff_phone_swap,1,0)+ IF( SELF.Diff_swap_start_dt,1,0)+ IF( SELF.Diff_swap_start_time,1,0)+ IF( SELF.Diff_swap_end_dt,1,0)+ IF( SELF.Diff_swap_end_time,1,0)+ IF( SELF.Diff_deact_code,1,0)+ IF( SELF.Diff_deact_start_dt,1,0)+ IF( SELF.Diff_deact_start_time,1,0)+ IF( SELF.Diff_deact_end_dt,1,0)+ IF( SELF.Diff_deact_end_time,1,0)+ IF( SELF.Diff_react_start_dt,1,0)+ IF( SELF.Diff_react_start_time,1,0)+ IF( SELF.Diff_react_end_dt,1,0)+ IF( SELF.Diff_react_end_time,1,0)+ IF( SELF.Diff_is_deact,1,0)+ IF( SELF.Diff_is_react,1,0)+ IF( SELF.Diff_call_forward_dt,1,0)+ IF( SELF.Diff_caller_id,1,0)+ IF( SELF.Diff_subpoena_company_name,1,0)+ IF( SELF.Diff_subpoena_contact_name,1,0)+ IF( SELF.Diff_subpoena_carrier_address,1,0)+ IF( SELF.Diff_subpoena_carrier_city,1,0)+ IF( SELF.Diff_subpoena_carrier_state,1,0)+ IF( SELF.Diff_subpoena_carrier_zip,1,0)+ IF( SELF.Diff_subpoena_email,1,0)+ IF( SELF.Diff_subpoena_contact_phone,1,0)+ IF( SELF.Diff_subpoena_contact_fax,1,0);
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
    Count_Diff_reference_id := COUNT(GROUP,%Closest%.Diff_reference_id);
    Count_Diff_source := COUNT(GROUP,%Closest%.Diff_source);
    Count_Diff_dt_first_reported := COUNT(GROUP,%Closest%.Diff_dt_first_reported);
    Count_Diff_dt_last_reported := COUNT(GROUP,%Closest%.Diff_dt_last_reported);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_phonetype := COUNT(GROUP,%Closest%.Diff_phonetype);
    Count_Diff_reply_code := COUNT(GROUP,%Closest%.Diff_reply_code);
    Count_Diff_local_routing_number := COUNT(GROUP,%Closest%.Diff_local_routing_number);
    Count_Diff_account_owner := COUNT(GROUP,%Closest%.Diff_account_owner);
    Count_Diff_carrier_name := COUNT(GROUP,%Closest%.Diff_carrier_name);
    Count_Diff_carrier_category := COUNT(GROUP,%Closest%.Diff_carrier_category);
    Count_Diff_local_area_transport_area := COUNT(GROUP,%Closest%.Diff_local_area_transport_area);
    Count_Diff_point_code := COUNT(GROUP,%Closest%.Diff_point_code);
    Count_Diff_country_code := COUNT(GROUP,%Closest%.Diff_country_code);
    Count_Diff_dial_type := COUNT(GROUP,%Closest%.Diff_dial_type);
    Count_Diff_routing_code := COUNT(GROUP,%Closest%.Diff_routing_code);
    Count_Diff_porting_dt := COUNT(GROUP,%Closest%.Diff_porting_dt);
    Count_Diff_porting_time := COUNT(GROUP,%Closest%.Diff_porting_time);
    Count_Diff_country_abbr := COUNT(GROUP,%Closest%.Diff_country_abbr);
    Count_Diff_vendor_first_reported_dt := COUNT(GROUP,%Closest%.Diff_vendor_first_reported_dt);
    Count_Diff_vendor_first_reported_time := COUNT(GROUP,%Closest%.Diff_vendor_first_reported_time);
    Count_Diff_vendor_last_reported_dt := COUNT(GROUP,%Closest%.Diff_vendor_last_reported_dt);
    Count_Diff_vendor_last_reported_time := COUNT(GROUP,%Closest%.Diff_vendor_last_reported_time);
    Count_Diff_port_start_dt := COUNT(GROUP,%Closest%.Diff_port_start_dt);
    Count_Diff_port_start_time := COUNT(GROUP,%Closest%.Diff_port_start_time);
    Count_Diff_port_end_dt := COUNT(GROUP,%Closest%.Diff_port_end_dt);
    Count_Diff_port_end_time := COUNT(GROUP,%Closest%.Diff_port_end_time);
    Count_Diff_remove_port_dt := COUNT(GROUP,%Closest%.Diff_remove_port_dt);
    Count_Diff_is_ported := COUNT(GROUP,%Closest%.Diff_is_ported);
    Count_Diff_serv := COUNT(GROUP,%Closest%.Diff_serv);
    Count_Diff_line := COUNT(GROUP,%Closest%.Diff_line);
    Count_Diff_spid := COUNT(GROUP,%Closest%.Diff_spid);
    Count_Diff_operator_fullname := COUNT(GROUP,%Closest%.Diff_operator_fullname);
    Count_Diff_number_in_service := COUNT(GROUP,%Closest%.Diff_number_in_service);
    Count_Diff_high_risk_indicator := COUNT(GROUP,%Closest%.Diff_high_risk_indicator);
    Count_Diff_prepaid := COUNT(GROUP,%Closest%.Diff_prepaid);
    Count_Diff_phone_swap := COUNT(GROUP,%Closest%.Diff_phone_swap);
    Count_Diff_swap_start_dt := COUNT(GROUP,%Closest%.Diff_swap_start_dt);
    Count_Diff_swap_start_time := COUNT(GROUP,%Closest%.Diff_swap_start_time);
    Count_Diff_swap_end_dt := COUNT(GROUP,%Closest%.Diff_swap_end_dt);
    Count_Diff_swap_end_time := COUNT(GROUP,%Closest%.Diff_swap_end_time);
    Count_Diff_deact_code := COUNT(GROUP,%Closest%.Diff_deact_code);
    Count_Diff_deact_start_dt := COUNT(GROUP,%Closest%.Diff_deact_start_dt);
    Count_Diff_deact_start_time := COUNT(GROUP,%Closest%.Diff_deact_start_time);
    Count_Diff_deact_end_dt := COUNT(GROUP,%Closest%.Diff_deact_end_dt);
    Count_Diff_deact_end_time := COUNT(GROUP,%Closest%.Diff_deact_end_time);
    Count_Diff_react_start_dt := COUNT(GROUP,%Closest%.Diff_react_start_dt);
    Count_Diff_react_start_time := COUNT(GROUP,%Closest%.Diff_react_start_time);
    Count_Diff_react_end_dt := COUNT(GROUP,%Closest%.Diff_react_end_dt);
    Count_Diff_react_end_time := COUNT(GROUP,%Closest%.Diff_react_end_time);
    Count_Diff_is_deact := COUNT(GROUP,%Closest%.Diff_is_deact);
    Count_Diff_is_react := COUNT(GROUP,%Closest%.Diff_is_react);
    Count_Diff_call_forward_dt := COUNT(GROUP,%Closest%.Diff_call_forward_dt);
    Count_Diff_caller_id := COUNT(GROUP,%Closest%.Diff_caller_id);
    Count_Diff_subpoena_company_name := COUNT(GROUP,%Closest%.Diff_subpoena_company_name);
    Count_Diff_subpoena_contact_name := COUNT(GROUP,%Closest%.Diff_subpoena_contact_name);
    Count_Diff_subpoena_carrier_address := COUNT(GROUP,%Closest%.Diff_subpoena_carrier_address);
    Count_Diff_subpoena_carrier_city := COUNT(GROUP,%Closest%.Diff_subpoena_carrier_city);
    Count_Diff_subpoena_carrier_state := COUNT(GROUP,%Closest%.Diff_subpoena_carrier_state);
    Count_Diff_subpoena_carrier_zip := COUNT(GROUP,%Closest%.Diff_subpoena_carrier_zip);
    Count_Diff_subpoena_email := COUNT(GROUP,%Closest%.Diff_subpoena_email);
    Count_Diff_subpoena_contact_phone := COUNT(GROUP,%Closest%.Diff_subpoena_contact_phone);
    Count_Diff_subpoena_contact_fax := COUNT(GROUP,%Closest%.Diff_subpoena_contact_fax);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
