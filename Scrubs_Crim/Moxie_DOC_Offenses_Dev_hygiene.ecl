IMPORT SALT311,STD;
EXPORT Moxie_DOC_Offenses_Dev_hygiene(dataset(Moxie_DOC_Offenses_Dev_layout_crim) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := IF(Glob, (TYPEOF(h.vendor))'', MAX(GROUP,h.vendor));
    NumberOfRecords := COUNT(GROUP);
    populated_process_date_cnt := COUNT(GROUP,h.process_date <> (TYPEOF(h.process_date))'');
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_offender_key_cnt := COUNT(GROUP,h.offender_key <> (TYPEOF(h.offender_key))'');
    populated_offender_key_pcnt := AVE(GROUP,IF(h.offender_key = (TYPEOF(h.offender_key))'',0,100));
    maxlength_offender_key := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.offender_key)));
    avelength_offender_key := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.offender_key)),h.offender_key<>(typeof(h.offender_key))'');
    populated_vendor_cnt := COUNT(GROUP,h.vendor <> (TYPEOF(h.vendor))'');
    populated_vendor_pcnt := AVE(GROUP,IF(h.vendor = (TYPEOF(h.vendor))'',0,100));
    maxlength_vendor := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendor)));
    avelength_vendor := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendor)),h.vendor<>(typeof(h.vendor))'');
    populated_county_of_origin_cnt := COUNT(GROUP,h.county_of_origin <> (TYPEOF(h.county_of_origin))'');
    populated_county_of_origin_pcnt := AVE(GROUP,IF(h.county_of_origin = (TYPEOF(h.county_of_origin))'',0,100));
    maxlength_county_of_origin := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.county_of_origin)));
    avelength_county_of_origin := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.county_of_origin)),h.county_of_origin<>(typeof(h.county_of_origin))'');
    populated_source_file_cnt := COUNT(GROUP,h.source_file <> (TYPEOF(h.source_file))'');
    populated_source_file_pcnt := AVE(GROUP,IF(h.source_file = (TYPEOF(h.source_file))'',0,100));
    maxlength_source_file := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_file)));
    avelength_source_file := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_file)),h.source_file<>(typeof(h.source_file))'');
    populated_data_type_cnt := COUNT(GROUP,h.data_type <> (TYPEOF(h.data_type))'');
    populated_data_type_pcnt := AVE(GROUP,IF(h.data_type = (TYPEOF(h.data_type))'',0,100));
    maxlength_data_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.data_type)));
    avelength_data_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.data_type)),h.data_type<>(typeof(h.data_type))'');
    populated_record_type_cnt := COUNT(GROUP,h.record_type <> (TYPEOF(h.record_type))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_orig_state_cnt := COUNT(GROUP,h.orig_state <> (TYPEOF(h.orig_state))'');
    populated_orig_state_pcnt := AVE(GROUP,IF(h.orig_state = (TYPEOF(h.orig_state))'',0,100));
    maxlength_orig_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_state)));
    avelength_orig_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_state)),h.orig_state<>(typeof(h.orig_state))'');
    populated_offense_key_cnt := COUNT(GROUP,h.offense_key <> (TYPEOF(h.offense_key))'');
    populated_offense_key_pcnt := AVE(GROUP,IF(h.offense_key = (TYPEOF(h.offense_key))'',0,100));
    maxlength_offense_key := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.offense_key)));
    avelength_offense_key := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.offense_key)),h.offense_key<>(typeof(h.offense_key))'');
    populated_off_date_cnt := COUNT(GROUP,h.off_date <> (TYPEOF(h.off_date))'');
    populated_off_date_pcnt := AVE(GROUP,IF(h.off_date = (TYPEOF(h.off_date))'',0,100));
    maxlength_off_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.off_date)));
    avelength_off_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.off_date)),h.off_date<>(typeof(h.off_date))'');
    populated_arr_date_cnt := COUNT(GROUP,h.arr_date <> (TYPEOF(h.arr_date))'');
    populated_arr_date_pcnt := AVE(GROUP,IF(h.arr_date = (TYPEOF(h.arr_date))'',0,100));
    maxlength_arr_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.arr_date)));
    avelength_arr_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.arr_date)),h.arr_date<>(typeof(h.arr_date))'');
    populated_case_num_cnt := COUNT(GROUP,h.case_num <> (TYPEOF(h.case_num))'');
    populated_case_num_pcnt := AVE(GROUP,IF(h.case_num = (TYPEOF(h.case_num))'',0,100));
    maxlength_case_num := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.case_num)));
    avelength_case_num := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.case_num)),h.case_num<>(typeof(h.case_num))'');
    populated_total_num_of_offenses_cnt := COUNT(GROUP,h.total_num_of_offenses <> (TYPEOF(h.total_num_of_offenses))'');
    populated_total_num_of_offenses_pcnt := AVE(GROUP,IF(h.total_num_of_offenses = (TYPEOF(h.total_num_of_offenses))'',0,100));
    maxlength_total_num_of_offenses := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_num_of_offenses)));
    avelength_total_num_of_offenses := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_num_of_offenses)),h.total_num_of_offenses<>(typeof(h.total_num_of_offenses))'');
    populated_num_of_counts_cnt := COUNT(GROUP,h.num_of_counts <> (TYPEOF(h.num_of_counts))'');
    populated_num_of_counts_pcnt := AVE(GROUP,IF(h.num_of_counts = (TYPEOF(h.num_of_counts))'',0,100));
    maxlength_num_of_counts := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.num_of_counts)));
    avelength_num_of_counts := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.num_of_counts)),h.num_of_counts<>(typeof(h.num_of_counts))'');
    populated_off_code_cnt := COUNT(GROUP,h.off_code <> (TYPEOF(h.off_code))'');
    populated_off_code_pcnt := AVE(GROUP,IF(h.off_code = (TYPEOF(h.off_code))'',0,100));
    maxlength_off_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.off_code)));
    avelength_off_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.off_code)),h.off_code<>(typeof(h.off_code))'');
    populated_chg_cnt := COUNT(GROUP,h.chg <> (TYPEOF(h.chg))'');
    populated_chg_pcnt := AVE(GROUP,IF(h.chg = (TYPEOF(h.chg))'',0,100));
    maxlength_chg := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.chg)));
    avelength_chg := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.chg)),h.chg<>(typeof(h.chg))'');
    populated_chg_typ_flg_cnt := COUNT(GROUP,h.chg_typ_flg <> (TYPEOF(h.chg_typ_flg))'');
    populated_chg_typ_flg_pcnt := AVE(GROUP,IF(h.chg_typ_flg = (TYPEOF(h.chg_typ_flg))'',0,100));
    maxlength_chg_typ_flg := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.chg_typ_flg)));
    avelength_chg_typ_flg := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.chg_typ_flg)),h.chg_typ_flg<>(typeof(h.chg_typ_flg))'');
    populated_off_of_record_cnt := COUNT(GROUP,h.off_of_record <> (TYPEOF(h.off_of_record))'');
    populated_off_of_record_pcnt := AVE(GROUP,IF(h.off_of_record = (TYPEOF(h.off_of_record))'',0,100));
    maxlength_off_of_record := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.off_of_record)));
    avelength_off_of_record := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.off_of_record)),h.off_of_record<>(typeof(h.off_of_record))'');
    populated_off_desc_1_cnt := COUNT(GROUP,h.off_desc_1 <> (TYPEOF(h.off_desc_1))'');
    populated_off_desc_1_pcnt := AVE(GROUP,IF(h.off_desc_1 = (TYPEOF(h.off_desc_1))'',0,100));
    maxlength_off_desc_1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.off_desc_1)));
    avelength_off_desc_1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.off_desc_1)),h.off_desc_1<>(typeof(h.off_desc_1))'');
    populated_off_desc_2_cnt := COUNT(GROUP,h.off_desc_2 <> (TYPEOF(h.off_desc_2))'');
    populated_off_desc_2_pcnt := AVE(GROUP,IF(h.off_desc_2 = (TYPEOF(h.off_desc_2))'',0,100));
    maxlength_off_desc_2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.off_desc_2)));
    avelength_off_desc_2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.off_desc_2)),h.off_desc_2<>(typeof(h.off_desc_2))'');
    populated_add_off_cd_cnt := COUNT(GROUP,h.add_off_cd <> (TYPEOF(h.add_off_cd))'');
    populated_add_off_cd_pcnt := AVE(GROUP,IF(h.add_off_cd = (TYPEOF(h.add_off_cd))'',0,100));
    maxlength_add_off_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.add_off_cd)));
    avelength_add_off_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.add_off_cd)),h.add_off_cd<>(typeof(h.add_off_cd))'');
    populated_add_off_desc_cnt := COUNT(GROUP,h.add_off_desc <> (TYPEOF(h.add_off_desc))'');
    populated_add_off_desc_pcnt := AVE(GROUP,IF(h.add_off_desc = (TYPEOF(h.add_off_desc))'',0,100));
    maxlength_add_off_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.add_off_desc)));
    avelength_add_off_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.add_off_desc)),h.add_off_desc<>(typeof(h.add_off_desc))'');
    populated_off_typ_cnt := COUNT(GROUP,h.off_typ <> (TYPEOF(h.off_typ))'');
    populated_off_typ_pcnt := AVE(GROUP,IF(h.off_typ = (TYPEOF(h.off_typ))'',0,100));
    maxlength_off_typ := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.off_typ)));
    avelength_off_typ := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.off_typ)),h.off_typ<>(typeof(h.off_typ))'');
    populated_off_lev_cnt := COUNT(GROUP,h.off_lev <> (TYPEOF(h.off_lev))'');
    populated_off_lev_pcnt := AVE(GROUP,IF(h.off_lev = (TYPEOF(h.off_lev))'',0,100));
    maxlength_off_lev := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.off_lev)));
    avelength_off_lev := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.off_lev)),h.off_lev<>(typeof(h.off_lev))'');
    populated_arr_disp_date_cnt := COUNT(GROUP,h.arr_disp_date <> (TYPEOF(h.arr_disp_date))'');
    populated_arr_disp_date_pcnt := AVE(GROUP,IF(h.arr_disp_date = (TYPEOF(h.arr_disp_date))'',0,100));
    maxlength_arr_disp_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.arr_disp_date)));
    avelength_arr_disp_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.arr_disp_date)),h.arr_disp_date<>(typeof(h.arr_disp_date))'');
    populated_arr_disp_cd_cnt := COUNT(GROUP,h.arr_disp_cd <> (TYPEOF(h.arr_disp_cd))'');
    populated_arr_disp_cd_pcnt := AVE(GROUP,IF(h.arr_disp_cd = (TYPEOF(h.arr_disp_cd))'',0,100));
    maxlength_arr_disp_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.arr_disp_cd)));
    avelength_arr_disp_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.arr_disp_cd)),h.arr_disp_cd<>(typeof(h.arr_disp_cd))'');
    populated_arr_disp_desc_1_cnt := COUNT(GROUP,h.arr_disp_desc_1 <> (TYPEOF(h.arr_disp_desc_1))'');
    populated_arr_disp_desc_1_pcnt := AVE(GROUP,IF(h.arr_disp_desc_1 = (TYPEOF(h.arr_disp_desc_1))'',0,100));
    maxlength_arr_disp_desc_1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.arr_disp_desc_1)));
    avelength_arr_disp_desc_1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.arr_disp_desc_1)),h.arr_disp_desc_1<>(typeof(h.arr_disp_desc_1))'');
    populated_arr_disp_desc_2_cnt := COUNT(GROUP,h.arr_disp_desc_2 <> (TYPEOF(h.arr_disp_desc_2))'');
    populated_arr_disp_desc_2_pcnt := AVE(GROUP,IF(h.arr_disp_desc_2 = (TYPEOF(h.arr_disp_desc_2))'',0,100));
    maxlength_arr_disp_desc_2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.arr_disp_desc_2)));
    avelength_arr_disp_desc_2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.arr_disp_desc_2)),h.arr_disp_desc_2<>(typeof(h.arr_disp_desc_2))'');
    populated_arr_disp_desc_3_cnt := COUNT(GROUP,h.arr_disp_desc_3 <> (TYPEOF(h.arr_disp_desc_3))'');
    populated_arr_disp_desc_3_pcnt := AVE(GROUP,IF(h.arr_disp_desc_3 = (TYPEOF(h.arr_disp_desc_3))'',0,100));
    maxlength_arr_disp_desc_3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.arr_disp_desc_3)));
    avelength_arr_disp_desc_3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.arr_disp_desc_3)),h.arr_disp_desc_3<>(typeof(h.arr_disp_desc_3))'');
    populated_court_cd_cnt := COUNT(GROUP,h.court_cd <> (TYPEOF(h.court_cd))'');
    populated_court_cd_pcnt := AVE(GROUP,IF(h.court_cd = (TYPEOF(h.court_cd))'',0,100));
    maxlength_court_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_cd)));
    avelength_court_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_cd)),h.court_cd<>(typeof(h.court_cd))'');
    populated_court_desc_cnt := COUNT(GROUP,h.court_desc <> (TYPEOF(h.court_desc))'');
    populated_court_desc_pcnt := AVE(GROUP,IF(h.court_desc = (TYPEOF(h.court_desc))'',0,100));
    maxlength_court_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_desc)));
    avelength_court_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_desc)),h.court_desc<>(typeof(h.court_desc))'');
    populated_ct_dist_cnt := COUNT(GROUP,h.ct_dist <> (TYPEOF(h.ct_dist))'');
    populated_ct_dist_pcnt := AVE(GROUP,IF(h.ct_dist = (TYPEOF(h.ct_dist))'',0,100));
    maxlength_ct_dist := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ct_dist)));
    avelength_ct_dist := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ct_dist)),h.ct_dist<>(typeof(h.ct_dist))'');
    populated_ct_fnl_plea_cd_cnt := COUNT(GROUP,h.ct_fnl_plea_cd <> (TYPEOF(h.ct_fnl_plea_cd))'');
    populated_ct_fnl_plea_cd_pcnt := AVE(GROUP,IF(h.ct_fnl_plea_cd = (TYPEOF(h.ct_fnl_plea_cd))'',0,100));
    maxlength_ct_fnl_plea_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ct_fnl_plea_cd)));
    avelength_ct_fnl_plea_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ct_fnl_plea_cd)),h.ct_fnl_plea_cd<>(typeof(h.ct_fnl_plea_cd))'');
    populated_ct_fnl_plea_cnt := COUNT(GROUP,h.ct_fnl_plea <> (TYPEOF(h.ct_fnl_plea))'');
    populated_ct_fnl_plea_pcnt := AVE(GROUP,IF(h.ct_fnl_plea = (TYPEOF(h.ct_fnl_plea))'',0,100));
    maxlength_ct_fnl_plea := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ct_fnl_plea)));
    avelength_ct_fnl_plea := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ct_fnl_plea)),h.ct_fnl_plea<>(typeof(h.ct_fnl_plea))'');
    populated_ct_off_code_cnt := COUNT(GROUP,h.ct_off_code <> (TYPEOF(h.ct_off_code))'');
    populated_ct_off_code_pcnt := AVE(GROUP,IF(h.ct_off_code = (TYPEOF(h.ct_off_code))'',0,100));
    maxlength_ct_off_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ct_off_code)));
    avelength_ct_off_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ct_off_code)),h.ct_off_code<>(typeof(h.ct_off_code))'');
    populated_ct_chg_cnt := COUNT(GROUP,h.ct_chg <> (TYPEOF(h.ct_chg))'');
    populated_ct_chg_pcnt := AVE(GROUP,IF(h.ct_chg = (TYPEOF(h.ct_chg))'',0,100));
    maxlength_ct_chg := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ct_chg)));
    avelength_ct_chg := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ct_chg)),h.ct_chg<>(typeof(h.ct_chg))'');
    populated_ct_chg_typ_flg_cnt := COUNT(GROUP,h.ct_chg_typ_flg <> (TYPEOF(h.ct_chg_typ_flg))'');
    populated_ct_chg_typ_flg_pcnt := AVE(GROUP,IF(h.ct_chg_typ_flg = (TYPEOF(h.ct_chg_typ_flg))'',0,100));
    maxlength_ct_chg_typ_flg := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ct_chg_typ_flg)));
    avelength_ct_chg_typ_flg := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ct_chg_typ_flg)),h.ct_chg_typ_flg<>(typeof(h.ct_chg_typ_flg))'');
    populated_ct_off_desc_1_cnt := COUNT(GROUP,h.ct_off_desc_1 <> (TYPEOF(h.ct_off_desc_1))'');
    populated_ct_off_desc_1_pcnt := AVE(GROUP,IF(h.ct_off_desc_1 = (TYPEOF(h.ct_off_desc_1))'',0,100));
    maxlength_ct_off_desc_1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ct_off_desc_1)));
    avelength_ct_off_desc_1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ct_off_desc_1)),h.ct_off_desc_1<>(typeof(h.ct_off_desc_1))'');
    populated_ct_off_desc_2_cnt := COUNT(GROUP,h.ct_off_desc_2 <> (TYPEOF(h.ct_off_desc_2))'');
    populated_ct_off_desc_2_pcnt := AVE(GROUP,IF(h.ct_off_desc_2 = (TYPEOF(h.ct_off_desc_2))'',0,100));
    maxlength_ct_off_desc_2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ct_off_desc_2)));
    avelength_ct_off_desc_2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ct_off_desc_2)),h.ct_off_desc_2<>(typeof(h.ct_off_desc_2))'');
    populated_ct_addl_desc_cd_cnt := COUNT(GROUP,h.ct_addl_desc_cd <> (TYPEOF(h.ct_addl_desc_cd))'');
    populated_ct_addl_desc_cd_pcnt := AVE(GROUP,IF(h.ct_addl_desc_cd = (TYPEOF(h.ct_addl_desc_cd))'',0,100));
    maxlength_ct_addl_desc_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ct_addl_desc_cd)));
    avelength_ct_addl_desc_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ct_addl_desc_cd)),h.ct_addl_desc_cd<>(typeof(h.ct_addl_desc_cd))'');
    populated_ct_off_lev_cnt := COUNT(GROUP,h.ct_off_lev <> (TYPEOF(h.ct_off_lev))'');
    populated_ct_off_lev_pcnt := AVE(GROUP,IF(h.ct_off_lev = (TYPEOF(h.ct_off_lev))'',0,100));
    maxlength_ct_off_lev := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ct_off_lev)));
    avelength_ct_off_lev := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ct_off_lev)),h.ct_off_lev<>(typeof(h.ct_off_lev))'');
    populated_ct_disp_dt_cnt := COUNT(GROUP,h.ct_disp_dt <> (TYPEOF(h.ct_disp_dt))'');
    populated_ct_disp_dt_pcnt := AVE(GROUP,IF(h.ct_disp_dt = (TYPEOF(h.ct_disp_dt))'',0,100));
    maxlength_ct_disp_dt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ct_disp_dt)));
    avelength_ct_disp_dt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ct_disp_dt)),h.ct_disp_dt<>(typeof(h.ct_disp_dt))'');
    populated_ct_disp_cd_cnt := COUNT(GROUP,h.ct_disp_cd <> (TYPEOF(h.ct_disp_cd))'');
    populated_ct_disp_cd_pcnt := AVE(GROUP,IF(h.ct_disp_cd = (TYPEOF(h.ct_disp_cd))'',0,100));
    maxlength_ct_disp_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ct_disp_cd)));
    avelength_ct_disp_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ct_disp_cd)),h.ct_disp_cd<>(typeof(h.ct_disp_cd))'');
    populated_ct_disp_desc_1_cnt := COUNT(GROUP,h.ct_disp_desc_1 <> (TYPEOF(h.ct_disp_desc_1))'');
    populated_ct_disp_desc_1_pcnt := AVE(GROUP,IF(h.ct_disp_desc_1 = (TYPEOF(h.ct_disp_desc_1))'',0,100));
    maxlength_ct_disp_desc_1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ct_disp_desc_1)));
    avelength_ct_disp_desc_1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ct_disp_desc_1)),h.ct_disp_desc_1<>(typeof(h.ct_disp_desc_1))'');
    populated_ct_disp_desc_2_cnt := COUNT(GROUP,h.ct_disp_desc_2 <> (TYPEOF(h.ct_disp_desc_2))'');
    populated_ct_disp_desc_2_pcnt := AVE(GROUP,IF(h.ct_disp_desc_2 = (TYPEOF(h.ct_disp_desc_2))'',0,100));
    maxlength_ct_disp_desc_2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ct_disp_desc_2)));
    avelength_ct_disp_desc_2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ct_disp_desc_2)),h.ct_disp_desc_2<>(typeof(h.ct_disp_desc_2))'');
    populated_cty_conv_cd_cnt := COUNT(GROUP,h.cty_conv_cd <> (TYPEOF(h.cty_conv_cd))'');
    populated_cty_conv_cd_pcnt := AVE(GROUP,IF(h.cty_conv_cd = (TYPEOF(h.cty_conv_cd))'',0,100));
    maxlength_cty_conv_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cty_conv_cd)));
    avelength_cty_conv_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cty_conv_cd)),h.cty_conv_cd<>(typeof(h.cty_conv_cd))'');
    populated_cty_conv_cnt := COUNT(GROUP,h.cty_conv <> (TYPEOF(h.cty_conv))'');
    populated_cty_conv_pcnt := AVE(GROUP,IF(h.cty_conv = (TYPEOF(h.cty_conv))'',0,100));
    maxlength_cty_conv := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cty_conv)));
    avelength_cty_conv := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cty_conv)),h.cty_conv<>(typeof(h.cty_conv))'');
    populated_adj_wthd_cnt := COUNT(GROUP,h.adj_wthd <> (TYPEOF(h.adj_wthd))'');
    populated_adj_wthd_pcnt := AVE(GROUP,IF(h.adj_wthd = (TYPEOF(h.adj_wthd))'',0,100));
    maxlength_adj_wthd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.adj_wthd)));
    avelength_adj_wthd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.adj_wthd)),h.adj_wthd<>(typeof(h.adj_wthd))'');
    populated_stc_dt_cnt := COUNT(GROUP,h.stc_dt <> (TYPEOF(h.stc_dt))'');
    populated_stc_dt_pcnt := AVE(GROUP,IF(h.stc_dt = (TYPEOF(h.stc_dt))'',0,100));
    maxlength_stc_dt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.stc_dt)));
    avelength_stc_dt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.stc_dt)),h.stc_dt<>(typeof(h.stc_dt))'');
    populated_stc_cd_cnt := COUNT(GROUP,h.stc_cd <> (TYPEOF(h.stc_cd))'');
    populated_stc_cd_pcnt := AVE(GROUP,IF(h.stc_cd = (TYPEOF(h.stc_cd))'',0,100));
    maxlength_stc_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.stc_cd)));
    avelength_stc_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.stc_cd)),h.stc_cd<>(typeof(h.stc_cd))'');
    populated_stc_comp_cnt := COUNT(GROUP,h.stc_comp <> (TYPEOF(h.stc_comp))'');
    populated_stc_comp_pcnt := AVE(GROUP,IF(h.stc_comp = (TYPEOF(h.stc_comp))'',0,100));
    maxlength_stc_comp := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.stc_comp)));
    avelength_stc_comp := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.stc_comp)),h.stc_comp<>(typeof(h.stc_comp))'');
    populated_stc_desc_1_cnt := COUNT(GROUP,h.stc_desc_1 <> (TYPEOF(h.stc_desc_1))'');
    populated_stc_desc_1_pcnt := AVE(GROUP,IF(h.stc_desc_1 = (TYPEOF(h.stc_desc_1))'',0,100));
    maxlength_stc_desc_1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.stc_desc_1)));
    avelength_stc_desc_1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.stc_desc_1)),h.stc_desc_1<>(typeof(h.stc_desc_1))'');
    populated_stc_desc_2_cnt := COUNT(GROUP,h.stc_desc_2 <> (TYPEOF(h.stc_desc_2))'');
    populated_stc_desc_2_pcnt := AVE(GROUP,IF(h.stc_desc_2 = (TYPEOF(h.stc_desc_2))'',0,100));
    maxlength_stc_desc_2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.stc_desc_2)));
    avelength_stc_desc_2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.stc_desc_2)),h.stc_desc_2<>(typeof(h.stc_desc_2))'');
    populated_stc_desc_3_cnt := COUNT(GROUP,h.stc_desc_3 <> (TYPEOF(h.stc_desc_3))'');
    populated_stc_desc_3_pcnt := AVE(GROUP,IF(h.stc_desc_3 = (TYPEOF(h.stc_desc_3))'',0,100));
    maxlength_stc_desc_3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.stc_desc_3)));
    avelength_stc_desc_3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.stc_desc_3)),h.stc_desc_3<>(typeof(h.stc_desc_3))'');
    populated_stc_desc_4_cnt := COUNT(GROUP,h.stc_desc_4 <> (TYPEOF(h.stc_desc_4))'');
    populated_stc_desc_4_pcnt := AVE(GROUP,IF(h.stc_desc_4 = (TYPEOF(h.stc_desc_4))'',0,100));
    maxlength_stc_desc_4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.stc_desc_4)));
    avelength_stc_desc_4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.stc_desc_4)),h.stc_desc_4<>(typeof(h.stc_desc_4))'');
    populated_stc_lgth_cnt := COUNT(GROUP,h.stc_lgth <> (TYPEOF(h.stc_lgth))'');
    populated_stc_lgth_pcnt := AVE(GROUP,IF(h.stc_lgth = (TYPEOF(h.stc_lgth))'',0,100));
    maxlength_stc_lgth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.stc_lgth)));
    avelength_stc_lgth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.stc_lgth)),h.stc_lgth<>(typeof(h.stc_lgth))'');
    populated_stc_lgth_desc_cnt := COUNT(GROUP,h.stc_lgth_desc <> (TYPEOF(h.stc_lgth_desc))'');
    populated_stc_lgth_desc_pcnt := AVE(GROUP,IF(h.stc_lgth_desc = (TYPEOF(h.stc_lgth_desc))'',0,100));
    maxlength_stc_lgth_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.stc_lgth_desc)));
    avelength_stc_lgth_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.stc_lgth_desc)),h.stc_lgth_desc<>(typeof(h.stc_lgth_desc))'');
    populated_inc_adm_dt_cnt := COUNT(GROUP,h.inc_adm_dt <> (TYPEOF(h.inc_adm_dt))'');
    populated_inc_adm_dt_pcnt := AVE(GROUP,IF(h.inc_adm_dt = (TYPEOF(h.inc_adm_dt))'',0,100));
    maxlength_inc_adm_dt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.inc_adm_dt)));
    avelength_inc_adm_dt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.inc_adm_dt)),h.inc_adm_dt<>(typeof(h.inc_adm_dt))'');
    populated_min_term_cnt := COUNT(GROUP,h.min_term <> (TYPEOF(h.min_term))'');
    populated_min_term_pcnt := AVE(GROUP,IF(h.min_term = (TYPEOF(h.min_term))'',0,100));
    maxlength_min_term := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.min_term)));
    avelength_min_term := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.min_term)),h.min_term<>(typeof(h.min_term))'');
    populated_min_term_desc_cnt := COUNT(GROUP,h.min_term_desc <> (TYPEOF(h.min_term_desc))'');
    populated_min_term_desc_pcnt := AVE(GROUP,IF(h.min_term_desc = (TYPEOF(h.min_term_desc))'',0,100));
    maxlength_min_term_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.min_term_desc)));
    avelength_min_term_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.min_term_desc)),h.min_term_desc<>(typeof(h.min_term_desc))'');
    populated_max_term_cnt := COUNT(GROUP,h.max_term <> (TYPEOF(h.max_term))'');
    populated_max_term_pcnt := AVE(GROUP,IF(h.max_term = (TYPEOF(h.max_term))'',0,100));
    maxlength_max_term := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.max_term)));
    avelength_max_term := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.max_term)),h.max_term<>(typeof(h.max_term))'');
    populated_max_term_desc_cnt := COUNT(GROUP,h.max_term_desc <> (TYPEOF(h.max_term_desc))'');
    populated_max_term_desc_pcnt := AVE(GROUP,IF(h.max_term_desc = (TYPEOF(h.max_term_desc))'',0,100));
    maxlength_max_term_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.max_term_desc)));
    avelength_max_term_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.max_term_desc)),h.max_term_desc<>(typeof(h.max_term_desc))'');
    populated_parole_cnt := COUNT(GROUP,h.parole <> (TYPEOF(h.parole))'');
    populated_parole_pcnt := AVE(GROUP,IF(h.parole = (TYPEOF(h.parole))'',0,100));
    maxlength_parole := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.parole)));
    avelength_parole := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.parole)),h.parole<>(typeof(h.parole))'');
    populated_probation_cnt := COUNT(GROUP,h.probation <> (TYPEOF(h.probation))'');
    populated_probation_pcnt := AVE(GROUP,IF(h.probation = (TYPEOF(h.probation))'',0,100));
    maxlength_probation := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.probation)));
    avelength_probation := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.probation)),h.probation<>(typeof(h.probation))'');
    populated_offensetown_cnt := COUNT(GROUP,h.offensetown <> (TYPEOF(h.offensetown))'');
    populated_offensetown_pcnt := AVE(GROUP,IF(h.offensetown = (TYPEOF(h.offensetown))'',0,100));
    maxlength_offensetown := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.offensetown)));
    avelength_offensetown := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.offensetown)),h.offensetown<>(typeof(h.offensetown))'');
    populated_convict_dt_cnt := COUNT(GROUP,h.convict_dt <> (TYPEOF(h.convict_dt))'');
    populated_convict_dt_pcnt := AVE(GROUP,IF(h.convict_dt = (TYPEOF(h.convict_dt))'',0,100));
    maxlength_convict_dt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.convict_dt)));
    avelength_convict_dt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.convict_dt)),h.convict_dt<>(typeof(h.convict_dt))'');
    populated_court_county_cnt := COUNT(GROUP,h.court_county <> (TYPEOF(h.court_county))'');
    populated_court_county_pcnt := AVE(GROUP,IF(h.court_county = (TYPEOF(h.court_county))'',0,100));
    maxlength_court_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_county)));
    avelength_court_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_county)),h.court_county<>(typeof(h.court_county))'');
    populated_fcra_offense_key_cnt := COUNT(GROUP,h.fcra_offense_key <> (TYPEOF(h.fcra_offense_key))'');
    populated_fcra_offense_key_pcnt := AVE(GROUP,IF(h.fcra_offense_key = (TYPEOF(h.fcra_offense_key))'',0,100));
    maxlength_fcra_offense_key := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fcra_offense_key)));
    avelength_fcra_offense_key := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fcra_offense_key)),h.fcra_offense_key<>(typeof(h.fcra_offense_key))'');
    populated_fcra_conviction_flag_cnt := COUNT(GROUP,h.fcra_conviction_flag <> (TYPEOF(h.fcra_conviction_flag))'');
    populated_fcra_conviction_flag_pcnt := AVE(GROUP,IF(h.fcra_conviction_flag = (TYPEOF(h.fcra_conviction_flag))'',0,100));
    maxlength_fcra_conviction_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fcra_conviction_flag)));
    avelength_fcra_conviction_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fcra_conviction_flag)),h.fcra_conviction_flag<>(typeof(h.fcra_conviction_flag))'');
    populated_fcra_traffic_flag_cnt := COUNT(GROUP,h.fcra_traffic_flag <> (TYPEOF(h.fcra_traffic_flag))'');
    populated_fcra_traffic_flag_pcnt := AVE(GROUP,IF(h.fcra_traffic_flag = (TYPEOF(h.fcra_traffic_flag))'',0,100));
    maxlength_fcra_traffic_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fcra_traffic_flag)));
    avelength_fcra_traffic_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fcra_traffic_flag)),h.fcra_traffic_flag<>(typeof(h.fcra_traffic_flag))'');
    populated_fcra_date_cnt := COUNT(GROUP,h.fcra_date <> (TYPEOF(h.fcra_date))'');
    populated_fcra_date_pcnt := AVE(GROUP,IF(h.fcra_date = (TYPEOF(h.fcra_date))'',0,100));
    maxlength_fcra_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fcra_date)));
    avelength_fcra_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fcra_date)),h.fcra_date<>(typeof(h.fcra_date))'');
    populated_fcra_date_type_cnt := COUNT(GROUP,h.fcra_date_type <> (TYPEOF(h.fcra_date_type))'');
    populated_fcra_date_type_pcnt := AVE(GROUP,IF(h.fcra_date_type = (TYPEOF(h.fcra_date_type))'',0,100));
    maxlength_fcra_date_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fcra_date_type)));
    avelength_fcra_date_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fcra_date_type)),h.fcra_date_type<>(typeof(h.fcra_date_type))'');
    populated_conviction_override_date_cnt := COUNT(GROUP,h.conviction_override_date <> (TYPEOF(h.conviction_override_date))'');
    populated_conviction_override_date_pcnt := AVE(GROUP,IF(h.conviction_override_date = (TYPEOF(h.conviction_override_date))'',0,100));
    maxlength_conviction_override_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.conviction_override_date)));
    avelength_conviction_override_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.conviction_override_date)),h.conviction_override_date<>(typeof(h.conviction_override_date))'');
    populated_conviction_override_date_type_cnt := COUNT(GROUP,h.conviction_override_date_type <> (TYPEOF(h.conviction_override_date_type))'');
    populated_conviction_override_date_type_pcnt := AVE(GROUP,IF(h.conviction_override_date_type = (TYPEOF(h.conviction_override_date_type))'',0,100));
    maxlength_conviction_override_date_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.conviction_override_date_type)));
    avelength_conviction_override_date_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.conviction_override_date_type)),h.conviction_override_date_type<>(typeof(h.conviction_override_date_type))'');
    populated_offense_score_cnt := COUNT(GROUP,h.offense_score <> (TYPEOF(h.offense_score))'');
    populated_offense_score_pcnt := AVE(GROUP,IF(h.offense_score = (TYPEOF(h.offense_score))'',0,100));
    maxlength_offense_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.offense_score)));
    avelength_offense_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.offense_score)),h.offense_score<>(typeof(h.offense_score))'');
    populated_offense_persistent_id_cnt := COUNT(GROUP,h.offense_persistent_id <> (TYPEOF(h.offense_persistent_id))'');
    populated_offense_persistent_id_pcnt := AVE(GROUP,IF(h.offense_persistent_id = (TYPEOF(h.offense_persistent_id))'',0,100));
    maxlength_offense_persistent_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.offense_persistent_id)));
    avelength_offense_persistent_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.offense_persistent_id)),h.offense_persistent_id<>(typeof(h.offense_persistent_id))'');
    populated_offense_category_cnt := COUNT(GROUP,h.offense_category <> (TYPEOF(h.offense_category))'');
    populated_offense_category_pcnt := AVE(GROUP,IF(h.offense_category = (TYPEOF(h.offense_category))'',0,100));
    maxlength_offense_category := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.offense_category)));
    avelength_offense_category := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.offense_category)),h.offense_category<>(typeof(h.offense_category))'');
    populated_hyg_classification_code_cnt := COUNT(GROUP,h.hyg_classification_code <> (TYPEOF(h.hyg_classification_code))'');
    populated_hyg_classification_code_pcnt := AVE(GROUP,IF(h.hyg_classification_code = (TYPEOF(h.hyg_classification_code))'',0,100));
    maxlength_hyg_classification_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hyg_classification_code)));
    avelength_hyg_classification_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hyg_classification_code)),h.hyg_classification_code<>(typeof(h.hyg_classification_code))'');
    populated_old_ln_offense_score_cnt := COUNT(GROUP,h.old_ln_offense_score <> (TYPEOF(h.old_ln_offense_score))'');
    populated_old_ln_offense_score_pcnt := AVE(GROUP,IF(h.old_ln_offense_score = (TYPEOF(h.old_ln_offense_score))'',0,100));
    maxlength_old_ln_offense_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.old_ln_offense_score)));
    avelength_old_ln_offense_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.old_ln_offense_score)),h.old_ln_offense_score<>(typeof(h.old_ln_offense_score))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,vendor,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_offender_key_pcnt *   0.00 / 100 + T.Populated_vendor_pcnt *   0.00 / 100 + T.Populated_county_of_origin_pcnt *   0.00 / 100 + T.Populated_source_file_pcnt *   0.00 / 100 + T.Populated_data_type_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_orig_state_pcnt *   0.00 / 100 + T.Populated_offense_key_pcnt *   0.00 / 100 + T.Populated_off_date_pcnt *   0.00 / 100 + T.Populated_arr_date_pcnt *   0.00 / 100 + T.Populated_case_num_pcnt *   0.00 / 100 + T.Populated_total_num_of_offenses_pcnt *   0.00 / 100 + T.Populated_num_of_counts_pcnt *   0.00 / 100 + T.Populated_off_code_pcnt *   0.00 / 100 + T.Populated_chg_pcnt *   0.00 / 100 + T.Populated_chg_typ_flg_pcnt *   0.00 / 100 + T.Populated_off_of_record_pcnt *   0.00 / 100 + T.Populated_off_desc_1_pcnt *   0.00 / 100 + T.Populated_off_desc_2_pcnt *   0.00 / 100 + T.Populated_add_off_cd_pcnt *   0.00 / 100 + T.Populated_add_off_desc_pcnt *   0.00 / 100 + T.Populated_off_typ_pcnt *   0.00 / 100 + T.Populated_off_lev_pcnt *   0.00 / 100 + T.Populated_arr_disp_date_pcnt *   0.00 / 100 + T.Populated_arr_disp_cd_pcnt *   0.00 / 100 + T.Populated_arr_disp_desc_1_pcnt *   0.00 / 100 + T.Populated_arr_disp_desc_2_pcnt *   0.00 / 100 + T.Populated_arr_disp_desc_3_pcnt *   0.00 / 100 + T.Populated_court_cd_pcnt *   0.00 / 100 + T.Populated_court_desc_pcnt *   0.00 / 100 + T.Populated_ct_dist_pcnt *   0.00 / 100 + T.Populated_ct_fnl_plea_cd_pcnt *   0.00 / 100 + T.Populated_ct_fnl_plea_pcnt *   0.00 / 100 + T.Populated_ct_off_code_pcnt *   0.00 / 100 + T.Populated_ct_chg_pcnt *   0.00 / 100 + T.Populated_ct_chg_typ_flg_pcnt *   0.00 / 100 + T.Populated_ct_off_desc_1_pcnt *   0.00 / 100 + T.Populated_ct_off_desc_2_pcnt *   0.00 / 100 + T.Populated_ct_addl_desc_cd_pcnt *   0.00 / 100 + T.Populated_ct_off_lev_pcnt *   0.00 / 100 + T.Populated_ct_disp_dt_pcnt *   0.00 / 100 + T.Populated_ct_disp_cd_pcnt *   0.00 / 100 + T.Populated_ct_disp_desc_1_pcnt *   0.00 / 100 + T.Populated_ct_disp_desc_2_pcnt *   0.00 / 100 + T.Populated_cty_conv_cd_pcnt *   0.00 / 100 + T.Populated_cty_conv_pcnt *   0.00 / 100 + T.Populated_adj_wthd_pcnt *   0.00 / 100 + T.Populated_stc_dt_pcnt *   0.00 / 100 + T.Populated_stc_cd_pcnt *   0.00 / 100 + T.Populated_stc_comp_pcnt *   0.00 / 100 + T.Populated_stc_desc_1_pcnt *   0.00 / 100 + T.Populated_stc_desc_2_pcnt *   0.00 / 100 + T.Populated_stc_desc_3_pcnt *   0.00 / 100 + T.Populated_stc_desc_4_pcnt *   0.00 / 100 + T.Populated_stc_lgth_pcnt *   0.00 / 100 + T.Populated_stc_lgth_desc_pcnt *   0.00 / 100 + T.Populated_inc_adm_dt_pcnt *   0.00 / 100 + T.Populated_min_term_pcnt *   0.00 / 100 + T.Populated_min_term_desc_pcnt *   0.00 / 100 + T.Populated_max_term_pcnt *   0.00 / 100 + T.Populated_max_term_desc_pcnt *   0.00 / 100 + T.Populated_parole_pcnt *   0.00 / 100 + T.Populated_probation_pcnt *   0.00 / 100 + T.Populated_offensetown_pcnt *   0.00 / 100 + T.Populated_convict_dt_pcnt *   0.00 / 100 + T.Populated_court_county_pcnt *   0.00 / 100 + T.Populated_fcra_offense_key_pcnt *   0.00 / 100 + T.Populated_fcra_conviction_flag_pcnt *   0.00 / 100 + T.Populated_fcra_traffic_flag_pcnt *   0.00 / 100 + T.Populated_fcra_date_pcnt *   0.00 / 100 + T.Populated_fcra_date_type_pcnt *   0.00 / 100 + T.Populated_conviction_override_date_pcnt *   0.00 / 100 + T.Populated_conviction_override_date_type_pcnt *   0.00 / 100 + T.Populated_offense_score_pcnt *   0.00 / 100 + T.Populated_offense_persistent_id_pcnt *   0.00 / 100 + T.Populated_offense_category_pcnt *   0.00 / 100 + T.Populated_hyg_classification_code_pcnt *   0.00 / 100 + T.Populated_old_ln_offense_score_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);
  R := RECORD
    STRING vendor1;
    STRING vendor2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.vendor1 := le.Source;
    SELF.vendor2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_process_date_pcnt*ri.Populated_process_date_pcnt *   0.00 / 10000 + le.Populated_offender_key_pcnt*ri.Populated_offender_key_pcnt *   0.00 / 10000 + le.Populated_vendor_pcnt*ri.Populated_vendor_pcnt *   0.00 / 10000 + le.Populated_county_of_origin_pcnt*ri.Populated_county_of_origin_pcnt *   0.00 / 10000 + le.Populated_source_file_pcnt*ri.Populated_source_file_pcnt *   0.00 / 10000 + le.Populated_data_type_pcnt*ri.Populated_data_type_pcnt *   0.00 / 10000 + le.Populated_record_type_pcnt*ri.Populated_record_type_pcnt *   0.00 / 10000 + le.Populated_orig_state_pcnt*ri.Populated_orig_state_pcnt *   0.00 / 10000 + le.Populated_offense_key_pcnt*ri.Populated_offense_key_pcnt *   0.00 / 10000 + le.Populated_off_date_pcnt*ri.Populated_off_date_pcnt *   0.00 / 10000 + le.Populated_arr_date_pcnt*ri.Populated_arr_date_pcnt *   0.00 / 10000 + le.Populated_case_num_pcnt*ri.Populated_case_num_pcnt *   0.00 / 10000 + le.Populated_total_num_of_offenses_pcnt*ri.Populated_total_num_of_offenses_pcnt *   0.00 / 10000 + le.Populated_num_of_counts_pcnt*ri.Populated_num_of_counts_pcnt *   0.00 / 10000 + le.Populated_off_code_pcnt*ri.Populated_off_code_pcnt *   0.00 / 10000 + le.Populated_chg_pcnt*ri.Populated_chg_pcnt *   0.00 / 10000 + le.Populated_chg_typ_flg_pcnt*ri.Populated_chg_typ_flg_pcnt *   0.00 / 10000 + le.Populated_off_of_record_pcnt*ri.Populated_off_of_record_pcnt *   0.00 / 10000 + le.Populated_off_desc_1_pcnt*ri.Populated_off_desc_1_pcnt *   0.00 / 10000 + le.Populated_off_desc_2_pcnt*ri.Populated_off_desc_2_pcnt *   0.00 / 10000 + le.Populated_add_off_cd_pcnt*ri.Populated_add_off_cd_pcnt *   0.00 / 10000 + le.Populated_add_off_desc_pcnt*ri.Populated_add_off_desc_pcnt *   0.00 / 10000 + le.Populated_off_typ_pcnt*ri.Populated_off_typ_pcnt *   0.00 / 10000 + le.Populated_off_lev_pcnt*ri.Populated_off_lev_pcnt *   0.00 / 10000 + le.Populated_arr_disp_date_pcnt*ri.Populated_arr_disp_date_pcnt *   0.00 / 10000 + le.Populated_arr_disp_cd_pcnt*ri.Populated_arr_disp_cd_pcnt *   0.00 / 10000 + le.Populated_arr_disp_desc_1_pcnt*ri.Populated_arr_disp_desc_1_pcnt *   0.00 / 10000 + le.Populated_arr_disp_desc_2_pcnt*ri.Populated_arr_disp_desc_2_pcnt *   0.00 / 10000 + le.Populated_arr_disp_desc_3_pcnt*ri.Populated_arr_disp_desc_3_pcnt *   0.00 / 10000 + le.Populated_court_cd_pcnt*ri.Populated_court_cd_pcnt *   0.00 / 10000 + le.Populated_court_desc_pcnt*ri.Populated_court_desc_pcnt *   0.00 / 10000 + le.Populated_ct_dist_pcnt*ri.Populated_ct_dist_pcnt *   0.00 / 10000 + le.Populated_ct_fnl_plea_cd_pcnt*ri.Populated_ct_fnl_plea_cd_pcnt *   0.00 / 10000 + le.Populated_ct_fnl_plea_pcnt*ri.Populated_ct_fnl_plea_pcnt *   0.00 / 10000 + le.Populated_ct_off_code_pcnt*ri.Populated_ct_off_code_pcnt *   0.00 / 10000 + le.Populated_ct_chg_pcnt*ri.Populated_ct_chg_pcnt *   0.00 / 10000 + le.Populated_ct_chg_typ_flg_pcnt*ri.Populated_ct_chg_typ_flg_pcnt *   0.00 / 10000 + le.Populated_ct_off_desc_1_pcnt*ri.Populated_ct_off_desc_1_pcnt *   0.00 / 10000 + le.Populated_ct_off_desc_2_pcnt*ri.Populated_ct_off_desc_2_pcnt *   0.00 / 10000 + le.Populated_ct_addl_desc_cd_pcnt*ri.Populated_ct_addl_desc_cd_pcnt *   0.00 / 10000 + le.Populated_ct_off_lev_pcnt*ri.Populated_ct_off_lev_pcnt *   0.00 / 10000 + le.Populated_ct_disp_dt_pcnt*ri.Populated_ct_disp_dt_pcnt *   0.00 / 10000 + le.Populated_ct_disp_cd_pcnt*ri.Populated_ct_disp_cd_pcnt *   0.00 / 10000 + le.Populated_ct_disp_desc_1_pcnt*ri.Populated_ct_disp_desc_1_pcnt *   0.00 / 10000 + le.Populated_ct_disp_desc_2_pcnt*ri.Populated_ct_disp_desc_2_pcnt *   0.00 / 10000 + le.Populated_cty_conv_cd_pcnt*ri.Populated_cty_conv_cd_pcnt *   0.00 / 10000 + le.Populated_cty_conv_pcnt*ri.Populated_cty_conv_pcnt *   0.00 / 10000 + le.Populated_adj_wthd_pcnt*ri.Populated_adj_wthd_pcnt *   0.00 / 10000 + le.Populated_stc_dt_pcnt*ri.Populated_stc_dt_pcnt *   0.00 / 10000 + le.Populated_stc_cd_pcnt*ri.Populated_stc_cd_pcnt *   0.00 / 10000 + le.Populated_stc_comp_pcnt*ri.Populated_stc_comp_pcnt *   0.00 / 10000 + le.Populated_stc_desc_1_pcnt*ri.Populated_stc_desc_1_pcnt *   0.00 / 10000 + le.Populated_stc_desc_2_pcnt*ri.Populated_stc_desc_2_pcnt *   0.00 / 10000 + le.Populated_stc_desc_3_pcnt*ri.Populated_stc_desc_3_pcnt *   0.00 / 10000 + le.Populated_stc_desc_4_pcnt*ri.Populated_stc_desc_4_pcnt *   0.00 / 10000 + le.Populated_stc_lgth_pcnt*ri.Populated_stc_lgth_pcnt *   0.00 / 10000 + le.Populated_stc_lgth_desc_pcnt*ri.Populated_stc_lgth_desc_pcnt *   0.00 / 10000 + le.Populated_inc_adm_dt_pcnt*ri.Populated_inc_adm_dt_pcnt *   0.00 / 10000 + le.Populated_min_term_pcnt*ri.Populated_min_term_pcnt *   0.00 / 10000 + le.Populated_min_term_desc_pcnt*ri.Populated_min_term_desc_pcnt *   0.00 / 10000 + le.Populated_max_term_pcnt*ri.Populated_max_term_pcnt *   0.00 / 10000 + le.Populated_max_term_desc_pcnt*ri.Populated_max_term_desc_pcnt *   0.00 / 10000 + le.Populated_parole_pcnt*ri.Populated_parole_pcnt *   0.00 / 10000 + le.Populated_probation_pcnt*ri.Populated_probation_pcnt *   0.00 / 10000 + le.Populated_offensetown_pcnt*ri.Populated_offensetown_pcnt *   0.00 / 10000 + le.Populated_convict_dt_pcnt*ri.Populated_convict_dt_pcnt *   0.00 / 10000 + le.Populated_court_county_pcnt*ri.Populated_court_county_pcnt *   0.00 / 10000 + le.Populated_fcra_offense_key_pcnt*ri.Populated_fcra_offense_key_pcnt *   0.00 / 10000 + le.Populated_fcra_conviction_flag_pcnt*ri.Populated_fcra_conviction_flag_pcnt *   0.00 / 10000 + le.Populated_fcra_traffic_flag_pcnt*ri.Populated_fcra_traffic_flag_pcnt *   0.00 / 10000 + le.Populated_fcra_date_pcnt*ri.Populated_fcra_date_pcnt *   0.00 / 10000 + le.Populated_fcra_date_type_pcnt*ri.Populated_fcra_date_type_pcnt *   0.00 / 10000 + le.Populated_conviction_override_date_pcnt*ri.Populated_conviction_override_date_pcnt *   0.00 / 10000 + le.Populated_conviction_override_date_type_pcnt*ri.Populated_conviction_override_date_type_pcnt *   0.00 / 10000 + le.Populated_offense_score_pcnt*ri.Populated_offense_score_pcnt *   0.00 / 10000 + le.Populated_offense_persistent_id_pcnt*ri.Populated_offense_persistent_id_pcnt *   0.00 / 10000 + le.Populated_offense_category_pcnt*ri.Populated_offense_category_pcnt *   0.00 / 10000 + le.Populated_hyg_classification_code_pcnt*ri.Populated_hyg_classification_code_pcnt *   0.00 / 10000 + le.Populated_old_ln_offense_score_pcnt*ri.Populated_old_ln_offense_score_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
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
  SELF.FieldName := CHOOSE(C,'process_date','offender_key','vendor','county_of_origin','source_file','data_type','record_type','orig_state','offense_key','off_date','arr_date','case_num','total_num_of_offenses','num_of_counts','off_code','chg','chg_typ_flg','off_of_record','off_desc_1','off_desc_2','add_off_cd','add_off_desc','off_typ','off_lev','arr_disp_date','arr_disp_cd','arr_disp_desc_1','arr_disp_desc_2','arr_disp_desc_3','court_cd','court_desc','ct_dist','ct_fnl_plea_cd','ct_fnl_plea','ct_off_code','ct_chg','ct_chg_typ_flg','ct_off_desc_1','ct_off_desc_2','ct_addl_desc_cd','ct_off_lev','ct_disp_dt','ct_disp_cd','ct_disp_desc_1','ct_disp_desc_2','cty_conv_cd','cty_conv','adj_wthd','stc_dt','stc_cd','stc_comp','stc_desc_1','stc_desc_2','stc_desc_3','stc_desc_4','stc_lgth','stc_lgth_desc','inc_adm_dt','min_term','min_term_desc','max_term','max_term_desc','parole','probation','offensetown','convict_dt','court_county','fcra_offense_key','fcra_conviction_flag','fcra_traffic_flag','fcra_date','fcra_date_type','conviction_override_date','conviction_override_date_type','offense_score','offense_persistent_id','offense_category','hyg_classification_code','old_ln_offense_score');
  SELF.populated_pcnt := CHOOSE(C,le.populated_process_date_pcnt,le.populated_offender_key_pcnt,le.populated_vendor_pcnt,le.populated_county_of_origin_pcnt,le.populated_source_file_pcnt,le.populated_data_type_pcnt,le.populated_record_type_pcnt,le.populated_orig_state_pcnt,le.populated_offense_key_pcnt,le.populated_off_date_pcnt,le.populated_arr_date_pcnt,le.populated_case_num_pcnt,le.populated_total_num_of_offenses_pcnt,le.populated_num_of_counts_pcnt,le.populated_off_code_pcnt,le.populated_chg_pcnt,le.populated_chg_typ_flg_pcnt,le.populated_off_of_record_pcnt,le.populated_off_desc_1_pcnt,le.populated_off_desc_2_pcnt,le.populated_add_off_cd_pcnt,le.populated_add_off_desc_pcnt,le.populated_off_typ_pcnt,le.populated_off_lev_pcnt,le.populated_arr_disp_date_pcnt,le.populated_arr_disp_cd_pcnt,le.populated_arr_disp_desc_1_pcnt,le.populated_arr_disp_desc_2_pcnt,le.populated_arr_disp_desc_3_pcnt,le.populated_court_cd_pcnt,le.populated_court_desc_pcnt,le.populated_ct_dist_pcnt,le.populated_ct_fnl_plea_cd_pcnt,le.populated_ct_fnl_plea_pcnt,le.populated_ct_off_code_pcnt,le.populated_ct_chg_pcnt,le.populated_ct_chg_typ_flg_pcnt,le.populated_ct_off_desc_1_pcnt,le.populated_ct_off_desc_2_pcnt,le.populated_ct_addl_desc_cd_pcnt,le.populated_ct_off_lev_pcnt,le.populated_ct_disp_dt_pcnt,le.populated_ct_disp_cd_pcnt,le.populated_ct_disp_desc_1_pcnt,le.populated_ct_disp_desc_2_pcnt,le.populated_cty_conv_cd_pcnt,le.populated_cty_conv_pcnt,le.populated_adj_wthd_pcnt,le.populated_stc_dt_pcnt,le.populated_stc_cd_pcnt,le.populated_stc_comp_pcnt,le.populated_stc_desc_1_pcnt,le.populated_stc_desc_2_pcnt,le.populated_stc_desc_3_pcnt,le.populated_stc_desc_4_pcnt,le.populated_stc_lgth_pcnt,le.populated_stc_lgth_desc_pcnt,le.populated_inc_adm_dt_pcnt,le.populated_min_term_pcnt,le.populated_min_term_desc_pcnt,le.populated_max_term_pcnt,le.populated_max_term_desc_pcnt,le.populated_parole_pcnt,le.populated_probation_pcnt,le.populated_offensetown_pcnt,le.populated_convict_dt_pcnt,le.populated_court_county_pcnt,le.populated_fcra_offense_key_pcnt,le.populated_fcra_conviction_flag_pcnt,le.populated_fcra_traffic_flag_pcnt,le.populated_fcra_date_pcnt,le.populated_fcra_date_type_pcnt,le.populated_conviction_override_date_pcnt,le.populated_conviction_override_date_type_pcnt,le.populated_offense_score_pcnt,le.populated_offense_persistent_id_pcnt,le.populated_offense_category_pcnt,le.populated_hyg_classification_code_pcnt,le.populated_old_ln_offense_score_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_process_date,le.maxlength_offender_key,le.maxlength_vendor,le.maxlength_county_of_origin,le.maxlength_source_file,le.maxlength_data_type,le.maxlength_record_type,le.maxlength_orig_state,le.maxlength_offense_key,le.maxlength_off_date,le.maxlength_arr_date,le.maxlength_case_num,le.maxlength_total_num_of_offenses,le.maxlength_num_of_counts,le.maxlength_off_code,le.maxlength_chg,le.maxlength_chg_typ_flg,le.maxlength_off_of_record,le.maxlength_off_desc_1,le.maxlength_off_desc_2,le.maxlength_add_off_cd,le.maxlength_add_off_desc,le.maxlength_off_typ,le.maxlength_off_lev,le.maxlength_arr_disp_date,le.maxlength_arr_disp_cd,le.maxlength_arr_disp_desc_1,le.maxlength_arr_disp_desc_2,le.maxlength_arr_disp_desc_3,le.maxlength_court_cd,le.maxlength_court_desc,le.maxlength_ct_dist,le.maxlength_ct_fnl_plea_cd,le.maxlength_ct_fnl_plea,le.maxlength_ct_off_code,le.maxlength_ct_chg,le.maxlength_ct_chg_typ_flg,le.maxlength_ct_off_desc_1,le.maxlength_ct_off_desc_2,le.maxlength_ct_addl_desc_cd,le.maxlength_ct_off_lev,le.maxlength_ct_disp_dt,le.maxlength_ct_disp_cd,le.maxlength_ct_disp_desc_1,le.maxlength_ct_disp_desc_2,le.maxlength_cty_conv_cd,le.maxlength_cty_conv,le.maxlength_adj_wthd,le.maxlength_stc_dt,le.maxlength_stc_cd,le.maxlength_stc_comp,le.maxlength_stc_desc_1,le.maxlength_stc_desc_2,le.maxlength_stc_desc_3,le.maxlength_stc_desc_4,le.maxlength_stc_lgth,le.maxlength_stc_lgth_desc,le.maxlength_inc_adm_dt,le.maxlength_min_term,le.maxlength_min_term_desc,le.maxlength_max_term,le.maxlength_max_term_desc,le.maxlength_parole,le.maxlength_probation,le.maxlength_offensetown,le.maxlength_convict_dt,le.maxlength_court_county,le.maxlength_fcra_offense_key,le.maxlength_fcra_conviction_flag,le.maxlength_fcra_traffic_flag,le.maxlength_fcra_date,le.maxlength_fcra_date_type,le.maxlength_conviction_override_date,le.maxlength_conviction_override_date_type,le.maxlength_offense_score,le.maxlength_offense_persistent_id,le.maxlength_offense_category,le.maxlength_hyg_classification_code,le.maxlength_old_ln_offense_score);
  SELF.avelength := CHOOSE(C,le.avelength_process_date,le.avelength_offender_key,le.avelength_vendor,le.avelength_county_of_origin,le.avelength_source_file,le.avelength_data_type,le.avelength_record_type,le.avelength_orig_state,le.avelength_offense_key,le.avelength_off_date,le.avelength_arr_date,le.avelength_case_num,le.avelength_total_num_of_offenses,le.avelength_num_of_counts,le.avelength_off_code,le.avelength_chg,le.avelength_chg_typ_flg,le.avelength_off_of_record,le.avelength_off_desc_1,le.avelength_off_desc_2,le.avelength_add_off_cd,le.avelength_add_off_desc,le.avelength_off_typ,le.avelength_off_lev,le.avelength_arr_disp_date,le.avelength_arr_disp_cd,le.avelength_arr_disp_desc_1,le.avelength_arr_disp_desc_2,le.avelength_arr_disp_desc_3,le.avelength_court_cd,le.avelength_court_desc,le.avelength_ct_dist,le.avelength_ct_fnl_plea_cd,le.avelength_ct_fnl_plea,le.avelength_ct_off_code,le.avelength_ct_chg,le.avelength_ct_chg_typ_flg,le.avelength_ct_off_desc_1,le.avelength_ct_off_desc_2,le.avelength_ct_addl_desc_cd,le.avelength_ct_off_lev,le.avelength_ct_disp_dt,le.avelength_ct_disp_cd,le.avelength_ct_disp_desc_1,le.avelength_ct_disp_desc_2,le.avelength_cty_conv_cd,le.avelength_cty_conv,le.avelength_adj_wthd,le.avelength_stc_dt,le.avelength_stc_cd,le.avelength_stc_comp,le.avelength_stc_desc_1,le.avelength_stc_desc_2,le.avelength_stc_desc_3,le.avelength_stc_desc_4,le.avelength_stc_lgth,le.avelength_stc_lgth_desc,le.avelength_inc_adm_dt,le.avelength_min_term,le.avelength_min_term_desc,le.avelength_max_term,le.avelength_max_term_desc,le.avelength_parole,le.avelength_probation,le.avelength_offensetown,le.avelength_convict_dt,le.avelength_court_county,le.avelength_fcra_offense_key,le.avelength_fcra_conviction_flag,le.avelength_fcra_traffic_flag,le.avelength_fcra_date,le.avelength_fcra_date_type,le.avelength_conviction_override_date,le.avelength_conviction_override_date_type,le.avelength_offense_score,le.avelength_offense_persistent_id,le.avelength_offense_category,le.avelength_hyg_classification_code,le.avelength_old_ln_offense_score);
