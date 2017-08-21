IMPORT SALT36;
IMPORT Scrubs,Scrubs_PhoneFraud; // Import modules for FieldTypes attribute definitions
EXPORT RawOTP_Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT36.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Date','Invalid_Event_Time','Invalid_Num_N','Invalid_Carrier','Invalid_Phone','Invalid_Date_Added','Invalid_Char','Invalid_Function','Non_Blank','Invalid_Delivery','Invalid_OTP_Length','Invalid_OTP_Type','Invalid_OTP_Language');
EXPORT FieldTypeNum(SALT36.StrType fn) := CASE(fn,'Invalid_Date' => 1,'Invalid_Event_Time' => 2,'Invalid_Num_N' => 3,'Invalid_Carrier' => 4,'Invalid_Phone' => 5,'Invalid_Date_Added' => 6,'Invalid_Char' => 7,'Invalid_Function' => 8,'Non_Blank' => 9,'Invalid_Delivery' => 10,'Invalid_OTP_Length' => 11,'Invalid_OTP_Type' => 12,'Invalid_OTP_Language' => 13,0);
 
EXPORT MakeFT_Invalid_Date(SALT36.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT36.StrType s) := WHICH(~Scrubs.fn_valid_date(s)>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Event_Time(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,'0123456789:/- '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Event_Time(SALT36.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,'0123456789:/- '))));
EXPORT InValidMessageFT_Invalid_Event_Time(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotInChars('0123456789:/- '),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Num_N(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,'0123456789\\\\N-\\()null'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num_N(SALT36.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,'0123456789\\\\N-\\()null'))));
EXPORT InValidMessageFT_Invalid_Num_N(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotInChars('0123456789\\\\N-\\()null'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Carrier(SALT36.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Carrier(SALT36.StrType s) := WHICH();
EXPORT InValidMessageFT_Invalid_Carrier(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotWithinFile('Scrubs_PhoneFraud.Lookup_Lists.Carrier_List'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Phone(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,'0123456789() \\\\N-\\()null'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Phone(SALT36.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,'0123456789() \\\\N-\\()null'))));
EXPORT InValidMessageFT_Invalid_Phone(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotInChars('0123456789() \\\\N-\\()null'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Date_Added(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,'0123456789-: '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Date_Added(SALT36.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,'0123456789-: '))));
EXPORT InValidMessageFT_Invalid_Date_Added(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotInChars('0123456789-: '),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Char(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz \\\\N\\()null'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Char(SALT36.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz \\\\N\\()null'))));
EXPORT InValidMessageFT_Invalid_Char(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz \\\\N\\()null'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Function(SALT36.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Function(SALT36.StrType s) := WHICH();
EXPORT InValidMessageFT_Invalid_Function(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotWithinFile('Scrubs_PhoneFraud.Lookup_Lists.Function_List'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_Non_Blank(SALT36.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Non_Blank(SALT36.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_Non_Blank(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotLength('1..'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Delivery(SALT36.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Delivery(SALT36.StrType s) := WHICH(((SALT36.StrType) s) NOT IN ['T','\\N','2','M','E','3','N','6','H','W','5','4','F','']);
EXPORT InValidMessageFT_Invalid_Delivery(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotInEnum('T|\\N|2|M|E|3|N|6|H|W|5|4|F|'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_OTP_Length(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,'-0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_OTP_Length(SALT36.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,'-0123456789'))));
EXPORT InValidMessageFT_Invalid_OTP_Length(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotInChars('-0123456789'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_OTP_Type(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,'\\\\NMA6 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_OTP_Type(SALT36.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,'\\\\NMA6 '))));
EXPORT InValidMessageFT_Invalid_OTP_Type(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotInChars('\\\\NMA6 '),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_OTP_Language(SALT36.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_OTP_Language(SALT36.StrType s) := WHICH(((SALT36.StrType) s) NOT IN ['\\N','en','es','fr','zh','ru','EN','ES','FR','ZH','RU','']);
EXPORT InValidMessageFT_Invalid_OTP_Language(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotInEnum('\\N|en|es|fr|zh|ru|EN|ES|FR|ZH|RU|'),SALT36.HygieneErrors.Good);
 
EXPORT SALT36.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'transaction_id','event_time','function_name','account_id','subject_id','customer_subject_id','otp_id','verify_passed','otp_delivery_method','otp_preferred_delivery','otp_phone','otp_email','reference_code','product_id','sub_product_id','subject_unique_id','first_name','last_name','country','state','otp_type','otp_length','mobile_phone','mobile_phone_country','mobile_phone_carrier','work_phone','work_phone_country','home_phone','home_phone_country','otp_language','date_added');
EXPORT FieldNum(SALT36.StrType fn) := CASE(fn,'transaction_id' => 0,'event_time' => 1,'function_name' => 2,'account_id' => 3,'subject_id' => 4,'customer_subject_id' => 5,'otp_id' => 6,'verify_passed' => 7,'otp_delivery_method' => 8,'otp_preferred_delivery' => 9,'otp_phone' => 10,'otp_email' => 11,'reference_code' => 12,'product_id' => 13,'sub_product_id' => 14,'subject_unique_id' => 15,'first_name' => 16,'last_name' => 17,'country' => 18,'state' => 19,'otp_type' => 20,'otp_length' => 21,'mobile_phone' => 22,'mobile_phone_country' => 23,'mobile_phone_carrier' => 24,'work_phone' => 25,'work_phone_country' => 26,'home_phone' => 27,'home_phone_country' => 28,'otp_language' => 29,'date_added' => 30,0);
 
//Individual field level validation
 
EXPORT Make_transaction_id(SALT36.StrType s0) := MakeFT_Non_Blank(s0);
EXPORT InValid_transaction_id(SALT36.StrType s) := InValidFT_Non_Blank(s);
EXPORT InValidMessage_transaction_id(UNSIGNED1 wh) := InValidMessageFT_Non_Blank(wh);
 
EXPORT Make_event_time(SALT36.StrType s0) := MakeFT_Invalid_Event_Time(s0);
EXPORT InValid_event_time(SALT36.StrType s) := InValidFT_Invalid_Event_Time(s);
EXPORT InValidMessage_event_time(UNSIGNED1 wh) := InValidMessageFT_Invalid_Event_Time(wh);
 
EXPORT Make_function_name(SALT36.StrType s0) := MakeFT_Invalid_Function(s0);
EXPORT InValid_function_name(SALT36.StrType s) := InValidFT_Invalid_Function(s);
EXPORT InValidMessage_function_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_Function(wh);
 
EXPORT Make_account_id(SALT36.StrType s0) := MakeFT_Invalid_Num_N(s0);
EXPORT InValid_account_id(SALT36.StrType s) := InValidFT_Invalid_Num_N(s);
EXPORT InValidMessage_account_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num_N(wh);
 
EXPORT Make_subject_id(SALT36.StrType s0) := MakeFT_Invalid_Num_N(s0);
EXPORT InValid_subject_id(SALT36.StrType s) := InValidFT_Invalid_Num_N(s);
EXPORT InValidMessage_subject_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num_N(wh);
 
EXPORT Make_customer_subject_id(SALT36.StrType s0) := MakeFT_Non_Blank(s0);
EXPORT InValid_customer_subject_id(SALT36.StrType s) := InValidFT_Non_Blank(s);
EXPORT InValidMessage_customer_subject_id(UNSIGNED1 wh) := InValidMessageFT_Non_Blank(wh);
 
EXPORT Make_otp_id(SALT36.StrType s0) := MakeFT_Invalid_Num_N(s0);
EXPORT InValid_otp_id(SALT36.StrType s) := InValidFT_Invalid_Num_N(s);
EXPORT InValidMessage_otp_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num_N(wh);
 
EXPORT Make_verify_passed(SALT36.StrType s0) := s0;
EXPORT InValid_verify_passed(SALT36.StrType s) := 0;
EXPORT InValidMessage_verify_passed(UNSIGNED1 wh) := '';
 
EXPORT Make_otp_delivery_method(SALT36.StrType s0) := MakeFT_Invalid_Delivery(s0);
EXPORT InValid_otp_delivery_method(SALT36.StrType s) := InValidFT_Invalid_Delivery(s);
EXPORT InValidMessage_otp_delivery_method(UNSIGNED1 wh) := InValidMessageFT_Invalid_Delivery(wh);
 
EXPORT Make_otp_preferred_delivery(SALT36.StrType s0) := MakeFT_Invalid_Delivery(s0);
EXPORT InValid_otp_preferred_delivery(SALT36.StrType s) := InValidFT_Invalid_Delivery(s);
EXPORT InValidMessage_otp_preferred_delivery(UNSIGNED1 wh) := InValidMessageFT_Invalid_Delivery(wh);
 
EXPORT Make_otp_phone(SALT36.StrType s0) := MakeFT_Invalid_Phone(s0);
EXPORT InValid_otp_phone(SALT36.StrType s) := InValidFT_Invalid_Phone(s);
EXPORT InValidMessage_otp_phone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone(wh);
 
EXPORT Make_otp_email(SALT36.StrType s0) := s0;
EXPORT InValid_otp_email(SALT36.StrType s) := 0;
EXPORT InValidMessage_otp_email(UNSIGNED1 wh) := '';
 
EXPORT Make_reference_code(SALT36.StrType s0) := s0;
EXPORT InValid_reference_code(SALT36.StrType s) := 0;
EXPORT InValidMessage_reference_code(UNSIGNED1 wh) := '';
 
EXPORT Make_product_id(SALT36.StrType s0) := s0;
EXPORT InValid_product_id(SALT36.StrType s) := 0;
EXPORT InValidMessage_product_id(UNSIGNED1 wh) := '';
 
EXPORT Make_sub_product_id(SALT36.StrType s0) := s0;
EXPORT InValid_sub_product_id(SALT36.StrType s) := 0;
EXPORT InValidMessage_sub_product_id(UNSIGNED1 wh) := '';
 
EXPORT Make_subject_unique_id(SALT36.StrType s0) := s0;
EXPORT InValid_subject_unique_id(SALT36.StrType s) := 0;
EXPORT InValidMessage_subject_unique_id(UNSIGNED1 wh) := '';
 
EXPORT Make_first_name(SALT36.StrType s0) := s0;
EXPORT InValid_first_name(SALT36.StrType s) := 0;
EXPORT InValidMessage_first_name(UNSIGNED1 wh) := '';
 
EXPORT Make_last_name(SALT36.StrType s0) := s0;
EXPORT InValid_last_name(SALT36.StrType s) := 0;
EXPORT InValidMessage_last_name(UNSIGNED1 wh) := '';
 
EXPORT Make_country(SALT36.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_country(SALT36.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_country(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_state(SALT36.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_state(SALT36.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_otp_type(SALT36.StrType s0) := MakeFT_Invalid_OTP_Type(s0);
EXPORT InValid_otp_type(SALT36.StrType s) := InValidFT_Invalid_OTP_Type(s);
EXPORT InValidMessage_otp_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_OTP_Type(wh);
 
EXPORT Make_otp_length(SALT36.StrType s0) := MakeFT_Invalid_OTP_Length(s0);
EXPORT InValid_otp_length(SALT36.StrType s) := InValidFT_Invalid_OTP_Length(s);
EXPORT InValidMessage_otp_length(UNSIGNED1 wh) := InValidMessageFT_Invalid_OTP_Length(wh);
 
EXPORT Make_mobile_phone(SALT36.StrType s0) := MakeFT_Invalid_Phone(s0);
EXPORT InValid_mobile_phone(SALT36.StrType s) := InValidFT_Invalid_Phone(s);
EXPORT InValidMessage_mobile_phone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone(wh);
 
EXPORT Make_mobile_phone_country(SALT36.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_mobile_phone_country(SALT36.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_mobile_phone_country(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_mobile_phone_carrier(SALT36.StrType s0) := MakeFT_Invalid_Carrier(s0);
EXPORT InValid_mobile_phone_carrier(SALT36.StrType s) := InValidFT_Invalid_Carrier(s);
EXPORT InValidMessage_mobile_phone_carrier(UNSIGNED1 wh) := InValidMessageFT_Invalid_Carrier(wh);
 
EXPORT Make_work_phone(SALT36.StrType s0) := MakeFT_Invalid_Num_N(s0);
EXPORT InValid_work_phone(SALT36.StrType s) := InValidFT_Invalid_Num_N(s);
EXPORT InValidMessage_work_phone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num_N(wh);
 
EXPORT Make_work_phone_country(SALT36.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_work_phone_country(SALT36.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_work_phone_country(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_home_phone(SALT36.StrType s0) := MakeFT_Invalid_Phone(s0);
EXPORT InValid_home_phone(SALT36.StrType s) := InValidFT_Invalid_Phone(s);
EXPORT InValidMessage_home_phone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone(wh);
 
EXPORT Make_home_phone_country(SALT36.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_home_phone_country(SALT36.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_home_phone_country(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_otp_language(SALT36.StrType s0) := MakeFT_Invalid_OTP_Language(s0);
EXPORT InValid_otp_language(SALT36.StrType s) := InValidFT_Invalid_OTP_Language(s);
EXPORT InValidMessage_otp_language(UNSIGNED1 wh) := InValidMessageFT_Invalid_OTP_Language(wh);
 
EXPORT Make_date_added(SALT36.StrType s0) := MakeFT_Invalid_Date_Added(s0);
EXPORT InValid_date_added(SALT36.StrType s) := InValidFT_Invalid_Date_Added(s);
EXPORT InValidMessage_date_added(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date_Added(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT36,Scrubs_PhoneFraud;
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
    BOOLEAN Diff_event_time;
    BOOLEAN Diff_function_name;
    BOOLEAN Diff_account_id;
    BOOLEAN Diff_subject_id;
    BOOLEAN Diff_customer_subject_id;
    BOOLEAN Diff_otp_id;
    BOOLEAN Diff_verify_passed;
    BOOLEAN Diff_otp_delivery_method;
    BOOLEAN Diff_otp_preferred_delivery;
    BOOLEAN Diff_otp_phone;
    BOOLEAN Diff_otp_email;
    BOOLEAN Diff_reference_code;
    BOOLEAN Diff_product_id;
    BOOLEAN Diff_sub_product_id;
    BOOLEAN Diff_subject_unique_id;
    BOOLEAN Diff_first_name;
    BOOLEAN Diff_last_name;
    BOOLEAN Diff_country;
    BOOLEAN Diff_state;
    BOOLEAN Diff_otp_type;
    BOOLEAN Diff_otp_length;
    BOOLEAN Diff_mobile_phone;
    BOOLEAN Diff_mobile_phone_country;
    BOOLEAN Diff_mobile_phone_carrier;
    BOOLEAN Diff_work_phone;
    BOOLEAN Diff_work_phone_country;
    BOOLEAN Diff_home_phone;
    BOOLEAN Diff_home_phone_country;
    BOOLEAN Diff_otp_language;
    BOOLEAN Diff_date_added;
    UNSIGNED Num_Diffs;
    SALT36.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_transaction_id := le.transaction_id <> ri.transaction_id;
    SELF.Diff_event_time := le.event_time <> ri.event_time;
    SELF.Diff_function_name := le.function_name <> ri.function_name;
    SELF.Diff_account_id := le.account_id <> ri.account_id;
    SELF.Diff_subject_id := le.subject_id <> ri.subject_id;
    SELF.Diff_customer_subject_id := le.customer_subject_id <> ri.customer_subject_id;
    SELF.Diff_otp_id := le.otp_id <> ri.otp_id;
    SELF.Diff_verify_passed := le.verify_passed <> ri.verify_passed;
    SELF.Diff_otp_delivery_method := le.otp_delivery_method <> ri.otp_delivery_method;
    SELF.Diff_otp_preferred_delivery := le.otp_preferred_delivery <> ri.otp_preferred_delivery;
    SELF.Diff_otp_phone := le.otp_phone <> ri.otp_phone;
    SELF.Diff_otp_email := le.otp_email <> ri.otp_email;
    SELF.Diff_reference_code := le.reference_code <> ri.reference_code;
    SELF.Diff_product_id := le.product_id <> ri.product_id;
    SELF.Diff_sub_product_id := le.sub_product_id <> ri.sub_product_id;
    SELF.Diff_subject_unique_id := le.subject_unique_id <> ri.subject_unique_id;
    SELF.Diff_first_name := le.first_name <> ri.first_name;
    SELF.Diff_last_name := le.last_name <> ri.last_name;
    SELF.Diff_country := le.country <> ri.country;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_otp_type := le.otp_type <> ri.otp_type;
    SELF.Diff_otp_length := le.otp_length <> ri.otp_length;
    SELF.Diff_mobile_phone := le.mobile_phone <> ri.mobile_phone;
    SELF.Diff_mobile_phone_country := le.mobile_phone_country <> ri.mobile_phone_country;
    SELF.Diff_mobile_phone_carrier := le.mobile_phone_carrier <> ri.mobile_phone_carrier;
    SELF.Diff_work_phone := le.work_phone <> ri.work_phone;
    SELF.Diff_work_phone_country := le.work_phone_country <> ri.work_phone_country;
    SELF.Diff_home_phone := le.home_phone <> ri.home_phone;
    SELF.Diff_home_phone_country := le.home_phone_country <> ri.home_phone_country;
    SELF.Diff_otp_language := le.otp_language <> ri.otp_language;
    SELF.Diff_date_added := le.date_added <> ri.date_added;
    SELF.Val := (SALT36.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_transaction_id,1,0)+ IF( SELF.Diff_event_time,1,0)+ IF( SELF.Diff_function_name,1,0)+ IF( SELF.Diff_account_id,1,0)+ IF( SELF.Diff_subject_id,1,0)+ IF( SELF.Diff_customer_subject_id,1,0)+ IF( SELF.Diff_otp_id,1,0)+ IF( SELF.Diff_verify_passed,1,0)+ IF( SELF.Diff_otp_delivery_method,1,0)+ IF( SELF.Diff_otp_preferred_delivery,1,0)+ IF( SELF.Diff_otp_phone,1,0)+ IF( SELF.Diff_otp_email,1,0)+ IF( SELF.Diff_reference_code,1,0)+ IF( SELF.Diff_product_id,1,0)+ IF( SELF.Diff_sub_product_id,1,0)+ IF( SELF.Diff_subject_unique_id,1,0)+ IF( SELF.Diff_first_name,1,0)+ IF( SELF.Diff_last_name,1,0)+ IF( SELF.Diff_country,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_otp_type,1,0)+ IF( SELF.Diff_otp_length,1,0)+ IF( SELF.Diff_mobile_phone,1,0)+ IF( SELF.Diff_mobile_phone_country,1,0)+ IF( SELF.Diff_mobile_phone_carrier,1,0)+ IF( SELF.Diff_work_phone,1,0)+ IF( SELF.Diff_work_phone_country,1,0)+ IF( SELF.Diff_home_phone,1,0)+ IF( SELF.Diff_home_phone_country,1,0)+ IF( SELF.Diff_otp_language,1,0)+ IF( SELF.Diff_date_added,1,0);
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
    Count_Diff_event_time := COUNT(GROUP,%Closest%.Diff_event_time);
    Count_Diff_function_name := COUNT(GROUP,%Closest%.Diff_function_name);
    Count_Diff_account_id := COUNT(GROUP,%Closest%.Diff_account_id);
    Count_Diff_subject_id := COUNT(GROUP,%Closest%.Diff_subject_id);
    Count_Diff_customer_subject_id := COUNT(GROUP,%Closest%.Diff_customer_subject_id);
    Count_Diff_otp_id := COUNT(GROUP,%Closest%.Diff_otp_id);
    Count_Diff_verify_passed := COUNT(GROUP,%Closest%.Diff_verify_passed);
    Count_Diff_otp_delivery_method := COUNT(GROUP,%Closest%.Diff_otp_delivery_method);
    Count_Diff_otp_preferred_delivery := COUNT(GROUP,%Closest%.Diff_otp_preferred_delivery);
    Count_Diff_otp_phone := COUNT(GROUP,%Closest%.Diff_otp_phone);
    Count_Diff_otp_email := COUNT(GROUP,%Closest%.Diff_otp_email);
    Count_Diff_reference_code := COUNT(GROUP,%Closest%.Diff_reference_code);
    Count_Diff_product_id := COUNT(GROUP,%Closest%.Diff_product_id);
    Count_Diff_sub_product_id := COUNT(GROUP,%Closest%.Diff_sub_product_id);
    Count_Diff_subject_unique_id := COUNT(GROUP,%Closest%.Diff_subject_unique_id);
    Count_Diff_first_name := COUNT(GROUP,%Closest%.Diff_first_name);
    Count_Diff_last_name := COUNT(GROUP,%Closest%.Diff_last_name);
    Count_Diff_country := COUNT(GROUP,%Closest%.Diff_country);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_otp_type := COUNT(GROUP,%Closest%.Diff_otp_type);
    Count_Diff_otp_length := COUNT(GROUP,%Closest%.Diff_otp_length);
    Count_Diff_mobile_phone := COUNT(GROUP,%Closest%.Diff_mobile_phone);
    Count_Diff_mobile_phone_country := COUNT(GROUP,%Closest%.Diff_mobile_phone_country);
    Count_Diff_mobile_phone_carrier := COUNT(GROUP,%Closest%.Diff_mobile_phone_carrier);
    Count_Diff_work_phone := COUNT(GROUP,%Closest%.Diff_work_phone);
    Count_Diff_work_phone_country := COUNT(GROUP,%Closest%.Diff_work_phone_country);
    Count_Diff_home_phone := COUNT(GROUP,%Closest%.Diff_home_phone);
    Count_Diff_home_phone_country := COUNT(GROUP,%Closest%.Diff_home_phone_country);
    Count_Diff_otp_language := COUNT(GROUP,%Closest%.Diff_otp_language);
    Count_Diff_date_added := COUNT(GROUP,%Closest%.Diff_date_added);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
