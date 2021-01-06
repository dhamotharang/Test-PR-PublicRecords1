IMPORT SALT311,STD;
EXPORT Lerg6Raw_hygiene(dataset(Lerg6Raw_layout_Phonesinfo) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_lata_cnt := COUNT(GROUP,h.lata <> (TYPEOF(h.lata))'');
    populated_lata_pcnt := AVE(GROUP,IF(h.lata = (TYPEOF(h.lata))'',0,100));
    maxlength_lata := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lata)));
    avelength_lata := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lata)),h.lata<>(typeof(h.lata))'');
    populated_lata_name_cnt := COUNT(GROUP,h.lata_name <> (TYPEOF(h.lata_name))'');
    populated_lata_name_pcnt := AVE(GROUP,IF(h.lata_name = (TYPEOF(h.lata_name))'',0,100));
    maxlength_lata_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lata_name)));
    avelength_lata_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lata_name)),h.lata_name<>(typeof(h.lata_name))'');
    populated_status_cnt := COUNT(GROUP,h.status <> (TYPEOF(h.status))'');
    populated_status_pcnt := AVE(GROUP,IF(h.status = (TYPEOF(h.status))'',0,100));
    maxlength_status := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.status)));
    avelength_status := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.status)),h.status<>(typeof(h.status))'');
    populated_eff_date_cnt := COUNT(GROUP,h.eff_date <> (TYPEOF(h.eff_date))'');
    populated_eff_date_pcnt := AVE(GROUP,IF(h.eff_date = (TYPEOF(h.eff_date))'',0,100));
    maxlength_eff_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.eff_date)));
    avelength_eff_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.eff_date)),h.eff_date<>(typeof(h.eff_date))'');
    populated_npa_cnt := COUNT(GROUP,h.npa <> (TYPEOF(h.npa))'');
    populated_npa_pcnt := AVE(GROUP,IF(h.npa = (TYPEOF(h.npa))'',0,100));
    maxlength_npa := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.npa)));
    avelength_npa := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.npa)),h.npa<>(typeof(h.npa))'');
    populated_nxx_cnt := COUNT(GROUP,h.nxx <> (TYPEOF(h.nxx))'');
    populated_nxx_pcnt := AVE(GROUP,IF(h.nxx = (TYPEOF(h.nxx))'',0,100));
    maxlength_nxx := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.nxx)));
    avelength_nxx := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.nxx)),h.nxx<>(typeof(h.nxx))'');
    populated_block_id_cnt := COUNT(GROUP,h.block_id <> (TYPEOF(h.block_id))'');
    populated_block_id_pcnt := AVE(GROUP,IF(h.block_id = (TYPEOF(h.block_id))'',0,100));
    maxlength_block_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.block_id)));
    avelength_block_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.block_id)),h.block_id<>(typeof(h.block_id))'');
    populated_filler1_cnt := COUNT(GROUP,h.filler1 <> (TYPEOF(h.filler1))'');
    populated_filler1_pcnt := AVE(GROUP,IF(h.filler1 = (TYPEOF(h.filler1))'',0,100));
    maxlength_filler1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler1)));
    avelength_filler1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler1)),h.filler1<>(typeof(h.filler1))'');
    populated_coc_type_cnt := COUNT(GROUP,h.coc_type <> (TYPEOF(h.coc_type))'');
    populated_coc_type_pcnt := AVE(GROUP,IF(h.coc_type = (TYPEOF(h.coc_type))'',0,100));
    maxlength_coc_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.coc_type)));
    avelength_coc_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.coc_type)),h.coc_type<>(typeof(h.coc_type))'');
    populated_ssc_cnt := COUNT(GROUP,h.ssc <> (TYPEOF(h.ssc))'');
    populated_ssc_pcnt := AVE(GROUP,IF(h.ssc = (TYPEOF(h.ssc))'',0,100));
    maxlength_ssc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ssc)));
    avelength_ssc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ssc)),h.ssc<>(typeof(h.ssc))'');
    populated_dind_cnt := COUNT(GROUP,h.dind <> (TYPEOF(h.dind))'');
    populated_dind_pcnt := AVE(GROUP,IF(h.dind = (TYPEOF(h.dind))'',0,100));
    maxlength_dind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dind)));
    avelength_dind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dind)),h.dind<>(typeof(h.dind))'');
    populated_td_eo_cnt := COUNT(GROUP,h.td_eo <> (TYPEOF(h.td_eo))'');
    populated_td_eo_pcnt := AVE(GROUP,IF(h.td_eo = (TYPEOF(h.td_eo))'',0,100));
    maxlength_td_eo := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.td_eo)));
    avelength_td_eo := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.td_eo)),h.td_eo<>(typeof(h.td_eo))'');
    populated_td_at_cnt := COUNT(GROUP,h.td_at <> (TYPEOF(h.td_at))'');
    populated_td_at_pcnt := AVE(GROUP,IF(h.td_at = (TYPEOF(h.td_at))'',0,100));
    maxlength_td_at := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.td_at)));
    avelength_td_at := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.td_at)),h.td_at<>(typeof(h.td_at))'');
    populated_portable_cnt := COUNT(GROUP,h.portable <> (TYPEOF(h.portable))'');
    populated_portable_pcnt := AVE(GROUP,IF(h.portable = (TYPEOF(h.portable))'',0,100));
    maxlength_portable := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.portable)));
    avelength_portable := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.portable)),h.portable<>(typeof(h.portable))'');
    populated_aocn_cnt := COUNT(GROUP,h.aocn <> (TYPEOF(h.aocn))'');
    populated_aocn_pcnt := AVE(GROUP,IF(h.aocn = (TYPEOF(h.aocn))'',0,100));
    maxlength_aocn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aocn)));
    avelength_aocn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aocn)),h.aocn<>(typeof(h.aocn))'');
    populated_filler2_cnt := COUNT(GROUP,h.filler2 <> (TYPEOF(h.filler2))'');
    populated_filler2_pcnt := AVE(GROUP,IF(h.filler2 = (TYPEOF(h.filler2))'',0,100));
    maxlength_filler2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler2)));
    avelength_filler2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler2)),h.filler2<>(typeof(h.filler2))'');
    populated_ocn_cnt := COUNT(GROUP,h.ocn <> (TYPEOF(h.ocn))'');
    populated_ocn_pcnt := AVE(GROUP,IF(h.ocn = (TYPEOF(h.ocn))'',0,100));
    maxlength_ocn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ocn)));
    avelength_ocn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ocn)),h.ocn<>(typeof(h.ocn))'');
    populated_loc_name_cnt := COUNT(GROUP,h.loc_name <> (TYPEOF(h.loc_name))'');
    populated_loc_name_pcnt := AVE(GROUP,IF(h.loc_name = (TYPEOF(h.loc_name))'',0,100));
    maxlength_loc_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.loc_name)));
    avelength_loc_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.loc_name)),h.loc_name<>(typeof(h.loc_name))'');
    populated_loc_cnt := COUNT(GROUP,h.loc <> (TYPEOF(h.loc))'');
    populated_loc_pcnt := AVE(GROUP,IF(h.loc = (TYPEOF(h.loc))'',0,100));
    maxlength_loc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.loc)));
    avelength_loc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.loc)),h.loc<>(typeof(h.loc))'');
    populated_loc_state_cnt := COUNT(GROUP,h.loc_state <> (TYPEOF(h.loc_state))'');
    populated_loc_state_pcnt := AVE(GROUP,IF(h.loc_state = (TYPEOF(h.loc_state))'',0,100));
    maxlength_loc_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.loc_state)));
    avelength_loc_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.loc_state)),h.loc_state<>(typeof(h.loc_state))'');
    populated_rc_abbre_cnt := COUNT(GROUP,h.rc_abbre <> (TYPEOF(h.rc_abbre))'');
    populated_rc_abbre_pcnt := AVE(GROUP,IF(h.rc_abbre = (TYPEOF(h.rc_abbre))'',0,100));
    maxlength_rc_abbre := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rc_abbre)));
    avelength_rc_abbre := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rc_abbre)),h.rc_abbre<>(typeof(h.rc_abbre))'');
    populated_rc_ty_cnt := COUNT(GROUP,h.rc_ty <> (TYPEOF(h.rc_ty))'');
    populated_rc_ty_pcnt := AVE(GROUP,IF(h.rc_ty = (TYPEOF(h.rc_ty))'',0,100));
    maxlength_rc_ty := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rc_ty)));
    avelength_rc_ty := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rc_ty)),h.rc_ty<>(typeof(h.rc_ty))'');
    populated_line_fr_cnt := COUNT(GROUP,h.line_fr <> (TYPEOF(h.line_fr))'');
    populated_line_fr_pcnt := AVE(GROUP,IF(h.line_fr = (TYPEOF(h.line_fr))'',0,100));
    maxlength_line_fr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.line_fr)));
    avelength_line_fr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.line_fr)),h.line_fr<>(typeof(h.line_fr))'');
    populated_line_to_cnt := COUNT(GROUP,h.line_to <> (TYPEOF(h.line_to))'');
    populated_line_to_pcnt := AVE(GROUP,IF(h.line_to = (TYPEOF(h.line_to))'',0,100));
    maxlength_line_to := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.line_to)));
    avelength_line_to := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.line_to)),h.line_to<>(typeof(h.line_to))'');
    populated_switch_cnt := COUNT(GROUP,h.switch <> (TYPEOF(h.switch))'');
    populated_switch_pcnt := AVE(GROUP,IF(h.switch = (TYPEOF(h.switch))'',0,100));
    maxlength_switch := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.switch)));
    avelength_switch := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.switch)),h.switch<>(typeof(h.switch))'');
    populated_sha_indicator_cnt := COUNT(GROUP,h.sha_indicator <> (TYPEOF(h.sha_indicator))'');
    populated_sha_indicator_pcnt := AVE(GROUP,IF(h.sha_indicator = (TYPEOF(h.sha_indicator))'',0,100));
    maxlength_sha_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sha_indicator)));
    avelength_sha_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sha_indicator)),h.sha_indicator<>(typeof(h.sha_indicator))'');
    populated_filler3_cnt := COUNT(GROUP,h.filler3 <> (TYPEOF(h.filler3))'');
    populated_filler3_pcnt := AVE(GROUP,IF(h.filler3 = (TYPEOF(h.filler3))'',0,100));
    maxlength_filler3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler3)));
    avelength_filler3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler3)),h.filler3<>(typeof(h.filler3))'');
    populated_test_line_num_cnt := COUNT(GROUP,h.test_line_num <> (TYPEOF(h.test_line_num))'');
    populated_test_line_num_pcnt := AVE(GROUP,IF(h.test_line_num = (TYPEOF(h.test_line_num))'',0,100));
    maxlength_test_line_num := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.test_line_num)));
    avelength_test_line_num := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.test_line_num)),h.test_line_num<>(typeof(h.test_line_num))'');
    populated_test_line_response_cnt := COUNT(GROUP,h.test_line_response <> (TYPEOF(h.test_line_response))'');
    populated_test_line_response_pcnt := AVE(GROUP,IF(h.test_line_response = (TYPEOF(h.test_line_response))'',0,100));
    maxlength_test_line_response := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.test_line_response)));
    avelength_test_line_response := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.test_line_response)),h.test_line_response<>(typeof(h.test_line_response))'');
    populated_test_line_exp_date_cnt := COUNT(GROUP,h.test_line_exp_date <> (TYPEOF(h.test_line_exp_date))'');
    populated_test_line_exp_date_pcnt := AVE(GROUP,IF(h.test_line_exp_date = (TYPEOF(h.test_line_exp_date))'',0,100));
    maxlength_test_line_exp_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.test_line_exp_date)));
    avelength_test_line_exp_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.test_line_exp_date)),h.test_line_exp_date<>(typeof(h.test_line_exp_date))'');
    populated_blk_1000_pool_cnt := COUNT(GROUP,h.blk_1000_pool <> (TYPEOF(h.blk_1000_pool))'');
    populated_blk_1000_pool_pcnt := AVE(GROUP,IF(h.blk_1000_pool = (TYPEOF(h.blk_1000_pool))'',0,100));
    maxlength_blk_1000_pool := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.blk_1000_pool)));
    avelength_blk_1000_pool := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.blk_1000_pool)),h.blk_1000_pool<>(typeof(h.blk_1000_pool))'');
    populated_rc_lata_cnt := COUNT(GROUP,h.rc_lata <> (TYPEOF(h.rc_lata))'');
    populated_rc_lata_pcnt := AVE(GROUP,IF(h.rc_lata = (TYPEOF(h.rc_lata))'',0,100));
    maxlength_rc_lata := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rc_lata)));
    avelength_rc_lata := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rc_lata)),h.rc_lata<>(typeof(h.rc_lata))'');
    populated_filler4_cnt := COUNT(GROUP,h.filler4 <> (TYPEOF(h.filler4))'');
    populated_filler4_pcnt := AVE(GROUP,IF(h.filler4 = (TYPEOF(h.filler4))'',0,100));
    maxlength_filler4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler4)));
    avelength_filler4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler4)),h.filler4<>(typeof(h.filler4))'');
    populated_creation_date_cnt := COUNT(GROUP,h.creation_date <> (TYPEOF(h.creation_date))'');
    populated_creation_date_pcnt := AVE(GROUP,IF(h.creation_date = (TYPEOF(h.creation_date))'',0,100));
    maxlength_creation_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.creation_date)));
    avelength_creation_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.creation_date)),h.creation_date<>(typeof(h.creation_date))'');
    populated_filler5_cnt := COUNT(GROUP,h.filler5 <> (TYPEOF(h.filler5))'');
    populated_filler5_pcnt := AVE(GROUP,IF(h.filler5 = (TYPEOF(h.filler5))'',0,100));
    maxlength_filler5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler5)));
    avelength_filler5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler5)),h.filler5<>(typeof(h.filler5))'');
    populated_e_status_date_cnt := COUNT(GROUP,h.e_status_date <> (TYPEOF(h.e_status_date))'');
    populated_e_status_date_pcnt := AVE(GROUP,IF(h.e_status_date = (TYPEOF(h.e_status_date))'',0,100));
    maxlength_e_status_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.e_status_date)));
    avelength_e_status_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.e_status_date)),h.e_status_date<>(typeof(h.e_status_date))'');
    populated_filler6_cnt := COUNT(GROUP,h.filler6 <> (TYPEOF(h.filler6))'');
    populated_filler6_pcnt := AVE(GROUP,IF(h.filler6 = (TYPEOF(h.filler6))'',0,100));
    maxlength_filler6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler6)));
    avelength_filler6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler6)),h.filler6<>(typeof(h.filler6))'');
    populated_last_modified_date_cnt := COUNT(GROUP,h.last_modified_date <> (TYPEOF(h.last_modified_date))'');
    populated_last_modified_date_pcnt := AVE(GROUP,IF(h.last_modified_date = (TYPEOF(h.last_modified_date))'',0,100));
    maxlength_last_modified_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_modified_date)));
    avelength_last_modified_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_modified_date)),h.last_modified_date<>(typeof(h.last_modified_date))'');
    populated_filler7_cnt := COUNT(GROUP,h.filler7 <> (TYPEOF(h.filler7))'');
    populated_filler7_pcnt := AVE(GROUP,IF(h.filler7 = (TYPEOF(h.filler7))'',0,100));
    maxlength_filler7 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler7)));
    avelength_filler7 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler7)),h.filler7<>(typeof(h.filler7))'');
    populated_filename_cnt := COUNT(GROUP,h.filename <> (TYPEOF(h.filename))'');
    populated_filename_pcnt := AVE(GROUP,IF(h.filename = (TYPEOF(h.filename))'',0,100));
    maxlength_filename := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filename)));
    avelength_filename := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filename)),h.filename<>(typeof(h.filename))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_lata_pcnt *   0.00 / 100 + T.Populated_lata_name_pcnt *   0.00 / 100 + T.Populated_status_pcnt *   0.00 / 100 + T.Populated_eff_date_pcnt *   0.00 / 100 + T.Populated_npa_pcnt *   0.00 / 100 + T.Populated_nxx_pcnt *   0.00 / 100 + T.Populated_block_id_pcnt *   0.00 / 100 + T.Populated_filler1_pcnt *   0.00 / 100 + T.Populated_coc_type_pcnt *   0.00 / 100 + T.Populated_ssc_pcnt *   0.00 / 100 + T.Populated_dind_pcnt *   0.00 / 100 + T.Populated_td_eo_pcnt *   0.00 / 100 + T.Populated_td_at_pcnt *   0.00 / 100 + T.Populated_portable_pcnt *   0.00 / 100 + T.Populated_aocn_pcnt *   0.00 / 100 + T.Populated_filler2_pcnt *   0.00 / 100 + T.Populated_ocn_pcnt *   0.00 / 100 + T.Populated_loc_name_pcnt *   0.00 / 100 + T.Populated_loc_pcnt *   0.00 / 100 + T.Populated_loc_state_pcnt *   0.00 / 100 + T.Populated_rc_abbre_pcnt *   0.00 / 100 + T.Populated_rc_ty_pcnt *   0.00 / 100 + T.Populated_line_fr_pcnt *   0.00 / 100 + T.Populated_line_to_pcnt *   0.00 / 100 + T.Populated_switch_pcnt *   0.00 / 100 + T.Populated_sha_indicator_pcnt *   0.00 / 100 + T.Populated_filler3_pcnt *   0.00 / 100 + T.Populated_test_line_num_pcnt *   0.00 / 100 + T.Populated_test_line_response_pcnt *   0.00 / 100 + T.Populated_test_line_exp_date_pcnt *   0.00 / 100 + T.Populated_blk_1000_pool_pcnt *   0.00 / 100 + T.Populated_rc_lata_pcnt *   0.00 / 100 + T.Populated_filler4_pcnt *   0.00 / 100 + T.Populated_creation_date_pcnt *   0.00 / 100 + T.Populated_filler5_pcnt *   0.00 / 100 + T.Populated_e_status_date_pcnt *   0.00 / 100 + T.Populated_filler6_pcnt *   0.00 / 100 + T.Populated_last_modified_date_pcnt *   0.00 / 100 + T.Populated_filler7_pcnt *   0.00 / 100 + T.Populated_filename_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT311.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'lata','lata_name','status','eff_date','npa','nxx','block_id','filler1','coc_type','ssc','dind','td_eo','td_at','portable','aocn','filler2','ocn','loc_name','loc','loc_state','rc_abbre','rc_ty','line_fr','line_to','switch','sha_indicator','filler3','test_line_num','test_line_response','test_line_exp_date','blk_1000_pool','rc_lata','filler4','creation_date','filler5','e_status_date','filler6','last_modified_date','filler7','filename');
  SELF.populated_pcnt := CHOOSE(C,le.populated_lata_pcnt,le.populated_lata_name_pcnt,le.populated_status_pcnt,le.populated_eff_date_pcnt,le.populated_npa_pcnt,le.populated_nxx_pcnt,le.populated_block_id_pcnt,le.populated_filler1_pcnt,le.populated_coc_type_pcnt,le.populated_ssc_pcnt,le.populated_dind_pcnt,le.populated_td_eo_pcnt,le.populated_td_at_pcnt,le.populated_portable_pcnt,le.populated_aocn_pcnt,le.populated_filler2_pcnt,le.populated_ocn_pcnt,le.populated_loc_name_pcnt,le.populated_loc_pcnt,le.populated_loc_state_pcnt,le.populated_rc_abbre_pcnt,le.populated_rc_ty_pcnt,le.populated_line_fr_pcnt,le.populated_line_to_pcnt,le.populated_switch_pcnt,le.populated_sha_indicator_pcnt,le.populated_filler3_pcnt,le.populated_test_line_num_pcnt,le.populated_test_line_response_pcnt,le.populated_test_line_exp_date_pcnt,le.populated_blk_1000_pool_pcnt,le.populated_rc_lata_pcnt,le.populated_filler4_pcnt,le.populated_creation_date_pcnt,le.populated_filler5_pcnt,le.populated_e_status_date_pcnt,le.populated_filler6_pcnt,le.populated_last_modified_date_pcnt,le.populated_filler7_pcnt,le.populated_filename_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_lata,le.maxlength_lata_name,le.maxlength_status,le.maxlength_eff_date,le.maxlength_npa,le.maxlength_nxx,le.maxlength_block_id,le.maxlength_filler1,le.maxlength_coc_type,le.maxlength_ssc,le.maxlength_dind,le.maxlength_td_eo,le.maxlength_td_at,le.maxlength_portable,le.maxlength_aocn,le.maxlength_filler2,le.maxlength_ocn,le.maxlength_loc_name,le.maxlength_loc,le.maxlength_loc_state,le.maxlength_rc_abbre,le.maxlength_rc_ty,le.maxlength_line_fr,le.maxlength_line_to,le.maxlength_switch,le.maxlength_sha_indicator,le.maxlength_filler3,le.maxlength_test_line_num,le.maxlength_test_line_response,le.maxlength_test_line_exp_date,le.maxlength_blk_1000_pool,le.maxlength_rc_lata,le.maxlength_filler4,le.maxlength_creation_date,le.maxlength_filler5,le.maxlength_e_status_date,le.maxlength_filler6,le.maxlength_last_modified_date,le.maxlength_filler7,le.maxlength_filename);
  SELF.avelength := CHOOSE(C,le.avelength_lata,le.avelength_lata_name,le.avelength_status,le.avelength_eff_date,le.avelength_npa,le.avelength_nxx,le.avelength_block_id,le.avelength_filler1,le.avelength_coc_type,le.avelength_ssc,le.avelength_dind,le.avelength_td_eo,le.avelength_td_at,le.avelength_portable,le.avelength_aocn,le.avelength_filler2,le.avelength_ocn,le.avelength_loc_name,le.avelength_loc,le.avelength_loc_state,le.avelength_rc_abbre,le.avelength_rc_ty,le.avelength_line_fr,le.avelength_line_to,le.avelength_switch,le.avelength_sha_indicator,le.avelength_filler3,le.avelength_test_line_num,le.avelength_test_line_response,le.avelength_test_line_exp_date,le.avelength_blk_1000_pool,le.avelength_rc_lata,le.avelength_filler4,le.avelength_creation_date,le.avelength_filler5,le.avelength_e_status_date,le.avelength_filler6,le.avelength_last_modified_date,le.avelength_filler7,le.avelength_filename);