END;
EXPORT invSummary := NORMALIZE(summary0, 79, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Src := le.vendor;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.offender_key),TRIM((SALT311.StrType)le.vendor),TRIM((SALT311.StrType)le.county_of_origin),TRIM((SALT311.StrType)le.source_file),TRIM((SALT311.StrType)le.data_type),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.orig_state),TRIM((SALT311.StrType)le.offense_key),TRIM((SALT311.StrType)le.off_date),TRIM((SALT311.StrType)le.arr_date),TRIM((SALT311.StrType)le.case_num),TRIM((SALT311.StrType)le.total_num_of_offenses),TRIM((SALT311.StrType)le.num_of_counts),TRIM((SALT311.StrType)le.off_code),TRIM((SALT311.StrType)le.chg),TRIM((SALT311.StrType)le.chg_typ_flg),TRIM((SALT311.StrType)le.off_of_record),TRIM((SALT311.StrType)le.off_desc_1),TRIM((SALT311.StrType)le.off_desc_2),TRIM((SALT311.StrType)le.add_off_cd),TRIM((SALT311.StrType)le.add_off_desc),TRIM((SALT311.StrType)le.off_typ),TRIM((SALT311.StrType)le.off_lev),TRIM((SALT311.StrType)le.arr_disp_date),TRIM((SALT311.StrType)le.arr_disp_cd),TRIM((SALT311.StrType)le.arr_disp_desc_1),TRIM((SALT311.StrType)le.arr_disp_desc_2),TRIM((SALT311.StrType)le.arr_disp_desc_3),TRIM((SALT311.StrType)le.court_cd),TRIM((SALT311.StrType)le.court_desc),TRIM((SALT311.StrType)le.ct_dist),TRIM((SALT311.StrType)le.ct_fnl_plea_cd),TRIM((SALT311.StrType)le.ct_fnl_plea),TRIM((SALT311.StrType)le.ct_off_code),TRIM((SALT311.StrType)le.ct_chg),TRIM((SALT311.StrType)le.ct_chg_typ_flg),TRIM((SALT311.StrType)le.ct_off_desc_1),TRIM((SALT311.StrType)le.ct_off_desc_2),TRIM((SALT311.StrType)le.ct_addl_desc_cd),TRIM((SALT311.StrType)le.ct_off_lev),TRIM((SALT311.StrType)le.ct_disp_dt),TRIM((SALT311.StrType)le.ct_disp_cd),TRIM((SALT311.StrType)le.ct_disp_desc_1),TRIM((SALT311.StrType)le.ct_disp_desc_2),TRIM((SALT311.StrType)le.cty_conv_cd),TRIM((SALT311.StrType)le.cty_conv),TRIM((SALT311.StrType)le.adj_wthd),TRIM((SALT311.StrType)le.stc_dt),TRIM((SALT311.StrType)le.stc_cd),TRIM((SALT311.StrType)le.stc_comp),TRIM((SALT311.StrType)le.stc_desc_1),TRIM((SALT311.StrType)le.stc_desc_2),TRIM((SALT311.StrType)le.stc_desc_3),TRIM((SALT311.StrType)le.stc_desc_4),TRIM((SALT311.StrType)le.stc_lgth),TRIM((SALT311.StrType)le.stc_lgth_desc),TRIM((SALT311.StrType)le.inc_adm_dt),TRIM((SALT311.StrType)le.min_term),TRIM((SALT311.StrType)le.min_term_desc),TRIM((SALT311.StrType)le.max_term),TRIM((SALT311.StrType)le.max_term_desc),TRIM((SALT311.StrType)le.parole),TRIM((SALT311.StrType)le.probation),TRIM((SALT311.StrType)le.offensetown),TRIM((SALT311.StrType)le.convict_dt),TRIM((SALT311.StrType)le.court_county),TRIM((SALT311.StrType)le.fcra_offense_key),TRIM((SALT311.StrType)le.fcra_conviction_flag),TRIM((SALT311.StrType)le.fcra_traffic_flag),TRIM((SALT311.StrType)le.fcra_date),TRIM((SALT311.StrType)le.fcra_date_type),TRIM((SALT311.StrType)le.conviction_override_date),TRIM((SALT311.StrType)le.conviction_override_date_type),TRIM((SALT311.StrType)le.offense_score),IF (le.offense_persistent_id <> 0,TRIM((SALT311.StrType)le.offense_persistent_id), ''),IF (le.offense_category <> 0,TRIM((SALT311.StrType)le.offense_category), ''),TRIM((SALT311.StrType)le.hyg_classification_code),TRIM((SALT311.StrType)le.old_ln_offense_score)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,79,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 79);
  SELF.FldNo2 := 1 + (C % 79);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.offender_key),TRIM((SALT311.StrType)le.vendor),TRIM((SALT311.StrType)le.county_of_origin),TRIM((SALT311.StrType)le.source_file),TRIM((SALT311.StrType)le.data_type),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.orig_state),TRIM((SALT311.StrType)le.offense_key),TRIM((SALT311.StrType)le.off_date),TRIM((SALT311.StrType)le.arr_date),TRIM((SALT311.StrType)le.case_num),TRIM((SALT311.StrType)le.total_num_of_offenses),TRIM((SALT311.StrType)le.num_of_counts),TRIM((SALT311.StrType)le.off_code),TRIM((SALT311.StrType)le.chg),TRIM((SALT311.StrType)le.chg_typ_flg),TRIM((SALT311.StrType)le.off_of_record),TRIM((SALT311.StrType)le.off_desc_1),TRIM((SALT311.StrType)le.off_desc_2),TRIM((SALT311.StrType)le.add_off_cd),TRIM((SALT311.StrType)le.add_off_desc),TRIM((SALT311.StrType)le.off_typ),TRIM((SALT311.StrType)le.off_lev),TRIM((SALT311.StrType)le.arr_disp_date),TRIM((SALT311.StrType)le.arr_disp_cd),TRIM((SALT311.StrType)le.arr_disp_desc_1),TRIM((SALT311.StrType)le.arr_disp_desc_2),TRIM((SALT311.StrType)le.arr_disp_desc_3),TRIM((SALT311.StrType)le.court_cd),TRIM((SALT311.StrType)le.court_desc),TRIM((SALT311.StrType)le.ct_dist),TRIM((SALT311.StrType)le.ct_fnl_plea_cd),TRIM((SALT311.StrType)le.ct_fnl_plea),TRIM((SALT311.StrType)le.ct_off_code),TRIM((SALT311.StrType)le.ct_chg),TRIM((SALT311.StrType)le.ct_chg_typ_flg),TRIM((SALT311.StrType)le.ct_off_desc_1),TRIM((SALT311.StrType)le.ct_off_desc_2),TRIM((SALT311.StrType)le.ct_addl_desc_cd),TRIM((SALT311.StrType)le.ct_off_lev),TRIM((SALT311.StrType)le.ct_disp_dt),TRIM((SALT311.StrType)le.ct_disp_cd),TRIM((SALT311.StrType)le.ct_disp_desc_1),TRIM((SALT311.StrType)le.ct_disp_desc_2),TRIM((SALT311.StrType)le.cty_conv_cd),TRIM((SALT311.StrType)le.cty_conv),TRIM((SALT311.StrType)le.adj_wthd),TRIM((SALT311.StrType)le.stc_dt),TRIM((SALT311.StrType)le.stc_cd),TRIM((SALT311.StrType)le.stc_comp),TRIM((SALT311.StrType)le.stc_desc_1),TRIM((SALT311.StrType)le.stc_desc_2),TRIM((SALT311.StrType)le.stc_desc_3),TRIM((SALT311.StrType)le.stc_desc_4),TRIM((SALT311.StrType)le.stc_lgth),TRIM((SALT311.StrType)le.stc_lgth_desc),TRIM((SALT311.StrType)le.inc_adm_dt),TRIM((SALT311.StrType)le.min_term),TRIM((SALT311.StrType)le.min_term_desc),TRIM((SALT311.StrType)le.max_term),TRIM((SALT311.StrType)le.max_term_desc),TRIM((SALT311.StrType)le.parole),TRIM((SALT311.StrType)le.probation),TRIM((SALT311.StrType)le.offensetown),TRIM((SALT311.StrType)le.convict_dt),TRIM((SALT311.StrType)le.court_county),TRIM((SALT311.StrType)le.fcra_offense_key),TRIM((SALT311.StrType)le.fcra_conviction_flag),TRIM((SALT311.StrType)le.fcra_traffic_flag),TRIM((SALT311.StrType)le.fcra_date),TRIM((SALT311.StrType)le.fcra_date_type),TRIM((SALT311.StrType)le.conviction_override_date),TRIM((SALT311.StrType)le.conviction_override_date_type),TRIM((SALT311.StrType)le.offense_score),IF (le.offense_persistent_id <> 0,TRIM((SALT311.StrType)le.offense_persistent_id), ''),IF (le.offense_category <> 0,TRIM((SALT311.StrType)le.offense_category), ''),TRIM((SALT311.StrType)le.hyg_classification_code),TRIM((SALT311.StrType)le.old_ln_offense_score)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.offender_key),TRIM((SALT311.StrType)le.vendor),TRIM((SALT311.StrType)le.county_of_origin),TRIM((SALT311.StrType)le.source_file),TRIM((SALT311.StrType)le.data_type),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.orig_state),TRIM((SALT311.StrType)le.offense_key),TRIM((SALT311.StrType)le.off_date),TRIM((SALT311.StrType)le.arr_date),TRIM((SALT311.StrType)le.case_num),TRIM((SALT311.StrType)le.total_num_of_offenses),TRIM((SALT311.StrType)le.num_of_counts),TRIM((SALT311.StrType)le.off_code),TRIM((SALT311.StrType)le.chg),TRIM((SALT311.StrType)le.chg_typ_flg),TRIM((SALT311.StrType)le.off_of_record),TRIM((SALT311.StrType)le.off_desc_1),TRIM((SALT311.StrType)le.off_desc_2),TRIM((SALT311.StrType)le.add_off_cd),TRIM((SALT311.StrType)le.add_off_desc),TRIM((SALT311.StrType)le.off_typ),TRIM((SALT311.StrType)le.off_lev),TRIM((SALT311.StrType)le.arr_disp_date),TRIM((SALT311.StrType)le.arr_disp_cd),TRIM((SALT311.StrType)le.arr_disp_desc_1),TRIM((SALT311.StrType)le.arr_disp_desc_2),TRIM((SALT311.StrType)le.arr_disp_desc_3),TRIM((SALT311.StrType)le.court_cd),TRIM((SALT311.StrType)le.court_desc),TRIM((SALT311.StrType)le.ct_dist),TRIM((SALT311.StrType)le.ct_fnl_plea_cd),TRIM((SALT311.StrType)le.ct_fnl_plea),TRIM((SALT311.StrType)le.ct_off_code),TRIM((SALT311.StrType)le.ct_chg),TRIM((SALT311.StrType)le.ct_chg_typ_flg),TRIM((SALT311.StrType)le.ct_off_desc_1),TRIM((SALT311.StrType)le.ct_off_desc_2),TRIM((SALT311.StrType)le.ct_addl_desc_cd),TRIM((SALT311.StrType)le.ct_off_lev),TRIM((SALT311.StrType)le.ct_disp_dt),TRIM((SALT311.StrType)le.ct_disp_cd),TRIM((SALT311.StrType)le.ct_disp_desc_1),TRIM((SALT311.StrType)le.ct_disp_desc_2),TRIM((SALT311.StrType)le.cty_conv_cd),TRIM((SALT311.StrType)le.cty_conv),TRIM((SALT311.StrType)le.adj_wthd),TRIM((SALT311.StrType)le.stc_dt),TRIM((SALT311.StrType)le.stc_cd),TRIM((SALT311.StrType)le.stc_comp),TRIM((SALT311.StrType)le.stc_desc_1),TRIM((SALT311.StrType)le.stc_desc_2),TRIM((SALT311.StrType)le.stc_desc_3),TRIM((SALT311.StrType)le.stc_desc_4),TRIM((SALT311.StrType)le.stc_lgth),TRIM((SALT311.StrType)le.stc_lgth_desc),TRIM((SALT311.StrType)le.inc_adm_dt),TRIM((SALT311.StrType)le.min_term),TRIM((SALT311.StrType)le.min_term_desc),TRIM((SALT311.StrType)le.max_term),TRIM((SALT311.StrType)le.max_term_desc),TRIM((SALT311.StrType)le.parole),TRIM((SALT311.StrType)le.probation),TRIM((SALT311.StrType)le.offensetown),TRIM((SALT311.StrType)le.convict_dt),TRIM((SALT311.StrType)le.court_county),TRIM((SALT311.StrType)le.fcra_offense_key),TRIM((SALT311.StrType)le.fcra_conviction_flag),TRIM((SALT311.StrType)le.fcra_traffic_flag),TRIM((SALT311.StrType)le.fcra_date),TRIM((SALT311.StrType)le.fcra_date_type),TRIM((SALT311.StrType)le.conviction_override_date),TRIM((SALT311.StrType)le.conviction_override_date_type),TRIM((SALT311.StrType)le.offense_score),IF (le.offense_persistent_id <> 0,TRIM((SALT311.StrType)le.offense_persistent_id), ''),IF (le.offense_category <> 0,TRIM((SALT311.StrType)le.offense_category), ''),TRIM((SALT311.StrType)le.hyg_classification_code),TRIM((SALT311.StrType)le.old_ln_offense_score)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),79*79,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'process_date'}
      ,{2,'offender_key'}
      ,{3,'vendor'}
      ,{4,'county_of_origin'}
      ,{5,'source_file'}
      ,{6,'data_type'}
      ,{7,'record_type'}
      ,{8,'orig_state'}
      ,{9,'offense_key'}
      ,{10,'off_date'}
      ,{11,'arr_date'}
      ,{12,'case_num'}
      ,{13,'total_num_of_offenses'}
      ,{14,'num_of_counts'}
      ,{15,'off_code'}
      ,{16,'chg'}
      ,{17,'chg_typ_flg'}
      ,{18,'off_of_record'}
      ,{19,'off_desc_1'}
      ,{20,'off_desc_2'}
      ,{21,'add_off_cd'}
      ,{22,'add_off_desc'}
      ,{23,'off_typ'}
      ,{24,'off_lev'}
      ,{25,'arr_disp_date'}
      ,{26,'arr_disp_cd'}
      ,{27,'arr_disp_desc_1'}
      ,{28,'arr_disp_desc_2'}
      ,{29,'arr_disp_desc_3'}
      ,{30,'court_cd'}
      ,{31,'court_desc'}
      ,{32,'ct_dist'}
      ,{33,'ct_fnl_plea_cd'}
      ,{34,'ct_fnl_plea'}
      ,{35,'ct_off_code'}
      ,{36,'ct_chg'}
      ,{37,'ct_chg_typ_flg'}
      ,{38,'ct_off_desc_1'}
      ,{39,'ct_off_desc_2'}
      ,{40,'ct_addl_desc_cd'}
      ,{41,'ct_off_lev'}
      ,{42,'ct_disp_dt'}
      ,{43,'ct_disp_cd'}
      ,{44,'ct_disp_desc_1'}
      ,{45,'ct_disp_desc_2'}
      ,{46,'cty_conv_cd'}
      ,{47,'cty_conv'}
      ,{48,'adj_wthd'}
      ,{49,'stc_dt'}
      ,{50,'stc_cd'}
      ,{51,'stc_comp'}
      ,{52,'stc_desc_1'}
      ,{53,'stc_desc_2'}
      ,{54,'stc_desc_3'}
      ,{55,'stc_desc_4'}
      ,{56,'stc_lgth'}
      ,{57,'stc_lgth_desc'}
      ,{58,'inc_adm_dt'}
      ,{59,'min_term'}
      ,{60,'min_term_desc'}
      ,{61,'max_term'}
      ,{62,'max_term_desc'}
      ,{63,'parole'}
      ,{64,'probation'}
      ,{65,'offensetown'}
      ,{66,'convict_dt'}
      ,{67,'court_county'}
      ,{68,'fcra_offense_key'}
      ,{69,'fcra_conviction_flag'}
      ,{70,'fcra_traffic_flag'}
      ,{71,'fcra_date'}
      ,{72,'fcra_date_type'}
      ,{73,'conviction_override_date'}
      ,{74,'conviction_override_date_type'}
      ,{75,'offense_score'}
      ,{76,'offense_persistent_id'}
      ,{77,'offense_category'}
      ,{78,'hyg_classification_code'}
      ,{79,'old_ln_offense_score'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.vendor) vendor; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Moxie_DOC_Offenses_Dev_Fields.InValid_process_date((SALT311.StrType)le.process_date),
    Moxie_DOC_Offenses_Dev_Fields.InValid_offender_key((SALT311.StrType)le.offender_key),
    Moxie_DOC_Offenses_Dev_Fields.InValid_vendor((SALT311.StrType)le.vendor),
    Moxie_DOC_Offenses_Dev_Fields.InValid_county_of_origin((SALT311.StrType)le.county_of_origin),
    Moxie_DOC_Offenses_Dev_Fields.InValid_source_file((SALT311.StrType)le.source_file),
    Moxie_DOC_Offenses_Dev_Fields.InValid_data_type((SALT311.StrType)le.data_type),
    Moxie_DOC_Offenses_Dev_Fields.InValid_record_type((SALT311.StrType)le.record_type),
    Moxie_DOC_Offenses_Dev_Fields.InValid_orig_state((SALT311.StrType)le.orig_state),
    Moxie_DOC_Offenses_Dev_Fields.InValid_offense_key((SALT311.StrType)le.offense_key),
    Moxie_DOC_Offenses_Dev_Fields.InValid_off_date((SALT311.StrType)le.off_date),
    Moxie_DOC_Offenses_Dev_Fields.InValid_arr_date((SALT311.StrType)le.arr_date),
    Moxie_DOC_Offenses_Dev_Fields.InValid_case_num((SALT311.StrType)le.case_num),
    Moxie_DOC_Offenses_Dev_Fields.InValid_total_num_of_offenses((SALT311.StrType)le.total_num_of_offenses),
    Moxie_DOC_Offenses_Dev_Fields.InValid_num_of_counts((SALT311.StrType)le.num_of_counts),
    Moxie_DOC_Offenses_Dev_Fields.InValid_off_code((SALT311.StrType)le.off_code),
    Moxie_DOC_Offenses_Dev_Fields.InValid_chg((SALT311.StrType)le.chg),
    Moxie_DOC_Offenses_Dev_Fields.InValid_chg_typ_flg((SALT311.StrType)le.chg_typ_flg),
    Moxie_DOC_Offenses_Dev_Fields.InValid_off_of_record((SALT311.StrType)le.off_of_record),
    Moxie_DOC_Offenses_Dev_Fields.InValid_off_desc_1((SALT311.StrType)le.off_desc_1),
    Moxie_DOC_Offenses_Dev_Fields.InValid_off_desc_2((SALT311.StrType)le.off_desc_2),
    Moxie_DOC_Offenses_Dev_Fields.InValid_add_off_cd((SALT311.StrType)le.add_off_cd),
    Moxie_DOC_Offenses_Dev_Fields.InValid_add_off_desc((SALT311.StrType)le.add_off_desc),
    Moxie_DOC_Offenses_Dev_Fields.InValid_off_typ((SALT311.StrType)le.off_typ),
    Moxie_DOC_Offenses_Dev_Fields.InValid_off_lev((SALT311.StrType)le.off_lev),
    Moxie_DOC_Offenses_Dev_Fields.InValid_arr_disp_date((SALT311.StrType)le.arr_disp_date),
    Moxie_DOC_Offenses_Dev_Fields.InValid_arr_disp_cd((SALT311.StrType)le.arr_disp_cd),
    Moxie_DOC_Offenses_Dev_Fields.InValid_arr_disp_desc_1((SALT311.StrType)le.arr_disp_desc_1),
    Moxie_DOC_Offenses_Dev_Fields.InValid_arr_disp_desc_2((SALT311.StrType)le.arr_disp_desc_2),
    Moxie_DOC_Offenses_Dev_Fields.InValid_arr_disp_desc_3((SALT311.StrType)le.arr_disp_desc_3),
    Moxie_DOC_Offenses_Dev_Fields.InValid_court_cd((SALT311.StrType)le.court_cd),
    Moxie_DOC_Offenses_Dev_Fields.InValid_court_desc((SALT311.StrType)le.court_desc),
    Moxie_DOC_Offenses_Dev_Fields.InValid_ct_dist((SALT311.StrType)le.ct_dist),
    Moxie_DOC_Offenses_Dev_Fields.InValid_ct_fnl_plea_cd((SALT311.StrType)le.ct_fnl_plea_cd),
    Moxie_DOC_Offenses_Dev_Fields.InValid_ct_fnl_plea((SALT311.StrType)le.ct_fnl_plea),
    Moxie_DOC_Offenses_Dev_Fields.InValid_ct_off_code((SALT311.StrType)le.ct_off_code),
    Moxie_DOC_Offenses_Dev_Fields.InValid_ct_chg((SALT311.StrType)le.ct_chg),
    Moxie_DOC_Offenses_Dev_Fields.InValid_ct_chg_typ_flg((SALT311.StrType)le.ct_chg_typ_flg),
    Moxie_DOC_Offenses_Dev_Fields.InValid_ct_off_desc_1((SALT311.StrType)le.ct_off_desc_1),
    Moxie_DOC_Offenses_Dev_Fields.InValid_ct_off_desc_2((SALT311.StrType)le.ct_off_desc_2),
    Moxie_DOC_Offenses_Dev_Fields.InValid_ct_addl_desc_cd((SALT311.StrType)le.ct_addl_desc_cd),
    Moxie_DOC_Offenses_Dev_Fields.InValid_ct_off_lev((SALT311.StrType)le.ct_off_lev),
    Moxie_DOC_Offenses_Dev_Fields.InValid_ct_disp_dt((SALT311.StrType)le.ct_disp_dt),
    Moxie_DOC_Offenses_Dev_Fields.InValid_ct_disp_cd((SALT311.StrType)le.ct_disp_cd),
    Moxie_DOC_Offenses_Dev_Fields.InValid_ct_disp_desc_1((SALT311.StrType)le.ct_disp_desc_1),
    Moxie_DOC_Offenses_Dev_Fields.InValid_ct_disp_desc_2((SALT311.StrType)le.ct_disp_desc_2),
    Moxie_DOC_Offenses_Dev_Fields.InValid_cty_conv_cd((SALT311.StrType)le.cty_conv_cd),
    Moxie_DOC_Offenses_Dev_Fields.InValid_cty_conv((SALT311.StrType)le.cty_conv),
    Moxie_DOC_Offenses_Dev_Fields.InValid_adj_wthd((SALT311.StrType)le.adj_wthd),
    Moxie_DOC_Offenses_Dev_Fields.InValid_stc_dt((SALT311.StrType)le.stc_dt),
    Moxie_DOC_Offenses_Dev_Fields.InValid_stc_cd((SALT311.StrType)le.stc_cd),
    Moxie_DOC_Offenses_Dev_Fields.InValid_stc_comp((SALT311.StrType)le.stc_comp),
    Moxie_DOC_Offenses_Dev_Fields.InValid_stc_desc_1((SALT311.StrType)le.stc_desc_1),
    Moxie_DOC_Offenses_Dev_Fields.InValid_stc_desc_2((SALT311.StrType)le.stc_desc_2),
    Moxie_DOC_Offenses_Dev_Fields.InValid_stc_desc_3((SALT311.StrType)le.stc_desc_3),
    Moxie_DOC_Offenses_Dev_Fields.InValid_stc_desc_4((SALT311.StrType)le.stc_desc_4),
    Moxie_DOC_Offenses_Dev_Fields.InValid_stc_lgth((SALT311.StrType)le.stc_lgth),
    Moxie_DOC_Offenses_Dev_Fields.InValid_stc_lgth_desc((SALT311.StrType)le.stc_lgth_desc),
    Moxie_DOC_Offenses_Dev_Fields.InValid_inc_adm_dt((SALT311.StrType)le.inc_adm_dt),
    Moxie_DOC_Offenses_Dev_Fields.InValid_min_term((SALT311.StrType)le.min_term),
    Moxie_DOC_Offenses_Dev_Fields.InValid_min_term_desc((SALT311.StrType)le.min_term_desc),
    Moxie_DOC_Offenses_Dev_Fields.InValid_max_term((SALT311.StrType)le.max_term),
    Moxie_DOC_Offenses_Dev_Fields.InValid_max_term_desc((SALT311.StrType)le.max_term_desc),
    Moxie_DOC_Offenses_Dev_Fields.InValid_parole((SALT311.StrType)le.parole),
    Moxie_DOC_Offenses_Dev_Fields.InValid_probation((SALT311.StrType)le.probation),
    Moxie_DOC_Offenses_Dev_Fields.InValid_offensetown((SALT311.StrType)le.offensetown),
    Moxie_DOC_Offenses_Dev_Fields.InValid_convict_dt((SALT311.StrType)le.convict_dt),
    Moxie_DOC_Offenses_Dev_Fields.InValid_court_county((SALT311.StrType)le.court_county),
    Moxie_DOC_Offenses_Dev_Fields.InValid_fcra_offense_key((SALT311.StrType)le.fcra_offense_key),
    Moxie_DOC_Offenses_Dev_Fields.InValid_fcra_conviction_flag((SALT311.StrType)le.fcra_conviction_flag),
    Moxie_DOC_Offenses_Dev_Fields.InValid_fcra_traffic_flag((SALT311.StrType)le.fcra_traffic_flag),
    Moxie_DOC_Offenses_Dev_Fields.InValid_fcra_date((SALT311.StrType)le.fcra_date),
    Moxie_DOC_Offenses_Dev_Fields.InValid_fcra_date_type((SALT311.StrType)le.fcra_date_type),
    Moxie_DOC_Offenses_Dev_Fields.InValid_conviction_override_date((SALT311.StrType)le.conviction_override_date),
    Moxie_DOC_Offenses_Dev_Fields.InValid_conviction_override_date_type((SALT311.StrType)le.conviction_override_date_type),
    Moxie_DOC_Offenses_Dev_Fields.InValid_offense_score((SALT311.StrType)le.offense_score),
    Moxie_DOC_Offenses_Dev_Fields.InValid_offense_persistent_id((SALT311.StrType)le.offense_persistent_id),
    Moxie_DOC_Offenses_Dev_Fields.InValid_offense_category((SALT311.StrType)le.offense_category),
    Moxie_DOC_Offenses_Dev_Fields.InValid_hyg_classification_code((SALT311.StrType)le.hyg_classification_code),
    Moxie_DOC_Offenses_Dev_Fields.InValid_old_ln_offense_score((SALT311.StrType)le.old_ln_offense_score),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.vendor := le.vendor;
