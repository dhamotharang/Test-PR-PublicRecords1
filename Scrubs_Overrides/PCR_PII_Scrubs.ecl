IMPORT SALT311,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT PCR_PII_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 28;
  EXPORT NumRulesFromFieldType := 28;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 24;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(PCR_PII_Layout_Overrides)
    UNSIGNED1 uid_Invalid;
    UNSIGNED1 date_created_Invalid;
    UNSIGNED1 dt_first_seen_Invalid;
    UNSIGNED1 dt_last_seen_Invalid;
    UNSIGNED1 did_Invalid;
    UNSIGNED1 fname_Invalid;
    UNSIGNED1 mname_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 name_suffix_Invalid;
    UNSIGNED1 ssn_Invalid;
    UNSIGNED1 dob_Invalid;
    UNSIGNED1 predir_Invalid;
    UNSIGNED1 prim_name_Invalid;
    UNSIGNED1 prim_range_Invalid;
    UNSIGNED1 suffix_Invalid;
    UNSIGNED1 postdir_Invalid;
    UNSIGNED1 unit_desig_Invalid;
    UNSIGNED1 sec_range_Invalid;
    UNSIGNED1 zip4_Invalid;
    UNSIGNED1 st_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 dl_number_Invalid;
    UNSIGNED1 dl_state_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(PCR_PII_Layout_Overrides)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(PCR_PII_Layout_Overrides) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.uid_Invalid := PCR_PII_Fields.InValid_uid((SALT311.StrType)le.uid);
    SELF.date_created_Invalid := PCR_PII_Fields.InValid_date_created((SALT311.StrType)le.date_created);
    SELF.dt_first_seen_Invalid := PCR_PII_Fields.InValid_dt_first_seen((SALT311.StrType)le.dt_first_seen);
    SELF.dt_last_seen_Invalid := PCR_PII_Fields.InValid_dt_last_seen((SALT311.StrType)le.dt_last_seen);
    SELF.did_Invalid := PCR_PII_Fields.InValid_did((SALT311.StrType)le.did);
    SELF.fname_Invalid := PCR_PII_Fields.InValid_fname((SALT311.StrType)le.fname);
    SELF.mname_Invalid := PCR_PII_Fields.InValid_mname((SALT311.StrType)le.mname);
    SELF.lname_Invalid := PCR_PII_Fields.InValid_lname((SALT311.StrType)le.lname);
    SELF.name_suffix_Invalid := PCR_PII_Fields.InValid_name_suffix((SALT311.StrType)le.name_suffix);
    SELF.ssn_Invalid := PCR_PII_Fields.InValid_ssn((SALT311.StrType)le.ssn);
    SELF.dob_Invalid := PCR_PII_Fields.InValid_dob((SALT311.StrType)le.dob);
    SELF.predir_Invalid := PCR_PII_Fields.InValid_predir((SALT311.StrType)le.predir);
    SELF.prim_name_Invalid := PCR_PII_Fields.InValid_prim_name((SALT311.StrType)le.prim_name);
    SELF.prim_range_Invalid := PCR_PII_Fields.InValid_prim_range((SALT311.StrType)le.prim_range);
    SELF.suffix_Invalid := PCR_PII_Fields.InValid_suffix((SALT311.StrType)le.suffix);
    SELF.postdir_Invalid := PCR_PII_Fields.InValid_postdir((SALT311.StrType)le.postdir);
    SELF.unit_desig_Invalid := PCR_PII_Fields.InValid_unit_desig((SALT311.StrType)le.unit_desig);
    SELF.sec_range_Invalid := PCR_PII_Fields.InValid_sec_range((SALT311.StrType)le.sec_range);
    SELF.zip4_Invalid := PCR_PII_Fields.InValid_zip4((SALT311.StrType)le.zip4);
    SELF.st_Invalid := PCR_PII_Fields.InValid_st((SALT311.StrType)le.st);
    SELF.zip_Invalid := PCR_PII_Fields.InValid_zip((SALT311.StrType)le.zip);
    SELF.phone_Invalid := PCR_PII_Fields.InValid_phone((SALT311.StrType)le.phone);
    SELF.dl_number_Invalid := PCR_PII_Fields.InValid_dl_number((SALT311.StrType)le.dl_number);
    SELF.dl_state_Invalid := PCR_PII_Fields.InValid_dl_state((SALT311.StrType)le.dl_state);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),PCR_PII_Layout_Overrides);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.uid_Invalid << 0 ) + ( le.date_created_Invalid << 1 ) + ( le.dt_first_seen_Invalid << 2 ) + ( le.dt_last_seen_Invalid << 3 ) + ( le.did_Invalid << 4 ) + ( le.fname_Invalid << 5 ) + ( le.mname_Invalid << 6 ) + ( le.lname_Invalid << 7 ) + ( le.name_suffix_Invalid << 8 ) + ( le.ssn_Invalid << 9 ) + ( le.dob_Invalid << 11 ) + ( le.predir_Invalid << 13 ) + ( le.prim_name_Invalid << 14 ) + ( le.prim_range_Invalid << 15 ) + ( le.suffix_Invalid << 16 ) + ( le.postdir_Invalid << 17 ) + ( le.unit_desig_Invalid << 18 ) + ( le.sec_range_Invalid << 19 ) + ( le.zip4_Invalid << 20 ) + ( le.st_Invalid << 21 ) + ( le.zip_Invalid << 23 ) + ( le.phone_Invalid << 24 ) + ( le.dl_number_Invalid << 25 ) + ( le.dl_state_Invalid << 26 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,PCR_PII_Layout_Overrides);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.uid_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.date_created_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.dt_first_seen_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.dt_last_seen_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.did_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.fname_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.mname_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.lname_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.name_suffix_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.ssn_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF.dob_Invalid := (le.ScrubsBits1 >> 11) & 3;
    SELF.predir_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.prim_name_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.prim_range_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.suffix_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.postdir_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.unit_desig_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.sec_range_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.zip4_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.st_Invalid := (le.ScrubsBits1 >> 21) & 3;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.phone_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.dl_number_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.dl_state_Invalid := (le.ScrubsBits1 >> 26) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    uid_ALLOW_ErrorCount := COUNT(GROUP,h.uid_Invalid=1);
    date_created_CUSTOM_ErrorCount := COUNT(GROUP,h.date_created_Invalid=1);
    dt_first_seen_ALLOW_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=1);
    dt_last_seen_ALLOW_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=1);
    did_ALLOW_ErrorCount := COUNT(GROUP,h.did_Invalid=1);
    fname_ALLOW_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    mname_ALLOW_ErrorCount := COUNT(GROUP,h.mname_Invalid=1);
    lname_ALLOW_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=1);
    ssn_ALLOW_ErrorCount := COUNT(GROUP,h.ssn_Invalid=1);
    ssn_LENGTHS_ErrorCount := COUNT(GROUP,h.ssn_Invalid=2);
    ssn_Total_ErrorCount := COUNT(GROUP,h.ssn_Invalid>0);
    dob_ALLOW_ErrorCount := COUNT(GROUP,h.dob_Invalid=1);
    dob_LENGTHS_ErrorCount := COUNT(GROUP,h.dob_Invalid=2);
    dob_Total_ErrorCount := COUNT(GROUP,h.dob_Invalid>0);
    predir_ALLOW_ErrorCount := COUNT(GROUP,h.predir_Invalid=1);
    prim_name_ALLOW_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=1);
    prim_range_ALLOW_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=1);
    suffix_ALLOW_ErrorCount := COUNT(GROUP,h.suffix_Invalid=1);
    postdir_ALLOW_ErrorCount := COUNT(GROUP,h.postdir_Invalid=1);
    unit_desig_ALLOW_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=1);
    sec_range_ALLOW_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=1);
    zip4_ALLOW_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    st_ALLOW_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    st_LENGTHS_ErrorCount := COUNT(GROUP,h.st_Invalid=2);
    st_Total_ErrorCount := COUNT(GROUP,h.st_Invalid>0);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    phone_ALLOW_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    dl_number_ALLOW_ErrorCount := COUNT(GROUP,h.dl_number_Invalid=1);
    dl_state_ALLOW_ErrorCount := COUNT(GROUP,h.dl_state_Invalid=1);
    dl_state_LENGTHS_ErrorCount := COUNT(GROUP,h.dl_state_Invalid=2);
    dl_state_Total_ErrorCount := COUNT(GROUP,h.dl_state_Invalid>0);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.uid_Invalid > 0 OR h.date_created_Invalid > 0 OR h.dt_first_seen_Invalid > 0 OR h.dt_last_seen_Invalid > 0 OR h.did_Invalid > 0 OR h.fname_Invalid > 0 OR h.mname_Invalid > 0 OR h.lname_Invalid > 0 OR h.name_suffix_Invalid > 0 OR h.ssn_Invalid > 0 OR h.dob_Invalid > 0 OR h.predir_Invalid > 0 OR h.prim_name_Invalid > 0 OR h.prim_range_Invalid > 0 OR h.suffix_Invalid > 0 OR h.postdir_Invalid > 0 OR h.unit_desig_Invalid > 0 OR h.sec_range_Invalid > 0 OR h.zip4_Invalid > 0 OR h.st_Invalid > 0 OR h.zip_Invalid > 0 OR h.phone_Invalid > 0 OR h.dl_number_Invalid > 0 OR h.dl_state_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.uid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_created_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_first_seen_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_ALLOW_ErrorCount > 0, 1, 0) + IF(le.did_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ssn_Total_ErrorCount > 0, 1, 0) + IF(le.dob_Total_ErrorCount > 0, 1, 0) + IF(le.predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.st_Total_ErrorCount > 0, 1, 0) + IF(le.zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dl_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dl_state_Total_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.uid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_created_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_first_seen_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_ALLOW_ErrorCount > 0, 1, 0) + IF(le.did_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ssn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ssn_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dob_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dob_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.st_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dl_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dl_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dl_state_LENGTHS_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT311.StrType ErrorMessage;
    SALT311.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.uid_Invalid,le.date_created_Invalid,le.dt_first_seen_Invalid,le.dt_last_seen_Invalid,le.did_Invalid,le.fname_Invalid,le.mname_Invalid,le.lname_Invalid,le.name_suffix_Invalid,le.ssn_Invalid,le.dob_Invalid,le.predir_Invalid,le.prim_name_Invalid,le.prim_range_Invalid,le.suffix_Invalid,le.postdir_Invalid,le.unit_desig_Invalid,le.sec_range_Invalid,le.zip4_Invalid,le.st_Invalid,le.zip_Invalid,le.phone_Invalid,le.dl_number_Invalid,le.dl_state_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,PCR_PII_Fields.InvalidMessage_uid(le.uid_Invalid),PCR_PII_Fields.InvalidMessage_date_created(le.date_created_Invalid),PCR_PII_Fields.InvalidMessage_dt_first_seen(le.dt_first_seen_Invalid),PCR_PII_Fields.InvalidMessage_dt_last_seen(le.dt_last_seen_Invalid),PCR_PII_Fields.InvalidMessage_did(le.did_Invalid),PCR_PII_Fields.InvalidMessage_fname(le.fname_Invalid),PCR_PII_Fields.InvalidMessage_mname(le.mname_Invalid),PCR_PII_Fields.InvalidMessage_lname(le.lname_Invalid),PCR_PII_Fields.InvalidMessage_name_suffix(le.name_suffix_Invalid),PCR_PII_Fields.InvalidMessage_ssn(le.ssn_Invalid),PCR_PII_Fields.InvalidMessage_dob(le.dob_Invalid),PCR_PII_Fields.InvalidMessage_predir(le.predir_Invalid),PCR_PII_Fields.InvalidMessage_prim_name(le.prim_name_Invalid),PCR_PII_Fields.InvalidMessage_prim_range(le.prim_range_Invalid),PCR_PII_Fields.InvalidMessage_suffix(le.suffix_Invalid),PCR_PII_Fields.InvalidMessage_postdir(le.postdir_Invalid),PCR_PII_Fields.InvalidMessage_unit_desig(le.unit_desig_Invalid),PCR_PII_Fields.InvalidMessage_sec_range(le.sec_range_Invalid),PCR_PII_Fields.InvalidMessage_zip4(le.zip4_Invalid),PCR_PII_Fields.InvalidMessage_st(le.st_Invalid),PCR_PII_Fields.InvalidMessage_zip(le.zip_Invalid),PCR_PII_Fields.InvalidMessage_phone(le.phone_Invalid),PCR_PII_Fields.InvalidMessage_dl_number(le.dl_number_Invalid),PCR_PII_Fields.InvalidMessage_dl_state(le.dl_state_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.uid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.date_created_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_first_seen_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.did_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ssn_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.dob_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.predir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prim_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prim_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.postdir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.unit_desig_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sec_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.st_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dl_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dl_state_Invalid,'ALLOW','LENGTHS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'uid','date_created','dt_first_seen','dt_last_seen','did','fname','mname','lname','name_suffix','ssn','dob','predir','prim_name','prim_range','suffix','postdir','unit_desig','sec_range','zip4','st','zip','phone','dl_number','dl_state','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Char','Invalid_Date','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_SSN','Invalid_DOB','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Num','Invalid_State','Invalid_Num','Invalid_Num','Invalid_DLNum','Invalid_State','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.uid,(SALT311.StrType)le.date_created,(SALT311.StrType)le.dt_first_seen,(SALT311.StrType)le.dt_last_seen,(SALT311.StrType)le.did,(SALT311.StrType)le.fname,(SALT311.StrType)le.mname,(SALT311.StrType)le.lname,(SALT311.StrType)le.name_suffix,(SALT311.StrType)le.ssn,(SALT311.StrType)le.dob,(SALT311.StrType)le.predir,(SALT311.StrType)le.prim_name,(SALT311.StrType)le.prim_range,(SALT311.StrType)le.suffix,(SALT311.StrType)le.postdir,(SALT311.StrType)le.unit_desig,(SALT311.StrType)le.sec_range,(SALT311.StrType)le.zip4,(SALT311.StrType)le.st,(SALT311.StrType)le.zip,(SALT311.StrType)le.phone,(SALT311.StrType)le.dl_number,(SALT311.StrType)le.dl_state,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,24,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(PCR_PII_Layout_Overrides) prevDS = DATASET([], PCR_PII_Layout_Overrides), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'uid:Invalid_Char:ALLOW'
          ,'date_created:Invalid_Date:CUSTOM'
          ,'dt_first_seen:Invalid_Num:ALLOW'
          ,'dt_last_seen:Invalid_Num:ALLOW'
          ,'did:Invalid_Num:ALLOW'
          ,'fname:Invalid_Char:ALLOW'
          ,'mname:Invalid_Char:ALLOW'
          ,'lname:Invalid_Char:ALLOW'
          ,'name_suffix:Invalid_Char:ALLOW'
          ,'ssn:Invalid_SSN:ALLOW','ssn:Invalid_SSN:LENGTHS'
          ,'dob:Invalid_DOB:ALLOW','dob:Invalid_DOB:LENGTHS'
          ,'predir:Invalid_Char:ALLOW'
          ,'prim_name:Invalid_Char:ALLOW'
          ,'prim_range:Invalid_Char:ALLOW'
          ,'suffix:Invalid_Char:ALLOW'
          ,'postdir:Invalid_Char:ALLOW'
          ,'unit_desig:Invalid_Char:ALLOW'
          ,'sec_range:Invalid_Char:ALLOW'
          ,'zip4:Invalid_Num:ALLOW'
          ,'st:Invalid_State:ALLOW','st:Invalid_State:LENGTHS'
          ,'zip:Invalid_Num:ALLOW'
          ,'phone:Invalid_Num:ALLOW'
          ,'dl_number:Invalid_DLNum:ALLOW'
          ,'dl_state:Invalid_State:ALLOW','dl_state:Invalid_State:LENGTHS'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,PCR_PII_Fields.InvalidMessage_uid(1)
          ,PCR_PII_Fields.InvalidMessage_date_created(1)
          ,PCR_PII_Fields.InvalidMessage_dt_first_seen(1)
          ,PCR_PII_Fields.InvalidMessage_dt_last_seen(1)
          ,PCR_PII_Fields.InvalidMessage_did(1)
          ,PCR_PII_Fields.InvalidMessage_fname(1)
          ,PCR_PII_Fields.InvalidMessage_mname(1)
          ,PCR_PII_Fields.InvalidMessage_lname(1)
          ,PCR_PII_Fields.InvalidMessage_name_suffix(1)
          ,PCR_PII_Fields.InvalidMessage_ssn(1),PCR_PII_Fields.InvalidMessage_ssn(2)
          ,PCR_PII_Fields.InvalidMessage_dob(1),PCR_PII_Fields.InvalidMessage_dob(2)
          ,PCR_PII_Fields.InvalidMessage_predir(1)
          ,PCR_PII_Fields.InvalidMessage_prim_name(1)
          ,PCR_PII_Fields.InvalidMessage_prim_range(1)
          ,PCR_PII_Fields.InvalidMessage_suffix(1)
          ,PCR_PII_Fields.InvalidMessage_postdir(1)
          ,PCR_PII_Fields.InvalidMessage_unit_desig(1)
          ,PCR_PII_Fields.InvalidMessage_sec_range(1)
          ,PCR_PII_Fields.InvalidMessage_zip4(1)
          ,PCR_PII_Fields.InvalidMessage_st(1),PCR_PII_Fields.InvalidMessage_st(2)
          ,PCR_PII_Fields.InvalidMessage_zip(1)
          ,PCR_PII_Fields.InvalidMessage_phone(1)
          ,PCR_PII_Fields.InvalidMessage_dl_number(1)
          ,PCR_PII_Fields.InvalidMessage_dl_state(1),PCR_PII_Fields.InvalidMessage_dl_state(2)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.uid_ALLOW_ErrorCount
          ,le.date_created_CUSTOM_ErrorCount
          ,le.dt_first_seen_ALLOW_ErrorCount
          ,le.dt_last_seen_ALLOW_ErrorCount
          ,le.did_ALLOW_ErrorCount
          ,le.fname_ALLOW_ErrorCount
          ,le.mname_ALLOW_ErrorCount
          ,le.lname_ALLOW_ErrorCount
          ,le.name_suffix_ALLOW_ErrorCount
          ,le.ssn_ALLOW_ErrorCount,le.ssn_LENGTHS_ErrorCount
          ,le.dob_ALLOW_ErrorCount,le.dob_LENGTHS_ErrorCount
          ,le.predir_ALLOW_ErrorCount
          ,le.prim_name_ALLOW_ErrorCount
          ,le.prim_range_ALLOW_ErrorCount
          ,le.suffix_ALLOW_ErrorCount
          ,le.postdir_ALLOW_ErrorCount
          ,le.unit_desig_ALLOW_ErrorCount
          ,le.sec_range_ALLOW_ErrorCount
          ,le.zip4_ALLOW_ErrorCount
          ,le.st_ALLOW_ErrorCount,le.st_LENGTHS_ErrorCount
          ,le.zip_ALLOW_ErrorCount
          ,le.phone_ALLOW_ErrorCount
          ,le.dl_number_ALLOW_ErrorCount
          ,le.dl_state_ALLOW_ErrorCount,le.dl_state_LENGTHS_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.uid_ALLOW_ErrorCount
          ,le.date_created_CUSTOM_ErrorCount
          ,le.dt_first_seen_ALLOW_ErrorCount
          ,le.dt_last_seen_ALLOW_ErrorCount
          ,le.did_ALLOW_ErrorCount
          ,le.fname_ALLOW_ErrorCount
          ,le.mname_ALLOW_ErrorCount
          ,le.lname_ALLOW_ErrorCount
          ,le.name_suffix_ALLOW_ErrorCount
          ,le.ssn_ALLOW_ErrorCount,le.ssn_LENGTHS_ErrorCount
          ,le.dob_ALLOW_ErrorCount,le.dob_LENGTHS_ErrorCount
          ,le.predir_ALLOW_ErrorCount
          ,le.prim_name_ALLOW_ErrorCount
          ,le.prim_range_ALLOW_ErrorCount
          ,le.suffix_ALLOW_ErrorCount
          ,le.postdir_ALLOW_ErrorCount
          ,le.unit_desig_ALLOW_ErrorCount
          ,le.sec_range_ALLOW_ErrorCount
          ,le.zip4_ALLOW_ErrorCount
          ,le.st_ALLOW_ErrorCount,le.st_LENGTHS_ErrorCount
          ,le.zip_ALLOW_ErrorCount
          ,le.phone_ALLOW_ErrorCount
          ,le.dl_number_ALLOW_ErrorCount
          ,le.dl_state_ALLOW_ErrorCount,le.dl_state_LENGTHS_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
      SALT311.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT311.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := PCR_PII_hygiene(PROJECT(h, PCR_PII_Layout_Overrides));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT311.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'uid:' + getFieldTypeText(h.uid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_created:' + getFieldTypeText(h.date_created) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_first_seen:' + getFieldTypeText(h.dt_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_last_seen:' + getFieldTypeText(h.dt_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did:' + getFieldTypeText(h.did) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fname:' + getFieldTypeText(h.fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mname:' + getFieldTypeText(h.mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname:' + getFieldTypeText(h.lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_suffix:' + getFieldTypeText(h.name_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ssn:' + getFieldTypeText(h.ssn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dob:' + getFieldTypeText(h.dob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'predir:' + getFieldTypeText(h.predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_name:' + getFieldTypeText(h.prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_range:' + getFieldTypeText(h.prim_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'suffix:' + getFieldTypeText(h.suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'postdir:' + getFieldTypeText(h.postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unit_desig:' + getFieldTypeText(h.unit_desig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sec_range:' + getFieldTypeText(h.sec_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip4:' + getFieldTypeText(h.zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address:' + getFieldTypeText(h.address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city_name:' + getFieldTypeText(h.city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'st:' + getFieldTypeText(h.st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip:' + getFieldTypeText(h.zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone:' + getFieldTypeText(h.phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dl_number:' + getFieldTypeText(h.dl_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dl_state:' + getFieldTypeText(h.dl_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dispute_flag:' + getFieldTypeText(h.dispute_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'security_freeze:' + getFieldTypeText(h.security_freeze) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'security_freeze_pin:' + getFieldTypeText(h.security_freeze_pin) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'security_alert:' + getFieldTypeText(h.security_alert) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'negative_alert:' + getFieldTypeText(h.negative_alert) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'id_theft_flag:' + getFieldTypeText(h.id_theft_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'insuff_inqry_data:' + getFieldTypeText(h.insuff_inqry_data) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'consumer_statement_flag:' + getFieldTypeText(h.consumer_statement_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_uid_cnt
          ,le.populated_date_created_cnt
          ,le.populated_dt_first_seen_cnt
          ,le.populated_dt_last_seen_cnt
          ,le.populated_did_cnt
          ,le.populated_fname_cnt
          ,le.populated_mname_cnt
          ,le.populated_lname_cnt
          ,le.populated_name_suffix_cnt
          ,le.populated_ssn_cnt
          ,le.populated_dob_cnt
          ,le.populated_predir_cnt
          ,le.populated_prim_name_cnt
          ,le.populated_prim_range_cnt
          ,le.populated_suffix_cnt
          ,le.populated_postdir_cnt
          ,le.populated_unit_desig_cnt
          ,le.populated_sec_range_cnt
          ,le.populated_zip4_cnt
          ,le.populated_address_cnt
          ,le.populated_city_name_cnt
          ,le.populated_st_cnt
          ,le.populated_zip_cnt
          ,le.populated_phone_cnt
          ,le.populated_dl_number_cnt
          ,le.populated_dl_state_cnt
          ,le.populated_dispute_flag_cnt
          ,le.populated_security_freeze_cnt
          ,le.populated_security_freeze_pin_cnt
          ,le.populated_security_alert_cnt
          ,le.populated_negative_alert_cnt
          ,le.populated_id_theft_flag_cnt
          ,le.populated_insuff_inqry_data_cnt
          ,le.populated_consumer_statement_flag_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_uid_pcnt
          ,le.populated_date_created_pcnt
          ,le.populated_dt_first_seen_pcnt
          ,le.populated_dt_last_seen_pcnt
          ,le.populated_did_pcnt
          ,le.populated_fname_pcnt
          ,le.populated_mname_pcnt
          ,le.populated_lname_pcnt
          ,le.populated_name_suffix_pcnt
          ,le.populated_ssn_pcnt
          ,le.populated_dob_pcnt
          ,le.populated_predir_pcnt
          ,le.populated_prim_name_pcnt
          ,le.populated_prim_range_pcnt
          ,le.populated_suffix_pcnt
          ,le.populated_postdir_pcnt
          ,le.populated_unit_desig_pcnt
          ,le.populated_sec_range_pcnt
          ,le.populated_zip4_pcnt
          ,le.populated_address_pcnt
          ,le.populated_city_name_pcnt
          ,le.populated_st_pcnt
          ,le.populated_zip_pcnt
          ,le.populated_phone_pcnt
          ,le.populated_dl_number_pcnt
          ,le.populated_dl_state_pcnt
          ,le.populated_dispute_flag_pcnt
          ,le.populated_security_freeze_pcnt
          ,le.populated_security_freeze_pin_pcnt
          ,le.populated_security_alert_pcnt
          ,le.populated_negative_alert_pcnt
          ,le.populated_id_theft_flag_pcnt
          ,le.populated_insuff_inqry_data_pcnt
          ,le.populated_consumer_statement_flag_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,34,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT311.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := PCR_PII_Delta(prevDS, PROJECT(h, PCR_PII_Layout_Overrides));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),34,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(PCR_PII_Layout_Overrides) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Overrides, PCR_PII_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
