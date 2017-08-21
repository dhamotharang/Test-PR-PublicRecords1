IMPORT ut,SALT32;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Input_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Input_Layout_DEA)
    UNSIGNED1 dea_registration_number_Invalid;
    UNSIGNED1 business_activity_code_Invalid;
    UNSIGNED1 drug_schedules_Invalid;
    UNSIGNED1 expiration_date_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 zip_code_Invalid;
    UNSIGNED1 bus_activity_sub_code_Invalid;
    UNSIGNED1 exp_of_payment_indicator_Invalid;
    UNSIGNED1 activity_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Input_Layout_DEA)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Input_Layout_DEA) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.dea_registration_number_Invalid := Input_Fields.InValid_dea_registration_number((SALT32.StrType)le.dea_registration_number);
    SELF.business_activity_code_Invalid := Input_Fields.InValid_business_activity_code((SALT32.StrType)le.business_activity_code);
    SELF.drug_schedules_Invalid := Input_Fields.InValid_drug_schedules((SALT32.StrType)le.drug_schedules);
    SELF.expiration_date_Invalid := Input_Fields.InValid_expiration_date((SALT32.StrType)le.expiration_date);
    SELF.state_Invalid := Input_Fields.InValid_state((SALT32.StrType)le.state);
    SELF.zip_code_Invalid := Input_Fields.InValid_zip_code((SALT32.StrType)le.zip_code);
    SELF.bus_activity_sub_code_Invalid := Input_Fields.InValid_bus_activity_sub_code((SALT32.StrType)le.bus_activity_sub_code);
    SELF.exp_of_payment_indicator_Invalid := Input_Fields.InValid_exp_of_payment_indicator((SALT32.StrType)le.exp_of_payment_indicator);
    SELF.activity_Invalid := Input_Fields.InValid_activity((SALT32.StrType)le.activity);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Input_Layout_DEA);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.dea_registration_number_Invalid << 0 ) + ( le.business_activity_code_Invalid << 1 ) + ( le.drug_schedules_Invalid << 2 ) + ( le.expiration_date_Invalid << 3 ) + ( le.state_Invalid << 5 ) + ( le.zip_code_Invalid << 6 ) + ( le.bus_activity_sub_code_Invalid << 7 ) + ( le.exp_of_payment_indicator_Invalid << 8 ) + ( le.activity_Invalid << 9 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Input_Layout_DEA);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.dea_registration_number_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.business_activity_code_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.drug_schedules_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.expiration_date_Invalid := (le.ScrubsBits1 >> 3) & 3;
    SELF.state_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.zip_code_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.bus_activity_sub_code_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.exp_of_payment_indicator_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.activity_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    dea_registration_number_ALLOW_ErrorCount := COUNT(GROUP,h.dea_registration_number_Invalid=1);
    business_activity_code_ALLOW_ErrorCount := COUNT(GROUP,h.business_activity_code_Invalid=1);
    drug_schedules_ALLOW_ErrorCount := COUNT(GROUP,h.drug_schedules_Invalid=1);
    expiration_date_ALLOW_ErrorCount := COUNT(GROUP,h.expiration_date_Invalid=1);
    expiration_date_CUSTOM_ErrorCount := COUNT(GROUP,h.expiration_date_Invalid=2);
    expiration_date_Total_ErrorCount := COUNT(GROUP,h.expiration_date_Invalid>0);
    state_ALLOW_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    zip_code_ALLOW_ErrorCount := COUNT(GROUP,h.zip_code_Invalid=1);
    bus_activity_sub_code_ALLOW_ErrorCount := COUNT(GROUP,h.bus_activity_sub_code_Invalid=1);
    exp_of_payment_indicator_ENUM_ErrorCount := COUNT(GROUP,h.exp_of_payment_indicator_Invalid=1);
    activity_CAPS_ErrorCount := COUNT(GROUP,h.activity_Invalid=1);
    activity_ENUM_ErrorCount := COUNT(GROUP,h.activity_Invalid=2);
    activity_Total_ErrorCount := COUNT(GROUP,h.activity_Invalid>0);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT32.StrType ErrorMessage;
    SALT32.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.dea_registration_number_Invalid,le.business_activity_code_Invalid,le.drug_schedules_Invalid,le.expiration_date_Invalid,le.state_Invalid,le.zip_code_Invalid,le.bus_activity_sub_code_Invalid,le.exp_of_payment_indicator_Invalid,le.activity_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Input_Fields.InvalidMessage_dea_registration_number(le.dea_registration_number_Invalid),Input_Fields.InvalidMessage_business_activity_code(le.business_activity_code_Invalid),Input_Fields.InvalidMessage_drug_schedules(le.drug_schedules_Invalid),Input_Fields.InvalidMessage_expiration_date(le.expiration_date_Invalid),Input_Fields.InvalidMessage_state(le.state_Invalid),Input_Fields.InvalidMessage_zip_code(le.zip_code_Invalid),Input_Fields.InvalidMessage_bus_activity_sub_code(le.bus_activity_sub_code_Invalid),Input_Fields.InvalidMessage_exp_of_payment_indicator(le.exp_of_payment_indicator_Invalid),Input_Fields.InvalidMessage_activity(le.activity_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.dea_registration_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.business_activity_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.drug_schedules_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.expiration_date_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.bus_activity_sub_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.exp_of_payment_indicator_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.activity_Invalid,'CAPS','ENUM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'dea_registration_number','business_activity_code','drug_schedules','expiration_date','state','zip_code','bus_activity_sub_code','exp_of_payment_indicator','activity','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_alphanumeric','invalid_alpha','invalid_drug_schedules','invalid_date','invalid_alpha','invalid_numeric','invalid_alphanumeric','invalid_exp_of_payment_indicator','invalid_activity','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT32.StrType)le.dea_registration_number,(SALT32.StrType)le.business_activity_code,(SALT32.StrType)le.drug_schedules,(SALT32.StrType)le.expiration_date,(SALT32.StrType)le.state,(SALT32.StrType)le.zip_code,(SALT32.StrType)le.bus_activity_sub_code,(SALT32.StrType)le.exp_of_payment_indicator,(SALT32.StrType)le.activity,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,9,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT32.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'dea_registration_number:invalid_alphanumeric:ALLOW'
          ,'business_activity_code:invalid_alpha:ALLOW'
          ,'drug_schedules:invalid_drug_schedules:ALLOW'
          ,'expiration_date:invalid_date:ALLOW','expiration_date:invalid_date:CUSTOM'
          ,'state:invalid_alpha:ALLOW'
          ,'zip_code:invalid_numeric:ALLOW'
          ,'bus_activity_sub_code:invalid_alphanumeric:ALLOW'
          ,'exp_of_payment_indicator:invalid_exp_of_payment_indicator:ENUM'
          ,'activity:invalid_activity:CAPS','activity:invalid_activity:ENUM','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Input_Fields.InvalidMessage_dea_registration_number(1)
          ,Input_Fields.InvalidMessage_business_activity_code(1)
          ,Input_Fields.InvalidMessage_drug_schedules(1)
          ,Input_Fields.InvalidMessage_expiration_date(1),Input_Fields.InvalidMessage_expiration_date(2)
          ,Input_Fields.InvalidMessage_state(1)
          ,Input_Fields.InvalidMessage_zip_code(1)
          ,Input_Fields.InvalidMessage_bus_activity_sub_code(1)
          ,Input_Fields.InvalidMessage_exp_of_payment_indicator(1)
          ,Input_Fields.InvalidMessage_activity(1),Input_Fields.InvalidMessage_activity(2),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.dea_registration_number_ALLOW_ErrorCount
          ,le.business_activity_code_ALLOW_ErrorCount
          ,le.drug_schedules_ALLOW_ErrorCount
          ,le.expiration_date_ALLOW_ErrorCount,le.expiration_date_CUSTOM_ErrorCount
          ,le.state_ALLOW_ErrorCount
          ,le.zip_code_ALLOW_ErrorCount
          ,le.bus_activity_sub_code_ALLOW_ErrorCount
          ,le.exp_of_payment_indicator_ENUM_ErrorCount
          ,le.activity_CAPS_ErrorCount,le.activity_ENUM_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.dea_registration_number_ALLOW_ErrorCount
          ,le.business_activity_code_ALLOW_ErrorCount
          ,le.drug_schedules_ALLOW_ErrorCount
          ,le.expiration_date_ALLOW_ErrorCount,le.expiration_date_CUSTOM_ErrorCount
          ,le.state_ALLOW_ErrorCount
          ,le.zip_code_ALLOW_ErrorCount
          ,le.bus_activity_sub_code_ALLOW_ErrorCount
          ,le.exp_of_payment_indicator_ENUM_ErrorCount
          ,le.activity_CAPS_ErrorCount,le.activity_ENUM_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,11,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT32.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT32.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