END;
Errors := NORMALIZE(h,79,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.vendor;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,vendor,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.vendor;
  FieldNme := Moxie_DOC_Offenses_Dev_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Current_Date','Non_Blank','Unknown','Unknown','Non_Blank','Unknown','Unknown','Invalid_Char','Non_Blank','Invalid_Current_Date','Invalid_Current_Date','Unknown','Invalid_Num','Invalid_Num','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_Off_Typ','Invalid_OffLev','Invalid_Current_Date','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_Current_Date','Unknown','Unknown','Unknown','Invalid_CtyConvCd','Unknown','Unknown','Invalid_Future_Date','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_Current_Date','Unknown','Unknown','Invalid_FCRAConFlag','Invalid_FCRATrafficFlag','Invalid_Current_Date','Invalid_FCRADateFlag','Invalid_Future_Date','Invalid_ConOverDateFlag','Unknown','Invalid_Num','Invalid_Num','Invalid_Char','Invalid_OffenseScore');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Moxie_DOC_Offenses_Dev_Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_offender_key(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_vendor(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_county_of_origin(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_source_file(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_data_type(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_orig_state(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_offense_key(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_off_date(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_arr_date(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_case_num(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_total_num_of_offenses(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_num_of_counts(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_off_code(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_chg(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_chg_typ_flg(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_off_of_record(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_off_desc_1(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_off_desc_2(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_add_off_cd(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_add_off_desc(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_off_typ(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_off_lev(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_arr_disp_date(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_arr_disp_cd(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_arr_disp_desc_1(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_arr_disp_desc_2(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_arr_disp_desc_3(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_court_cd(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_court_desc(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_ct_dist(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_ct_fnl_plea_cd(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_ct_fnl_plea(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_ct_off_code(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_ct_chg(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_ct_chg_typ_flg(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_ct_off_desc_1(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_ct_off_desc_2(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_ct_addl_desc_cd(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_ct_off_lev(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_ct_disp_dt(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_ct_disp_cd(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_ct_disp_desc_1(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_ct_disp_desc_2(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_cty_conv_cd(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_cty_conv(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_adj_wthd(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_stc_dt(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_stc_cd(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_stc_comp(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_stc_desc_1(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_stc_desc_2(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_stc_desc_3(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_stc_desc_4(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_stc_lgth(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_stc_lgth_desc(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_inc_adm_dt(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_min_term(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_min_term_desc(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_max_term(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_max_term_desc(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_parole(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_probation(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_offensetown(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_convict_dt(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_court_county(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_fcra_offense_key(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_fcra_conviction_flag(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_fcra_traffic_flag(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_fcra_date(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_fcra_date_type(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_conviction_override_date(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_conviction_override_date_type(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_offense_score(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_offense_persistent_id(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_offense_category(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_hyg_classification_code(TotalErrors.ErrorNum),Moxie_DOC_Offenses_Dev_Fields.InValidMessage_old_ln_offense_score(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.vendor=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doSummaryPerSrc = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
  fieldPopulationPerSource := Summary('', FALSE);
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Crim, Moxie_DOC_Offenses_Dev_Fields, 'RECORDOF(fieldPopulationOverall)', TRUE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationPerSource_Standard := IF(doSummaryPerSrc, NORMALIZE(fieldPopulationPerSource, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'src', 'src')));
 
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', TRUE, 'all'));
  fieldPopulationPerSource_TotalRecs_Standard := IF(doSummaryPerSrc, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationPerSource, myTimeStamp, 'src', TRUE, 'src'));
 
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & fieldPopulationPerSource_Standard & fieldPopulationPerSource_TotalRecs_Standard & allProfiles_Standard;
END;
END;
