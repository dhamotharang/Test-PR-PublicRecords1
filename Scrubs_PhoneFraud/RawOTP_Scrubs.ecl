IMPORT SALT36;
IMPORT Scrubs,Scrubs_PhoneFraud; // Import modules for FieldTypes attribute definitions
EXPORT RawOTP_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(RawOTP_Layout_PhoneFraud)
    UNSIGNED1 transaction_id_Invalid;
    UNSIGNED1 event_time_Invalid;
    UNSIGNED1 function_name_Invalid;
    UNSIGNED1 account_id_Invalid;
    UNSIGNED1 subject_id_Invalid;
    UNSIGNED1 customer_subject_id_Invalid;
    UNSIGNED1 otp_id_Invalid;
    UNSIGNED1 otp_delivery_method_Invalid;
    UNSIGNED1 otp_preferred_delivery_Invalid;
    UNSIGNED1 otp_phone_Invalid;
    UNSIGNED1 country_Invalid;
    UNSIGNED1 state_Invalid;
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
    UNSIGNED1 date_added_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(RawOTP_Layout_PhoneFraud)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(RawOTP_Layout_PhoneFraud) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.transaction_id_Invalid := RawOTP_Fields.InValid_transaction_id((SALT36.StrType)le.transaction_id);
    SELF.event_time_Invalid := RawOTP_Fields.InValid_event_time((SALT36.StrType)le.event_time);
    SELF.function_name_Invalid := RawOTP_Fields.InValid_function_name((SALT36.StrType)le.function_name);
    SELF.account_id_Invalid := RawOTP_Fields.InValid_account_id((SALT36.StrType)le.account_id);
    SELF.subject_id_Invalid := RawOTP_Fields.InValid_subject_id((SALT36.StrType)le.subject_id);
    SELF.customer_subject_id_Invalid := RawOTP_Fields.InValid_customer_subject_id((SALT36.StrType)le.customer_subject_id);
    SELF.otp_id_Invalid := RawOTP_Fields.InValid_otp_id((SALT36.StrType)le.otp_id);
    SELF.otp_delivery_method_Invalid := RawOTP_Fields.InValid_otp_delivery_method((SALT36.StrType)le.otp_delivery_method);
    SELF.otp_preferred_delivery_Invalid := RawOTP_Fields.InValid_otp_preferred_delivery((SALT36.StrType)le.otp_preferred_delivery);
    SELF.otp_phone_Invalid := RawOTP_Fields.InValid_otp_phone((SALT36.StrType)le.otp_phone);
    SELF.country_Invalid := RawOTP_Fields.InValid_country((SALT36.StrType)le.country);
    SELF.state_Invalid := RawOTP_Fields.InValid_state((SALT36.StrType)le.state);
    SELF.otp_type_Invalid := RawOTP_Fields.InValid_otp_type((SALT36.StrType)le.otp_type);
    SELF.otp_length_Invalid := RawOTP_Fields.InValid_otp_length((SALT36.StrType)le.otp_length);
    SELF.mobile_phone_Invalid := RawOTP_Fields.InValid_mobile_phone((SALT36.StrType)le.mobile_phone);
    SELF.mobile_phone_country_Invalid := RawOTP_Fields.InValid_mobile_phone_country((SALT36.StrType)le.mobile_phone_country);
    SELF.mobile_phone_carrier_Invalid := RawOTP_Fields.InValid_mobile_phone_carrier((SALT36.StrType)le.mobile_phone_carrier);
    SELF.work_phone_Invalid := RawOTP_Fields.InValid_work_phone((SALT36.StrType)le.work_phone);
    SELF.work_phone_country_Invalid := RawOTP_Fields.InValid_work_phone_country((SALT36.StrType)le.work_phone_country);
    SELF.home_phone_Invalid := RawOTP_Fields.InValid_home_phone((SALT36.StrType)le.home_phone);
    SELF.home_phone_country_Invalid := RawOTP_Fields.InValid_home_phone_country((SALT36.StrType)le.home_phone_country);
    SELF.otp_language_Invalid := RawOTP_Fields.InValid_otp_language((SALT36.StrType)le.otp_language);
    SELF.date_added_Invalid := RawOTP_Fields.InValid_date_added((SALT36.StrType)le.date_added);
    SELF := le;
  END;
  EXPORT ExpandedInfile0 := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),RawOTP_Layout_PhoneFraud);
  EXPORT WithinList1 := DEDUP(SORT(TABLE(Scrubs_PhoneFraud.Lookup_Lists.Function_List,{entry}),entry),ALL) : PERSIST('~temp::Scrubs_PhoneFraud::Scrubs_PhoneFraud.Lookup_Lists.Function_List::entry',EXPIRE(Scrubs_PhoneFraud.Config.PersistExpire));
  EXPORT ExpandedInfile1 := JOIN(ExpandedInfile0, WithinList1, LEFT.function_name=RIGHT.entry AND LEFT.function_name_Invalid=0, TRANSFORM(Expanded_Layout, SELF.function_name_Invalid:=MAP(RIGHT.entry<>''=>0,LEFT.function_name_Invalid>0=>LEFT.function_name_Invalid,1),SELF:=LEFT),LEFT OUTER, SMART);
  EXPORT WithinList2 := DEDUP(SORT(TABLE(Scrubs_PhoneFraud.Lookup_Lists.Carrier_List,{entry}),entry),ALL) : PERSIST('~temp::Scrubs_PhoneFraud::Scrubs_PhoneFraud.Lookup_Lists.Carrier_List::entry',EXPIRE(Scrubs_PhoneFraud.Config.PersistExpire));
  EXPORT ExpandedInfile2 := JOIN(ExpandedInfile1, WithinList2, LEFT.mobile_phone_carrier=RIGHT.entry AND LEFT.mobile_phone_carrier_Invalid=0, TRANSFORM(Expanded_Layout, SELF.mobile_phone_carrier_Invalid:=MAP(RIGHT.entry<>''=>0,LEFT.mobile_phone_carrier_Invalid>0=>LEFT.mobile_phone_carrier_Invalid,1),SELF:=LEFT),LEFT OUTER, SMART);
  EXPORT ExpandedInfile := ExpandedInfile2;
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.transaction_id_Invalid << 0 ) + ( le.event_time_Invalid << 1 ) + ( le.function_name_Invalid << 2 ) + ( le.account_id_Invalid << 3 ) + ( le.subject_id_Invalid << 4 ) + ( le.customer_subject_id_Invalid << 5 ) + ( le.otp_id_Invalid << 6 ) + ( le.otp_delivery_method_Invalid << 7 ) + ( le.otp_preferred_delivery_Invalid << 8 ) + ( le.otp_phone_Invalid << 9 ) + ( le.country_Invalid << 10 ) + ( le.state_Invalid << 11 ) + ( le.otp_type_Invalid << 12 ) + ( le.otp_length_Invalid << 13 ) + ( le.mobile_phone_Invalid << 14 ) + ( le.mobile_phone_country_Invalid << 15 ) + ( le.mobile_phone_carrier_Invalid << 16 ) + ( le.work_phone_Invalid << 17 ) + ( le.work_phone_country_Invalid << 18 ) + ( le.home_phone_Invalid << 19 ) + ( le.home_phone_country_Invalid << 20 ) + ( le.otp_language_Invalid << 21 ) + ( le.date_added_Invalid << 22 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,RawOTP_Layout_PhoneFraud);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.transaction_id_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.event_time_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.function_name_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.account_id_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.subject_id_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.customer_subject_id_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.otp_id_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.otp_delivery_method_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.otp_preferred_delivery_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.otp_phone_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.country_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.otp_type_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.otp_length_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.mobile_phone_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.mobile_phone_country_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.mobile_phone_carrier_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.work_phone_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.work_phone_country_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.home_phone_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.home_phone_country_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.otp_language_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.date_added_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    transaction_id_LENGTH_ErrorCount := COUNT(GROUP,h.transaction_id_Invalid=1);
    event_time_ALLOW_ErrorCount := COUNT(GROUP,h.event_time_Invalid=1);
    function_name_WITHIN_FILE_ErrorCount := COUNT(GROUP,h.function_name_Invalid=1);
    account_id_ALLOW_ErrorCount := COUNT(GROUP,h.account_id_Invalid=1);
    subject_id_ALLOW_ErrorCount := COUNT(GROUP,h.subject_id_Invalid=1);
    customer_subject_id_LENGTH_ErrorCount := COUNT(GROUP,h.customer_subject_id_Invalid=1);
    otp_id_ALLOW_ErrorCount := COUNT(GROUP,h.otp_id_Invalid=1);
    otp_delivery_method_ENUM_ErrorCount := COUNT(GROUP,h.otp_delivery_method_Invalid=1);
    otp_preferred_delivery_ENUM_ErrorCount := COUNT(GROUP,h.otp_preferred_delivery_Invalid=1);
    otp_phone_ALLOW_ErrorCount := COUNT(GROUP,h.otp_phone_Invalid=1);
    country_ALLOW_ErrorCount := COUNT(GROUP,h.country_Invalid=1);
    state_ALLOW_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    otp_type_ALLOW_ErrorCount := COUNT(GROUP,h.otp_type_Invalid=1);
    otp_length_ALLOW_ErrorCount := COUNT(GROUP,h.otp_length_Invalid=1);
    mobile_phone_ALLOW_ErrorCount := COUNT(GROUP,h.mobile_phone_Invalid=1);
    mobile_phone_country_ALLOW_ErrorCount := COUNT(GROUP,h.mobile_phone_country_Invalid=1);
    mobile_phone_carrier_WITHIN_FILE_ErrorCount := COUNT(GROUP,h.mobile_phone_carrier_Invalid=1);
    work_phone_ALLOW_ErrorCount := COUNT(GROUP,h.work_phone_Invalid=1);
    work_phone_country_ALLOW_ErrorCount := COUNT(GROUP,h.work_phone_country_Invalid=1);
    home_phone_ALLOW_ErrorCount := COUNT(GROUP,h.home_phone_Invalid=1);
    home_phone_country_ALLOW_ErrorCount := COUNT(GROUP,h.home_phone_country_Invalid=1);
    otp_language_ENUM_ErrorCount := COUNT(GROUP,h.otp_language_Invalid=1);
    date_added_ALLOW_ErrorCount := COUNT(GROUP,h.date_added_Invalid=1);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.transaction_id_Invalid,le.event_time_Invalid,le.function_name_Invalid,le.account_id_Invalid,le.subject_id_Invalid,le.customer_subject_id_Invalid,le.otp_id_Invalid,le.otp_delivery_method_Invalid,le.otp_preferred_delivery_Invalid,le.otp_phone_Invalid,le.country_Invalid,le.state_Invalid,le.otp_type_Invalid,le.otp_length_Invalid,le.mobile_phone_Invalid,le.mobile_phone_country_Invalid,le.mobile_phone_carrier_Invalid,le.work_phone_Invalid,le.work_phone_country_Invalid,le.home_phone_Invalid,le.home_phone_country_Invalid,le.otp_language_Invalid,le.date_added_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,RawOTP_Fields.InvalidMessage_transaction_id(le.transaction_id_Invalid),RawOTP_Fields.InvalidMessage_event_time(le.event_time_Invalid),RawOTP_Fields.InvalidMessage_function_name(le.function_name_Invalid),RawOTP_Fields.InvalidMessage_account_id(le.account_id_Invalid),RawOTP_Fields.InvalidMessage_subject_id(le.subject_id_Invalid),RawOTP_Fields.InvalidMessage_customer_subject_id(le.customer_subject_id_Invalid),RawOTP_Fields.InvalidMessage_otp_id(le.otp_id_Invalid),RawOTP_Fields.InvalidMessage_otp_delivery_method(le.otp_delivery_method_Invalid),RawOTP_Fields.InvalidMessage_otp_preferred_delivery(le.otp_preferred_delivery_Invalid),RawOTP_Fields.InvalidMessage_otp_phone(le.otp_phone_Invalid),RawOTP_Fields.InvalidMessage_country(le.country_Invalid),RawOTP_Fields.InvalidMessage_state(le.state_Invalid),RawOTP_Fields.InvalidMessage_otp_type(le.otp_type_Invalid),RawOTP_Fields.InvalidMessage_otp_length(le.otp_length_Invalid),RawOTP_Fields.InvalidMessage_mobile_phone(le.mobile_phone_Invalid),RawOTP_Fields.InvalidMessage_mobile_phone_country(le.mobile_phone_country_Invalid),RawOTP_Fields.InvalidMessage_mobile_phone_carrier(le.mobile_phone_carrier_Invalid),RawOTP_Fields.InvalidMessage_work_phone(le.work_phone_Invalid),RawOTP_Fields.InvalidMessage_work_phone_country(le.work_phone_country_Invalid),RawOTP_Fields.InvalidMessage_home_phone(le.home_phone_Invalid),RawOTP_Fields.InvalidMessage_home_phone_country(le.home_phone_country_Invalid),RawOTP_Fields.InvalidMessage_otp_language(le.otp_language_Invalid),RawOTP_Fields.InvalidMessage_date_added(le.date_added_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.transaction_id_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.event_time_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.function_name_Invalid,'WITHIN_FILE','UNKNOWN')
          ,CHOOSE(le.account_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.subject_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.customer_subject_id_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.otp_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.otp_delivery_method_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.otp_preferred_delivery_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.otp_phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.country_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.otp_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.otp_length_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mobile_phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mobile_phone_country_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mobile_phone_carrier_Invalid,'WITHIN_FILE','UNKNOWN')
          ,CHOOSE(le.work_phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.work_phone_country_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.home_phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.home_phone_country_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.otp_language_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.date_added_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'transaction_id','event_time','function_name','account_id','subject_id','customer_subject_id','otp_id','otp_delivery_method','otp_preferred_delivery','otp_phone','country','state','otp_type','otp_length','mobile_phone','mobile_phone_country','mobile_phone_carrier','work_phone','work_phone_country','home_phone','home_phone_country','otp_language','date_added','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Non_Blank','Invalid_Event_Time','Invalid_Function','Invalid_Num_N','Invalid_Num_N','Non_Blank','Invalid_Num_N','Invalid_Delivery','Invalid_Delivery','Invalid_Phone','Invalid_Char','Invalid_Char','Invalid_OTP_Type','Invalid_OTP_Length','Invalid_Phone','Invalid_Char','Invalid_Carrier','Invalid_Num_N','Invalid_Char','Invalid_Phone','Invalid_Char','Invalid_OTP_Language','Invalid_Date_Added','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT36.StrType)le.transaction_id,(SALT36.StrType)le.event_time,(SALT36.StrType)le.function_name,(SALT36.StrType)le.account_id,(SALT36.StrType)le.subject_id,(SALT36.StrType)le.customer_subject_id,(SALT36.StrType)le.otp_id,(SALT36.StrType)le.otp_delivery_method,(SALT36.StrType)le.otp_preferred_delivery,(SALT36.StrType)le.otp_phone,(SALT36.StrType)le.country,(SALT36.StrType)le.state,(SALT36.StrType)le.otp_type,(SALT36.StrType)le.otp_length,(SALT36.StrType)le.mobile_phone,(SALT36.StrType)le.mobile_phone_country,(SALT36.StrType)le.mobile_phone_carrier,(SALT36.StrType)le.work_phone,(SALT36.StrType)le.work_phone_country,(SALT36.StrType)le.home_phone,(SALT36.StrType)le.home_phone_country,(SALT36.StrType)le.otp_language,(SALT36.StrType)le.date_added,'***SALTBUG***');
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
          ,'transaction_id:Non_Blank:LENGTH'
          ,'event_time:Invalid_Event_Time:ALLOW'
          ,'function_name:Invalid_Function:WITHIN_FILE'
          ,'account_id:Invalid_Num_N:ALLOW'
          ,'subject_id:Invalid_Num_N:ALLOW'
          ,'customer_subject_id:Non_Blank:LENGTH'
          ,'otp_id:Invalid_Num_N:ALLOW'
          ,'otp_delivery_method:Invalid_Delivery:ENUM'
          ,'otp_preferred_delivery:Invalid_Delivery:ENUM'
          ,'otp_phone:Invalid_Phone:ALLOW'
          ,'country:Invalid_Char:ALLOW'
          ,'state:Invalid_Char:ALLOW'
          ,'otp_type:Invalid_OTP_Type:ALLOW'
          ,'otp_length:Invalid_OTP_Length:ALLOW'
          ,'mobile_phone:Invalid_Phone:ALLOW'
          ,'mobile_phone_country:Invalid_Char:ALLOW'
          ,'mobile_phone_carrier:Invalid_Carrier:WITHIN_FILE'
          ,'work_phone:Invalid_Num_N:ALLOW'
          ,'work_phone_country:Invalid_Char:ALLOW'
          ,'home_phone:Invalid_Phone:ALLOW'
          ,'home_phone_country:Invalid_Char:ALLOW'
          ,'otp_language:Invalid_OTP_Language:ENUM'
          ,'date_added:Invalid_Date_Added:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,RawOTP_Fields.InvalidMessage_transaction_id(1)
          ,RawOTP_Fields.InvalidMessage_event_time(1)
          ,RawOTP_Fields.InvalidMessage_function_name(1)
          ,RawOTP_Fields.InvalidMessage_account_id(1)
          ,RawOTP_Fields.InvalidMessage_subject_id(1)
          ,RawOTP_Fields.InvalidMessage_customer_subject_id(1)
          ,RawOTP_Fields.InvalidMessage_otp_id(1)
          ,RawOTP_Fields.InvalidMessage_otp_delivery_method(1)
          ,RawOTP_Fields.InvalidMessage_otp_preferred_delivery(1)
          ,RawOTP_Fields.InvalidMessage_otp_phone(1)
          ,RawOTP_Fields.InvalidMessage_country(1)
          ,RawOTP_Fields.InvalidMessage_state(1)
          ,RawOTP_Fields.InvalidMessage_otp_type(1)
          ,RawOTP_Fields.InvalidMessage_otp_length(1)
          ,RawOTP_Fields.InvalidMessage_mobile_phone(1)
          ,RawOTP_Fields.InvalidMessage_mobile_phone_country(1)
          ,RawOTP_Fields.InvalidMessage_mobile_phone_carrier(1)
          ,RawOTP_Fields.InvalidMessage_work_phone(1)
          ,RawOTP_Fields.InvalidMessage_work_phone_country(1)
          ,RawOTP_Fields.InvalidMessage_home_phone(1)
          ,RawOTP_Fields.InvalidMessage_home_phone_country(1)
          ,RawOTP_Fields.InvalidMessage_otp_language(1)
          ,RawOTP_Fields.InvalidMessage_date_added(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.transaction_id_LENGTH_ErrorCount
          ,le.event_time_ALLOW_ErrorCount
          ,le.function_name_WITHIN_FILE_ErrorCount
          ,le.account_id_ALLOW_ErrorCount
          ,le.subject_id_ALLOW_ErrorCount
          ,le.customer_subject_id_LENGTH_ErrorCount
          ,le.otp_id_ALLOW_ErrorCount
          ,le.otp_delivery_method_ENUM_ErrorCount
          ,le.otp_preferred_delivery_ENUM_ErrorCount
          ,le.otp_phone_ALLOW_ErrorCount
          ,le.country_ALLOW_ErrorCount
          ,le.state_ALLOW_ErrorCount
          ,le.otp_type_ALLOW_ErrorCount
          ,le.otp_length_ALLOW_ErrorCount
          ,le.mobile_phone_ALLOW_ErrorCount
          ,le.mobile_phone_country_ALLOW_ErrorCount
          ,le.mobile_phone_carrier_WITHIN_FILE_ErrorCount
          ,le.work_phone_ALLOW_ErrorCount
          ,le.work_phone_country_ALLOW_ErrorCount
          ,le.home_phone_ALLOW_ErrorCount
          ,le.home_phone_country_ALLOW_ErrorCount
          ,le.otp_language_ENUM_ErrorCount
          ,le.date_added_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.transaction_id_LENGTH_ErrorCount
          ,le.event_time_ALLOW_ErrorCount
          ,le.function_name_WITHIN_FILE_ErrorCount
          ,le.account_id_ALLOW_ErrorCount
          ,le.subject_id_ALLOW_ErrorCount
          ,le.customer_subject_id_LENGTH_ErrorCount
          ,le.otp_id_ALLOW_ErrorCount
          ,le.otp_delivery_method_ENUM_ErrorCount
          ,le.otp_preferred_delivery_ENUM_ErrorCount
          ,le.otp_phone_ALLOW_ErrorCount
          ,le.country_ALLOW_ErrorCount
          ,le.state_ALLOW_ErrorCount
          ,le.otp_type_ALLOW_ErrorCount
          ,le.otp_length_ALLOW_ErrorCount
          ,le.mobile_phone_ALLOW_ErrorCount
          ,le.mobile_phone_country_ALLOW_ErrorCount
          ,le.mobile_phone_carrier_WITHIN_FILE_ErrorCount
          ,le.work_phone_ALLOW_ErrorCount
          ,le.work_phone_country_ALLOW_ErrorCount
          ,le.home_phone_ALLOW_ErrorCount
          ,le.home_phone_country_ALLOW_ErrorCount
          ,le.otp_language_ENUM_ErrorCount
          ,le.date_added_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,23,Into(LEFT,COUNTER));
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
