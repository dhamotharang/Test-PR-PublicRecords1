IMPORT SALT311,STD;
EXPORT Lerg6Main_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 66;
  EXPORT NumRulesFromFieldType := 66;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 66;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Lerg6Main_Layout_Phonesinfo)
    UNSIGNED1 dt_first_reported_Invalid;
    UNSIGNED1 dt_last_reported_Invalid;
    UNSIGNED1 dt_start_Invalid;
    UNSIGNED1 dt_end_Invalid;
    UNSIGNED1 source_Invalid;
    UNSIGNED1 lata_Invalid;
    UNSIGNED1 lata_name_Invalid;
    UNSIGNED1 status_Invalid;
    UNSIGNED1 eff_date_Invalid;
    UNSIGNED1 eff_time_Invalid;
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
    UNSIGNED1 creation_date_Invalid;
    UNSIGNED1 creation_time_Invalid;
    UNSIGNED1 e_status_date_Invalid;
    UNSIGNED1 e_status_time_Invalid;
    UNSIGNED1 last_modified_date_Invalid;
    UNSIGNED1 last_modified_time_Invalid;
    UNSIGNED1 os1_Invalid;
    UNSIGNED1 os2_Invalid;
    UNSIGNED1 os3_Invalid;
    UNSIGNED1 os4_Invalid;
    UNSIGNED1 os5_Invalid;
    UNSIGNED1 os6_Invalid;
    UNSIGNED1 os7_Invalid;
    UNSIGNED1 os8_Invalid;
    UNSIGNED1 os9_Invalid;
    UNSIGNED1 os10_Invalid;
    UNSIGNED1 os11_Invalid;
    UNSIGNED1 os12_Invalid;
    UNSIGNED1 os13_Invalid;
    UNSIGNED1 os14_Invalid;
    UNSIGNED1 os15_Invalid;
    UNSIGNED1 os16_Invalid;
    UNSIGNED1 os17_Invalid;
    UNSIGNED1 os18_Invalid;
    UNSIGNED1 os19_Invalid;
    UNSIGNED1 os20_Invalid;
    UNSIGNED1 os21_Invalid;
    UNSIGNED1 os22_Invalid;
    UNSIGNED1 os23_Invalid;
    UNSIGNED1 os24_Invalid;
    UNSIGNED1 os25_Invalid;
    UNSIGNED1 record_sid_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Lerg6Main_Layout_Phonesinfo)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
  END;
  EXPORT Rule_Layout := RECORD(Lerg6Main_Layout_Phonesinfo)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'dt_first_reported:Invalid_Num:ALLOW'
          ,'dt_last_reported:Invalid_Num:ALLOW'
          ,'dt_start:Invalid_Num:ALLOW'
          ,'dt_end:Invalid_Num:ALLOW'
          ,'source:Invalid_Src:ALLOW'
          ,'lata:Invalid_Num:ALLOW'
          ,'lata_name:Invalid_Alpha:ALLOW'
          ,'status:Invalid_StatusCode:ENUM'
          ,'eff_date:Invalid_Num:ALLOW'
          ,'eff_time:Invalid_Num:ALLOW'
          ,'npa:Invalid_Num:ALLOW'
          ,'nxx:Invalid_Num:ALLOW'
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
          ,'creation_date:Invalid_Num:ALLOW'
          ,'creation_time:Invalid_Num:ALLOW'
          ,'e_status_date:Invalid_Num:ALLOW'
          ,'e_status_time:Invalid_Num:ALLOW'
          ,'last_modified_date:Invalid_Num:ALLOW'
          ,'last_modified_time:Invalid_Num:ALLOW'
          ,'os1:Invalid_Num:ALLOW'
          ,'os2:Invalid_Num:ALLOW'
          ,'os3:Invalid_Num:ALLOW'
          ,'os4:Invalid_Num:ALLOW'
          ,'os5:Invalid_Num:ALLOW'
          ,'os6:Invalid_Num:ALLOW'
          ,'os7:Invalid_Num:ALLOW'
          ,'os8:Invalid_Num:ALLOW'
          ,'os9:Invalid_Num:ALLOW'
          ,'os10:Invalid_Num:ALLOW'
          ,'os11:Invalid_Num:ALLOW'
          ,'os12:Invalid_Num:ALLOW'
          ,'os13:Invalid_Num:ALLOW'
          ,'os14:Invalid_Num:ALLOW'
          ,'os15:Invalid_Num:ALLOW'
          ,'os16:Invalid_Num:ALLOW'
          ,'os17:Invalid_Num:ALLOW'
          ,'os18:Invalid_Num:ALLOW'
          ,'os19:Invalid_Num:ALLOW'
          ,'os20:Invalid_Num:ALLOW'
          ,'os21:Invalid_Num:ALLOW'
          ,'os22:Invalid_Num:ALLOW'
          ,'os23:Invalid_Num:ALLOW'
          ,'os24:Invalid_Num:ALLOW'
          ,'os25:Invalid_Num:ALLOW'
          ,'record_sid:Invalid_Num:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Lerg6Main_Fields.InvalidMessage_dt_first_reported(1)
          ,Lerg6Main_Fields.InvalidMessage_dt_last_reported(1)
          ,Lerg6Main_Fields.InvalidMessage_dt_start(1)
          ,Lerg6Main_Fields.InvalidMessage_dt_end(1)
          ,Lerg6Main_Fields.InvalidMessage_source(1)
          ,Lerg6Main_Fields.InvalidMessage_lata(1)
          ,Lerg6Main_Fields.InvalidMessage_lata_name(1)
          ,Lerg6Main_Fields.InvalidMessage_status(1)
          ,Lerg6Main_Fields.InvalidMessage_eff_date(1)
          ,Lerg6Main_Fields.InvalidMessage_eff_time(1)
          ,Lerg6Main_Fields.InvalidMessage_npa(1)
          ,Lerg6Main_Fields.InvalidMessage_nxx(1)
          ,Lerg6Main_Fields.InvalidMessage_block_id(1)
          ,Lerg6Main_Fields.InvalidMessage_coc_type(1)
          ,Lerg6Main_Fields.InvalidMessage_ssc(1)
          ,Lerg6Main_Fields.InvalidMessage_dind(1)
          ,Lerg6Main_Fields.InvalidMessage_td_eo(1)
          ,Lerg6Main_Fields.InvalidMessage_td_at(1)
          ,Lerg6Main_Fields.InvalidMessage_portable(1)
          ,Lerg6Main_Fields.InvalidMessage_aocn(1)
          ,Lerg6Main_Fields.InvalidMessage_ocn(1)
          ,Lerg6Main_Fields.InvalidMessage_loc_name(1)
          ,Lerg6Main_Fields.InvalidMessage_loc(1)
          ,Lerg6Main_Fields.InvalidMessage_loc_state(1)
          ,Lerg6Main_Fields.InvalidMessage_rc_abbre(1)
          ,Lerg6Main_Fields.InvalidMessage_rc_ty(1)
          ,Lerg6Main_Fields.InvalidMessage_line_fr(1)
          ,Lerg6Main_Fields.InvalidMessage_line_to(1)
          ,Lerg6Main_Fields.InvalidMessage_switch(1)
          ,Lerg6Main_Fields.InvalidMessage_sha_indicator(1)
          ,Lerg6Main_Fields.InvalidMessage_test_line_num(1)
          ,Lerg6Main_Fields.InvalidMessage_test_line_response(1)
          ,Lerg6Main_Fields.InvalidMessage_blk_1000_pool(1)
          ,Lerg6Main_Fields.InvalidMessage_rc_lata(1)
          ,Lerg6Main_Fields.InvalidMessage_creation_date(1)
          ,Lerg6Main_Fields.InvalidMessage_creation_time(1)
          ,Lerg6Main_Fields.InvalidMessage_e_status_date(1)
          ,Lerg6Main_Fields.InvalidMessage_e_status_time(1)
          ,Lerg6Main_Fields.InvalidMessage_last_modified_date(1)
          ,Lerg6Main_Fields.InvalidMessage_last_modified_time(1)
          ,Lerg6Main_Fields.InvalidMessage_os1(1)
          ,Lerg6Main_Fields.InvalidMessage_os2(1)
          ,Lerg6Main_Fields.InvalidMessage_os3(1)
          ,Lerg6Main_Fields.InvalidMessage_os4(1)
          ,Lerg6Main_Fields.InvalidMessage_os5(1)
          ,Lerg6Main_Fields.InvalidMessage_os6(1)
          ,Lerg6Main_Fields.InvalidMessage_os7(1)
          ,Lerg6Main_Fields.InvalidMessage_os8(1)
          ,Lerg6Main_Fields.InvalidMessage_os9(1)
          ,Lerg6Main_Fields.InvalidMessage_os10(1)
          ,Lerg6Main_Fields.InvalidMessage_os11(1)
          ,Lerg6Main_Fields.InvalidMessage_os12(1)
          ,Lerg6Main_Fields.InvalidMessage_os13(1)
          ,Lerg6Main_Fields.InvalidMessage_os14(1)
          ,Lerg6Main_Fields.InvalidMessage_os15(1)
          ,Lerg6Main_Fields.InvalidMessage_os16(1)
          ,Lerg6Main_Fields.InvalidMessage_os17(1)
          ,Lerg6Main_Fields.InvalidMessage_os18(1)
          ,Lerg6Main_Fields.InvalidMessage_os19(1)
          ,Lerg6Main_Fields.InvalidMessage_os20(1)
          ,Lerg6Main_Fields.InvalidMessage_os21(1)
          ,Lerg6Main_Fields.InvalidMessage_os22(1)
          ,Lerg6Main_Fields.InvalidMessage_os23(1)
          ,Lerg6Main_Fields.InvalidMessage_os24(1)
          ,Lerg6Main_Fields.InvalidMessage_os25(1)
          ,Lerg6Main_Fields.InvalidMessage_record_sid(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(Lerg6Main_Layout_Phonesinfo) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.dt_first_reported_Invalid := Lerg6Main_Fields.InValid_dt_first_reported((SALT311.StrType)le.dt_first_reported);
    SELF.dt_last_reported_Invalid := Lerg6Main_Fields.InValid_dt_last_reported((SALT311.StrType)le.dt_last_reported);
    SELF.dt_start_Invalid := Lerg6Main_Fields.InValid_dt_start((SALT311.StrType)le.dt_start);
    SELF.dt_end_Invalid := Lerg6Main_Fields.InValid_dt_end((SALT311.StrType)le.dt_end);
    SELF.source_Invalid := Lerg6Main_Fields.InValid_source((SALT311.StrType)le.source);
    SELF.lata_Invalid := Lerg6Main_Fields.InValid_lata((SALT311.StrType)le.lata);
    SELF.lata_name_Invalid := Lerg6Main_Fields.InValid_lata_name((SALT311.StrType)le.lata_name);
    SELF.status_Invalid := Lerg6Main_Fields.InValid_status((SALT311.StrType)le.status);
    SELF.eff_date_Invalid := Lerg6Main_Fields.InValid_eff_date((SALT311.StrType)le.eff_date);
    SELF.eff_time_Invalid := Lerg6Main_Fields.InValid_eff_time((SALT311.StrType)le.eff_time);
    SELF.npa_Invalid := Lerg6Main_Fields.InValid_npa((SALT311.StrType)le.npa);
    SELF.nxx_Invalid := Lerg6Main_Fields.InValid_nxx((SALT311.StrType)le.nxx);
    SELF.block_id_Invalid := Lerg6Main_Fields.InValid_block_id((SALT311.StrType)le.block_id);
    SELF.coc_type_Invalid := Lerg6Main_Fields.InValid_coc_type((SALT311.StrType)le.coc_type);
    SELF.ssc_Invalid := Lerg6Main_Fields.InValid_ssc((SALT311.StrType)le.ssc);
    SELF.dind_Invalid := Lerg6Main_Fields.InValid_dind((SALT311.StrType)le.dind);
    SELF.td_eo_Invalid := Lerg6Main_Fields.InValid_td_eo((SALT311.StrType)le.td_eo);
    SELF.td_at_Invalid := Lerg6Main_Fields.InValid_td_at((SALT311.StrType)le.td_at);
    SELF.portable_Invalid := Lerg6Main_Fields.InValid_portable((SALT311.StrType)le.portable);
    SELF.aocn_Invalid := Lerg6Main_Fields.InValid_aocn((SALT311.StrType)le.aocn);
    SELF.ocn_Invalid := Lerg6Main_Fields.InValid_ocn((SALT311.StrType)le.ocn);
    SELF.loc_name_Invalid := Lerg6Main_Fields.InValid_loc_name((SALT311.StrType)le.loc_name);
    SELF.loc_Invalid := Lerg6Main_Fields.InValid_loc((SALT311.StrType)le.loc);
    SELF.loc_state_Invalid := Lerg6Main_Fields.InValid_loc_state((SALT311.StrType)le.loc_state);
    SELF.rc_abbre_Invalid := Lerg6Main_Fields.InValid_rc_abbre((SALT311.StrType)le.rc_abbre);
    SELF.rc_ty_Invalid := Lerg6Main_Fields.InValid_rc_ty((SALT311.StrType)le.rc_ty);
    SELF.line_fr_Invalid := Lerg6Main_Fields.InValid_line_fr((SALT311.StrType)le.line_fr);
    SELF.line_to_Invalid := Lerg6Main_Fields.InValid_line_to((SALT311.StrType)le.line_to);
    SELF.switch_Invalid := Lerg6Main_Fields.InValid_switch((SALT311.StrType)le.switch);
    SELF.sha_indicator_Invalid := Lerg6Main_Fields.InValid_sha_indicator((SALT311.StrType)le.sha_indicator);
    SELF.test_line_num_Invalid := Lerg6Main_Fields.InValid_test_line_num((SALT311.StrType)le.test_line_num);
    SELF.test_line_response_Invalid := Lerg6Main_Fields.InValid_test_line_response((SALT311.StrType)le.test_line_response);
    SELF.blk_1000_pool_Invalid := Lerg6Main_Fields.InValid_blk_1000_pool((SALT311.StrType)le.blk_1000_pool);
    SELF.rc_lata_Invalid := Lerg6Main_Fields.InValid_rc_lata((SALT311.StrType)le.rc_lata);
    SELF.creation_date_Invalid := Lerg6Main_Fields.InValid_creation_date((SALT311.StrType)le.creation_date);
    SELF.creation_time_Invalid := Lerg6Main_Fields.InValid_creation_time((SALT311.StrType)le.creation_time);
    SELF.e_status_date_Invalid := Lerg6Main_Fields.InValid_e_status_date((SALT311.StrType)le.e_status_date);
    SELF.e_status_time_Invalid := Lerg6Main_Fields.InValid_e_status_time((SALT311.StrType)le.e_status_time);
    SELF.last_modified_date_Invalid := Lerg6Main_Fields.InValid_last_modified_date((SALT311.StrType)le.last_modified_date);
    SELF.last_modified_time_Invalid := Lerg6Main_Fields.InValid_last_modified_time((SALT311.StrType)le.last_modified_time);
    SELF.os1_Invalid := Lerg6Main_Fields.InValid_os1((SALT311.StrType)le.os1);
    SELF.os2_Invalid := Lerg6Main_Fields.InValid_os2((SALT311.StrType)le.os2);
    SELF.os3_Invalid := Lerg6Main_Fields.InValid_os3((SALT311.StrType)le.os3);
    SELF.os4_Invalid := Lerg6Main_Fields.InValid_os4((SALT311.StrType)le.os4);
    SELF.os5_Invalid := Lerg6Main_Fields.InValid_os5((SALT311.StrType)le.os5);
    SELF.os6_Invalid := Lerg6Main_Fields.InValid_os6((SALT311.StrType)le.os6);
    SELF.os7_Invalid := Lerg6Main_Fields.InValid_os7((SALT311.StrType)le.os7);
    SELF.os8_Invalid := Lerg6Main_Fields.InValid_os8((SALT311.StrType)le.os8);
    SELF.os9_Invalid := Lerg6Main_Fields.InValid_os9((SALT311.StrType)le.os9);
    SELF.os10_Invalid := Lerg6Main_Fields.InValid_os10((SALT311.StrType)le.os10);
    SELF.os11_Invalid := Lerg6Main_Fields.InValid_os11((SALT311.StrType)le.os11);
    SELF.os12_Invalid := Lerg6Main_Fields.InValid_os12((SALT311.StrType)le.os12);
    SELF.os13_Invalid := Lerg6Main_Fields.InValid_os13((SALT311.StrType)le.os13);
    SELF.os14_Invalid := Lerg6Main_Fields.InValid_os14((SALT311.StrType)le.os14);
    SELF.os15_Invalid := Lerg6Main_Fields.InValid_os15((SALT311.StrType)le.os15);
    SELF.os16_Invalid := Lerg6Main_Fields.InValid_os16((SALT311.StrType)le.os16);
    SELF.os17_Invalid := Lerg6Main_Fields.InValid_os17((SALT311.StrType)le.os17);
    SELF.os18_Invalid := Lerg6Main_Fields.InValid_os18((SALT311.StrType)le.os18);
    SELF.os19_Invalid := Lerg6Main_Fields.InValid_os19((SALT311.StrType)le.os19);
    SELF.os20_Invalid := Lerg6Main_Fields.InValid_os20((SALT311.StrType)le.os20);
    SELF.os21_Invalid := Lerg6Main_Fields.InValid_os21((SALT311.StrType)le.os21);
    SELF.os22_Invalid := Lerg6Main_Fields.InValid_os22((SALT311.StrType)le.os22);
    SELF.os23_Invalid := Lerg6Main_Fields.InValid_os23((SALT311.StrType)le.os23);
    SELF.os24_Invalid := Lerg6Main_Fields.InValid_os24((SALT311.StrType)le.os24);
    SELF.os25_Invalid := Lerg6Main_Fields.InValid_os25((SALT311.StrType)le.os25);
    SELF.record_sid_Invalid := Lerg6Main_Fields.InValid_record_sid((SALT311.StrType)le.record_sid);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Lerg6Main_Layout_Phonesinfo);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.dt_first_reported_Invalid << 0 ) + ( le.dt_last_reported_Invalid << 1 ) + ( le.dt_start_Invalid << 2 ) + ( le.dt_end_Invalid << 3 ) + ( le.source_Invalid << 4 ) + ( le.lata_Invalid << 5 ) + ( le.lata_name_Invalid << 6 ) + ( le.status_Invalid << 7 ) + ( le.eff_date_Invalid << 8 ) + ( le.eff_time_Invalid << 9 ) + ( le.npa_Invalid << 10 ) + ( le.nxx_Invalid << 11 ) + ( le.block_id_Invalid << 12 ) + ( le.coc_type_Invalid << 13 ) + ( le.ssc_Invalid << 14 ) + ( le.dind_Invalid << 15 ) + ( le.td_eo_Invalid << 16 ) + ( le.td_at_Invalid << 17 ) + ( le.portable_Invalid << 18 ) + ( le.aocn_Invalid << 19 ) + ( le.ocn_Invalid << 20 ) + ( le.loc_name_Invalid << 21 ) + ( le.loc_Invalid << 22 ) + ( le.loc_state_Invalid << 23 ) + ( le.rc_abbre_Invalid << 24 ) + ( le.rc_ty_Invalid << 25 ) + ( le.line_fr_Invalid << 26 ) + ( le.line_to_Invalid << 27 ) + ( le.switch_Invalid << 28 ) + ( le.sha_indicator_Invalid << 29 ) + ( le.test_line_num_Invalid << 30 ) + ( le.test_line_response_Invalid << 31 ) + ( le.blk_1000_pool_Invalid << 32 ) + ( le.rc_lata_Invalid << 33 ) + ( le.creation_date_Invalid << 34 ) + ( le.creation_time_Invalid << 35 ) + ( le.e_status_date_Invalid << 36 ) + ( le.e_status_time_Invalid << 37 ) + ( le.last_modified_date_Invalid << 38 ) + ( le.last_modified_time_Invalid << 39 ) + ( le.os1_Invalid << 40 ) + ( le.os2_Invalid << 41 ) + ( le.os3_Invalid << 42 ) + ( le.os4_Invalid << 43 ) + ( le.os5_Invalid << 44 ) + ( le.os6_Invalid << 45 ) + ( le.os7_Invalid << 46 ) + ( le.os8_Invalid << 47 ) + ( le.os9_Invalid << 48 ) + ( le.os10_Invalid << 49 ) + ( le.os11_Invalid << 50 ) + ( le.os12_Invalid << 51 ) + ( le.os13_Invalid << 52 ) + ( le.os14_Invalid << 53 ) + ( le.os15_Invalid << 54 ) + ( le.os16_Invalid << 55 ) + ( le.os17_Invalid << 56 ) + ( le.os18_Invalid << 57 ) + ( le.os19_Invalid << 58 ) + ( le.os20_Invalid << 59 ) + ( le.os21_Invalid << 60 ) + ( le.os22_Invalid << 61 ) + ( le.os23_Invalid << 62 ) + ( le.os24_Invalid << 63 );
    SELF.ScrubsBits2 := ( le.os25_Invalid << 0 ) + ( le.record_sid_Invalid << 1 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
  STRING escQuotes(STRING s) := STD.Str.FindReplace(s,'\'','\\\'');
  Rule_Layout IntoRule(BitmapInfile le, UNSIGNED c) := TRANSFORM
    mask := 1<<(c-1);
    hasError := (mask&le.ScrubsBits1)>0 OR (mask&le.ScrubsBits2)>0;
    SELF.Rules := IF(hasError,TRIM(toRuleDesc(c))+':\''+escQuotes(TRIM(toErrorMessage(c)))+'\'',IF(le.ScrubsBits1=0 AND le.ScrubsBits2=0 AND c=1,'',SKIP));
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
  EXPORT Infile := PROJECT(h,Lerg6Main_Layout_Phonesinfo);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.dt_first_reported_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.dt_last_reported_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.dt_start_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.dt_end_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.source_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.lata_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.lata_name_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.status_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.eff_date_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.eff_time_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.npa_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.nxx_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.block_id_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.coc_type_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.ssc_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.dind_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.td_eo_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.td_at_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.portable_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.aocn_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.ocn_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.loc_name_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.loc_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.loc_state_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.rc_abbre_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.rc_ty_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.line_fr_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.line_to_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.switch_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.sha_indicator_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.test_line_num_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.test_line_response_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.blk_1000_pool_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.rc_lata_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.creation_date_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.creation_time_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.e_status_date_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.e_status_time_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.last_modified_date_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.last_modified_time_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.os1_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.os2_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.os3_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.os4_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.os5_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.os6_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.os7_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.os8_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.os9_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.os10_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.os11_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.os12_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.os13_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.os14_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.os15_Invalid := (le.ScrubsBits1 >> 54) & 1;
    SELF.os16_Invalid := (le.ScrubsBits1 >> 55) & 1;
    SELF.os17_Invalid := (le.ScrubsBits1 >> 56) & 1;
    SELF.os18_Invalid := (le.ScrubsBits1 >> 57) & 1;
    SELF.os19_Invalid := (le.ScrubsBits1 >> 58) & 1;
    SELF.os20_Invalid := (le.ScrubsBits1 >> 59) & 1;
    SELF.os21_Invalid := (le.ScrubsBits1 >> 60) & 1;
    SELF.os22_Invalid := (le.ScrubsBits1 >> 61) & 1;
    SELF.os23_Invalid := (le.ScrubsBits1 >> 62) & 1;
    SELF.os24_Invalid := (le.ScrubsBits1 >> 63) & 1;
    SELF.os25_Invalid := (le.ScrubsBits2 >> 0) & 1;
    SELF.record_sid_Invalid := (le.ScrubsBits2 >> 1) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    dt_first_reported_ALLOW_ErrorCount := COUNT(GROUP,h.dt_first_reported_Invalid=1);
    dt_last_reported_ALLOW_ErrorCount := COUNT(GROUP,h.dt_last_reported_Invalid=1);
    dt_start_ALLOW_ErrorCount := COUNT(GROUP,h.dt_start_Invalid=1);
    dt_end_ALLOW_ErrorCount := COUNT(GROUP,h.dt_end_Invalid=1);
    source_ALLOW_ErrorCount := COUNT(GROUP,h.source_Invalid=1);
    lata_ALLOW_ErrorCount := COUNT(GROUP,h.lata_Invalid=1);
    lata_name_ALLOW_ErrorCount := COUNT(GROUP,h.lata_name_Invalid=1);
    status_ENUM_ErrorCount := COUNT(GROUP,h.status_Invalid=1);
    eff_date_ALLOW_ErrorCount := COUNT(GROUP,h.eff_date_Invalid=1);
    eff_time_ALLOW_ErrorCount := COUNT(GROUP,h.eff_time_Invalid=1);
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
    creation_date_ALLOW_ErrorCount := COUNT(GROUP,h.creation_date_Invalid=1);
    creation_time_ALLOW_ErrorCount := COUNT(GROUP,h.creation_time_Invalid=1);
    e_status_date_ALLOW_ErrorCount := COUNT(GROUP,h.e_status_date_Invalid=1);
    e_status_time_ALLOW_ErrorCount := COUNT(GROUP,h.e_status_time_Invalid=1);
    last_modified_date_ALLOW_ErrorCount := COUNT(GROUP,h.last_modified_date_Invalid=1);
    last_modified_time_ALLOW_ErrorCount := COUNT(GROUP,h.last_modified_time_Invalid=1);
    os1_ALLOW_ErrorCount := COUNT(GROUP,h.os1_Invalid=1);
    os2_ALLOW_ErrorCount := COUNT(GROUP,h.os2_Invalid=1);
    os3_ALLOW_ErrorCount := COUNT(GROUP,h.os3_Invalid=1);
    os4_ALLOW_ErrorCount := COUNT(GROUP,h.os4_Invalid=1);
    os5_ALLOW_ErrorCount := COUNT(GROUP,h.os5_Invalid=1);
    os6_ALLOW_ErrorCount := COUNT(GROUP,h.os6_Invalid=1);
    os7_ALLOW_ErrorCount := COUNT(GROUP,h.os7_Invalid=1);
    os8_ALLOW_ErrorCount := COUNT(GROUP,h.os8_Invalid=1);
    os9_ALLOW_ErrorCount := COUNT(GROUP,h.os9_Invalid=1);
    os10_ALLOW_ErrorCount := COUNT(GROUP,h.os10_Invalid=1);
    os11_ALLOW_ErrorCount := COUNT(GROUP,h.os11_Invalid=1);
    os12_ALLOW_ErrorCount := COUNT(GROUP,h.os12_Invalid=1);
    os13_ALLOW_ErrorCount := COUNT(GROUP,h.os13_Invalid=1);
    os14_ALLOW_ErrorCount := COUNT(GROUP,h.os14_Invalid=1);
    os15_ALLOW_ErrorCount := COUNT(GROUP,h.os15_Invalid=1);
    os16_ALLOW_ErrorCount := COUNT(GROUP,h.os16_Invalid=1);
    os17_ALLOW_ErrorCount := COUNT(GROUP,h.os17_Invalid=1);
    os18_ALLOW_ErrorCount := COUNT(GROUP,h.os18_Invalid=1);
    os19_ALLOW_ErrorCount := COUNT(GROUP,h.os19_Invalid=1);
    os20_ALLOW_ErrorCount := COUNT(GROUP,h.os20_Invalid=1);
    os21_ALLOW_ErrorCount := COUNT(GROUP,h.os21_Invalid=1);
    os22_ALLOW_ErrorCount := COUNT(GROUP,h.os22_Invalid=1);
    os23_ALLOW_ErrorCount := COUNT(GROUP,h.os23_Invalid=1);
    os24_ALLOW_ErrorCount := COUNT(GROUP,h.os24_Invalid=1);
    os25_ALLOW_ErrorCount := COUNT(GROUP,h.os25_Invalid=1);
    record_sid_ALLOW_ErrorCount := COUNT(GROUP,h.record_sid_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.dt_first_reported_Invalid > 0 OR h.dt_last_reported_Invalid > 0 OR h.dt_start_Invalid > 0 OR h.dt_end_Invalid > 0 OR h.source_Invalid > 0 OR h.lata_Invalid > 0 OR h.lata_name_Invalid > 0 OR h.status_Invalid > 0 OR h.eff_date_Invalid > 0 OR h.eff_time_Invalid > 0 OR h.npa_Invalid > 0 OR h.nxx_Invalid > 0 OR h.block_id_Invalid > 0 OR h.coc_type_Invalid > 0 OR h.ssc_Invalid > 0 OR h.dind_Invalid > 0 OR h.td_eo_Invalid > 0 OR h.td_at_Invalid > 0 OR h.portable_Invalid > 0 OR h.aocn_Invalid > 0 OR h.ocn_Invalid > 0 OR h.loc_name_Invalid > 0 OR h.loc_Invalid > 0 OR h.loc_state_Invalid > 0 OR h.rc_abbre_Invalid > 0 OR h.rc_ty_Invalid > 0 OR h.line_fr_Invalid > 0 OR h.line_to_Invalid > 0 OR h.switch_Invalid > 0 OR h.sha_indicator_Invalid > 0 OR h.test_line_num_Invalid > 0 OR h.test_line_response_Invalid > 0 OR h.blk_1000_pool_Invalid > 0 OR h.rc_lata_Invalid > 0 OR h.creation_date_Invalid > 0 OR h.creation_time_Invalid > 0 OR h.e_status_date_Invalid > 0 OR h.e_status_time_Invalid > 0 OR h.last_modified_date_Invalid > 0 OR h.last_modified_time_Invalid > 0 OR h.os1_Invalid > 0 OR h.os2_Invalid > 0 OR h.os3_Invalid > 0 OR h.os4_Invalid > 0 OR h.os5_Invalid > 0 OR h.os6_Invalid > 0 OR h.os7_Invalid > 0 OR h.os8_Invalid > 0 OR h.os9_Invalid > 0 OR h.os10_Invalid > 0 OR h.os11_Invalid > 0 OR h.os12_Invalid > 0 OR h.os13_Invalid > 0 OR h.os14_Invalid > 0 OR h.os15_Invalid > 0 OR h.os16_Invalid > 0 OR h.os17_Invalid > 0 OR h.os18_Invalid > 0 OR h.os19_Invalid > 0 OR h.os20_Invalid > 0 OR h.os21_Invalid > 0 OR h.os22_Invalid > 0 OR h.os23_Invalid > 0 OR h.os24_Invalid > 0 OR h.os25_Invalid > 0 OR h.record_sid_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.dt_first_reported_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dt_last_reported_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dt_start_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dt_end_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lata_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lata_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.status_ENUM_ErrorCount > 0, 1, 0) + IF(le.eff_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.eff_time_ALLOW_ErrorCount > 0, 1, 0) + IF(le.npa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.nxx_ALLOW_ErrorCount > 0, 1, 0) + IF(le.block_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.coc_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.ssc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dind_ENUM_ErrorCount > 0, 1, 0) + IF(le.td_eo_ALLOW_ErrorCount > 0, 1, 0) + IF(le.td_at_ALLOW_ErrorCount > 0, 1, 0) + IF(le.portable_ENUM_ErrorCount > 0, 1, 0) + IF(le.aocn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ocn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.loc_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.loc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.loc_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rc_abbre_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rc_ty_ENUM_ErrorCount > 0, 1, 0) + IF(le.line_fr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.line_to_ALLOW_ErrorCount > 0, 1, 0) + IF(le.switch_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sha_indicator_ALLOW_ErrorCount > 0, 1, 0) + IF(le.test_line_num_ALLOW_ErrorCount > 0, 1, 0) + IF(le.test_line_response_ENUM_ErrorCount > 0, 1, 0) + IF(le.blk_1000_pool_ENUM_ErrorCount > 0, 1, 0) + IF(le.rc_lata_ALLOW_ErrorCount > 0, 1, 0) + IF(le.creation_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.creation_time_ALLOW_ErrorCount > 0, 1, 0) + IF(le.e_status_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.e_status_time_ALLOW_ErrorCount > 0, 1, 0) + IF(le.last_modified_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.last_modified_time_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os7_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os8_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os9_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os10_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os11_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os13_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os14_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os15_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os16_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os17_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os18_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os19_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os20_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os21_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os22_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os23_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os25_ALLOW_ErrorCount > 0, 1, 0) + IF(le.record_sid_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.dt_first_reported_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dt_last_reported_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dt_start_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dt_end_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lata_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lata_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.status_ENUM_ErrorCount > 0, 1, 0) + IF(le.eff_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.eff_time_ALLOW_ErrorCount > 0, 1, 0) + IF(le.npa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.nxx_ALLOW_ErrorCount > 0, 1, 0) + IF(le.block_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.coc_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.ssc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dind_ENUM_ErrorCount > 0, 1, 0) + IF(le.td_eo_ALLOW_ErrorCount > 0, 1, 0) + IF(le.td_at_ALLOW_ErrorCount > 0, 1, 0) + IF(le.portable_ENUM_ErrorCount > 0, 1, 0) + IF(le.aocn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ocn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.loc_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.loc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.loc_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rc_abbre_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rc_ty_ENUM_ErrorCount > 0, 1, 0) + IF(le.line_fr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.line_to_ALLOW_ErrorCount > 0, 1, 0) + IF(le.switch_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sha_indicator_ALLOW_ErrorCount > 0, 1, 0) + IF(le.test_line_num_ALLOW_ErrorCount > 0, 1, 0) + IF(le.test_line_response_ENUM_ErrorCount > 0, 1, 0) + IF(le.blk_1000_pool_ENUM_ErrorCount > 0, 1, 0) + IF(le.rc_lata_ALLOW_ErrorCount > 0, 1, 0) + IF(le.creation_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.creation_time_ALLOW_ErrorCount > 0, 1, 0) + IF(le.e_status_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.e_status_time_ALLOW_ErrorCount > 0, 1, 0) + IF(le.last_modified_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.last_modified_time_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os7_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os8_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os9_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os10_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os11_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os13_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os14_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os15_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os16_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os17_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os18_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os19_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os20_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os21_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os22_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os23_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os25_ALLOW_ErrorCount > 0, 1, 0) + IF(le.record_sid_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.dt_first_reported_Invalid,le.dt_last_reported_Invalid,le.dt_start_Invalid,le.dt_end_Invalid,le.source_Invalid,le.lata_Invalid,le.lata_name_Invalid,le.status_Invalid,le.eff_date_Invalid,le.eff_time_Invalid,le.npa_Invalid,le.nxx_Invalid,le.block_id_Invalid,le.coc_type_Invalid,le.ssc_Invalid,le.dind_Invalid,le.td_eo_Invalid,le.td_at_Invalid,le.portable_Invalid,le.aocn_Invalid,le.ocn_Invalid,le.loc_name_Invalid,le.loc_Invalid,le.loc_state_Invalid,le.rc_abbre_Invalid,le.rc_ty_Invalid,le.line_fr_Invalid,le.line_to_Invalid,le.switch_Invalid,le.sha_indicator_Invalid,le.test_line_num_Invalid,le.test_line_response_Invalid,le.blk_1000_pool_Invalid,le.rc_lata_Invalid,le.creation_date_Invalid,le.creation_time_Invalid,le.e_status_date_Invalid,le.e_status_time_Invalid,le.last_modified_date_Invalid,le.last_modified_time_Invalid,le.os1_Invalid,le.os2_Invalid,le.os3_Invalid,le.os4_Invalid,le.os5_Invalid,le.os6_Invalid,le.os7_Invalid,le.os8_Invalid,le.os9_Invalid,le.os10_Invalid,le.os11_Invalid,le.os12_Invalid,le.os13_Invalid,le.os14_Invalid,le.os15_Invalid,le.os16_Invalid,le.os17_Invalid,le.os18_Invalid,le.os19_Invalid,le.os20_Invalid,le.os21_Invalid,le.os22_Invalid,le.os23_Invalid,le.os24_Invalid,le.os25_Invalid,le.record_sid_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Lerg6Main_Fields.InvalidMessage_dt_first_reported(le.dt_first_reported_Invalid),Lerg6Main_Fields.InvalidMessage_dt_last_reported(le.dt_last_reported_Invalid),Lerg6Main_Fields.InvalidMessage_dt_start(le.dt_start_Invalid),Lerg6Main_Fields.InvalidMessage_dt_end(le.dt_end_Invalid),Lerg6Main_Fields.InvalidMessage_source(le.source_Invalid),Lerg6Main_Fields.InvalidMessage_lata(le.lata_Invalid),Lerg6Main_Fields.InvalidMessage_lata_name(le.lata_name_Invalid),Lerg6Main_Fields.InvalidMessage_status(le.status_Invalid),Lerg6Main_Fields.InvalidMessage_eff_date(le.eff_date_Invalid),Lerg6Main_Fields.InvalidMessage_eff_time(le.eff_time_Invalid),Lerg6Main_Fields.InvalidMessage_npa(le.npa_Invalid),Lerg6Main_Fields.InvalidMessage_nxx(le.nxx_Invalid),Lerg6Main_Fields.InvalidMessage_block_id(le.block_id_Invalid),Lerg6Main_Fields.InvalidMessage_coc_type(le.coc_type_Invalid),Lerg6Main_Fields.InvalidMessage_ssc(le.ssc_Invalid),Lerg6Main_Fields.InvalidMessage_dind(le.dind_Invalid),Lerg6Main_Fields.InvalidMessage_td_eo(le.td_eo_Invalid),Lerg6Main_Fields.InvalidMessage_td_at(le.td_at_Invalid),Lerg6Main_Fields.InvalidMessage_portable(le.portable_Invalid),Lerg6Main_Fields.InvalidMessage_aocn(le.aocn_Invalid),Lerg6Main_Fields.InvalidMessage_ocn(le.ocn_Invalid),Lerg6Main_Fields.InvalidMessage_loc_name(le.loc_name_Invalid),Lerg6Main_Fields.InvalidMessage_loc(le.loc_Invalid),Lerg6Main_Fields.InvalidMessage_loc_state(le.loc_state_Invalid),Lerg6Main_Fields.InvalidMessage_rc_abbre(le.rc_abbre_Invalid),Lerg6Main_Fields.InvalidMessage_rc_ty(le.rc_ty_Invalid),Lerg6Main_Fields.InvalidMessage_line_fr(le.line_fr_Invalid),Lerg6Main_Fields.InvalidMessage_line_to(le.line_to_Invalid),Lerg6Main_Fields.InvalidMessage_switch(le.switch_Invalid),Lerg6Main_Fields.InvalidMessage_sha_indicator(le.sha_indicator_Invalid),Lerg6Main_Fields.InvalidMessage_test_line_num(le.test_line_num_Invalid),Lerg6Main_Fields.InvalidMessage_test_line_response(le.test_line_response_Invalid),Lerg6Main_Fields.InvalidMessage_blk_1000_pool(le.blk_1000_pool_Invalid),Lerg6Main_Fields.InvalidMessage_rc_lata(le.rc_lata_Invalid),Lerg6Main_Fields.InvalidMessage_creation_date(le.creation_date_Invalid),Lerg6Main_Fields.InvalidMessage_creation_time(le.creation_time_Invalid),Lerg6Main_Fields.InvalidMessage_e_status_date(le.e_status_date_Invalid),Lerg6Main_Fields.InvalidMessage_e_status_time(le.e_status_time_Invalid),Lerg6Main_Fields.InvalidMessage_last_modified_date(le.last_modified_date_Invalid),Lerg6Main_Fields.InvalidMessage_last_modified_time(le.last_modified_time_Invalid),Lerg6Main_Fields.InvalidMessage_os1(le.os1_Invalid),Lerg6Main_Fields.InvalidMessage_os2(le.os2_Invalid),Lerg6Main_Fields.InvalidMessage_os3(le.os3_Invalid),Lerg6Main_Fields.InvalidMessage_os4(le.os4_Invalid),Lerg6Main_Fields.InvalidMessage_os5(le.os5_Invalid),Lerg6Main_Fields.InvalidMessage_os6(le.os6_Invalid),Lerg6Main_Fields.InvalidMessage_os7(le.os7_Invalid),Lerg6Main_Fields.InvalidMessage_os8(le.os8_Invalid),Lerg6Main_Fields.InvalidMessage_os9(le.os9_Invalid),Lerg6Main_Fields.InvalidMessage_os10(le.os10_Invalid),Lerg6Main_Fields.InvalidMessage_os11(le.os11_Invalid),Lerg6Main_Fields.InvalidMessage_os12(le.os12_Invalid),Lerg6Main_Fields.InvalidMessage_os13(le.os13_Invalid),Lerg6Main_Fields.InvalidMessage_os14(le.os14_Invalid),Lerg6Main_Fields.InvalidMessage_os15(le.os15_Invalid),Lerg6Main_Fields.InvalidMessage_os16(le.os16_Invalid),Lerg6Main_Fields.InvalidMessage_os17(le.os17_Invalid),Lerg6Main_Fields.InvalidMessage_os18(le.os18_Invalid),Lerg6Main_Fields.InvalidMessage_os19(le.os19_Invalid),Lerg6Main_Fields.InvalidMessage_os20(le.os20_Invalid),Lerg6Main_Fields.InvalidMessage_os21(le.os21_Invalid),Lerg6Main_Fields.InvalidMessage_os22(le.os22_Invalid),Lerg6Main_Fields.InvalidMessage_os23(le.os23_Invalid),Lerg6Main_Fields.InvalidMessage_os24(le.os24_Invalid),Lerg6Main_Fields.InvalidMessage_os25(le.os25_Invalid),Lerg6Main_Fields.InvalidMessage_record_sid(le.record_sid_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.dt_first_reported_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dt_last_reported_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dt_start_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dt_end_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.source_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lata_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lata_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.status_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.eff_date_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.eff_time_Invalid,'ALLOW','UNKNOWN')
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
          ,CHOOSE(le.creation_date_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.creation_time_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.e_status_date_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.e_status_time_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.last_modified_date_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.last_modified_time_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.os1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.os2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.os3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.os4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.os5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.os6_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.os7_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.os8_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.os9_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.os10_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.os11_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.os12_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.os13_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.os14_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.os15_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.os16_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.os17_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.os18_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.os19_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.os20_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.os21_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.os22_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.os23_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.os24_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.os25_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.record_sid_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'dt_first_reported','dt_last_reported','dt_start','dt_end','source','lata','lata_name','status','eff_date','eff_time','npa','nxx','block_id','coc_type','ssc','dind','td_eo','td_at','portable','aocn','ocn','loc_name','loc','loc_state','rc_abbre','rc_ty','line_fr','line_to','switch','sha_indicator','test_line_num','test_line_response','blk_1000_pool','rc_lata','creation_date','creation_time','e_status_date','e_status_time','last_modified_date','last_modified_time','os1','os2','os3','os4','os5','os6','os7','os8','os9','os10','os11','os12','os13','os14','os15','os16','os17','os18','os19','os20','os21','os22','os23','os24','os25','record_sid','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Src','Invalid_Num','Invalid_Alpha','Invalid_StatusCode','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_BlockID','Invalid_CocTypeCode','Invalid_SccTypeCode','Invalid_YesNo','Invalid_TdCode','Invalid_TdCode','Invalid_YesNo','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Alpha','Invalid_Char','Invalid_RcTyCode','Invalid_Num','Invalid_Num','Invalid_Char','Invalid_Num','Invalid_Num','Invalid_TestRespCode','Invalid_TBlockInd','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.dt_first_reported,(SALT311.StrType)le.dt_last_reported,(SALT311.StrType)le.dt_start,(SALT311.StrType)le.dt_end,(SALT311.StrType)le.source,(SALT311.StrType)le.lata,(SALT311.StrType)le.lata_name,(SALT311.StrType)le.status,(SALT311.StrType)le.eff_date,(SALT311.StrType)le.eff_time,(SALT311.StrType)le.npa,(SALT311.StrType)le.nxx,(SALT311.StrType)le.block_id,(SALT311.StrType)le.coc_type,(SALT311.StrType)le.ssc,(SALT311.StrType)le.dind,(SALT311.StrType)le.td_eo,(SALT311.StrType)le.td_at,(SALT311.StrType)le.portable,(SALT311.StrType)le.aocn,(SALT311.StrType)le.ocn,(SALT311.StrType)le.loc_name,(SALT311.StrType)le.loc,(SALT311.StrType)le.loc_state,(SALT311.StrType)le.rc_abbre,(SALT311.StrType)le.rc_ty,(SALT311.StrType)le.line_fr,(SALT311.StrType)le.line_to,(SALT311.StrType)le.switch,(SALT311.StrType)le.sha_indicator,(SALT311.StrType)le.test_line_num,(SALT311.StrType)le.test_line_response,(SALT311.StrType)le.blk_1000_pool,(SALT311.StrType)le.rc_lata,(SALT311.StrType)le.creation_date,(SALT311.StrType)le.creation_time,(SALT311.StrType)le.e_status_date,(SALT311.StrType)le.e_status_time,(SALT311.StrType)le.last_modified_date,(SALT311.StrType)le.last_modified_time,(SALT311.StrType)le.os1,(SALT311.StrType)le.os2,(SALT311.StrType)le.os3,(SALT311.StrType)le.os4,(SALT311.StrType)le.os5,(SALT311.StrType)le.os6,(SALT311.StrType)le.os7,(SALT311.StrType)le.os8,(SALT311.StrType)le.os9,(SALT311.StrType)le.os10,(SALT311.StrType)le.os11,(SALT311.StrType)le.os12,(SALT311.StrType)le.os13,(SALT311.StrType)le.os14,(SALT311.StrType)le.os15,(SALT311.StrType)le.os16,(SALT311.StrType)le.os17,(SALT311.StrType)le.os18,(SALT311.StrType)le.os19,(SALT311.StrType)le.os20,(SALT311.StrType)le.os21,(SALT311.StrType)le.os22,(SALT311.StrType)le.os23,(SALT311.StrType)le.os24,(SALT311.StrType)le.os25,(SALT311.StrType)le.record_sid,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,66,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Lerg6Main_Layout_Phonesinfo) prevDS = DATASET([], Lerg6Main_Layout_Phonesinfo), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.dt_first_reported_ALLOW_ErrorCount
          ,le.dt_last_reported_ALLOW_ErrorCount
          ,le.dt_start_ALLOW_ErrorCount
          ,le.dt_end_ALLOW_ErrorCount
          ,le.source_ALLOW_ErrorCount
          ,le.lata_ALLOW_ErrorCount
          ,le.lata_name_ALLOW_ErrorCount
          ,le.status_ENUM_ErrorCount
          ,le.eff_date_ALLOW_ErrorCount
          ,le.eff_time_ALLOW_ErrorCount
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
          ,le.creation_date_ALLOW_ErrorCount
          ,le.creation_time_ALLOW_ErrorCount
          ,le.e_status_date_ALLOW_ErrorCount
          ,le.e_status_time_ALLOW_ErrorCount
          ,le.last_modified_date_ALLOW_ErrorCount
          ,le.last_modified_time_ALLOW_ErrorCount
          ,le.os1_ALLOW_ErrorCount
          ,le.os2_ALLOW_ErrorCount
          ,le.os3_ALLOW_ErrorCount
          ,le.os4_ALLOW_ErrorCount
          ,le.os5_ALLOW_ErrorCount
          ,le.os6_ALLOW_ErrorCount
          ,le.os7_ALLOW_ErrorCount
          ,le.os8_ALLOW_ErrorCount
          ,le.os9_ALLOW_ErrorCount
          ,le.os10_ALLOW_ErrorCount
          ,le.os11_ALLOW_ErrorCount
          ,le.os12_ALLOW_ErrorCount
          ,le.os13_ALLOW_ErrorCount
          ,le.os14_ALLOW_ErrorCount
          ,le.os15_ALLOW_ErrorCount
          ,le.os16_ALLOW_ErrorCount
          ,le.os17_ALLOW_ErrorCount
          ,le.os18_ALLOW_ErrorCount
          ,le.os19_ALLOW_ErrorCount
          ,le.os20_ALLOW_ErrorCount
          ,le.os21_ALLOW_ErrorCount
          ,le.os22_ALLOW_ErrorCount
          ,le.os23_ALLOW_ErrorCount
          ,le.os24_ALLOW_ErrorCount
          ,le.os25_ALLOW_ErrorCount
          ,le.record_sid_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.dt_first_reported_ALLOW_ErrorCount
          ,le.dt_last_reported_ALLOW_ErrorCount
          ,le.dt_start_ALLOW_ErrorCount
          ,le.dt_end_ALLOW_ErrorCount
          ,le.source_ALLOW_ErrorCount
          ,le.lata_ALLOW_ErrorCount
          ,le.lata_name_ALLOW_ErrorCount
          ,le.status_ENUM_ErrorCount
          ,le.eff_date_ALLOW_ErrorCount
          ,le.eff_time_ALLOW_ErrorCount
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
          ,le.creation_date_ALLOW_ErrorCount
          ,le.creation_time_ALLOW_ErrorCount
          ,le.e_status_date_ALLOW_ErrorCount
          ,le.e_status_time_ALLOW_ErrorCount
          ,le.last_modified_date_ALLOW_ErrorCount
          ,le.last_modified_time_ALLOW_ErrorCount
          ,le.os1_ALLOW_ErrorCount
          ,le.os2_ALLOW_ErrorCount
          ,le.os3_ALLOW_ErrorCount
          ,le.os4_ALLOW_ErrorCount
          ,le.os5_ALLOW_ErrorCount
          ,le.os6_ALLOW_ErrorCount
          ,le.os7_ALLOW_ErrorCount
          ,le.os8_ALLOW_ErrorCount
          ,le.os9_ALLOW_ErrorCount
          ,le.os10_ALLOW_ErrorCount
          ,le.os11_ALLOW_ErrorCount
          ,le.os12_ALLOW_ErrorCount
          ,le.os13_ALLOW_ErrorCount
          ,le.os14_ALLOW_ErrorCount
          ,le.os15_ALLOW_ErrorCount
          ,le.os16_ALLOW_ErrorCount
          ,le.os17_ALLOW_ErrorCount
          ,le.os18_ALLOW_ErrorCount
          ,le.os19_ALLOW_ErrorCount
          ,le.os20_ALLOW_ErrorCount
          ,le.os21_ALLOW_ErrorCount
          ,le.os22_ALLOW_ErrorCount
          ,le.os23_ALLOW_ErrorCount
          ,le.os24_ALLOW_ErrorCount
          ,le.os25_ALLOW_ErrorCount
          ,le.record_sid_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := Lerg6Main_hygiene(PROJECT(h, Lerg6Main_Layout_Phonesinfo));
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
          ,'dt_first_reported:' + getFieldTypeText(h.dt_first_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_last_reported:' + getFieldTypeText(h.dt_last_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_start:' + getFieldTypeText(h.dt_start) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_end:' + getFieldTypeText(h.dt_end) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source:' + getFieldTypeText(h.source) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lata:' + getFieldTypeText(h.lata) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lata_name:' + getFieldTypeText(h.lata_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'status:' + getFieldTypeText(h.status) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'eff_date:' + getFieldTypeText(h.eff_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'eff_time:' + getFieldTypeText(h.eff_time) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
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
          ,'test_line_exp_time:' + getFieldTypeText(h.test_line_exp_time) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'blk_1000_pool:' + getFieldTypeText(h.blk_1000_pool) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rc_lata:' + getFieldTypeText(h.rc_lata) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filler4:' + getFieldTypeText(h.filler4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'creation_date:' + getFieldTypeText(h.creation_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'creation_time:' + getFieldTypeText(h.creation_time) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filler5:' + getFieldTypeText(h.filler5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e_status_date:' + getFieldTypeText(h.e_status_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e_status_time:' + getFieldTypeText(h.e_status_time) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filler6:' + getFieldTypeText(h.filler6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'last_modified_date:' + getFieldTypeText(h.last_modified_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'last_modified_time:' + getFieldTypeText(h.last_modified_time) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filler7:' + getFieldTypeText(h.filler7) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'is_current:' + getFieldTypeText(h.is_current) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'os1:' + getFieldTypeText(h.os1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'os2:' + getFieldTypeText(h.os2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'os3:' + getFieldTypeText(h.os3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'os4:' + getFieldTypeText(h.os4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'os5:' + getFieldTypeText(h.os5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'os6:' + getFieldTypeText(h.os6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'os7:' + getFieldTypeText(h.os7) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'os8:' + getFieldTypeText(h.os8) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'os9:' + getFieldTypeText(h.os9) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'os10:' + getFieldTypeText(h.os10) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'os11:' + getFieldTypeText(h.os11) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'os12:' + getFieldTypeText(h.os12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'os13:' + getFieldTypeText(h.os13) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'os14:' + getFieldTypeText(h.os14) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'os15:' + getFieldTypeText(h.os15) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'os16:' + getFieldTypeText(h.os16) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'os17:' + getFieldTypeText(h.os17) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'os18:' + getFieldTypeText(h.os18) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'os19:' + getFieldTypeText(h.os19) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'os20:' + getFieldTypeText(h.os20) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'os21:' + getFieldTypeText(h.os21) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'os22:' + getFieldTypeText(h.os22) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'os23:' + getFieldTypeText(h.os23) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'os24:' + getFieldTypeText(h.os24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'os25:' + getFieldTypeText(h.os25) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'notes:' + getFieldTypeText(h.notes) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'global_sid:' + getFieldTypeText(h.global_sid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'record_sid:' + getFieldTypeText(h.record_sid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_dt_first_reported_cnt
          ,le.populated_dt_last_reported_cnt
          ,le.populated_dt_start_cnt
          ,le.populated_dt_end_cnt
          ,le.populated_source_cnt
          ,le.populated_lata_cnt
          ,le.populated_lata_name_cnt
          ,le.populated_status_cnt
          ,le.populated_eff_date_cnt
          ,le.populated_eff_time_cnt
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
          ,le.populated_test_line_exp_time_cnt
          ,le.populated_blk_1000_pool_cnt
          ,le.populated_rc_lata_cnt
          ,le.populated_filler4_cnt
          ,le.populated_creation_date_cnt
          ,le.populated_creation_time_cnt
          ,le.populated_filler5_cnt
          ,le.populated_e_status_date_cnt
          ,le.populated_e_status_time_cnt
          ,le.populated_filler6_cnt
          ,le.populated_last_modified_date_cnt
          ,le.populated_last_modified_time_cnt
          ,le.populated_filler7_cnt
          ,le.populated_is_current_cnt
          ,le.populated_os1_cnt
          ,le.populated_os2_cnt
          ,le.populated_os3_cnt
          ,le.populated_os4_cnt
          ,le.populated_os5_cnt
          ,le.populated_os6_cnt
          ,le.populated_os7_cnt
          ,le.populated_os8_cnt
          ,le.populated_os9_cnt
          ,le.populated_os10_cnt
          ,le.populated_os11_cnt
          ,le.populated_os12_cnt
          ,le.populated_os13_cnt
          ,le.populated_os14_cnt
          ,le.populated_os15_cnt
          ,le.populated_os16_cnt
          ,le.populated_os17_cnt
          ,le.populated_os18_cnt
          ,le.populated_os19_cnt
          ,le.populated_os20_cnt
          ,le.populated_os21_cnt
          ,le.populated_os22_cnt
          ,le.populated_os23_cnt
          ,le.populated_os24_cnt
          ,le.populated_os25_cnt
          ,le.populated_notes_cnt
          ,le.populated_global_sid_cnt
          ,le.populated_record_sid_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_dt_first_reported_pcnt
          ,le.populated_dt_last_reported_pcnt
          ,le.populated_dt_start_pcnt
          ,le.populated_dt_end_pcnt
          ,le.populated_source_pcnt
          ,le.populated_lata_pcnt
          ,le.populated_lata_name_pcnt
          ,le.populated_status_pcnt
          ,le.populated_eff_date_pcnt
          ,le.populated_eff_time_pcnt
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
          ,le.populated_test_line_exp_time_pcnt
          ,le.populated_blk_1000_pool_pcnt
          ,le.populated_rc_lata_pcnt
          ,le.populated_filler4_pcnt
          ,le.populated_creation_date_pcnt
          ,le.populated_creation_time_pcnt
          ,le.populated_filler5_pcnt
          ,le.populated_e_status_date_pcnt
          ,le.populated_e_status_time_pcnt
          ,le.populated_filler6_pcnt
          ,le.populated_last_modified_date_pcnt
          ,le.populated_last_modified_time_pcnt
          ,le.populated_filler7_pcnt
          ,le.populated_is_current_pcnt
          ,le.populated_os1_pcnt
          ,le.populated_os2_pcnt
          ,le.populated_os3_pcnt
          ,le.populated_os4_pcnt
          ,le.populated_os5_pcnt
          ,le.populated_os6_pcnt
          ,le.populated_os7_pcnt
          ,le.populated_os8_pcnt
          ,le.populated_os9_pcnt
          ,le.populated_os10_pcnt
          ,le.populated_os11_pcnt
          ,le.populated_os12_pcnt
          ,le.populated_os13_pcnt
          ,le.populated_os14_pcnt
          ,le.populated_os15_pcnt
          ,le.populated_os16_pcnt
          ,le.populated_os17_pcnt
          ,le.populated_os18_pcnt
          ,le.populated_os19_pcnt
          ,le.populated_os20_pcnt
          ,le.populated_os21_pcnt
          ,le.populated_os22_pcnt
          ,le.populated_os23_pcnt
          ,le.populated_os24_pcnt
          ,le.populated_os25_pcnt
          ,le.populated_notes_pcnt
          ,le.populated_global_sid_pcnt
          ,le.populated_record_sid_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,78,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Lerg6Main_Delta(prevDS, PROJECT(h, Lerg6Main_Layout_Phonesinfo));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),78,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Lerg6Main_Layout_Phonesinfo) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Phonesinfo, Lerg6Main_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
