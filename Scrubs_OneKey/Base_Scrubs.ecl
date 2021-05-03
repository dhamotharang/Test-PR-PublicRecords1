IMPORT SALT311,STD;
IMPORT Scrubs_OneKey; // Import modules for FieldTypes attribute definitions
EXPORT Base_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 28;
  EXPORT NumRulesFromFieldType := 28;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 28;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Base_Layout_OneKey)
    UNSIGNED1 source_Invalid;
    UNSIGNED1 bdid_Invalid;
    UNSIGNED1 source_rec_id_Invalid;
    UNSIGNED1 dt_vendor_first_reported_Invalid;
    UNSIGNED1 dt_vendor_last_reported_Invalid;
    UNSIGNED1 record_type_Invalid;
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
    UNSIGNED1 prep_addr_line1_Invalid;
    UNSIGNED1 prep_addr_line_last_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Base_Layout_OneKey)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(Base_Layout_OneKey)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'source:invalid_source:ENUM'
          ,'bdid:invalid_numeric:CUSTOM'
          ,'source_rec_id:invalid_numeric_nonzero:CUSTOM'
          ,'dt_vendor_first_reported:invalid_pastdate8:CUSTOM'
          ,'dt_vendor_last_reported:invalid_pastdate8:CUSTOM'
          ,'record_type:invalid_record_type:ENUM'
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
          ,'prep_addr_line1:invalid_mandatory:CUSTOM'
          ,'prep_addr_line_last:invalid_mandatory:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Base_Fields.InvalidMessage_source(1)
          ,Base_Fields.InvalidMessage_bdid(1)
          ,Base_Fields.InvalidMessage_source_rec_id(1)
          ,Base_Fields.InvalidMessage_dt_vendor_first_reported(1)
          ,Base_Fields.InvalidMessage_dt_vendor_last_reported(1)
          ,Base_Fields.InvalidMessage_record_type(1)
          ,Base_Fields.InvalidMessage_hcp_hce_id(1)
          ,Base_Fields.InvalidMessage_frst_nm(1)
          ,Base_Fields.InvalidMessage_mid_nm(1)
          ,Base_Fields.InvalidMessage_last_nm(1)
          ,Base_Fields.InvalidMessage_prim_prfsn_cd(1)
          ,Base_Fields.InvalidMessage_prim_prfsn_desc(1)
          ,Base_Fields.InvalidMessage_prim_spcl_cd(1)
          ,Base_Fields.InvalidMessage_prim_spcl_desc(1)
          ,Base_Fields.InvalidMessage_sec_spcl_cd(1)
          ,Base_Fields.InvalidMessage_sec_spcl_desc(1)
          ,Base_Fields.InvalidMessage_tert_spcl_cd(1)
          ,Base_Fields.InvalidMessage_tert_spcl_desc(1)
          ,Base_Fields.InvalidMessage_sub_spcl_cd(1)
          ,Base_Fields.InvalidMessage_sub_spcl_desc(1)
          ,Base_Fields.InvalidMessage_titl_typ_id(1)
          ,Base_Fields.InvalidMessage_titl_typ_desc(1)
          ,Base_Fields.InvalidMessage_hco_hce_id(1)
          ,Base_Fields.InvalidMessage_ok_wkp_id(1)
          ,Base_Fields.InvalidMessage_ska_id(1)
          ,Base_Fields.InvalidMessage_bus_nm(1)
          ,Base_Fields.InvalidMessage_prep_addr_line1(1)
          ,Base_Fields.InvalidMessage_prep_addr_line_last(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(Base_Layout_OneKey) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.source_Invalid := Base_Fields.InValid_source((SALT311.StrType)le.source);
    SELF.bdid_Invalid := Base_Fields.InValid_bdid((SALT311.StrType)le.bdid);
    SELF.source_rec_id_Invalid := Base_Fields.InValid_source_rec_id((SALT311.StrType)le.source_rec_id);
    SELF.dt_vendor_first_reported_Invalid := Base_Fields.InValid_dt_vendor_first_reported((SALT311.StrType)le.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported_Invalid := Base_Fields.InValid_dt_vendor_last_reported((SALT311.StrType)le.dt_vendor_last_reported);
    SELF.record_type_Invalid := Base_Fields.InValid_record_type((SALT311.StrType)le.record_type);
    SELF.hcp_hce_id_Invalid := Base_Fields.InValid_hcp_hce_id((SALT311.StrType)le.hcp_hce_id);
    SELF.frst_nm_Invalid := Base_Fields.InValid_frst_nm((SALT311.StrType)le.frst_nm,(SALT311.StrType)le.mid_nm,(SALT311.StrType)le.last_nm);
    SELF.mid_nm_Invalid := Base_Fields.InValid_mid_nm((SALT311.StrType)le.mid_nm,(SALT311.StrType)le.frst_nm,(SALT311.StrType)le.last_nm);
    SELF.last_nm_Invalid := Base_Fields.InValid_last_nm((SALT311.StrType)le.last_nm,(SALT311.StrType)le.frst_nm,(SALT311.StrType)le.mid_nm);
    SELF.prim_prfsn_cd_Invalid := Base_Fields.InValid_prim_prfsn_cd((SALT311.StrType)le.prim_prfsn_cd,(SALT311.StrType)le.prim_prfsn_desc);
    SELF.prim_prfsn_desc_Invalid := Base_Fields.InValid_prim_prfsn_desc((SALT311.StrType)le.prim_prfsn_desc,(SALT311.StrType)le.prim_prfsn_cd);
    SELF.prim_spcl_cd_Invalid := Base_Fields.InValid_prim_spcl_cd((SALT311.StrType)le.prim_spcl_cd,(SALT311.StrType)le.prim_spcl_desc);
    SELF.prim_spcl_desc_Invalid := Base_Fields.InValid_prim_spcl_desc((SALT311.StrType)le.prim_spcl_desc,(SALT311.StrType)le.prim_spcl_cd);
    SELF.sec_spcl_cd_Invalid := Base_Fields.InValid_sec_spcl_cd((SALT311.StrType)le.sec_spcl_cd,(SALT311.StrType)le.sec_spcl_desc);
    SELF.sec_spcl_desc_Invalid := Base_Fields.InValid_sec_spcl_desc((SALT311.StrType)le.sec_spcl_desc,(SALT311.StrType)le.sec_spcl_cd);
    SELF.tert_spcl_cd_Invalid := Base_Fields.InValid_tert_spcl_cd((SALT311.StrType)le.tert_spcl_cd,(SALT311.StrType)le.tert_spcl_desc);
    SELF.tert_spcl_desc_Invalid := Base_Fields.InValid_tert_spcl_desc((SALT311.StrType)le.tert_spcl_desc,(SALT311.StrType)le.tert_spcl_cd);
    SELF.sub_spcl_cd_Invalid := Base_Fields.InValid_sub_spcl_cd((SALT311.StrType)le.sub_spcl_cd,(SALT311.StrType)le.sub_spcl_desc);
    SELF.sub_spcl_desc_Invalid := Base_Fields.InValid_sub_spcl_desc((SALT311.StrType)le.sub_spcl_desc,(SALT311.StrType)le.sub_spcl_cd);
    SELF.titl_typ_id_Invalid := Base_Fields.InValid_titl_typ_id((SALT311.StrType)le.titl_typ_id,(SALT311.StrType)le.titl_typ_desc);
    SELF.titl_typ_desc_Invalid := Base_Fields.InValid_titl_typ_desc((SALT311.StrType)le.titl_typ_desc,(SALT311.StrType)le.titl_typ_id);
    SELF.hco_hce_id_Invalid := Base_Fields.InValid_hco_hce_id((SALT311.StrType)le.hco_hce_id);
    SELF.ok_wkp_id_Invalid := Base_Fields.InValid_ok_wkp_id((SALT311.StrType)le.ok_wkp_id);
    SELF.ska_id_Invalid := Base_Fields.InValid_ska_id((SALT311.StrType)le.ska_id);
    SELF.bus_nm_Invalid := Base_Fields.InValid_bus_nm((SALT311.StrType)le.bus_nm);
    SELF.prep_addr_line1_Invalid := Base_Fields.InValid_prep_addr_line1((SALT311.StrType)le.prep_addr_line1);
    SELF.prep_addr_line_last_Invalid := Base_Fields.InValid_prep_addr_line_last((SALT311.StrType)le.prep_addr_line_last);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Base_Layout_OneKey);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.source_Invalid << 0 ) + ( le.bdid_Invalid << 1 ) + ( le.source_rec_id_Invalid << 2 ) + ( le.dt_vendor_first_reported_Invalid << 3 ) + ( le.dt_vendor_last_reported_Invalid << 4 ) + ( le.record_type_Invalid << 5 ) + ( le.hcp_hce_id_Invalid << 6 ) + ( le.frst_nm_Invalid << 7 ) + ( le.mid_nm_Invalid << 8 ) + ( le.last_nm_Invalid << 9 ) + ( le.prim_prfsn_cd_Invalid << 10 ) + ( le.prim_prfsn_desc_Invalid << 11 ) + ( le.prim_spcl_cd_Invalid << 12 ) + ( le.prim_spcl_desc_Invalid << 13 ) + ( le.sec_spcl_cd_Invalid << 14 ) + ( le.sec_spcl_desc_Invalid << 15 ) + ( le.tert_spcl_cd_Invalid << 16 ) + ( le.tert_spcl_desc_Invalid << 17 ) + ( le.sub_spcl_cd_Invalid << 18 ) + ( le.sub_spcl_desc_Invalid << 19 ) + ( le.titl_typ_id_Invalid << 20 ) + ( le.titl_typ_desc_Invalid << 21 ) + ( le.hco_hce_id_Invalid << 22 ) + ( le.ok_wkp_id_Invalid << 23 ) + ( le.ska_id_Invalid << 24 ) + ( le.bus_nm_Invalid << 25 ) + ( le.prep_addr_line1_Invalid << 26 ) + ( le.prep_addr_line_last_Invalid << 27 );
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
  EXPORT Infile := PROJECT(h,Base_Layout_OneKey);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.source_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.bdid_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.source_rec_id_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.dt_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.dt_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.record_type_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.hcp_hce_id_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.frst_nm_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.mid_nm_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.last_nm_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.prim_prfsn_cd_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.prim_prfsn_desc_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.prim_spcl_cd_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.prim_spcl_desc_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.sec_spcl_cd_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.sec_spcl_desc_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.tert_spcl_cd_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.tert_spcl_desc_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.sub_spcl_cd_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.sub_spcl_desc_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.titl_typ_id_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.titl_typ_desc_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.hco_hce_id_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.ok_wkp_id_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.ska_id_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.bus_nm_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.prep_addr_line1_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.prep_addr_line_last_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    source_ENUM_ErrorCount := COUNT(GROUP,h.source_Invalid=1);
    bdid_CUSTOM_ErrorCount := COUNT(GROUP,h.bdid_Invalid=1);
    source_rec_id_CUSTOM_ErrorCount := COUNT(GROUP,h.source_rec_id_Invalid=1);
    dt_vendor_first_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=1);
    dt_vendor_last_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=1);
    record_type_ENUM_ErrorCount := COUNT(GROUP,h.record_type_Invalid=1);
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
    prep_addr_line1_CUSTOM_ErrorCount := COUNT(GROUP,h.prep_addr_line1_Invalid=1);
    prep_addr_line_last_CUSTOM_ErrorCount := COUNT(GROUP,h.prep_addr_line_last_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.source_Invalid > 0 OR h.bdid_Invalid > 0 OR h.source_rec_id_Invalid > 0 OR h.dt_vendor_first_reported_Invalid > 0 OR h.dt_vendor_last_reported_Invalid > 0 OR h.record_type_Invalid > 0 OR h.hcp_hce_id_Invalid > 0 OR h.frst_nm_Invalid > 0 OR h.mid_nm_Invalid > 0 OR h.last_nm_Invalid > 0 OR h.prim_prfsn_cd_Invalid > 0 OR h.prim_prfsn_desc_Invalid > 0 OR h.prim_spcl_cd_Invalid > 0 OR h.prim_spcl_desc_Invalid > 0 OR h.sec_spcl_cd_Invalid > 0 OR h.sec_spcl_desc_Invalid > 0 OR h.tert_spcl_cd_Invalid > 0 OR h.tert_spcl_desc_Invalid > 0 OR h.sub_spcl_cd_Invalid > 0 OR h.sub_spcl_desc_Invalid > 0 OR h.titl_typ_id_Invalid > 0 OR h.titl_typ_desc_Invalid > 0 OR h.hco_hce_id_Invalid > 0 OR h.ok_wkp_id_Invalid > 0 OR h.ska_id_Invalid > 0 OR h.bus_nm_Invalid > 0 OR h.prep_addr_line1_Invalid > 0 OR h.prep_addr_line_last_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.source_ENUM_ErrorCount > 0, 1, 0) + IF(le.bdid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.source_rec_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.hcp_hce_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.frst_nm_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mid_nm_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.last_nm_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prim_prfsn_cd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prim_prfsn_desc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prim_spcl_cd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prim_spcl_desc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sec_spcl_cd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sec_spcl_desc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.tert_spcl_cd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.tert_spcl_desc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sub_spcl_cd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sub_spcl_desc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.titl_typ_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.titl_typ_desc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.hco_hce_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ok_wkp_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ska_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bus_nm_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prep_addr_line1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prep_addr_line_last_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.source_ENUM_ErrorCount > 0, 1, 0) + IF(le.bdid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.source_rec_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.hcp_hce_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.frst_nm_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mid_nm_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.last_nm_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prim_prfsn_cd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prim_prfsn_desc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prim_spcl_cd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prim_spcl_desc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sec_spcl_cd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sec_spcl_desc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.tert_spcl_cd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.tert_spcl_desc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sub_spcl_cd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sub_spcl_desc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.titl_typ_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.titl_typ_desc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.hco_hce_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ok_wkp_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ska_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bus_nm_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prep_addr_line1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prep_addr_line_last_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.source_Invalid,le.bdid_Invalid,le.source_rec_id_Invalid,le.dt_vendor_first_reported_Invalid,le.dt_vendor_last_reported_Invalid,le.record_type_Invalid,le.hcp_hce_id_Invalid,le.frst_nm_Invalid,le.mid_nm_Invalid,le.last_nm_Invalid,le.prim_prfsn_cd_Invalid,le.prim_prfsn_desc_Invalid,le.prim_spcl_cd_Invalid,le.prim_spcl_desc_Invalid,le.sec_spcl_cd_Invalid,le.sec_spcl_desc_Invalid,le.tert_spcl_cd_Invalid,le.tert_spcl_desc_Invalid,le.sub_spcl_cd_Invalid,le.sub_spcl_desc_Invalid,le.titl_typ_id_Invalid,le.titl_typ_desc_Invalid,le.hco_hce_id_Invalid,le.ok_wkp_id_Invalid,le.ska_id_Invalid,le.bus_nm_Invalid,le.prep_addr_line1_Invalid,le.prep_addr_line_last_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Base_Fields.InvalidMessage_source(le.source_Invalid),Base_Fields.InvalidMessage_bdid(le.bdid_Invalid),Base_Fields.InvalidMessage_source_rec_id(le.source_rec_id_Invalid),Base_Fields.InvalidMessage_dt_vendor_first_reported(le.dt_vendor_first_reported_Invalid),Base_Fields.InvalidMessage_dt_vendor_last_reported(le.dt_vendor_last_reported_Invalid),Base_Fields.InvalidMessage_record_type(le.record_type_Invalid),Base_Fields.InvalidMessage_hcp_hce_id(le.hcp_hce_id_Invalid),Base_Fields.InvalidMessage_frst_nm(le.frst_nm_Invalid),Base_Fields.InvalidMessage_mid_nm(le.mid_nm_Invalid),Base_Fields.InvalidMessage_last_nm(le.last_nm_Invalid),Base_Fields.InvalidMessage_prim_prfsn_cd(le.prim_prfsn_cd_Invalid),Base_Fields.InvalidMessage_prim_prfsn_desc(le.prim_prfsn_desc_Invalid),Base_Fields.InvalidMessage_prim_spcl_cd(le.prim_spcl_cd_Invalid),Base_Fields.InvalidMessage_prim_spcl_desc(le.prim_spcl_desc_Invalid),Base_Fields.InvalidMessage_sec_spcl_cd(le.sec_spcl_cd_Invalid),Base_Fields.InvalidMessage_sec_spcl_desc(le.sec_spcl_desc_Invalid),Base_Fields.InvalidMessage_tert_spcl_cd(le.tert_spcl_cd_Invalid),Base_Fields.InvalidMessage_tert_spcl_desc(le.tert_spcl_desc_Invalid),Base_Fields.InvalidMessage_sub_spcl_cd(le.sub_spcl_cd_Invalid),Base_Fields.InvalidMessage_sub_spcl_desc(le.sub_spcl_desc_Invalid),Base_Fields.InvalidMessage_titl_typ_id(le.titl_typ_id_Invalid),Base_Fields.InvalidMessage_titl_typ_desc(le.titl_typ_desc_Invalid),Base_Fields.InvalidMessage_hco_hce_id(le.hco_hce_id_Invalid),Base_Fields.InvalidMessage_ok_wkp_id(le.ok_wkp_id_Invalid),Base_Fields.InvalidMessage_ska_id(le.ska_id_Invalid),Base_Fields.InvalidMessage_bus_nm(le.bus_nm_Invalid),Base_Fields.InvalidMessage_prep_addr_line1(le.prep_addr_line1_Invalid),Base_Fields.InvalidMessage_prep_addr_line_last(le.prep_addr_line_last_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.source_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.bdid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.source_rec_id_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_vendor_first_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_vendor_last_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.record_type_Invalid,'ENUM','UNKNOWN')
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
          ,CHOOSE(le.prep_addr_line1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.prep_addr_line_last_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'source','bdid','source_rec_id','dt_vendor_first_reported','dt_vendor_last_reported','record_type','hcp_hce_id','frst_nm','mid_nm','last_nm','prim_prfsn_cd','prim_prfsn_desc','prim_spcl_cd','prim_spcl_desc','sec_spcl_cd','sec_spcl_desc','tert_spcl_cd','tert_spcl_desc','sub_spcl_cd','sub_spcl_desc','titl_typ_id','titl_typ_desc','hco_hce_id','ok_wkp_id','ska_id','bus_nm','prep_addr_line1','prep_addr_line_last','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_source','invalid_numeric','invalid_numeric_nonzero','invalid_pastdate8','invalid_pastdate8','invalid_record_type','invalid_numeric_nonzero','invalid_frst_nm','invalid_mid_nm','invalid_last_nm','invalid_prim_prfsn_cd','invalid_prim_prfsn_desc','invalid_prim_spcl_cd','invalid_prim_spcl_desc','invalid_sec_spcl_cd','invalid_sec_spcl_desc','invalid_tert_spcl_cd','invalid_tert_spcl_desc','invalid_sub_spcl_cd','invalid_sub_spcl_desc','invalid_titl_typ_id','invalid_titl_typ_desc','invalid_numeric_nonzero','invalid_ok_wkp_id','invalid_numeric_nonzero','invalid_mandatory','invalid_mandatory','invalid_mandatory','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.source,(SALT311.StrType)le.bdid,(SALT311.StrType)le.source_rec_id,(SALT311.StrType)le.dt_vendor_first_reported,(SALT311.StrType)le.dt_vendor_last_reported,(SALT311.StrType)le.record_type,(SALT311.StrType)le.hcp_hce_id,(SALT311.StrType)le.frst_nm,(SALT311.StrType)le.mid_nm,(SALT311.StrType)le.last_nm,(SALT311.StrType)le.prim_prfsn_cd,(SALT311.StrType)le.prim_prfsn_desc,(SALT311.StrType)le.prim_spcl_cd,(SALT311.StrType)le.prim_spcl_desc,(SALT311.StrType)le.sec_spcl_cd,(SALT311.StrType)le.sec_spcl_desc,(SALT311.StrType)le.tert_spcl_cd,(SALT311.StrType)le.tert_spcl_desc,(SALT311.StrType)le.sub_spcl_cd,(SALT311.StrType)le.sub_spcl_desc,(SALT311.StrType)le.titl_typ_id,(SALT311.StrType)le.titl_typ_desc,(SALT311.StrType)le.hco_hce_id,(SALT311.StrType)le.ok_wkp_id,(SALT311.StrType)le.ska_id,(SALT311.StrType)le.bus_nm,(SALT311.StrType)le.prep_addr_line1,(SALT311.StrType)le.prep_addr_line_last,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,28,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Base_Layout_OneKey) prevDS = DATASET([], Base_Layout_OneKey), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.source_ENUM_ErrorCount
          ,le.bdid_CUSTOM_ErrorCount
          ,le.source_rec_id_CUSTOM_ErrorCount
          ,le.dt_vendor_first_reported_CUSTOM_ErrorCount
          ,le.dt_vendor_last_reported_CUSTOM_ErrorCount
          ,le.record_type_ENUM_ErrorCount
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
          ,le.prep_addr_line1_CUSTOM_ErrorCount
          ,le.prep_addr_line_last_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.source_ENUM_ErrorCount
          ,le.bdid_CUSTOM_ErrorCount
          ,le.source_rec_id_CUSTOM_ErrorCount
          ,le.dt_vendor_first_reported_CUSTOM_ErrorCount
          ,le.dt_vendor_last_reported_CUSTOM_ErrorCount
          ,le.record_type_ENUM_ErrorCount
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
          ,le.prep_addr_line1_CUSTOM_ErrorCount
          ,le.prep_addr_line_last_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := Base_hygiene(PROJECT(h, Base_Layout_OneKey));
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
          ,'source:' + getFieldTypeText(h.source) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bdid:' + getFieldTypeText(h.bdid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bdid_score:' + getFieldTypeText(h.bdid_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_rec_id:' + getFieldTypeText(h.source_rec_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_first_reported:' + getFieldTypeText(h.dt_vendor_first_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_last_reported:' + getFieldTypeText(h.dt_vendor_last_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'record_type:' + getFieldTypeText(h.record_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
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
          ,'ims_id:' + getFieldTypeText(h.ims_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hce_prfsnl_stat_cd:' + getFieldTypeText(h.hce_prfsnl_stat_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hce_prfsnl_stat_desc:' + getFieldTypeText(h.hce_prfsnl_stat_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'excld_rsn_desc:' + getFieldTypeText(h.excld_rsn_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'npi:' + getFieldTypeText(h.npi) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'deactv_dt:' + getFieldTypeText(h.deactv_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cleaned_deactv_dt:' + getFieldTypeText(h.cleaned_deactv_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'xref_hce_id:' + getFieldTypeText(h.xref_hce_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title:' + getFieldTypeText(h.title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fname:' + getFieldTypeText(h.fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mname:' + getFieldTypeText(h.mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname:' + getFieldTypeText(h.lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_suffix:' + getFieldTypeText(h.name_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_score:' + getFieldTypeText(h.name_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prep_addr_line1:' + getFieldTypeText(h.prep_addr_line1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prep_addr_line_last:' + getFieldTypeText(h.prep_addr_line_last) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
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
          ,'fips_state:' + getFieldTypeText(h.fips_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fips_county:' + getFieldTypeText(h.fips_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_lat:' + getFieldTypeText(h.geo_lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_long:' + getFieldTypeText(h.geo_long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'msa:' + getFieldTypeText(h.msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_blk:' + getFieldTypeText(h.geo_blk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_match:' + getFieldTypeText(h.geo_match) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'err_stat:' + getFieldTypeText(h.err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'raw_aid:' + getFieldTypeText(h.raw_aid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ace_aid:' + getFieldTypeText(h.ace_aid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dotid:' + getFieldTypeText(h.dotid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dotscore:' + getFieldTypeText(h.dotscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dotweight:' + getFieldTypeText(h.dotweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'empid:' + getFieldTypeText(h.empid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'empscore:' + getFieldTypeText(h.empscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'empweight:' + getFieldTypeText(h.empweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'powid:' + getFieldTypeText(h.powid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'powscore:' + getFieldTypeText(h.powscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'powweight:' + getFieldTypeText(h.powweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'proxid:' + getFieldTypeText(h.proxid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'proxscore:' + getFieldTypeText(h.proxscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'proxweight:' + getFieldTypeText(h.proxweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'seleid:' + getFieldTypeText(h.seleid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'selescore:' + getFieldTypeText(h.selescore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'seleweight:' + getFieldTypeText(h.seleweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orgid:' + getFieldTypeText(h.orgid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orgscore:' + getFieldTypeText(h.orgscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orgweight:' + getFieldTypeText(h.orgweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ultid:' + getFieldTypeText(h.ultid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ultscore:' + getFieldTypeText(h.ultscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ultweight:' + getFieldTypeText(h.ultweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_source_cnt
          ,le.populated_bdid_cnt
          ,le.populated_bdid_score_cnt
          ,le.populated_source_rec_id_cnt
          ,le.populated_dt_vendor_first_reported_cnt
          ,le.populated_dt_vendor_last_reported_cnt
          ,le.populated_record_type_cnt
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
          ,le.populated_ims_id_cnt
          ,le.populated_hce_prfsnl_stat_cd_cnt
          ,le.populated_hce_prfsnl_stat_desc_cnt
          ,le.populated_excld_rsn_desc_cnt
          ,le.populated_npi_cnt
          ,le.populated_deactv_dt_cnt
          ,le.populated_cleaned_deactv_dt_cnt
          ,le.populated_xref_hce_id_cnt
          ,le.populated_title_cnt
          ,le.populated_fname_cnt
          ,le.populated_mname_cnt
          ,le.populated_lname_cnt
          ,le.populated_name_suffix_cnt
          ,le.populated_name_score_cnt
          ,le.populated_prep_addr_line1_cnt
          ,le.populated_prep_addr_line_last_cnt
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
          ,le.populated_fips_state_cnt
          ,le.populated_fips_county_cnt
          ,le.populated_geo_lat_cnt
          ,le.populated_geo_long_cnt
          ,le.populated_msa_cnt
          ,le.populated_geo_blk_cnt
          ,le.populated_geo_match_cnt
          ,le.populated_err_stat_cnt
          ,le.populated_raw_aid_cnt
          ,le.populated_ace_aid_cnt
          ,le.populated_dotid_cnt
          ,le.populated_dotscore_cnt
          ,le.populated_dotweight_cnt
          ,le.populated_empid_cnt
          ,le.populated_empscore_cnt
          ,le.populated_empweight_cnt
          ,le.populated_powid_cnt
          ,le.populated_powscore_cnt
          ,le.populated_powweight_cnt
          ,le.populated_proxid_cnt
          ,le.populated_proxscore_cnt
          ,le.populated_proxweight_cnt
          ,le.populated_seleid_cnt
          ,le.populated_selescore_cnt
          ,le.populated_seleweight_cnt
          ,le.populated_orgid_cnt
          ,le.populated_orgscore_cnt
          ,le.populated_orgweight_cnt
          ,le.populated_ultid_cnt
          ,le.populated_ultscore_cnt
          ,le.populated_ultweight_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_source_pcnt
          ,le.populated_bdid_pcnt
          ,le.populated_bdid_score_pcnt
          ,le.populated_source_rec_id_pcnt
          ,le.populated_dt_vendor_first_reported_pcnt
          ,le.populated_dt_vendor_last_reported_pcnt
          ,le.populated_record_type_pcnt
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
          ,le.populated_ims_id_pcnt
          ,le.populated_hce_prfsnl_stat_cd_pcnt
          ,le.populated_hce_prfsnl_stat_desc_pcnt
          ,le.populated_excld_rsn_desc_pcnt
          ,le.populated_npi_pcnt
          ,le.populated_deactv_dt_pcnt
          ,le.populated_cleaned_deactv_dt_pcnt
          ,le.populated_xref_hce_id_pcnt
          ,le.populated_title_pcnt
          ,le.populated_fname_pcnt
          ,le.populated_mname_pcnt
          ,le.populated_lname_pcnt
          ,le.populated_name_suffix_pcnt
          ,le.populated_name_score_pcnt
          ,le.populated_prep_addr_line1_pcnt
          ,le.populated_prep_addr_line_last_pcnt
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
          ,le.populated_fips_state_pcnt
          ,le.populated_fips_county_pcnt
          ,le.populated_geo_lat_pcnt
          ,le.populated_geo_long_pcnt
          ,le.populated_msa_pcnt
          ,le.populated_geo_blk_pcnt
          ,le.populated_geo_match_pcnt
          ,le.populated_err_stat_pcnt
          ,le.populated_raw_aid_pcnt
          ,le.populated_ace_aid_pcnt
          ,le.populated_dotid_pcnt
          ,le.populated_dotscore_pcnt
          ,le.populated_dotweight_pcnt
          ,le.populated_empid_pcnt
          ,le.populated_empscore_pcnt
          ,le.populated_empweight_pcnt
          ,le.populated_powid_pcnt
          ,le.populated_powscore_pcnt
          ,le.populated_powweight_pcnt
          ,le.populated_proxid_pcnt
          ,le.populated_proxscore_pcnt
          ,le.populated_proxweight_pcnt
          ,le.populated_seleid_pcnt
          ,le.populated_selescore_pcnt
          ,le.populated_seleweight_pcnt
          ,le.populated_orgid_pcnt
          ,le.populated_orgscore_pcnt
          ,le.populated_orgweight_pcnt
          ,le.populated_ultid_pcnt
          ,le.populated_ultscore_pcnt
          ,le.populated_ultweight_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,117,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Base_Delta(prevDS, PROJECT(h, Base_Layout_OneKey));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),117,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Base_Layout_OneKey) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_OneKey, Base_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
