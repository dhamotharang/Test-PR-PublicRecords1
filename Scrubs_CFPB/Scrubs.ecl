IMPORT SALT311,STD;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 26;
  EXPORT NumRulesFromFieldType := 26;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 10;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_CFPB)
    UNSIGNED1 record_sid_Invalid;
    UNSIGNED1 global_src_id_Invalid;
    UNSIGNED1 dt_vendor_first_reported_Invalid;
    UNSIGNED1 dt_vendor_last_reported_Invalid;
    UNSIGNED1 seqno_Invalid;
    UNSIGNED1 geoid10_blkgrp_Invalid;
    UNSIGNED1 state_fips10_Invalid;
    UNSIGNED1 county_fips10_Invalid;
    UNSIGNED1 tract_fips10_Invalid;
    UNSIGNED1 blkgrp_fips10_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_CFPB)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(Layout_CFPB)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'record_sid:invalid_id:LEFTTRIM','record_sid:invalid_id:LENGTHS'
          ,'global_src_id:invalid_id:LEFTTRIM','global_src_id:invalid_id:LENGTHS'
          ,'dt_vendor_first_reported:invalid_date:LEFTTRIM','dt_vendor_first_reported:invalid_date:ALLOW','dt_vendor_first_reported:invalid_date:LENGTHS'
          ,'dt_vendor_last_reported:invalid_date:LEFTTRIM','dt_vendor_last_reported:invalid_date:ALLOW','dt_vendor_last_reported:invalid_date:LENGTHS'
          ,'seqno:invalid_seqno:LEFTTRIM','seqno:invalid_seqno:LENGTHS'
          ,'geoid10_blkgrp:invalid_geoid10_blkgrp:LEFTTRIM','geoid10_blkgrp:invalid_geoid10_blkgrp:ALLOW','geoid10_blkgrp:invalid_geoid10_blkgrp:LENGTHS'
          ,'state_fips10:invalid_state_fips10:LEFTTRIM','state_fips10:invalid_state_fips10:ALLOW','state_fips10:invalid_state_fips10:LENGTHS'
          ,'county_fips10:invalid_county_fips10:LEFTTRIM','county_fips10:invalid_county_fips10:ALLOW','county_fips10:invalid_county_fips10:LENGTHS'
          ,'tract_fips10:invalid_tract_fips10:LEFTTRIM','tract_fips10:invalid_tract_fips10:ALLOW','tract_fips10:invalid_tract_fips10:LENGTHS'
          ,'blkgrp_fips10:invalid_blkgrp_fips10:LEFTTRIM','blkgrp_fips10:invalid_blkgrp_fips10:LENGTHS'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Fields.InvalidMessage_record_sid(1),Fields.InvalidMessage_record_sid(2)
          ,Fields.InvalidMessage_global_src_id(1),Fields.InvalidMessage_global_src_id(2)
          ,Fields.InvalidMessage_dt_vendor_first_reported(1),Fields.InvalidMessage_dt_vendor_first_reported(2),Fields.InvalidMessage_dt_vendor_first_reported(3)
          ,Fields.InvalidMessage_dt_vendor_last_reported(1),Fields.InvalidMessage_dt_vendor_last_reported(2),Fields.InvalidMessage_dt_vendor_last_reported(3)
          ,Fields.InvalidMessage_seqno(1),Fields.InvalidMessage_seqno(2)
          ,Fields.InvalidMessage_geoid10_blkgrp(1),Fields.InvalidMessage_geoid10_blkgrp(2),Fields.InvalidMessage_geoid10_blkgrp(3)
          ,Fields.InvalidMessage_state_fips10(1),Fields.InvalidMessage_state_fips10(2),Fields.InvalidMessage_state_fips10(3)
          ,Fields.InvalidMessage_county_fips10(1),Fields.InvalidMessage_county_fips10(2),Fields.InvalidMessage_county_fips10(3)
          ,Fields.InvalidMessage_tract_fips10(1),Fields.InvalidMessage_tract_fips10(2),Fields.InvalidMessage_tract_fips10(3)
          ,Fields.InvalidMessage_blkgrp_fips10(1),Fields.InvalidMessage_blkgrp_fips10(2)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(Layout_CFPB) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.record_sid_Invalid := Fields.InValid_record_sid((SALT311.StrType)le.record_sid);
    SELF.global_src_id_Invalid := Fields.InValid_global_src_id((SALT311.StrType)le.global_src_id);
    SELF.dt_vendor_first_reported_Invalid := Fields.InValid_dt_vendor_first_reported((SALT311.StrType)le.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported_Invalid := Fields.InValid_dt_vendor_last_reported((SALT311.StrType)le.dt_vendor_last_reported);
    SELF.seqno_Invalid := Fields.InValid_seqno((SALT311.StrType)le.seqno);
    SELF.geoid10_blkgrp_Invalid := Fields.InValid_geoid10_blkgrp((SALT311.StrType)le.geoid10_blkgrp);
    SELF.state_fips10_Invalid := Fields.InValid_state_fips10((SALT311.StrType)le.state_fips10);
    SELF.county_fips10_Invalid := Fields.InValid_county_fips10((SALT311.StrType)le.county_fips10);
    SELF.tract_fips10_Invalid := Fields.InValid_tract_fips10((SALT311.StrType)le.tract_fips10);
    SELF.blkgrp_fips10_Invalid := Fields.InValid_blkgrp_fips10((SALT311.StrType)le.blkgrp_fips10);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_CFPB);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.record_sid_Invalid << 0 ) + ( le.global_src_id_Invalid << 2 ) + ( le.dt_vendor_first_reported_Invalid << 4 ) + ( le.dt_vendor_last_reported_Invalid << 6 ) + ( le.seqno_Invalid << 8 ) + ( le.geoid10_blkgrp_Invalid << 10 ) + ( le.state_fips10_Invalid << 12 ) + ( le.county_fips10_Invalid << 14 ) + ( le.tract_fips10_Invalid << 16 ) + ( le.blkgrp_fips10_Invalid << 18 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
  STRING escQuotes(STRING s) := STD.Str.FindReplace(s,'\'','\\\'');
  Rule_Layout IntoRule(BitmapInfile le, UNSIGNED c) := TRANSFORM
    mask := 1<<(c-1);
    hasError := (mask&le.ScrubsBits1)>0;
    SELF.Rules := IF(hasError,TRIM(toRuleDesc(c))+':\''+escQuotes(TRIM(toErrorMessage(c)))+'\'',IF(le.ScrubsBits1=0 AND c=1,'',SKIP));
    SELF := le;
  END;
  unrolled := NORMALIZE(BitmapInfile,NumRules,IntoRule(LEFT,COUNTER));
  Rule_Layout toRoll(Rule_Layout le,Rule_Layout ri) := TRANSFORM
    SELF.Rules := TRIM(le.Rules) + IF(LENGTH(TRIM(le.Rules))>0 AND LENGTH(TRIM(ri.Rules))>0,',','') + TRIM(ri.Rules);
    SELF := le;
  END;
  EXPORT RulesInfile := ROLLUP(unrolled,toRoll(LEFT,RIGHT),EXCEPT Rules);
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_CFPB);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.record_sid_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.global_src_id_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.dt_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.dt_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.seqno_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.geoid10_blkgrp_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.state_fips10_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.county_fips10_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.tract_fips10_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.blkgrp_fips10_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    record_sid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.record_sid_Invalid=1);
    record_sid_LENGTHS_ErrorCount := COUNT(GROUP,h.record_sid_Invalid=2);
    record_sid_Total_ErrorCount := COUNT(GROUP,h.record_sid_Invalid>0);
    global_src_id_LEFTTRIM_ErrorCount := COUNT(GROUP,h.global_src_id_Invalid=1);
    global_src_id_LENGTHS_ErrorCount := COUNT(GROUP,h.global_src_id_Invalid=2);
    global_src_id_Total_ErrorCount := COUNT(GROUP,h.global_src_id_Invalid>0);
    dt_vendor_first_reported_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=1);
    dt_vendor_first_reported_ALLOW_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=2);
    dt_vendor_first_reported_LENGTHS_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=3);
    dt_vendor_first_reported_Total_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid>0);
    dt_vendor_last_reported_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=1);
    dt_vendor_last_reported_ALLOW_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=2);
    dt_vendor_last_reported_LENGTHS_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=3);
    dt_vendor_last_reported_Total_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid>0);
    seqno_LEFTTRIM_ErrorCount := COUNT(GROUP,h.seqno_Invalid=1);
    seqno_LENGTHS_ErrorCount := COUNT(GROUP,h.seqno_Invalid=2);
    seqno_Total_ErrorCount := COUNT(GROUP,h.seqno_Invalid>0);
    geoid10_blkgrp_LEFTTRIM_ErrorCount := COUNT(GROUP,h.geoid10_blkgrp_Invalid=1);
    geoid10_blkgrp_ALLOW_ErrorCount := COUNT(GROUP,h.geoid10_blkgrp_Invalid=2);
    geoid10_blkgrp_LENGTHS_ErrorCount := COUNT(GROUP,h.geoid10_blkgrp_Invalid=3);
    geoid10_blkgrp_Total_ErrorCount := COUNT(GROUP,h.geoid10_blkgrp_Invalid>0);
    state_fips10_LEFTTRIM_ErrorCount := COUNT(GROUP,h.state_fips10_Invalid=1);
    state_fips10_ALLOW_ErrorCount := COUNT(GROUP,h.state_fips10_Invalid=2);
    state_fips10_LENGTHS_ErrorCount := COUNT(GROUP,h.state_fips10_Invalid=3);
    state_fips10_Total_ErrorCount := COUNT(GROUP,h.state_fips10_Invalid>0);
    county_fips10_LEFTTRIM_ErrorCount := COUNT(GROUP,h.county_fips10_Invalid=1);
    county_fips10_ALLOW_ErrorCount := COUNT(GROUP,h.county_fips10_Invalid=2);
    county_fips10_LENGTHS_ErrorCount := COUNT(GROUP,h.county_fips10_Invalid=3);
    county_fips10_Total_ErrorCount := COUNT(GROUP,h.county_fips10_Invalid>0);
    tract_fips10_LEFTTRIM_ErrorCount := COUNT(GROUP,h.tract_fips10_Invalid=1);
    tract_fips10_ALLOW_ErrorCount := COUNT(GROUP,h.tract_fips10_Invalid=2);
    tract_fips10_LENGTHS_ErrorCount := COUNT(GROUP,h.tract_fips10_Invalid=3);
    tract_fips10_Total_ErrorCount := COUNT(GROUP,h.tract_fips10_Invalid>0);
    blkgrp_fips10_LEFTTRIM_ErrorCount := COUNT(GROUP,h.blkgrp_fips10_Invalid=1);
    blkgrp_fips10_LENGTHS_ErrorCount := COUNT(GROUP,h.blkgrp_fips10_Invalid=2);
    blkgrp_fips10_Total_ErrorCount := COUNT(GROUP,h.blkgrp_fips10_Invalid>0);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.record_sid_Invalid > 0 OR h.global_src_id_Invalid > 0 OR h.dt_vendor_first_reported_Invalid > 0 OR h.dt_vendor_last_reported_Invalid > 0 OR h.seqno_Invalid > 0 OR h.geoid10_blkgrp_Invalid > 0 OR h.state_fips10_Invalid > 0 OR h.county_fips10_Invalid > 0 OR h.tract_fips10_Invalid > 0 OR h.blkgrp_fips10_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.record_sid_Total_ErrorCount > 0, 1, 0) + IF(le.global_src_id_Total_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_Total_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_Total_ErrorCount > 0, 1, 0) + IF(le.seqno_Total_ErrorCount > 0, 1, 0) + IF(le.geoid10_blkgrp_Total_ErrorCount > 0, 1, 0) + IF(le.state_fips10_Total_ErrorCount > 0, 1, 0) + IF(le.county_fips10_Total_ErrorCount > 0, 1, 0) + IF(le.tract_fips10_Total_ErrorCount > 0, 1, 0) + IF(le.blkgrp_fips10_Total_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.record_sid_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.record_sid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.global_src_id_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.global_src_id_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.seqno_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.seqno_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.geoid10_blkgrp_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.geoid10_blkgrp_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geoid10_blkgrp_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.state_fips10_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.state_fips10_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_fips10_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.county_fips10_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.county_fips10_ALLOW_ErrorCount > 0, 1, 0) + IF(le.county_fips10_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tract_fips10_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.tract_fips10_ALLOW_ErrorCount > 0, 1, 0) + IF(le.tract_fips10_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.blkgrp_fips10_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.blkgrp_fips10_LENGTHS_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.record_sid_Invalid,le.global_src_id_Invalid,le.dt_vendor_first_reported_Invalid,le.dt_vendor_last_reported_Invalid,le.seqno_Invalid,le.geoid10_blkgrp_Invalid,le.state_fips10_Invalid,le.county_fips10_Invalid,le.tract_fips10_Invalid,le.blkgrp_fips10_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_record_sid(le.record_sid_Invalid),Fields.InvalidMessage_global_src_id(le.global_src_id_Invalid),Fields.InvalidMessage_dt_vendor_first_reported(le.dt_vendor_first_reported_Invalid),Fields.InvalidMessage_dt_vendor_last_reported(le.dt_vendor_last_reported_Invalid),Fields.InvalidMessage_seqno(le.seqno_Invalid),Fields.InvalidMessage_geoid10_blkgrp(le.geoid10_blkgrp_Invalid),Fields.InvalidMessage_state_fips10(le.state_fips10_Invalid),Fields.InvalidMessage_county_fips10(le.county_fips10_Invalid),Fields.InvalidMessage_tract_fips10(le.tract_fips10_Invalid),Fields.InvalidMessage_blkgrp_fips10(le.blkgrp_fips10_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.record_sid_Invalid,'LEFTTRIM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.global_src_id_Invalid,'LEFTTRIM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.dt_vendor_first_reported_Invalid,'LEFTTRIM','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.dt_vendor_last_reported_Invalid,'LEFTTRIM','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.seqno_Invalid,'LEFTTRIM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.geoid10_blkgrp_Invalid,'LEFTTRIM','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.state_fips10_Invalid,'LEFTTRIM','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.county_fips10_Invalid,'LEFTTRIM','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tract_fips10_Invalid,'LEFTTRIM','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.blkgrp_fips10_Invalid,'LEFTTRIM','LENGTHS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'record_sid','global_src_id','dt_vendor_first_reported','dt_vendor_last_reported','seqno','geoid10_blkgrp','state_fips10','county_fips10','tract_fips10','blkgrp_fips10','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_id','invalid_id','invalid_date','invalid_date','invalid_seqno','invalid_geoid10_blkgrp','invalid_state_fips10','invalid_county_fips10','invalid_tract_fips10','invalid_blkgrp_fips10','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.record_sid,(SALT311.StrType)le.global_src_id,(SALT311.StrType)le.dt_vendor_first_reported,(SALT311.StrType)le.dt_vendor_last_reported,(SALT311.StrType)le.seqno,(SALT311.StrType)le.geoid10_blkgrp,(SALT311.StrType)le.state_fips10,(SALT311.StrType)le.county_fips10,(SALT311.StrType)le.tract_fips10,(SALT311.StrType)le.blkgrp_fips10,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,10,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_CFPB) prevDS = DATASET([], Layout_CFPB), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.record_sid_LEFTTRIM_ErrorCount,le.record_sid_LENGTHS_ErrorCount
          ,le.global_src_id_LEFTTRIM_ErrorCount,le.global_src_id_LENGTHS_ErrorCount
          ,le.dt_vendor_first_reported_LEFTTRIM_ErrorCount,le.dt_vendor_first_reported_ALLOW_ErrorCount,le.dt_vendor_first_reported_LENGTHS_ErrorCount
          ,le.dt_vendor_last_reported_LEFTTRIM_ErrorCount,le.dt_vendor_last_reported_ALLOW_ErrorCount,le.dt_vendor_last_reported_LENGTHS_ErrorCount
          ,le.seqno_LEFTTRIM_ErrorCount,le.seqno_LENGTHS_ErrorCount
          ,le.geoid10_blkgrp_LEFTTRIM_ErrorCount,le.geoid10_blkgrp_ALLOW_ErrorCount,le.geoid10_blkgrp_LENGTHS_ErrorCount
          ,le.state_fips10_LEFTTRIM_ErrorCount,le.state_fips10_ALLOW_ErrorCount,le.state_fips10_LENGTHS_ErrorCount
          ,le.county_fips10_LEFTTRIM_ErrorCount,le.county_fips10_ALLOW_ErrorCount,le.county_fips10_LENGTHS_ErrorCount
          ,le.tract_fips10_LEFTTRIM_ErrorCount,le.tract_fips10_ALLOW_ErrorCount,le.tract_fips10_LENGTHS_ErrorCount
          ,le.blkgrp_fips10_LEFTTRIM_ErrorCount,le.blkgrp_fips10_LENGTHS_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.record_sid_LEFTTRIM_ErrorCount,le.record_sid_LENGTHS_ErrorCount
          ,le.global_src_id_LEFTTRIM_ErrorCount,le.global_src_id_LENGTHS_ErrorCount
          ,le.dt_vendor_first_reported_LEFTTRIM_ErrorCount,le.dt_vendor_first_reported_ALLOW_ErrorCount,le.dt_vendor_first_reported_LENGTHS_ErrorCount
          ,le.dt_vendor_last_reported_LEFTTRIM_ErrorCount,le.dt_vendor_last_reported_ALLOW_ErrorCount,le.dt_vendor_last_reported_LENGTHS_ErrorCount
          ,le.seqno_LEFTTRIM_ErrorCount,le.seqno_LENGTHS_ErrorCount
          ,le.geoid10_blkgrp_LEFTTRIM_ErrorCount,le.geoid10_blkgrp_ALLOW_ErrorCount,le.geoid10_blkgrp_LENGTHS_ErrorCount
          ,le.state_fips10_LEFTTRIM_ErrorCount,le.state_fips10_ALLOW_ErrorCount,le.state_fips10_LENGTHS_ErrorCount
          ,le.county_fips10_LEFTTRIM_ErrorCount,le.county_fips10_ALLOW_ErrorCount,le.county_fips10_LENGTHS_ErrorCount
          ,le.tract_fips10_LEFTTRIM_ErrorCount,le.tract_fips10_ALLOW_ErrorCount,le.tract_fips10_LENGTHS_ErrorCount
          ,le.blkgrp_fips10_LEFTTRIM_ErrorCount,le.blkgrp_fips10_LENGTHS_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Layout_CFPB));
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
          ,'record_sid:' + getFieldTypeText(h.record_sid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'global_src_id:' + getFieldTypeText(h.global_src_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_first_reported:' + getFieldTypeText(h.dt_vendor_first_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_last_reported:' + getFieldTypeText(h.dt_vendor_last_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'is_latest:' + getFieldTypeText(h.is_latest) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'seqno:' + getFieldTypeText(h.seqno) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geoid10_blkgrp:' + getFieldTypeText(h.geoid10_blkgrp) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state_fips10:' + getFieldTypeText(h.state_fips10) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county_fips10:' + getFieldTypeText(h.county_fips10) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tract_fips10:' + getFieldTypeText(h.tract_fips10) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'blkgrp_fips10:' + getFieldTypeText(h.blkgrp_fips10) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_pop:' + getFieldTypeText(h.total_pop) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hispanic_total:' + getFieldTypeText(h.hispanic_total) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'non_hispanic_total:' + getFieldTypeText(h.non_hispanic_total) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nh_white_alone:' + getFieldTypeText(h.nh_white_alone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nh_black_alone:' + getFieldTypeText(h.nh_black_alone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nh_aian_alone:' + getFieldTypeText(h.nh_aian_alone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nh_api_alone:' + getFieldTypeText(h.nh_api_alone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nh_other_alone:' + getFieldTypeText(h.nh_other_alone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nh_mult_total:' + getFieldTypeText(h.nh_mult_total) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nh_white_other:' + getFieldTypeText(h.nh_white_other) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nh_black_other:' + getFieldTypeText(h.nh_black_other) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nh_aian_other:' + getFieldTypeText(h.nh_aian_other) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nh_asian_hpi:' + getFieldTypeText(h.nh_asian_hpi) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nh_api_other:' + getFieldTypeText(h.nh_api_other) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nh_asian_hpi_other:' + getFieldTypeText(h.nh_asian_hpi_other) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_record_sid_cnt
          ,le.populated_global_src_id_cnt
          ,le.populated_dt_vendor_first_reported_cnt
          ,le.populated_dt_vendor_last_reported_cnt
          ,le.populated_is_latest_cnt
          ,le.populated_seqno_cnt
          ,le.populated_geoid10_blkgrp_cnt
          ,le.populated_state_fips10_cnt
          ,le.populated_county_fips10_cnt
          ,le.populated_tract_fips10_cnt
          ,le.populated_blkgrp_fips10_cnt
          ,le.populated_total_pop_cnt
          ,le.populated_hispanic_total_cnt
          ,le.populated_non_hispanic_total_cnt
          ,le.populated_nh_white_alone_cnt
          ,le.populated_nh_black_alone_cnt
          ,le.populated_nh_aian_alone_cnt
          ,le.populated_nh_api_alone_cnt
          ,le.populated_nh_other_alone_cnt
          ,le.populated_nh_mult_total_cnt
          ,le.populated_nh_white_other_cnt
          ,le.populated_nh_black_other_cnt
          ,le.populated_nh_aian_other_cnt
          ,le.populated_nh_asian_hpi_cnt
          ,le.populated_nh_api_other_cnt
          ,le.populated_nh_asian_hpi_other_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_record_sid_pcnt
          ,le.populated_global_src_id_pcnt
          ,le.populated_dt_vendor_first_reported_pcnt
          ,le.populated_dt_vendor_last_reported_pcnt
          ,le.populated_is_latest_pcnt
          ,le.populated_seqno_pcnt
          ,le.populated_geoid10_blkgrp_pcnt
          ,le.populated_state_fips10_pcnt
          ,le.populated_county_fips10_pcnt
          ,le.populated_tract_fips10_pcnt
          ,le.populated_blkgrp_fips10_pcnt
          ,le.populated_total_pop_pcnt
          ,le.populated_hispanic_total_pcnt
          ,le.populated_non_hispanic_total_pcnt
          ,le.populated_nh_white_alone_pcnt
          ,le.populated_nh_black_alone_pcnt
          ,le.populated_nh_aian_alone_pcnt
          ,le.populated_nh_api_alone_pcnt
          ,le.populated_nh_other_alone_pcnt
          ,le.populated_nh_mult_total_pcnt
          ,le.populated_nh_white_other_pcnt
          ,le.populated_nh_black_other_pcnt
          ,le.populated_nh_aian_other_pcnt
          ,le.populated_nh_asian_hpi_pcnt
          ,le.populated_nh_api_other_pcnt
          ,le.populated_nh_asian_hpi_other_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,26,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_CFPB));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),26,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_CFPB) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_CFPB, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
