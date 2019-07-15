IMPORT SALT311,STD;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 8;
  EXPORT NumRulesFromFieldType := 8;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 4;
  EXPORT NumFieldsWithPossibleEdits := 4;
  EXPORT NumRulesWithPossibleEdits := 8;
  EXPORT Expanded_Layout := RECORD(Layout_Address_Link)
    UNSIGNED1 prim_range_num_Invalid;
    BOOLEAN prim_range_num_wouldClean;
    UNSIGNED1 prim_name_num_Invalid;
    BOOLEAN prim_name_num_wouldClean;
    UNSIGNED1 prim_name_alpha_Invalid;
    BOOLEAN prim_name_alpha_wouldClean;
    UNSIGNED1 city_Invalid;
    BOOLEAN city_wouldClean;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_Address_Link)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsCleanBits1;
  END;
EXPORT FromNone(DATASET(Layout_Address_Link) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.prim_range_num_Invalid := Fields.InValid_prim_range_num((SALT311.StrType)le.prim_range_num);
    clean_prim_range_num := (TYPEOF(le.prim_range_num))Fields.Make_prim_range_num((SALT311.StrType)le.prim_range_num);
    clean_prim_range_num_Invalid := Fields.InValid_prim_range_num((SALT311.StrType)clean_prim_range_num);
    SELF.prim_range_num := IF(withOnfail, clean_prim_range_num, le.prim_range_num); // ONFAIL(CLEAN)
    SELF.prim_range_num_wouldClean := TRIM((SALT311.StrType)le.prim_range_num) <> TRIM((SALT311.StrType)clean_prim_range_num);
    SELF.prim_name_num_Invalid := Fields.InValid_prim_name_num((SALT311.StrType)le.prim_name_num);
    clean_prim_name_num := (TYPEOF(le.prim_name_num))Fields.Make_prim_name_num((SALT311.StrType)le.prim_name_num);
    clean_prim_name_num_Invalid := Fields.InValid_prim_name_num((SALT311.StrType)clean_prim_name_num);
    SELF.prim_name_num := IF(withOnfail, clean_prim_name_num, le.prim_name_num); // ONFAIL(CLEAN)
    SELF.prim_name_num_wouldClean := TRIM((SALT311.StrType)le.prim_name_num) <> TRIM((SALT311.StrType)clean_prim_name_num);
    SELF.prim_name_alpha_Invalid := Fields.InValid_prim_name_alpha((SALT311.StrType)le.prim_name_alpha);
    clean_prim_name_alpha := (TYPEOF(le.prim_name_alpha))Fields.Make_prim_name_alpha((SALT311.StrType)le.prim_name_alpha);
    clean_prim_name_alpha_Invalid := Fields.InValid_prim_name_alpha((SALT311.StrType)clean_prim_name_alpha);
    SELF.prim_name_alpha := IF(withOnfail, clean_prim_name_alpha, le.prim_name_alpha); // ONFAIL(CLEAN)
    SELF.prim_name_alpha_wouldClean := TRIM((SALT311.StrType)le.prim_name_alpha) <> TRIM((SALT311.StrType)clean_prim_name_alpha);
    SELF.city_Invalid := Fields.InValid_city((SALT311.StrType)le.city);
    clean_city := (TYPEOF(le.city))Fields.Make_city((SALT311.StrType)le.city);
    clean_city_Invalid := Fields.InValid_city((SALT311.StrType)clean_city);
    SELF.city := IF(withOnfail, clean_city, le.city); // ONFAIL(CLEAN)
    SELF.city_wouldClean := TRIM((SALT311.StrType)le.city) <> TRIM((SALT311.StrType)clean_city);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_Address_Link);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.prim_range_num_Invalid << 0 ) + ( le.prim_name_num_Invalid << 2 ) + ( le.prim_name_alpha_Invalid << 4 ) + ( le.city_Invalid << 6 );
    SELF.ScrubsCleanBits1 := ( IF(le.prim_range_num_wouldClean, 1, 0) << 0 ) + ( IF(le.prim_name_num_wouldClean, 1, 0) << 1 ) + ( IF(le.prim_name_alpha_wouldClean, 1, 0) << 2 ) + ( IF(le.city_wouldClean, 1, 0) << 3 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_Address_Link);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.prim_range_num_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.prim_name_num_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.prim_name_alpha_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.city_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.prim_range_num_wouldClean := le.ScrubsCleanBits1 >> 0;
    SELF.prim_name_num_wouldClean := le.ScrubsCleanBits1 >> 1;
    SELF.prim_name_alpha_wouldClean := le.ScrubsCleanBits1 >> 2;
    SELF.city_wouldClean := le.ScrubsCleanBits1 >> 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
    FromNew := FromNone(InFile).ExpandedInfile;
  EXPORT Changed := JOIN(ExpandedInfile,FromNew, LEFT.RID=RIGHT.RID AND (LEFT.prim_range_num_Invalid <> RIGHT.prim_range_num_Invalid OR LEFT.prim_name_num_Invalid <> RIGHT.prim_name_num_Invalid OR LEFT.prim_name_alpha_Invalid <> RIGHT.prim_name_alpha_Invalid OR LEFT.city_Invalid <> RIGHT.city_Invalid), TRANSFORM(RIGHT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    prim_range_num_CAPS_ErrorCount := COUNT(GROUP,h.prim_range_num_Invalid=1);
    prim_range_num_CAPS_WouldModifyCount := COUNT(GROUP,h.prim_range_num_Invalid=1 AND h.prim_range_num_wouldClean);
    prim_range_num_ALLOW_ErrorCount := COUNT(GROUP,h.prim_range_num_Invalid=2);
    prim_range_num_ALLOW_WouldModifyCount := COUNT(GROUP,h.prim_range_num_Invalid=2 AND h.prim_range_num_wouldClean);
    prim_range_num_Total_ErrorCount := COUNT(GROUP,h.prim_range_num_Invalid>0);
    prim_name_num_CAPS_ErrorCount := COUNT(GROUP,h.prim_name_num_Invalid=1);
    prim_name_num_CAPS_WouldModifyCount := COUNT(GROUP,h.prim_name_num_Invalid=1 AND h.prim_name_num_wouldClean);
    prim_name_num_ALLOW_ErrorCount := COUNT(GROUP,h.prim_name_num_Invalid=2);
    prim_name_num_ALLOW_WouldModifyCount := COUNT(GROUP,h.prim_name_num_Invalid=2 AND h.prim_name_num_wouldClean);
    prim_name_num_Total_ErrorCount := COUNT(GROUP,h.prim_name_num_Invalid>0);
    prim_name_alpha_CAPS_ErrorCount := COUNT(GROUP,h.prim_name_alpha_Invalid=1);
    prim_name_alpha_CAPS_WouldModifyCount := COUNT(GROUP,h.prim_name_alpha_Invalid=1 AND h.prim_name_alpha_wouldClean);
    prim_name_alpha_ALLOW_ErrorCount := COUNT(GROUP,h.prim_name_alpha_Invalid=2);
    prim_name_alpha_ALLOW_WouldModifyCount := COUNT(GROUP,h.prim_name_alpha_Invalid=2 AND h.prim_name_alpha_wouldClean);
    prim_name_alpha_Total_ErrorCount := COUNT(GROUP,h.prim_name_alpha_Invalid>0);
    city_CAPS_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    city_CAPS_WouldModifyCount := COUNT(GROUP,h.city_Invalid=1 AND h.city_wouldClean);
    city_ALLOW_ErrorCount := COUNT(GROUP,h.city_Invalid=2);
    city_ALLOW_WouldModifyCount := COUNT(GROUP,h.city_Invalid=2 AND h.city_wouldClean);
    city_Total_ErrorCount := COUNT(GROUP,h.city_Invalid>0);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.prim_range_num_Invalid > 0 OR h.prim_name_num_Invalid > 0 OR h.prim_name_alpha_Invalid > 0 OR h.city_Invalid > 0);
    AnyRule_WithEditsCount := COUNT(GROUP, h.prim_range_num_wouldClean OR h.prim_name_num_wouldClean OR h.prim_name_alpha_wouldClean OR h.city_wouldClean);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
    Rules_WithEdits := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.prim_range_num_Total_ErrorCount > 0, 1, 0) + IF(le.prim_name_num_Total_ErrorCount > 0, 1, 0) + IF(le.prim_name_alpha_Total_ErrorCount > 0, 1, 0) + IF(le.city_Total_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.prim_range_num_CAPS_ErrorCount > 0, 1, 0) + IF(le.prim_range_num_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_name_num_CAPS_ErrorCount > 0, 1, 0) + IF(le.prim_name_num_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_name_alpha_CAPS_ErrorCount > 0, 1, 0) + IF(le.prim_name_alpha_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_CAPS_ErrorCount > 0, 1, 0) + IF(le.city_ALLOW_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF.Rules_WithEdits := IF(le.prim_range_num_CAPS_WouldModifyCount > 0, 1, 0) + IF(le.prim_range_num_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.prim_name_num_CAPS_WouldModifyCount > 0, 1, 0) + IF(le.prim_name_num_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.prim_name_alpha_CAPS_WouldModifyCount > 0, 1, 0) + IF(le.prim_name_alpha_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.city_CAPS_WouldModifyCount > 0, 1, 0) + IF(le.city_ALLOW_WouldModifyCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.prim_range_num_Invalid,le.prim_name_num_Invalid,le.prim_name_alpha_Invalid,le.city_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_prim_range_num(le.prim_range_num_Invalid),Fields.InvalidMessage_prim_name_num(le.prim_name_num_Invalid),Fields.InvalidMessage_prim_name_alpha(le.prim_name_alpha_Invalid),Fields.InvalidMessage_city(le.city_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.prim_range_num_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.prim_name_num_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.prim_name_alpha_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'CAPS','ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'prim_range_num','prim_name_num','prim_name_alpha','city','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'WORDBAG','WORDBAG','WORDBAG','WORDBAG','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.prim_range_num,(SALT311.StrType)le.prim_name_num,(SALT311.StrType)le.prim_name_alpha,(SALT311.StrType)le.city,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,4,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_Address_Link) prevDS = DATASET([], Layout_Address_Link), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'prim_range_num:WORDBAG:CAPS','prim_range_num:WORDBAG:ALLOW'
          ,'prim_name_num:WORDBAG:CAPS','prim_name_num:WORDBAG:ALLOW'
          ,'prim_name_alpha:WORDBAG:CAPS','prim_name_alpha:WORDBAG:ALLOW'
          ,'city:WORDBAG:CAPS','city:WORDBAG:ALLOW'
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
          ,Fields.InvalidMessage_prim_range_num(1),Fields.InvalidMessage_prim_range_num(2)
          ,Fields.InvalidMessage_prim_name_num(1),Fields.InvalidMessage_prim_name_num(2)
          ,Fields.InvalidMessage_prim_name_alpha(1),Fields.InvalidMessage_prim_name_alpha(2)
          ,Fields.InvalidMessage_city(1),Fields.InvalidMessage_city(2)
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
          ,le.prim_range_num_CAPS_ErrorCount,le.prim_range_num_ALLOW_ErrorCount
          ,le.prim_name_num_CAPS_ErrorCount,le.prim_name_num_ALLOW_ErrorCount
          ,le.prim_name_alpha_CAPS_ErrorCount,le.prim_name_alpha_ALLOW_ErrorCount
          ,le.city_CAPS_ErrorCount,le.city_ALLOW_ErrorCount
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
          ,le.prim_range_num_CAPS_ErrorCount,le.prim_range_num_ALLOW_ErrorCount
          ,le.prim_name_num_CAPS_ErrorCount,le.prim_name_num_ALLOW_ErrorCount
          ,le.prim_name_alpha_CAPS_ErrorCount,le.prim_name_alpha_ALLOW_ErrorCount
          ,le.city_CAPS_ErrorCount,le.city_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := hygiene(PROJECT(h, Layout_Address_Link));
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
          ,'DID:' + getFieldTypeText(h.DID) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip:' + getFieldTypeText(h.zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_range_num:' + getFieldTypeText(h.prim_range_num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_name_num:' + getFieldTypeText(h.prim_name_num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_range_alpha:' + getFieldTypeText(h.prim_range_alpha) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_name_alpha:' + getFieldTypeText(h.prim_name_alpha) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_range_fract:' + getFieldTypeText(h.prim_range_fract) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sec_range_alpha:' + getFieldTypeText(h.sec_range_alpha) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sec_range_num:' + getFieldTypeText(h.sec_range_num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city:' + getFieldTypeText(h.city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'st:' + getFieldTypeText(h.st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src:' + getFieldTypeText(h.src) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_first_seen:' + getFieldTypeText(h.dt_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_last_seen:' + getFieldTypeText(h.dt_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_range:' + getFieldTypeText(h.prim_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'predir:' + getFieldTypeText(h.predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_name:' + getFieldTypeText(h.prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_suffix:' + getFieldTypeText(h.addr_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_ind:' + getFieldTypeText(h.addr_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'postdir:' + getFieldTypeText(h.postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unit_desig:' + getFieldTypeText(h.unit_desig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sec_range:' + getFieldTypeText(h.sec_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rec_cnt:' + getFieldTypeText(h.rec_cnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_cnt:' + getFieldTypeText(h.src_cnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_DID_cnt
          ,le.populated_zip_cnt
          ,le.populated_prim_range_num_cnt
          ,le.populated_prim_name_num_cnt
          ,le.populated_prim_range_alpha_cnt
          ,le.populated_prim_name_alpha_cnt
          ,le.populated_prim_range_fract_cnt
          ,le.populated_sec_range_alpha_cnt
          ,le.populated_sec_range_num_cnt
          ,le.populated_city_cnt
          ,le.populated_st_cnt
          ,le.populated_src_cnt
          ,le.populated_dt_first_seen_cnt
          ,le.populated_dt_last_seen_cnt
          ,le.populated_prim_range_cnt
          ,le.populated_predir_cnt
          ,le.populated_prim_name_cnt
          ,le.populated_addr_suffix_cnt
          ,le.populated_addr_ind_cnt
          ,le.populated_postdir_cnt
          ,le.populated_unit_desig_cnt
          ,le.populated_sec_range_cnt
          ,le.populated_rec_cnt_cnt
          ,le.populated_src_cnt_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_DID_pcnt
          ,le.populated_zip_pcnt
          ,le.populated_prim_range_num_pcnt
          ,le.populated_prim_name_num_pcnt
          ,le.populated_prim_range_alpha_pcnt
          ,le.populated_prim_name_alpha_pcnt
          ,le.populated_prim_range_fract_pcnt
          ,le.populated_sec_range_alpha_pcnt
          ,le.populated_sec_range_num_pcnt
          ,le.populated_city_pcnt
          ,le.populated_st_pcnt
          ,le.populated_src_pcnt
          ,le.populated_dt_first_seen_pcnt
          ,le.populated_dt_last_seen_pcnt
          ,le.populated_prim_range_pcnt
          ,le.populated_predir_pcnt
          ,le.populated_prim_name_pcnt
          ,le.populated_addr_suffix_pcnt
          ,le.populated_addr_ind_pcnt
          ,le.populated_postdir_pcnt
          ,le.populated_unit_desig_pcnt
          ,le.populated_sec_range_pcnt
          ,le.populated_rec_cnt_pcnt
          ,le.populated_src_cnt_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,24,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_Address_Link));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),24,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_Address_Link) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(InsuranceHeader_Address, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
