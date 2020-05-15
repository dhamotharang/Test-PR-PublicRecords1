IMPORT SALT311,STD;
EXPORT Moxie_Court_Offenses_Dev_hygiene(dataset(Moxie_Court_Offenses_Dev_layout_crim) h) := MODULE
 
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
    populated_state_origin_cnt := COUNT(GROUP,h.state_origin <> (TYPEOF(h.state_origin))'');
    populated_state_origin_pcnt := AVE(GROUP,IF(h.state_origin = (TYPEOF(h.state_origin))'',0,100));
    maxlength_state_origin := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state_origin)));
    avelength_state_origin := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state_origin)),h.state_origin<>(typeof(h.state_origin))'');
    populated_source_file_cnt := COUNT(GROUP,h.source_file <> (TYPEOF(h.source_file))'');
    populated_source_file_pcnt := AVE(GROUP,IF(h.source_file = (TYPEOF(h.source_file))'',0,100));
    maxlength_source_file := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_file)));
    avelength_source_file := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_file)),h.source_file<>(typeof(h.source_file))'');
    populated_data_type_cnt := COUNT(GROUP,h.data_type <> (TYPEOF(h.data_type))'');
    populated_data_type_pcnt := AVE(GROUP,IF(h.data_type = (TYPEOF(h.data_type))'',0,100));
    maxlength_data_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.data_type)));
    avelength_data_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.data_type)),h.data_type<>(typeof(h.data_type))'');
    populated_off_comp_cnt := COUNT(GROUP,h.off_comp <> (TYPEOF(h.off_comp))'');
    populated_off_comp_pcnt := AVE(GROUP,IF(h.off_comp = (TYPEOF(h.off_comp))'',0,100));
    maxlength_off_comp := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.off_comp)));
    avelength_off_comp := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.off_comp)),h.off_comp<>(typeof(h.off_comp))'');
    populated_off_delete_flag_cnt := COUNT(GROUP,h.off_delete_flag <> (TYPEOF(h.off_delete_flag))'');
    populated_off_delete_flag_pcnt := AVE(GROUP,IF(h.off_delete_flag = (TYPEOF(h.off_delete_flag))'',0,100));
    maxlength_off_delete_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.off_delete_flag)));
    avelength_off_delete_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.off_delete_flag)),h.off_delete_flag<>(typeof(h.off_delete_flag))'');
    populated_off_date_cnt := COUNT(GROUP,h.off_date <> (TYPEOF(h.off_date))'');
    populated_off_date_pcnt := AVE(GROUP,IF(h.off_date = (TYPEOF(h.off_date))'',0,100));
    maxlength_off_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.off_date)));
    avelength_off_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.off_date)),h.off_date<>(typeof(h.off_date))'');
    populated_arr_date_cnt := COUNT(GROUP,h.arr_date <> (TYPEOF(h.arr_date))'');
    populated_arr_date_pcnt := AVE(GROUP,IF(h.arr_date = (TYPEOF(h.arr_date))'',0,100));
    maxlength_arr_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.arr_date)));
    avelength_arr_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.arr_date)),h.arr_date<>(typeof(h.arr_date))'');
    populated_num_of_counts_cnt := COUNT(GROUP,h.num_of_counts <> (TYPEOF(h.num_of_counts))'');
    populated_num_of_counts_pcnt := AVE(GROUP,IF(h.num_of_counts = (TYPEOF(h.num_of_counts))'',0,100));
    maxlength_num_of_counts := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.num_of_counts)));
    avelength_num_of_counts := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.num_of_counts)),h.num_of_counts<>(typeof(h.num_of_counts))'');
    populated_le_agency_cd_cnt := COUNT(GROUP,h.le_agency_cd <> (TYPEOF(h.le_agency_cd))'');
    populated_le_agency_cd_pcnt := AVE(GROUP,IF(h.le_agency_cd = (TYPEOF(h.le_agency_cd))'',0,100));
    maxlength_le_agency_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.le_agency_cd)));
    avelength_le_agency_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.le_agency_cd)),h.le_agency_cd<>(typeof(h.le_agency_cd))'');
    populated_le_agency_desc_cnt := COUNT(GROUP,h.le_agency_desc <> (TYPEOF(h.le_agency_desc))'');
    populated_le_agency_desc_pcnt := AVE(GROUP,IF(h.le_agency_desc = (TYPEOF(h.le_agency_desc))'',0,100));
    maxlength_le_agency_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.le_agency_desc)));
    avelength_le_agency_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.le_agency_desc)),h.le_agency_desc<>(typeof(h.le_agency_desc))'');
    populated_le_agency_case_number_cnt := COUNT(GROUP,h.le_agency_case_number <> (TYPEOF(h.le_agency_case_number))'');
    populated_le_agency_case_number_pcnt := AVE(GROUP,IF(h.le_agency_case_number = (TYPEOF(h.le_agency_case_number))'',0,100));
    maxlength_le_agency_case_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.le_agency_case_number)));
    avelength_le_agency_case_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.le_agency_case_number)),h.le_agency_case_number<>(typeof(h.le_agency_case_number))'');
    populated_traffic_ticket_number_cnt := COUNT(GROUP,h.traffic_ticket_number <> (TYPEOF(h.traffic_ticket_number))'');
    populated_traffic_ticket_number_pcnt := AVE(GROUP,IF(h.traffic_ticket_number = (TYPEOF(h.traffic_ticket_number))'',0,100));
    maxlength_traffic_ticket_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.traffic_ticket_number)));
    avelength_traffic_ticket_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.traffic_ticket_number)),h.traffic_ticket_number<>(typeof(h.traffic_ticket_number))'');
    populated_traffic_dl_no_cnt := COUNT(GROUP,h.traffic_dl_no <> (TYPEOF(h.traffic_dl_no))'');
    populated_traffic_dl_no_pcnt := AVE(GROUP,IF(h.traffic_dl_no = (TYPEOF(h.traffic_dl_no))'',0,100));
    maxlength_traffic_dl_no := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.traffic_dl_no)));
    avelength_traffic_dl_no := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.traffic_dl_no)),h.traffic_dl_no<>(typeof(h.traffic_dl_no))'');
    populated_traffic_dl_st_cnt := COUNT(GROUP,h.traffic_dl_st <> (TYPEOF(h.traffic_dl_st))'');
    populated_traffic_dl_st_pcnt := AVE(GROUP,IF(h.traffic_dl_st = (TYPEOF(h.traffic_dl_st))'',0,100));
    maxlength_traffic_dl_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.traffic_dl_st)));
    avelength_traffic_dl_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.traffic_dl_st)),h.traffic_dl_st<>(typeof(h.traffic_dl_st))'');
    populated_arr_off_code_cnt := COUNT(GROUP,h.arr_off_code <> (TYPEOF(h.arr_off_code))'');
    populated_arr_off_code_pcnt := AVE(GROUP,IF(h.arr_off_code = (TYPEOF(h.arr_off_code))'',0,100));
    maxlength_arr_off_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.arr_off_code)));
    avelength_arr_off_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.arr_off_code)),h.arr_off_code<>(typeof(h.arr_off_code))'');
    populated_arr_off_desc_1_cnt := COUNT(GROUP,h.arr_off_desc_1 <> (TYPEOF(h.arr_off_desc_1))'');
    populated_arr_off_desc_1_pcnt := AVE(GROUP,IF(h.arr_off_desc_1 = (TYPEOF(h.arr_off_desc_1))'',0,100));
    maxlength_arr_off_desc_1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.arr_off_desc_1)));
    avelength_arr_off_desc_1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.arr_off_desc_1)),h.arr_off_desc_1<>(typeof(h.arr_off_desc_1))'');
    populated_arr_off_desc_2_cnt := COUNT(GROUP,h.arr_off_desc_2 <> (TYPEOF(h.arr_off_desc_2))'');
    populated_arr_off_desc_2_pcnt := AVE(GROUP,IF(h.arr_off_desc_2 = (TYPEOF(h.arr_off_desc_2))'',0,100));
    maxlength_arr_off_desc_2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.arr_off_desc_2)));
    avelength_arr_off_desc_2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.arr_off_desc_2)),h.arr_off_desc_2<>(typeof(h.arr_off_desc_2))'');
    populated_arr_off_type_cd_cnt := COUNT(GROUP,h.arr_off_type_cd <> (TYPEOF(h.arr_off_type_cd))'');
    populated_arr_off_type_cd_pcnt := AVE(GROUP,IF(h.arr_off_type_cd = (TYPEOF(h.arr_off_type_cd))'',0,100));
    maxlength_arr_off_type_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.arr_off_type_cd)));
    avelength_arr_off_type_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.arr_off_type_cd)),h.arr_off_type_cd<>(typeof(h.arr_off_type_cd))'');
    populated_arr_off_type_desc_cnt := COUNT(GROUP,h.arr_off_type_desc <> (TYPEOF(h.arr_off_type_desc))'');
    populated_arr_off_type_desc_pcnt := AVE(GROUP,IF(h.arr_off_type_desc = (TYPEOF(h.arr_off_type_desc))'',0,100));
    maxlength_arr_off_type_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.arr_off_type_desc)));
    avelength_arr_off_type_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.arr_off_type_desc)),h.arr_off_type_desc<>(typeof(h.arr_off_type_desc))'');
    populated_arr_off_lev_cnt := COUNT(GROUP,h.arr_off_lev <> (TYPEOF(h.arr_off_lev))'');
    populated_arr_off_lev_pcnt := AVE(GROUP,IF(h.arr_off_lev = (TYPEOF(h.arr_off_lev))'',0,100));
    maxlength_arr_off_lev := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.arr_off_lev)));
    avelength_arr_off_lev := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.arr_off_lev)),h.arr_off_lev<>(typeof(h.arr_off_lev))'');
    populated_arr_statute_cnt := COUNT(GROUP,h.arr_statute <> (TYPEOF(h.arr_statute))'');
    populated_arr_statute_pcnt := AVE(GROUP,IF(h.arr_statute = (TYPEOF(h.arr_statute))'',0,100));
    maxlength_arr_statute := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.arr_statute)));
    avelength_arr_statute := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.arr_statute)),h.arr_statute<>(typeof(h.arr_statute))'');
    populated_arr_statute_desc_cnt := COUNT(GROUP,h.arr_statute_desc <> (TYPEOF(h.arr_statute_desc))'');
    populated_arr_statute_desc_pcnt := AVE(GROUP,IF(h.arr_statute_desc = (TYPEOF(h.arr_statute_desc))'',0,100));
    maxlength_arr_statute_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.arr_statute_desc)));
    avelength_arr_statute_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.arr_statute_desc)),h.arr_statute_desc<>(typeof(h.arr_statute_desc))'');
    populated_arr_disp_date_cnt := COUNT(GROUP,h.arr_disp_date <> (TYPEOF(h.arr_disp_date))'');
    populated_arr_disp_date_pcnt := AVE(GROUP,IF(h.arr_disp_date = (TYPEOF(h.arr_disp_date))'',0,100));
    maxlength_arr_disp_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.arr_disp_date)));
    avelength_arr_disp_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.arr_disp_date)),h.arr_disp_date<>(typeof(h.arr_disp_date))'');
    populated_arr_disp_code_cnt := COUNT(GROUP,h.arr_disp_code <> (TYPEOF(h.arr_disp_code))'');
    populated_arr_disp_code_pcnt := AVE(GROUP,IF(h.arr_disp_code = (TYPEOF(h.arr_disp_code))'',0,100));
    maxlength_arr_disp_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.arr_disp_code)));
    avelength_arr_disp_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.arr_disp_code)),h.arr_disp_code<>(typeof(h.arr_disp_code))'');
    populated_arr_disp_desc_1_cnt := COUNT(GROUP,h.arr_disp_desc_1 <> (TYPEOF(h.arr_disp_desc_1))'');
    populated_arr_disp_desc_1_pcnt := AVE(GROUP,IF(h.arr_disp_desc_1 = (TYPEOF(h.arr_disp_desc_1))'',0,100));
    maxlength_arr_disp_desc_1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.arr_disp_desc_1)));
    avelength_arr_disp_desc_1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.arr_disp_desc_1)),h.arr_disp_desc_1<>(typeof(h.arr_disp_desc_1))'');
    populated_arr_disp_desc_2_cnt := COUNT(GROUP,h.arr_disp_desc_2 <> (TYPEOF(h.arr_disp_desc_2))'');
    populated_arr_disp_desc_2_pcnt := AVE(GROUP,IF(h.arr_disp_desc_2 = (TYPEOF(h.arr_disp_desc_2))'',0,100));
    maxlength_arr_disp_desc_2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.arr_disp_desc_2)));
    avelength_arr_disp_desc_2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.arr_disp_desc_2)),h.arr_disp_desc_2<>(typeof(h.arr_disp_desc_2))'');
    populated_pros_refer_cd_cnt := COUNT(GROUP,h.pros_refer_cd <> (TYPEOF(h.pros_refer_cd))'');
    populated_pros_refer_cd_pcnt := AVE(GROUP,IF(h.pros_refer_cd = (TYPEOF(h.pros_refer_cd))'',0,100));
    maxlength_pros_refer_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pros_refer_cd)));
    avelength_pros_refer_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pros_refer_cd)),h.pros_refer_cd<>(typeof(h.pros_refer_cd))'');
    populated_pros_refer_cnt := COUNT(GROUP,h.pros_refer <> (TYPEOF(h.pros_refer))'');
    populated_pros_refer_pcnt := AVE(GROUP,IF(h.pros_refer = (TYPEOF(h.pros_refer))'',0,100));
    maxlength_pros_refer := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pros_refer)));
    avelength_pros_refer := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pros_refer)),h.pros_refer<>(typeof(h.pros_refer))'');
    populated_pros_assgn_cd_cnt := COUNT(GROUP,h.pros_assgn_cd <> (TYPEOF(h.pros_assgn_cd))'');
    populated_pros_assgn_cd_pcnt := AVE(GROUP,IF(h.pros_assgn_cd = (TYPEOF(h.pros_assgn_cd))'',0,100));
    maxlength_pros_assgn_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pros_assgn_cd)));
    avelength_pros_assgn_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pros_assgn_cd)),h.pros_assgn_cd<>(typeof(h.pros_assgn_cd))'');
    populated_pros_assgn_cnt := COUNT(GROUP,h.pros_assgn <> (TYPEOF(h.pros_assgn))'');
    populated_pros_assgn_pcnt := AVE(GROUP,IF(h.pros_assgn = (TYPEOF(h.pros_assgn))'',0,100));
    maxlength_pros_assgn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pros_assgn)));
    avelength_pros_assgn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pros_assgn)),h.pros_assgn<>(typeof(h.pros_assgn))'');
    populated_pros_chg_rej_cnt := COUNT(GROUP,h.pros_chg_rej <> (TYPEOF(h.pros_chg_rej))'');
    populated_pros_chg_rej_pcnt := AVE(GROUP,IF(h.pros_chg_rej = (TYPEOF(h.pros_chg_rej))'',0,100));
    maxlength_pros_chg_rej := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pros_chg_rej)));
    avelength_pros_chg_rej := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pros_chg_rej)),h.pros_chg_rej<>(typeof(h.pros_chg_rej))'');
    populated_pros_off_code_cnt := COUNT(GROUP,h.pros_off_code <> (TYPEOF(h.pros_off_code))'');
    populated_pros_off_code_pcnt := AVE(GROUP,IF(h.pros_off_code = (TYPEOF(h.pros_off_code))'',0,100));
    maxlength_pros_off_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pros_off_code)));
    avelength_pros_off_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pros_off_code)),h.pros_off_code<>(typeof(h.pros_off_code))'');
    populated_pros_off_desc_1_cnt := COUNT(GROUP,h.pros_off_desc_1 <> (TYPEOF(h.pros_off_desc_1))'');
    populated_pros_off_desc_1_pcnt := AVE(GROUP,IF(h.pros_off_desc_1 = (TYPEOF(h.pros_off_desc_1))'',0,100));
    maxlength_pros_off_desc_1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pros_off_desc_1)));
    avelength_pros_off_desc_1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pros_off_desc_1)),h.pros_off_desc_1<>(typeof(h.pros_off_desc_1))'');
    populated_pros_off_desc_2_cnt := COUNT(GROUP,h.pros_off_desc_2 <> (TYPEOF(h.pros_off_desc_2))'');
    populated_pros_off_desc_2_pcnt := AVE(GROUP,IF(h.pros_off_desc_2 = (TYPEOF(h.pros_off_desc_2))'',0,100));
    maxlength_pros_off_desc_2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pros_off_desc_2)));
    avelength_pros_off_desc_2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pros_off_desc_2)),h.pros_off_desc_2<>(typeof(h.pros_off_desc_2))'');
    populated_pros_off_type_cd_cnt := COUNT(GROUP,h.pros_off_type_cd <> (TYPEOF(h.pros_off_type_cd))'');
    populated_pros_off_type_cd_pcnt := AVE(GROUP,IF(h.pros_off_type_cd = (TYPEOF(h.pros_off_type_cd))'',0,100));
    maxlength_pros_off_type_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pros_off_type_cd)));
    avelength_pros_off_type_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pros_off_type_cd)),h.pros_off_type_cd<>(typeof(h.pros_off_type_cd))'');
    populated_pros_off_type_desc_cnt := COUNT(GROUP,h.pros_off_type_desc <> (TYPEOF(h.pros_off_type_desc))'');
    populated_pros_off_type_desc_pcnt := AVE(GROUP,IF(h.pros_off_type_desc = (TYPEOF(h.pros_off_type_desc))'',0,100));
    maxlength_pros_off_type_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pros_off_type_desc)));
    avelength_pros_off_type_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pros_off_type_desc)),h.pros_off_type_desc<>(typeof(h.pros_off_type_desc))'');
    populated_pros_off_lev_cnt := COUNT(GROUP,h.pros_off_lev <> (TYPEOF(h.pros_off_lev))'');
    populated_pros_off_lev_pcnt := AVE(GROUP,IF(h.pros_off_lev = (TYPEOF(h.pros_off_lev))'',0,100));
    maxlength_pros_off_lev := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pros_off_lev)));
    avelength_pros_off_lev := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pros_off_lev)),h.pros_off_lev<>(typeof(h.pros_off_lev))'');
    populated_pros_act_filed_cnt := COUNT(GROUP,h.pros_act_filed <> (TYPEOF(h.pros_act_filed))'');
    populated_pros_act_filed_pcnt := AVE(GROUP,IF(h.pros_act_filed = (TYPEOF(h.pros_act_filed))'',0,100));
    maxlength_pros_act_filed := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pros_act_filed)));
    avelength_pros_act_filed := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pros_act_filed)),h.pros_act_filed<>(typeof(h.pros_act_filed))'');
    populated_court_case_number_cnt := COUNT(GROUP,h.court_case_number <> (TYPEOF(h.court_case_number))'');
    populated_court_case_number_pcnt := AVE(GROUP,IF(h.court_case_number = (TYPEOF(h.court_case_number))'',0,100));
    maxlength_court_case_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_case_number)));
    avelength_court_case_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_case_number)),h.court_case_number<>(typeof(h.court_case_number))'');
    populated_court_cd_cnt := COUNT(GROUP,h.court_cd <> (TYPEOF(h.court_cd))'');
    populated_court_cd_pcnt := AVE(GROUP,IF(h.court_cd = (TYPEOF(h.court_cd))'',0,100));
    maxlength_court_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_cd)));
    avelength_court_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_cd)),h.court_cd<>(typeof(h.court_cd))'');
    populated_court_desc_cnt := COUNT(GROUP,h.court_desc <> (TYPEOF(h.court_desc))'');
    populated_court_desc_pcnt := AVE(GROUP,IF(h.court_desc = (TYPEOF(h.court_desc))'',0,100));
    maxlength_court_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_desc)));
    avelength_court_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_desc)),h.court_desc<>(typeof(h.court_desc))'');
    populated_court_appeal_flag_cnt := COUNT(GROUP,h.court_appeal_flag <> (TYPEOF(h.court_appeal_flag))'');
    populated_court_appeal_flag_pcnt := AVE(GROUP,IF(h.court_appeal_flag = (TYPEOF(h.court_appeal_flag))'',0,100));
    maxlength_court_appeal_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_appeal_flag)));
    avelength_court_appeal_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_appeal_flag)),h.court_appeal_flag<>(typeof(h.court_appeal_flag))'');
    populated_court_final_plea_cnt := COUNT(GROUP,h.court_final_plea <> (TYPEOF(h.court_final_plea))'');
    populated_court_final_plea_pcnt := AVE(GROUP,IF(h.court_final_plea = (TYPEOF(h.court_final_plea))'',0,100));
    maxlength_court_final_plea := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_final_plea)));
    avelength_court_final_plea := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_final_plea)),h.court_final_plea<>(typeof(h.court_final_plea))'');
    populated_court_off_code_cnt := COUNT(GROUP,h.court_off_code <> (TYPEOF(h.court_off_code))'');
    populated_court_off_code_pcnt := AVE(GROUP,IF(h.court_off_code = (TYPEOF(h.court_off_code))'',0,100));
    maxlength_court_off_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_off_code)));
    avelength_court_off_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_off_code)),h.court_off_code<>(typeof(h.court_off_code))'');
    populated_court_off_desc_1_cnt := COUNT(GROUP,h.court_off_desc_1 <> (TYPEOF(h.court_off_desc_1))'');
    populated_court_off_desc_1_pcnt := AVE(GROUP,IF(h.court_off_desc_1 = (TYPEOF(h.court_off_desc_1))'',0,100));
    maxlength_court_off_desc_1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_off_desc_1)));
    avelength_court_off_desc_1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_off_desc_1)),h.court_off_desc_1<>(typeof(h.court_off_desc_1))'');
    populated_court_off_desc_2_cnt := COUNT(GROUP,h.court_off_desc_2 <> (TYPEOF(h.court_off_desc_2))'');
    populated_court_off_desc_2_pcnt := AVE(GROUP,IF(h.court_off_desc_2 = (TYPEOF(h.court_off_desc_2))'',0,100));
    maxlength_court_off_desc_2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_off_desc_2)));
    avelength_court_off_desc_2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_off_desc_2)),h.court_off_desc_2<>(typeof(h.court_off_desc_2))'');
    populated_court_off_type_cd_cnt := COUNT(GROUP,h.court_off_type_cd <> (TYPEOF(h.court_off_type_cd))'');
    populated_court_off_type_cd_pcnt := AVE(GROUP,IF(h.court_off_type_cd = (TYPEOF(h.court_off_type_cd))'',0,100));
    maxlength_court_off_type_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_off_type_cd)));
    avelength_court_off_type_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_off_type_cd)),h.court_off_type_cd<>(typeof(h.court_off_type_cd))'');
    populated_court_off_type_desc_cnt := COUNT(GROUP,h.court_off_type_desc <> (TYPEOF(h.court_off_type_desc))'');
    populated_court_off_type_desc_pcnt := AVE(GROUP,IF(h.court_off_type_desc = (TYPEOF(h.court_off_type_desc))'',0,100));
    maxlength_court_off_type_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_off_type_desc)));
    avelength_court_off_type_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_off_type_desc)),h.court_off_type_desc<>(typeof(h.court_off_type_desc))'');
    populated_court_off_lev_cnt := COUNT(GROUP,h.court_off_lev <> (TYPEOF(h.court_off_lev))'');
    populated_court_off_lev_pcnt := AVE(GROUP,IF(h.court_off_lev = (TYPEOF(h.court_off_lev))'',0,100));
    maxlength_court_off_lev := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_off_lev)));
    avelength_court_off_lev := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_off_lev)),h.court_off_lev<>(typeof(h.court_off_lev))'');
    populated_court_statute_cnt := COUNT(GROUP,h.court_statute <> (TYPEOF(h.court_statute))'');
    populated_court_statute_pcnt := AVE(GROUP,IF(h.court_statute = (TYPEOF(h.court_statute))'',0,100));
    maxlength_court_statute := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_statute)));
    avelength_court_statute := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_statute)),h.court_statute<>(typeof(h.court_statute))'');
    populated_court_additional_statutes_cnt := COUNT(GROUP,h.court_additional_statutes <> (TYPEOF(h.court_additional_statutes))'');
    populated_court_additional_statutes_pcnt := AVE(GROUP,IF(h.court_additional_statutes = (TYPEOF(h.court_additional_statutes))'',0,100));
    maxlength_court_additional_statutes := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_additional_statutes)));
    avelength_court_additional_statutes := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_additional_statutes)),h.court_additional_statutes<>(typeof(h.court_additional_statutes))'');
    populated_court_statute_desc_cnt := COUNT(GROUP,h.court_statute_desc <> (TYPEOF(h.court_statute_desc))'');
    populated_court_statute_desc_pcnt := AVE(GROUP,IF(h.court_statute_desc = (TYPEOF(h.court_statute_desc))'',0,100));
    maxlength_court_statute_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_statute_desc)));
    avelength_court_statute_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_statute_desc)),h.court_statute_desc<>(typeof(h.court_statute_desc))'');
    populated_court_disp_date_cnt := COUNT(GROUP,h.court_disp_date <> (TYPEOF(h.court_disp_date))'');
    populated_court_disp_date_pcnt := AVE(GROUP,IF(h.court_disp_date = (TYPEOF(h.court_disp_date))'',0,100));
    maxlength_court_disp_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_disp_date)));
    avelength_court_disp_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_disp_date)),h.court_disp_date<>(typeof(h.court_disp_date))'');
    populated_court_disp_code_cnt := COUNT(GROUP,h.court_disp_code <> (TYPEOF(h.court_disp_code))'');
    populated_court_disp_code_pcnt := AVE(GROUP,IF(h.court_disp_code = (TYPEOF(h.court_disp_code))'',0,100));
    maxlength_court_disp_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_disp_code)));
    avelength_court_disp_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_disp_code)),h.court_disp_code<>(typeof(h.court_disp_code))'');
    populated_court_disp_desc_1_cnt := COUNT(GROUP,h.court_disp_desc_1 <> (TYPEOF(h.court_disp_desc_1))'');
    populated_court_disp_desc_1_pcnt := AVE(GROUP,IF(h.court_disp_desc_1 = (TYPEOF(h.court_disp_desc_1))'',0,100));
    maxlength_court_disp_desc_1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_disp_desc_1)));
    avelength_court_disp_desc_1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_disp_desc_1)),h.court_disp_desc_1<>(typeof(h.court_disp_desc_1))'');
    populated_court_disp_desc_2_cnt := COUNT(GROUP,h.court_disp_desc_2 <> (TYPEOF(h.court_disp_desc_2))'');
    populated_court_disp_desc_2_pcnt := AVE(GROUP,IF(h.court_disp_desc_2 = (TYPEOF(h.court_disp_desc_2))'',0,100));
    maxlength_court_disp_desc_2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_disp_desc_2)));
    avelength_court_disp_desc_2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_disp_desc_2)),h.court_disp_desc_2<>(typeof(h.court_disp_desc_2))'');
    populated_sent_date_cnt := COUNT(GROUP,h.sent_date <> (TYPEOF(h.sent_date))'');
    populated_sent_date_pcnt := AVE(GROUP,IF(h.sent_date = (TYPEOF(h.sent_date))'',0,100));
    maxlength_sent_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sent_date)));
    avelength_sent_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sent_date)),h.sent_date<>(typeof(h.sent_date))'');
    populated_sent_jail_cnt := COUNT(GROUP,h.sent_jail <> (TYPEOF(h.sent_jail))'');
    populated_sent_jail_pcnt := AVE(GROUP,IF(h.sent_jail = (TYPEOF(h.sent_jail))'',0,100));
    maxlength_sent_jail := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sent_jail)));
    avelength_sent_jail := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sent_jail)),h.sent_jail<>(typeof(h.sent_jail))'');
    populated_sent_susp_time_cnt := COUNT(GROUP,h.sent_susp_time <> (TYPEOF(h.sent_susp_time))'');
    populated_sent_susp_time_pcnt := AVE(GROUP,IF(h.sent_susp_time = (TYPEOF(h.sent_susp_time))'',0,100));
    maxlength_sent_susp_time := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sent_susp_time)));
    avelength_sent_susp_time := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sent_susp_time)),h.sent_susp_time<>(typeof(h.sent_susp_time))'');
    populated_sent_court_cost_cnt := COUNT(GROUP,h.sent_court_cost <> (TYPEOF(h.sent_court_cost))'');
    populated_sent_court_cost_pcnt := AVE(GROUP,IF(h.sent_court_cost = (TYPEOF(h.sent_court_cost))'',0,100));
    maxlength_sent_court_cost := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sent_court_cost)));
    avelength_sent_court_cost := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sent_court_cost)),h.sent_court_cost<>(typeof(h.sent_court_cost))'');
    populated_sent_court_fine_cnt := COUNT(GROUP,h.sent_court_fine <> (TYPEOF(h.sent_court_fine))'');
    populated_sent_court_fine_pcnt := AVE(GROUP,IF(h.sent_court_fine = (TYPEOF(h.sent_court_fine))'',0,100));
    maxlength_sent_court_fine := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sent_court_fine)));
    avelength_sent_court_fine := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sent_court_fine)),h.sent_court_fine<>(typeof(h.sent_court_fine))'');
    populated_sent_susp_court_fine_cnt := COUNT(GROUP,h.sent_susp_court_fine <> (TYPEOF(h.sent_susp_court_fine))'');
    populated_sent_susp_court_fine_pcnt := AVE(GROUP,IF(h.sent_susp_court_fine = (TYPEOF(h.sent_susp_court_fine))'',0,100));
    maxlength_sent_susp_court_fine := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sent_susp_court_fine)));
    avelength_sent_susp_court_fine := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sent_susp_court_fine)),h.sent_susp_court_fine<>(typeof(h.sent_susp_court_fine))'');
    populated_sent_probation_cnt := COUNT(GROUP,h.sent_probation <> (TYPEOF(h.sent_probation))'');
    populated_sent_probation_pcnt := AVE(GROUP,IF(h.sent_probation = (TYPEOF(h.sent_probation))'',0,100));
    maxlength_sent_probation := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sent_probation)));
    avelength_sent_probation := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sent_probation)),h.sent_probation<>(typeof(h.sent_probation))'');
    populated_sent_addl_prov_code_cnt := COUNT(GROUP,h.sent_addl_prov_code <> (TYPEOF(h.sent_addl_prov_code))'');
    populated_sent_addl_prov_code_pcnt := AVE(GROUP,IF(h.sent_addl_prov_code = (TYPEOF(h.sent_addl_prov_code))'',0,100));
    maxlength_sent_addl_prov_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sent_addl_prov_code)));
    avelength_sent_addl_prov_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sent_addl_prov_code)),h.sent_addl_prov_code<>(typeof(h.sent_addl_prov_code))'');
    populated_sent_addl_prov_desc_1_cnt := COUNT(GROUP,h.sent_addl_prov_desc_1 <> (TYPEOF(h.sent_addl_prov_desc_1))'');
    populated_sent_addl_prov_desc_1_pcnt := AVE(GROUP,IF(h.sent_addl_prov_desc_1 = (TYPEOF(h.sent_addl_prov_desc_1))'',0,100));
    maxlength_sent_addl_prov_desc_1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sent_addl_prov_desc_1)));
    avelength_sent_addl_prov_desc_1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sent_addl_prov_desc_1)),h.sent_addl_prov_desc_1<>(typeof(h.sent_addl_prov_desc_1))'');
    populated_sent_addl_prov_desc_2_cnt := COUNT(GROUP,h.sent_addl_prov_desc_2 <> (TYPEOF(h.sent_addl_prov_desc_2))'');
    populated_sent_addl_prov_desc_2_pcnt := AVE(GROUP,IF(h.sent_addl_prov_desc_2 = (TYPEOF(h.sent_addl_prov_desc_2))'',0,100));
    maxlength_sent_addl_prov_desc_2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sent_addl_prov_desc_2)));
    avelength_sent_addl_prov_desc_2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sent_addl_prov_desc_2)),h.sent_addl_prov_desc_2<>(typeof(h.sent_addl_prov_desc_2))'');
    populated_sent_consec_cnt := COUNT(GROUP,h.sent_consec <> (TYPEOF(h.sent_consec))'');
    populated_sent_consec_pcnt := AVE(GROUP,IF(h.sent_consec = (TYPEOF(h.sent_consec))'',0,100));
    maxlength_sent_consec := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sent_consec)));
    avelength_sent_consec := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sent_consec)),h.sent_consec<>(typeof(h.sent_consec))'');
    populated_sent_agency_rec_cust_ori_cnt := COUNT(GROUP,h.sent_agency_rec_cust_ori <> (TYPEOF(h.sent_agency_rec_cust_ori))'');
    populated_sent_agency_rec_cust_ori_pcnt := AVE(GROUP,IF(h.sent_agency_rec_cust_ori = (TYPEOF(h.sent_agency_rec_cust_ori))'',0,100));
    maxlength_sent_agency_rec_cust_ori := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sent_agency_rec_cust_ori)));
    avelength_sent_agency_rec_cust_ori := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sent_agency_rec_cust_ori)),h.sent_agency_rec_cust_ori<>(typeof(h.sent_agency_rec_cust_ori))'');
    populated_sent_agency_rec_cust_cnt := COUNT(GROUP,h.sent_agency_rec_cust <> (TYPEOF(h.sent_agency_rec_cust))'');
    populated_sent_agency_rec_cust_pcnt := AVE(GROUP,IF(h.sent_agency_rec_cust = (TYPEOF(h.sent_agency_rec_cust))'',0,100));
    maxlength_sent_agency_rec_cust := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sent_agency_rec_cust)));
    avelength_sent_agency_rec_cust := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sent_agency_rec_cust)),h.sent_agency_rec_cust<>(typeof(h.sent_agency_rec_cust))'');
    populated_appeal_date_cnt := COUNT(GROUP,h.appeal_date <> (TYPEOF(h.appeal_date))'');
    populated_appeal_date_pcnt := AVE(GROUP,IF(h.appeal_date = (TYPEOF(h.appeal_date))'',0,100));
    maxlength_appeal_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.appeal_date)));
    avelength_appeal_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.appeal_date)),h.appeal_date<>(typeof(h.appeal_date))'');
    populated_appeal_off_disp_cnt := COUNT(GROUP,h.appeal_off_disp <> (TYPEOF(h.appeal_off_disp))'');
    populated_appeal_off_disp_pcnt := AVE(GROUP,IF(h.appeal_off_disp = (TYPEOF(h.appeal_off_disp))'',0,100));
    maxlength_appeal_off_disp := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.appeal_off_disp)));
    avelength_appeal_off_disp := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.appeal_off_disp)),h.appeal_off_disp<>(typeof(h.appeal_off_disp))'');
    populated_appeal_final_decision_cnt := COUNT(GROUP,h.appeal_final_decision <> (TYPEOF(h.appeal_final_decision))'');
    populated_appeal_final_decision_pcnt := AVE(GROUP,IF(h.appeal_final_decision = (TYPEOF(h.appeal_final_decision))'',0,100));
    maxlength_appeal_final_decision := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.appeal_final_decision)));
    avelength_appeal_final_decision := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.appeal_final_decision)),h.appeal_final_decision<>(typeof(h.appeal_final_decision))'');
    populated_convict_dt_cnt := COUNT(GROUP,h.convict_dt <> (TYPEOF(h.convict_dt))'');
    populated_convict_dt_pcnt := AVE(GROUP,IF(h.convict_dt = (TYPEOF(h.convict_dt))'',0,100));
    maxlength_convict_dt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.convict_dt)));
    avelength_convict_dt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.convict_dt)),h.convict_dt<>(typeof(h.convict_dt))'');
    populated_offense_town_cnt := COUNT(GROUP,h.offense_town <> (TYPEOF(h.offense_town))'');
    populated_offense_town_pcnt := AVE(GROUP,IF(h.offense_town = (TYPEOF(h.offense_town))'',0,100));
    maxlength_offense_town := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.offense_town)));
    avelength_offense_town := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.offense_town)),h.offense_town<>(typeof(h.offense_town))'');
    populated_cty_conv_cnt := COUNT(GROUP,h.cty_conv <> (TYPEOF(h.cty_conv))'');
    populated_cty_conv_pcnt := AVE(GROUP,IF(h.cty_conv = (TYPEOF(h.cty_conv))'',0,100));
    maxlength_cty_conv := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cty_conv)));
    avelength_cty_conv := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cty_conv)),h.cty_conv<>(typeof(h.cty_conv))'');
    populated_restitution_cnt := COUNT(GROUP,h.restitution <> (TYPEOF(h.restitution))'');
    populated_restitution_pcnt := AVE(GROUP,IF(h.restitution = (TYPEOF(h.restitution))'',0,100));
    maxlength_restitution := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.restitution)));
    avelength_restitution := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.restitution)),h.restitution<>(typeof(h.restitution))'');
    populated_community_service_cnt := COUNT(GROUP,h.community_service <> (TYPEOF(h.community_service))'');
    populated_community_service_pcnt := AVE(GROUP,IF(h.community_service = (TYPEOF(h.community_service))'',0,100));
    maxlength_community_service := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.community_service)));
    avelength_community_service := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.community_service)),h.community_service<>(typeof(h.community_service))'');
    populated_parole_cnt := COUNT(GROUP,h.parole <> (TYPEOF(h.parole))'');
    populated_parole_pcnt := AVE(GROUP,IF(h.parole = (TYPEOF(h.parole))'',0,100));
    maxlength_parole := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.parole)));
    avelength_parole := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.parole)),h.parole<>(typeof(h.parole))'');
    populated_addl_sent_dates_cnt := COUNT(GROUP,h.addl_sent_dates <> (TYPEOF(h.addl_sent_dates))'');
    populated_addl_sent_dates_pcnt := AVE(GROUP,IF(h.addl_sent_dates = (TYPEOF(h.addl_sent_dates))'',0,100));
    maxlength_addl_sent_dates := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addl_sent_dates)));
    avelength_addl_sent_dates := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addl_sent_dates)),h.addl_sent_dates<>(typeof(h.addl_sent_dates))'');
    populated_probation_desc2_cnt := COUNT(GROUP,h.probation_desc2 <> (TYPEOF(h.probation_desc2))'');
    populated_probation_desc2_pcnt := AVE(GROUP,IF(h.probation_desc2 = (TYPEOF(h.probation_desc2))'',0,100));
    maxlength_probation_desc2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.probation_desc2)));
    avelength_probation_desc2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.probation_desc2)),h.probation_desc2<>(typeof(h.probation_desc2))'');
    populated_court_dt_cnt := COUNT(GROUP,h.court_dt <> (TYPEOF(h.court_dt))'');
    populated_court_dt_pcnt := AVE(GROUP,IF(h.court_dt = (TYPEOF(h.court_dt))'',0,100));
    maxlength_court_dt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_dt)));
    avelength_court_dt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_dt)),h.court_dt<>(typeof(h.court_dt))'');
    populated_court_county_cnt := COUNT(GROUP,h.court_county <> (TYPEOF(h.court_county))'');
    populated_court_county_pcnt := AVE(GROUP,IF(h.court_county = (TYPEOF(h.court_county))'',0,100));
    maxlength_court_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_county)));
    avelength_court_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_county)),h.court_county<>(typeof(h.court_county))'');
    populated_arr_off_lev_mapped_cnt := COUNT(GROUP,h.arr_off_lev_mapped <> (TYPEOF(h.arr_off_lev_mapped))'');
    populated_arr_off_lev_mapped_pcnt := AVE(GROUP,IF(h.arr_off_lev_mapped = (TYPEOF(h.arr_off_lev_mapped))'',0,100));
    maxlength_arr_off_lev_mapped := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.arr_off_lev_mapped)));
    avelength_arr_off_lev_mapped := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.arr_off_lev_mapped)),h.arr_off_lev_mapped<>(typeof(h.arr_off_lev_mapped))'');
    populated_court_off_lev_mapped_cnt := COUNT(GROUP,h.court_off_lev_mapped <> (TYPEOF(h.court_off_lev_mapped))'');
    populated_court_off_lev_mapped_pcnt := AVE(GROUP,IF(h.court_off_lev_mapped = (TYPEOF(h.court_off_lev_mapped))'',0,100));
    maxlength_court_off_lev_mapped := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_off_lev_mapped)));
    avelength_court_off_lev_mapped := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.court_off_lev_mapped)),h.court_off_lev_mapped<>(typeof(h.court_off_lev_mapped))'');
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
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,vendor,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_offender_key_pcnt *   0.00 / 100 + T.Populated_vendor_pcnt *   0.00 / 100 + T.Populated_state_origin_pcnt *   0.00 / 100 + T.Populated_source_file_pcnt *   0.00 / 100 + T.Populated_data_type_pcnt *   0.00 / 100 + T.Populated_off_comp_pcnt *   0.00 / 100 + T.Populated_off_delete_flag_pcnt *   0.00 / 100 + T.Populated_off_date_pcnt *   0.00 / 100 + T.Populated_arr_date_pcnt *   0.00 / 100 + T.Populated_num_of_counts_pcnt *   0.00 / 100 + T.Populated_le_agency_cd_pcnt *   0.00 / 100 + T.Populated_le_agency_desc_pcnt *   0.00 / 100 + T.Populated_le_agency_case_number_pcnt *   0.00 / 100 + T.Populated_traffic_ticket_number_pcnt *   0.00 / 100 + T.Populated_traffic_dl_no_pcnt *   0.00 / 100 + T.Populated_traffic_dl_st_pcnt *   0.00 / 100 + T.Populated_arr_off_code_pcnt *   0.00 / 100 + T.Populated_arr_off_desc_1_pcnt *   0.00 / 100 + T.Populated_arr_off_desc_2_pcnt *   0.00 / 100 + T.Populated_arr_off_type_cd_pcnt *   0.00 / 100 + T.Populated_arr_off_type_desc_pcnt *   0.00 / 100 + T.Populated_arr_off_lev_pcnt *   0.00 / 100 + T.Populated_arr_statute_pcnt *   0.00 / 100 + T.Populated_arr_statute_desc_pcnt *   0.00 / 100 + T.Populated_arr_disp_date_pcnt *   0.00 / 100 + T.Populated_arr_disp_code_pcnt *   0.00 / 100 + T.Populated_arr_disp_desc_1_pcnt *   0.00 / 100 + T.Populated_arr_disp_desc_2_pcnt *   0.00 / 100 + T.Populated_pros_refer_cd_pcnt *   0.00 / 100 + T.Populated_pros_refer_pcnt *   0.00 / 100 + T.Populated_pros_assgn_cd_pcnt *   0.00 / 100 + T.Populated_pros_assgn_pcnt *   0.00 / 100 + T.Populated_pros_chg_rej_pcnt *   0.00 / 100 + T.Populated_pros_off_code_pcnt *   0.00 / 100 + T.Populated_pros_off_desc_1_pcnt *   0.00 / 100 + T.Populated_pros_off_desc_2_pcnt *   0.00 / 100 + T.Populated_pros_off_type_cd_pcnt *   0.00 / 100 + T.Populated_pros_off_type_desc_pcnt *   0.00 / 100 + T.Populated_pros_off_lev_pcnt *   0.00 / 100 + T.Populated_pros_act_filed_pcnt *   0.00 / 100 + T.Populated_court_case_number_pcnt *   0.00 / 100 + T.Populated_court_cd_pcnt *   0.00 / 100 + T.Populated_court_desc_pcnt *   0.00 / 100 + T.Populated_court_appeal_flag_pcnt *   0.00 / 100 + T.Populated_court_final_plea_pcnt *   0.00 / 100 + T.Populated_court_off_code_pcnt *   0.00 / 100 + T.Populated_court_off_desc_1_pcnt *   0.00 / 100 + T.Populated_court_off_desc_2_pcnt *   0.00 / 100 + T.Populated_court_off_type_cd_pcnt *   0.00 / 100 + T.Populated_court_off_type_desc_pcnt *   0.00 / 100 + T.Populated_court_off_lev_pcnt *   0.00 / 100 + T.Populated_court_statute_pcnt *   0.00 / 100 + T.Populated_court_additional_statutes_pcnt *   0.00 / 100 + T.Populated_court_statute_desc_pcnt *   0.00 / 100 + T.Populated_court_disp_date_pcnt *   0.00 / 100 + T.Populated_court_disp_code_pcnt *   0.00 / 100 + T.Populated_court_disp_desc_1_pcnt *   0.00 / 100 + T.Populated_court_disp_desc_2_pcnt *   0.00 / 100 + T.Populated_sent_date_pcnt *   0.00 / 100 + T.Populated_sent_jail_pcnt *   0.00 / 100 + T.Populated_sent_susp_time_pcnt *   0.00 / 100 + T.Populated_sent_court_cost_pcnt *   0.00 / 100 + T.Populated_sent_court_fine_pcnt *   0.00 / 100 + T.Populated_sent_susp_court_fine_pcnt *   0.00 / 100 + T.Populated_sent_probation_pcnt *   0.00 / 100 + T.Populated_sent_addl_prov_code_pcnt *   0.00 / 100 + T.Populated_sent_addl_prov_desc_1_pcnt *   0.00 / 100 + T.Populated_sent_addl_prov_desc_2_pcnt *   0.00 / 100 + T.Populated_sent_consec_pcnt *   0.00 / 100 + T.Populated_sent_agency_rec_cust_ori_pcnt *   0.00 / 100 + T.Populated_sent_agency_rec_cust_pcnt *   0.00 / 100 + T.Populated_appeal_date_pcnt *   0.00 / 100 + T.Populated_appeal_off_disp_pcnt *   0.00 / 100 + T.Populated_appeal_final_decision_pcnt *   0.00 / 100 + T.Populated_convict_dt_pcnt *   0.00 / 100 + T.Populated_offense_town_pcnt *   0.00 / 100 + T.Populated_cty_conv_pcnt *   0.00 / 100 + T.Populated_restitution_pcnt *   0.00 / 100 + T.Populated_community_service_pcnt *   0.00 / 100 + T.Populated_parole_pcnt *   0.00 / 100 + T.Populated_addl_sent_dates_pcnt *   0.00 / 100 + T.Populated_probation_desc2_pcnt *   0.00 / 100 + T.Populated_court_dt_pcnt *   0.00 / 100 + T.Populated_court_county_pcnt *   0.00 / 100 + T.Populated_arr_off_lev_mapped_pcnt *   0.00 / 100 + T.Populated_court_off_lev_mapped_pcnt *   0.00 / 100 + T.Populated_fcra_offense_key_pcnt *   0.00 / 100 + T.Populated_fcra_conviction_flag_pcnt *   0.00 / 100 + T.Populated_fcra_traffic_flag_pcnt *   0.00 / 100 + T.Populated_fcra_date_pcnt *   0.00 / 100 + T.Populated_fcra_date_type_pcnt *   0.00 / 100 + T.Populated_conviction_override_date_pcnt *   0.00 / 100 + T.Populated_conviction_override_date_type_pcnt *   0.00 / 100 + T.Populated_offense_score_pcnt *   0.00 / 100 + T.Populated_offense_persistent_id_pcnt *   0.00 / 100 + T.Populated_offense_category_pcnt *   0.00 / 100;
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
    SELF.LinkingPotential := 0 + le.Populated_process_date_pcnt*ri.Populated_process_date_pcnt *   0.00 / 10000 + le.Populated_offender_key_pcnt*ri.Populated_offender_key_pcnt *   0.00 / 10000 + le.Populated_vendor_pcnt*ri.Populated_vendor_pcnt *   0.00 / 10000 + le.Populated_state_origin_pcnt*ri.Populated_state_origin_pcnt *   0.00 / 10000 + le.Populated_source_file_pcnt*ri.Populated_source_file_pcnt *   0.00 / 10000 + le.Populated_data_type_pcnt*ri.Populated_data_type_pcnt *   0.00 / 10000 + le.Populated_off_comp_pcnt*ri.Populated_off_comp_pcnt *   0.00 / 10000 + le.Populated_off_delete_flag_pcnt*ri.Populated_off_delete_flag_pcnt *   0.00 / 10000 + le.Populated_off_date_pcnt*ri.Populated_off_date_pcnt *   0.00 / 10000 + le.Populated_arr_date_pcnt*ri.Populated_arr_date_pcnt *   0.00 / 10000 + le.Populated_num_of_counts_pcnt*ri.Populated_num_of_counts_pcnt *   0.00 / 10000 + le.Populated_le_agency_cd_pcnt*ri.Populated_le_agency_cd_pcnt *   0.00 / 10000 + le.Populated_le_agency_desc_pcnt*ri.Populated_le_agency_desc_pcnt *   0.00 / 10000 + le.Populated_le_agency_case_number_pcnt*ri.Populated_le_agency_case_number_pcnt *   0.00 / 10000 + le.Populated_traffic_ticket_number_pcnt*ri.Populated_traffic_ticket_number_pcnt *   0.00 / 10000 + le.Populated_traffic_dl_no_pcnt*ri.Populated_traffic_dl_no_pcnt *   0.00 / 10000 + le.Populated_traffic_dl_st_pcnt*ri.Populated_traffic_dl_st_pcnt *   0.00 / 10000 + le.Populated_arr_off_code_pcnt*ri.Populated_arr_off_code_pcnt *   0.00 / 10000 + le.Populated_arr_off_desc_1_pcnt*ri.Populated_arr_off_desc_1_pcnt *   0.00 / 10000 + le.Populated_arr_off_desc_2_pcnt*ri.Populated_arr_off_desc_2_pcnt *   0.00 / 10000 + le.Populated_arr_off_type_cd_pcnt*ri.Populated_arr_off_type_cd_pcnt *   0.00 / 10000 + le.Populated_arr_off_type_desc_pcnt*ri.Populated_arr_off_type_desc_pcnt *   0.00 / 10000 + le.Populated_arr_off_lev_pcnt*ri.Populated_arr_off_lev_pcnt *   0.00 / 10000 + le.Populated_arr_statute_pcnt*ri.Populated_arr_statute_pcnt *   0.00 / 10000 + le.Populated_arr_statute_desc_pcnt*ri.Populated_arr_statute_desc_pcnt *   0.00 / 10000 + le.Populated_arr_disp_date_pcnt*ri.Populated_arr_disp_date_pcnt *   0.00 / 10000 + le.Populated_arr_disp_code_pcnt*ri.Populated_arr_disp_code_pcnt *   0.00 / 10000 + le.Populated_arr_disp_desc_1_pcnt*ri.Populated_arr_disp_desc_1_pcnt *   0.00 / 10000 + le.Populated_arr_disp_desc_2_pcnt*ri.Populated_arr_disp_desc_2_pcnt *   0.00 / 10000 + le.Populated_pros_refer_cd_pcnt*ri.Populated_pros_refer_cd_pcnt *   0.00 / 10000 + le.Populated_pros_refer_pcnt*ri.Populated_pros_refer_pcnt *   0.00 / 10000 + le.Populated_pros_assgn_cd_pcnt*ri.Populated_pros_assgn_cd_pcnt *   0.00 / 10000 + le.Populated_pros_assgn_pcnt*ri.Populated_pros_assgn_pcnt *   0.00 / 10000 + le.Populated_pros_chg_rej_pcnt*ri.Populated_pros_chg_rej_pcnt *   0.00 / 10000 + le.Populated_pros_off_code_pcnt*ri.Populated_pros_off_code_pcnt *   0.00 / 10000 + le.Populated_pros_off_desc_1_pcnt*ri.Populated_pros_off_desc_1_pcnt *   0.00 / 10000 + le.Populated_pros_off_desc_2_pcnt*ri.Populated_pros_off_desc_2_pcnt *   0.00 / 10000 + le.Populated_pros_off_type_cd_pcnt*ri.Populated_pros_off_type_cd_pcnt *   0.00 / 10000 + le.Populated_pros_off_type_desc_pcnt*ri.Populated_pros_off_type_desc_pcnt *   0.00 / 10000 + le.Populated_pros_off_lev_pcnt*ri.Populated_pros_off_lev_pcnt *   0.00 / 10000 + le.Populated_pros_act_filed_pcnt*ri.Populated_pros_act_filed_pcnt *   0.00 / 10000 + le.Populated_court_case_number_pcnt*ri.Populated_court_case_number_pcnt *   0.00 / 10000 + le.Populated_court_cd_pcnt*ri.Populated_court_cd_pcnt *   0.00 / 10000 + le.Populated_court_desc_pcnt*ri.Populated_court_desc_pcnt *   0.00 / 10000 + le.Populated_court_appeal_flag_pcnt*ri.Populated_court_appeal_flag_pcnt *   0.00 / 10000 + le.Populated_court_final_plea_pcnt*ri.Populated_court_final_plea_pcnt *   0.00 / 10000 + le.Populated_court_off_code_pcnt*ri.Populated_court_off_code_pcnt *   0.00 / 10000 + le.Populated_court_off_desc_1_pcnt*ri.Populated_court_off_desc_1_pcnt *   0.00 / 10000 + le.Populated_court_off_desc_2_pcnt*ri.Populated_court_off_desc_2_pcnt *   0.00 / 10000 + le.Populated_court_off_type_cd_pcnt*ri.Populated_court_off_type_cd_pcnt *   0.00 / 10000 + le.Populated_court_off_type_desc_pcnt*ri.Populated_court_off_type_desc_pcnt *   0.00 / 10000 + le.Populated_court_off_lev_pcnt*ri.Populated_court_off_lev_pcnt *   0.00 / 10000 + le.Populated_court_statute_pcnt*ri.Populated_court_statute_pcnt *   0.00 / 10000 + le.Populated_court_additional_statutes_pcnt*ri.Populated_court_additional_statutes_pcnt *   0.00 / 10000 + le.Populated_court_statute_desc_pcnt*ri.Populated_court_statute_desc_pcnt *   0.00 / 10000 + le.Populated_court_disp_date_pcnt*ri.Populated_court_disp_date_pcnt *   0.00 / 10000 + le.Populated_court_disp_code_pcnt*ri.Populated_court_disp_code_pcnt *   0.00 / 10000 + le.Populated_court_disp_desc_1_pcnt*ri.Populated_court_disp_desc_1_pcnt *   0.00 / 10000 + le.Populated_court_disp_desc_2_pcnt*ri.Populated_court_disp_desc_2_pcnt *   0.00 / 10000 + le.Populated_sent_date_pcnt*ri.Populated_sent_date_pcnt *   0.00 / 10000 + le.Populated_sent_jail_pcnt*ri.Populated_sent_jail_pcnt *   0.00 / 10000 + le.Populated_sent_susp_time_pcnt*ri.Populated_sent_susp_time_pcnt *   0.00 / 10000 + le.Populated_sent_court_cost_pcnt*ri.Populated_sent_court_cost_pcnt *   0.00 / 10000 + le.Populated_sent_court_fine_pcnt*ri.Populated_sent_court_fine_pcnt *   0.00 / 10000 + le.Populated_sent_susp_court_fine_pcnt*ri.Populated_sent_susp_court_fine_pcnt *   0.00 / 10000 + le.Populated_sent_probation_pcnt*ri.Populated_sent_probation_pcnt *   0.00 / 10000 + le.Populated_sent_addl_prov_code_pcnt*ri.Populated_sent_addl_prov_code_pcnt *   0.00 / 10000 + le.Populated_sent_addl_prov_desc_1_pcnt*ri.Populated_sent_addl_prov_desc_1_pcnt *   0.00 / 10000 + le.Populated_sent_addl_prov_desc_2_pcnt*ri.Populated_sent_addl_prov_desc_2_pcnt *   0.00 / 10000 + le.Populated_sent_consec_pcnt*ri.Populated_sent_consec_pcnt *   0.00 / 10000 + le.Populated_sent_agency_rec_cust_ori_pcnt*ri.Populated_sent_agency_rec_cust_ori_pcnt *   0.00 / 10000 + le.Populated_sent_agency_rec_cust_pcnt*ri.Populated_sent_agency_rec_cust_pcnt *   0.00 / 10000 + le.Populated_appeal_date_pcnt*ri.Populated_appeal_date_pcnt *   0.00 / 10000 + le.Populated_appeal_off_disp_pcnt*ri.Populated_appeal_off_disp_pcnt *   0.00 / 10000 + le.Populated_appeal_final_decision_pcnt*ri.Populated_appeal_final_decision_pcnt *   0.00 / 10000 + le.Populated_convict_dt_pcnt*ri.Populated_convict_dt_pcnt *   0.00 / 10000 + le.Populated_offense_town_pcnt*ri.Populated_offense_town_pcnt *   0.00 / 10000 + le.Populated_cty_conv_pcnt*ri.Populated_cty_conv_pcnt *   0.00 / 10000 + le.Populated_restitution_pcnt*ri.Populated_restitution_pcnt *   0.00 / 10000 + le.Populated_community_service_pcnt*ri.Populated_community_service_pcnt *   0.00 / 10000 + le.Populated_parole_pcnt*ri.Populated_parole_pcnt *   0.00 / 10000 + le.Populated_addl_sent_dates_pcnt*ri.Populated_addl_sent_dates_pcnt *   0.00 / 10000 + le.Populated_probation_desc2_pcnt*ri.Populated_probation_desc2_pcnt *   0.00 / 10000 + le.Populated_court_dt_pcnt*ri.Populated_court_dt_pcnt *   0.00 / 10000 + le.Populated_court_county_pcnt*ri.Populated_court_county_pcnt *   0.00 / 10000 + le.Populated_arr_off_lev_mapped_pcnt*ri.Populated_arr_off_lev_mapped_pcnt *   0.00 / 10000 + le.Populated_court_off_lev_mapped_pcnt*ri.Populated_court_off_lev_mapped_pcnt *   0.00 / 10000 + le.Populated_fcra_offense_key_pcnt*ri.Populated_fcra_offense_key_pcnt *   0.00 / 10000 + le.Populated_fcra_conviction_flag_pcnt*ri.Populated_fcra_conviction_flag_pcnt *   0.00 / 10000 + le.Populated_fcra_traffic_flag_pcnt*ri.Populated_fcra_traffic_flag_pcnt *   0.00 / 10000 + le.Populated_fcra_date_pcnt*ri.Populated_fcra_date_pcnt *   0.00 / 10000 + le.Populated_fcra_date_type_pcnt*ri.Populated_fcra_date_type_pcnt *   0.00 / 10000 + le.Populated_conviction_override_date_pcnt*ri.Populated_conviction_override_date_pcnt *   0.00 / 10000 + le.Populated_conviction_override_date_type_pcnt*ri.Populated_conviction_override_date_type_pcnt *   0.00 / 10000 + le.Populated_offense_score_pcnt*ri.Populated_offense_score_pcnt *   0.00 / 10000 + le.Populated_offense_persistent_id_pcnt*ri.Populated_offense_persistent_id_pcnt *   0.00 / 10000 + le.Populated_offense_category_pcnt*ri.Populated_offense_category_pcnt *   0.00 / 10000;
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
  SELF.FieldName := CHOOSE(C,'process_date','offender_key','vendor','state_origin','source_file','data_type','off_comp','off_delete_flag','off_date','arr_date','num_of_counts','le_agency_cd','le_agency_desc','le_agency_case_number','traffic_ticket_number','traffic_dl_no','traffic_dl_st','arr_off_code','arr_off_desc_1','arr_off_desc_2','arr_off_type_cd','arr_off_type_desc','arr_off_lev','arr_statute','arr_statute_desc','arr_disp_date','arr_disp_code','arr_disp_desc_1','arr_disp_desc_2','pros_refer_cd','pros_refer','pros_assgn_cd','pros_assgn','pros_chg_rej','pros_off_code','pros_off_desc_1','pros_off_desc_2','pros_off_type_cd','pros_off_type_desc','pros_off_lev','pros_act_filed','court_case_number','court_cd','court_desc','court_appeal_flag','court_final_plea','court_off_code','court_off_desc_1','court_off_desc_2','court_off_type_cd','court_off_type_desc','court_off_lev','court_statute','court_additional_statutes','court_statute_desc','court_disp_date','court_disp_code','court_disp_desc_1','court_disp_desc_2','sent_date','sent_jail','sent_susp_time','sent_court_cost','sent_court_fine','sent_susp_court_fine','sent_probation','sent_addl_prov_code','sent_addl_prov_desc_1','sent_addl_prov_desc_2','sent_consec','sent_agency_rec_cust_ori','sent_agency_rec_cust','appeal_date','appeal_off_disp','appeal_final_decision','convict_dt','offense_town','cty_conv','restitution','community_service','parole','addl_sent_dates','probation_desc2','court_dt','court_county','arr_off_lev_mapped','court_off_lev_mapped','fcra_offense_key','fcra_conviction_flag','fcra_traffic_flag','fcra_date','fcra_date_type','conviction_override_date','conviction_override_date_type','offense_score','offense_persistent_id','offense_category');
  SELF.populated_pcnt := CHOOSE(C,le.populated_process_date_pcnt,le.populated_offender_key_pcnt,le.populated_vendor_pcnt,le.populated_state_origin_pcnt,le.populated_source_file_pcnt,le.populated_data_type_pcnt,le.populated_off_comp_pcnt,le.populated_off_delete_flag_pcnt,le.populated_off_date_pcnt,le.populated_arr_date_pcnt,le.populated_num_of_counts_pcnt,le.populated_le_agency_cd_pcnt,le.populated_le_agency_desc_pcnt,le.populated_le_agency_case_number_pcnt,le.populated_traffic_ticket_number_pcnt,le.populated_traffic_dl_no_pcnt,le.populated_traffic_dl_st_pcnt,le.populated_arr_off_code_pcnt,le.populated_arr_off_desc_1_pcnt,le.populated_arr_off_desc_2_pcnt,le.populated_arr_off_type_cd_pcnt,le.populated_arr_off_type_desc_pcnt,le.populated_arr_off_lev_pcnt,le.populated_arr_statute_pcnt,le.populated_arr_statute_desc_pcnt,le.populated_arr_disp_date_pcnt,le.populated_arr_disp_code_pcnt,le.populated_arr_disp_desc_1_pcnt,le.populated_arr_disp_desc_2_pcnt,le.populated_pros_refer_cd_pcnt,le.populated_pros_refer_pcnt,le.populated_pros_assgn_cd_pcnt,le.populated_pros_assgn_pcnt,le.populated_pros_chg_rej_pcnt,le.populated_pros_off_code_pcnt,le.populated_pros_off_desc_1_pcnt,le.populated_pros_off_desc_2_pcnt,le.populated_pros_off_type_cd_pcnt,le.populated_pros_off_type_desc_pcnt,le.populated_pros_off_lev_pcnt,le.populated_pros_act_filed_pcnt,le.populated_court_case_number_pcnt,le.populated_court_cd_pcnt,le.populated_court_desc_pcnt,le.populated_court_appeal_flag_pcnt,le.populated_court_final_plea_pcnt,le.populated_court_off_code_pcnt,le.populated_court_off_desc_1_pcnt,le.populated_court_off_desc_2_pcnt,le.populated_court_off_type_cd_pcnt,le.populated_court_off_type_desc_pcnt,le.populated_court_off_lev_pcnt,le.populated_court_statute_pcnt,le.populated_court_additional_statutes_pcnt,le.populated_court_statute_desc_pcnt,le.populated_court_disp_date_pcnt,le.populated_court_disp_code_pcnt,le.populated_court_disp_desc_1_pcnt,le.populated_court_disp_desc_2_pcnt,le.populated_sent_date_pcnt,le.populated_sent_jail_pcnt,le.populated_sent_susp_time_pcnt,le.populated_sent_court_cost_pcnt,le.populated_sent_court_fine_pcnt,le.populated_sent_susp_court_fine_pcnt,le.populated_sent_probation_pcnt,le.populated_sent_addl_prov_code_pcnt,le.populated_sent_addl_prov_desc_1_pcnt,le.populated_sent_addl_prov_desc_2_pcnt,le.populated_sent_consec_pcnt,le.populated_sent_agency_rec_cust_ori_pcnt,le.populated_sent_agency_rec_cust_pcnt,le.populated_appeal_date_pcnt,le.populated_appeal_off_disp_pcnt,le.populated_appeal_final_decision_pcnt,le.populated_convict_dt_pcnt,le.populated_offense_town_pcnt,le.populated_cty_conv_pcnt,le.populated_restitution_pcnt,le.populated_community_service_pcnt,le.populated_parole_pcnt,le.populated_addl_sent_dates_pcnt,le.populated_probation_desc2_pcnt,le.populated_court_dt_pcnt,le.populated_court_county_pcnt,le.populated_arr_off_lev_mapped_pcnt,le.populated_court_off_lev_mapped_pcnt,le.populated_fcra_offense_key_pcnt,le.populated_fcra_conviction_flag_pcnt,le.populated_fcra_traffic_flag_pcnt,le.populated_fcra_date_pcnt,le.populated_fcra_date_type_pcnt,le.populated_conviction_override_date_pcnt,le.populated_conviction_override_date_type_pcnt,le.populated_offense_score_pcnt,le.populated_offense_persistent_id_pcnt,le.populated_offense_category_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_process_date,le.maxlength_offender_key,le.maxlength_vendor,le.maxlength_state_origin,le.maxlength_source_file,le.maxlength_data_type,le.maxlength_off_comp,le.maxlength_off_delete_flag,le.maxlength_off_date,le.maxlength_arr_date,le.maxlength_num_of_counts,le.maxlength_le_agency_cd,le.maxlength_le_agency_desc,le.maxlength_le_agency_case_number,le.maxlength_traffic_ticket_number,le.maxlength_traffic_dl_no,le.maxlength_traffic_dl_st,le.maxlength_arr_off_code,le.maxlength_arr_off_desc_1,le.maxlength_arr_off_desc_2,le.maxlength_arr_off_type_cd,le.maxlength_arr_off_type_desc,le.maxlength_arr_off_lev,le.maxlength_arr_statute,le.maxlength_arr_statute_desc,le.maxlength_arr_disp_date,le.maxlength_arr_disp_code,le.maxlength_arr_disp_desc_1,le.maxlength_arr_disp_desc_2,le.maxlength_pros_refer_cd,le.maxlength_pros_refer,le.maxlength_pros_assgn_cd,le.maxlength_pros_assgn,le.maxlength_pros_chg_rej,le.maxlength_pros_off_code,le.maxlength_pros_off_desc_1,le.maxlength_pros_off_desc_2,le.maxlength_pros_off_type_cd,le.maxlength_pros_off_type_desc,le.maxlength_pros_off_lev,le.maxlength_pros_act_filed,le.maxlength_court_case_number,le.maxlength_court_cd,le.maxlength_court_desc,le.maxlength_court_appeal_flag,le.maxlength_court_final_plea,le.maxlength_court_off_code,le.maxlength_court_off_desc_1,le.maxlength_court_off_desc_2,le.maxlength_court_off_type_cd,le.maxlength_court_off_type_desc,le.maxlength_court_off_lev,le.maxlength_court_statute,le.maxlength_court_additional_statutes,le.maxlength_court_statute_desc,le.maxlength_court_disp_date,le.maxlength_court_disp_code,le.maxlength_court_disp_desc_1,le.maxlength_court_disp_desc_2,le.maxlength_sent_date,le.maxlength_sent_jail,le.maxlength_sent_susp_time,le.maxlength_sent_court_cost,le.maxlength_sent_court_fine,le.maxlength_sent_susp_court_fine,le.maxlength_sent_probation,le.maxlength_sent_addl_prov_code,le.maxlength_sent_addl_prov_desc_1,le.maxlength_sent_addl_prov_desc_2,le.maxlength_sent_consec,le.maxlength_sent_agency_rec_cust_ori,le.maxlength_sent_agency_rec_cust,le.maxlength_appeal_date,le.maxlength_appeal_off_disp,le.maxlength_appeal_final_decision,le.maxlength_convict_dt,le.maxlength_offense_town,le.maxlength_cty_conv,le.maxlength_restitution,le.maxlength_community_service,le.maxlength_parole,le.maxlength_addl_sent_dates,le.maxlength_probation_desc2,le.maxlength_court_dt,le.maxlength_court_county,le.maxlength_arr_off_lev_mapped,le.maxlength_court_off_lev_mapped,le.maxlength_fcra_offense_key,le.maxlength_fcra_conviction_flag,le.maxlength_fcra_traffic_flag,le.maxlength_fcra_date,le.maxlength_fcra_date_type,le.maxlength_conviction_override_date,le.maxlength_conviction_override_date_type,le.maxlength_offense_score,le.maxlength_offense_persistent_id,le.maxlength_offense_category);
  SELF.avelength := CHOOSE(C,le.avelength_process_date,le.avelength_offender_key,le.avelength_vendor,le.avelength_state_origin,le.avelength_source_file,le.avelength_data_type,le.avelength_off_comp,le.avelength_off_delete_flag,le.avelength_off_date,le.avelength_arr_date,le.avelength_num_of_counts,le.avelength_le_agency_cd,le.avelength_le_agency_desc,le.avelength_le_agency_case_number,le.avelength_traffic_ticket_number,le.avelength_traffic_dl_no,le.avelength_traffic_dl_st,le.avelength_arr_off_code,le.avelength_arr_off_desc_1,le.avelength_arr_off_desc_2,le.avelength_arr_off_type_cd,le.avelength_arr_off_type_desc,le.avelength_arr_off_lev,le.avelength_arr_statute,le.avelength_arr_statute_desc,le.avelength_arr_disp_date,le.avelength_arr_disp_code,le.avelength_arr_disp_desc_1,le.avelength_arr_disp_desc_2,le.avelength_pros_refer_cd,le.avelength_pros_refer,le.avelength_pros_assgn_cd,le.avelength_pros_assgn,le.avelength_pros_chg_rej,le.avelength_pros_off_code,le.avelength_pros_off_desc_1,le.avelength_pros_off_desc_2,le.avelength_pros_off_type_cd,le.avelength_pros_off_type_desc,le.avelength_pros_off_lev,le.avelength_pros_act_filed,le.avelength_court_case_number,le.avelength_court_cd,le.avelength_court_desc,le.avelength_court_appeal_flag,le.avelength_court_final_plea,le.avelength_court_off_code,le.avelength_court_off_desc_1,le.avelength_court_off_desc_2,le.avelength_court_off_type_cd,le.avelength_court_off_type_desc,le.avelength_court_off_lev,le.avelength_court_statute,le.avelength_court_additional_statutes,le.avelength_court_statute_desc,le.avelength_court_disp_date,le.avelength_court_disp_code,le.avelength_court_disp_desc_1,le.avelength_court_disp_desc_2,le.avelength_sent_date,le.avelength_sent_jail,le.avelength_sent_susp_time,le.avelength_sent_court_cost,le.avelength_sent_court_fine,le.avelength_sent_susp_court_fine,le.avelength_sent_probation,le.avelength_sent_addl_prov_code,le.avelength_sent_addl_prov_desc_1,le.avelength_sent_addl_prov_desc_2,le.avelength_sent_consec,le.avelength_sent_agency_rec_cust_ori,le.avelength_sent_agency_rec_cust,le.avelength_appeal_date,le.avelength_appeal_off_disp,le.avelength_appeal_final_decision,le.avelength_convict_dt,le.avelength_offense_town,le.avelength_cty_conv,le.avelength_restitution,le.avelength_community_service,le.avelength_parole,le.avelength_addl_sent_dates,le.avelength_probation_desc2,le.avelength_court_dt,le.avelength_court_county,le.avelength_arr_off_lev_mapped,le.avelength_court_off_lev_mapped,le.avelength_fcra_offense_key,le.avelength_fcra_conviction_flag,le.avelength_fcra_traffic_flag,le.avelength_fcra_date,le.avelength_fcra_date_type,le.avelength_conviction_override_date,le.avelength_conviction_override_date_type,le.avelength_offense_score,le.avelength_offense_persistent_id,le.avelength_offense_category);