END;
EXPORT invSummary := NORMALIZE(summary0, 40, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.lata),TRIM((SALT311.StrType)le.lata_name),TRIM((SALT311.StrType)le.status),TRIM((SALT311.StrType)le.eff_date),TRIM((SALT311.StrType)le.npa),TRIM((SALT311.StrType)le.nxx),TRIM((SALT311.StrType)le.block_id),TRIM((SALT311.StrType)le.filler1),TRIM((SALT311.StrType)le.coc_type),TRIM((SALT311.StrType)le.ssc),TRIM((SALT311.StrType)le.dind),TRIM((SALT311.StrType)le.td_eo),TRIM((SALT311.StrType)le.td_at),TRIM((SALT311.StrType)le.portable),TRIM((SALT311.StrType)le.aocn),TRIM((SALT311.StrType)le.filler2),TRIM((SALT311.StrType)le.ocn),TRIM((SALT311.StrType)le.loc_name),TRIM((SALT311.StrType)le.loc),TRIM((SALT311.StrType)le.loc_state),TRIM((SALT311.StrType)le.rc_abbre),TRIM((SALT311.StrType)le.rc_ty),TRIM((SALT311.StrType)le.line_fr),TRIM((SALT311.StrType)le.line_to),TRIM((SALT311.StrType)le.switch),TRIM((SALT311.StrType)le.sha_indicator),TRIM((SALT311.StrType)le.filler3),TRIM((SALT311.StrType)le.test_line_num),TRIM((SALT311.StrType)le.test_line_response),TRIM((SALT311.StrType)le.test_line_exp_date),TRIM((SALT311.StrType)le.blk_1000_pool),TRIM((SALT311.StrType)le.rc_lata),TRIM((SALT311.StrType)le.filler4),TRIM((SALT311.StrType)le.creation_date),TRIM((SALT311.StrType)le.filler5),TRIM((SALT311.StrType)le.e_status_date),TRIM((SALT311.StrType)le.filler6),TRIM((SALT311.StrType)le.last_modified_date),TRIM((SALT311.StrType)le.filler7),TRIM((SALT311.StrType)le.filename)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,40,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 40);
  SELF.FldNo2 := 1 + (C % 40);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.lata),TRIM((SALT311.StrType)le.lata_name),TRIM((SALT311.StrType)le.status),TRIM((SALT311.StrType)le.eff_date),TRIM((SALT311.StrType)le.npa),TRIM((SALT311.StrType)le.nxx),TRIM((SALT311.StrType)le.block_id),TRIM((SALT311.StrType)le.filler1),TRIM((SALT311.StrType)le.coc_type),TRIM((SALT311.StrType)le.ssc),TRIM((SALT311.StrType)le.dind),TRIM((SALT311.StrType)le.td_eo),TRIM((SALT311.StrType)le.td_at),TRIM((SALT311.StrType)le.portable),TRIM((SALT311.StrType)le.aocn),TRIM((SALT311.StrType)le.filler2),TRIM((SALT311.StrType)le.ocn),TRIM((SALT311.StrType)le.loc_name),TRIM((SALT311.StrType)le.loc),TRIM((SALT311.StrType)le.loc_state),TRIM((SALT311.StrType)le.rc_abbre),TRIM((SALT311.StrType)le.rc_ty),TRIM((SALT311.StrType)le.line_fr),TRIM((SALT311.StrType)le.line_to),TRIM((SALT311.StrType)le.switch),TRIM((SALT311.StrType)le.sha_indicator),TRIM((SALT311.StrType)le.filler3),TRIM((SALT311.StrType)le.test_line_num),TRIM((SALT311.StrType)le.test_line_response),TRIM((SALT311.StrType)le.test_line_exp_date),TRIM((SALT311.StrType)le.blk_1000_pool),TRIM((SALT311.StrType)le.rc_lata),TRIM((SALT311.StrType)le.filler4),TRIM((SALT311.StrType)le.creation_date),TRIM((SALT311.StrType)le.filler5),TRIM((SALT311.StrType)le.e_status_date),TRIM((SALT311.StrType)le.filler6),TRIM((SALT311.StrType)le.last_modified_date),TRIM((SALT311.StrType)le.filler7),TRIM((SALT311.StrType)le.filename)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.lata),TRIM((SALT311.StrType)le.lata_name),TRIM((SALT311.StrType)le.status),TRIM((SALT311.StrType)le.eff_date),TRIM((SALT311.StrType)le.npa),TRIM((SALT311.StrType)le.nxx),TRIM((SALT311.StrType)le.block_id),TRIM((SALT311.StrType)le.filler1),TRIM((SALT311.StrType)le.coc_type),TRIM((SALT311.StrType)le.ssc),TRIM((SALT311.StrType)le.dind),TRIM((SALT311.StrType)le.td_eo),TRIM((SALT311.StrType)le.td_at),TRIM((SALT311.StrType)le.portable),TRIM((SALT311.StrType)le.aocn),TRIM((SALT311.StrType)le.filler2),TRIM((SALT311.StrType)le.ocn),TRIM((SALT311.StrType)le.loc_name),TRIM((SALT311.StrType)le.loc),TRIM((SALT311.StrType)le.loc_state),TRIM((SALT311.StrType)le.rc_abbre),TRIM((SALT311.StrType)le.rc_ty),TRIM((SALT311.StrType)le.line_fr),TRIM((SALT311.StrType)le.line_to),TRIM((SALT311.StrType)le.switch),TRIM((SALT311.StrType)le.sha_indicator),TRIM((SALT311.StrType)le.filler3),TRIM((SALT311.StrType)le.test_line_num),TRIM((SALT311.StrType)le.test_line_response),TRIM((SALT311.StrType)le.test_line_exp_date),TRIM((SALT311.StrType)le.blk_1000_pool),TRIM((SALT311.StrType)le.rc_lata),TRIM((SALT311.StrType)le.filler4),TRIM((SALT311.StrType)le.creation_date),TRIM((SALT311.StrType)le.filler5),TRIM((SALT311.StrType)le.e_status_date),TRIM((SALT311.StrType)le.filler6),TRIM((SALT311.StrType)le.last_modified_date),TRIM((SALT311.StrType)le.filler7),TRIM((SALT311.StrType)le.filename)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),40*40,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'lata'}
      ,{2,'lata_name'}
      ,{3,'status'}
      ,{4,'eff_date'}
      ,{5,'npa'}
      ,{6,'nxx'}
      ,{7,'block_id'}
      ,{8,'filler1'}
      ,{9,'coc_type'}
      ,{10,'ssc'}
      ,{11,'dind'}
      ,{12,'td_eo'}
      ,{13,'td_at'}
      ,{14,'portable'}
      ,{15,'aocn'}
      ,{16,'filler2'}
      ,{17,'ocn'}
      ,{18,'loc_name'}
      ,{19,'loc'}
      ,{20,'loc_state'}
      ,{21,'rc_abbre'}
      ,{22,'rc_ty'}
      ,{23,'line_fr'}
      ,{24,'line_to'}
      ,{25,'switch'}
      ,{26,'sha_indicator'}
      ,{27,'filler3'}
      ,{28,'test_line_num'}
      ,{29,'test_line_response'}
      ,{30,'test_line_exp_date'}
      ,{31,'blk_1000_pool'}
      ,{32,'rc_lata'}
      ,{33,'filler4'}
      ,{34,'creation_date'}
      ,{35,'filler5'}
      ,{36,'e_status_date'}
      ,{37,'filler6'}
      ,{38,'last_modified_date'}
      ,{39,'filler7'}
      ,{40,'filename'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Lerg6Raw_Fields.InValid_lata((SALT311.StrType)le.lata),
    Lerg6Raw_Fields.InValid_lata_name((SALT311.StrType)le.lata_name),
    Lerg6Raw_Fields.InValid_status((SALT311.StrType)le.status),
    Lerg6Raw_Fields.InValid_eff_date((SALT311.StrType)le.eff_date),
    Lerg6Raw_Fields.InValid_npa((SALT311.StrType)le.npa),
    Lerg6Raw_Fields.InValid_nxx((SALT311.StrType)le.nxx),
    Lerg6Raw_Fields.InValid_block_id((SALT311.StrType)le.block_id),
    Lerg6Raw_Fields.InValid_filler1((SALT311.StrType)le.filler1),
    Lerg6Raw_Fields.InValid_coc_type((SALT311.StrType)le.coc_type),
    Lerg6Raw_Fields.InValid_ssc((SALT311.StrType)le.ssc),
    Lerg6Raw_Fields.InValid_dind((SALT311.StrType)le.dind),
    Lerg6Raw_Fields.InValid_td_eo((SALT311.StrType)le.td_eo),
    Lerg6Raw_Fields.InValid_td_at((SALT311.StrType)le.td_at),
    Lerg6Raw_Fields.InValid_portable((SALT311.StrType)le.portable),
    Lerg6Raw_Fields.InValid_aocn((SALT311.StrType)le.aocn),
    Lerg6Raw_Fields.InValid_filler2((SALT311.StrType)le.filler2),
    Lerg6Raw_Fields.InValid_ocn((SALT311.StrType)le.ocn),
    Lerg6Raw_Fields.InValid_loc_name((SALT311.StrType)le.loc_name),
    Lerg6Raw_Fields.InValid_loc((SALT311.StrType)le.loc),
    Lerg6Raw_Fields.InValid_loc_state((SALT311.StrType)le.loc_state),
    Lerg6Raw_Fields.InValid_rc_abbre((SALT311.StrType)le.rc_abbre),
    Lerg6Raw_Fields.InValid_rc_ty((SALT311.StrType)le.rc_ty),
    Lerg6Raw_Fields.InValid_line_fr((SALT311.StrType)le.line_fr),
    Lerg6Raw_Fields.InValid_line_to((SALT311.StrType)le.line_to),
    Lerg6Raw_Fields.InValid_switch((SALT311.StrType)le.switch),
    Lerg6Raw_Fields.InValid_sha_indicator((SALT311.StrType)le.sha_indicator),
    Lerg6Raw_Fields.InValid_filler3((SALT311.StrType)le.filler3),
    Lerg6Raw_Fields.InValid_test_line_num((SALT311.StrType)le.test_line_num),
    Lerg6Raw_Fields.InValid_test_line_response((SALT311.StrType)le.test_line_response),
    Lerg6Raw_Fields.InValid_test_line_exp_date((SALT311.StrType)le.test_line_exp_date),
    Lerg6Raw_Fields.InValid_blk_1000_pool((SALT311.StrType)le.blk_1000_pool),
    Lerg6Raw_Fields.InValid_rc_lata((SALT311.StrType)le.rc_lata),
    Lerg6Raw_Fields.InValid_filler4((SALT311.StrType)le.filler4),
    Lerg6Raw_Fields.InValid_creation_date((SALT311.StrType)le.creation_date),
    Lerg6Raw_Fields.InValid_filler5((SALT311.StrType)le.filler5),
    Lerg6Raw_Fields.InValid_e_status_date((SALT311.StrType)le.e_status_date),
    Lerg6Raw_Fields.InValid_filler6((SALT311.StrType)le.filler6),
    Lerg6Raw_Fields.InValid_last_modified_date((SALT311.StrType)le.last_modified_date),
    Lerg6Raw_Fields.InValid_filler7((SALT311.StrType)le.filler7),
    Lerg6Raw_Fields.InValid_filename((SALT311.StrType)le.filename),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,40,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Lerg6Raw_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Num','Invalid_Alpha','Invalid_StatusCode','Unknown','Invalid_Num','Invalid_Nxx','Invalid_BlockID','Unknown','Invalid_CocTypeCode','Invalid_SccTypeCode','Invalid_YesNo','Invalid_TdCode','Invalid_TdCode','Invalid_YesNo','Invalid_Char','Unknown','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Alpha','Invalid_Char','Invalid_RcTyCode','Invalid_Num','Invalid_Num','Invalid_Char','Invalid_Num','Unknown','Invalid_Num','Invalid_TestRespCode','Unknown','Invalid_TBlockInd','Invalid_Num','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_Filename');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Lerg6Raw_Fields.InValidMessage_lata(TotalErrors.ErrorNum),Lerg6Raw_Fields.InValidMessage_lata_name(TotalErrors.ErrorNum),Lerg6Raw_Fields.InValidMessage_status(TotalErrors.ErrorNum),Lerg6Raw_Fields.InValidMessage_eff_date(TotalErrors.ErrorNum),Lerg6Raw_Fields.InValidMessage_npa(TotalErrors.ErrorNum),Lerg6Raw_Fields.InValidMessage_nxx(TotalErrors.ErrorNum),Lerg6Raw_Fields.InValidMessage_block_id(TotalErrors.ErrorNum),Lerg6Raw_Fields.InValidMessage_filler1(TotalErrors.ErrorNum),Lerg6Raw_Fields.InValidMessage_coc_type(TotalErrors.ErrorNum),Lerg6Raw_Fields.InValidMessage_ssc(TotalErrors.ErrorNum),Lerg6Raw_Fields.InValidMessage_dind(TotalErrors.ErrorNum),Lerg6Raw_Fields.InValidMessage_td_eo(TotalErrors.ErrorNum),Lerg6Raw_Fields.InValidMessage_td_at(TotalErrors.ErrorNum),Lerg6Raw_Fields.InValidMessage_portable(TotalErrors.ErrorNum),Lerg6Raw_Fields.InValidMessage_aocn(TotalErrors.ErrorNum),Lerg6Raw_Fields.InValidMessage_filler2(TotalErrors.ErrorNum),Lerg6Raw_Fields.InValidMessage_ocn(TotalErrors.ErrorNum),Lerg6Raw_Fields.InValidMessage_loc_name(TotalErrors.ErrorNum),Lerg6Raw_Fields.InValidMessage_loc(TotalErrors.ErrorNum),Lerg6Raw_Fields.InValidMessage_loc_state(TotalErrors.ErrorNum),Lerg6Raw_Fields.InValidMessage_rc_abbre(TotalErrors.ErrorNum),Lerg6Raw_Fields.InValidMessage_rc_ty(TotalErrors.ErrorNum),Lerg6Raw_Fields.InValidMessage_line_fr(TotalErrors.ErrorNum),Lerg6Raw_Fields.InValidMessage_line_to(TotalErrors.ErrorNum),Lerg6Raw_Fields.InValidMessage_switch(TotalErrors.ErrorNum),Lerg6Raw_Fields.InValidMessage_sha_indicator(TotalErrors.ErrorNum),Lerg6Raw_Fields.InValidMessage_filler3(TotalErrors.ErrorNum),Lerg6Raw_Fields.InValidMessage_test_line_num(TotalErrors.ErrorNum),Lerg6Raw_Fields.InValidMessage_test_line_response(TotalErrors.ErrorNum),Lerg6Raw_Fields.InValidMessage_test_line_exp_date(TotalErrors.ErrorNum),Lerg6Raw_Fields.InValidMessage_blk_1000_pool(TotalErrors.ErrorNum),Lerg6Raw_Fields.InValidMessage_rc_lata(TotalErrors.ErrorNum),Lerg6Raw_Fields.InValidMessage_filler4(TotalErrors.ErrorNum),Lerg6Raw_Fields.InValidMessage_creation_date(TotalErrors.ErrorNum),Lerg6Raw_Fields.InValidMessage_filler5(TotalErrors.ErrorNum),Lerg6Raw_Fields.InValidMessage_e_status_date(TotalErrors.ErrorNum),Lerg6Raw_Fields.InValidMessage_filler6(TotalErrors.ErrorNum),Lerg6Raw_Fields.InValidMessage_last_modified_date(TotalErrors.ErrorNum),Lerg6Raw_Fields.InValidMessage_filler7(TotalErrors.ErrorNum),Lerg6Raw_Fields.InValidMessage_filename(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Phonesinfo, Lerg6Raw_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
