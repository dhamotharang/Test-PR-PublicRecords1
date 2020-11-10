IMPORT SALT311,STD;
EXPORT Lerg6Main_hygiene(dataset(Lerg6Main_layout_Phonesinfo) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_dt_first_reported_cnt := COUNT(GROUP,h.dt_first_reported <> (TYPEOF(h.dt_first_reported))'');
    populated_dt_first_reported_pcnt := AVE(GROUP,IF(h.dt_first_reported = (TYPEOF(h.dt_first_reported))'',0,100));
    maxlength_dt_first_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_reported)));
    avelength_dt_first_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_reported)),h.dt_first_reported<>(typeof(h.dt_first_reported))'');
    populated_dt_last_reported_cnt := COUNT(GROUP,h.dt_last_reported <> (TYPEOF(h.dt_last_reported))'');
    populated_dt_last_reported_pcnt := AVE(GROUP,IF(h.dt_last_reported = (TYPEOF(h.dt_last_reported))'',0,100));
    maxlength_dt_last_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_reported)));
    avelength_dt_last_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_reported)),h.dt_last_reported<>(typeof(h.dt_last_reported))'');
    populated_dt_start_cnt := COUNT(GROUP,h.dt_start <> (TYPEOF(h.dt_start))'');
    populated_dt_start_pcnt := AVE(GROUP,IF(h.dt_start = (TYPEOF(h.dt_start))'',0,100));
    maxlength_dt_start := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_start)));
    avelength_dt_start := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_start)),h.dt_start<>(typeof(h.dt_start))'');
    populated_dt_end_cnt := COUNT(GROUP,h.dt_end <> (TYPEOF(h.dt_end))'');
    populated_dt_end_pcnt := AVE(GROUP,IF(h.dt_end = (TYPEOF(h.dt_end))'',0,100));
    maxlength_dt_end := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_end)));
    avelength_dt_end := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_end)),h.dt_end<>(typeof(h.dt_end))'');
    populated_source_cnt := COUNT(GROUP,h.source <> (TYPEOF(h.source))'');
    populated_source_pcnt := AVE(GROUP,IF(h.source = (TYPEOF(h.source))'',0,100));
    maxlength_source := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source)));
    avelength_source := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source)),h.source<>(typeof(h.source))'');
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
    populated_eff_time_cnt := COUNT(GROUP,h.eff_time <> (TYPEOF(h.eff_time))'');
    populated_eff_time_pcnt := AVE(GROUP,IF(h.eff_time = (TYPEOF(h.eff_time))'',0,100));
    maxlength_eff_time := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.eff_time)));
    avelength_eff_time := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.eff_time)),h.eff_time<>(typeof(h.eff_time))'');
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
    populated_test_line_exp_time_cnt := COUNT(GROUP,h.test_line_exp_time <> (TYPEOF(h.test_line_exp_time))'');
    populated_test_line_exp_time_pcnt := AVE(GROUP,IF(h.test_line_exp_time = (TYPEOF(h.test_line_exp_time))'',0,100));
    maxlength_test_line_exp_time := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.test_line_exp_time)));
    avelength_test_line_exp_time := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.test_line_exp_time)),h.test_line_exp_time<>(typeof(h.test_line_exp_time))'');
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
    populated_creation_time_cnt := COUNT(GROUP,h.creation_time <> (TYPEOF(h.creation_time))'');
    populated_creation_time_pcnt := AVE(GROUP,IF(h.creation_time = (TYPEOF(h.creation_time))'',0,100));
    maxlength_creation_time := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.creation_time)));
    avelength_creation_time := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.creation_time)),h.creation_time<>(typeof(h.creation_time))'');
    populated_filler5_cnt := COUNT(GROUP,h.filler5 <> (TYPEOF(h.filler5))'');
    populated_filler5_pcnt := AVE(GROUP,IF(h.filler5 = (TYPEOF(h.filler5))'',0,100));
    maxlength_filler5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler5)));
    avelength_filler5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler5)),h.filler5<>(typeof(h.filler5))'');
    populated_e_status_date_cnt := COUNT(GROUP,h.e_status_date <> (TYPEOF(h.e_status_date))'');
    populated_e_status_date_pcnt := AVE(GROUP,IF(h.e_status_date = (TYPEOF(h.e_status_date))'',0,100));
    maxlength_e_status_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.e_status_date)));
    avelength_e_status_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.e_status_date)),h.e_status_date<>(typeof(h.e_status_date))'');
    populated_e_status_time_cnt := COUNT(GROUP,h.e_status_time <> (TYPEOF(h.e_status_time))'');
    populated_e_status_time_pcnt := AVE(GROUP,IF(h.e_status_time = (TYPEOF(h.e_status_time))'',0,100));
    maxlength_e_status_time := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.e_status_time)));
    avelength_e_status_time := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.e_status_time)),h.e_status_time<>(typeof(h.e_status_time))'');
    populated_filler6_cnt := COUNT(GROUP,h.filler6 <> (TYPEOF(h.filler6))'');
    populated_filler6_pcnt := AVE(GROUP,IF(h.filler6 = (TYPEOF(h.filler6))'',0,100));
    maxlength_filler6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler6)));
    avelength_filler6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler6)),h.filler6<>(typeof(h.filler6))'');
    populated_last_modified_date_cnt := COUNT(GROUP,h.last_modified_date <> (TYPEOF(h.last_modified_date))'');
    populated_last_modified_date_pcnt := AVE(GROUP,IF(h.last_modified_date = (TYPEOF(h.last_modified_date))'',0,100));
    maxlength_last_modified_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_modified_date)));
    avelength_last_modified_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_modified_date)),h.last_modified_date<>(typeof(h.last_modified_date))'');
    populated_last_modified_time_cnt := COUNT(GROUP,h.last_modified_time <> (TYPEOF(h.last_modified_time))'');
    populated_last_modified_time_pcnt := AVE(GROUP,IF(h.last_modified_time = (TYPEOF(h.last_modified_time))'',0,100));
    maxlength_last_modified_time := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_modified_time)));
    avelength_last_modified_time := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_modified_time)),h.last_modified_time<>(typeof(h.last_modified_time))'');
    populated_filler7_cnt := COUNT(GROUP,h.filler7 <> (TYPEOF(h.filler7))'');
    populated_filler7_pcnt := AVE(GROUP,IF(h.filler7 = (TYPEOF(h.filler7))'',0,100));
    maxlength_filler7 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler7)));
    avelength_filler7 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler7)),h.filler7<>(typeof(h.filler7))'');
    populated_is_current_cnt := COUNT(GROUP,h.is_current <> (TYPEOF(h.is_current))'');
    populated_is_current_pcnt := AVE(GROUP,IF(h.is_current = (TYPEOF(h.is_current))'',0,100));
    maxlength_is_current := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.is_current)));
    avelength_is_current := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.is_current)),h.is_current<>(typeof(h.is_current))'');
    populated_os1_cnt := COUNT(GROUP,h.os1 <> (TYPEOF(h.os1))'');
    populated_os1_pcnt := AVE(GROUP,IF(h.os1 = (TYPEOF(h.os1))'',0,100));
    maxlength_os1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.os1)));
    avelength_os1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.os1)),h.os1<>(typeof(h.os1))'');
    populated_os2_cnt := COUNT(GROUP,h.os2 <> (TYPEOF(h.os2))'');
    populated_os2_pcnt := AVE(GROUP,IF(h.os2 = (TYPEOF(h.os2))'',0,100));
    maxlength_os2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.os2)));
    avelength_os2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.os2)),h.os2<>(typeof(h.os2))'');
    populated_os3_cnt := COUNT(GROUP,h.os3 <> (TYPEOF(h.os3))'');
    populated_os3_pcnt := AVE(GROUP,IF(h.os3 = (TYPEOF(h.os3))'',0,100));
    maxlength_os3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.os3)));
    avelength_os3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.os3)),h.os3<>(typeof(h.os3))'');
    populated_os4_cnt := COUNT(GROUP,h.os4 <> (TYPEOF(h.os4))'');
    populated_os4_pcnt := AVE(GROUP,IF(h.os4 = (TYPEOF(h.os4))'',0,100));
    maxlength_os4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.os4)));
    avelength_os4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.os4)),h.os4<>(typeof(h.os4))'');
    populated_os5_cnt := COUNT(GROUP,h.os5 <> (TYPEOF(h.os5))'');
    populated_os5_pcnt := AVE(GROUP,IF(h.os5 = (TYPEOF(h.os5))'',0,100));
    maxlength_os5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.os5)));
    avelength_os5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.os5)),h.os5<>(typeof(h.os5))'');
    populated_os6_cnt := COUNT(GROUP,h.os6 <> (TYPEOF(h.os6))'');
    populated_os6_pcnt := AVE(GROUP,IF(h.os6 = (TYPEOF(h.os6))'',0,100));
    maxlength_os6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.os6)));
    avelength_os6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.os6)),h.os6<>(typeof(h.os6))'');
    populated_os7_cnt := COUNT(GROUP,h.os7 <> (TYPEOF(h.os7))'');
    populated_os7_pcnt := AVE(GROUP,IF(h.os7 = (TYPEOF(h.os7))'',0,100));
    maxlength_os7 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.os7)));
    avelength_os7 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.os7)),h.os7<>(typeof(h.os7))'');
    populated_os8_cnt := COUNT(GROUP,h.os8 <> (TYPEOF(h.os8))'');
    populated_os8_pcnt := AVE(GROUP,IF(h.os8 = (TYPEOF(h.os8))'',0,100));
    maxlength_os8 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.os8)));
    avelength_os8 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.os8)),h.os8<>(typeof(h.os8))'');
    populated_os9_cnt := COUNT(GROUP,h.os9 <> (TYPEOF(h.os9))'');
    populated_os9_pcnt := AVE(GROUP,IF(h.os9 = (TYPEOF(h.os9))'',0,100));
    maxlength_os9 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.os9)));
    avelength_os9 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.os9)),h.os9<>(typeof(h.os9))'');
    populated_os10_cnt := COUNT(GROUP,h.os10 <> (TYPEOF(h.os10))'');
    populated_os10_pcnt := AVE(GROUP,IF(h.os10 = (TYPEOF(h.os10))'',0,100));
    maxlength_os10 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.os10)));
    avelength_os10 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.os10)),h.os10<>(typeof(h.os10))'');
    populated_os11_cnt := COUNT(GROUP,h.os11 <> (TYPEOF(h.os11))'');
    populated_os11_pcnt := AVE(GROUP,IF(h.os11 = (TYPEOF(h.os11))'',0,100));
    maxlength_os11 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.os11)));
    avelength_os11 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.os11)),h.os11<>(typeof(h.os11))'');
    populated_os12_cnt := COUNT(GROUP,h.os12 <> (TYPEOF(h.os12))'');
    populated_os12_pcnt := AVE(GROUP,IF(h.os12 = (TYPEOF(h.os12))'',0,100));
    maxlength_os12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.os12)));
    avelength_os12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.os12)),h.os12<>(typeof(h.os12))'');
    populated_os13_cnt := COUNT(GROUP,h.os13 <> (TYPEOF(h.os13))'');
    populated_os13_pcnt := AVE(GROUP,IF(h.os13 = (TYPEOF(h.os13))'',0,100));
    maxlength_os13 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.os13)));
    avelength_os13 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.os13)),h.os13<>(typeof(h.os13))'');
    populated_os14_cnt := COUNT(GROUP,h.os14 <> (TYPEOF(h.os14))'');
    populated_os14_pcnt := AVE(GROUP,IF(h.os14 = (TYPEOF(h.os14))'',0,100));
    maxlength_os14 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.os14)));
    avelength_os14 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.os14)),h.os14<>(typeof(h.os14))'');
    populated_os15_cnt := COUNT(GROUP,h.os15 <> (TYPEOF(h.os15))'');
    populated_os15_pcnt := AVE(GROUP,IF(h.os15 = (TYPEOF(h.os15))'',0,100));
    maxlength_os15 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.os15)));
    avelength_os15 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.os15)),h.os15<>(typeof(h.os15))'');
    populated_os16_cnt := COUNT(GROUP,h.os16 <> (TYPEOF(h.os16))'');
    populated_os16_pcnt := AVE(GROUP,IF(h.os16 = (TYPEOF(h.os16))'',0,100));
    maxlength_os16 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.os16)));
    avelength_os16 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.os16)),h.os16<>(typeof(h.os16))'');
    populated_os17_cnt := COUNT(GROUP,h.os17 <> (TYPEOF(h.os17))'');
    populated_os17_pcnt := AVE(GROUP,IF(h.os17 = (TYPEOF(h.os17))'',0,100));
    maxlength_os17 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.os17)));
    avelength_os17 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.os17)),h.os17<>(typeof(h.os17))'');
    populated_os18_cnt := COUNT(GROUP,h.os18 <> (TYPEOF(h.os18))'');
    populated_os18_pcnt := AVE(GROUP,IF(h.os18 = (TYPEOF(h.os18))'',0,100));
    maxlength_os18 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.os18)));
    avelength_os18 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.os18)),h.os18<>(typeof(h.os18))'');
    populated_os19_cnt := COUNT(GROUP,h.os19 <> (TYPEOF(h.os19))'');
    populated_os19_pcnt := AVE(GROUP,IF(h.os19 = (TYPEOF(h.os19))'',0,100));
    maxlength_os19 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.os19)));
    avelength_os19 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.os19)),h.os19<>(typeof(h.os19))'');
    populated_os20_cnt := COUNT(GROUP,h.os20 <> (TYPEOF(h.os20))'');
    populated_os20_pcnt := AVE(GROUP,IF(h.os20 = (TYPEOF(h.os20))'',0,100));
    maxlength_os20 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.os20)));
    avelength_os20 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.os20)),h.os20<>(typeof(h.os20))'');
    populated_os21_cnt := COUNT(GROUP,h.os21 <> (TYPEOF(h.os21))'');
    populated_os21_pcnt := AVE(GROUP,IF(h.os21 = (TYPEOF(h.os21))'',0,100));
    maxlength_os21 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.os21)));
    avelength_os21 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.os21)),h.os21<>(typeof(h.os21))'');
    populated_os22_cnt := COUNT(GROUP,h.os22 <> (TYPEOF(h.os22))'');
    populated_os22_pcnt := AVE(GROUP,IF(h.os22 = (TYPEOF(h.os22))'',0,100));
    maxlength_os22 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.os22)));
    avelength_os22 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.os22)),h.os22<>(typeof(h.os22))'');
    populated_os23_cnt := COUNT(GROUP,h.os23 <> (TYPEOF(h.os23))'');
    populated_os23_pcnt := AVE(GROUP,IF(h.os23 = (TYPEOF(h.os23))'',0,100));
    maxlength_os23 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.os23)));
    avelength_os23 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.os23)),h.os23<>(typeof(h.os23))'');
    populated_os24_cnt := COUNT(GROUP,h.os24 <> (TYPEOF(h.os24))'');
    populated_os24_pcnt := AVE(GROUP,IF(h.os24 = (TYPEOF(h.os24))'',0,100));
    maxlength_os24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.os24)));
    avelength_os24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.os24)),h.os24<>(typeof(h.os24))'');
    populated_os25_cnt := COUNT(GROUP,h.os25 <> (TYPEOF(h.os25))'');
    populated_os25_pcnt := AVE(GROUP,IF(h.os25 = (TYPEOF(h.os25))'',0,100));
    maxlength_os25 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.os25)));
    avelength_os25 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.os25)),h.os25<>(typeof(h.os25))'');
    populated_notes_cnt := COUNT(GROUP,h.notes <> (TYPEOF(h.notes))'');
    populated_notes_pcnt := AVE(GROUP,IF(h.notes = (TYPEOF(h.notes))'',0,100));
    maxlength_notes := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.notes)));
    avelength_notes := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.notes)),h.notes<>(typeof(h.notes))'');
    populated_global_sid_cnt := COUNT(GROUP,h.global_sid <> (TYPEOF(h.global_sid))'');
    populated_global_sid_pcnt := AVE(GROUP,IF(h.global_sid = (TYPEOF(h.global_sid))'',0,100));
    maxlength_global_sid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.global_sid)));
    avelength_global_sid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.global_sid)),h.global_sid<>(typeof(h.global_sid))'');
    populated_record_sid_cnt := COUNT(GROUP,h.record_sid <> (TYPEOF(h.record_sid))'');
    populated_record_sid_pcnt := AVE(GROUP,IF(h.record_sid = (TYPEOF(h.record_sid))'',0,100));
    maxlength_record_sid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_sid)));
    avelength_record_sid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_sid)),h.record_sid<>(typeof(h.record_sid))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_dt_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_last_reported_pcnt *   0.00 / 100 + T.Populated_dt_start_pcnt *   0.00 / 100 + T.Populated_dt_end_pcnt *   0.00 / 100 + T.Populated_source_pcnt *   0.00 / 100 + T.Populated_lata_pcnt *   0.00 / 100 + T.Populated_lata_name_pcnt *   0.00 / 100 + T.Populated_status_pcnt *   0.00 / 100 + T.Populated_eff_date_pcnt *   0.00 / 100 + T.Populated_eff_time_pcnt *   0.00 / 100 + T.Populated_npa_pcnt *   0.00 / 100 + T.Populated_nxx_pcnt *   0.00 / 100 + T.Populated_block_id_pcnt *   0.00 / 100 + T.Populated_filler1_pcnt *   0.00 / 100 + T.Populated_coc_type_pcnt *   0.00 / 100 + T.Populated_ssc_pcnt *   0.00 / 100 + T.Populated_dind_pcnt *   0.00 / 100 + T.Populated_td_eo_pcnt *   0.00 / 100 + T.Populated_td_at_pcnt *   0.00 / 100 + T.Populated_portable_pcnt *   0.00 / 100 + T.Populated_aocn_pcnt *   0.00 / 100 + T.Populated_filler2_pcnt *   0.00 / 100 + T.Populated_ocn_pcnt *   0.00 / 100 + T.Populated_loc_name_pcnt *   0.00 / 100 + T.Populated_loc_pcnt *   0.00 / 100 + T.Populated_loc_state_pcnt *   0.00 / 100 + T.Populated_rc_abbre_pcnt *   0.00 / 100 + T.Populated_rc_ty_pcnt *   0.00 / 100 + T.Populated_line_fr_pcnt *   0.00 / 100 + T.Populated_line_to_pcnt *   0.00 / 100 + T.Populated_switch_pcnt *   0.00 / 100 + T.Populated_sha_indicator_pcnt *   0.00 / 100 + T.Populated_filler3_pcnt *   0.00 / 100 + T.Populated_test_line_num_pcnt *   0.00 / 100 + T.Populated_test_line_response_pcnt *   0.00 / 100 + T.Populated_test_line_exp_date_pcnt *   0.00 / 100 + T.Populated_test_line_exp_time_pcnt *   0.00 / 100 + T.Populated_blk_1000_pool_pcnt *   0.00 / 100 + T.Populated_rc_lata_pcnt *   0.00 / 100 + T.Populated_filler4_pcnt *   0.00 / 100 + T.Populated_creation_date_pcnt *   0.00 / 100 + T.Populated_creation_time_pcnt *   0.00 / 100 + T.Populated_filler5_pcnt *   0.00 / 100 + T.Populated_e_status_date_pcnt *   0.00 / 100 + T.Populated_e_status_time_pcnt *   0.00 / 100 + T.Populated_filler6_pcnt *   0.00 / 100 + T.Populated_last_modified_date_pcnt *   0.00 / 100 + T.Populated_last_modified_time_pcnt *   0.00 / 100 + T.Populated_filler7_pcnt *   0.00 / 100 + T.Populated_is_current_pcnt *   0.00 / 100 + T.Populated_os1_pcnt *   0.00 / 100 + T.Populated_os2_pcnt *   0.00 / 100 + T.Populated_os3_pcnt *   0.00 / 100 + T.Populated_os4_pcnt *   0.00 / 100 + T.Populated_os5_pcnt *   0.00 / 100 + T.Populated_os6_pcnt *   0.00 / 100 + T.Populated_os7_pcnt *   0.00 / 100 + T.Populated_os8_pcnt *   0.00 / 100 + T.Populated_os9_pcnt *   0.00 / 100 + T.Populated_os10_pcnt *   0.00 / 100 + T.Populated_os11_pcnt *   0.00 / 100 + T.Populated_os12_pcnt *   0.00 / 100 + T.Populated_os13_pcnt *   0.00 / 100 + T.Populated_os14_pcnt *   0.00 / 100 + T.Populated_os15_pcnt *   0.00 / 100 + T.Populated_os16_pcnt *   0.00 / 100 + T.Populated_os17_pcnt *   0.00 / 100 + T.Populated_os18_pcnt *   0.00 / 100 + T.Populated_os19_pcnt *   0.00 / 100 + T.Populated_os20_pcnt *   0.00 / 100 + T.Populated_os21_pcnt *   0.00 / 100 + T.Populated_os22_pcnt *   0.00 / 100 + T.Populated_os23_pcnt *   0.00 / 100 + T.Populated_os24_pcnt *   0.00 / 100 + T.Populated_os25_pcnt *   0.00 / 100 + T.Populated_notes_pcnt *   0.00 / 100 + T.Populated_global_sid_pcnt *   0.00 / 100 + T.Populated_record_sid_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'dt_first_reported','dt_last_reported','dt_start','dt_end','source','lata','lata_name','status','eff_date','eff_time','npa','nxx','block_id','filler1','coc_type','ssc','dind','td_eo','td_at','portable','aocn','filler2','ocn','loc_name','loc','loc_state','rc_abbre','rc_ty','line_fr','line_to','switch','sha_indicator','filler3','test_line_num','test_line_response','test_line_exp_date','test_line_exp_time','blk_1000_pool','rc_lata','filler4','creation_date','creation_time','filler5','e_status_date','e_status_time','filler6','last_modified_date','last_modified_time','filler7','is_current','os1','os2','os3','os4','os5','os6','os7','os8','os9','os10','os11','os12','os13','os14','os15','os16','os17','os18','os19','os20','os21','os22','os23','os24','os25','notes','global_sid','record_sid');
  SELF.populated_pcnt := CHOOSE(C,le.populated_dt_first_reported_pcnt,le.populated_dt_last_reported_pcnt,le.populated_dt_start_pcnt,le.populated_dt_end_pcnt,le.populated_source_pcnt,le.populated_lata_pcnt,le.populated_lata_name_pcnt,le.populated_status_pcnt,le.populated_eff_date_pcnt,le.populated_eff_time_pcnt,le.populated_npa_pcnt,le.populated_nxx_pcnt,le.populated_block_id_pcnt,le.populated_filler1_pcnt,le.populated_coc_type_pcnt,le.populated_ssc_pcnt,le.populated_dind_pcnt,le.populated_td_eo_pcnt,le.populated_td_at_pcnt,le.populated_portable_pcnt,le.populated_aocn_pcnt,le.populated_filler2_pcnt,le.populated_ocn_pcnt,le.populated_loc_name_pcnt,le.populated_loc_pcnt,le.populated_loc_state_pcnt,le.populated_rc_abbre_pcnt,le.populated_rc_ty_pcnt,le.populated_line_fr_pcnt,le.populated_line_to_pcnt,le.populated_switch_pcnt,le.populated_sha_indicator_pcnt,le.populated_filler3_pcnt,le.populated_test_line_num_pcnt,le.populated_test_line_response_pcnt,le.populated_test_line_exp_date_pcnt,le.populated_test_line_exp_time_pcnt,le.populated_blk_1000_pool_pcnt,le.populated_rc_lata_pcnt,le.populated_filler4_pcnt,le.populated_creation_date_pcnt,le.populated_creation_time_pcnt,le.populated_filler5_pcnt,le.populated_e_status_date_pcnt,le.populated_e_status_time_pcnt,le.populated_filler6_pcnt,le.populated_last_modified_date_pcnt,le.populated_last_modified_time_pcnt,le.populated_filler7_pcnt,le.populated_is_current_pcnt,le.populated_os1_pcnt,le.populated_os2_pcnt,le.populated_os3_pcnt,le.populated_os4_pcnt,le.populated_os5_pcnt,le.populated_os6_pcnt,le.populated_os7_pcnt,le.populated_os8_pcnt,le.populated_os9_pcnt,le.populated_os10_pcnt,le.populated_os11_pcnt,le.populated_os12_pcnt,le.populated_os13_pcnt,le.populated_os14_pcnt,le.populated_os15_pcnt,le.populated_os16_pcnt,le.populated_os17_pcnt,le.populated_os18_pcnt,le.populated_os19_pcnt,le.populated_os20_pcnt,le.populated_os21_pcnt,le.populated_os22_pcnt,le.populated_os23_pcnt,le.populated_os24_pcnt,le.populated_os25_pcnt,le.populated_notes_pcnt,le.populated_global_sid_pcnt,le.populated_record_sid_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_dt_first_reported,le.maxlength_dt_last_reported,le.maxlength_dt_start,le.maxlength_dt_end,le.maxlength_source,le.maxlength_lata,le.maxlength_lata_name,le.maxlength_status,le.maxlength_eff_date,le.maxlength_eff_time,le.maxlength_npa,le.maxlength_nxx,le.maxlength_block_id,le.maxlength_filler1,le.maxlength_coc_type,le.maxlength_ssc,le.maxlength_dind,le.maxlength_td_eo,le.maxlength_td_at,le.maxlength_portable,le.maxlength_aocn,le.maxlength_filler2,le.maxlength_ocn,le.maxlength_loc_name,le.maxlength_loc,le.maxlength_loc_state,le.maxlength_rc_abbre,le.maxlength_rc_ty,le.maxlength_line_fr,le.maxlength_line_to,le.maxlength_switch,le.maxlength_sha_indicator,le.maxlength_filler3,le.maxlength_test_line_num,le.maxlength_test_line_response,le.maxlength_test_line_exp_date,le.maxlength_test_line_exp_time,le.maxlength_blk_1000_pool,le.maxlength_rc_lata,le.maxlength_filler4,le.maxlength_creation_date,le.maxlength_creation_time,le.maxlength_filler5,le.maxlength_e_status_date,le.maxlength_e_status_time,le.maxlength_filler6,le.maxlength_last_modified_date,le.maxlength_last_modified_time,le.maxlength_filler7,le.maxlength_is_current,le.maxlength_os1,le.maxlength_os2,le.maxlength_os3,le.maxlength_os4,le.maxlength_os5,le.maxlength_os6,le.maxlength_os7,le.maxlength_os8,le.maxlength_os9,le.maxlength_os10,le.maxlength_os11,le.maxlength_os12,le.maxlength_os13,le.maxlength_os14,le.maxlength_os15,le.maxlength_os16,le.maxlength_os17,le.maxlength_os18,le.maxlength_os19,le.maxlength_os20,le.maxlength_os21,le.maxlength_os22,le.maxlength_os23,le.maxlength_os24,le.maxlength_os25,le.maxlength_notes,le.maxlength_global_sid,le.maxlength_record_sid);
  SELF.avelength := CHOOSE(C,le.avelength_dt_first_reported,le.avelength_dt_last_reported,le.avelength_dt_start,le.avelength_dt_end,le.avelength_source,le.avelength_lata,le.avelength_lata_name,le.avelength_status,le.avelength_eff_date,le.avelength_eff_time,le.avelength_npa,le.avelength_nxx,le.avelength_block_id,le.avelength_filler1,le.avelength_coc_type,le.avelength_ssc,le.avelength_dind,le.avelength_td_eo,le.avelength_td_at,le.avelength_portable,le.avelength_aocn,le.avelength_filler2,le.avelength_ocn,le.avelength_loc_name,le.avelength_loc,le.avelength_loc_state,le.avelength_rc_abbre,le.avelength_rc_ty,le.avelength_line_fr,le.avelength_line_to,le.avelength_switch,le.avelength_sha_indicator,le.avelength_filler3,le.avelength_test_line_num,le.avelength_test_line_response,le.avelength_test_line_exp_date,le.avelength_test_line_exp_time,le.avelength_blk_1000_pool,le.avelength_rc_lata,le.avelength_filler4,le.avelength_creation_date,le.avelength_creation_time,le.avelength_filler5,le.avelength_e_status_date,le.avelength_e_status_time,le.avelength_filler6,le.avelength_last_modified_date,le.avelength_last_modified_time,le.avelength_filler7,le.avelength_is_current,le.avelength_os1,le.avelength_os2,le.avelength_os3,le.avelength_os4,le.avelength_os5,le.avelength_os6,le.avelength_os7,le.avelength_os8,le.avelength_os9,le.avelength_os10,le.avelength_os11,le.avelength_os12,le.avelength_os13,le.avelength_os14,le.avelength_os15,le.avelength_os16,le.avelength_os17,le.avelength_os18,le.avelength_os19,le.avelength_os20,le.avelength_os21,le.avelength_os22,le.avelength_os23,le.avelength_os24,le.avelength_os25,le.avelength_notes,le.avelength_global_sid,le.avelength_record_sid);
