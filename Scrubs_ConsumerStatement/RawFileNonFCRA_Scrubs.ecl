IMPORT SALT38,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT RawFileNonFCRA_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 20;
  EXPORT NumRulesFromFieldType := 20;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 19;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(RawFileNonFCRA_Layout_ConsumerStatement)
    UNSIGNED1 statement_id_Invalid;
    UNSIGNED1 orig_fname_Invalid;
    UNSIGNED1 orig_lname_Invalid;
    UNSIGNED1 orig_mname_Invalid;
    UNSIGNED1 orig_cname_Invalid;
    UNSIGNED1 orig_st_Invalid;
    UNSIGNED1 orig_zip_Invalid;
    UNSIGNED1 orig_zip4_Invalid;
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 fname_Invalid;
    UNSIGNED1 mname_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 st_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 zip4_Invalid;
    UNSIGNED1 date_submitted_Invalid;
    UNSIGNED1 date_created_Invalid;
    UNSIGNED1 did_Invalid;
    UNSIGNED1 override_flag_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(RawFileNonFCRA_Layout_ConsumerStatement)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(RawFileNonFCRA_Layout_ConsumerStatement) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.statement_id_Invalid := RawFileNonFCRA_Fields.InValid_statement_id((SALT38.StrType)le.statement_id);
    SELF.orig_fname_Invalid := RawFileNonFCRA_Fields.InValid_orig_fname((SALT38.StrType)le.orig_fname);
    SELF.orig_lname_Invalid := RawFileNonFCRA_Fields.InValid_orig_lname((SALT38.StrType)le.orig_lname);
    SELF.orig_mname_Invalid := RawFileNonFCRA_Fields.InValid_orig_mname((SALT38.StrType)le.orig_mname);
    SELF.orig_cname_Invalid := RawFileNonFCRA_Fields.InValid_orig_cname((SALT38.StrType)le.orig_cname);
    SELF.orig_st_Invalid := RawFileNonFCRA_Fields.InValid_orig_st((SALT38.StrType)le.orig_st);
    SELF.orig_zip_Invalid := RawFileNonFCRA_Fields.InValid_orig_zip((SALT38.StrType)le.orig_zip);
    SELF.orig_zip4_Invalid := RawFileNonFCRA_Fields.InValid_orig_zip4((SALT38.StrType)le.orig_zip4);
    SELF.phone_Invalid := RawFileNonFCRA_Fields.InValid_phone((SALT38.StrType)le.phone);
    SELF.fname_Invalid := RawFileNonFCRA_Fields.InValid_fname((SALT38.StrType)le.fname);
    SELF.mname_Invalid := RawFileNonFCRA_Fields.InValid_mname((SALT38.StrType)le.mname);
    SELF.lname_Invalid := RawFileNonFCRA_Fields.InValid_lname((SALT38.StrType)le.lname);
    SELF.st_Invalid := RawFileNonFCRA_Fields.InValid_st((SALT38.StrType)le.st);
    SELF.zip_Invalid := RawFileNonFCRA_Fields.InValid_zip((SALT38.StrType)le.zip);
    SELF.zip4_Invalid := RawFileNonFCRA_Fields.InValid_zip4((SALT38.StrType)le.zip4);
    SELF.date_submitted_Invalid := RawFileNonFCRA_Fields.InValid_date_submitted((SALT38.StrType)le.date_submitted);
    SELF.date_created_Invalid := RawFileNonFCRA_Fields.InValid_date_created((SALT38.StrType)le.date_created);
    SELF.did_Invalid := RawFileNonFCRA_Fields.InValid_did((SALT38.StrType)le.did);
    SELF.override_flag_Invalid := RawFileNonFCRA_Fields.InValid_override_flag((SALT38.StrType)le.override_flag);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),RawFileNonFCRA_Layout_ConsumerStatement);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.statement_id_Invalid << 0 ) + ( le.orig_fname_Invalid << 1 ) + ( le.orig_lname_Invalid << 2 ) + ( le.orig_mname_Invalid << 3 ) + ( le.orig_cname_Invalid << 4 ) + ( le.orig_st_Invalid << 5 ) + ( le.orig_zip_Invalid << 6 ) + ( le.orig_zip4_Invalid << 7 ) + ( le.phone_Invalid << 8 ) + ( le.fname_Invalid << 10 ) + ( le.mname_Invalid << 11 ) + ( le.lname_Invalid << 12 ) + ( le.st_Invalid << 13 ) + ( le.zip_Invalid << 14 ) + ( le.zip4_Invalid << 15 ) + ( le.date_submitted_Invalid << 16 ) + ( le.date_created_Invalid << 17 ) + ( le.did_Invalid << 18 ) + ( le.override_flag_Invalid << 19 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,RawFileNonFCRA_Layout_ConsumerStatement);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.statement_id_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.orig_fname_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.orig_lname_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.orig_mname_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.orig_cname_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.orig_st_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.orig_zip_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.orig_zip4_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.phone_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.fname_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.mname_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.lname_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.st_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.zip4_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.date_submitted_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.date_created_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.did_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.override_flag_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    statement_id_ALLOW_ErrorCount := COUNT(GROUP,h.statement_id_Invalid=1);
    orig_fname_ALLOW_ErrorCount := COUNT(GROUP,h.orig_fname_Invalid=1);
    orig_lname_ALLOW_ErrorCount := COUNT(GROUP,h.orig_lname_Invalid=1);
    orig_mname_ALLOW_ErrorCount := COUNT(GROUP,h.orig_mname_Invalid=1);
    orig_cname_ALLOW_ErrorCount := COUNT(GROUP,h.orig_cname_Invalid=1);
    orig_st_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_st_Invalid=1);
    orig_zip_ALLOW_ErrorCount := COUNT(GROUP,h.orig_zip_Invalid=1);
    orig_zip4_ALLOW_ErrorCount := COUNT(GROUP,h.orig_zip4_Invalid=1);
    phone_ALLOW_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    phone_LENGTH_ErrorCount := COUNT(GROUP,h.phone_Invalid=2);
    phone_Total_ErrorCount := COUNT(GROUP,h.phone_Invalid>0);
    fname_ALLOW_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    mname_ALLOW_ErrorCount := COUNT(GROUP,h.mname_Invalid=1);
    lname_ALLOW_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    st_CUSTOM_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip4_ALLOW_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    date_submitted_ALLOW_ErrorCount := COUNT(GROUP,h.date_submitted_Invalid=1);
    date_created_ALLOW_ErrorCount := COUNT(GROUP,h.date_created_Invalid=1);
    did_ALLOW_ErrorCount := COUNT(GROUP,h.did_Invalid=1);
    override_flag_ALLOW_ErrorCount := COUNT(GROUP,h.override_flag_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.statement_id_Invalid > 0 OR h.orig_fname_Invalid > 0 OR h.orig_lname_Invalid > 0 OR h.orig_mname_Invalid > 0 OR h.orig_cname_Invalid > 0 OR h.orig_st_Invalid > 0 OR h.orig_zip_Invalid > 0 OR h.orig_zip4_Invalid > 0 OR h.phone_Invalid > 0 OR h.fname_Invalid > 0 OR h.mname_Invalid > 0 OR h.lname_Invalid > 0 OR h.st_Invalid > 0 OR h.zip_Invalid > 0 OR h.zip4_Invalid > 0 OR h.date_submitted_Invalid > 0 OR h.date_created_Invalid > 0 OR h.did_Invalid > 0 OR h.override_flag_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.statement_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_cname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_st_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_Total_ErrorCount > 0, 1, 0) + IF(le.fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.st_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_submitted_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_created_ALLOW_ErrorCount > 0, 1, 0) + IF(le.did_ALLOW_ErrorCount > 0, 1, 0) + IF(le.override_flag_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.statement_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_cname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_st_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_LENGTH_ErrorCount > 0, 1, 0) + IF(le.fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.st_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_submitted_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_created_ALLOW_ErrorCount > 0, 1, 0) + IF(le.did_ALLOW_ErrorCount > 0, 1, 0) + IF(le.override_flag_ALLOW_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT38.StrType ErrorMessage;
    SALT38.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.statement_id_Invalid,le.orig_fname_Invalid,le.orig_lname_Invalid,le.orig_mname_Invalid,le.orig_cname_Invalid,le.orig_st_Invalid,le.orig_zip_Invalid,le.orig_zip4_Invalid,le.phone_Invalid,le.fname_Invalid,le.mname_Invalid,le.lname_Invalid,le.st_Invalid,le.zip_Invalid,le.zip4_Invalid,le.date_submitted_Invalid,le.date_created_Invalid,le.did_Invalid,le.override_flag_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,RawFileNonFCRA_Fields.InvalidMessage_statement_id(le.statement_id_Invalid),RawFileNonFCRA_Fields.InvalidMessage_orig_fname(le.orig_fname_Invalid),RawFileNonFCRA_Fields.InvalidMessage_orig_lname(le.orig_lname_Invalid),RawFileNonFCRA_Fields.InvalidMessage_orig_mname(le.orig_mname_Invalid),RawFileNonFCRA_Fields.InvalidMessage_orig_cname(le.orig_cname_Invalid),RawFileNonFCRA_Fields.InvalidMessage_orig_st(le.orig_st_Invalid),RawFileNonFCRA_Fields.InvalidMessage_orig_zip(le.orig_zip_Invalid),RawFileNonFCRA_Fields.InvalidMessage_orig_zip4(le.orig_zip4_Invalid),RawFileNonFCRA_Fields.InvalidMessage_phone(le.phone_Invalid),RawFileNonFCRA_Fields.InvalidMessage_fname(le.fname_Invalid),RawFileNonFCRA_Fields.InvalidMessage_mname(le.mname_Invalid),RawFileNonFCRA_Fields.InvalidMessage_lname(le.lname_Invalid),RawFileNonFCRA_Fields.InvalidMessage_st(le.st_Invalid),RawFileNonFCRA_Fields.InvalidMessage_zip(le.zip_Invalid),RawFileNonFCRA_Fields.InvalidMessage_zip4(le.zip4_Invalid),RawFileNonFCRA_Fields.InvalidMessage_date_submitted(le.date_submitted_Invalid),RawFileNonFCRA_Fields.InvalidMessage_date_created(le.date_created_Invalid),RawFileNonFCRA_Fields.InvalidMessage_did(le.did_Invalid),RawFileNonFCRA_Fields.InvalidMessage_override_flag(le.override_flag_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.statement_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_fname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_lname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_mname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_cname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_st_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_zip_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_zip4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.st_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.date_submitted_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.date_created_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.did_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.override_flag_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'statement_id','orig_fname','orig_lname','orig_mname','orig_cname','orig_st','orig_zip','orig_zip4','phone','fname','mname','lname','st','zip','zip4','date_submitted','date_created','did','override_flag','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Number','Invalid_Name','Invalid_Name','Invalid_Name','Invalid_Name','Invalid_State','Invalid_Number','Invalid_Number','Invalid_Phone','Invalid_Name','Invalid_Name','Invalid_Name','Invalid_State','Invalid_Number','Invalid_Number','Invalid_Date','Invalid_Date','Invalid_Number','Invalid_Number','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT38.StrType)le.statement_id,(SALT38.StrType)le.orig_fname,(SALT38.StrType)le.orig_lname,(SALT38.StrType)le.orig_mname,(SALT38.StrType)le.orig_cname,(SALT38.StrType)le.orig_st,(SALT38.StrType)le.orig_zip,(SALT38.StrType)le.orig_zip4,(SALT38.StrType)le.phone,(SALT38.StrType)le.fname,(SALT38.StrType)le.mname,(SALT38.StrType)le.lname,(SALT38.StrType)le.st,(SALT38.StrType)le.zip,(SALT38.StrType)le.zip4,(SALT38.StrType)le.date_submitted,(SALT38.StrType)le.date_created,(SALT38.StrType)le.did,(SALT38.StrType)le.override_flag,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,19,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(RawFileNonFCRA_Layout_ConsumerStatement) prevDS = DATASET([], RawFileNonFCRA_Layout_ConsumerStatement), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT38.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'statement_id:Invalid_Number:ALLOW'
          ,'orig_fname:Invalid_Name:ALLOW'
          ,'orig_lname:Invalid_Name:ALLOW'
          ,'orig_mname:Invalid_Name:ALLOW'
          ,'orig_cname:Invalid_Name:ALLOW'
          ,'orig_st:Invalid_State:CUSTOM'
          ,'orig_zip:Invalid_Number:ALLOW'
          ,'orig_zip4:Invalid_Number:ALLOW'
          ,'phone:Invalid_Phone:ALLOW','phone:Invalid_Phone:LENGTH'
          ,'fname:Invalid_Name:ALLOW'
          ,'mname:Invalid_Name:ALLOW'
          ,'lname:Invalid_Name:ALLOW'
          ,'st:Invalid_State:CUSTOM'
          ,'zip:Invalid_Number:ALLOW'
          ,'zip4:Invalid_Number:ALLOW'
          ,'date_submitted:Invalid_Date:ALLOW'
          ,'date_created:Invalid_Date:ALLOW'
          ,'did:Invalid_Number:ALLOW'
          ,'override_flag:Invalid_Number:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,RawFileNonFCRA_Fields.InvalidMessage_statement_id(1)
          ,RawFileNonFCRA_Fields.InvalidMessage_orig_fname(1)
          ,RawFileNonFCRA_Fields.InvalidMessage_orig_lname(1)
          ,RawFileNonFCRA_Fields.InvalidMessage_orig_mname(1)
          ,RawFileNonFCRA_Fields.InvalidMessage_orig_cname(1)
          ,RawFileNonFCRA_Fields.InvalidMessage_orig_st(1)
          ,RawFileNonFCRA_Fields.InvalidMessage_orig_zip(1)
          ,RawFileNonFCRA_Fields.InvalidMessage_orig_zip4(1)
          ,RawFileNonFCRA_Fields.InvalidMessage_phone(1),RawFileNonFCRA_Fields.InvalidMessage_phone(2)
          ,RawFileNonFCRA_Fields.InvalidMessage_fname(1)
          ,RawFileNonFCRA_Fields.InvalidMessage_mname(1)
          ,RawFileNonFCRA_Fields.InvalidMessage_lname(1)
          ,RawFileNonFCRA_Fields.InvalidMessage_st(1)
          ,RawFileNonFCRA_Fields.InvalidMessage_zip(1)
          ,RawFileNonFCRA_Fields.InvalidMessage_zip4(1)
          ,RawFileNonFCRA_Fields.InvalidMessage_date_submitted(1)
          ,RawFileNonFCRA_Fields.InvalidMessage_date_created(1)
          ,RawFileNonFCRA_Fields.InvalidMessage_did(1)
          ,RawFileNonFCRA_Fields.InvalidMessage_override_flag(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.statement_id_ALLOW_ErrorCount
          ,le.orig_fname_ALLOW_ErrorCount
          ,le.orig_lname_ALLOW_ErrorCount
          ,le.orig_mname_ALLOW_ErrorCount
          ,le.orig_cname_ALLOW_ErrorCount
          ,le.orig_st_CUSTOM_ErrorCount
          ,le.orig_zip_ALLOW_ErrorCount
          ,le.orig_zip4_ALLOW_ErrorCount
          ,le.phone_ALLOW_ErrorCount,le.phone_LENGTH_ErrorCount
          ,le.fname_ALLOW_ErrorCount
          ,le.mname_ALLOW_ErrorCount
          ,le.lname_ALLOW_ErrorCount
          ,le.st_CUSTOM_ErrorCount
          ,le.zip_ALLOW_ErrorCount
          ,le.zip4_ALLOW_ErrorCount
          ,le.date_submitted_ALLOW_ErrorCount
          ,le.date_created_ALLOW_ErrorCount
          ,le.did_ALLOW_ErrorCount
          ,le.override_flag_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.statement_id_ALLOW_ErrorCount
          ,le.orig_fname_ALLOW_ErrorCount
          ,le.orig_lname_ALLOW_ErrorCount
          ,le.orig_mname_ALLOW_ErrorCount
          ,le.orig_cname_ALLOW_ErrorCount
          ,le.orig_st_CUSTOM_ErrorCount
          ,le.orig_zip_ALLOW_ErrorCount
          ,le.orig_zip4_ALLOW_ErrorCount
          ,le.phone_ALLOW_ErrorCount,le.phone_LENGTH_ErrorCount
          ,le.fname_ALLOW_ErrorCount
          ,le.mname_ALLOW_ErrorCount
          ,le.lname_ALLOW_ErrorCount
          ,le.st_CUSTOM_ErrorCount
          ,le.zip_ALLOW_ErrorCount
          ,le.zip4_ALLOW_ErrorCount
          ,le.date_submitted_ALLOW_ErrorCount
          ,le.date_created_ALLOW_ErrorCount
          ,le.did_ALLOW_ErrorCount
          ,le.override_flag_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
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
      SALT38.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT38.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := RawFileNonFCRA_hygiene(PROJECT(h, RawFileNonFCRA_Layout_ConsumerStatement));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT38.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'statement_id:' + getFieldTypeText(h.statement_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_fname:' + getFieldTypeText(h.orig_fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_lname:' + getFieldTypeText(h.orig_lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_mname:' + getFieldTypeText(h.orig_mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_cname:' + getFieldTypeText(h.orig_cname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_address:' + getFieldTypeText(h.orig_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_city:' + getFieldTypeText(h.orig_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_st:' + getFieldTypeText(h.orig_st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_zip:' + getFieldTypeText(h.orig_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_zip4:' + getFieldTypeText(h.orig_zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone:' + getFieldTypeText(h.phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title:' + getFieldTypeText(h.title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fname:' + getFieldTypeText(h.fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mname:' + getFieldTypeText(h.mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname:' + getFieldTypeText(h.lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_suffix:' + getFieldTypeText(h.name_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_score:' + getFieldTypeText(h.name_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_range:' + getFieldTypeText(h.prim_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'predir:' + getFieldTypeText(h.predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_name:' + getFieldTypeText(h.prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_suffix:' + getFieldTypeText(h.addr_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'postdir:' + getFieldTypeText(h.postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unit_desig:' + getFieldTypeText(h.unit_desig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sec_range:' + getFieldTypeText(h.sec_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_city_name:' + getFieldTypeText(h.p_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v_city_name:' + getFieldTypeText(h.v_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'st:' + getFieldTypeText(h.st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip:' + getFieldTypeText(h.zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip4:' + getFieldTypeText(h.zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cart:' + getFieldTypeText(h.cart) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cr_sort_sz:' + getFieldTypeText(h.cr_sort_sz) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot:' + getFieldTypeText(h.lot) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot_order:' + getFieldTypeText(h.lot_order) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dbpc:' + getFieldTypeText(h.dbpc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'chk_digit:' + getFieldTypeText(h.chk_digit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rec_type:' + getFieldTypeText(h.rec_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county:' + getFieldTypeText(h.county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_lat:' + getFieldTypeText(h.geo_lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_long:' + getFieldTypeText(h.geo_long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'msa:' + getFieldTypeText(h.msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_blk:' + getFieldTypeText(h.geo_blk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_match:' + getFieldTypeText(h.geo_match) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'err_stat:' + getFieldTypeText(h.err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_submitted:' + getFieldTypeText(h.date_submitted) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_created:' + getFieldTypeText(h.date_created) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did:' + getFieldTypeText(h.did) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'consumer_text:' + getFieldTypeText(h.consumer_text) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'override_flag:' + getFieldTypeText(h.override_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_statement_id_cnt
          ,le.populated_orig_fname_cnt
          ,le.populated_orig_lname_cnt
          ,le.populated_orig_mname_cnt
          ,le.populated_orig_cname_cnt
          ,le.populated_orig_address_cnt
          ,le.populated_orig_city_cnt
          ,le.populated_orig_st_cnt
          ,le.populated_orig_zip_cnt
          ,le.populated_orig_zip4_cnt
          ,le.populated_phone_cnt
          ,le.populated_title_cnt
          ,le.populated_fname_cnt
          ,le.populated_mname_cnt
          ,le.populated_lname_cnt
          ,le.populated_name_suffix_cnt
          ,le.populated_name_score_cnt
          ,le.populated_prim_range_cnt
          ,le.populated_predir_cnt
          ,le.populated_prim_name_cnt
          ,le.populated_addr_suffix_cnt
          ,le.populated_postdir_cnt
          ,le.populated_unit_desig_cnt
          ,le.populated_sec_range_cnt
          ,le.populated_p_city_name_cnt
          ,le.populated_v_city_name_cnt
          ,le.populated_st_cnt
          ,le.populated_zip_cnt
          ,le.populated_zip4_cnt
          ,le.populated_cart_cnt
          ,le.populated_cr_sort_sz_cnt
          ,le.populated_lot_cnt
          ,le.populated_lot_order_cnt
          ,le.populated_dbpc_cnt
          ,le.populated_chk_digit_cnt
          ,le.populated_rec_type_cnt
          ,le.populated_county_cnt
          ,le.populated_geo_lat_cnt
          ,le.populated_geo_long_cnt
          ,le.populated_msa_cnt
          ,le.populated_geo_blk_cnt
          ,le.populated_geo_match_cnt
          ,le.populated_err_stat_cnt
          ,le.populated_date_submitted_cnt
          ,le.populated_date_created_cnt
          ,le.populated_did_cnt
          ,le.populated_consumer_text_cnt
          ,le.populated_override_flag_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_statement_id_pcnt
          ,le.populated_orig_fname_pcnt
          ,le.populated_orig_lname_pcnt
          ,le.populated_orig_mname_pcnt
          ,le.populated_orig_cname_pcnt
          ,le.populated_orig_address_pcnt
          ,le.populated_orig_city_pcnt
          ,le.populated_orig_st_pcnt
          ,le.populated_orig_zip_pcnt
          ,le.populated_orig_zip4_pcnt
          ,le.populated_phone_pcnt
          ,le.populated_title_pcnt
          ,le.populated_fname_pcnt
          ,le.populated_mname_pcnt
          ,le.populated_lname_pcnt
          ,le.populated_name_suffix_pcnt
          ,le.populated_name_score_pcnt
          ,le.populated_prim_range_pcnt
          ,le.populated_predir_pcnt
          ,le.populated_prim_name_pcnt
          ,le.populated_addr_suffix_pcnt
          ,le.populated_postdir_pcnt
          ,le.populated_unit_desig_pcnt
          ,le.populated_sec_range_pcnt
          ,le.populated_p_city_name_pcnt
          ,le.populated_v_city_name_pcnt
          ,le.populated_st_pcnt
          ,le.populated_zip_pcnt
          ,le.populated_zip4_pcnt
          ,le.populated_cart_pcnt
          ,le.populated_cr_sort_sz_pcnt
          ,le.populated_lot_pcnt
          ,le.populated_lot_order_pcnt
          ,le.populated_dbpc_pcnt
          ,le.populated_chk_digit_pcnt
          ,le.populated_rec_type_pcnt
          ,le.populated_county_pcnt
          ,le.populated_geo_lat_pcnt
          ,le.populated_geo_long_pcnt
          ,le.populated_msa_pcnt
          ,le.populated_geo_blk_pcnt
          ,le.populated_geo_match_pcnt
          ,le.populated_err_stat_pcnt
          ,le.populated_date_submitted_pcnt
          ,le.populated_date_created_pcnt
          ,le.populated_did_pcnt
          ,le.populated_consumer_text_pcnt
          ,le.populated_override_flag_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,48,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT38.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := RawFileNonFCRA_Delta(prevDS, PROJECT(h, RawFileNonFCRA_Layout_ConsumerStatement));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),48,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(RawFileNonFCRA_Layout_ConsumerStatement) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT38.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_ConsumerStatement, RawFileNonFCRA_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT38.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT38.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
