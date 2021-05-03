IMPORT SALT311,STD;
IMPORT Scrubs_OneKey; // Import modules for FieldTypes attribute definitions
EXPORT InputB_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 17;
  EXPORT NumRulesFromFieldType := 17;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 17;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(InputB_Layout_OneKey)
    UNSIGNED1 hcp_hce_id_Invalid;
    UNSIGNED1 ok_indv_id_Invalid;
    UNSIGNED1 ska_uid_Invalid;
    UNSIGNED1 frst_nm_Invalid;
    UNSIGNED1 mid_nm_Invalid;
    UNSIGNED1 last_nm_Invalid;
    UNSIGNED1 prim_prfsn_cd_Invalid;
    UNSIGNED1 prim_prfsn_desc_Invalid;
    UNSIGNED1 prim_spcl_cd_Invalid;
    UNSIGNED1 prim_spcl_desc_Invalid;
    UNSIGNED1 hce_prfsnl_stat_cd_Invalid;
    UNSIGNED1 hce_prfsnl_stat_desc_Invalid;
    UNSIGNED1 excld_rsn_desc_Invalid;
    UNSIGNED1 deactv_dt_Invalid;
    UNSIGNED1 city_nm_Invalid;
    UNSIGNED1 st_cd_Invalid;
    UNSIGNED1 zip5_cd_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(InputB_Layout_OneKey)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(InputB_Layout_OneKey)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'hcp_hce_id:invalid_numeric_nonzero:CUSTOM'
          ,'ok_indv_id:invalid_ok_wkp_id:CUSTOM'
          ,'ska_uid:invalid_numeric_nonzero:CUSTOM'
          ,'frst_nm:invalid_frst_nm:CUSTOM'
          ,'mid_nm:invalid_mid_nm:CUSTOM'
          ,'last_nm:invalid_last_nm:CUSTOM'
          ,'prim_prfsn_cd:invalid_prim_prfsn_cd:CUSTOM'
          ,'prim_prfsn_desc:invalid_prim_prfsn_desc:CUSTOM'
          ,'prim_spcl_cd:invalid_prim_spcl_cd:CUSTOM'
          ,'prim_spcl_desc:invalid_prim_spcl_desc:CUSTOM'
          ,'hce_prfsnl_stat_cd:invalid_hce_prfsnl_stat_cd:CUSTOM'
          ,'hce_prfsnl_stat_desc:invalid_hce_prfsnl_stat_desc:CUSTOM'
          ,'excld_rsn_desc:invalid_excld_rsn_desc:CUSTOM'
          ,'deactv_dt:invalid_deactv_dt:CUSTOM'
          ,'city_nm:invalid_city_nm:CUSTOM'
          ,'st_cd:invalid_st_cd:CUSTOM'
          ,'zip5_cd:invalid_zip5_cd:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,InputB_Fields.InvalidMessage_hcp_hce_id(1)
          ,InputB_Fields.InvalidMessage_ok_indv_id(1)
          ,InputB_Fields.InvalidMessage_ska_uid(1)
          ,InputB_Fields.InvalidMessage_frst_nm(1)
          ,InputB_Fields.InvalidMessage_mid_nm(1)
          ,InputB_Fields.InvalidMessage_last_nm(1)
          ,InputB_Fields.InvalidMessage_prim_prfsn_cd(1)
          ,InputB_Fields.InvalidMessage_prim_prfsn_desc(1)
          ,InputB_Fields.InvalidMessage_prim_spcl_cd(1)
          ,InputB_Fields.InvalidMessage_prim_spcl_desc(1)
          ,InputB_Fields.InvalidMessage_hce_prfsnl_stat_cd(1)
          ,InputB_Fields.InvalidMessage_hce_prfsnl_stat_desc(1)
          ,InputB_Fields.InvalidMessage_excld_rsn_desc(1)
          ,InputB_Fields.InvalidMessage_deactv_dt(1)
          ,InputB_Fields.InvalidMessage_city_nm(1)
          ,InputB_Fields.InvalidMessage_st_cd(1)
          ,InputB_Fields.InvalidMessage_zip5_cd(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(InputB_Layout_OneKey) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.hcp_hce_id_Invalid := InputB_Fields.InValid_hcp_hce_id((SALT311.StrType)le.hcp_hce_id);
    SELF.ok_indv_id_Invalid := InputB_Fields.InValid_ok_indv_id((SALT311.StrType)le.ok_indv_id);
    SELF.ska_uid_Invalid := InputB_Fields.InValid_ska_uid((SALT311.StrType)le.ska_uid);
    SELF.frst_nm_Invalid := InputB_Fields.InValid_frst_nm((SALT311.StrType)le.frst_nm,(SALT311.StrType)le.mid_nm,(SALT311.StrType)le.last_nm);
    SELF.mid_nm_Invalid := InputB_Fields.InValid_mid_nm((SALT311.StrType)le.mid_nm,(SALT311.StrType)le.frst_nm,(SALT311.StrType)le.last_nm);
    SELF.last_nm_Invalid := InputB_Fields.InValid_last_nm((SALT311.StrType)le.last_nm,(SALT311.StrType)le.frst_nm,(SALT311.StrType)le.mid_nm);
    SELF.prim_prfsn_cd_Invalid := InputB_Fields.InValid_prim_prfsn_cd((SALT311.StrType)le.prim_prfsn_cd,(SALT311.StrType)le.prim_prfsn_desc);
    SELF.prim_prfsn_desc_Invalid := InputB_Fields.InValid_prim_prfsn_desc((SALT311.StrType)le.prim_prfsn_desc,(SALT311.StrType)le.prim_prfsn_cd);
    SELF.prim_spcl_cd_Invalid := InputB_Fields.InValid_prim_spcl_cd((SALT311.StrType)le.prim_spcl_cd,(SALT311.StrType)le.prim_spcl_desc);
    SELF.prim_spcl_desc_Invalid := InputB_Fields.InValid_prim_spcl_desc((SALT311.StrType)le.prim_spcl_desc,(SALT311.StrType)le.prim_spcl_cd);
    SELF.hce_prfsnl_stat_cd_Invalid := InputB_Fields.InValid_hce_prfsnl_stat_cd((SALT311.StrType)le.hce_prfsnl_stat_cd,(SALT311.StrType)le.hce_prfsnl_stat_desc);
    SELF.hce_prfsnl_stat_desc_Invalid := InputB_Fields.InValid_hce_prfsnl_stat_desc((SALT311.StrType)le.hce_prfsnl_stat_desc,(SALT311.StrType)le.hce_prfsnl_stat_cd);
    SELF.excld_rsn_desc_Invalid := InputB_Fields.InValid_excld_rsn_desc((SALT311.StrType)le.excld_rsn_desc,(SALT311.StrType)le.hce_prfsnl_stat_cd);
    SELF.deactv_dt_Invalid := InputB_Fields.InValid_deactv_dt((SALT311.StrType)le.deactv_dt);
    SELF.city_nm_Invalid := InputB_Fields.InValid_city_nm((SALT311.StrType)le.city_nm,(SALT311.StrType)le.st_cd,(SALT311.StrType)le.zip5_cd);
    SELF.st_cd_Invalid := InputB_Fields.InValid_st_cd((SALT311.StrType)le.st_cd);
    SELF.zip5_cd_Invalid := InputB_Fields.InValid_zip5_cd((SALT311.StrType)le.zip5_cd);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),InputB_Layout_OneKey);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.hcp_hce_id_Invalid << 0 ) + ( le.ok_indv_id_Invalid << 1 ) + ( le.ska_uid_Invalid << 2 ) + ( le.frst_nm_Invalid << 3 ) + ( le.mid_nm_Invalid << 4 ) + ( le.last_nm_Invalid << 5 ) + ( le.prim_prfsn_cd_Invalid << 6 ) + ( le.prim_prfsn_desc_Invalid << 7 ) + ( le.prim_spcl_cd_Invalid << 8 ) + ( le.prim_spcl_desc_Invalid << 9 ) + ( le.hce_prfsnl_stat_cd_Invalid << 10 ) + ( le.hce_prfsnl_stat_desc_Invalid << 11 ) + ( le.excld_rsn_desc_Invalid << 12 ) + ( le.deactv_dt_Invalid << 13 ) + ( le.city_nm_Invalid << 14 ) + ( le.st_cd_Invalid << 15 ) + ( le.zip5_cd_Invalid << 16 );
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
  EXPORT Infile := PROJECT(h,InputB_Layout_OneKey);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.hcp_hce_id_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.ok_indv_id_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.ska_uid_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.frst_nm_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.mid_nm_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.last_nm_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.prim_prfsn_cd_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.prim_prfsn_desc_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.prim_spcl_cd_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.prim_spcl_desc_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.hce_prfsnl_stat_cd_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.hce_prfsnl_stat_desc_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.excld_rsn_desc_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.deactv_dt_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.city_nm_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.st_cd_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.zip5_cd_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    hcp_hce_id_CUSTOM_ErrorCount := COUNT(GROUP,h.hcp_hce_id_Invalid=1);
    ok_indv_id_CUSTOM_ErrorCount := COUNT(GROUP,h.ok_indv_id_Invalid=1);
    ska_uid_CUSTOM_ErrorCount := COUNT(GROUP,h.ska_uid_Invalid=1);
    frst_nm_CUSTOM_ErrorCount := COUNT(GROUP,h.frst_nm_Invalid=1);
    mid_nm_CUSTOM_ErrorCount := COUNT(GROUP,h.mid_nm_Invalid=1);
    last_nm_CUSTOM_ErrorCount := COUNT(GROUP,h.last_nm_Invalid=1);
    prim_prfsn_cd_CUSTOM_ErrorCount := COUNT(GROUP,h.prim_prfsn_cd_Invalid=1);
    prim_prfsn_desc_CUSTOM_ErrorCount := COUNT(GROUP,h.prim_prfsn_desc_Invalid=1);
    prim_spcl_cd_CUSTOM_ErrorCount := COUNT(GROUP,h.prim_spcl_cd_Invalid=1);
    prim_spcl_desc_CUSTOM_ErrorCount := COUNT(GROUP,h.prim_spcl_desc_Invalid=1);
    hce_prfsnl_stat_cd_CUSTOM_ErrorCount := COUNT(GROUP,h.hce_prfsnl_stat_cd_Invalid=1);
    hce_prfsnl_stat_desc_CUSTOM_ErrorCount := COUNT(GROUP,h.hce_prfsnl_stat_desc_Invalid=1);
    excld_rsn_desc_CUSTOM_ErrorCount := COUNT(GROUP,h.excld_rsn_desc_Invalid=1);
    deactv_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.deactv_dt_Invalid=1);
    city_nm_CUSTOM_ErrorCount := COUNT(GROUP,h.city_nm_Invalid=1);
    st_cd_CUSTOM_ErrorCount := COUNT(GROUP,h.st_cd_Invalid=1);
    zip5_cd_CUSTOM_ErrorCount := COUNT(GROUP,h.zip5_cd_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.hcp_hce_id_Invalid > 0 OR h.ok_indv_id_Invalid > 0 OR h.ska_uid_Invalid > 0 OR h.frst_nm_Invalid > 0 OR h.mid_nm_Invalid > 0 OR h.last_nm_Invalid > 0 OR h.prim_prfsn_cd_Invalid > 0 OR h.prim_prfsn_desc_Invalid > 0 OR h.prim_spcl_cd_Invalid > 0 OR h.prim_spcl_desc_Invalid > 0 OR h.hce_prfsnl_stat_cd_Invalid > 0 OR h.hce_prfsnl_stat_desc_Invalid > 0 OR h.excld_rsn_desc_Invalid > 0 OR h.deactv_dt_Invalid > 0 OR h.city_nm_Invalid > 0 OR h.st_cd_Invalid > 0 OR h.zip5_cd_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.hcp_hce_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ok_indv_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ska_uid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.frst_nm_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mid_nm_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.last_nm_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prim_prfsn_cd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prim_prfsn_desc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prim_spcl_cd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prim_spcl_desc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.hce_prfsnl_stat_cd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.hce_prfsnl_stat_desc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.excld_rsn_desc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.deactv_dt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.city_nm_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.st_cd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip5_cd_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.hcp_hce_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ok_indv_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ska_uid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.frst_nm_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mid_nm_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.last_nm_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prim_prfsn_cd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prim_prfsn_desc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prim_spcl_cd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prim_spcl_desc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.hce_prfsnl_stat_cd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.hce_prfsnl_stat_desc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.excld_rsn_desc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.deactv_dt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.city_nm_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.st_cd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip5_cd_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.hcp_hce_id_Invalid,le.ok_indv_id_Invalid,le.ska_uid_Invalid,le.frst_nm_Invalid,le.mid_nm_Invalid,le.last_nm_Invalid,le.prim_prfsn_cd_Invalid,le.prim_prfsn_desc_Invalid,le.prim_spcl_cd_Invalid,le.prim_spcl_desc_Invalid,le.hce_prfsnl_stat_cd_Invalid,le.hce_prfsnl_stat_desc_Invalid,le.excld_rsn_desc_Invalid,le.deactv_dt_Invalid,le.city_nm_Invalid,le.st_cd_Invalid,le.zip5_cd_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,InputB_Fields.InvalidMessage_hcp_hce_id(le.hcp_hce_id_Invalid),InputB_Fields.InvalidMessage_ok_indv_id(le.ok_indv_id_Invalid),InputB_Fields.InvalidMessage_ska_uid(le.ska_uid_Invalid),InputB_Fields.InvalidMessage_frst_nm(le.frst_nm_Invalid),InputB_Fields.InvalidMessage_mid_nm(le.mid_nm_Invalid),InputB_Fields.InvalidMessage_last_nm(le.last_nm_Invalid),InputB_Fields.InvalidMessage_prim_prfsn_cd(le.prim_prfsn_cd_Invalid),InputB_Fields.InvalidMessage_prim_prfsn_desc(le.prim_prfsn_desc_Invalid),InputB_Fields.InvalidMessage_prim_spcl_cd(le.prim_spcl_cd_Invalid),InputB_Fields.InvalidMessage_prim_spcl_desc(le.prim_spcl_desc_Invalid),InputB_Fields.InvalidMessage_hce_prfsnl_stat_cd(le.hce_prfsnl_stat_cd_Invalid),InputB_Fields.InvalidMessage_hce_prfsnl_stat_desc(le.hce_prfsnl_stat_desc_Invalid),InputB_Fields.InvalidMessage_excld_rsn_desc(le.excld_rsn_desc_Invalid),InputB_Fields.InvalidMessage_deactv_dt(le.deactv_dt_Invalid),InputB_Fields.InvalidMessage_city_nm(le.city_nm_Invalid),InputB_Fields.InvalidMessage_st_cd(le.st_cd_Invalid),InputB_Fields.InvalidMessage_zip5_cd(le.zip5_cd_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.hcp_hce_id_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ok_indv_id_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ska_uid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.frst_nm_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mid_nm_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.last_nm_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.prim_prfsn_cd_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.prim_prfsn_desc_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.prim_spcl_cd_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.prim_spcl_desc_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.hce_prfsnl_stat_cd_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.hce_prfsnl_stat_desc_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.excld_rsn_desc_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.deactv_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.city_nm_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.st_cd_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.zip5_cd_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'hcp_hce_id','ok_indv_id','ska_uid','frst_nm','mid_nm','last_nm','prim_prfsn_cd','prim_prfsn_desc','prim_spcl_cd','prim_spcl_desc','hce_prfsnl_stat_cd','hce_prfsnl_stat_desc','excld_rsn_desc','deactv_dt','city_nm','st_cd','zip5_cd','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_numeric_nonzero','invalid_ok_wkp_id','invalid_numeric_nonzero','invalid_frst_nm','invalid_mid_nm','invalid_last_nm','invalid_prim_prfsn_cd','invalid_prim_prfsn_desc','invalid_prim_spcl_cd','invalid_prim_spcl_desc','invalid_hce_prfsnl_stat_cd','invalid_hce_prfsnl_stat_desc','invalid_excld_rsn_desc','invalid_deactv_dt','invalid_city_nm','invalid_st_cd','invalid_zip5_cd','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.hcp_hce_id,(SALT311.StrType)le.ok_indv_id,(SALT311.StrType)le.ska_uid,(SALT311.StrType)le.frst_nm,(SALT311.StrType)le.mid_nm,(SALT311.StrType)le.last_nm,(SALT311.StrType)le.prim_prfsn_cd,(SALT311.StrType)le.prim_prfsn_desc,(SALT311.StrType)le.prim_spcl_cd,(SALT311.StrType)le.prim_spcl_desc,(SALT311.StrType)le.hce_prfsnl_stat_cd,(SALT311.StrType)le.hce_prfsnl_stat_desc,(SALT311.StrType)le.excld_rsn_desc,(SALT311.StrType)le.deactv_dt,(SALT311.StrType)le.city_nm,(SALT311.StrType)le.st_cd,(SALT311.StrType)le.zip5_cd,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,17,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(InputB_Layout_OneKey) prevDS = DATASET([], InputB_Layout_OneKey), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.hcp_hce_id_CUSTOM_ErrorCount
          ,le.ok_indv_id_CUSTOM_ErrorCount
          ,le.ska_uid_CUSTOM_ErrorCount
          ,le.frst_nm_CUSTOM_ErrorCount
          ,le.mid_nm_CUSTOM_ErrorCount
          ,le.last_nm_CUSTOM_ErrorCount
          ,le.prim_prfsn_cd_CUSTOM_ErrorCount
          ,le.prim_prfsn_desc_CUSTOM_ErrorCount
          ,le.prim_spcl_cd_CUSTOM_ErrorCount
          ,le.prim_spcl_desc_CUSTOM_ErrorCount
          ,le.hce_prfsnl_stat_cd_CUSTOM_ErrorCount
          ,le.hce_prfsnl_stat_desc_CUSTOM_ErrorCount
          ,le.excld_rsn_desc_CUSTOM_ErrorCount
          ,le.deactv_dt_CUSTOM_ErrorCount
          ,le.city_nm_CUSTOM_ErrorCount
          ,le.st_cd_CUSTOM_ErrorCount
          ,le.zip5_cd_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.hcp_hce_id_CUSTOM_ErrorCount
          ,le.ok_indv_id_CUSTOM_ErrorCount
          ,le.ska_uid_CUSTOM_ErrorCount
          ,le.frst_nm_CUSTOM_ErrorCount
          ,le.mid_nm_CUSTOM_ErrorCount
          ,le.last_nm_CUSTOM_ErrorCount
          ,le.prim_prfsn_cd_CUSTOM_ErrorCount
          ,le.prim_prfsn_desc_CUSTOM_ErrorCount
          ,le.prim_spcl_cd_CUSTOM_ErrorCount
          ,le.prim_spcl_desc_CUSTOM_ErrorCount
          ,le.hce_prfsnl_stat_cd_CUSTOM_ErrorCount
          ,le.hce_prfsnl_stat_desc_CUSTOM_ErrorCount
          ,le.excld_rsn_desc_CUSTOM_ErrorCount
          ,le.deactv_dt_CUSTOM_ErrorCount
          ,le.city_nm_CUSTOM_ErrorCount
          ,le.st_cd_CUSTOM_ErrorCount
          ,le.zip5_cd_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := InputB_hygiene(PROJECT(h, InputB_Layout_OneKey));
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
          ,'hcp_hce_id:' + getFieldTypeText(h.hcp_hce_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ok_indv_id:' + getFieldTypeText(h.ok_indv_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ska_uid:' + getFieldTypeText(h.ska_uid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ims_id:' + getFieldTypeText(h.ims_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'frst_nm:' + getFieldTypeText(h.frst_nm) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mid_nm:' + getFieldTypeText(h.mid_nm) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'last_nm:' + getFieldTypeText(h.last_nm) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sfx_cd:' + getFieldTypeText(h.sfx_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'gender_cd:' + getFieldTypeText(h.gender_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_prfsn_cd:' + getFieldTypeText(h.prim_prfsn_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_prfsn_desc:' + getFieldTypeText(h.prim_prfsn_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_spcl_cd:' + getFieldTypeText(h.prim_spcl_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_spcl_desc:' + getFieldTypeText(h.prim_spcl_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hce_prfsnl_stat_cd:' + getFieldTypeText(h.hce_prfsnl_stat_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hce_prfsnl_stat_desc:' + getFieldTypeText(h.hce_prfsnl_stat_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'excld_rsn_desc:' + getFieldTypeText(h.excld_rsn_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'npi:' + getFieldTypeText(h.npi) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'deactv_dt:' + getFieldTypeText(h.deactv_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'xref_hce_id:' + getFieldTypeText(h.xref_hce_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city_nm:' + getFieldTypeText(h.city_nm) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'st_cd:' + getFieldTypeText(h.st_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip5_cd:' + getFieldTypeText(h.zip5_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_hcp_hce_id_cnt
          ,le.populated_ok_indv_id_cnt
          ,le.populated_ska_uid_cnt
          ,le.populated_ims_id_cnt
          ,le.populated_frst_nm_cnt
          ,le.populated_mid_nm_cnt
          ,le.populated_last_nm_cnt
          ,le.populated_sfx_cd_cnt
          ,le.populated_gender_cd_cnt
          ,le.populated_prim_prfsn_cd_cnt
          ,le.populated_prim_prfsn_desc_cnt
          ,le.populated_prim_spcl_cd_cnt
          ,le.populated_prim_spcl_desc_cnt
          ,le.populated_hce_prfsnl_stat_cd_cnt
          ,le.populated_hce_prfsnl_stat_desc_cnt
          ,le.populated_excld_rsn_desc_cnt
          ,le.populated_npi_cnt
          ,le.populated_deactv_dt_cnt
          ,le.populated_xref_hce_id_cnt
          ,le.populated_city_nm_cnt
          ,le.populated_st_cd_cnt
          ,le.populated_zip5_cd_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_hcp_hce_id_pcnt
          ,le.populated_ok_indv_id_pcnt
          ,le.populated_ska_uid_pcnt
          ,le.populated_ims_id_pcnt
          ,le.populated_frst_nm_pcnt
          ,le.populated_mid_nm_pcnt
          ,le.populated_last_nm_pcnt
          ,le.populated_sfx_cd_pcnt
          ,le.populated_gender_cd_pcnt
          ,le.populated_prim_prfsn_cd_pcnt
          ,le.populated_prim_prfsn_desc_pcnt
          ,le.populated_prim_spcl_cd_pcnt
          ,le.populated_prim_spcl_desc_pcnt
          ,le.populated_hce_prfsnl_stat_cd_pcnt
          ,le.populated_hce_prfsnl_stat_desc_pcnt
          ,le.populated_excld_rsn_desc_pcnt
          ,le.populated_npi_pcnt
          ,le.populated_deactv_dt_pcnt
          ,le.populated_xref_hce_id_pcnt
          ,le.populated_city_nm_pcnt
          ,le.populated_st_cd_pcnt
          ,le.populated_zip5_cd_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,22,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := InputB_Delta(prevDS, PROJECT(h, InputB_Layout_OneKey));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),22,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(InputB_Layout_OneKey) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_OneKey, InputB_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