END;
EXPORT invSummary := NORMALIZE(summary0, 97, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Src := le.vendor;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.offender_key),TRIM((SALT311.StrType)le.vendor),TRIM((SALT311.StrType)le.state_origin),TRIM((SALT311.StrType)le.source_file),TRIM((SALT311.StrType)le.data_type),TRIM((SALT311.StrType)le.off_comp),TRIM((SALT311.StrType)le.off_delete_flag),TRIM((SALT311.StrType)le.off_date),TRIM((SALT311.StrType)le.arr_date),TRIM((SALT311.StrType)le.num_of_counts),TRIM((SALT311.StrType)le.le_agency_cd),TRIM((SALT311.StrType)le.le_agency_desc),TRIM((SALT311.StrType)le.le_agency_case_number),TRIM((SALT311.StrType)le.traffic_ticket_number),TRIM((SALT311.StrType)le.traffic_dl_no),TRIM((SALT311.StrType)le.traffic_dl_st),TRIM((SALT311.StrType)le.arr_off_code),TRIM((SALT311.StrType)le.arr_off_desc_1),TRIM((SALT311.StrType)le.arr_off_desc_2),TRIM((SALT311.StrType)le.arr_off_type_cd),TRIM((SALT311.StrType)le.arr_off_type_desc),TRIM((SALT311.StrType)le.arr_off_lev),TRIM((SALT311.StrType)le.arr_statute),TRIM((SALT311.StrType)le.arr_statute_desc),TRIM((SALT311.StrType)le.arr_disp_date),TRIM((SALT311.StrType)le.arr_disp_code),TRIM((SALT311.StrType)le.arr_disp_desc_1),TRIM((SALT311.StrType)le.arr_disp_desc_2),TRIM((SALT311.StrType)le.pros_refer_cd),TRIM((SALT311.StrType)le.pros_refer),TRIM((SALT311.StrType)le.pros_assgn_cd),TRIM((SALT311.StrType)le.pros_assgn),TRIM((SALT311.StrType)le.pros_chg_rej),TRIM((SALT311.StrType)le.pros_off_code),TRIM((SALT311.StrType)le.pros_off_desc_1),TRIM((SALT311.StrType)le.pros_off_desc_2),TRIM((SALT311.StrType)le.pros_off_type_cd),TRIM((SALT311.StrType)le.pros_off_type_desc),TRIM((SALT311.StrType)le.pros_off_lev),TRIM((SALT311.StrType)le.pros_act_filed),TRIM((SALT311.StrType)le.court_case_number),TRIM((SALT311.StrType)le.court_cd),TRIM((SALT311.StrType)le.court_desc),TRIM((SALT311.StrType)le.court_appeal_flag),TRIM((SALT311.StrType)le.court_final_plea),TRIM((SALT311.StrType)le.court_off_code),TRIM((SALT311.StrType)le.court_off_desc_1),TRIM((SALT311.StrType)le.court_off_desc_2),TRIM((SALT311.StrType)le.court_off_type_cd),TRIM((SALT311.StrType)le.court_off_type_desc),TRIM((SALT311.StrType)le.court_off_lev),TRIM((SALT311.StrType)le.court_statute),TRIM((SALT311.StrType)le.court_additional_statutes),TRIM((SALT311.StrType)le.court_statute_desc),TRIM((SALT311.StrType)le.court_disp_date),TRIM((SALT311.StrType)le.court_disp_code),TRIM((SALT311.StrType)le.court_disp_desc_1),TRIM((SALT311.StrType)le.court_disp_desc_2),TRIM((SALT311.StrType)le.sent_date),TRIM((SALT311.StrType)le.sent_jail),TRIM((SALT311.StrType)le.sent_susp_time),TRIM((SALT311.StrType)le.sent_court_cost),TRIM((SALT311.StrType)le.sent_court_fine),TRIM((SALT311.StrType)le.sent_susp_court_fine),TRIM((SALT311.StrType)le.sent_probation),TRIM((SALT311.StrType)le.sent_addl_prov_code),TRIM((SALT311.StrType)le.sent_addl_prov_desc_1),TRIM((SALT311.StrType)le.sent_addl_prov_desc_2),TRIM((SALT311.StrType)le.sent_consec),TRIM((SALT311.StrType)le.sent_agency_rec_cust_ori),TRIM((SALT311.StrType)le.sent_agency_rec_cust),TRIM((SALT311.StrType)le.appeal_date),TRIM((SALT311.StrType)le.appeal_off_disp),TRIM((SALT311.StrType)le.appeal_final_decision),TRIM((SALT311.StrType)le.convict_dt),TRIM((SALT311.StrType)le.offense_town),TRIM((SALT311.StrType)le.cty_conv),TRIM((SALT311.StrType)le.restitution),TRIM((SALT311.StrType)le.community_service),TRIM((SALT311.StrType)le.parole),TRIM((SALT311.StrType)le.addl_sent_dates),TRIM((SALT311.StrType)le.probation_desc2),TRIM((SALT311.StrType)le.court_dt),TRIM((SALT311.StrType)le.court_county),TRIM((SALT311.StrType)le.arr_off_lev_mapped),TRIM((SALT311.StrType)le.court_off_lev_mapped),TRIM((SALT311.StrType)le.fcra_offense_key),TRIM((SALT311.StrType)le.fcra_conviction_flag),TRIM((SALT311.StrType)le.fcra_traffic_flag),TRIM((SALT311.StrType)le.fcra_date),TRIM((SALT311.StrType)le.fcra_date_type),TRIM((SALT311.StrType)le.conviction_override_date),TRIM((SALT311.StrType)le.conviction_override_date_type),TRIM((SALT311.StrType)le.offense_score),IF (le.offense_persistent_id <> 0,TRIM((SALT311.StrType)le.offense_persistent_id), ''),IF (le.offense_category <> 0,TRIM((SALT311.StrType)le.offense_category), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,97,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 97);
  SELF.FldNo2 := 1 + (C % 97);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.offender_key),TRIM((SALT311.StrType)le.vendor),TRIM((SALT311.StrType)le.state_origin),TRIM((SALT311.StrType)le.source_file),TRIM((SALT311.StrType)le.data_type),TRIM((SALT311.StrType)le.off_comp),TRIM((SALT311.StrType)le.off_delete_flag),TRIM((SALT311.StrType)le.off_date),TRIM((SALT311.StrType)le.arr_date),TRIM((SALT311.StrType)le.num_of_counts),TRIM((SALT311.StrType)le.le_agency_cd),TRIM((SALT311.StrType)le.le_agency_desc),TRIM((SALT311.StrType)le.le_agency_case_number),TRIM((SALT311.StrType)le.traffic_ticket_number),TRIM((SALT311.StrType)le.traffic_dl_no),TRIM((SALT311.StrType)le.traffic_dl_st),TRIM((SALT311.StrType)le.arr_off_code),TRIM((SALT311.StrType)le.arr_off_desc_1),TRIM((SALT311.StrType)le.arr_off_desc_2),TRIM((SALT311.StrType)le.arr_off_type_cd),TRIM((SALT311.StrType)le.arr_off_type_desc),TRIM((SALT311.StrType)le.arr_off_lev),TRIM((SALT311.StrType)le.arr_statute),TRIM((SALT311.StrType)le.arr_statute_desc),TRIM((SALT311.StrType)le.arr_disp_date),TRIM((SALT311.StrType)le.arr_disp_code),TRIM((SALT311.StrType)le.arr_disp_desc_1),TRIM((SALT311.StrType)le.arr_disp_desc_2),TRIM((SALT311.StrType)le.pros_refer_cd),TRIM((SALT311.StrType)le.pros_refer),TRIM((SALT311.StrType)le.pros_assgn_cd),TRIM((SALT311.StrType)le.pros_assgn),TRIM((SALT311.StrType)le.pros_chg_rej),TRIM((SALT311.StrType)le.pros_off_code),TRIM((SALT311.StrType)le.pros_off_desc_1),TRIM((SALT311.StrType)le.pros_off_desc_2),TRIM((SALT311.StrType)le.pros_off_type_cd),TRIM((SALT311.StrType)le.pros_off_type_desc),TRIM((SALT311.StrType)le.pros_off_lev),TRIM((SALT311.StrType)le.pros_act_filed),TRIM((SALT311.StrType)le.court_case_number),TRIM((SALT311.StrType)le.court_cd),TRIM((SALT311.StrType)le.court_desc),TRIM((SALT311.StrType)le.court_appeal_flag),TRIM((SALT311.StrType)le.court_final_plea),TRIM((SALT311.StrType)le.court_off_code),TRIM((SALT311.StrType)le.court_off_desc_1),TRIM((SALT311.StrType)le.court_off_desc_2),TRIM((SALT311.StrType)le.court_off_type_cd),TRIM((SALT311.StrType)le.court_off_type_desc),TRIM((SALT311.StrType)le.court_off_lev),TRIM((SALT311.StrType)le.court_statute),TRIM((SALT311.StrType)le.court_additional_statutes),TRIM((SALT311.StrType)le.court_statute_desc),TRIM((SALT311.StrType)le.court_disp_date),TRIM((SALT311.StrType)le.court_disp_code),TRIM((SALT311.StrType)le.court_disp_desc_1),TRIM((SALT311.StrType)le.court_disp_desc_2),TRIM((SALT311.StrType)le.sent_date),TRIM((SALT311.StrType)le.sent_jail),TRIM((SALT311.StrType)le.sent_susp_time),TRIM((SALT311.StrType)le.sent_court_cost),TRIM((SALT311.StrType)le.sent_court_fine),TRIM((SALT311.StrType)le.sent_susp_court_fine),TRIM((SALT311.StrType)le.sent_probation),TRIM((SALT311.StrType)le.sent_addl_prov_code),TRIM((SALT311.StrType)le.sent_addl_prov_desc_1),TRIM((SALT311.StrType)le.sent_addl_prov_desc_2),TRIM((SALT311.StrType)le.sent_consec),TRIM((SALT311.StrType)le.sent_agency_rec_cust_ori),TRIM((SALT311.StrType)le.sent_agency_rec_cust),TRIM((SALT311.StrType)le.appeal_date),TRIM((SALT311.StrType)le.appeal_off_disp),TRIM((SALT311.StrType)le.appeal_final_decision),TRIM((SALT311.StrType)le.convict_dt),TRIM((SALT311.StrType)le.offense_town),TRIM((SALT311.StrType)le.cty_conv),TRIM((SALT311.StrType)le.restitution),TRIM((SALT311.StrType)le.community_service),TRIM((SALT311.StrType)le.parole),TRIM((SALT311.StrType)le.addl_sent_dates),TRIM((SALT311.StrType)le.probation_desc2),TRIM((SALT311.StrType)le.court_dt),TRIM((SALT311.StrType)le.court_county),TRIM((SALT311.StrType)le.arr_off_lev_mapped),TRIM((SALT311.StrType)le.court_off_lev_mapped),TRIM((SALT311.StrType)le.fcra_offense_key),TRIM((SALT311.StrType)le.fcra_conviction_flag),TRIM((SALT311.StrType)le.fcra_traffic_flag),TRIM((SALT311.StrType)le.fcra_date),TRIM((SALT311.StrType)le.fcra_date_type),TRIM((SALT311.StrType)le.conviction_override_date),TRIM((SALT311.StrType)le.conviction_override_date_type),TRIM((SALT311.StrType)le.offense_score),IF (le.offense_persistent_id <> 0,TRIM((SALT311.StrType)le.offense_persistent_id), ''),IF (le.offense_category <> 0,TRIM((SALT311.StrType)le.offense_category), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.offender_key),TRIM((SALT311.StrType)le.vendor),TRIM((SALT311.StrType)le.state_origin),TRIM((SALT311.StrType)le.source_file),TRIM((SALT311.StrType)le.data_type),TRIM((SALT311.StrType)le.off_comp),TRIM((SALT311.StrType)le.off_delete_flag),TRIM((SALT311.StrType)le.off_date),TRIM((SALT311.StrType)le.arr_date),TRIM((SALT311.StrType)le.num_of_counts),TRIM((SALT311.StrType)le.le_agency_cd),TRIM((SALT311.StrType)le.le_agency_desc),TRIM((SALT311.StrType)le.le_agency_case_number),TRIM((SALT311.StrType)le.traffic_ticket_number),TRIM((SALT311.StrType)le.traffic_dl_no),TRIM((SALT311.StrType)le.traffic_dl_st),TRIM((SALT311.StrType)le.arr_off_code),TRIM((SALT311.StrType)le.arr_off_desc_1),TRIM((SALT311.StrType)le.arr_off_desc_2),TRIM((SALT311.StrType)le.arr_off_type_cd),TRIM((SALT311.StrType)le.arr_off_type_desc),TRIM((SALT311.StrType)le.arr_off_lev),TRIM((SALT311.StrType)le.arr_statute),TRIM((SALT311.StrType)le.arr_statute_desc),TRIM((SALT311.StrType)le.arr_disp_date),TRIM((SALT311.StrType)le.arr_disp_code),TRIM((SALT311.StrType)le.arr_disp_desc_1),TRIM((SALT311.StrType)le.arr_disp_desc_2),TRIM((SALT311.StrType)le.pros_refer_cd),TRIM((SALT311.StrType)le.pros_refer),TRIM((SALT311.StrType)le.pros_assgn_cd),TRIM((SALT311.StrType)le.pros_assgn),TRIM((SALT311.StrType)le.pros_chg_rej),TRIM((SALT311.StrType)le.pros_off_code),TRIM((SALT311.StrType)le.pros_off_desc_1),TRIM((SALT311.StrType)le.pros_off_desc_2),TRIM((SALT311.StrType)le.pros_off_type_cd),TRIM((SALT311.StrType)le.pros_off_type_desc),TRIM((SALT311.StrType)le.pros_off_lev),TRIM((SALT311.StrType)le.pros_act_filed),TRIM((SALT311.StrType)le.court_case_number),TRIM((SALT311.StrType)le.court_cd),TRIM((SALT311.StrType)le.court_desc),TRIM((SALT311.StrType)le.court_appeal_flag),TRIM((SALT311.StrType)le.court_final_plea),TRIM((SALT311.StrType)le.court_off_code),TRIM((SALT311.StrType)le.court_off_desc_1),TRIM((SALT311.StrType)le.court_off_desc_2),TRIM((SALT311.StrType)le.court_off_type_cd),TRIM((SALT311.StrType)le.court_off_type_desc),TRIM((SALT311.StrType)le.court_off_lev),TRIM((SALT311.StrType)le.court_statute),TRIM((SALT311.StrType)le.court_additional_statutes),TRIM((SALT311.StrType)le.court_statute_desc),TRIM((SALT311.StrType)le.court_disp_date),TRIM((SALT311.StrType)le.court_disp_code),TRIM((SALT311.StrType)le.court_disp_desc_1),TRIM((SALT311.StrType)le.court_disp_desc_2),TRIM((SALT311.StrType)le.sent_date),TRIM((SALT311.StrType)le.sent_jail),TRIM((SALT311.StrType)le.sent_susp_time),TRIM((SALT311.StrType)le.sent_court_cost),TRIM((SALT311.StrType)le.sent_court_fine),TRIM((SALT311.StrType)le.sent_susp_court_fine),TRIM((SALT311.StrType)le.sent_probation),TRIM((SALT311.StrType)le.sent_addl_prov_code),TRIM((SALT311.StrType)le.sent_addl_prov_desc_1),TRIM((SALT311.StrType)le.sent_addl_prov_desc_2),TRIM((SALT311.StrType)le.sent_consec),TRIM((SALT311.StrType)le.sent_agency_rec_cust_ori),TRIM((SALT311.StrType)le.sent_agency_rec_cust),TRIM((SALT311.StrType)le.appeal_date),TRIM((SALT311.StrType)le.appeal_off_disp),TRIM((SALT311.StrType)le.appeal_final_decision),TRIM((SALT311.StrType)le.convict_dt),TRIM((SALT311.StrType)le.offense_town),TRIM((SALT311.StrType)le.cty_conv),TRIM((SALT311.StrType)le.restitution),TRIM((SALT311.StrType)le.community_service),TRIM((SALT311.StrType)le.parole),TRIM((SALT311.StrType)le.addl_sent_dates),TRIM((SALT311.StrType)le.probation_desc2),TRIM((SALT311.StrType)le.court_dt),TRIM((SALT311.StrType)le.court_county),TRIM((SALT311.StrType)le.arr_off_lev_mapped),TRIM((SALT311.StrType)le.court_off_lev_mapped),TRIM((SALT311.StrType)le.fcra_offense_key),TRIM((SALT311.StrType)le.fcra_conviction_flag),TRIM((SALT311.StrType)le.fcra_traffic_flag),TRIM((SALT311.StrType)le.fcra_date),TRIM((SALT311.StrType)le.fcra_date_type),TRIM((SALT311.StrType)le.conviction_override_date),TRIM((SALT311.StrType)le.conviction_override_date_type),TRIM((SALT311.StrType)le.offense_score),IF (le.offense_persistent_id <> 0,TRIM((SALT311.StrType)le.offense_persistent_id), ''),IF (le.offense_category <> 0,TRIM((SALT311.StrType)le.offense_category), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),97*97,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'process_date'}
      ,{2,'offender_key'}
      ,{3,'vendor'}
      ,{4,'state_origin'}
      ,{5,'source_file'}
      ,{6,'data_type'}
      ,{7,'off_comp'}
      ,{8,'off_delete_flag'}
      ,{9,'off_date'}
      ,{10,'arr_date'}
      ,{11,'num_of_counts'}
      ,{12,'le_agency_cd'}
      ,{13,'le_agency_desc'}
      ,{14,'le_agency_case_number'}
      ,{15,'traffic_ticket_number'}
      ,{16,'traffic_dl_no'}
      ,{17,'traffic_dl_st'}
      ,{18,'arr_off_code'}
      ,{19,'arr_off_desc_1'}
      ,{20,'arr_off_desc_2'}
      ,{21,'arr_off_type_cd'}
      ,{22,'arr_off_type_desc'}
      ,{23,'arr_off_lev'}
      ,{24,'arr_statute'}
      ,{25,'arr_statute_desc'}
      ,{26,'arr_disp_date'}
      ,{27,'arr_disp_code'}
      ,{28,'arr_disp_desc_1'}
      ,{29,'arr_disp_desc_2'}
      ,{30,'pros_refer_cd'}
      ,{31,'pros_refer'}
      ,{32,'pros_assgn_cd'}
      ,{33,'pros_assgn'}
      ,{34,'pros_chg_rej'}
      ,{35,'pros_off_code'}
      ,{36,'pros_off_desc_1'}
      ,{37,'pros_off_desc_2'}
      ,{38,'pros_off_type_cd'}
      ,{39,'pros_off_type_desc'}
      ,{40,'pros_off_lev'}
      ,{41,'pros_act_filed'}
      ,{42,'court_case_number'}
      ,{43,'court_cd'}
      ,{44,'court_desc'}
      ,{45,'court_appeal_flag'}
      ,{46,'court_final_plea'}
      ,{47,'court_off_code'}
      ,{48,'court_off_desc_1'}
      ,{49,'court_off_desc_2'}
      ,{50,'court_off_type_cd'}
      ,{51,'court_off_type_desc'}
      ,{52,'court_off_lev'}
      ,{53,'court_statute'}
      ,{54,'court_additional_statutes'}
      ,{55,'court_statute_desc'}
      ,{56,'court_disp_date'}
      ,{57,'court_disp_code'}
      ,{58,'court_disp_desc_1'}
      ,{59,'court_disp_desc_2'}
      ,{60,'sent_date'}
      ,{61,'sent_jail'}
      ,{62,'sent_susp_time'}
      ,{63,'sent_court_cost'}
      ,{64,'sent_court_fine'}
      ,{65,'sent_susp_court_fine'}
      ,{66,'sent_probation'}
      ,{67,'sent_addl_prov_code'}
      ,{68,'sent_addl_prov_desc_1'}
      ,{69,'sent_addl_prov_desc_2'}
      ,{70,'sent_consec'}
      ,{71,'sent_agency_rec_cust_ori'}
      ,{72,'sent_agency_rec_cust'}
      ,{73,'appeal_date'}
      ,{74,'appeal_off_disp'}
      ,{75,'appeal_final_decision'}
      ,{76,'convict_dt'}
      ,{77,'offense_town'}
      ,{78,'cty_conv'}
      ,{79,'restitution'}
      ,{80,'community_service'}
      ,{81,'parole'}
      ,{82,'addl_sent_dates'}
      ,{83,'probation_desc2'}
      ,{84,'court_dt'}
      ,{85,'court_county'}
      ,{86,'arr_off_lev_mapped'}
      ,{87,'court_off_lev_mapped'}
      ,{88,'fcra_offense_key'}
      ,{89,'fcra_conviction_flag'}
      ,{90,'fcra_traffic_flag'}
      ,{91,'fcra_date'}
      ,{92,'fcra_date_type'}
      ,{93,'conviction_override_date'}
      ,{94,'conviction_override_date_type'}
      ,{95,'offense_score'}
      ,{96,'offense_persistent_id'}
      ,{97,'offense_category'}],SALT311.MAC_Character_Counts.Field_Identification);
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
    Moxie_Court_Offenses_Dev_Fields.InValid_process_date((SALT311.StrType)le.process_date),
    Moxie_Court_Offenses_Dev_Fields.InValid_offender_key((SALT311.StrType)le.offender_key),
    Moxie_Court_Offenses_Dev_Fields.InValid_vendor((SALT311.StrType)le.vendor),
    Moxie_Court_Offenses_Dev_Fields.InValid_state_origin((SALT311.StrType)le.state_origin),
    Moxie_Court_Offenses_Dev_Fields.InValid_source_file((SALT311.StrType)le.source_file),
    Moxie_Court_Offenses_Dev_Fields.InValid_data_type((SALT311.StrType)le.data_type),
    Moxie_Court_Offenses_Dev_Fields.InValid_off_comp((SALT311.StrType)le.off_comp),
    Moxie_Court_Offenses_Dev_Fields.InValid_off_delete_flag((SALT311.StrType)le.off_delete_flag),
    Moxie_Court_Offenses_Dev_Fields.InValid_off_date((SALT311.StrType)le.off_date),
    Moxie_Court_Offenses_Dev_Fields.InValid_arr_date((SALT311.StrType)le.arr_date),
    Moxie_Court_Offenses_Dev_Fields.InValid_num_of_counts((SALT311.StrType)le.num_of_counts),
    Moxie_Court_Offenses_Dev_Fields.InValid_le_agency_cd((SALT311.StrType)le.le_agency_cd),
    Moxie_Court_Offenses_Dev_Fields.InValid_le_agency_desc((SALT311.StrType)le.le_agency_desc),
    Moxie_Court_Offenses_Dev_Fields.InValid_le_agency_case_number((SALT311.StrType)le.le_agency_case_number),
    Moxie_Court_Offenses_Dev_Fields.InValid_traffic_ticket_number((SALT311.StrType)le.traffic_ticket_number),
    Moxie_Court_Offenses_Dev_Fields.InValid_traffic_dl_no((SALT311.StrType)le.traffic_dl_no),
    Moxie_Court_Offenses_Dev_Fields.InValid_traffic_dl_st((SALT311.StrType)le.traffic_dl_st),
    Moxie_Court_Offenses_Dev_Fields.InValid_arr_off_code((SALT311.StrType)le.arr_off_code),
    Moxie_Court_Offenses_Dev_Fields.InValid_arr_off_desc_1((SALT311.StrType)le.arr_off_desc_1),
    Moxie_Court_Offenses_Dev_Fields.InValid_arr_off_desc_2((SALT311.StrType)le.arr_off_desc_2),
    Moxie_Court_Offenses_Dev_Fields.InValid_arr_off_type_cd((SALT311.StrType)le.arr_off_type_cd),
    Moxie_Court_Offenses_Dev_Fields.InValid_arr_off_type_desc((SALT311.StrType)le.arr_off_type_desc),
    Moxie_Court_Offenses_Dev_Fields.InValid_arr_off_lev((SALT311.StrType)le.arr_off_lev),
    Moxie_Court_Offenses_Dev_Fields.InValid_arr_statute((SALT311.StrType)le.arr_statute),
    Moxie_Court_Offenses_Dev_Fields.InValid_arr_statute_desc((SALT311.StrType)le.arr_statute_desc),
    Moxie_Court_Offenses_Dev_Fields.InValid_arr_disp_date((SALT311.StrType)le.arr_disp_date),
    Moxie_Court_Offenses_Dev_Fields.InValid_arr_disp_code((SALT311.StrType)le.arr_disp_code),
    Moxie_Court_Offenses_Dev_Fields.InValid_arr_disp_desc_1((SALT311.StrType)le.arr_disp_desc_1),
    Moxie_Court_Offenses_Dev_Fields.InValid_arr_disp_desc_2((SALT311.StrType)le.arr_disp_desc_2),
    Moxie_Court_Offenses_Dev_Fields.InValid_pros_refer_cd((SALT311.StrType)le.pros_refer_cd),
    Moxie_Court_Offenses_Dev_Fields.InValid_pros_refer((SALT311.StrType)le.pros_refer),
    Moxie_Court_Offenses_Dev_Fields.InValid_pros_assgn_cd((SALT311.StrType)le.pros_assgn_cd),
    Moxie_Court_Offenses_Dev_Fields.InValid_pros_assgn((SALT311.StrType)le.pros_assgn),
    Moxie_Court_Offenses_Dev_Fields.InValid_pros_chg_rej((SALT311.StrType)le.pros_chg_rej),
    Moxie_Court_Offenses_Dev_Fields.InValid_pros_off_code((SALT311.StrType)le.pros_off_code),
    Moxie_Court_Offenses_Dev_Fields.InValid_pros_off_desc_1((SALT311.StrType)le.pros_off_desc_1),
    Moxie_Court_Offenses_Dev_Fields.InValid_pros_off_desc_2((SALT311.StrType)le.pros_off_desc_2),
    Moxie_Court_Offenses_Dev_Fields.InValid_pros_off_type_cd((SALT311.StrType)le.pros_off_type_cd),
    Moxie_Court_Offenses_Dev_Fields.InValid_pros_off_type_desc((SALT311.StrType)le.pros_off_type_desc),
    Moxie_Court_Offenses_Dev_Fields.InValid_pros_off_lev((SALT311.StrType)le.pros_off_lev),
    Moxie_Court_Offenses_Dev_Fields.InValid_pros_act_filed((SALT311.StrType)le.pros_act_filed),
    Moxie_Court_Offenses_Dev_Fields.InValid_court_case_number((SALT311.StrType)le.court_case_number),
    Moxie_Court_Offenses_Dev_Fields.InValid_court_cd((SALT311.StrType)le.court_cd),
    Moxie_Court_Offenses_Dev_Fields.InValid_court_desc((SALT311.StrType)le.court_desc),
    Moxie_Court_Offenses_Dev_Fields.InValid_court_appeal_flag((SALT311.StrType)le.court_appeal_flag),
    Moxie_Court_Offenses_Dev_Fields.InValid_court_final_plea((SALT311.StrType)le.court_final_plea),
    Moxie_Court_Offenses_Dev_Fields.InValid_court_off_code((SALT311.StrType)le.court_off_code),
    Moxie_Court_Offenses_Dev_Fields.InValid_court_off_desc_1((SALT311.StrType)le.court_off_desc_1),
    Moxie_Court_Offenses_Dev_Fields.InValid_court_off_desc_2((SALT311.StrType)le.court_off_desc_2),
    Moxie_Court_Offenses_Dev_Fields.InValid_court_off_type_cd((SALT311.StrType)le.court_off_type_cd),
    Moxie_Court_Offenses_Dev_Fields.InValid_court_off_type_desc((SALT311.StrType)le.court_off_type_desc),
    Moxie_Court_Offenses_Dev_Fields.InValid_court_off_lev((SALT311.StrType)le.court_off_lev),
    Moxie_Court_Offenses_Dev_Fields.InValid_court_statute((SALT311.StrType)le.court_statute),
    Moxie_Court_Offenses_Dev_Fields.InValid_court_additional_statutes((SALT311.StrType)le.court_additional_statutes),
    Moxie_Court_Offenses_Dev_Fields.InValid_court_statute_desc((SALT311.StrType)le.court_statute_desc),
    Moxie_Court_Offenses_Dev_Fields.InValid_court_disp_date((SALT311.StrType)le.court_disp_date),
    Moxie_Court_Offenses_Dev_Fields.InValid_court_disp_code((SALT311.StrType)le.court_disp_code),
    Moxie_Court_Offenses_Dev_Fields.InValid_court_disp_desc_1((SALT311.StrType)le.court_disp_desc_1),
    Moxie_Court_Offenses_Dev_Fields.InValid_court_disp_desc_2((SALT311.StrType)le.court_disp_desc_2),
    Moxie_Court_Offenses_Dev_Fields.InValid_sent_date((SALT311.StrType)le.sent_date),
    Moxie_Court_Offenses_Dev_Fields.InValid_sent_jail((SALT311.StrType)le.sent_jail),
    Moxie_Court_Offenses_Dev_Fields.InValid_sent_susp_time((SALT311.StrType)le.sent_susp_time),
    Moxie_Court_Offenses_Dev_Fields.InValid_sent_court_cost((SALT311.StrType)le.sent_court_cost),
    Moxie_Court_Offenses_Dev_Fields.InValid_sent_court_fine((SALT311.StrType)le.sent_court_fine),
    Moxie_Court_Offenses_Dev_Fields.InValid_sent_susp_court_fine((SALT311.StrType)le.sent_susp_court_fine),
    Moxie_Court_Offenses_Dev_Fields.InValid_sent_probation((SALT311.StrType)le.sent_probation),
    Moxie_Court_Offenses_Dev_Fields.InValid_sent_addl_prov_code((SALT311.StrType)le.sent_addl_prov_code),
    Moxie_Court_Offenses_Dev_Fields.InValid_sent_addl_prov_desc_1((SALT311.StrType)le.sent_addl_prov_desc_1),
    Moxie_Court_Offenses_Dev_Fields.InValid_sent_addl_prov_desc_2((SALT311.StrType)le.sent_addl_prov_desc_2),
    Moxie_Court_Offenses_Dev_Fields.InValid_sent_consec((SALT311.StrType)le.sent_consec),
    Moxie_Court_Offenses_Dev_Fields.InValid_sent_agency_rec_cust_ori((SALT311.StrType)le.sent_agency_rec_cust_ori),
    Moxie_Court_Offenses_Dev_Fields.InValid_sent_agency_rec_cust((SALT311.StrType)le.sent_agency_rec_cust),
    Moxie_Court_Offenses_Dev_Fields.InValid_appeal_date((SALT311.StrType)le.appeal_date),
    Moxie_Court_Offenses_Dev_Fields.InValid_appeal_off_disp((SALT311.StrType)le.appeal_off_disp),
    Moxie_Court_Offenses_Dev_Fields.InValid_appeal_final_decision((SALT311.StrType)le.appeal_final_decision),
    Moxie_Court_Offenses_Dev_Fields.InValid_convict_dt((SALT311.StrType)le.convict_dt),
    Moxie_Court_Offenses_Dev_Fields.InValid_offense_town((SALT311.StrType)le.offense_town),
    Moxie_Court_Offenses_Dev_Fields.InValid_cty_conv((SALT311.StrType)le.cty_conv),
    Moxie_Court_Offenses_Dev_Fields.InValid_restitution((SALT311.StrType)le.restitution),
    Moxie_Court_Offenses_Dev_Fields.InValid_community_service((SALT311.StrType)le.community_service),
    Moxie_Court_Offenses_Dev_Fields.InValid_parole((SALT311.StrType)le.parole),
    Moxie_Court_Offenses_Dev_Fields.InValid_addl_sent_dates((SALT311.StrType)le.addl_sent_dates),
    Moxie_Court_Offenses_Dev_Fields.InValid_probation_desc2((SALT311.StrType)le.probation_desc2),
    Moxie_Court_Offenses_Dev_Fields.InValid_court_dt((SALT311.StrType)le.court_dt),
    Moxie_Court_Offenses_Dev_Fields.InValid_court_county((SALT311.StrType)le.court_county),
    Moxie_Court_Offenses_Dev_Fields.InValid_arr_off_lev_mapped((SALT311.StrType)le.arr_off_lev_mapped),
    Moxie_Court_Offenses_Dev_Fields.InValid_court_off_lev_mapped((SALT311.StrType)le.court_off_lev_mapped),
    Moxie_Court_Offenses_Dev_Fields.InValid_fcra_offense_key((SALT311.StrType)le.fcra_offense_key),
    Moxie_Court_Offenses_Dev_Fields.InValid_fcra_conviction_flag((SALT311.StrType)le.fcra_conviction_flag),
    Moxie_Court_Offenses_Dev_Fields.InValid_fcra_traffic_flag((SALT311.StrType)le.fcra_traffic_flag),
    Moxie_Court_Offenses_Dev_Fields.InValid_fcra_date((SALT311.StrType)le.fcra_date),
    Moxie_Court_Offenses_Dev_Fields.InValid_fcra_date_type((SALT311.StrType)le.fcra_date_type),
    Moxie_Court_Offenses_Dev_Fields.InValid_conviction_override_date((SALT311.StrType)le.conviction_override_date),
    Moxie_Court_Offenses_Dev_Fields.InValid_conviction_override_date_type((SALT311.StrType)le.conviction_override_date_type),
    Moxie_Court_Offenses_Dev_Fields.InValid_offense_score((SALT311.StrType)le.offense_score),
    Moxie_Court_Offenses_Dev_Fields.InValid_offense_persistent_id((SALT311.StrType)le.offense_persistent_id),
    Moxie_Court_Offenses_Dev_Fields.InValid_offense_category((SALT311.StrType)le.offense_category),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.vendor := le.vendor;