END;
EXPORT invSummary := NORMALIZE(summary0, 78, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.dt_first_reported),TRIM((SALT311.StrType)le.dt_last_reported),TRIM((SALT311.StrType)le.dt_start),TRIM((SALT311.StrType)le.dt_end),TRIM((SALT311.StrType)le.source),TRIM((SALT311.StrType)le.lata),TRIM((SALT311.StrType)le.lata_name),TRIM((SALT311.StrType)le.status),TRIM((SALT311.StrType)le.eff_date),TRIM((SALT311.StrType)le.eff_time),TRIM((SALT311.StrType)le.npa),TRIM((SALT311.StrType)le.nxx),TRIM((SALT311.StrType)le.block_id),TRIM((SALT311.StrType)le.filler1),TRIM((SALT311.StrType)le.coc_type),TRIM((SALT311.StrType)le.ssc),TRIM((SALT311.StrType)le.dind),TRIM((SALT311.StrType)le.td_eo),TRIM((SALT311.StrType)le.td_at),TRIM((SALT311.StrType)le.portable),TRIM((SALT311.StrType)le.aocn),TRIM((SALT311.StrType)le.filler2),TRIM((SALT311.StrType)le.ocn),TRIM((SALT311.StrType)le.loc_name),TRIM((SALT311.StrType)le.loc),TRIM((SALT311.StrType)le.loc_state),TRIM((SALT311.StrType)le.rc_abbre),TRIM((SALT311.StrType)le.rc_ty),TRIM((SALT311.StrType)le.line_fr),TRIM((SALT311.StrType)le.line_to),TRIM((SALT311.StrType)le.switch),TRIM((SALT311.StrType)le.sha_indicator),TRIM((SALT311.StrType)le.filler3),TRIM((SALT311.StrType)le.test_line_num),TRIM((SALT311.StrType)le.test_line_response),TRIM((SALT311.StrType)le.test_line_exp_date),TRIM((SALT311.StrType)le.test_line_exp_time),TRIM((SALT311.StrType)le.blk_1000_pool),TRIM((SALT311.StrType)le.rc_lata),TRIM((SALT311.StrType)le.filler4),TRIM((SALT311.StrType)le.creation_date),TRIM((SALT311.StrType)le.creation_time),TRIM((SALT311.StrType)le.filler5),TRIM((SALT311.StrType)le.e_status_date),TRIM((SALT311.StrType)le.e_status_time),TRIM((SALT311.StrType)le.filler6),TRIM((SALT311.StrType)le.last_modified_date),TRIM((SALT311.StrType)le.last_modified_time),TRIM((SALT311.StrType)le.filler7),TRIM((SALT311.StrType)le.is_current),TRIM((SALT311.StrType)le.os1),TRIM((SALT311.StrType)le.os2),TRIM((SALT311.StrType)le.os3),TRIM((SALT311.StrType)le.os4),TRIM((SALT311.StrType)le.os5),TRIM((SALT311.StrType)le.os6),TRIM((SALT311.StrType)le.os7),TRIM((SALT311.StrType)le.os8),TRIM((SALT311.StrType)le.os9),TRIM((SALT311.StrType)le.os10),TRIM((SALT311.StrType)le.os11),TRIM((SALT311.StrType)le.os12),TRIM((SALT311.StrType)le.os13),TRIM((SALT311.StrType)le.os14),TRIM((SALT311.StrType)le.os15),TRIM((SALT311.StrType)le.os16),TRIM((SALT311.StrType)le.os17),TRIM((SALT311.StrType)le.os18),TRIM((SALT311.StrType)le.os19),TRIM((SALT311.StrType)le.os20),TRIM((SALT311.StrType)le.os21),TRIM((SALT311.StrType)le.os22),TRIM((SALT311.StrType)le.os23),TRIM((SALT311.StrType)le.os24),TRIM((SALT311.StrType)le.os25),TRIM((SALT311.StrType)le.notes),IF (le.global_sid <> 0,TRIM((SALT311.StrType)le.global_sid), ''),IF (le.record_sid <> 0,TRIM((SALT311.StrType)le.record_sid), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,78,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 78);
  SELF.FldNo2 := 1 + (C % 78);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.dt_first_reported),TRIM((SALT311.StrType)le.dt_last_reported),TRIM((SALT311.StrType)le.dt_start),TRIM((SALT311.StrType)le.dt_end),TRIM((SALT311.StrType)le.source),TRIM((SALT311.StrType)le.lata),TRIM((SALT311.StrType)le.lata_name),TRIM((SALT311.StrType)le.status),TRIM((SALT311.StrType)le.eff_date),TRIM((SALT311.StrType)le.eff_time),TRIM((SALT311.StrType)le.npa),TRIM((SALT311.StrType)le.nxx),TRIM((SALT311.StrType)le.block_id),TRIM((SALT311.StrType)le.filler1),TRIM((SALT311.StrType)le.coc_type),TRIM((SALT311.StrType)le.ssc),TRIM((SALT311.StrType)le.dind),TRIM((SALT311.StrType)le.td_eo),TRIM((SALT311.StrType)le.td_at),TRIM((SALT311.StrType)le.portable),TRIM((SALT311.StrType)le.aocn),TRIM((SALT311.StrType)le.filler2),TRIM((SALT311.StrType)le.ocn),TRIM((SALT311.StrType)le.loc_name),TRIM((SALT311.StrType)le.loc),TRIM((SALT311.StrType)le.loc_state),TRIM((SALT311.StrType)le.rc_abbre),TRIM((SALT311.StrType)le.rc_ty),TRIM((SALT311.StrType)le.line_fr),TRIM((SALT311.StrType)le.line_to),TRIM((SALT311.StrType)le.switch),TRIM((SALT311.StrType)le.sha_indicator),TRIM((SALT311.StrType)le.filler3),TRIM((SALT311.StrType)le.test_line_num),TRIM((SALT311.StrType)le.test_line_response),TRIM((SALT311.StrType)le.test_line_exp_date),TRIM((SALT311.StrType)le.test_line_exp_time),TRIM((SALT311.StrType)le.blk_1000_pool),TRIM((SALT311.StrType)le.rc_lata),TRIM((SALT311.StrType)le.filler4),TRIM((SALT311.StrType)le.creation_date),TRIM((SALT311.StrType)le.creation_time),TRIM((SALT311.StrType)le.filler5),TRIM((SALT311.StrType)le.e_status_date),TRIM((SALT311.StrType)le.e_status_time),TRIM((SALT311.StrType)le.filler6),TRIM((SALT311.StrType)le.last_modified_date),TRIM((SALT311.StrType)le.last_modified_time),TRIM((SALT311.StrType)le.filler7),TRIM((SALT311.StrType)le.is_current),TRIM((SALT311.StrType)le.os1),TRIM((SALT311.StrType)le.os2),TRIM((SALT311.StrType)le.os3),TRIM((SALT311.StrType)le.os4),TRIM((SALT311.StrType)le.os5),TRIM((SALT311.StrType)le.os6),TRIM((SALT311.StrType)le.os7),TRIM((SALT311.StrType)le.os8),TRIM((SALT311.StrType)le.os9),TRIM((SALT311.StrType)le.os10),TRIM((SALT311.StrType)le.os11),TRIM((SALT311.StrType)le.os12),TRIM((SALT311.StrType)le.os13),TRIM((SALT311.StrType)le.os14),TRIM((SALT311.StrType)le.os15),TRIM((SALT311.StrType)le.os16),TRIM((SALT311.StrType)le.os17),TRIM((SALT311.StrType)le.os18),TRIM((SALT311.StrType)le.os19),TRIM((SALT311.StrType)le.os20),TRIM((SALT311.StrType)le.os21),TRIM((SALT311.StrType)le.os22),TRIM((SALT311.StrType)le.os23),TRIM((SALT311.StrType)le.os24),TRIM((SALT311.StrType)le.os25),TRIM((SALT311.StrType)le.notes),IF (le.global_sid <> 0,TRIM((SALT311.StrType)le.global_sid), ''),IF (le.record_sid <> 0,TRIM((SALT311.StrType)le.record_sid), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.dt_first_reported),TRIM((SALT311.StrType)le.dt_last_reported),TRIM((SALT311.StrType)le.dt_start),TRIM((SALT311.StrType)le.dt_end),TRIM((SALT311.StrType)le.source),TRIM((SALT311.StrType)le.lata),TRIM((SALT311.StrType)le.lata_name),TRIM((SALT311.StrType)le.status),TRIM((SALT311.StrType)le.eff_date),TRIM((SALT311.StrType)le.eff_time),TRIM((SALT311.StrType)le.npa),TRIM((SALT311.StrType)le.nxx),TRIM((SALT311.StrType)le.block_id),TRIM((SALT311.StrType)le.filler1),TRIM((SALT311.StrType)le.coc_type),TRIM((SALT311.StrType)le.ssc),TRIM((SALT311.StrType)le.dind),TRIM((SALT311.StrType)le.td_eo),TRIM((SALT311.StrType)le.td_at),TRIM((SALT311.StrType)le.portable),TRIM((SALT311.StrType)le.aocn),TRIM((SALT311.StrType)le.filler2),TRIM((SALT311.StrType)le.ocn),TRIM((SALT311.StrType)le.loc_name),TRIM((SALT311.StrType)le.loc),TRIM((SALT311.StrType)le.loc_state),TRIM((SALT311.StrType)le.rc_abbre),TRIM((SALT311.StrType)le.rc_ty),TRIM((SALT311.StrType)le.line_fr),TRIM((SALT311.StrType)le.line_to),TRIM((SALT311.StrType)le.switch),TRIM((SALT311.StrType)le.sha_indicator),TRIM((SALT311.StrType)le.filler3),TRIM((SALT311.StrType)le.test_line_num),TRIM((SALT311.StrType)le.test_line_response),TRIM((SALT311.StrType)le.test_line_exp_date),TRIM((SALT311.StrType)le.test_line_exp_time),TRIM((SALT311.StrType)le.blk_1000_pool),TRIM((SALT311.StrType)le.rc_lata),TRIM((SALT311.StrType)le.filler4),TRIM((SALT311.StrType)le.creation_date),TRIM((SALT311.StrType)le.creation_time),TRIM((SALT311.StrType)le.filler5),TRIM((SALT311.StrType)le.e_status_date),TRIM((SALT311.StrType)le.e_status_time),TRIM((SALT311.StrType)le.filler6),TRIM((SALT311.StrType)le.last_modified_date),TRIM((SALT311.StrType)le.last_modified_time),TRIM((SALT311.StrType)le.filler7),TRIM((SALT311.StrType)le.is_current),TRIM((SALT311.StrType)le.os1),TRIM((SALT311.StrType)le.os2),TRIM((SALT311.StrType)le.os3),TRIM((SALT311.StrType)le.os4),TRIM((SALT311.StrType)le.os5),TRIM((SALT311.StrType)le.os6),TRIM((SALT311.StrType)le.os7),TRIM((SALT311.StrType)le.os8),TRIM((SALT311.StrType)le.os9),TRIM((SALT311.StrType)le.os10),TRIM((SALT311.StrType)le.os11),TRIM((SALT311.StrType)le.os12),TRIM((SALT311.StrType)le.os13),TRIM((SALT311.StrType)le.os14),TRIM((SALT311.StrType)le.os15),TRIM((SALT311.StrType)le.os16),TRIM((SALT311.StrType)le.os17),TRIM((SALT311.StrType)le.os18),TRIM((SALT311.StrType)le.os19),TRIM((SALT311.StrType)le.os20),TRIM((SALT311.StrType)le.os21),TRIM((SALT311.StrType)le.os22),TRIM((SALT311.StrType)le.os23),TRIM((SALT311.StrType)le.os24),TRIM((SALT311.StrType)le.os25),TRIM((SALT311.StrType)le.notes),IF (le.global_sid <> 0,TRIM((SALT311.StrType)le.global_sid), ''),IF (le.record_sid <> 0,TRIM((SALT311.StrType)le.record_sid), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),78*78,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'dt_first_reported'}
      ,{2,'dt_last_reported'}
      ,{3,'dt_start'}
      ,{4,'dt_end'}
      ,{5,'source'}
      ,{6,'lata'}
      ,{7,'lata_name'}
      ,{8,'status'}
      ,{9,'eff_date'}
      ,{10,'eff_time'}
      ,{11,'npa'}
      ,{12,'nxx'}
      ,{13,'block_id'}
      ,{14,'filler1'}
      ,{15,'coc_type'}
      ,{16,'ssc'}
      ,{17,'dind'}
      ,{18,'td_eo'}
      ,{19,'td_at'}
      ,{20,'portable'}
      ,{21,'aocn'}
      ,{22,'filler2'}
      ,{23,'ocn'}
      ,{24,'loc_name'}
      ,{25,'loc'}
      ,{26,'loc_state'}
      ,{27,'rc_abbre'}
      ,{28,'rc_ty'}
      ,{29,'line_fr'}
      ,{30,'line_to'}
      ,{31,'switch'}
      ,{32,'sha_indicator'}
      ,{33,'filler3'}
      ,{34,'test_line_num'}
      ,{35,'test_line_response'}
      ,{36,'test_line_exp_date'}
      ,{37,'test_line_exp_time'}
      ,{38,'blk_1000_pool'}
      ,{39,'rc_lata'}
      ,{40,'filler4'}
      ,{41,'creation_date'}
      ,{42,'creation_time'}
      ,{43,'filler5'}
      ,{44,'e_status_date'}
      ,{45,'e_status_time'}
      ,{46,'filler6'}
      ,{47,'last_modified_date'}
      ,{48,'last_modified_time'}
      ,{49,'filler7'}
      ,{50,'is_current'}
      ,{51,'os1'}
      ,{52,'os2'}
      ,{53,'os3'}
      ,{54,'os4'}
      ,{55,'os5'}
      ,{56,'os6'}
      ,{57,'os7'}
      ,{58,'os8'}
      ,{59,'os9'}
      ,{60,'os10'}
      ,{61,'os11'}
      ,{62,'os12'}
      ,{63,'os13'}
      ,{64,'os14'}
      ,{65,'os15'}
      ,{66,'os16'}
      ,{67,'os17'}
      ,{68,'os18'}
      ,{69,'os19'}
      ,{70,'os20'}
      ,{71,'os21'}
      ,{72,'os22'}
      ,{73,'os23'}
      ,{74,'os24'}
      ,{75,'os25'}
      ,{76,'notes'}
      ,{77,'global_sid'}
      ,{78,'record_sid'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Lerg6Main_Fields.InValid_dt_first_reported((SALT311.StrType)le.dt_first_reported),
    Lerg6Main_Fields.InValid_dt_last_reported((SALT311.StrType)le.dt_last_reported),
    Lerg6Main_Fields.InValid_dt_start((SALT311.StrType)le.dt_start),
    Lerg6Main_Fields.InValid_dt_end((SALT311.StrType)le.dt_end),
    Lerg6Main_Fields.InValid_source((SALT311.StrType)le.source),
    Lerg6Main_Fields.InValid_lata((SALT311.StrType)le.lata),
    Lerg6Main_Fields.InValid_lata_name((SALT311.StrType)le.lata_name),
    Lerg6Main_Fields.InValid_status((SALT311.StrType)le.status),
    Lerg6Main_Fields.InValid_eff_date((SALT311.StrType)le.eff_date),
    Lerg6Main_Fields.InValid_eff_time((SALT311.StrType)le.eff_time),
    Lerg6Main_Fields.InValid_npa((SALT311.StrType)le.npa),
    Lerg6Main_Fields.InValid_nxx((SALT311.StrType)le.nxx),
    Lerg6Main_Fields.InValid_block_id((SALT311.StrType)le.block_id),
    Lerg6Main_Fields.InValid_filler1((SALT311.StrType)le.filler1),
    Lerg6Main_Fields.InValid_coc_type((SALT311.StrType)le.coc_type),
    Lerg6Main_Fields.InValid_ssc((SALT311.StrType)le.ssc),
    Lerg6Main_Fields.InValid_dind((SALT311.StrType)le.dind),
    Lerg6Main_Fields.InValid_td_eo((SALT311.StrType)le.td_eo),
    Lerg6Main_Fields.InValid_td_at((SALT311.StrType)le.td_at),
    Lerg6Main_Fields.InValid_portable((SALT311.StrType)le.portable),
    Lerg6Main_Fields.InValid_aocn((SALT311.StrType)le.aocn),
    Lerg6Main_Fields.InValid_filler2((SALT311.StrType)le.filler2),
    Lerg6Main_Fields.InValid_ocn((SALT311.StrType)le.ocn),
    Lerg6Main_Fields.InValid_loc_name((SALT311.StrType)le.loc_name),
    Lerg6Main_Fields.InValid_loc((SALT311.StrType)le.loc),
    Lerg6Main_Fields.InValid_loc_state((SALT311.StrType)le.loc_state),
    Lerg6Main_Fields.InValid_rc_abbre((SALT311.StrType)le.rc_abbre),
    Lerg6Main_Fields.InValid_rc_ty((SALT311.StrType)le.rc_ty),
    Lerg6Main_Fields.InValid_line_fr((SALT311.StrType)le.line_fr),
    Lerg6Main_Fields.InValid_line_to((SALT311.StrType)le.line_to),
    Lerg6Main_Fields.InValid_switch((SALT311.StrType)le.switch),
    Lerg6Main_Fields.InValid_sha_indicator((SALT311.StrType)le.sha_indicator),
    Lerg6Main_Fields.InValid_filler3((SALT311.StrType)le.filler3),
    Lerg6Main_Fields.InValid_test_line_num((SALT311.StrType)le.test_line_num),
    Lerg6Main_Fields.InValid_test_line_response((SALT311.StrType)le.test_line_response),
    Lerg6Main_Fields.InValid_test_line_exp_date((SALT311.StrType)le.test_line_exp_date),
    Lerg6Main_Fields.InValid_test_line_exp_time((SALT311.StrType)le.test_line_exp_time),
    Lerg6Main_Fields.InValid_blk_1000_pool((SALT311.StrType)le.blk_1000_pool),
    Lerg6Main_Fields.InValid_rc_lata((SALT311.StrType)le.rc_lata),
    Lerg6Main_Fields.InValid_filler4((SALT311.StrType)le.filler4),
    Lerg6Main_Fields.InValid_creation_date((SALT311.StrType)le.creation_date),
    Lerg6Main_Fields.InValid_creation_time((SALT311.StrType)le.creation_time),
    Lerg6Main_Fields.InValid_filler5((SALT311.StrType)le.filler5),
    Lerg6Main_Fields.InValid_e_status_date((SALT311.StrType)le.e_status_date),
    Lerg6Main_Fields.InValid_e_status_time((SALT311.StrType)le.e_status_time),
    Lerg6Main_Fields.InValid_filler6((SALT311.StrType)le.filler6),
    Lerg6Main_Fields.InValid_last_modified_date((SALT311.StrType)le.last_modified_date),
    Lerg6Main_Fields.InValid_last_modified_time((SALT311.StrType)le.last_modified_time),
    Lerg6Main_Fields.InValid_filler7((SALT311.StrType)le.filler7),
    Lerg6Main_Fields.InValid_is_current((SALT311.StrType)le.is_current),
    Lerg6Main_Fields.InValid_os1((SALT311.StrType)le.os1),
    Lerg6Main_Fields.InValid_os2((SALT311.StrType)le.os2),
    Lerg6Main_Fields.InValid_os3((SALT311.StrType)le.os3),
    Lerg6Main_Fields.InValid_os4((SALT311.StrType)le.os4),
    Lerg6Main_Fields.InValid_os5((SALT311.StrType)le.os5),
    Lerg6Main_Fields.InValid_os6((SALT311.StrType)le.os6),
    Lerg6Main_Fields.InValid_os7((SALT311.StrType)le.os7),
    Lerg6Main_Fields.InValid_os8((SALT311.StrType)le.os8),
    Lerg6Main_Fields.InValid_os9((SALT311.StrType)le.os9),
    Lerg6Main_Fields.InValid_os10((SALT311.StrType)le.os10),
    Lerg6Main_Fields.InValid_os11((SALT311.StrType)le.os11),
    Lerg6Main_Fields.InValid_os12((SALT311.StrType)le.os12),
    Lerg6Main_Fields.InValid_os13((SALT311.StrType)le.os13),
    Lerg6Main_Fields.InValid_os14((SALT311.StrType)le.os14),
    Lerg6Main_Fields.InValid_os15((SALT311.StrType)le.os15),
    Lerg6Main_Fields.InValid_os16((SALT311.StrType)le.os16),
    Lerg6Main_Fields.InValid_os17((SALT311.StrType)le.os17),
    Lerg6Main_Fields.InValid_os18((SALT311.StrType)le.os18),
    Lerg6Main_Fields.InValid_os19((SALT311.StrType)le.os19),
    Lerg6Main_Fields.InValid_os20((SALT311.StrType)le.os20),
    Lerg6Main_Fields.InValid_os21((SALT311.StrType)le.os21),
    Lerg6Main_Fields.InValid_os22((SALT311.StrType)le.os22),
    Lerg6Main_Fields.InValid_os23((SALT311.StrType)le.os23),
    Lerg6Main_Fields.InValid_os24((SALT311.StrType)le.os24),
    Lerg6Main_Fields.InValid_os25((SALT311.StrType)le.os25),
    Lerg6Main_Fields.InValid_notes((SALT311.StrType)le.notes),
    Lerg6Main_Fields.InValid_global_sid((SALT311.StrType)le.global_sid),
    Lerg6Main_Fields.InValid_record_sid((SALT311.StrType)le.record_sid),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,78,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Lerg6Main_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Src','Invalid_Num','Invalid_Alpha','Invalid_StatusCode','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_BlockID','Unknown','Invalid_CocTypeCode','Invalid_SccTypeCode','Invalid_YesNo','Invalid_TdCode','Invalid_TdCode','Invalid_YesNo','Invalid_Char','Unknown','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Alpha','Invalid_Char','Invalid_RcTyCode','Invalid_Num','Invalid_Num','Invalid_Char','Invalid_Num','Unknown','Invalid_Num','Invalid_TestRespCode','Unknown','Unknown','Invalid_TBlockInd','Invalid_Num','Unknown','Invalid_Num','Invalid_Num','Unknown','Invalid_Num','Invalid_Num','Unknown','Invalid_Num','Invalid_Num','Unknown','Unknown','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Unknown','Unknown','Invalid_Num');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Lerg6Main_Fields.InValidMessage_dt_first_reported(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_dt_last_reported(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_dt_start(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_dt_end(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_source(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_lata(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_lata_name(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_status(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_eff_date(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_eff_time(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_npa(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_nxx(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_block_id(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_filler1(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_coc_type(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_ssc(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_dind(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_td_eo(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_td_at(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_portable(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_aocn(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_filler2(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_ocn(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_loc_name(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_loc(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_loc_state(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_rc_abbre(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_rc_ty(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_line_fr(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_line_to(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_switch(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_sha_indicator(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_filler3(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_test_line_num(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_test_line_response(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_test_line_exp_date(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_test_line_exp_time(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_blk_1000_pool(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_rc_lata(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_filler4(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_creation_date(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_creation_time(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_filler5(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_e_status_date(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_e_status_time(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_filler6(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_last_modified_date(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_last_modified_time(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_filler7(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_is_current(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_os1(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_os2(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_os3(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_os4(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_os5(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_os6(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_os7(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_os8(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_os9(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_os10(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_os11(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_os12(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_os13(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_os14(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_os15(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_os16(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_os17(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_os18(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_os19(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_os20(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_os21(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_os22(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_os23(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_os24(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_os25(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_notes(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_global_sid(TotalErrors.ErrorNum),Lerg6Main_Fields.InValidMessage_record_sid(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Phonesinfo, Lerg6Main_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
