IMPORT SALT311,STD;
EXPORT Lerg6Raw_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 28;
  EXPORT NumRulesFromFieldType := 28;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 28;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Lerg6Raw_Layout_Phonesinfo)
    UNSIGNED1 lata_Invalid;
    UNSIGNED1 lata_name_Invalid;
    UNSIGNED1 status_Invalid;
    UNSIGNED1 npa_Invalid;
    UNSIGNED1 nxx_Invalid;
    UNSIGNED1 block_id_Invalid;
    UNSIGNED1 coc_type_Invalid;
    UNSIGNED1 ssc_Invalid;
    UNSIGNED1 dind_Invalid;
    UNSIGNED1 td_eo_Invalid;
    UNSIGNED1 td_at_Invalid;
    UNSIGNED1 portable_Invalid;
    UNSIGNED1 aocn_Invalid;
    UNSIGNED1 ocn_Invalid;
    UNSIGNED1 loc_name_Invalid;
    UNSIGNED1 loc_Invalid;
    UNSIGNED1 loc_state_Invalid;
    UNSIGNED1 rc_abbre_Invalid;
    UNSIGNED1 rc_ty_Invalid;
    UNSIGNED1 line_fr_Invalid;
    UNSIGNED1 line_to_Invalid;
    UNSIGNED1 switch_Invalid;
    UNSIGNED1 sha_indicator_Invalid;
    UNSIGNED1 test_line_num_Invalid;
    UNSIGNED1 test_line_response_Invalid;
    UNSIGNED1 blk_1000_pool_Invalid;
    UNSIGNED1 rc_lata_Invalid;
    UNSIGNED1 filename_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Lerg6Raw_Layout_Phonesinfo)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(Lerg6Raw_Layout_Phonesinfo)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'lata:Invalid_Num:ALLOW'
          ,'lata_name:Invalid_Alpha:ALLOW'
          ,'status:Invalid_StatusCode:ENUM'
          ,'npa:Invalid_Num:ALLOW'
          ,'nxx:Invalid_Nxx:ALLOW'
          ,'block_id:Invalid_BlockID:ALLOW'
          ,'coc_type:Invalid_CocTypeCode:ENUM'
          ,'ssc:Invalid_SccTypeCode:ALLOW'
          ,'dind:Invalid_YesNo:ENUM'
          ,'td_eo:Invalid_TdCode:ALLOW'
          ,'td_at:Invalid_TdCode:ALLOW'
          ,'portable:Invalid_YesNo:ENUM'
          ,'aocn:Invalid_Char:ALLOW'
          ,'ocn:Invalid_Char:ALLOW'
          ,'loc_name:Invalid_Char:ALLOW'
          ,'loc:Invalid_Char:ALLOW'
          ,'loc_state:Invalid_Alpha:ALLOW'
          ,'rc_abbre:Invalid_Char:ALLOW'
          ,'rc_ty:Invalid_RcTyCode:ENUM'
          ,'line_fr:Invalid_Num:ALLOW'
          ,'line_to:Invalid_Num:ALLOW'
          ,'switch:Invalid_Char:ALLOW'
          ,'sha_indicator:Invalid_Num:ALLOW'
          ,'test_line_num:Invalid_Num:ALLOW'
          ,'test_line_response:Invalid_TestRespCode:ENUM'
          ,'blk_1000_pool:Invalid_TBlockInd:ENUM'
          ,'rc_lata:Invalid_Num:ALLOW'
          ,'filename:Invalid_Filename:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Lerg6Raw_Fields.InvalidMessage_lata(1)
          ,Lerg6Raw_Fields.InvalidMessage_lata_name(1)
          ,Lerg6Raw_Fields.InvalidMessage_status(1)
          ,Lerg6Raw_Fields.InvalidMessage_npa(1)
          ,Lerg6Raw_Fields.InvalidMessage_nxx(1)
          ,Lerg6Raw_Fields.InvalidMessage_block_id(1)
          ,Lerg6Raw_Fields.InvalidMessage_coc_type(1)
          ,Lerg6Raw_Fields.InvalidMessage_ssc(1)
          ,Lerg6Raw_Fields.InvalidMessage_dind(1)
          ,Lerg6Raw_Fields.InvalidMessage_td_eo(1)
          ,Lerg6Raw_Fields.InvalidMessage_td_at(1)
          ,Lerg6Raw_Fields.InvalidMessage_portable(1)
          ,Lerg6Raw_Fields.InvalidMessage_aocn(1)
          ,Lerg6Raw_Fields.InvalidMessage_ocn(1)
          ,Lerg6Raw_Fields.InvalidMessage_loc_name(1)
          ,Lerg6Raw_Fields.InvalidMessage_loc(1)
          ,Lerg6Raw_Fields.InvalidMessage_loc_state(1)
          ,Lerg6Raw_Fields.InvalidMessage_rc_abbre(1)
          ,Lerg6Raw_Fields.InvalidMessage_rc_ty(1)
          ,Lerg6Raw_Fields.InvalidMessage_line_fr(1)
          ,Lerg6Raw_Fields.InvalidMessage_line_to(1)
          ,Lerg6Raw_Fields.InvalidMessage_switch(1)
          ,Lerg6Raw_Fields.InvalidMessage_sha_indicator(1)
          ,Lerg6Raw_Fields.InvalidMessage_test_line_num(1)
          ,Lerg6Raw_Fields.InvalidMessage_test_line_response(1)
          ,Lerg6Raw_Fields.InvalidMessage_blk_1000_pool(1)
          ,Lerg6Raw_Fields.InvalidMessage_rc_lata(1)
          ,Lerg6Raw_Fields.InvalidMessage_filename(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(Lerg6Raw_Layout_Phonesinfo) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.lata_Invalid := Lerg6Raw_Fields.InValid_lata((SALT311.StrType)le.lata);
    SELF.lata_name_Invalid := Lerg6Raw_Fields.InValid_lata_name((SALT311.StrType)le.lata_name);
    SELF.status_Invalid := Lerg6Raw_Fields.InValid_status((SALT311.StrType)le.status);
    SELF.npa_Invalid := Lerg6Raw_Fields.InValid_npa((SALT311.StrType)le.npa);
    SELF.nxx_Invalid := Lerg6Raw_Fields.InValid_nxx((SALT311.StrType)le.nxx);
    SELF.block_id_Invalid := Lerg6Raw_Fields.InValid_block_id((SALT311.StrType)le.block_id);
    SELF.coc_type_Invalid := Lerg6Raw_Fields.InValid_coc_type((SALT311.StrType)le.coc_type);
    SELF.ssc_Invalid := Lerg6Raw_Fields.InValid_ssc((SALT311.StrType)le.ssc);
    SELF.dind_Invalid := Lerg6Raw_Fields.InValid_dind((SALT311.StrType)le.dind);
    SELF.td_eo_Invalid := Lerg6Raw_Fields.InValid_td_eo((SALT311.StrType)le.td_eo);
    SELF.td_at_Invalid := Lerg6Raw_Fields.InValid_td_at((SALT311.StrType)le.td_at);
    SELF.portable_Invalid := Lerg6Raw_Fields.InValid_portable((SALT311.StrType)le.portable);
    SELF.aocn_Invalid := Lerg6Raw_Fields.InValid_aocn((SALT311.StrType)le.aocn);
    SELF.ocn_Invalid := Lerg6Raw_Fields.InValid_ocn((SALT311.StrType)le.ocn);
    SELF.loc_name_Invalid := Lerg6Raw_Fields.InValid_loc_name((SALT311.StrType)le.loc_name);
    SELF.loc_Invalid := Lerg6Raw_Fields.InValid_loc((SALT311.StrType)le.loc);
    SELF.loc_state_Invalid := Lerg6Raw_Fields.InValid_loc_state((SALT311.StrType)le.loc_state);
    SELF.rc_abbre_Invalid := Lerg6Raw_Fields.InValid_rc_abbre((SALT311.StrType)le.rc_abbre);
    SELF.rc_ty_Invalid := Lerg6Raw_Fields.InValid_rc_ty((SALT311.StrType)le.rc_ty);
    SELF.line_fr_Invalid := Lerg6Raw_Fields.InValid_line_fr((SALT311.StrType)le.line_fr);
    SELF.line_to_Invalid := Lerg6Raw_Fields.InValid_line_to((SALT311.StrType)le.line_to);
    SELF.switch_Invalid := Lerg6Raw_Fields.InValid_switch((SALT311.StrType)le.switch);
    SELF.sha_indicator_Invalid := Lerg6Raw_Fields.InValid_sha_indicator((SALT311.StrType)le.sha_indicator);
    SELF.test_line_num_Invalid := Lerg6Raw_Fields.InValid_test_line_num((SALT311.StrType)le.test_line_num);
    SELF.test_line_response_Invalid := Lerg6Raw_Fields.InValid_test_line_response((SALT311.StrType)le.test_line_response);
    SELF.blk_1000_pool_Invalid := Lerg6Raw_Fields.InValid_blk_1000_pool((SALT311.StrType)le.blk_1000_pool);
    SELF.rc_lata_Invalid := Lerg6Raw_Fields.InValid_rc_lata((SALT311.StrType)le.rc_lata);
    SELF.filename_Invalid := Lerg6Raw_Fields.InValid_filename((SALT311.StrType)le.filename);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Lerg6Raw_Layout_Phonesinfo);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.lata_Invalid << 0 ) + ( le.lata_name_Invalid << 1 ) + ( le.status_Invalid << 2 ) + ( le.npa_Invalid << 3 ) + ( le.nxx_Invalid << 4 ) + ( le.block_id_Invalid << 5 ) + ( le.coc_type_Invalid << 6 ) + ( le.ssc_Invalid << 7 ) + ( le.dind_Invalid << 8 ) + ( le.td_eo_Invalid << 9 ) + ( le.td_at_Invalid << 10 ) + ( le.portable_Invalid << 11 ) + ( le.aocn_Invalid << 12 ) + ( le.ocn_Invalid << 13 ) + ( le.loc_name_Invalid << 14 ) + ( le.loc_Invalid << 15 ) + ( le.loc_state_Invalid << 16 ) + ( le.rc_abbre_Invalid << 17 ) + ( le.rc_ty_Invalid << 18 ) + ( le.line_fr_Invalid << 19 ) + ( le.line_to_Invalid << 20 ) + ( le.switch_Invalid << 21 ) + ( le.sha_indicator_Invalid << 22 ) + ( le.test_line_num_Invalid << 23 ) + ( le.test_line_response_Invalid << 24 ) + ( le.blk_1000_pool_Invalid << 25 ) + ( le.rc_lata_Invalid << 26 ) + ( le.filename_Invalid << 27 );
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
  EXPORT Infile := PROJECT(h,Lerg6Raw_Layout_Phonesinfo);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.lata_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.lata_name_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.status_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.npa_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.nxx_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.block_id_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.coc_type_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.ssc_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.dind_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.td_eo_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.td_at_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.portable_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.aocn_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.ocn_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.loc_name_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.loc_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.loc_state_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.rc_abbre_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.rc_ty_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.line_fr_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.line_to_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.switch_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.sha_indicator_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.test_line_num_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.test_line_response_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.blk_1000_pool_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.rc_lata_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.filename_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    lata_ALLOW_ErrorCount := COUNT(GROUP,h.lata_Invalid=1);
    lata_name_ALLOW_ErrorCount := COUNT(GROUP,h.lata_name_Invalid=1);
    status_ENUM_ErrorCount := COUNT(GROUP,h.status_Invalid=1);
    npa_ALLOW_ErrorCount := COUNT(GROUP,h.npa_Invalid=1);
    nxx_ALLOW_ErrorCount := COUNT(GROUP,h.nxx_Invalid=1);
    block_id_ALLOW_ErrorCount := COUNT(GROUP,h.block_id_Invalid=1);
    coc_type_ENUM_ErrorCount := COUNT(GROUP,h.coc_type_Invalid=1);
    ssc_ALLOW_ErrorCount := COUNT(GROUP,h.ssc_Invalid=1);
    dind_ENUM_ErrorCount := COUNT(GROUP,h.dind_Invalid=1);
    td_eo_ALLOW_ErrorCount := COUNT(GROUP,h.td_eo_Invalid=1);
    td_at_ALLOW_ErrorCount := COUNT(GROUP,h.td_at_Invalid=1);
    portable_ENUM_ErrorCount := COUNT(GROUP,h.portable_Invalid=1);
    aocn_ALLOW_ErrorCount := COUNT(GROUP,h.aocn_Invalid=1);
    ocn_ALLOW_ErrorCount := COUNT(GROUP,h.ocn_Invalid=1);
    loc_name_ALLOW_ErrorCount := COUNT(GROUP,h.loc_name_Invalid=1);
    loc_ALLOW_ErrorCount := COUNT(GROUP,h.loc_Invalid=1);
    loc_state_ALLOW_ErrorCount := COUNT(GROUP,h.loc_state_Invalid=1);
    rc_abbre_ALLOW_ErrorCount := COUNT(GROUP,h.rc_abbre_Invalid=1);
    rc_ty_ENUM_ErrorCount := COUNT(GROUP,h.rc_ty_Invalid=1);
    line_fr_ALLOW_ErrorCount := COUNT(GROUP,h.line_fr_Invalid=1);
    line_to_ALLOW_ErrorCount := COUNT(GROUP,h.line_to_Invalid=1);
    switch_ALLOW_ErrorCount := COUNT(GROUP,h.switch_Invalid=1);
    sha_indicator_ALLOW_ErrorCount := COUNT(GROUP,h.sha_indicator_Invalid=1);
    test_line_num_ALLOW_ErrorCount := COUNT(GROUP,h.test_line_num_Invalid=1);
    test_line_response_ENUM_ErrorCount := COUNT(GROUP,h.test_line_response_Invalid=1);
    blk_1000_pool_ENUM_ErrorCount := COUNT(GROUP,h.blk_1000_pool_Invalid=1);
    rc_lata_ALLOW_ErrorCount := COUNT(GROUP,h.rc_lata_Invalid=1);
    filename_ALLOW_ErrorCount := COUNT(GROUP,h.filename_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.lata_Invalid > 0 OR h.lata_name_Invalid > 0 OR h.status_Invalid > 0 OR h.npa_Invalid > 0 OR h.nxx_Invalid > 0 OR h.block_id_Invalid > 0 OR h.coc_type_Invalid > 0 OR h.ssc_Invalid > 0 OR h.dind_Invalid > 0 OR h.td_eo_Invalid > 0 OR h.td_at_Invalid > 0 OR h.portable_Invalid > 0 OR h.aocn_Invalid > 0 OR h.ocn_Invalid > 0 OR h.loc_name_Invalid > 0 OR h.loc_Invalid > 0 OR h.loc_state_Invalid > 0 OR h.rc_abbre_Invalid > 0 OR h.rc_ty_Invalid > 0 OR h.line_fr_Invalid > 0 OR h.line_to_Invalid > 0 OR h.switch_Invalid > 0 OR h.sha_indicator_Invalid > 0 OR h.test_line_num_Invalid > 0 OR h.test_line_response_Invalid > 0 OR h.blk_1000_pool_Invalid > 0 OR h.rc_lata_Invalid > 0 OR h.filename_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.lata_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lata_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.status_ENUM_ErrorCount > 0, 1, 0) + IF(le.npa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.nxx_ALLOW_ErrorCount > 0, 1, 0) + IF(le.block_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.coc_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.ssc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dind_ENUM_ErrorCount > 0, 1, 0) + IF(le.td_eo_ALLOW_ErrorCount > 0, 1, 0) + IF(le.td_at_ALLOW_ErrorCount > 0, 1, 0) + IF(le.portable_ENUM_ErrorCount > 0, 1, 0) + IF(le.aocn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ocn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.loc_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.loc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.loc_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rc_abbre_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rc_ty_ENUM_ErrorCount > 0, 1, 0) + IF(le.line_fr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.line_to_ALLOW_ErrorCount > 0, 1, 0) + IF(le.switch_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sha_indicator_ALLOW_ErrorCount > 0, 1, 0) + IF(le.test_line_num_ALLOW_ErrorCount > 0, 1, 0) + IF(le.test_line_response_ENUM_ErrorCount > 0, 1, 0) + IF(le.blk_1000_pool_ENUM_ErrorCount > 0, 1, 0) + IF(le.rc_lata_ALLOW_ErrorCount > 0, 1, 0) + IF(le.filename_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.lata_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lata_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.status_ENUM_ErrorCount > 0, 1, 0) + IF(le.npa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.nxx_ALLOW_ErrorCount > 0, 1, 0) + IF(le.block_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.coc_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.ssc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dind_ENUM_ErrorCount > 0, 1, 0) + IF(le.td_eo_ALLOW_ErrorCount > 0, 1, 0) + IF(le.td_at_ALLOW_ErrorCount > 0, 1, 0) + IF(le.portable_ENUM_ErrorCount > 0, 1, 0) + IF(le.aocn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ocn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.loc_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.loc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.loc_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rc_abbre_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rc_ty_ENUM_ErrorCount > 0, 1, 0) + IF(le.line_fr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.line_to_ALLOW_ErrorCount > 0, 1, 0) + IF(le.switch_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sha_indicator_ALLOW_ErrorCount > 0, 1, 0) + IF(le.test_line_num_ALLOW_ErrorCount > 0, 1, 0) + IF(le.test_line_response_ENUM_ErrorCount > 0, 1, 0) + IF(le.blk_1000_pool_ENUM_ErrorCount > 0, 1, 0) + IF(le.rc_lata_ALLOW_ErrorCount > 0, 1, 0) + IF(le.filename_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.lata_Invalid,le.lata_name_Invalid,le.status_Invalid,le.npa_Invalid,le.nxx_Invalid,le.block_id_Invalid,le.coc_type_Invalid,le.ssc_Invalid,le.dind_Invalid,le.td_eo_Invalid,le.td_at_Invalid,le.portable_Invalid,le.aocn_Invalid,le.ocn_Invalid,le.loc_name_Invalid,le.loc_Invalid,le.loc_state_Invalid,le.rc_abbre_Invalid,le.rc_ty_Invalid,le.line_fr_Invalid,le.line_to_Invalid,le.switch_Invalid,le.sha_indicator_Invalid,le.test_line_num_Invalid,le.test_line_response_Invalid,le.blk_1000_pool_Invalid,le.rc_lata_Invalid,le.filename_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Lerg6Raw_Fields.InvalidMessage_lata(le.lata_Invalid),Lerg6Raw_Fields.InvalidMessage_lata_name(le.lata_name_Invalid),Lerg6Raw_Fields.InvalidMessage_status(le.status_Invalid),Lerg6Raw_Fields.InvalidMessage_npa(le.npa_Invalid),Lerg6Raw_Fields.InvalidMessage_nxx(le.nxx_Invalid),Lerg6Raw_Fields.InvalidMessage_block_id(le.block_id_Invalid),Lerg6Raw_Fields.InvalidMessage_coc_type(le.coc_type_Invalid),Lerg6Raw_Fields.InvalidMessage_ssc(le.ssc_Invalid),Lerg6Raw_Fields.InvalidMessage_dind(le.dind_Invalid),Lerg6Raw_Fields.InvalidMessage_td_eo(le.td_eo_Invalid),Lerg6Raw_Fields.InvalidMessage_td_at(le.td_at_Invalid),Lerg6Raw_Fields.InvalidMessage_portable(le.portable_Invalid),Lerg6Raw_Fields.InvalidMessage_aocn(le.aocn_Invalid),Lerg6Raw_Fields.InvalidMessage_ocn(le.ocn_Invalid),Lerg6Raw_Fields.InvalidMessage_loc_name(le.loc_name_Invalid),Lerg6Raw_Fields.InvalidMessage_loc(le.loc_Invalid),Lerg6Raw_Fields.InvalidMessage_loc_state(le.loc_state_Invalid),Lerg6Raw_Fields.InvalidMessage_rc_abbre(le.rc_abbre_Invalid),Lerg6Raw_Fields.InvalidMessage_rc_ty(le.rc_ty_Invalid),Lerg6Raw_Fields.InvalidMessage_line_fr(le.line_fr_Invalid),Lerg6Raw_Fields.InvalidMessage_line_to(le.line_to_Invalid),Lerg6Raw_Fields.InvalidMessage_switch(le.switch_Invalid),Lerg6Raw_Fields.InvalidMessage_sha_indicator(le.sha_indicator_Invalid),Lerg6Raw_Fields.InvalidMessage_test_line_num(le.test_line_num_Invalid),Lerg6Raw_Fields.InvalidMessage_test_line_response(le.test_line_response_Invalid),Lerg6Raw_Fields.InvalidMessage_blk_1000_pool(le.blk_1000_pool_Invalid),Lerg6Raw_Fields.InvalidMessage_rc_lata(le.rc_lata_Invalid),Lerg6Raw_Fields.InvalidMessage_filename(le.filename_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.lata_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lata_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.status_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.npa_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.nxx_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.block_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.coc_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.ssc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.td_eo_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.td_at_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.portable_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.aocn_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ocn_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.loc_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.loc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.loc_state_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rc_abbre_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rc_ty_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.line_fr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.line_to_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.switch_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sha_indicator_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.test_line_num_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.test_line_response_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.blk_1000_pool_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.rc_lata_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.filename_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'lata','lata_name','status','npa','nxx','block_id','coc_type','ssc','dind','td_eo','td_at','portable','aocn','ocn','loc_name','loc','loc_state','rc_abbre','rc_ty','line_fr','line_to','switch','sha_indicator','test_line_num','test_line_response','blk_1000_pool','rc_lata','filename','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Num','Invalid_Alpha','Invalid_StatusCode','Invalid_Num','Invalid_Nxx','Invalid_BlockID','Invalid_CocTypeCode','Invalid_SccTypeCode','Invalid_YesNo','Invalid_TdCode','Invalid_TdCode','Invalid_YesNo','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Alpha','Invalid_Char','Invalid_RcTyCode','Invalid_Num','Invalid_Num','Invalid_Char','Invalid_Num','Invalid_Num','Invalid_TestRespCode','Invalid_TBlockInd','Invalid_Num','Invalid_Filename','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.lata,(SALT311.StrType)le.lata_name,(SALT311.StrType)le.status,(SALT311.StrType)le.npa,(SALT311.StrType)le.nxx,(SALT311.StrType)le.block_id,(SALT311.StrType)le.coc_type,(SALT311.StrType)le.ssc,(SALT311.StrType)le.dind,(SALT311.StrType)le.td_eo,(SALT311.StrType)le.td_at,(SALT311.StrType)le.portable,(SALT311.StrType)le.aocn,(SALT311.StrType)le.ocn,(SALT311.StrType)le.loc_name,(SALT311.StrType)le.loc,(SALT311.StrType)le.loc_state,(SALT311.StrType)le.rc_abbre,(SALT311.StrType)le.rc_ty,(SALT311.StrType)le.line_fr,(SALT311.StrType)le.line_to,(SALT311.StrType)le.switch,(SALT311.StrType)le.sha_indicator,(SALT311.StrType)le.test_line_num,(SALT311.StrType)le.test_line_response,(SALT311.StrType)le.blk_1000_pool,(SALT311.StrType)le.rc_lata,(SALT311.StrType)le.filename,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,28,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Lerg6Raw_Layout_Phonesinfo) prevDS = DATASET([], Lerg6Raw_Layout_Phonesinfo), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.lata_ALLOW_ErrorCount
          ,le.lata_name_ALLOW_ErrorCount
          ,le.status_ENUM_ErrorCount
          ,le.npa_ALLOW_ErrorCount
          ,le.nxx_ALLOW_ErrorCount
          ,le.block_id_ALLOW_ErrorCount
          ,le.coc_type_ENUM_ErrorCount
          ,le.ssc_ALLOW_ErrorCount
          ,le.dind_ENUM_ErrorCount
          ,le.td_eo_ALLOW_ErrorCount
          ,le.td_at_ALLOW_ErrorCount
          ,le.portable_ENUM_ErrorCount
          ,le.aocn_ALLOW_ErrorCount
          ,le.ocn_ALLOW_ErrorCount
          ,le.loc_name_ALLOW_ErrorCount
          ,le.loc_ALLOW_ErrorCount
          ,le.loc_state_ALLOW_ErrorCount
          ,le.rc_abbre_ALLOW_ErrorCount
          ,le.rc_ty_ENUM_ErrorCount
          ,le.line_fr_ALLOW_ErrorCount
          ,le.line_to_ALLOW_ErrorCount
          ,le.switch_ALLOW_ErrorCount
          ,le.sha_indicator_ALLOW_ErrorCount
          ,le.test_line_num_ALLOW_ErrorCount
          ,le.test_line_response_ENUM_ErrorCount
          ,le.blk_1000_pool_ENUM_ErrorCount
          ,le.rc_lata_ALLOW_ErrorCount
          ,le.filename_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.lata_ALLOW_ErrorCount
          ,le.lata_name_ALLOW_ErrorCount
          ,le.status_ENUM_ErrorCount
          ,le.npa_ALLOW_ErrorCount
          ,le.nxx_ALLOW_ErrorCount
          ,le.block_id_ALLOW_ErrorCount
          ,le.coc_type_ENUM_ErrorCount
          ,le.ssc_ALLOW_ErrorCount
          ,le.dind_ENUM_ErrorCount
          ,le.td_eo_ALLOW_ErrorCount
          ,le.td_at_ALLOW_ErrorCount
          ,le.portable_ENUM_ErrorCount
          ,le.aocn_ALLOW_ErrorCount
          ,le.ocn_ALLOW_ErrorCount
          ,le.loc_name_ALLOW_ErrorCount
          ,le.loc_ALLOW_ErrorCount
          ,le.loc_state_ALLOW_ErrorCount
          ,le.rc_abbre_ALLOW_ErrorCount
          ,le.rc_ty_ENUM_ErrorCount
          ,le.line_fr_ALLOW_ErrorCount
          ,le.line_to_ALLOW_ErrorCount
          ,le.switch_ALLOW_ErrorCount
          ,le.sha_indicator_ALLOW_ErrorCount
          ,le.test_line_num_ALLOW_ErrorCount
          ,le.test_line_response_ENUM_ErrorCount
          ,le.blk_1000_pool_ENUM_ErrorCount
          ,le.rc_lata_ALLOW_ErrorCount
          ,le.filename_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := Lerg6Raw_hygiene(PROJECT(h, Lerg6Raw_Layout_Phonesinfo));
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
          ,'lata:' + getFieldTypeText(h.lata) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lata_name:' + getFieldTypeText(h.lata_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'status:' + getFieldTypeText(h.status) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'eff_date:' + getFieldTypeText(h.eff_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'npa:' + getFieldTypeText(h.npa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nxx:' + getFieldTypeText(h.nxx) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'block_id:' + getFieldTypeText(h.block_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filler1:' + getFieldTypeText(h.filler1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'coc_type:' + getFieldTypeText(h.coc_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ssc:' + getFieldTypeText(h.ssc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dind:' + getFieldTypeText(h.dind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'td_eo:' + getFieldTypeText(h.td_eo) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'td_at:' + getFieldTypeText(h.td_at) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'portable:' + getFieldTypeText(h.portable) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aocn:' + getFieldTypeText(h.aocn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filler2:' + getFieldTypeText(h.filler2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ocn:' + getFieldTypeText(h.ocn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'loc_name:' + getFieldTypeText(h.loc_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'loc:' + getFieldTypeText(h.loc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'loc_state:' + getFieldTypeText(h.loc_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rc_abbre:' + getFieldTypeText(h.rc_abbre) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rc_ty:' + getFieldTypeText(h.rc_ty) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'line_fr:' + getFieldTypeText(h.line_fr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'line_to:' + getFieldTypeText(h.line_to) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'switch:' + getFieldTypeText(h.switch) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sha_indicator:' + getFieldTypeText(h.sha_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filler3:' + getFieldTypeText(h.filler3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'test_line_num:' + getFieldTypeText(h.test_line_num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'test_line_response:' + getFieldTypeText(h.test_line_response) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'test_line_exp_date:' + getFieldTypeText(h.test_line_exp_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'blk_1000_pool:' + getFieldTypeText(h.blk_1000_pool) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rc_lata:' + getFieldTypeText(h.rc_lata) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filler4:' + getFieldTypeText(h.filler4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'creation_date:' + getFieldTypeText(h.creation_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filler5:' + getFieldTypeText(h.filler5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e_status_date:' + getFieldTypeText(h.e_status_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filler6:' + getFieldTypeText(h.filler6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'last_modified_date:' + getFieldTypeText(h.last_modified_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filler7:' + getFieldTypeText(h.filler7) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filename:' + getFieldTypeText(h.filename) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_lata_cnt
          ,le.populated_lata_name_cnt
          ,le.populated_status_cnt
          ,le.populated_eff_date_cnt
          ,le.populated_npa_cnt
          ,le.populated_nxx_cnt
          ,le.populated_block_id_cnt
          ,le.populated_filler1_cnt
          ,le.populated_coc_type_cnt
          ,le.populated_ssc_cnt
          ,le.populated_dind_cnt
          ,le.populated_td_eo_cnt
          ,le.populated_td_at_cnt
          ,le.populated_portable_cnt
          ,le.populated_aocn_cnt
          ,le.populated_filler2_cnt
          ,le.populated_ocn_cnt
          ,le.populated_loc_name_cnt
          ,le.populated_loc_cnt
          ,le.populated_loc_state_cnt
          ,le.populated_rc_abbre_cnt
          ,le.populated_rc_ty_cnt
          ,le.populated_line_fr_cnt
          ,le.populated_line_to_cnt
          ,le.populated_switch_cnt
          ,le.populated_sha_indicator_cnt
          ,le.populated_filler3_cnt
          ,le.populated_test_line_num_cnt
          ,le.populated_test_line_response_cnt
          ,le.populated_test_line_exp_date_cnt
          ,le.populated_blk_1000_pool_cnt
          ,le.populated_rc_lata_cnt
          ,le.populated_filler4_cnt
          ,le.populated_creation_date_cnt
          ,le.populated_filler5_cnt
          ,le.populated_e_status_date_cnt
          ,le.populated_filler6_cnt
          ,le.populated_last_modified_date_cnt
          ,le.populated_filler7_cnt
          ,le.populated_filename_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_lata_pcnt
          ,le.populated_lata_name_pcnt
          ,le.populated_status_pcnt
          ,le.populated_eff_date_pcnt
          ,le.populated_npa_pcnt
          ,le.populated_nxx_pcnt
          ,le.populated_block_id_pcnt
          ,le.populated_filler1_pcnt
          ,le.populated_coc_type_pcnt
          ,le.populated_ssc_pcnt
          ,le.populated_dind_pcnt
          ,le.populated_td_eo_pcnt
          ,le.populated_td_at_pcnt
          ,le.populated_portable_pcnt
          ,le.populated_aocn_pcnt
          ,le.populated_filler2_pcnt
          ,le.populated_ocn_pcnt
          ,le.populated_loc_name_pcnt
          ,le.populated_loc_pcnt
          ,le.populated_loc_state_pcnt
          ,le.populated_rc_abbre_pcnt
          ,le.populated_rc_ty_pcnt
          ,le.populated_line_fr_pcnt
          ,le.populated_line_to_pcnt
          ,le.populated_switch_pcnt
          ,le.populated_sha_indicator_pcnt
          ,le.populated_filler3_pcnt
          ,le.populated_test_line_num_pcnt
          ,le.populated_test_line_response_pcnt
          ,le.populated_test_line_exp_date_pcnt
          ,le.populated_blk_1000_pool_pcnt
          ,le.populated_rc_lata_pcnt
          ,le.populated_filler4_pcnt
          ,le.populated_creation_date_pcnt
          ,le.populated_filler5_pcnt
          ,le.populated_e_status_date_pcnt
          ,le.populated_filler6_pcnt
          ,le.populated_last_modified_date_pcnt
          ,le.populated_filler7_pcnt
          ,le.populated_filename_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,40,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Lerg6Raw_Delta(prevDS, PROJECT(h, Lerg6Raw_Layout_Phonesinfo));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),40,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Lerg6Raw_Layout_Phonesinfo) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Phonesinfo, Lerg6Raw_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
