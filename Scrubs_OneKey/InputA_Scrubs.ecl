IMPORT SALT311,STD;
IMPORT Scrubs_OneKey; // Import modules for FieldTypes attribute definitions
EXPORT InputA_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 25;
  EXPORT NumRulesFromFieldType := 25;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 25;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(InputA_Layout_OneKey)
    UNSIGNED1 hcp_hce_id_Invalid;
    UNSIGNED1 frst_nm_Invalid;
    UNSIGNED1 mid_nm_Invalid;
    UNSIGNED1 last_nm_Invalid;
    UNSIGNED1 prim_prfsn_cd_Invalid;
    UNSIGNED1 prim_prfsn_desc_Invalid;
    UNSIGNED1 prim_spcl_cd_Invalid;
    UNSIGNED1 prim_spcl_desc_Invalid;
    UNSIGNED1 sec_spcl_cd_Invalid;
    UNSIGNED1 sec_spcl_desc_Invalid;
    UNSIGNED1 tert_spcl_cd_Invalid;
    UNSIGNED1 tert_spcl_desc_Invalid;
    UNSIGNED1 sub_spcl_cd_Invalid;
    UNSIGNED1 sub_spcl_desc_Invalid;
    UNSIGNED1 titl_typ_id_Invalid;
    UNSIGNED1 titl_typ_desc_Invalid;
    UNSIGNED1 hco_hce_id_Invalid;
    UNSIGNED1 ok_wkp_id_Invalid;
    UNSIGNED1 ska_id_Invalid;
    UNSIGNED1 bus_nm_Invalid;
    UNSIGNED1 city_nm_Invalid;
    UNSIGNED1 st_cd_Invalid;
    UNSIGNED1 zip5_cd_Invalid;
    UNSIGNED1 hcp_affil_xid_Invalid;
    UNSIGNED1 delta_cd_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(InputA_Layout_OneKey)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(InputA_Layout_OneKey)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'hcp_hce_id:invalid_numeric_nonzero:CUSTOM'
          ,'frst_nm:invalid_frst_nm:CUSTOM'
          ,'mid_nm:invalid_mid_nm:CUSTOM'
          ,'last_nm:invalid_last_nm:CUSTOM'
          ,'prim_prfsn_cd:invalid_prim_prfsn_cd:CUSTOM'
          ,'prim_prfsn_desc:invalid_prim_prfsn_desc:CUSTOM'
          ,'prim_spcl_cd:invalid_prim_spcl_cd:CUSTOM'
          ,'prim_spcl_desc:invalid_prim_spcl_desc:CUSTOM'
          ,'sec_spcl_cd:invalid_sec_spcl_cd:CUSTOM'
          ,'sec_spcl_desc:invalid_sec_spcl_desc:CUSTOM'
          ,'tert_spcl_cd:invalid_tert_spcl_cd:CUSTOM'
          ,'tert_spcl_desc:invalid_tert_spcl_desc:CUSTOM'
          ,'sub_spcl_cd:invalid_sub_spcl_cd:CUSTOM'
          ,'sub_spcl_desc:invalid_sub_spcl_desc:CUSTOM'
          ,'titl_typ_id:invalid_titl_typ_id:CUSTOM'
          ,'titl_typ_desc:invalid_titl_typ_desc:CUSTOM'
          ,'hco_hce_id:invalid_numeric_nonzero:CUSTOM'
          ,'ok_wkp_id:invalid_ok_wkp_id:CUSTOM'
          ,'ska_id:invalid_numeric_nonzero:CUSTOM'
          ,'bus_nm:invalid_mandatory:CUSTOM'
          ,'city_nm:invalid_city_nm:CUSTOM'
          ,'st_cd:invalid_st_cd:CUSTOM'
          ,'zip5_cd:invalid_zip5_cd:CUSTOM'
          ,'hcp_affil_xid:invalid_hcp_affil_xid:CUSTOM'
          ,'delta_cd:invalid_delta_cd:ENUM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,InputA_Fields.InvalidMessage_hcp_hce_id(1)
          ,InputA_Fields.InvalidMessage_frst_nm(1)
          ,InputA_Fields.InvalidMessage_mid_nm(1)
          ,InputA_Fields.InvalidMessage_last_nm(1)
          ,InputA_Fields.InvalidMessage_prim_prfsn_cd(1)
          ,InputA_Fields.InvalidMessage_prim_prfsn_desc(1)
          ,InputA_Fields.InvalidMessage_prim_spcl_cd(1)
          ,InputA_Fields.InvalidMessage_prim_spcl_desc(1)
          ,InputA_Fields.InvalidMessage_sec_spcl_cd(1)
          ,InputA_Fields.InvalidMessage_sec_spcl_desc(1)
          ,InputA_Fields.InvalidMessage_tert_spcl_cd(1)
          ,InputA_Fields.InvalidMessage_tert_spcl_desc(1)
          ,InputA_Fields.InvalidMessage_sub_spcl_cd(1)
          ,InputA_Fields.InvalidMessage_sub_spcl_desc(1)
          ,InputA_Fields.InvalidMessage_titl_typ_id(1)
          ,InputA_Fields.InvalidMessage_titl_typ_desc(1)
          ,InputA_Fields.InvalidMessage_hco_hce_id(1)
          ,InputA_Fields.InvalidMessage_ok_wkp_id(1)
          ,InputA_Fields.InvalidMessage_ska_id(1)
          ,InputA_Fields.InvalidMessage_bus_nm(1)
          ,InputA_Fields.InvalidMessage_city_nm(1)
          ,InputA_Fields.InvalidMessage_st_cd(1)
          ,InputA_Fields.InvalidMessage_zip5_cd(1)
          ,InputA_Fields.InvalidMessage_hcp_affil_xid(1)
          ,InputA_Fields.InvalidMessage_delta_cd(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(InputA_Layout_OneKey) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.hcp_hce_id_Invalid := InputA_Fields.InValid_hcp_hce_id((SALT311.StrType)le.hcp_hce_id);
    SELF.frst_nm_Invalid := InputA_Fields.InValid_frst_nm((SALT311.StrType)le.frst_nm,(SALT311.StrType)le.mid_nm,(SALT311.StrType)le.last_nm);
    SELF.mid_nm_Invalid := InputA_Fields.InValid_mid_nm((SALT311.StrType)le.mid_nm,(SALT311.StrType)le.frst_nm,(SALT311.StrType)le.last_nm);
    SELF.last_nm_Invalid := InputA_Fields.InValid_last_nm((SALT311.StrType)le.last_nm,(SALT311.StrType)le.frst_nm,(SALT311.StrType)le.mid_nm);
    SELF.prim_prfsn_cd_Invalid := InputA_Fields.InValid_prim_prfsn_cd((SALT311.StrType)le.prim_prfsn_cd,(SALT311.StrType)le.prim_prfsn_desc);
    SELF.prim_prfsn_desc_Invalid := InputA_Fields.InValid_prim_prfsn_desc((SALT311.StrType)le.prim_prfsn_desc,(SALT311.StrType)le.prim_prfsn_cd);
    SELF.prim_spcl_cd_Invalid := InputA_Fields.InValid_prim_spcl_cd((SALT311.StrType)le.prim_spcl_cd,(SALT311.StrType)le.prim_spcl_desc);
    SELF.prim_spcl_desc_Invalid := InputA_Fields.InValid_prim_spcl_desc((SALT311.StrType)le.prim_spcl_desc,(SALT311.StrType)le.prim_spcl_cd);
    SELF.sec_spcl_cd_Invalid := InputA_Fields.InValid_sec_spcl_cd((SALT311.StrType)le.sec_spcl_cd,(SALT311.StrType)le.sec_spcl_desc);
    SELF.sec_spcl_desc_Invalid := InputA_Fields.InValid_sec_spcl_desc((SALT311.StrType)le.sec_spcl_desc,(SALT311.StrType)le.sec_spcl_cd);
    SELF.tert_spcl_cd_Invalid := InputA_Fields.InValid_tert_spcl_cd((SALT311.StrType)le.tert_spcl_cd,(SALT311.StrType)le.tert_spcl_desc);
    SELF.tert_spcl_desc_Invalid := InputA_Fields.InValid_tert_spcl_desc((SALT311.StrType)le.tert_spcl_desc,(SALT311.StrType)le.tert_spcl_cd);
    SELF.sub_spcl_cd_Invalid := InputA_Fields.InValid_sub_spcl_cd((SALT311.StrType)le.sub_spcl_cd,(SALT311.StrType)le.sub_spcl_desc);
    SELF.sub_spcl_desc_Invalid := InputA_Fields.InValid_sub_spcl_desc((SALT311.StrType)le.sub_spcl_desc,(SALT311.StrType)le.sub_spcl_cd);
    SELF.titl_typ_id_Invalid := InputA_Fields.InValid_titl_typ_id((SALT311.StrType)le.titl_typ_id,(SALT311.StrType)le.titl_typ_desc);
    SELF.titl_typ_desc_Invalid := InputA_Fields.InValid_titl_typ_desc((SALT311.StrType)le.titl_typ_desc,(SALT311.StrType)le.titl_typ_id);
    SELF.hco_hce_id_Invalid := InputA_Fields.InValid_hco_hce_id((SALT311.StrType)le.hco_hce_id);
    SELF.ok_wkp_id_Invalid := InputA_Fields.InValid_ok_wkp_id((SALT311.StrType)le.ok_wkp_id);
    SELF.ska_id_Invalid := InputA_Fields.InValid_ska_id((SALT311.StrType)le.ska_id);
    SELF.bus_nm_Invalid := InputA_Fields.InValid_bus_nm((SALT311.StrType)le.bus_nm);
    SELF.city_nm_Invalid := InputA_Fields.InValid_city_nm((SALT311.StrType)le.city_nm);
    SELF.st_cd_Invalid := InputA_Fields.InValid_st_cd((SALT311.StrType)le.st_cd);
    SELF.zip5_cd_Invalid := InputA_Fields.InValid_zip5_cd((SALT311.StrType)le.zip5_cd);
    SELF.hcp_affil_xid_Invalid := InputA_Fields.InValid_hcp_affil_xid((SALT311.StrType)le.hcp_affil_xid,(SALT311.StrType)le.hcp_hce_id,(SALT311.StrType)le.hco_hce_id,(SALT311.StrType)le.titl_typ_id);
    SELF.delta_cd_Invalid := InputA_Fields.InValid_delta_cd((SALT311.StrType)le.delta_cd);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),InputA_Layout_OneKey);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.hcp_hce_id_Invalid << 0 ) + ( le.frst_nm_Invalid << 1 ) + ( le.mid_nm_Invalid << 2 ) + ( le.last_nm_Invalid << 3 ) + ( le.prim_prfsn_cd_Invalid << 4 ) + ( le.prim_prfsn_desc_Invalid << 5 ) + ( le.prim_spcl_cd_Invalid << 6 ) + ( le.prim_spcl_desc_Invalid << 7 ) + ( le.sec_spcl_cd_Invalid << 8 ) + ( le.sec_spcl_desc_Invalid << 9 ) + ( le.tert_spcl_cd_Invalid << 10 ) + ( le.tert_spcl_desc_Invalid << 11 ) + ( le.sub_spcl_cd_Invalid << 12 ) + ( le.sub_spcl_desc_Invalid << 13 ) + ( le.titl_typ_id_Invalid << 14 ) + ( le.titl_typ_desc_Invalid << 15 ) + ( le.hco_hce_id_Invalid << 16 ) + ( le.ok_wkp_id_Invalid << 17 ) + ( le.ska_id_Invalid << 18 ) + ( le.bus_nm_Invalid << 19 ) + ( le.city_nm_Invalid << 20 ) + ( le.st_cd_Invalid << 21 ) + ( le.zip5_cd_Invalid << 22 ) + ( le.hcp_affil_xid_Invalid << 23 ) + ( le.delta_cd_Invalid << 24 );
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
  EXPORT Infile := PROJECT(h,InputA_Layout_OneKey);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.hcp_hce_id_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.frst_nm_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.mid_nm_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.last_nm_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.prim_prfsn_cd_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.prim_prfsn_desc_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.prim_spcl_cd_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.prim_spcl_desc_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.sec_spcl_cd_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.sec_spcl_desc_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.tert_spcl_cd_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.tert_spcl_desc_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.sub_spcl_cd_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.sub_spcl_desc_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.titl_typ_id_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.titl_typ_desc_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.hco_hce_id_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.ok_wkp_id_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.ska_id_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.bus_nm_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.city_nm_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.st_cd_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.zip5_cd_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.hcp_affil_xid_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.delta_cd_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    hcp_hce_id_CUSTOM_ErrorCount := COUNT(GROUP,h.hcp_hce_id_Invalid=1);
    frst_nm_CUSTOM_ErrorCount := COUNT(GROUP,h.frst_nm_Invalid=1);
    mid_nm_CUSTOM_ErrorCount := COUNT(GROUP,h.mid_nm_Invalid=1);
    last_nm_CUSTOM_ErrorCount := COUNT(GROUP,h.last_nm_Invalid=1);
    prim_prfsn_cd_CUSTOM_ErrorCount := COUNT(GROUP,h.prim_prfsn_cd_Invalid=1);
    prim_prfsn_desc_CUSTOM_ErrorCount := COUNT(GROUP,h.prim_prfsn_desc_Invalid=1);
    prim_spcl_cd_CUSTOM_ErrorCount := COUNT(GROUP,h.prim_spcl_cd_Invalid=1);
    prim_spcl_desc_CUSTOM_ErrorCount := COUNT(GROUP,h.prim_spcl_desc_Invalid=1);
    sec_spcl_cd_CUSTOM_ErrorCount := COUNT(GROUP,h.sec_spcl_cd_Invalid=1);
    sec_spcl_desc_CUSTOM_ErrorCount := COUNT(GROUP,h.sec_spcl_desc_Invalid=1);
    tert_spcl_cd_CUSTOM_ErrorCount := COUNT(GROUP,h.tert_spcl_cd_Invalid=1);
    tert_spcl_desc_CUSTOM_ErrorCount := COUNT(GROUP,h.tert_spcl_desc_Invalid=1);
    sub_spcl_cd_CUSTOM_ErrorCount := COUNT(GROUP,h.sub_spcl_cd_Invalid=1);
    sub_spcl_desc_CUSTOM_ErrorCount := COUNT(GROUP,h.sub_spcl_desc_Invalid=1);
    titl_typ_id_CUSTOM_ErrorCount := COUNT(GROUP,h.titl_typ_id_Invalid=1);
    titl_typ_desc_CUSTOM_ErrorCount := COUNT(GROUP,h.titl_typ_desc_Invalid=1);
    hco_hce_id_CUSTOM_ErrorCount := COUNT(GROUP,h.hco_hce_id_Invalid=1);
    ok_wkp_id_CUSTOM_ErrorCount := COUNT(GROUP,h.ok_wkp_id_Invalid=1);
    ska_id_CUSTOM_ErrorCount := COUNT(GROUP,h.ska_id_Invalid=1);
    bus_nm_CUSTOM_ErrorCount := COUNT(GROUP,h.bus_nm_Invalid=1);
    city_nm_CUSTOM_ErrorCount := COUNT(GROUP,h.city_nm_Invalid=1);
    st_cd_CUSTOM_ErrorCount := COUNT(GROUP,h.st_cd_Invalid=1);
    zip5_cd_CUSTOM_ErrorCount := COUNT(GROUP,h.zip5_cd_Invalid=1);
    hcp_affil_xid_CUSTOM_ErrorCount := COUNT(GROUP,h.hcp_affil_xid_Invalid=1);
    delta_cd_ENUM_ErrorCount := COUNT(GROUP,h.delta_cd_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.hcp_hce_id_Invalid > 0 OR h.frst_nm_Invalid > 0 OR h.mid_nm_Invalid > 0 OR h.last_nm_Invalid > 0 OR h.prim_prfsn_cd_Invalid > 0 OR h.prim_prfsn_desc_Invalid > 0 OR h.prim_spcl_cd_Invalid > 0 OR h.prim_spcl_desc_Invalid > 0 OR h.sec_spcl_cd_Invalid > 0 OR h.sec_spcl_desc_Invalid > 0 OR h.tert_spcl_cd_Invalid > 0 OR h.tert_spcl_desc_Invalid > 0 OR h.sub_spcl_cd_Invalid > 0 OR h.sub_spcl_desc_Invalid > 0 OR h.titl_typ_id_Invalid > 0 OR h.titl_typ_desc_Invalid > 0 OR h.hco_hce_id_Invalid > 0 OR h.ok_wkp_id_Invalid > 0 OR h.ska_id_Invalid > 0 OR h.bus_nm_Invalid > 0 OR h.city_nm_Invalid > 0 OR h.st_cd_Invalid > 0 OR h.zip5_cd_Invalid > 0 OR h.hcp_affil_xid_Invalid > 0 OR h.delta_cd_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.hcp_hce_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.frst_nm_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mid_nm_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.last_nm_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prim_prfsn_cd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prim_prfsn_desc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prim_spcl_cd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prim_spcl_desc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sec_spcl_cd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sec_spcl_desc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.tert_spcl_cd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.tert_spcl_desc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sub_spcl_cd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sub_spcl_desc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.titl_typ_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.titl_typ_desc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.hco_hce_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ok_wkp_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ska_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bus_nm_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.city_nm_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.st_cd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip5_cd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.hcp_affil_xid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.delta_cd_ENUM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.hcp_hce_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.frst_nm_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mid_nm_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.last_nm_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prim_prfsn_cd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prim_prfsn_desc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prim_spcl_cd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prim_spcl_desc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sec_spcl_cd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sec_spcl_desc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.tert_spcl_cd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.tert_spcl_desc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sub_spcl_cd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sub_spcl_desc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.titl_typ_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.titl_typ_desc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.hco_hce_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ok_wkp_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ska_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bus_nm_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.city_nm_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.st_cd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip5_cd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.hcp_affil_xid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.delta_cd_ENUM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.hcp_hce_id_Invalid,le.frst_nm_Invalid,le.mid_nm_Invalid,le.last_nm_Invalid,le.prim_prfsn_cd_Invalid,le.prim_prfsn_desc_Invalid,le.prim_spcl_cd_Invalid,le.prim_spcl_desc_Invalid,le.sec_spcl_cd_Invalid,le.sec_spcl_desc_Invalid,le.tert_spcl_cd_Invalid,le.tert_spcl_desc_Invalid,le.sub_spcl_cd_Invalid,le.sub_spcl_desc_Invalid,le.titl_typ_id_Invalid,le.titl_typ_desc_Invalid,le.hco_hce_id_Invalid,le.ok_wkp_id_Invalid,le.ska_id_Invalid,le.bus_nm_Invalid,le.city_nm_Invalid,le.st_cd_Invalid,le.zip5_cd_Invalid,le.hcp_affil_xid_Invalid,le.delta_cd_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,InputA_Fields.InvalidMessage_hcp_hce_id(le.hcp_hce_id_Invalid),InputA_Fields.InvalidMessage_frst_nm(le.frst_nm_Invalid),InputA_Fields.InvalidMessage_mid_nm(le.mid_nm_Invalid),InputA_Fields.InvalidMessage_last_nm(le.last_nm_Invalid),InputA_Fields.InvalidMessage_prim_prfsn_cd(le.prim_prfsn_cd_Invalid),InputA_Fields.InvalidMessage_prim_prfsn_desc(le.prim_prfsn_desc_Invalid),InputA_Fields.InvalidMessage_prim_spcl_cd(le.prim_spcl_cd_Invalid),InputA_Fields.InvalidMessage_prim_spcl_desc(le.prim_spcl_desc_Invalid),InputA_Fields.InvalidMessage_sec_spcl_cd(le.sec_spcl_cd_Invalid),InputA_Fields.InvalidMessage_sec_spcl_desc(le.sec_spcl_desc_Invalid),InputA_Fields.InvalidMessage_tert_spcl_cd(le.tert_spcl_cd_Invalid),InputA_Fields.InvalidMessage_tert_spcl_desc(le.tert_spcl_desc_Invalid),InputA_Fields.InvalidMessage_sub_spcl_cd(le.sub_spcl_cd_Invalid),InputA_Fields.InvalidMessage_sub_spcl_desc(le.sub_spcl_desc_Invalid),InputA_Fields.InvalidMessage_titl_typ_id(le.titl_typ_id_Invalid),InputA_Fields.InvalidMessage_titl_typ_desc(le.titl_typ_desc_Invalid),InputA_Fields.InvalidMessage_hco_hce_id(le.hco_hce_id_Invalid),InputA_Fields.InvalidMessage_ok_wkp_id(le.ok_wkp_id_Invalid),InputA_Fields.InvalidMessage_ska_id(le.ska_id_Invalid),InputA_Fields.InvalidMessage_bus_nm(le.bus_nm_Invalid),InputA_Fields.InvalidMessage_city_nm(le.city_nm_Invalid),InputA_Fields.InvalidMessage_st_cd(le.st_cd_Invalid),InputA_Fields.InvalidMessage_zip5_cd(le.zip5_cd_Invalid),InputA_Fields.InvalidMessage_hcp_affil_xid(le.hcp_affil_xid_Invalid),InputA_Fields.InvalidMessage_delta_cd(le.delta_cd_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.hcp_hce_id_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.frst_nm_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mid_nm_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.last_nm_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.prim_prfsn_cd_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.prim_prfsn_desc_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.prim_spcl_cd_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.prim_spcl_desc_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sec_spcl_cd_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sec_spcl_desc_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.tert_spcl_cd_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.tert_spcl_desc_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sub_spcl_cd_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sub_spcl_desc_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.titl_typ_id_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.titl_typ_desc_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.hco_hce_id_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ok_wkp_id_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ska_id_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.bus_nm_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.city_nm_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.st_cd_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.zip5_cd_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.hcp_affil_xid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.delta_cd_Invalid,'ENUM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'hcp_hce_id','frst_nm','mid_nm','last_nm','prim_prfsn_cd','prim_prfsn_desc','prim_spcl_cd','prim_spcl_desc','sec_spcl_cd','sec_spcl_desc','tert_spcl_cd','tert_spcl_desc','sub_spcl_cd','sub_spcl_desc','titl_typ_id','titl_typ_desc','hco_hce_id','ok_wkp_id','ska_id','bus_nm','city_nm','st_cd','zip5_cd','hcp_affil_xid','delta_cd','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_numeric_nonzero','invalid_frst_nm','invalid_mid_nm','invalid_last_nm','invalid_prim_prfsn_cd','invalid_prim_prfsn_desc','invalid_prim_spcl_cd','invalid_prim_spcl_desc','invalid_sec_spcl_cd','invalid_sec_spcl_desc','invalid_tert_spcl_cd','invalid_tert_spcl_desc','invalid_sub_spcl_cd','invalid_sub_spcl_desc','invalid_titl_typ_id','invalid_titl_typ_desc','invalid_numeric_nonzero','invalid_ok_wkp_id','invalid_numeric_nonzero','invalid_mandatory','invalid_city_nm','invalid_st_cd','invalid_zip5_cd','invalid_hcp_affil_xid','invalid_delta_cd','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.hcp_hce_id,(SALT311.StrType)le.frst_nm,(SALT311.StrType)le.mid_nm,(SALT311.StrType)le.last_nm,(SALT311.StrType)le.prim_prfsn_cd,(SALT311.StrType)le.prim_prfsn_desc,(SALT311.StrType)le.prim_spcl_cd,(SALT311.StrType)le.prim_spcl_desc,(SALT311.StrType)le.sec_spcl_cd,(SALT311.StrType)le.sec_spcl_desc,(SALT311.StrType)le.tert_spcl_cd,(SALT311.StrType)le.tert_spcl_desc,(SALT311.StrType)le.sub_spcl_cd,(SALT311.StrType)le.sub_spcl_desc,(SALT311.StrType)le.titl_typ_id,(SALT311.StrType)le.titl_typ_desc,(SALT311.StrType)le.hco_hce_id,(SALT311.StrType)le.ok_wkp_id,(SALT311.StrType)le.ska_id,(SALT311.StrType)le.bus_nm,(SALT311.StrType)le.city_nm,(SALT311.StrType)le.st_cd,(SALT311.StrType)le.zip5_cd,(SALT311.StrType)le.hcp_affil_xid,(SALT311.StrType)le.delta_cd,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,25,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(InputA_Layout_OneKey) prevDS = DATASET([], InputA_Layout_OneKey), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.hcp_hce_id_CUSTOM_ErrorCount
          ,le.frst_nm_CUSTOM_ErrorCount
          ,le.mid_nm_CUSTOM_ErrorCount
          ,le.last_nm_CUSTOM_ErrorCount
          ,le.prim_prfsn_cd_CUSTOM_ErrorCount
          ,le.prim_prfsn_desc_CUSTOM_ErrorCount
          ,le.prim_spcl_cd_CUSTOM_ErrorCount
          ,le.prim_spcl_desc_CUSTOM_ErrorCount
          ,le.sec_spcl_cd_CUSTOM_ErrorCount
          ,le.sec_spcl_desc_CUSTOM_ErrorCount
          ,le.tert_spcl_cd_CUSTOM_ErrorCount
          ,le.tert_spcl_desc_CUSTOM_ErrorCount
          ,le.sub_spcl_cd_CUSTOM_ErrorCount
          ,le.sub_spcl_desc_CUSTOM_ErrorCount
          ,le.titl_typ_id_CUSTOM_ErrorCount
          ,le.titl_typ_desc_CUSTOM_ErrorCount
          ,le.hco_hce_id_CUSTOM_ErrorCount
          ,le.ok_wkp_id_CUSTOM_ErrorCount
          ,le.ska_id_CUSTOM_ErrorCount
          ,le.bus_nm_CUSTOM_ErrorCount
          ,le.city_nm_CUSTOM_ErrorCount
          ,le.st_cd_CUSTOM_ErrorCount
          ,le.zip5_cd_CUSTOM_ErrorCount
          ,le.hcp_affil_xid_CUSTOM_ErrorCount
          ,le.delta_cd_ENUM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.hcp_hce_id_CUSTOM_ErrorCount
          ,le.frst_nm_CUSTOM_ErrorCount
          ,le.mid_nm_CUSTOM_ErrorCount
          ,le.last_nm_CUSTOM_ErrorCount
          ,le.prim_prfsn_cd_CUSTOM_ErrorCount
          ,le.prim_prfsn_desc_CUSTOM_ErrorCount
          ,le.prim_spcl_cd_CUSTOM_ErrorCount
          ,le.prim_spcl_desc_CUSTOM_ErrorCount
          ,le.sec_spcl_cd_CUSTOM_ErrorCount
          ,le.sec_spcl_desc_CUSTOM_ErrorCount
          ,le.tert_spcl_cd_CUSTOM_ErrorCount
          ,le.tert_spcl_desc_CUSTOM_ErrorCount
          ,le.sub_spcl_cd_CUSTOM_ErrorCount
          ,le.sub_spcl_desc_CUSTOM_ErrorCount
          ,le.titl_typ_id_CUSTOM_ErrorCount
          ,le.titl_typ_desc_CUSTOM_ErrorCount
          ,le.hco_hce_id_CUSTOM_ErrorCount
          ,le.ok_wkp_id_CUSTOM_ErrorCount
          ,le.ska_id_CUSTOM_ErrorCount
          ,le.bus_nm_CUSTOM_ErrorCount
          ,le.city_nm_CUSTOM_ErrorCount
          ,le.st_cd_CUSTOM_ErrorCount
          ,le.zip5_cd_CUSTOM_ErrorCount
          ,le.hcp_affil_xid_CUSTOM_ErrorCount
          ,le.delta_cd_ENUM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := InputA_hygiene(PROJECT(h, InputA_Layout_OneKey));
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
          ,'frst_nm:' + getFieldTypeText(h.frst_nm) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mid_nm:' + getFieldTypeText(h.mid_nm) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'last_nm:' + getFieldTypeText(h.last_nm) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sfx_cd:' + getFieldTypeText(h.sfx_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'gender_cd:' + getFieldTypeText(h.gender_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_prfsn_cd:' + getFieldTypeText(h.prim_prfsn_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_prfsn_desc:' + getFieldTypeText(h.prim_prfsn_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_spcl_cd:' + getFieldTypeText(h.prim_spcl_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_spcl_desc:' + getFieldTypeText(h.prim_spcl_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sec_spcl_cd:' + getFieldTypeText(h.sec_spcl_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sec_spcl_desc:' + getFieldTypeText(h.sec_spcl_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tert_spcl_cd:' + getFieldTypeText(h.tert_spcl_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tert_spcl_desc:' + getFieldTypeText(h.tert_spcl_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sub_spcl_cd:' + getFieldTypeText(h.sub_spcl_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sub_spcl_desc:' + getFieldTypeText(h.sub_spcl_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'titl_typ_id:' + getFieldTypeText(h.titl_typ_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'titl_typ_desc:' + getFieldTypeText(h.titl_typ_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hco_hce_id:' + getFieldTypeText(h.hco_hce_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ok_wkp_id:' + getFieldTypeText(h.ok_wkp_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ska_id:' + getFieldTypeText(h.ska_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bus_nm:' + getFieldTypeText(h.bus_nm) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dba_nm:' + getFieldTypeText(h.dba_nm) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_id:' + getFieldTypeText(h.addr_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'str_front_id:' + getFieldTypeText(h.str_front_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_ln_1_txt:' + getFieldTypeText(h.addr_ln_1_txt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_ln_2_txt:' + getFieldTypeText(h.addr_ln_2_txt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city_nm:' + getFieldTypeText(h.city_nm) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'st_cd:' + getFieldTypeText(h.st_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip5_cd:' + getFieldTypeText(h.zip5_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip4_cd:' + getFieldTypeText(h.zip4_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fips_cnty_cd:' + getFieldTypeText(h.fips_cnty_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fips_cnty_desc:' + getFieldTypeText(h.fips_cnty_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'telephn_nbr:' + getFieldTypeText(h.telephn_nbr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cot_id:' + getFieldTypeText(h.cot_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cot_clas_id:' + getFieldTypeText(h.cot_clas_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cot_clas_desc:' + getFieldTypeText(h.cot_clas_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cot_fclt_typ_id:' + getFieldTypeText(h.cot_fclt_typ_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cot_fclt_typ_desc:' + getFieldTypeText(h.cot_fclt_typ_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cot_spcl_id:' + getFieldTypeText(h.cot_spcl_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cot_spcl_desc:' + getFieldTypeText(h.cot_spcl_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'email_ind_flag:' + getFieldTypeText(h.email_ind_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hcp_affil_xid:' + getFieldTypeText(h.hcp_affil_xid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'delta_cd:' + getFieldTypeText(h.delta_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_hcp_hce_id_cnt
          ,le.populated_ok_indv_id_cnt
          ,le.populated_ska_uid_cnt
          ,le.populated_frst_nm_cnt
          ,le.populated_mid_nm_cnt
          ,le.populated_last_nm_cnt
          ,le.populated_sfx_cd_cnt
          ,le.populated_gender_cd_cnt
          ,le.populated_prim_prfsn_cd_cnt
          ,le.populated_prim_prfsn_desc_cnt
          ,le.populated_prim_spcl_cd_cnt
          ,le.populated_prim_spcl_desc_cnt
          ,le.populated_sec_spcl_cd_cnt
          ,le.populated_sec_spcl_desc_cnt
          ,le.populated_tert_spcl_cd_cnt
          ,le.populated_tert_spcl_desc_cnt
          ,le.populated_sub_spcl_cd_cnt
          ,le.populated_sub_spcl_desc_cnt
          ,le.populated_titl_typ_id_cnt
          ,le.populated_titl_typ_desc_cnt
          ,le.populated_hco_hce_id_cnt
          ,le.populated_ok_wkp_id_cnt
          ,le.populated_ska_id_cnt
          ,le.populated_bus_nm_cnt
          ,le.populated_dba_nm_cnt
          ,le.populated_addr_id_cnt
          ,le.populated_str_front_id_cnt
          ,le.populated_addr_ln_1_txt_cnt
          ,le.populated_addr_ln_2_txt_cnt
          ,le.populated_city_nm_cnt
          ,le.populated_st_cd_cnt
          ,le.populated_zip5_cd_cnt
          ,le.populated_zip4_cd_cnt
          ,le.populated_fips_cnty_cd_cnt
          ,le.populated_fips_cnty_desc_cnt
          ,le.populated_telephn_nbr_cnt
          ,le.populated_cot_id_cnt
          ,le.populated_cot_clas_id_cnt
          ,le.populated_cot_clas_desc_cnt
          ,le.populated_cot_fclt_typ_id_cnt
          ,le.populated_cot_fclt_typ_desc_cnt
          ,le.populated_cot_spcl_id_cnt
          ,le.populated_cot_spcl_desc_cnt
          ,le.populated_email_ind_flag_cnt
          ,le.populated_hcp_affil_xid_cnt
          ,le.populated_delta_cd_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_hcp_hce_id_pcnt
          ,le.populated_ok_indv_id_pcnt
          ,le.populated_ska_uid_pcnt
          ,le.populated_frst_nm_pcnt
          ,le.populated_mid_nm_pcnt
          ,le.populated_last_nm_pcnt
          ,le.populated_sfx_cd_pcnt
          ,le.populated_gender_cd_pcnt
          ,le.populated_prim_prfsn_cd_pcnt
          ,le.populated_prim_prfsn_desc_pcnt
          ,le.populated_prim_spcl_cd_pcnt
          ,le.populated_prim_spcl_desc_pcnt
          ,le.populated_sec_spcl_cd_pcnt
          ,le.populated_sec_spcl_desc_pcnt
          ,le.populated_tert_spcl_cd_pcnt
          ,le.populated_tert_spcl_desc_pcnt
          ,le.populated_sub_spcl_cd_pcnt
          ,le.populated_sub_spcl_desc_pcnt
          ,le.populated_titl_typ_id_pcnt
          ,le.populated_titl_typ_desc_pcnt
          ,le.populated_hco_hce_id_pcnt
          ,le.populated_ok_wkp_id_pcnt
          ,le.populated_ska_id_pcnt
          ,le.populated_bus_nm_pcnt
          ,le.populated_dba_nm_pcnt
          ,le.populated_addr_id_pcnt
          ,le.populated_str_front_id_pcnt
          ,le.populated_addr_ln_1_txt_pcnt
          ,le.populated_addr_ln_2_txt_pcnt
          ,le.populated_city_nm_pcnt
          ,le.populated_st_cd_pcnt
          ,le.populated_zip5_cd_pcnt
          ,le.populated_zip4_cd_pcnt
          ,le.populated_fips_cnty_cd_pcnt
          ,le.populated_fips_cnty_desc_pcnt
          ,le.populated_telephn_nbr_pcnt
          ,le.populated_cot_id_pcnt
          ,le.populated_cot_clas_id_pcnt
          ,le.populated_cot_clas_desc_pcnt
          ,le.populated_cot_fclt_typ_id_pcnt
          ,le.populated_cot_fclt_typ_desc_pcnt
          ,le.populated_cot_spcl_id_pcnt
          ,le.populated_cot_spcl_desc_pcnt
          ,le.populated_email_ind_flag_pcnt
          ,le.populated_hcp_affil_xid_pcnt
          ,le.populated_delta_cd_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,46,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := InputA_Delta(prevDS, PROJECT(h, InputA_Layout_OneKey));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),46,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(InputA_Layout_OneKey) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_OneKey, InputA_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
