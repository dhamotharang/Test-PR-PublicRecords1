IMPORT SALT36;
IMPORT Scrubs,Scrubs_PhoneFraud; // Import modules for FieldTypes attribute definitions
EXPORT BaseOTP_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(BaseOTP_Layout_PhoneFraud)
    UNSIGNED1 date_file_loaded_Invalid;
    UNSIGNED1 transaction_id_Invalid;
    UNSIGNED1 event_date_Invalid;
    UNSIGNED1 event_time_Invalid;
    UNSIGNED1 function_name_Invalid;
    UNSIGNED1 account_id_Invalid;
    UNSIGNED1 subject_id_Invalid;
    UNSIGNED1 customer_subject_id_Invalid;
    UNSIGNED1 otp_id_Invalid;
    UNSIGNED1 verify_passed_Invalid;
    UNSIGNED1 otp_delivery_method_Invalid;
    UNSIGNED1 otp_preferred_delivery_Invalid;
    UNSIGNED1 otp_phone_Invalid;
    UNSIGNED1 otp_type_Invalid;
    UNSIGNED1 otp_length_Invalid;
    UNSIGNED1 mobile_phone_Invalid;
    UNSIGNED1 mobile_phone_country_Invalid;
    UNSIGNED1 mobile_phone_carrier_Invalid;
    UNSIGNED1 work_phone_Invalid;
    UNSIGNED1 work_phone_country_Invalid;
    UNSIGNED1 home_phone_Invalid;
    UNSIGNED1 home_phone_country_Invalid;
    UNSIGNED1 otp_language_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(BaseOTP_Layout_PhoneFraud)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(BaseOTP_Layout_PhoneFraud) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.date_file_loaded_Invalid := BaseOTP_Fields.InValid_date_file_loaded((SALT36.StrType)le.date_file_loaded);
    SELF.transaction_id_Invalid := BaseOTP_Fields.InValid_transaction_id((SALT36.StrType)le.transaction_id);
      SELF.transaction_id := IF(SELF.transaction_id_Invalid=0 OR NOT withOnfail, le.transaction_id, SKIP); // ONFAIL(REJECT)
    SELF.event_date_Invalid := BaseOTP_Fields.InValid_event_date((SALT36.StrType)le.event_date);
    SELF.event_time_Invalid := BaseOTP_Fields.InValid_event_time((SALT36.StrType)le.event_time);
    SELF.function_name_Invalid := BaseOTP_Fields.InValid_function_name((SALT36.StrType)le.function_name);
    SELF.account_id_Invalid := BaseOTP_Fields.InValid_account_id((SALT36.StrType)le.account_id);
    SELF.subject_id_Invalid := BaseOTP_Fields.InValid_subject_id((SALT36.StrType)le.subject_id);
    SELF.customer_subject_id_Invalid := BaseOTP_Fields.InValid_customer_subject_id((SALT36.StrType)le.customer_subject_id);
    SELF.otp_id_Invalid := BaseOTP_Fields.InValid_otp_id((SALT36.StrType)le.otp_id);
    SELF.verify_passed_Invalid := BaseOTP_Fields.InValid_verify_passed((SALT36.StrType)le.verify_passed);
    SELF.otp_delivery_method_Invalid := BaseOTP_Fields.InValid_otp_delivery_method((SALT36.StrType)le.otp_delivery_method);
    SELF.otp_preferred_delivery_Invalid := BaseOTP_Fields.InValid_otp_preferred_delivery((SALT36.StrType)le.otp_preferred_delivery);
    SELF.otp_phone_Invalid := BaseOTP_Fields.InValid_otp_phone((SALT36.StrType)le.otp_phone);
    SELF.otp_type_Invalid := BaseOTP_Fields.InValid_otp_type((SALT36.StrType)le.otp_type);
    SELF.otp_length_Invalid := BaseOTP_Fields.InValid_otp_length((SALT36.StrType)le.otp_length);
    SELF.mobile_phone_Invalid := BaseOTP_Fields.InValid_mobile_phone((SALT36.StrType)le.mobile_phone);
    SELF.mobile_phone_country_Invalid := BaseOTP_Fields.InValid_mobile_phone_country((SALT36.StrType)le.mobile_phone_country);
    SELF.mobile_phone_carrier_Invalid := BaseOTP_Fields.InValid_mobile_phone_carrier((SALT36.StrType)le.mobile_phone_carrier);
    SELF.work_phone_Invalid := BaseOTP_Fields.InValid_work_phone((SALT36.StrType)le.work_phone);
    SELF.work_phone_country_Invalid := BaseOTP_Fields.InValid_work_phone_country((SALT36.StrType)le.work_phone_country);
    SELF.home_phone_Invalid := BaseOTP_Fields.InValid_home_phone((SALT36.StrType)le.home_phone);
    SELF.home_phone_country_Invalid := BaseOTP_Fields.InValid_home_phone_country((SALT36.StrType)le.home_phone_country);
    SELF.otp_language_Invalid := BaseOTP_Fields.InValid_otp_language((SALT36.StrType)le.otp_language);
    SELF := le;
  END;
  EXPORT ExpandedInfile0 := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),BaseOTP_Layout_PhoneFraud);
  EXPORT WithinList1 := DEDUP(SORT(TABLE(Scrubs_PhoneFraud.Lookup_Lists.Function_List,{entry}),entry),ALL) : PERSIST('~temp::Scrubs_PhoneFraud::Scrubs_PhoneFraud.Lookup_Lists.Function_List::entry',EXPIRE(Scrubs_PhoneFraud.Config.PersistExpire));
  EXPORT ExpandedInfile1 := JOIN(ExpandedInfile0, WithinList1, LEFT.function_name=RIGHT.entry AND LEFT.function_name_Invalid=0, TRANSFORM(Expanded_Layout, SELF.function_name_Invalid:=MAP(RIGHT.entry<>''=>0,LEFT.function_name_Invalid>0=>LEFT.function_name_Invalid,1),SELF:=LEFT),LEFT OUTER, SMART);
  EXPORT WithinList2 := DEDUP(SORT(TABLE(Scrubs_PhoneFraud.Lookup_Lists.Carrier_List,{entry}),entry),ALL) : PERSIST('~temp::Scrubs_PhoneFraud::Scrubs_PhoneFraud.Lookup_Lists.Carrier_List::entry',EXPIRE(Scrubs_PhoneFraud.Config.PersistExpire));
  EXPORT ExpandedInfile2 := JOIN(ExpandedInfile1, WithinList2, LEFT.mobile_phone_carrier=RIGHT.entry AND LEFT.mobile_phone_carrier_Invalid=0, TRANSFORM(Expanded_Layout, SELF.mobile_phone_carrier_Invalid:=MAP(RIGHT.entry<>''=>0,LEFT.mobile_phone_carrier_Invalid>0=>LEFT.mobile_phone_carrier_Invalid,1),SELF:=LEFT),LEFT OUTER, SMART);
  EXPORT ExpandedInfile := ExpandedInfile2;
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.date_file_loaded_Invalid << 0 ) + ( le.transaction_id_Invalid << 1 ) + ( le.event_date_Invalid << 3 ) + ( le.event_time_Invalid << 4 ) + ( le.function_name_Invalid << 5 ) + ( le.account_id_Invalid << 6 ) + ( le.subject_id_Invalid << 7 ) + ( le.customer_subject_id_Invalid << 8 ) + ( le.otp_id_Invalid << 9 ) + ( le.verify_passed_Invalid << 10 ) + ( le.otp_delivery_method_Invalid << 11 ) + ( le.otp_preferred_delivery_Invalid << 12 ) + ( le.otp_phone_Invalid << 13 ) + ( le.otp_type_Invalid << 14 ) + ( le.otp_length_Invalid << 15 ) + ( le.mobile_phone_Invalid << 16 ) + ( le.mobile_phone_country_Invalid << 18 ) + ( le.mobile_phone_carrier_Invalid << 19 ) + ( le.work_phone_Invalid << 20 ) + ( le.work_phone_country_Invalid << 22 ) + ( le.home_phone_Invalid << 23 ) + ( le.home_phone_country_Invalid << 25 ) + ( le.otp_language_Invalid << 26 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,BaseOTP_Layout_PhoneFraud);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.date_file_loaded_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.transaction_id_Invalid := (le.ScrubsBits1 >> 1) & 3;
    SELF.event_date_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.event_time_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.function_name_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.account_id_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.subject_id_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.customer_subject_id_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.otp_id_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.verify_passed_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.otp_delivery_method_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.otp_preferred_delivery_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.otp_phone_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.otp_type_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.otp_length_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.mobile_phone_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.mobile_phone_country_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.mobile_phone_carrier_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.work_phone_Invalid := (le.ScrubsBits1 >> 20) & 3;
    SELF.work_phone_country_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.home_phone_Invalid := (le.ScrubsBits1 >> 23) & 3;
    SELF.home_phone_country_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.otp_language_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    date_file_loaded_CUSTOM_ErrorCount := COUNT(GROUP,h.date_file_loaded_Invalid=1);
    transaction_id_ALLOW_ErrorCount := COUNT(GROUP,h.transaction_id_Invalid=1);
    transaction_id_LENGTH_ErrorCount := COUNT(GROUP,h.transaction_id_Invalid=2);
    transaction_id_Total_ErrorCount := COUNT(GROUP,h.transaction_id_Invalid>0);
    event_date_CUSTOM_ErrorCount := COUNT(GROUP,h.event_date_Invalid=1);
    event_time_ALLOW_ErrorCount := COUNT(GROUP,h.event_time_Invalid=1);
    function_name_WITHIN_FILE_ErrorCount := COUNT(GROUP,h.function_name_Invalid=1);
    account_id_ALLOW_ErrorCount := COUNT(GROUP,h.account_id_Invalid=1);
    subject_id_ALLOW_ErrorCount := COUNT(GROUP,h.subject_id_Invalid=1);
    customer_subject_id_LENGTH_ErrorCount := COUNT(GROUP,h.customer_subject_id_Invalid=1);
    otp_id_ALLOW_ErrorCount := COUNT(GROUP,h.otp_id_Invalid=1);
    verify_passed_LENGTH_ErrorCount := COUNT(GROUP,h.verify_passed_Invalid=1);
    otp_delivery_method_ENUM_ErrorCount := COUNT(GROUP,h.otp_delivery_method_Invalid=1);
    otp_preferred_delivery_ENUM_ErrorCount := COUNT(GROUP,h.otp_preferred_delivery_Invalid=1);
    otp_phone_ALLOW_ErrorCount := COUNT(GROUP,h.otp_phone_Invalid=1);
    otp_type_ALLOW_ErrorCount := COUNT(GROUP,h.otp_type_Invalid=1);
    otp_length_ALLOW_ErrorCount := COUNT(GROUP,h.otp_length_Invalid=1);
    mobile_phone_ALLOW_ErrorCount := COUNT(GROUP,h.mobile_phone_Invalid=1);
    mobile_phone_LENGTH_ErrorCount := COUNT(GROUP,h.mobile_phone_Invalid=2);
    mobile_phone_Total_ErrorCount := COUNT(GROUP,h.mobile_phone_Invalid>0);
    mobile_phone_country_ALLOW_ErrorCount := COUNT(GROUP,h.mobile_phone_country_Invalid=1);
    mobile_phone_carrier_WITHIN_FILE_ErrorCount := COUNT(GROUP,h.mobile_phone_carrier_Invalid=1);
    work_phone_ALLOW_ErrorCount := COUNT(GROUP,h.work_phone_Invalid=1);
    work_phone_LENGTH_ErrorCount := COUNT(GROUP,h.work_phone_Invalid=2);
    work_phone_Total_ErrorCount := COUNT(GROUP,h.work_phone_Invalid>0);
    work_phone_country_ALLOW_ErrorCount := COUNT(GROUP,h.work_phone_country_Invalid=1);
    home_phone_ALLOW_ErrorCount := COUNT(GROUP,h.home_phone_Invalid=1);
    home_phone_LENGTH_ErrorCount := COUNT(GROUP,h.home_phone_Invalid=2);
    home_phone_Total_ErrorCount := COUNT(GROUP,h.home_phone_Invalid>0);
    home_phone_country_ALLOW_ErrorCount := COUNT(GROUP,h.home_phone_country_Invalid=1);
    otp_language_ENUM_ErrorCount := COUNT(GROUP,h.otp_language_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT36.StrType ErrorMessage;
    SALT36.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.date_file_loaded_Invalid,le.transaction_id_Invalid,le.event_date_Invalid,le.event_time_Invalid,le.function_name_Invalid,le.account_id_Invalid,le.subject_id_Invalid,le.customer_subject_id_Invalid,le.otp_id_Invalid,le.verify_passed_Invalid,le.otp_delivery_method_Invalid,le.otp_preferred_delivery_Invalid,le.otp_phone_Invalid,le.otp_type_Invalid,le.otp_length_Invalid,le.mobile_phone_Invalid,le.mobile_phone_country_Invalid,le.mobile_phone_carrier_Invalid,le.work_phone_Invalid,le.work_phone_country_Invalid,le.home_phone_Invalid,le.home_phone_country_Invalid,le.otp_language_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,BaseOTP_Fields.InvalidMessage_date_file_loaded(le.date_file_loaded_Invalid),BaseOTP_Fields.InvalidMessage_transaction_id(le.transaction_id_Invalid),BaseOTP_Fields.InvalidMessage_event_date(le.event_date_Invalid),BaseOTP_Fields.InvalidMessage_event_time(le.event_time_Invalid),BaseOTP_Fields.InvalidMessage_function_name(le.function_name_Invalid),BaseOTP_Fields.InvalidMessage_account_id(le.account_id_Invalid),BaseOTP_Fields.InvalidMessage_subject_id(le.subject_id_Invalid),BaseOTP_Fields.InvalidMessage_customer_subject_id(le.customer_subject_id_Invalid),BaseOTP_Fields.InvalidMessage_otp_id(le.otp_id_Invalid),BaseOTP_Fields.InvalidMessage_verify_passed(le.verify_passed_Invalid),BaseOTP_Fields.InvalidMessage_otp_delivery_method(le.otp_delivery_method_Invalid),BaseOTP_Fields.InvalidMessage_otp_preferred_delivery(le.otp_preferred_delivery_Invalid),BaseOTP_Fields.InvalidMessage_otp_phone(le.otp_phone_Invalid),BaseOTP_Fields.InvalidMessage_otp_type(le.otp_type_Invalid),BaseOTP_Fields.InvalidMessage_otp_length(le.otp_length_Invalid),BaseOTP_Fields.InvalidMessage_mobile_phone(le.mobile_phone_Invalid),BaseOTP_Fields.InvalidMessage_mobile_phone_country(le.mobile_phone_country_Invalid),BaseOTP_Fields.InvalidMessage_mobile_phone_carrier(le.mobile_phone_carrier_Invalid),BaseOTP_Fields.InvalidMessage_work_phone(le.work_phone_Invalid),BaseOTP_Fields.InvalidMessage_work_phone_country(le.work_phone_country_Invalid),BaseOTP_Fields.InvalidMessage_home_phone(le.home_phone_Invalid),BaseOTP_Fields.InvalidMessage_home_phone_country(le.home_phone_country_Invalid),BaseOTP_Fields.InvalidMessage_otp_language(le.otp_language_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.date_file_loaded_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.transaction_id_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.event_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.event_time_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.function_name_Invalid,'WITHIN_FILE','UNKNOWN')
          ,CHOOSE(le.account_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.subject_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.customer_subject_id_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.otp_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.verify_passed_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.otp_delivery_method_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.otp_preferred_delivery_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.otp_phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.otp_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.otp_length_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mobile_phone_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.mobile_phone_country_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mobile_phone_carrier_Invalid,'WITHIN_FILE','UNKNOWN')
          ,CHOOSE(le.work_phone_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.work_phone_country_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.home_phone_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.home_phone_country_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.otp_language_Invalid,'ENUM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'date_file_loaded','transaction_id','event_date','event_time','function_name','account_id','subject_id','customer_subject_id','otp_id','verify_passed','otp_delivery_method','otp_preferred_delivery','otp_phone','otp_type','otp_length','mobile_phone','mobile_phone_country','mobile_phone_carrier','work_phone','work_phone_country','home_phone','home_phone_country','otp_language','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Date','Invalid_Trans_ID','Invalid_Date','Invalid_Num','Invalid_Function','Invalid_Num','Invalid_Num','Non_Blank','Invalid_Num','Non_Blank','Invalid_Delivery','Invalid_Delivery','Invalid_Num','Invalid_OTP_Type','Invalid_OTP_Length','Invalid_Phone','Invalid_Country','Invalid_Carrier','Invalid_Phone','Invalid_Country','Invalid_Phone','Invalid_Country','Invalid_OTP_Language','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT36.StrType)le.date_file_loaded,(SALT36.StrType)le.transaction_id,(SALT36.StrType)le.event_date,(SALT36.StrType)le.event_time,(SALT36.StrType)le.function_name,(SALT36.StrType)le.account_id,(SALT36.StrType)le.subject_id,(SALT36.StrType)le.customer_subject_id,(SALT36.StrType)le.otp_id,(SALT36.StrType)le.verify_passed,(SALT36.StrType)le.otp_delivery_method,(SALT36.StrType)le.otp_preferred_delivery,(SALT36.StrType)le.otp_phone,(SALT36.StrType)le.otp_type,(SALT36.StrType)le.otp_length,(SALT36.StrType)le.mobile_phone,(SALT36.StrType)le.mobile_phone_country,(SALT36.StrType)le.mobile_phone_carrier,(SALT36.StrType)le.work_phone,(SALT36.StrType)le.work_phone_country,(SALT36.StrType)le.home_phone,(SALT36.StrType)le.home_phone_country,(SALT36.StrType)le.otp_language,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,23,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT36.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'date_file_loaded:Invalid_Date:CUSTOM'
          ,'transaction_id:Invalid_Trans_ID:ALLOW','transaction_id:Invalid_Trans_ID:LENGTH'
          ,'event_date:Invalid_Date:CUSTOM'
          ,'event_time:Invalid_Num:ALLOW'
          ,'function_name:Invalid_Function:WITHIN_FILE'
          ,'account_id:Invalid_Num:ALLOW'
          ,'subject_id:Invalid_Num:ALLOW'
          ,'customer_subject_id:Non_Blank:LENGTH'
          ,'otp_id:Invalid_Num:ALLOW'
          ,'verify_passed:Non_Blank:LENGTH'
          ,'otp_delivery_method:Invalid_Delivery:ENUM'
          ,'otp_preferred_delivery:Invalid_Delivery:ENUM'
          ,'otp_phone:Invalid_Num:ALLOW'
          ,'otp_type:Invalid_OTP_Type:ALLOW'
          ,'otp_length:Invalid_OTP_Length:ALLOW'
          ,'mobile_phone:Invalid_Phone:ALLOW','mobile_phone:Invalid_Phone:LENGTH'
          ,'mobile_phone_country:Invalid_Country:ALLOW'
          ,'mobile_phone_carrier:Invalid_Carrier:WITHIN_FILE'
          ,'work_phone:Invalid_Phone:ALLOW','work_phone:Invalid_Phone:LENGTH'
          ,'work_phone_country:Invalid_Country:ALLOW'
          ,'home_phone:Invalid_Phone:ALLOW','home_phone:Invalid_Phone:LENGTH'
          ,'home_phone_country:Invalid_Country:ALLOW'
          ,'otp_language:Invalid_OTP_Language:ENUM','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,BaseOTP_Fields.InvalidMessage_date_file_loaded(1)
          ,BaseOTP_Fields.InvalidMessage_transaction_id(1),BaseOTP_Fields.InvalidMessage_transaction_id(2)
          ,BaseOTP_Fields.InvalidMessage_event_date(1)
          ,BaseOTP_Fields.InvalidMessage_event_time(1)
          ,BaseOTP_Fields.InvalidMessage_function_name(1)
          ,BaseOTP_Fields.InvalidMessage_account_id(1)
          ,BaseOTP_Fields.InvalidMessage_subject_id(1)
          ,BaseOTP_Fields.InvalidMessage_customer_subject_id(1)
          ,BaseOTP_Fields.InvalidMessage_otp_id(1)
          ,BaseOTP_Fields.InvalidMessage_verify_passed(1)
          ,BaseOTP_Fields.InvalidMessage_otp_delivery_method(1)
          ,BaseOTP_Fields.InvalidMessage_otp_preferred_delivery(1)
          ,BaseOTP_Fields.InvalidMessage_otp_phone(1)
          ,BaseOTP_Fields.InvalidMessage_otp_type(1)
          ,BaseOTP_Fields.InvalidMessage_otp_length(1)
          ,BaseOTP_Fields.InvalidMessage_mobile_phone(1),BaseOTP_Fields.InvalidMessage_mobile_phone(2)
          ,BaseOTP_Fields.InvalidMessage_mobile_phone_country(1)
          ,BaseOTP_Fields.InvalidMessage_mobile_phone_carrier(1)
          ,BaseOTP_Fields.InvalidMessage_work_phone(1),BaseOTP_Fields.InvalidMessage_work_phone(2)
          ,BaseOTP_Fields.InvalidMessage_work_phone_country(1)
          ,BaseOTP_Fields.InvalidMessage_home_phone(1),BaseOTP_Fields.InvalidMessage_home_phone(2)
          ,BaseOTP_Fields.InvalidMessage_home_phone_country(1)
          ,BaseOTP_Fields.InvalidMessage_otp_language(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.date_file_loaded_CUSTOM_ErrorCount
          ,le.transaction_id_ALLOW_ErrorCount,le.transaction_id_LENGTH_ErrorCount
          ,le.event_date_CUSTOM_ErrorCount
          ,le.event_time_ALLOW_ErrorCount
          ,le.function_name_WITHIN_FILE_ErrorCount
          ,le.account_id_ALLOW_ErrorCount
          ,le.subject_id_ALLOW_ErrorCount
          ,le.customer_subject_id_LENGTH_ErrorCount
          ,le.otp_id_ALLOW_ErrorCount
          ,le.verify_passed_LENGTH_ErrorCount
          ,le.otp_delivery_method_ENUM_ErrorCount
          ,le.otp_preferred_delivery_ENUM_ErrorCount
          ,le.otp_phone_ALLOW_ErrorCount
          ,le.otp_type_ALLOW_ErrorCount
          ,le.otp_length_ALLOW_ErrorCount
          ,le.mobile_phone_ALLOW_ErrorCount,le.mobile_phone_LENGTH_ErrorCount
          ,le.mobile_phone_country_ALLOW_ErrorCount
          ,le.mobile_phone_carrier_WITHIN_FILE_ErrorCount
          ,le.work_phone_ALLOW_ErrorCount,le.work_phone_LENGTH_ErrorCount
          ,le.work_phone_country_ALLOW_ErrorCount
          ,le.home_phone_ALLOW_ErrorCount,le.home_phone_LENGTH_ErrorCount
          ,le.home_phone_country_ALLOW_ErrorCount
          ,le.otp_language_ENUM_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.date_file_loaded_CUSTOM_ErrorCount
          ,le.transaction_id_ALLOW_ErrorCount,le.transaction_id_LENGTH_ErrorCount
          ,le.event_date_CUSTOM_ErrorCount
          ,le.event_time_ALLOW_ErrorCount
          ,le.function_name_WITHIN_FILE_ErrorCount
          ,le.account_id_ALLOW_ErrorCount
          ,le.subject_id_ALLOW_ErrorCount
          ,le.customer_subject_id_LENGTH_ErrorCount
          ,le.otp_id_ALLOW_ErrorCount
          ,le.verify_passed_LENGTH_ErrorCount
          ,le.otp_delivery_method_ENUM_ErrorCount
          ,le.otp_preferred_delivery_ENUM_ErrorCount
          ,le.otp_phone_ALLOW_ErrorCount
          ,le.otp_type_ALLOW_ErrorCount
          ,le.otp_length_ALLOW_ErrorCount
          ,le.mobile_phone_ALLOW_ErrorCount,le.mobile_phone_LENGTH_ErrorCount
          ,le.mobile_phone_country_ALLOW_ErrorCount
          ,le.mobile_phone_carrier_WITHIN_FILE_ErrorCount
          ,le.work_phone_ALLOW_ErrorCount,le.work_phone_LENGTH_ErrorCount
          ,le.work_phone_country_ALLOW_ErrorCount
          ,le.home_phone_ALLOW_ErrorCount,le.home_phone_LENGTH_ErrorCount
          ,le.home_phone_country_ALLOW_ErrorCount
          ,le.otp_language_ENUM_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,27,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT36.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT36.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
