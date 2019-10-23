IMPORT SALT311,STD;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 4;
  EXPORT NumRulesFromFieldType := 4;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 2;
  EXPORT NumFieldsWithPossibleEdits := 2;
  EXPORT NumRulesWithPossibleEdits := 4;
  EXPORT Expanded_Layout := RECORD(Layout_LGID3)
    UNSIGNED1 company_name_Invalid;
    BOOLEAN company_name_wouldSkip;
    BOOLEAN company_name_wouldClean;
    UNSIGNED1 nodes_below_st_Invalid;
    BOOLEAN nodes_below_st_wouldSkip;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_LGID3)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsCleanBits1;
  END;
EXPORT FromNone(DATASET(Layout_LGID3) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.company_name_Invalid := Fields.InValid_company_name((SALT311.StrType)le.company_name);
    clean_company_name := (TYPEOF(le.company_name))Fields.Make_company_name((SALT311.StrType)le.company_name);
    clean_company_name_Invalid := Fields.InValid_company_name((SALT311.StrType)clean_company_name);
    SELF.company_name := IF(withOnfail, IF(clean_company_name_Invalid=0, clean_company_name, SKIP), le.company_name); // ONFAIL(CLEAN,REJECT)
    SELF.company_name_wouldClean := TRIM((SALT311.StrType)le.company_name) <> TRIM((SALT311.StrType)clean_company_name);
    SELF.company_name_wouldSkip := clean_company_name_Invalid > 0;
    SELF.nodes_below_st_Invalid := Fields.InValid_nodes_below_st((SALT311.StrType)le.nodes_below_st);
    SELF.nodes_below_st := IF(SELF.nodes_below_st_Invalid=0 OR NOT withOnfail, le.nodes_below_st, SKIP); // ONFAIL(REJECT)
    SELF.nodes_below_st_wouldSkip := SELF.nodes_below_st_Invalid > 0;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_LGID3);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.company_name_Invalid << 0 ) + ( le.nodes_below_st_Invalid << 2 );
    SELF.ScrubsCleanBits1 := ( IF(le.company_name_wouldSkip, 1, 0) << 0 ) + ( IF(le.company_name_wouldClean, 1, 0) << 1 ) + ( IF(le.nodes_below_st_wouldSkip, 1, 0) << 2 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_LGID3);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.company_name_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.nodes_below_st_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.company_name_wouldSkip := le.ScrubsCleanBits1 >> 0;
    SELF.company_name_wouldClean := le.ScrubsCleanBits1 >> 1;
    SELF.nodes_below_st_wouldSkip := le.ScrubsCleanBits1 >> 2;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
    FromNew := FromNone(InFile).ExpandedInfile;
  EXPORT Changed := JOIN(ExpandedInfile,FromNew, LEFT.rcid=RIGHT.rcid AND (LEFT.company_name_Invalid <> RIGHT.company_name_Invalid OR LEFT.nodes_below_st_Invalid <> RIGHT.nodes_below_st_Invalid), TRANSFORM(RIGHT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h, BOOLEAN Glob = FALSE) := MODULE
  r := RECORD
    TYPEOF(h.source) source := IF(Glob, '', h.source);
    TotalCnt := COUNT(GROUP); // Number of records in total
    company_name_CAPS_ErrorCount := COUNT(GROUP,h.company_name_Invalid=1);
    company_name_CAPS_WouldModifyCount := COUNT(GROUP,h.company_name_Invalid=1 AND h.company_name_wouldClean);
    company_name_CAPS_WouldSkipRecCount := COUNT(GROUP,h.company_name_Invalid=1 AND h.company_name_wouldSkip);
    company_name_ALLOW_ErrorCount := COUNT(GROUP,h.company_name_Invalid=2);
    company_name_ALLOW_WouldModifyCount := COUNT(GROUP,h.company_name_Invalid=2 AND h.company_name_wouldClean);
    company_name_ALLOW_WouldSkipRecCount := COUNT(GROUP,h.company_name_Invalid=2 AND h.company_name_wouldSkip);
    company_name_LENGTHS_ErrorCount := COUNT(GROUP,h.company_name_Invalid=3);
    company_name_LENGTHS_WouldModifyCount := COUNT(GROUP,h.company_name_Invalid=3 AND h.company_name_wouldClean);
    company_name_LENGTHS_WouldSkipRecCount := COUNT(GROUP,h.company_name_Invalid=3 AND h.company_name_wouldSkip);
    company_name_Total_ErrorCount := COUNT(GROUP,h.company_name_Invalid>0);
    nodes_below_st_ENUM_ErrorCount := COUNT(GROUP,h.nodes_below_st_Invalid=1);
    nodes_below_st_ENUM_WouldSkipRecCount := COUNT(GROUP,h.nodes_below_st_Invalid=1 AND h.nodes_below_st_wouldSkip);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.company_name_Invalid > 0 OR h.nodes_below_st_Invalid > 0);
    AnyRule_WithEditsCount := COUNT(GROUP, h.company_name_wouldClean OR h.company_name_wouldSkip OR h.nodes_below_st_wouldSkip);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
    Rules_WithEdits := 0;
  END;
  SummaryStats0 := IF(Glob, TABLE(h,r), TABLE(h,r,source,FEW));
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.company_name_Total_ErrorCount > 0, 1, 0) + IF(le.nodes_below_st_ENUM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.company_name_CAPS_ErrorCount > 0, 1, 0) + IF(le.company_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.company_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.nodes_below_st_ENUM_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF.Rules_WithEdits := IF(le.company_name_CAPS_WouldModifyCount > 0, 1, 0) + IF(le.company_name_CAPS_WouldSkipRecCount > 0, 1, 0) + IF(le.company_name_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.company_name_ALLOW_WouldSkipRecCount > 0, 1, 0) + IF(le.company_name_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.company_name_LENGTHS_WouldSkipRecCount > 0, 1, 0) + IF(le.nodes_below_st_ENUM_WouldSkipRecCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.company_name_Invalid,le.nodes_below_st_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_company_name(le.company_name_Invalid),Fields.InvalidMessage_nodes_below_st(le.nodes_below_st_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.company_name_Invalid,'CAPS','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.nodes_below_st_Invalid,'ENUM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'company_name','nodes_below_st','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Noblanks','not_hrchy_parent','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.company_name,(SALT311.StrType)le.nodes_below_st,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,2,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_LGID3) prevDS = DATASET([], Layout_LGID3)):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.source;
      SELF.ruledesc := CHOOSE(c
          ,'company_name:Noblanks:CAPS','company_name:Noblanks:ALLOW','company_name:Noblanks:LENGTHS'
          ,'nodes_below_st:not_hrchy_parent:ENUM'
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
          ,Fields.InvalidMessage_company_name(1),Fields.InvalidMessage_company_name(2),Fields.InvalidMessage_company_name(3)
          ,Fields.InvalidMessage_nodes_below_st(1)
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
          ,le.company_name_CAPS_ErrorCount,le.company_name_ALLOW_ErrorCount,le.company_name_LENGTHS_ErrorCount
          ,le.nodes_below_st_ENUM_ErrorCount
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
          ,le.company_name_CAPS_ErrorCount,le.company_name_ALLOW_ErrorCount,le.company_name_LENGTHS_ErrorCount
          ,le.nodes_below_st_ENUM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Layout_LGID3));
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
          ,'company_inc_state:' + getFieldTypeText(h.company_inc_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Lgid3IfHrchy:' + getFieldTypeText(h.Lgid3IfHrchy) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'active_duns_number:' + getFieldTypeText(h.active_duns_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'duns_number:' + getFieldTypeText(h.duns_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sbfe_id:' + getFieldTypeText(h.sbfe_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_name:' + getFieldTypeText(h.company_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_fein:' + getFieldTypeText(h.company_fein) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_charter_number:' + getFieldTypeText(h.company_charter_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cnp_number:' + getFieldTypeText(h.cnp_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cnp_btype:' + getFieldTypeText(h.cnp_btype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nodes_below_st:' + getFieldTypeText(h.nodes_below_st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'OriginalSeleId:' + getFieldTypeText(h.OriginalSeleId) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'OriginalOrgId:' + getFieldTypeText(h.OriginalOrgId) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_name_type_derived:' + getFieldTypeText(h.company_name_type_derived) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hist_duns_number:' + getFieldTypeText(h.hist_duns_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'active_domestic_corp_key:' + getFieldTypeText(h.active_domestic_corp_key) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hist_domestic_corp_key:' + getFieldTypeText(h.hist_domestic_corp_key) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'foreign_corp_key:' + getFieldTypeText(h.foreign_corp_key) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unk_corp_key:' + getFieldTypeText(h.unk_corp_key) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cnp_name:' + getFieldTypeText(h.cnp_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cnp_hasNumber:' + getFieldTypeText(h.cnp_hasNumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cnp_lowv:' + getFieldTypeText(h.cnp_lowv) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cnp_translated:' + getFieldTypeText(h.cnp_translated) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cnp_classid:' + getFieldTypeText(h.cnp_classid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_range:' + getFieldTypeText(h.prim_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_name:' + getFieldTypeText(h.prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sec_range:' + getFieldTypeText(h.sec_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v_city_name:' + getFieldTypeText(h.v_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'st:' + getFieldTypeText(h.st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip:' + getFieldTypeText(h.zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'has_lgid:' + getFieldTypeText(h.has_lgid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'is_sele_level:' + getFieldTypeText(h.is_sele_level) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'is_org_level:' + getFieldTypeText(h.is_org_level) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'is_ult_level:' + getFieldTypeText(h.is_ult_level) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'parent_proxid:' + getFieldTypeText(h.parent_proxid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sele_proxid:' + getFieldTypeText(h.sele_proxid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'org_proxid:' + getFieldTypeText(h.org_proxid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ultimate_proxid:' + getFieldTypeText(h.ultimate_proxid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'levels_from_top:' + getFieldTypeText(h.levels_from_top) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nodes_total:' + getFieldTypeText(h.nodes_total) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_first_seen:' + getFieldTypeText(h.dt_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_last_seen:' + getFieldTypeText(h.dt_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_company_inc_state_cnt
          ,le.populated_Lgid3IfHrchy_cnt
          ,le.populated_active_duns_number_cnt
          ,le.populated_duns_number_cnt
          ,le.populated_sbfe_id_cnt
          ,le.populated_company_name_cnt
          ,le.populated_company_fein_cnt
          ,le.populated_company_charter_number_cnt
          ,le.populated_cnp_number_cnt
          ,le.populated_cnp_btype_cnt
          ,le.populated_nodes_below_st_cnt
          ,le.populated_OriginalSeleId_cnt
          ,le.populated_OriginalOrgId_cnt
          ,le.populated_company_name_type_derived_cnt
          ,le.populated_hist_duns_number_cnt
          ,le.populated_active_domestic_corp_key_cnt
          ,le.populated_hist_domestic_corp_key_cnt
          ,le.populated_foreign_corp_key_cnt
          ,le.populated_unk_corp_key_cnt
          ,le.populated_cnp_name_cnt
          ,le.populated_cnp_hasNumber_cnt
          ,le.populated_cnp_lowv_cnt
          ,le.populated_cnp_translated_cnt
          ,le.populated_cnp_classid_cnt
          ,le.populated_prim_range_cnt
          ,le.populated_prim_name_cnt
          ,le.populated_sec_range_cnt
          ,le.populated_v_city_name_cnt
          ,le.populated_st_cnt
          ,le.populated_zip_cnt
          ,le.populated_has_lgid_cnt
          ,le.populated_is_sele_level_cnt
          ,le.populated_is_org_level_cnt
          ,le.populated_is_ult_level_cnt
          ,le.populated_parent_proxid_cnt
          ,le.populated_sele_proxid_cnt
          ,le.populated_org_proxid_cnt
          ,le.populated_ultimate_proxid_cnt
          ,le.populated_levels_from_top_cnt
          ,le.populated_nodes_total_cnt
          ,le.populated_dt_first_seen_cnt
          ,le.populated_dt_last_seen_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_company_inc_state_pcnt
          ,le.populated_Lgid3IfHrchy_pcnt
          ,le.populated_active_duns_number_pcnt
          ,le.populated_duns_number_pcnt
          ,le.populated_sbfe_id_pcnt
          ,le.populated_company_name_pcnt
          ,le.populated_company_fein_pcnt
          ,le.populated_company_charter_number_pcnt
          ,le.populated_cnp_number_pcnt
          ,le.populated_cnp_btype_pcnt
          ,le.populated_nodes_below_st_pcnt
          ,le.populated_OriginalSeleId_pcnt
          ,le.populated_OriginalOrgId_pcnt
          ,le.populated_company_name_type_derived_pcnt
          ,le.populated_hist_duns_number_pcnt
          ,le.populated_active_domestic_corp_key_pcnt
          ,le.populated_hist_domestic_corp_key_pcnt
          ,le.populated_foreign_corp_key_pcnt
          ,le.populated_unk_corp_key_pcnt
          ,le.populated_cnp_name_pcnt
          ,le.populated_cnp_hasNumber_pcnt
          ,le.populated_cnp_lowv_pcnt
          ,le.populated_cnp_translated_pcnt
          ,le.populated_cnp_classid_pcnt
          ,le.populated_prim_range_pcnt
          ,le.populated_prim_name_pcnt
          ,le.populated_sec_range_pcnt
          ,le.populated_v_city_name_pcnt
          ,le.populated_st_pcnt
          ,le.populated_zip_pcnt
          ,le.populated_has_lgid_pcnt
          ,le.populated_is_sele_level_pcnt
          ,le.populated_is_org_level_pcnt
          ,le.populated_is_ult_level_pcnt
          ,le.populated_parent_proxid_pcnt
          ,le.populated_sele_proxid_pcnt
          ,le.populated_org_proxid_pcnt
          ,le.populated_ultimate_proxid_pcnt
          ,le.populated_levels_from_top_pcnt
          ,le.populated_nodes_total_pcnt
          ,le.populated_dt_first_seen_pcnt
          ,le.populated_dt_last_seen_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,42,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_LGID3));
    deltaHygieneSummary := mod_Delta.DifferenceSummary(Glob);
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),42,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_LGID3) inFile, BOOLEAN doErrorOverall = TRUE, BOOLEAN doErrorPerSrc = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedPerSource := FromExpanded(expandedFile, FALSE);
  mod_fromexpandedOverall := FromExpanded(expandedFile, TRUE);
  scrubsSummaryPerSource := mod_fromexpandedPerSource.SummaryStats;
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(BIPV2_LGID3, Fields, 'RECORDOF(scrubsSummaryOverall)', 'source');
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
