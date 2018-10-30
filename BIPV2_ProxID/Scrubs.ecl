IMPORT SALT311,STD;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 9;
  EXPORT NumRulesFromFieldType := 9;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 4;
  EXPORT NumFieldsWithPossibleEdits := 2;
  EXPORT NumRulesWithPossibleEdits := 6;
  EXPORT Expanded_Layout := RECORD(Layout_DOT_Base)
    UNSIGNED1 st_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 cnp_name_Invalid;
    BOOLEAN cnp_name_wouldSkip;
    BOOLEAN cnp_name_wouldClean;
    UNSIGNED1 prim_name_derived_Invalid;
    BOOLEAN prim_name_derived_wouldSkip;
    BOOLEAN prim_name_derived_wouldClean;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_DOT_Base)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsCleanBits1;
  END;
EXPORT FromNone(DATASET(Layout_DOT_Base) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.st_Invalid := Fields.InValid_st((SALT311.StrType)le.st);
    SELF.zip_Invalid := Fields.InValid_zip((SALT311.StrType)le.zip);
    SELF.cnp_name_Invalid := Fields.InValid_cnp_name((SALT311.StrType)le.cnp_name);
    clean_cnp_name := (TYPEOF(le.cnp_name))Fields.Make_cnp_name((SALT311.StrType)le.cnp_name);
    clean_cnp_name_Invalid := Fields.InValid_cnp_name((SALT311.StrType)clean_cnp_name);
    SELF.cnp_name := IF(withOnfail, IF(clean_cnp_name_Invalid=0, clean_cnp_name, SKIP), le.cnp_name); // ONFAIL(CLEAN,REJECT)
    SELF.cnp_name_wouldClean := TRIM((SALT311.StrType)le.cnp_name) <> TRIM((SALT311.StrType)clean_cnp_name);
    SELF.cnp_name_wouldSkip := clean_cnp_name_Invalid > 0;
    SELF.prim_name_derived_Invalid := Fields.InValid_prim_name_derived((SALT311.StrType)le.prim_name_derived);
    clean_prim_name_derived := (TYPEOF(le.prim_name_derived))Fields.Make_prim_name_derived((SALT311.StrType)le.prim_name_derived);
    clean_prim_name_derived_Invalid := Fields.InValid_prim_name_derived((SALT311.StrType)clean_prim_name_derived);
    SELF.prim_name_derived := IF(withOnfail, IF(clean_prim_name_derived_Invalid=0, clean_prim_name_derived, SKIP), le.prim_name_derived); // ONFAIL(CLEAN,REJECT)
    SELF.prim_name_derived_wouldClean := TRIM((SALT311.StrType)le.prim_name_derived) <> TRIM((SALT311.StrType)clean_prim_name_derived);
    SELF.prim_name_derived_wouldSkip := clean_prim_name_derived_Invalid > 0;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_DOT_Base);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.st_Invalid << 0 ) + ( le.zip_Invalid << 2 ) + ( le.cnp_name_Invalid << 3 ) + ( le.prim_name_derived_Invalid << 5 );
    SELF.ScrubsCleanBits1 := ( IF(le.cnp_name_wouldSkip, 1, 0) << 0 ) + ( IF(le.cnp_name_wouldClean, 1, 0) << 1 ) + ( IF(le.prim_name_derived_wouldSkip, 1, 0) << 2 ) + ( IF(le.prim_name_derived_wouldClean, 1, 0) << 3 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_DOT_Base);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.st_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.cnp_name_Invalid := (le.ScrubsBits1 >> 3) & 3;
    SELF.prim_name_derived_Invalid := (le.ScrubsBits1 >> 5) & 3;
    SELF.cnp_name_wouldSkip := le.ScrubsCleanBits1 >> 0;
    SELF.cnp_name_wouldClean := le.ScrubsCleanBits1 >> 1;
    SELF.prim_name_derived_wouldSkip := le.ScrubsCleanBits1 >> 2;
    SELF.prim_name_derived_wouldClean := le.ScrubsCleanBits1 >> 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
    FromNew := FromNone(InFile).ExpandedInfile;
  EXPORT Changed := JOIN(ExpandedInfile,FromNew, LEFT.rcid=RIGHT.rcid AND (LEFT.st_Invalid <> RIGHT.st_Invalid OR LEFT.zip_Invalid <> RIGHT.zip_Invalid OR LEFT.cnp_name_Invalid <> RIGHT.cnp_name_Invalid OR LEFT.prim_name_derived_Invalid <> RIGHT.prim_name_derived_Invalid), TRANSFORM(RIGHT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h, BOOLEAN Glob = FALSE) := MODULE
  r := RECORD
    TYPEOF(h.source) source := IF(Glob, '', h.source);
    TotalCnt := COUNT(GROUP); // Number of records in total
    st_CAPS_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    st_ALLOW_ErrorCount := COUNT(GROUP,h.st_Invalid=2);
    st_Total_ErrorCount := COUNT(GROUP,h.st_Invalid>0);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    cnp_name_CAPS_ErrorCount := COUNT(GROUP,h.cnp_name_Invalid=1);
    cnp_name_CAPS_WouldModifyCount := COUNT(GROUP,h.cnp_name_Invalid=1 AND h.cnp_name_wouldClean);
    cnp_name_CAPS_WouldSkipRecCount := COUNT(GROUP,h.cnp_name_Invalid=1 AND h.cnp_name_wouldSkip);
    cnp_name_ALLOW_ErrorCount := COUNT(GROUP,h.cnp_name_Invalid=2);
    cnp_name_ALLOW_WouldModifyCount := COUNT(GROUP,h.cnp_name_Invalid=2 AND h.cnp_name_wouldClean);
    cnp_name_ALLOW_WouldSkipRecCount := COUNT(GROUP,h.cnp_name_Invalid=2 AND h.cnp_name_wouldSkip);
    cnp_name_LENGTHS_ErrorCount := COUNT(GROUP,h.cnp_name_Invalid=3);
    cnp_name_LENGTHS_WouldModifyCount := COUNT(GROUP,h.cnp_name_Invalid=3 AND h.cnp_name_wouldClean);
    cnp_name_LENGTHS_WouldSkipRecCount := COUNT(GROUP,h.cnp_name_Invalid=3 AND h.cnp_name_wouldSkip);
    cnp_name_Total_ErrorCount := COUNT(GROUP,h.cnp_name_Invalid>0);
    prim_name_derived_CAPS_ErrorCount := COUNT(GROUP,h.prim_name_derived_Invalid=1);
    prim_name_derived_CAPS_WouldModifyCount := COUNT(GROUP,h.prim_name_derived_Invalid=1 AND h.prim_name_derived_wouldClean);
    prim_name_derived_CAPS_WouldSkipRecCount := COUNT(GROUP,h.prim_name_derived_Invalid=1 AND h.prim_name_derived_wouldSkip);
    prim_name_derived_ALLOW_ErrorCount := COUNT(GROUP,h.prim_name_derived_Invalid=2);
    prim_name_derived_ALLOW_WouldModifyCount := COUNT(GROUP,h.prim_name_derived_Invalid=2 AND h.prim_name_derived_wouldClean);
    prim_name_derived_ALLOW_WouldSkipRecCount := COUNT(GROUP,h.prim_name_derived_Invalid=2 AND h.prim_name_derived_wouldSkip);
    prim_name_derived_LENGTHS_ErrorCount := COUNT(GROUP,h.prim_name_derived_Invalid=3);
    prim_name_derived_LENGTHS_WouldModifyCount := COUNT(GROUP,h.prim_name_derived_Invalid=3 AND h.prim_name_derived_wouldClean);
    prim_name_derived_LENGTHS_WouldSkipRecCount := COUNT(GROUP,h.prim_name_derived_Invalid=3 AND h.prim_name_derived_wouldSkip);
    prim_name_derived_Total_ErrorCount := COUNT(GROUP,h.prim_name_derived_Invalid>0);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.st_Invalid > 0 OR h.zip_Invalid > 0 OR h.cnp_name_Invalid > 0 OR h.prim_name_derived_Invalid > 0);
    AnyRule_WithEditsCount := COUNT(GROUP, h.cnp_name_wouldClean OR h.cnp_name_wouldSkip OR h.prim_name_derived_wouldClean OR h.prim_name_derived_wouldSkip);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
    Rules_WithEdits := 0;
  END;
  SummaryStats0 := IF(Glob, TABLE(h,r), TABLE(h,r,source,FEW));
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.st_Total_ErrorCount > 0, 1, 0) + IF(le.zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cnp_name_Total_ErrorCount > 0, 1, 0) + IF(le.prim_name_derived_Total_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.st_CAPS_ErrorCount > 0, 1, 0) + IF(le.st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cnp_name_CAPS_ErrorCount > 0, 1, 0) + IF(le.cnp_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cnp_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prim_name_derived_CAPS_ErrorCount > 0, 1, 0) + IF(le.prim_name_derived_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_name_derived_LENGTHS_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF.Rules_WithEdits := IF(le.cnp_name_CAPS_WouldModifyCount > 0, 1, 0) + IF(le.cnp_name_CAPS_WouldSkipRecCount > 0, 1, 0) + IF(le.cnp_name_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.cnp_name_ALLOW_WouldSkipRecCount > 0, 1, 0) + IF(le.cnp_name_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.cnp_name_LENGTHS_WouldSkipRecCount > 0, 1, 0) + IF(le.prim_name_derived_CAPS_WouldModifyCount > 0, 1, 0) + IF(le.prim_name_derived_CAPS_WouldSkipRecCount > 0, 1, 0) + IF(le.prim_name_derived_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.prim_name_derived_ALLOW_WouldSkipRecCount > 0, 1, 0) + IF(le.prim_name_derived_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.prim_name_derived_LENGTHS_WouldSkipRecCount > 0, 1, 0);
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
    SELF.Src :=  le.source;
    UNSIGNED1 ErrNum := CHOOSE(c,le.st_Invalid,le.zip_Invalid,le.cnp_name_Invalid,le.prim_name_derived_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_st(le.st_Invalid),Fields.InvalidMessage_zip(le.zip_Invalid),Fields.InvalidMessage_cnp_name(le.cnp_name_Invalid),Fields.InvalidMessage_prim_name_derived(le.prim_name_derived_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.st_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cnp_name_Invalid,'CAPS','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.prim_name_derived_Invalid,'CAPS','ALLOW','LENGTHS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'st','zip','cnp_name','prim_name_derived','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'alpha','number','Noblanks','Noblanks','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.st,(SALT311.StrType)le.zip,(SALT311.StrType)le.cnp_name,(SALT311.StrType)le.prim_name_derived,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,4,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_DOT_Base) prevDS = DATASET([], Layout_DOT_Base)):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.source;
      SELF.ruledesc := CHOOSE(c
          ,'st:alpha:CAPS','st:alpha:ALLOW'
          ,'zip:number:ALLOW'
          ,'cnp_name:Noblanks:CAPS','cnp_name:Noblanks:ALLOW','cnp_name:Noblanks:LENGTHS'
          ,'prim_name_derived:Noblanks:CAPS','prim_name_derived:Noblanks:ALLOW','prim_name_derived:Noblanks:LENGTHS'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY'
          ,'record:Number_Edited_Records:SUMMARY'
          ,'rule:Number_Edited_Rules:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_st(1),Fields.InvalidMessage_st(2)
          ,Fields.InvalidMessage_zip(1)
          ,Fields.InvalidMessage_cnp_name(1),Fields.InvalidMessage_cnp_name(2),Fields.InvalidMessage_cnp_name(3)
          ,Fields.InvalidMessage_prim_name_derived(1),Fields.InvalidMessage_prim_name_derived(2),Fields.InvalidMessage_prim_name_derived(3)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors'
          ,'Edited records'
          ,'Rules leading to edits','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.st_CAPS_ErrorCount,le.st_ALLOW_ErrorCount
          ,le.zip_ALLOW_ErrorCount
          ,le.cnp_name_CAPS_ErrorCount,le.cnp_name_ALLOW_ErrorCount,le.cnp_name_LENGTHS_ErrorCount
          ,le.prim_name_derived_CAPS_ErrorCount,le.prim_name_derived_ALLOW_ErrorCount,le.prim_name_derived_LENGTHS_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount
          ,le.AnyRule_WithEditsCount
          ,le.Rules_WithEdits,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.st_CAPS_ErrorCount,le.st_ALLOW_ErrorCount
          ,le.zip_ALLOW_ErrorCount
          ,le.cnp_name_CAPS_ErrorCount,le.cnp_name_ALLOW_ErrorCount,le.cnp_name_LENGTHS_ErrorCount
          ,le.prim_name_derived_CAPS_ErrorCount,le.prim_name_derived_ALLOW_ErrorCount,le.prim_name_derived_LENGTHS_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_WithErrors/NumFieldsWithRules * 100)
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_NoErrors/NumFieldsWithRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_WithErrors/NumRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_NoErrors/NumRules * 100)
          ,0
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithErrorsCount/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, (SELF.recordstotal - le.AnyRule_WithErrorsCount)/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithEditsCount/SELF.recordstotal * 100)
          ,IF(NumRulesWithPossibleEdits = 0, 0, le.Rules_WithEdits/NumRulesWithPossibleEdits * 100),0));
    END;
    SummaryInfo := NORMALIZE(SummaryStats,NumRules + 9,Into(LEFT,COUNTER));
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
    jGlob := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    jSrc := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    j := IF(Glob, jGlob, jSrc);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := hygiene(PROJECT(h, Layout_DOT_Base));
    hygiene_summaryStats := mod_hygiene.Summary('', Glob);
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT311.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.Source;
      SELF.ruledesc := CHOOSE(c
          ,'cnp_number:' + getFieldTypeText(h.cnp_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'st:' + getFieldTypeText(h.st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_range_derived:' + getFieldTypeText(h.prim_range_derived) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hist_enterprise_number:' + getFieldTypeText(h.hist_enterprise_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ebr_file_number:' + getFieldTypeText(h.ebr_file_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'active_enterprise_number:' + getFieldTypeText(h.active_enterprise_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hist_domestic_corp_key:' + getFieldTypeText(h.hist_domestic_corp_key) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'foreign_corp_key:' + getFieldTypeText(h.foreign_corp_key) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unk_corp_key:' + getFieldTypeText(h.unk_corp_key) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'active_domestic_corp_key:' + getFieldTypeText(h.active_domestic_corp_key) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hist_duns_number:' + getFieldTypeText(h.hist_duns_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'active_duns_number:' + getFieldTypeText(h.active_duns_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_phone:' + getFieldTypeText(h.company_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_fein:' + getFieldTypeText(h.company_fein) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip:' + getFieldTypeText(h.zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cnp_name:' + getFieldTypeText(h.cnp_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_name_derived:' + getFieldTypeText(h.prim_name_derived) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sec_range:' + getFieldTypeText(h.sec_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v_city_name:' + getFieldTypeText(h.v_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cnp_btype:' + getFieldTypeText(h.cnp_btype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_name_type_derived:' + getFieldTypeText(h.company_name_type_derived) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_name:' + getFieldTypeText(h.company_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_name_type_raw:' + getFieldTypeText(h.company_name_type_raw) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cnp_hasnumber:' + getFieldTypeText(h.cnp_hasnumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cnp_lowv:' + getFieldTypeText(h.cnp_lowv) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cnp_translated:' + getFieldTypeText(h.cnp_translated) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cnp_classid:' + getFieldTypeText(h.cnp_classid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_foreign_domestic:' + getFieldTypeText(h.company_foreign_domestic) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_bdid:' + getFieldTypeText(h.company_bdid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_name:' + getFieldTypeText(h.prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_range:' + getFieldTypeText(h.prim_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_first_seen:' + getFieldTypeText(h.dt_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_last_seen:' + getFieldTypeText(h.dt_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_cnp_number_cnt
          ,le.populated_st_cnt
          ,le.populated_prim_range_derived_cnt
          ,le.populated_hist_enterprise_number_cnt
          ,le.populated_ebr_file_number_cnt
          ,le.populated_active_enterprise_number_cnt
          ,le.populated_hist_domestic_corp_key_cnt
          ,le.populated_foreign_corp_key_cnt
          ,le.populated_unk_corp_key_cnt
          ,le.populated_active_domestic_corp_key_cnt
          ,le.populated_hist_duns_number_cnt
          ,le.populated_active_duns_number_cnt
          ,le.populated_company_phone_cnt
          ,le.populated_company_fein_cnt
          ,le.populated_zip_cnt
          ,le.populated_cnp_name_cnt
          ,le.populated_prim_name_derived_cnt
          ,le.populated_sec_range_cnt
          ,le.populated_v_city_name_cnt
          ,le.populated_cnp_btype_cnt
          ,le.populated_company_name_type_derived_cnt
          ,le.populated_company_name_cnt
          ,le.populated_company_name_type_raw_cnt
          ,le.populated_cnp_hasnumber_cnt
          ,le.populated_cnp_lowv_cnt
          ,le.populated_cnp_translated_cnt
          ,le.populated_cnp_classid_cnt
          ,le.populated_company_foreign_domestic_cnt
          ,le.populated_company_bdid_cnt
          ,le.populated_prim_name_cnt
          ,le.populated_prim_range_cnt
          ,le.populated_dt_first_seen_cnt
          ,le.populated_dt_last_seen_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_cnp_number_pcnt
          ,le.populated_st_pcnt
          ,le.populated_prim_range_derived_pcnt
          ,le.populated_hist_enterprise_number_pcnt
          ,le.populated_ebr_file_number_pcnt
          ,le.populated_active_enterprise_number_pcnt
          ,le.populated_hist_domestic_corp_key_pcnt
          ,le.populated_foreign_corp_key_pcnt
          ,le.populated_unk_corp_key_pcnt
          ,le.populated_active_domestic_corp_key_pcnt
          ,le.populated_hist_duns_number_pcnt
          ,le.populated_active_duns_number_pcnt
          ,le.populated_company_phone_pcnt
          ,le.populated_company_fein_pcnt
          ,le.populated_zip_pcnt
          ,le.populated_cnp_name_pcnt
          ,le.populated_prim_name_derived_pcnt
          ,le.populated_sec_range_pcnt
          ,le.populated_v_city_name_pcnt
          ,le.populated_cnp_btype_pcnt
          ,le.populated_company_name_type_derived_pcnt
          ,le.populated_company_name_pcnt
          ,le.populated_company_name_type_raw_pcnt
          ,le.populated_cnp_hasnumber_pcnt
          ,le.populated_cnp_lowv_pcnt
          ,le.populated_cnp_translated_pcnt
          ,le.populated_cnp_classid_pcnt
          ,le.populated_company_foreign_domestic_pcnt
          ,le.populated_company_bdid_pcnt
          ,le.populated_prim_name_pcnt
          ,le.populated_prim_range_pcnt
          ,le.populated_dt_first_seen_pcnt
          ,le.populated_dt_last_seen_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,33,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT311.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.Source;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_DOT_Base));
    deltaHygieneSummary := mod_Delta.DifferenceSummary(Glob);
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),33,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_DOT_Base) inFile, BOOLEAN doErrorOverall = TRUE, BOOLEAN doErrorPerSrc = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedPerSource := FromExpanded(expandedFile, FALSE);
  mod_fromexpandedOverall := FromExpanded(expandedFile, TRUE);
  scrubsSummaryPerSource := mod_fromexpandedPerSource.SummaryStats;
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(BIPV2_ProxID, Fields, 'RECORDOF(scrubsSummaryOverall)', 'source');
  scrubsSummaryPerSource_Standard := NORMALIZE(scrubsSummaryPerSource, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'src', 'src'));
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsPerSource := mod_fromexpandedPerSource.AllErrors;
  tErrsPerSource := TABLE(DISTRIBUTE(allErrsPerSource, HASH(src, FieldName, ErrorType)), {src, FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, src, FieldName, ErrorType, FieldContents, LOCAL);
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryPerSource_Standard_addErr := IF(doErrorPerSrc,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryPerSource_Standard, HASH(source, field, ruletype)), source, field, ruletype, LOCAL),
  	                                                       SORT(tErrsPerSource, src, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.source = RIGHT.src AND LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryPerSource_Standard_GeneralErrs := IF(doErrorPerSrc, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryPerSource, source, myTimeStamp, 'src', 'src'));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryPerSource_Standard_addErr & scrubsSummaryPerSource_Standard_GeneralErrs & scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