END;
Errors := NORMALIZE(h,97,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.vendor;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,vendor,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.vendor;
  FieldNme := Moxie_Court_Offenses_Dev_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Current_Date','Non_Blank','Non_Blank','Invalid_Char','Non_Blank','Unknown','Unknown','Unknown','Invalid_Current_Date','Invalid_Current_Date','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_ArrOffLev','Unknown','Unknown','Invalid_Current_Date','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_CourtOffLev','Unknown','Unknown','Unknown','Invalid_Future_Date','Unknown','Unknown','Unknown','Invalid_Future_Date','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_Current_Date','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_Future_Date','Unknown','Unknown','Unknown','Unknown','Invalid_FCRAConFlag','Invalid_FCRATrafficFlag','Invalid_Current_Date','Invalid_FCRADateFlag','Invalid_Future_Date','Invalid_ConOverDateFlag','Invalid_OffenseScore','Invalid_Num','Invalid_Num');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Moxie_Court_Offenses_Dev_Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_offender_key(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_vendor(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_state_origin(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_source_file(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_data_type(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_off_comp(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_off_delete_flag(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_off_date(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_arr_date(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_num_of_counts(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_le_agency_cd(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_le_agency_desc(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_le_agency_case_number(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_traffic_ticket_number(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_traffic_dl_no(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_traffic_dl_st(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_arr_off_code(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_arr_off_desc_1(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_arr_off_desc_2(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_arr_off_type_cd(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_arr_off_type_desc(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_arr_off_lev(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_arr_statute(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_arr_statute_desc(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_arr_disp_date(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_arr_disp_code(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_arr_disp_desc_1(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_arr_disp_desc_2(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_pros_refer_cd(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_pros_refer(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_pros_assgn_cd(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_pros_assgn(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_pros_chg_rej(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_pros_off_code(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_pros_off_desc_1(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_pros_off_desc_2(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_pros_off_type_cd(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_pros_off_type_desc(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_pros_off_lev(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_pros_act_filed(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_court_case_number(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_court_cd(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_court_desc(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_court_appeal_flag(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_court_final_plea(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_court_off_code(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_court_off_desc_1(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_court_off_desc_2(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_court_off_type_cd(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_court_off_type_desc(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_court_off_lev(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_court_statute(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_court_additional_statutes(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_court_statute_desc(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_court_disp_date(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_court_disp_code(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_court_disp_desc_1(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_court_disp_desc_2(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_sent_date(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_sent_jail(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_sent_susp_time(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_sent_court_cost(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_sent_court_fine(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_sent_susp_court_fine(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_sent_probation(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_sent_addl_prov_code(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_sent_addl_prov_desc_1(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_sent_addl_prov_desc_2(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_sent_consec(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_sent_agency_rec_cust_ori(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_sent_agency_rec_cust(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_appeal_date(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_appeal_off_disp(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_appeal_final_decision(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_convict_dt(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_offense_town(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_cty_conv(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_restitution(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_community_service(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_parole(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_addl_sent_dates(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_probation_desc2(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_court_dt(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_court_county(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_arr_off_lev_mapped(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_court_off_lev_mapped(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_fcra_offense_key(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_fcra_conviction_flag(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_fcra_traffic_flag(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_fcra_date(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_fcra_date_type(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_conviction_override_date(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_conviction_override_date_type(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_offense_score(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_offense_persistent_id(TotalErrors.ErrorNum),Moxie_Court_Offenses_Dev_Fields.InValidMessage_offense_category(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.vendor=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doSummaryPerSrc = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
  fieldPopulationPerSource := Summary('', FALSE);
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Crim, Moxie_Court_Offenses_Dev_Fields, 'RECORDOF(fieldPopulationOverall)', TRUE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationPerSource_Standard := IF(doSummaryPerSrc, NORMALIZE(fieldPopulationPerSource, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'src', 'src')));
 
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', TRUE, 'all'));
  fieldPopulationPerSource_TotalRecs_Standard := IF(doSummaryPerSrc, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationPerSource, myTimeStamp, 'src', TRUE, 'src'));
 
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & fieldPopulationPerSource_Standard & fieldPopulationPerSource_TotalRecs_Standard & allProfiles_Standard;
END;
END;
