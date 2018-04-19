IMPORT SALT39,STD;
EXPORT InquiryLogs_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 17;
  EXPORT NumRulesFromFieldType := 17;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 17;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(InquiryLogs_Layout_InquiryLogs)
    UNSIGNED1 Customer_Account_Number_Invalid;
    UNSIGNED1 Customer_County_Invalid;
    UNSIGNED1 Customer_State_Invalid;
    UNSIGNED1 Customer_Agency_Vertical_Type_Invalid;
    UNSIGNED1 Customer_Program_Invalid;
    UNSIGNED1 LexID_Invalid;
    UNSIGNED1 raw_Full_Name_Invalid;
    UNSIGNED1 raw_First_name_Invalid;
    UNSIGNED1 raw_Last_Name_Invalid;
    UNSIGNED1 SSN_Invalid;
    UNSIGNED1 Drivers_License_State_Invalid;
    UNSIGNED1 Drivers_License_Number_Invalid;
    UNSIGNED1 Street_1_Invalid;
    UNSIGNED1 City_Invalid;
    UNSIGNED1 State_Invalid;
    UNSIGNED1 Zip_Invalid;
    UNSIGNED1 did_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(InquiryLogs_Layout_InquiryLogs)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(InquiryLogs_Layout_InquiryLogs) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.Customer_Account_Number_Invalid := InquiryLogs_Fields.InValid_Customer_Account_Number((SALT39.StrType)le.Customer_Account_Number);
    SELF.Customer_County_Invalid := InquiryLogs_Fields.InValid_Customer_County((SALT39.StrType)le.Customer_County);
    SELF.Customer_State_Invalid := InquiryLogs_Fields.InValid_Customer_State((SALT39.StrType)le.Customer_State);
    SELF.Customer_Agency_Vertical_Type_Invalid := InquiryLogs_Fields.InValid_Customer_Agency_Vertical_Type((SALT39.StrType)le.Customer_Agency_Vertical_Type);
    SELF.Customer_Program_Invalid := InquiryLogs_Fields.InValid_Customer_Program((SALT39.StrType)le.Customer_Program);
    SELF.LexID_Invalid := InquiryLogs_Fields.InValid_LexID((SALT39.StrType)le.LexID);
    SELF.raw_Full_Name_Invalid := InquiryLogs_Fields.InValid_raw_Full_Name((SALT39.StrType)le.raw_Full_Name);
    SELF.raw_First_name_Invalid := InquiryLogs_Fields.InValid_raw_First_name((SALT39.StrType)le.raw_First_name);
    SELF.raw_Last_Name_Invalid := InquiryLogs_Fields.InValid_raw_Last_Name((SALT39.StrType)le.raw_Last_Name);
    SELF.SSN_Invalid := InquiryLogs_Fields.InValid_SSN((SALT39.StrType)le.SSN);
    SELF.Drivers_License_State_Invalid := InquiryLogs_Fields.InValid_Drivers_License_State((SALT39.StrType)le.Drivers_License_State);
    SELF.Drivers_License_Number_Invalid := InquiryLogs_Fields.InValid_Drivers_License_Number((SALT39.StrType)le.Drivers_License_Number);
    SELF.Street_1_Invalid := InquiryLogs_Fields.InValid_Street_1((SALT39.StrType)le.Street_1);
    SELF.City_Invalid := InquiryLogs_Fields.InValid_City((SALT39.StrType)le.City);
    SELF.State_Invalid := InquiryLogs_Fields.InValid_State((SALT39.StrType)le.State);
    SELF.Zip_Invalid := InquiryLogs_Fields.InValid_Zip((SALT39.StrType)le.Zip);
    SELF.did_Invalid := InquiryLogs_Fields.InValid_did((SALT39.StrType)le.did);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),InquiryLogs_Layout_InquiryLogs);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.Customer_Account_Number_Invalid << 0 ) + ( le.Customer_County_Invalid << 1 ) + ( le.Customer_State_Invalid << 2 ) + ( le.Customer_Agency_Vertical_Type_Invalid << 3 ) + ( le.Customer_Program_Invalid << 4 ) + ( le.LexID_Invalid << 5 ) + ( le.raw_Full_Name_Invalid << 6 ) + ( le.raw_First_name_Invalid << 7 ) + ( le.raw_Last_Name_Invalid << 8 ) + ( le.SSN_Invalid << 9 ) + ( le.Drivers_License_State_Invalid << 10 ) + ( le.Drivers_License_Number_Invalid << 11 ) + ( le.Street_1_Invalid << 12 ) + ( le.City_Invalid << 13 ) + ( le.State_Invalid << 14 ) + ( le.Zip_Invalid << 15 ) + ( le.did_Invalid << 16 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,InquiryLogs_Layout_InquiryLogs);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.Customer_Account_Number_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.Customer_County_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.Customer_State_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.Customer_Agency_Vertical_Type_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.Customer_Program_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.LexID_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.raw_Full_Name_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.raw_First_name_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.raw_Last_Name_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.SSN_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.Drivers_License_State_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.Drivers_License_Number_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.Street_1_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.City_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.State_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.Zip_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.did_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    Customer_Account_Number_ALLOW_ErrorCount := COUNT(GROUP,h.Customer_Account_Number_Invalid=1);
    Customer_County_ALLOW_ErrorCount := COUNT(GROUP,h.Customer_County_Invalid=1);
    Customer_State_ALLOW_ErrorCount := COUNT(GROUP,h.Customer_State_Invalid=1);
    Customer_Agency_Vertical_Type_ALLOW_ErrorCount := COUNT(GROUP,h.Customer_Agency_Vertical_Type_Invalid=1);
    Customer_Program_ALLOW_ErrorCount := COUNT(GROUP,h.Customer_Program_Invalid=1);
    LexID_ALLOW_ErrorCount := COUNT(GROUP,h.LexID_Invalid=1);
    raw_Full_Name_ALLOW_ErrorCount := COUNT(GROUP,h.raw_Full_Name_Invalid=1);
    raw_First_name_ALLOW_ErrorCount := COUNT(GROUP,h.raw_First_name_Invalid=1);
    raw_Last_Name_ALLOW_ErrorCount := COUNT(GROUP,h.raw_Last_Name_Invalid=1);
    SSN_ALLOW_ErrorCount := COUNT(GROUP,h.SSN_Invalid=1);
    Drivers_License_State_ALLOW_ErrorCount := COUNT(GROUP,h.Drivers_License_State_Invalid=1);
    Drivers_License_Number_ALLOW_ErrorCount := COUNT(GROUP,h.Drivers_License_Number_Invalid=1);
    Street_1_ALLOW_ErrorCount := COUNT(GROUP,h.Street_1_Invalid=1);
    City_ALLOW_ErrorCount := COUNT(GROUP,h.City_Invalid=1);
    State_ALLOW_ErrorCount := COUNT(GROUP,h.State_Invalid=1);
    Zip_ALLOW_ErrorCount := COUNT(GROUP,h.Zip_Invalid=1);
    did_ALLOW_ErrorCount := COUNT(GROUP,h.did_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.Customer_Account_Number_Invalid > 0 OR h.Customer_County_Invalid > 0 OR h.Customer_State_Invalid > 0 OR h.Customer_Agency_Vertical_Type_Invalid > 0 OR h.Customer_Program_Invalid > 0 OR h.LexID_Invalid > 0 OR h.raw_Full_Name_Invalid > 0 OR h.raw_First_name_Invalid > 0 OR h.raw_Last_Name_Invalid > 0 OR h.SSN_Invalid > 0 OR h.Drivers_License_State_Invalid > 0 OR h.Drivers_License_Number_Invalid > 0 OR h.Street_1_Invalid > 0 OR h.City_Invalid > 0 OR h.State_Invalid > 0 OR h.Zip_Invalid > 0 OR h.did_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.Customer_Account_Number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Customer_County_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Customer_State_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Customer_Agency_Vertical_Type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Customer_Program_ALLOW_ErrorCount > 0, 1, 0) + IF(le.LexID_ALLOW_ErrorCount > 0, 1, 0) + IF(le.raw_Full_Name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.raw_First_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.raw_Last_Name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.SSN_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Drivers_License_State_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Drivers_License_Number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Street_1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.City_ALLOW_ErrorCount > 0, 1, 0) + IF(le.State_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.did_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.Customer_Account_Number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Customer_County_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Customer_State_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Customer_Agency_Vertical_Type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Customer_Program_ALLOW_ErrorCount > 0, 1, 0) + IF(le.LexID_ALLOW_ErrorCount > 0, 1, 0) + IF(le.raw_Full_Name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.raw_First_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.raw_Last_Name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.SSN_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Drivers_License_State_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Drivers_License_Number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Street_1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.City_ALLOW_ErrorCount > 0, 1, 0) + IF(le.State_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.did_ALLOW_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT39.StrType ErrorMessage;
    SALT39.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.Customer_Account_Number_Invalid,le.Customer_County_Invalid,le.Customer_State_Invalid,le.Customer_Agency_Vertical_Type_Invalid,le.Customer_Program_Invalid,le.LexID_Invalid,le.raw_Full_Name_Invalid,le.raw_First_name_Invalid,le.raw_Last_Name_Invalid,le.SSN_Invalid,le.Drivers_License_State_Invalid,le.Drivers_License_Number_Invalid,le.Street_1_Invalid,le.City_Invalid,le.State_Invalid,le.Zip_Invalid,le.did_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,InquiryLogs_Fields.InvalidMessage_Customer_Account_Number(le.Customer_Account_Number_Invalid),InquiryLogs_Fields.InvalidMessage_Customer_County(le.Customer_County_Invalid),InquiryLogs_Fields.InvalidMessage_Customer_State(le.Customer_State_Invalid),InquiryLogs_Fields.InvalidMessage_Customer_Agency_Vertical_Type(le.Customer_Agency_Vertical_Type_Invalid),InquiryLogs_Fields.InvalidMessage_Customer_Program(le.Customer_Program_Invalid),InquiryLogs_Fields.InvalidMessage_LexID(le.LexID_Invalid),InquiryLogs_Fields.InvalidMessage_raw_Full_Name(le.raw_Full_Name_Invalid),InquiryLogs_Fields.InvalidMessage_raw_First_name(le.raw_First_name_Invalid),InquiryLogs_Fields.InvalidMessage_raw_Last_Name(le.raw_Last_Name_Invalid),InquiryLogs_Fields.InvalidMessage_SSN(le.SSN_Invalid),InquiryLogs_Fields.InvalidMessage_Drivers_License_State(le.Drivers_License_State_Invalid),InquiryLogs_Fields.InvalidMessage_Drivers_License_Number(le.Drivers_License_Number_Invalid),InquiryLogs_Fields.InvalidMessage_Street_1(le.Street_1_Invalid),InquiryLogs_Fields.InvalidMessage_City(le.City_Invalid),InquiryLogs_Fields.InvalidMessage_State(le.State_Invalid),InquiryLogs_Fields.InvalidMessage_Zip(le.Zip_Invalid),InquiryLogs_Fields.InvalidMessage_did(le.did_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.Customer_Account_Number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.Customer_County_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.Customer_State_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.Customer_Agency_Vertical_Type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.Customer_Program_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.LexID_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.raw_Full_Name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.raw_First_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.raw_Last_Name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.SSN_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.Drivers_License_State_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.Drivers_License_Number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.Street_1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.City_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.State_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.Zip_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.did_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'Customer_Account_Number','Customer_County','Customer_State','Customer_Agency_Vertical_Type','Customer_Program','LexID','raw_Full_Name','raw_First_name','raw_Last_Name','SSN','Drivers_License_State','Drivers_License_Number','Street_1','City','State','Zip','did','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_numeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_numeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_numeric','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT39.StrType)le.Customer_Account_Number,(SALT39.StrType)le.Customer_County,(SALT39.StrType)le.Customer_State,(SALT39.StrType)le.Customer_Agency_Vertical_Type,(SALT39.StrType)le.Customer_Program,(SALT39.StrType)le.LexID,(SALT39.StrType)le.raw_Full_Name,(SALT39.StrType)le.raw_First_name,(SALT39.StrType)le.raw_Last_Name,(SALT39.StrType)le.SSN,(SALT39.StrType)le.Drivers_License_State,(SALT39.StrType)le.Drivers_License_Number,(SALT39.StrType)le.Street_1,(SALT39.StrType)le.City,(SALT39.StrType)le.State,(SALT39.StrType)le.Zip,(SALT39.StrType)le.did,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,17,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(InquiryLogs_Layout_InquiryLogs) prevDS = DATASET([], InquiryLogs_Layout_InquiryLogs), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT39.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'Customer_Account_Number:invalid_numeric:ALLOW'
          ,'Customer_County:invalid_alphanumeric:ALLOW'
          ,'Customer_State:invalid_alphanumeric:ALLOW'
          ,'Customer_Agency_Vertical_Type:invalid_alphanumeric:ALLOW'
          ,'Customer_Program:invalid_alphanumeric:ALLOW'
          ,'LexID:invalid_numeric:ALLOW'
          ,'raw_Full_Name:invalid_alphanumeric:ALLOW'
          ,'raw_First_name:invalid_alphanumeric:ALLOW'
          ,'raw_Last_Name:invalid_alphanumeric:ALLOW'
          ,'SSN:invalid_alphanumeric:ALLOW'
          ,'Drivers_License_State:invalid_alphanumeric:ALLOW'
          ,'Drivers_License_Number:invalid_alphanumeric:ALLOW'
          ,'Street_1:invalid_alphanumeric:ALLOW'
          ,'City:invalid_alphanumeric:ALLOW'
          ,'State:invalid_alphanumeric:ALLOW'
          ,'Zip:invalid_alphanumeric:ALLOW'
          ,'did:invalid_numeric:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,InquiryLogs_Fields.InvalidMessage_Customer_Account_Number(1)
          ,InquiryLogs_Fields.InvalidMessage_Customer_County(1)
          ,InquiryLogs_Fields.InvalidMessage_Customer_State(1)
          ,InquiryLogs_Fields.InvalidMessage_Customer_Agency_Vertical_Type(1)
          ,InquiryLogs_Fields.InvalidMessage_Customer_Program(1)
          ,InquiryLogs_Fields.InvalidMessage_LexID(1)
          ,InquiryLogs_Fields.InvalidMessage_raw_Full_Name(1)
          ,InquiryLogs_Fields.InvalidMessage_raw_First_name(1)
          ,InquiryLogs_Fields.InvalidMessage_raw_Last_Name(1)
          ,InquiryLogs_Fields.InvalidMessage_SSN(1)
          ,InquiryLogs_Fields.InvalidMessage_Drivers_License_State(1)
          ,InquiryLogs_Fields.InvalidMessage_Drivers_License_Number(1)
          ,InquiryLogs_Fields.InvalidMessage_Street_1(1)
          ,InquiryLogs_Fields.InvalidMessage_City(1)
          ,InquiryLogs_Fields.InvalidMessage_State(1)
          ,InquiryLogs_Fields.InvalidMessage_Zip(1)
          ,InquiryLogs_Fields.InvalidMessage_did(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.Customer_Account_Number_ALLOW_ErrorCount
          ,le.Customer_County_ALLOW_ErrorCount
          ,le.Customer_State_ALLOW_ErrorCount
          ,le.Customer_Agency_Vertical_Type_ALLOW_ErrorCount
          ,le.Customer_Program_ALLOW_ErrorCount
          ,le.LexID_ALLOW_ErrorCount
          ,le.raw_Full_Name_ALLOW_ErrorCount
          ,le.raw_First_name_ALLOW_ErrorCount
          ,le.raw_Last_Name_ALLOW_ErrorCount
          ,le.SSN_ALLOW_ErrorCount
          ,le.Drivers_License_State_ALLOW_ErrorCount
          ,le.Drivers_License_Number_ALLOW_ErrorCount
          ,le.Street_1_ALLOW_ErrorCount
          ,le.City_ALLOW_ErrorCount
          ,le.State_ALLOW_ErrorCount
          ,le.Zip_ALLOW_ErrorCount
          ,le.did_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.Customer_Account_Number_ALLOW_ErrorCount
          ,le.Customer_County_ALLOW_ErrorCount
          ,le.Customer_State_ALLOW_ErrorCount
          ,le.Customer_Agency_Vertical_Type_ALLOW_ErrorCount
          ,le.Customer_Program_ALLOW_ErrorCount
          ,le.LexID_ALLOW_ErrorCount
          ,le.raw_Full_Name_ALLOW_ErrorCount
          ,le.raw_First_name_ALLOW_ErrorCount
          ,le.raw_Last_Name_ALLOW_ErrorCount
          ,le.SSN_ALLOW_ErrorCount
          ,le.Drivers_License_State_ALLOW_ErrorCount
          ,le.Drivers_License_Number_ALLOW_ErrorCount
          ,le.Street_1_ALLOW_ErrorCount
          ,le.City_ALLOW_ErrorCount
          ,le.State_ALLOW_ErrorCount
          ,le.Zip_ALLOW_ErrorCount
          ,le.did_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_WithErrors/NumFieldsWithRules * 100)
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_NoErrors/NumFieldsWithRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_WithErrors/NumRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_NoErrors/NumRules * 100)
          ,0
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithErrorsCount/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, (SELF.recordstotal - le.AnyRule_WithErrorsCount)/SELF.recordstotal * 100),0));
    END;
    SummaryInfo := NORMALIZE(SummaryStats,NumRules + 7,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT39.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT39.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := InquiryLogs_hygiene(PROJECT(h, InquiryLogs_Layout_InquiryLogs));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT39.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'Customer_Account_Number:' + getFieldTypeText(h.Customer_Account_Number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Customer_County:' + getFieldTypeText(h.Customer_County) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Customer_State:' + getFieldTypeText(h.Customer_State) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Customer_Agency_Vertical_Type:' + getFieldTypeText(h.Customer_Agency_Vertical_Type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Customer_Program:' + getFieldTypeText(h.Customer_Program) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'LexID:' + getFieldTypeText(h.LexID) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'raw_Full_Name:' + getFieldTypeText(h.raw_Full_Name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'raw_First_name:' + getFieldTypeText(h.raw_First_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'raw_Last_Name:' + getFieldTypeText(h.raw_Last_Name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'SSN:' + getFieldTypeText(h.SSN) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Drivers_License_State:' + getFieldTypeText(h.Drivers_License_State) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Drivers_License_Number:' + getFieldTypeText(h.Drivers_License_Number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Street_1:' + getFieldTypeText(h.Street_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'City:' + getFieldTypeText(h.City) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'State:' + getFieldTypeText(h.State) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Zip:' + getFieldTypeText(h.Zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did:' + getFieldTypeText(h.did) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_Customer_Account_Number_cnt
          ,le.populated_Customer_County_cnt
          ,le.populated_Customer_State_cnt
          ,le.populated_Customer_Agency_Vertical_Type_cnt
          ,le.populated_Customer_Program_cnt
          ,le.populated_LexID_cnt
          ,le.populated_raw_Full_Name_cnt
          ,le.populated_raw_First_name_cnt
          ,le.populated_raw_Last_Name_cnt
          ,le.populated_SSN_cnt
          ,le.populated_Drivers_License_State_cnt
          ,le.populated_Drivers_License_Number_cnt
          ,le.populated_Street_1_cnt
          ,le.populated_City_cnt
          ,le.populated_State_cnt
          ,le.populated_Zip_cnt
          ,le.populated_did_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_Customer_Account_Number_pcnt
          ,le.populated_Customer_County_pcnt
          ,le.populated_Customer_State_pcnt
          ,le.populated_Customer_Agency_Vertical_Type_pcnt
          ,le.populated_Customer_Program_pcnt
          ,le.populated_LexID_pcnt
          ,le.populated_raw_Full_Name_pcnt
          ,le.populated_raw_First_name_pcnt
          ,le.populated_raw_Last_Name_pcnt
          ,le.populated_SSN_pcnt
          ,le.populated_Drivers_License_State_pcnt
          ,le.populated_Drivers_License_Number_pcnt
          ,le.populated_Street_1_pcnt
          ,le.populated_City_pcnt
          ,le.populated_State_pcnt
          ,le.populated_Zip_pcnt
          ,le.populated_did_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,17,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT39.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := InquiryLogs_Delta(prevDS, PROJECT(h, InquiryLogs_Layout_InquiryLogs));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),17,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(InquiryLogs_Layout_InquiryLogs) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT39.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_FraudGov, InquiryLogs_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT39.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT39.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
