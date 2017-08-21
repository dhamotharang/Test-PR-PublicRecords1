import ut,SALT19,crim_common;
export hygiene(dataset(crim_common.layout_in_court_offenses) h) := MODULE
//A simple summary record
export Summary(string20 txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_process_date_pcnt := ave(group,if(h.process_date = (typeof(h.process_date))'',0,100));
    maxlength_process_date := max(group,length(trim((string)h.process_date)));
    avelength_process_date := ave(group,length(trim((string)h.process_date)));
    populated_offender_key_pcnt := ave(group,if(h.offender_key = (typeof(h.offender_key))'',0,100));
    maxlength_offender_key := max(group,length(trim((string)h.offender_key)));
    avelength_offender_key := ave(group,length(trim((string)h.offender_key)));
    populated_vendor_pcnt := ave(group,if(h.vendor = (typeof(h.vendor))'',0,100));
    maxlength_vendor := max(group,length(trim((string)h.vendor)));
    avelength_vendor := ave(group,length(trim((string)h.vendor)));
    populated_state_origin_pcnt := ave(group,if(h.state_origin = (typeof(h.state_origin))'',0,100));
    maxlength_state_origin := max(group,length(trim((string)h.state_origin)));
    avelength_state_origin := ave(group,length(trim((string)h.state_origin)));
    populated_source_file_pcnt := ave(group,if(h.source_file = (typeof(h.source_file))'',0,100));
    maxlength_source_file := max(group,length(trim((string)h.source_file)));
    avelength_source_file := ave(group,length(trim((string)h.source_file)));
    populated_off_comp_pcnt := ave(group,if(h.off_comp = (typeof(h.off_comp))'',0,100));
    maxlength_off_comp := max(group,length(trim((string)h.off_comp)));
    avelength_off_comp := ave(group,length(trim((string)h.off_comp)));
    populated_off_delete_flag_pcnt := ave(group,if(h.off_delete_flag = (typeof(h.off_delete_flag))'',0,100));
    maxlength_off_delete_flag := max(group,length(trim((string)h.off_delete_flag)));
    avelength_off_delete_flag := ave(group,length(trim((string)h.off_delete_flag)));
    populated_off_date_pcnt := ave(group,if(h.off_date = (typeof(h.off_date))'',0,100));
    maxlength_off_date := max(group,length(trim((string)h.off_date)));
    avelength_off_date := ave(group,length(trim((string)h.off_date)));
    populated_arr_date_pcnt := ave(group,if(h.arr_date = (typeof(h.arr_date))'',0,100));
    maxlength_arr_date := max(group,length(trim((string)h.arr_date)));
    avelength_arr_date := ave(group,length(trim((string)h.arr_date)));
    populated_num_of_counts_pcnt := ave(group,if(h.num_of_counts = (typeof(h.num_of_counts))'',0,100));
    maxlength_num_of_counts := max(group,length(trim((string)h.num_of_counts)));
    avelength_num_of_counts := ave(group,length(trim((string)h.num_of_counts)));
    populated_le_agency_cd_pcnt := ave(group,if(h.le_agency_cd = (typeof(h.le_agency_cd))'',0,100));
    maxlength_le_agency_cd := max(group,length(trim((string)h.le_agency_cd)));
    avelength_le_agency_cd := ave(group,length(trim((string)h.le_agency_cd)));
    populated_le_agency_desc_pcnt := ave(group,if(h.le_agency_desc = (typeof(h.le_agency_desc))'',0,100));
    maxlength_le_agency_desc := max(group,length(trim((string)h.le_agency_desc)));
    avelength_le_agency_desc := ave(group,length(trim((string)h.le_agency_desc)));
    populated_le_agency_case_number_pcnt := ave(group,if(h.le_agency_case_number = (typeof(h.le_agency_case_number))'',0,100));
    maxlength_le_agency_case_number := max(group,length(trim((string)h.le_agency_case_number)));
    avelength_le_agency_case_number := ave(group,length(trim((string)h.le_agency_case_number)));
    populated_traffic_ticket_number_pcnt := ave(group,if(h.traffic_ticket_number = (typeof(h.traffic_ticket_number))'',0,100));
    maxlength_traffic_ticket_number := max(group,length(trim((string)h.traffic_ticket_number)));
    avelength_traffic_ticket_number := ave(group,length(trim((string)h.traffic_ticket_number)));
    populated_traffic_dl_no_pcnt := ave(group,if(h.traffic_dl_no = (typeof(h.traffic_dl_no))'',0,100));
    maxlength_traffic_dl_no := max(group,length(trim((string)h.traffic_dl_no)));
    avelength_traffic_dl_no := ave(group,length(trim((string)h.traffic_dl_no)));
    populated_traffic_dl_st_pcnt := ave(group,if(h.traffic_dl_st = (typeof(h.traffic_dl_st))'',0,100));
    maxlength_traffic_dl_st := max(group,length(trim((string)h.traffic_dl_st)));
    avelength_traffic_dl_st := ave(group,length(trim((string)h.traffic_dl_st)));
    populated_arr_off_code_pcnt := ave(group,if(h.arr_off_code = (typeof(h.arr_off_code))'',0,100));
    maxlength_arr_off_code := max(group,length(trim((string)h.arr_off_code)));
    avelength_arr_off_code := ave(group,length(trim((string)h.arr_off_code)));
    populated_arr_off_desc_1_pcnt := ave(group,if(h.arr_off_desc_1 = (typeof(h.arr_off_desc_1))'',0,100));
    maxlength_arr_off_desc_1 := max(group,length(trim((string)h.arr_off_desc_1)));
    avelength_arr_off_desc_1 := ave(group,length(trim((string)h.arr_off_desc_1)));
    populated_arr_off_desc_2_pcnt := ave(group,if(h.arr_off_desc_2 = (typeof(h.arr_off_desc_2))'',0,100));
    maxlength_arr_off_desc_2 := max(group,length(trim((string)h.arr_off_desc_2)));
    avelength_arr_off_desc_2 := ave(group,length(trim((string)h.arr_off_desc_2)));
    populated_arr_off_type_cd_pcnt := ave(group,if(h.arr_off_type_cd = (typeof(h.arr_off_type_cd))'',0,100));
    maxlength_arr_off_type_cd := max(group,length(trim((string)h.arr_off_type_cd)));
    avelength_arr_off_type_cd := ave(group,length(trim((string)h.arr_off_type_cd)));
    populated_arr_off_type_desc_pcnt := ave(group,if(h.arr_off_type_desc = (typeof(h.arr_off_type_desc))'',0,100));
    maxlength_arr_off_type_desc := max(group,length(trim((string)h.arr_off_type_desc)));
    avelength_arr_off_type_desc := ave(group,length(trim((string)h.arr_off_type_desc)));
    populated_arr_off_lev_pcnt := ave(group,if(h.arr_off_lev = (typeof(h.arr_off_lev))'',0,100));
    maxlength_arr_off_lev := max(group,length(trim((string)h.arr_off_lev)));
    avelength_arr_off_lev := ave(group,length(trim((string)h.arr_off_lev)));
    populated_arr_statute_pcnt := ave(group,if(h.arr_statute = (typeof(h.arr_statute))'',0,100));
    maxlength_arr_statute := max(group,length(trim((string)h.arr_statute)));
    avelength_arr_statute := ave(group,length(trim((string)h.arr_statute)));
    populated_arr_statute_desc_pcnt := ave(group,if(h.arr_statute_desc = (typeof(h.arr_statute_desc))'',0,100));
    maxlength_arr_statute_desc := max(group,length(trim((string)h.arr_statute_desc)));
    avelength_arr_statute_desc := ave(group,length(trim((string)h.arr_statute_desc)));
    populated_arr_disp_date_pcnt := ave(group,if(h.arr_disp_date = (typeof(h.arr_disp_date))'',0,100));
    maxlength_arr_disp_date := max(group,length(trim((string)h.arr_disp_date)));
    avelength_arr_disp_date := ave(group,length(trim((string)h.arr_disp_date)));
    populated_arr_disp_code_pcnt := ave(group,if(h.arr_disp_code = (typeof(h.arr_disp_code))'',0,100));
    maxlength_arr_disp_code := max(group,length(trim((string)h.arr_disp_code)));
    avelength_arr_disp_code := ave(group,length(trim((string)h.arr_disp_code)));
    populated_arr_disp_desc_1_pcnt := ave(group,if(h.arr_disp_desc_1 = (typeof(h.arr_disp_desc_1))'',0,100));
    maxlength_arr_disp_desc_1 := max(group,length(trim((string)h.arr_disp_desc_1)));
    avelength_arr_disp_desc_1 := ave(group,length(trim((string)h.arr_disp_desc_1)));
    populated_arr_disp_desc_2_pcnt := ave(group,if(h.arr_disp_desc_2 = (typeof(h.arr_disp_desc_2))'',0,100));
    maxlength_arr_disp_desc_2 := max(group,length(trim((string)h.arr_disp_desc_2)));
    avelength_arr_disp_desc_2 := ave(group,length(trim((string)h.arr_disp_desc_2)));
    populated_pros_refer_cd_pcnt := ave(group,if(h.pros_refer_cd = (typeof(h.pros_refer_cd))'',0,100));
    maxlength_pros_refer_cd := max(group,length(trim((string)h.pros_refer_cd)));
    avelength_pros_refer_cd := ave(group,length(trim((string)h.pros_refer_cd)));
    populated_pros_refer_pcnt := ave(group,if(h.pros_refer = (typeof(h.pros_refer))'',0,100));
    maxlength_pros_refer := max(group,length(trim((string)h.pros_refer)));
    avelength_pros_refer := ave(group,length(trim((string)h.pros_refer)));
    populated_pros_assgn_cd_pcnt := ave(group,if(h.pros_assgn_cd = (typeof(h.pros_assgn_cd))'',0,100));
    maxlength_pros_assgn_cd := max(group,length(trim((string)h.pros_assgn_cd)));
    avelength_pros_assgn_cd := ave(group,length(trim((string)h.pros_assgn_cd)));
    populated_pros_assgn_pcnt := ave(group,if(h.pros_assgn = (typeof(h.pros_assgn))'',0,100));
    maxlength_pros_assgn := max(group,length(trim((string)h.pros_assgn)));
    avelength_pros_assgn := ave(group,length(trim((string)h.pros_assgn)));
    populated_pros_chg_rej_pcnt := ave(group,if(h.pros_chg_rej = (typeof(h.pros_chg_rej))'',0,100));
    maxlength_pros_chg_rej := max(group,length(trim((string)h.pros_chg_rej)));
    avelength_pros_chg_rej := ave(group,length(trim((string)h.pros_chg_rej)));
    populated_pros_off_code_pcnt := ave(group,if(h.pros_off_code = (typeof(h.pros_off_code))'',0,100));
    maxlength_pros_off_code := max(group,length(trim((string)h.pros_off_code)));
    avelength_pros_off_code := ave(group,length(trim((string)h.pros_off_code)));
    populated_pros_off_desc_1_pcnt := ave(group,if(h.pros_off_desc_1 = (typeof(h.pros_off_desc_1))'',0,100));
    maxlength_pros_off_desc_1 := max(group,length(trim((string)h.pros_off_desc_1)));
    avelength_pros_off_desc_1 := ave(group,length(trim((string)h.pros_off_desc_1)));
    populated_pros_off_desc_2_pcnt := ave(group,if(h.pros_off_desc_2 = (typeof(h.pros_off_desc_2))'',0,100));
    maxlength_pros_off_desc_2 := max(group,length(trim((string)h.pros_off_desc_2)));
    avelength_pros_off_desc_2 := ave(group,length(trim((string)h.pros_off_desc_2)));
    populated_pros_off_type_cd_pcnt := ave(group,if(h.pros_off_type_cd = (typeof(h.pros_off_type_cd))'',0,100));
    maxlength_pros_off_type_cd := max(group,length(trim((string)h.pros_off_type_cd)));
    avelength_pros_off_type_cd := ave(group,length(trim((string)h.pros_off_type_cd)));
    populated_pros_off_type_desc_pcnt := ave(group,if(h.pros_off_type_desc = (typeof(h.pros_off_type_desc))'',0,100));
    maxlength_pros_off_type_desc := max(group,length(trim((string)h.pros_off_type_desc)));
    avelength_pros_off_type_desc := ave(group,length(trim((string)h.pros_off_type_desc)));
    populated_pros_off_lev_pcnt := ave(group,if(h.pros_off_lev = (typeof(h.pros_off_lev))'',0,100));
    maxlength_pros_off_lev := max(group,length(trim((string)h.pros_off_lev)));
    avelength_pros_off_lev := ave(group,length(trim((string)h.pros_off_lev)));
    populated_pros_act_filed_pcnt := ave(group,if(h.pros_act_filed = (typeof(h.pros_act_filed))'',0,100));
    maxlength_pros_act_filed := max(group,length(trim((string)h.pros_act_filed)));
    avelength_pros_act_filed := ave(group,length(trim((string)h.pros_act_filed)));
    populated_court_case_number_pcnt := ave(group,if(h.court_case_number = (typeof(h.court_case_number))'',0,100));
    maxlength_court_case_number := max(group,length(trim((string)h.court_case_number)));
    avelength_court_case_number := ave(group,length(trim((string)h.court_case_number)));
    populated_court_cd_pcnt := ave(group,if(h.court_cd = (typeof(h.court_cd))'',0,100));
    maxlength_court_cd := max(group,length(trim((string)h.court_cd)));
    avelength_court_cd := ave(group,length(trim((string)h.court_cd)));
    populated_court_desc_pcnt := ave(group,if(h.court_desc = (typeof(h.court_desc))'',0,100));
    maxlength_court_desc := max(group,length(trim((string)h.court_desc)));
    avelength_court_desc := ave(group,length(trim((string)h.court_desc)));
    populated_court_appeal_flag_pcnt := ave(group,if(h.court_appeal_flag = (typeof(h.court_appeal_flag))'',0,100));
    maxlength_court_appeal_flag := max(group,length(trim((string)h.court_appeal_flag)));
    avelength_court_appeal_flag := ave(group,length(trim((string)h.court_appeal_flag)));
    populated_court_final_plea_pcnt := ave(group,if(h.court_final_plea = (typeof(h.court_final_plea))'',0,100));
    maxlength_court_final_plea := max(group,length(trim((string)h.court_final_plea)));
    avelength_court_final_plea := ave(group,length(trim((string)h.court_final_plea)));
    populated_court_off_code_pcnt := ave(group,if(h.court_off_code = (typeof(h.court_off_code))'',0,100));
    maxlength_court_off_code := max(group,length(trim((string)h.court_off_code)));
    avelength_court_off_code := ave(group,length(trim((string)h.court_off_code)));
    populated_court_off_desc_1_pcnt := ave(group,if(h.court_off_desc_1 = (typeof(h.court_off_desc_1))'',0,100));
    maxlength_court_off_desc_1 := max(group,length(trim((string)h.court_off_desc_1)));
    avelength_court_off_desc_1 := ave(group,length(trim((string)h.court_off_desc_1)));
    populated_court_off_desc_2_pcnt := ave(group,if(h.court_off_desc_2 = (typeof(h.court_off_desc_2))'',0,100));
    maxlength_court_off_desc_2 := max(group,length(trim((string)h.court_off_desc_2)));
    avelength_court_off_desc_2 := ave(group,length(trim((string)h.court_off_desc_2)));
    populated_court_off_type_cd_pcnt := ave(group,if(h.court_off_type_cd = (typeof(h.court_off_type_cd))'',0,100));
    maxlength_court_off_type_cd := max(group,length(trim((string)h.court_off_type_cd)));
    avelength_court_off_type_cd := ave(group,length(trim((string)h.court_off_type_cd)));
    populated_court_off_type_desc_pcnt := ave(group,if(h.court_off_type_desc = (typeof(h.court_off_type_desc))'',0,100));
    maxlength_court_off_type_desc := max(group,length(trim((string)h.court_off_type_desc)));
    avelength_court_off_type_desc := ave(group,length(trim((string)h.court_off_type_desc)));
    populated_court_off_lev_pcnt := ave(group,if(h.court_off_lev = (typeof(h.court_off_lev))'',0,100));
    maxlength_court_off_lev := max(group,length(trim((string)h.court_off_lev)));
    avelength_court_off_lev := ave(group,length(trim((string)h.court_off_lev)));
    populated_court_statute_pcnt := ave(group,if(h.court_statute = (typeof(h.court_statute))'',0,100));
    maxlength_court_statute := max(group,length(trim((string)h.court_statute)));
    avelength_court_statute := ave(group,length(trim((string)h.court_statute)));
    populated_court_additional_statutes_pcnt := ave(group,if(h.court_additional_statutes = (typeof(h.court_additional_statutes))'',0,100));
    maxlength_court_additional_statutes := max(group,length(trim((string)h.court_additional_statutes)));
    avelength_court_additional_statutes := ave(group,length(trim((string)h.court_additional_statutes)));
    populated_court_statute_desc_pcnt := ave(group,if(h.court_statute_desc = (typeof(h.court_statute_desc))'',0,100));
    maxlength_court_statute_desc := max(group,length(trim((string)h.court_statute_desc)));
    avelength_court_statute_desc := ave(group,length(trim((string)h.court_statute_desc)));
    populated_court_disp_date_pcnt := ave(group,if(h.court_disp_date = (typeof(h.court_disp_date))'',0,100));
    maxlength_court_disp_date := max(group,length(trim((string)h.court_disp_date)));
    avelength_court_disp_date := ave(group,length(trim((string)h.court_disp_date)));
    populated_court_disp_code_pcnt := ave(group,if(h.court_disp_code = (typeof(h.court_disp_code))'',0,100));
    maxlength_court_disp_code := max(group,length(trim((string)h.court_disp_code)));
    avelength_court_disp_code := ave(group,length(trim((string)h.court_disp_code)));
    populated_court_disp_desc_1_pcnt := ave(group,if(h.court_disp_desc_1 = (typeof(h.court_disp_desc_1))'',0,100));
    maxlength_court_disp_desc_1 := max(group,length(trim((string)h.court_disp_desc_1)));
    avelength_court_disp_desc_1 := ave(group,length(trim((string)h.court_disp_desc_1)));
    populated_court_disp_desc_2_pcnt := ave(group,if(h.court_disp_desc_2 = (typeof(h.court_disp_desc_2))'',0,100));
    maxlength_court_disp_desc_2 := max(group,length(trim((string)h.court_disp_desc_2)));
    avelength_court_disp_desc_2 := ave(group,length(trim((string)h.court_disp_desc_2)));
    populated_sent_date_pcnt := ave(group,if(h.sent_date = (typeof(h.sent_date))'',0,100));
    maxlength_sent_date := max(group,length(trim((string)h.sent_date)));
    avelength_sent_date := ave(group,length(trim((string)h.sent_date)));
    populated_sent_jail_pcnt := ave(group,if(h.sent_jail = (typeof(h.sent_jail))'',0,100));
    maxlength_sent_jail := max(group,length(trim((string)h.sent_jail)));
    avelength_sent_jail := ave(group,length(trim((string)h.sent_jail)));
    populated_sent_susp_time_pcnt := ave(group,if(h.sent_susp_time = (typeof(h.sent_susp_time))'',0,100));
    maxlength_sent_susp_time := max(group,length(trim((string)h.sent_susp_time)));
    avelength_sent_susp_time := ave(group,length(trim((string)h.sent_susp_time)));
    populated_sent_court_cost_pcnt := ave(group,if(h.sent_court_cost = (typeof(h.sent_court_cost))'',0,100));
    maxlength_sent_court_cost := max(group,length(trim((string)h.sent_court_cost)));
    avelength_sent_court_cost := ave(group,length(trim((string)h.sent_court_cost)));
    populated_sent_court_fine_pcnt := ave(group,if(h.sent_court_fine = (typeof(h.sent_court_fine))'',0,100));
    maxlength_sent_court_fine := max(group,length(trim((string)h.sent_court_fine)));
    avelength_sent_court_fine := ave(group,length(trim((string)h.sent_court_fine)));
    populated_sent_susp_court_fine_pcnt := ave(group,if(h.sent_susp_court_fine = (typeof(h.sent_susp_court_fine))'',0,100));
    maxlength_sent_susp_court_fine := max(group,length(trim((string)h.sent_susp_court_fine)));
    avelength_sent_susp_court_fine := ave(group,length(trim((string)h.sent_susp_court_fine)));
    populated_sent_probation_pcnt := ave(group,if(h.sent_probation = (typeof(h.sent_probation))'',0,100));
    maxlength_sent_probation := max(group,length(trim((string)h.sent_probation)));
    avelength_sent_probation := ave(group,length(trim((string)h.sent_probation)));
    populated_sent_addl_prov_code_pcnt := ave(group,if(h.sent_addl_prov_code = (typeof(h.sent_addl_prov_code))'',0,100));
    maxlength_sent_addl_prov_code := max(group,length(trim((string)h.sent_addl_prov_code)));
    avelength_sent_addl_prov_code := ave(group,length(trim((string)h.sent_addl_prov_code)));
    populated_sent_addl_prov_desc_1_pcnt := ave(group,if(h.sent_addl_prov_desc_1 = (typeof(h.sent_addl_prov_desc_1))'',0,100));
    maxlength_sent_addl_prov_desc_1 := max(group,length(trim((string)h.sent_addl_prov_desc_1)));
    avelength_sent_addl_prov_desc_1 := ave(group,length(trim((string)h.sent_addl_prov_desc_1)));
    populated_sent_addl_prov_desc_2_pcnt := ave(group,if(h.sent_addl_prov_desc_2 = (typeof(h.sent_addl_prov_desc_2))'',0,100));
    maxlength_sent_addl_prov_desc_2 := max(group,length(trim((string)h.sent_addl_prov_desc_2)));
    avelength_sent_addl_prov_desc_2 := ave(group,length(trim((string)h.sent_addl_prov_desc_2)));
    populated_sent_consec_pcnt := ave(group,if(h.sent_consec = (typeof(h.sent_consec))'',0,100));
    maxlength_sent_consec := max(group,length(trim((string)h.sent_consec)));
    avelength_sent_consec := ave(group,length(trim((string)h.sent_consec)));
    populated_sent_agency_rec_cust_ori_pcnt := ave(group,if(h.sent_agency_rec_cust_ori = (typeof(h.sent_agency_rec_cust_ori))'',0,100));
    maxlength_sent_agency_rec_cust_ori := max(group,length(trim((string)h.sent_agency_rec_cust_ori)));
    avelength_sent_agency_rec_cust_ori := ave(group,length(trim((string)h.sent_agency_rec_cust_ori)));
    populated_sent_agency_rec_cust_pcnt := ave(group,if(h.sent_agency_rec_cust = (typeof(h.sent_agency_rec_cust))'',0,100));
    maxlength_sent_agency_rec_cust := max(group,length(trim((string)h.sent_agency_rec_cust)));
    avelength_sent_agency_rec_cust := ave(group,length(trim((string)h.sent_agency_rec_cust)));
    populated_appeal_date_pcnt := ave(group,if(h.appeal_date = (typeof(h.appeal_date))'',0,100));
    maxlength_appeal_date := max(group,length(trim((string)h.appeal_date)));
    avelength_appeal_date := ave(group,length(trim((string)h.appeal_date)));
    populated_appeal_off_disp_pcnt := ave(group,if(h.appeal_off_disp = (typeof(h.appeal_off_disp))'',0,100));
    maxlength_appeal_off_disp := max(group,length(trim((string)h.appeal_off_disp)));
    avelength_appeal_off_disp := ave(group,length(trim((string)h.appeal_off_disp)));
    populated_appeal_final_decision_pcnt := ave(group,if(h.appeal_final_decision = (typeof(h.appeal_final_decision))'',0,100));
    maxlength_appeal_final_decision := max(group,length(trim((string)h.appeal_final_decision)));
    avelength_appeal_final_decision := ave(group,length(trim((string)h.appeal_final_decision)));
  END;
  RETURN table(h,SummaryLayout);
END;
// The character counts
// First create a deduped inversion to speed things up
SALT19.MAC_Character_Counts.Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,trim((string)le.process_date),trim((string)le.offender_key),trim((string)le.vendor),trim((string)le.state_origin),trim((string)le.source_file),trim((string)le.off_comp),trim((string)le.off_delete_flag),trim((string)le.off_date),trim((string)le.arr_date),trim((string)le.num_of_counts),trim((string)le.le_agency_cd),trim((string)le.le_agency_desc),trim((string)le.le_agency_case_number),trim((string)le.traffic_ticket_number),trim((string)le.traffic_dl_no),trim((string)le.traffic_dl_st),trim((string)le.arr_off_code),trim((string)le.arr_off_desc_1),trim((string)le.arr_off_desc_2),trim((string)le.arr_off_type_cd),trim((string)le.arr_off_type_desc),trim((string)le.arr_off_lev),trim((string)le.arr_statute),trim((string)le.arr_statute_desc),trim((string)le.arr_disp_date),trim((string)le.arr_disp_code),trim((string)le.arr_disp_desc_1),trim((string)le.arr_disp_desc_2),trim((string)le.pros_refer_cd),trim((string)le.pros_refer),trim((string)le.pros_assgn_cd),trim((string)le.pros_assgn),trim((string)le.pros_chg_rej),trim((string)le.pros_off_code),trim((string)le.pros_off_desc_1),trim((string)le.pros_off_desc_2),trim((string)le.pros_off_type_cd),trim((string)le.pros_off_type_desc),trim((string)le.pros_off_lev),trim((string)le.pros_act_filed),trim((string)le.court_case_number),trim((string)le.court_cd),trim((string)le.court_desc),trim((string)le.court_appeal_flag),trim((string)le.court_final_plea),trim((string)le.court_off_code),trim((string)le.court_off_desc_1),trim((string)le.court_off_desc_2),trim((string)le.court_off_type_cd),trim((string)le.court_off_type_desc),trim((string)le.court_off_lev),trim((string)le.court_statute),trim((string)le.court_additional_statutes),trim((string)le.court_statute_desc),trim((string)le.court_disp_date),trim((string)le.court_disp_code),trim((string)le.court_disp_desc_1),trim((string)le.court_disp_desc_2),trim((string)le.sent_date),trim((string)le.sent_jail),trim((string)le.sent_susp_time),trim((string)le.sent_court_cost),trim((string)le.sent_court_fine),trim((string)le.sent_susp_court_fine),trim((string)le.sent_probation),trim((string)le.sent_addl_prov_code),trim((string)le.sent_addl_prov_desc_1),trim((string)le.sent_addl_prov_desc_2),trim((string)le.sent_consec),trim((string)le.sent_agency_rec_cust_ori),trim((string)le.sent_agency_rec_cust),trim((string)le.appeal_date),trim((string)le.appeal_off_disp),trim((string)le.appeal_final_decision)));
  SELF.FldNo := C;
END;
shared FldInv0 := NORMALIZE(h,74,Into(LEFT,COUNTER));
shared FldIds := dataset([{1,'process_date'}
      ,{2,'offender_key'}
      ,{3,'vendor'}
      ,{4,'state_origin'}
      ,{5,'source_file'}
      ,{6,'off_comp'}
      ,{7,'off_delete_flag'}
      ,{8,'off_date'}
      ,{9,'arr_date'}
      ,{10,'num_of_counts'}
      ,{11,'le_agency_cd'}
      ,{12,'le_agency_desc'}
      ,{13,'le_agency_case_number'}
      ,{14,'traffic_ticket_number'}
      ,{15,'traffic_dl_no'}
      ,{16,'traffic_dl_st'}
      ,{17,'arr_off_code'}
      ,{18,'arr_off_desc_1'}
      ,{19,'arr_off_desc_2'}
      ,{20,'arr_off_type_cd'}
      ,{21,'arr_off_type_desc'}
      ,{22,'arr_off_lev'}
      ,{23,'arr_statute'}
      ,{24,'arr_statute_desc'}
      ,{25,'arr_disp_date'}
      ,{26,'arr_disp_code'}
      ,{27,'arr_disp_desc_1'}
      ,{28,'arr_disp_desc_2'}
      ,{29,'pros_refer_cd'}
      ,{30,'pros_refer'}
      ,{31,'pros_assgn_cd'}
      ,{32,'pros_assgn'}
      ,{33,'pros_chg_rej'}
      ,{34,'pros_off_code'}
      ,{35,'pros_off_desc_1'}
      ,{36,'pros_off_desc_2'}
      ,{37,'pros_off_type_cd'}
      ,{38,'pros_off_type_desc'}
      ,{39,'pros_off_lev'}
      ,{40,'pros_act_filed'}
      ,{41,'court_case_number'}
      ,{42,'court_cd'}
      ,{43,'court_desc'}
      ,{44,'court_appeal_flag'}
      ,{45,'court_final_plea'}
      ,{46,'court_off_code'}
      ,{47,'court_off_desc_1'}
      ,{48,'court_off_desc_2'}
      ,{49,'court_off_type_cd'}
      ,{50,'court_off_type_desc'}
      ,{51,'court_off_lev'}
      ,{52,'court_statute'}
      ,{53,'court_additional_statutes'}
      ,{54,'court_statute_desc'}
      ,{55,'court_disp_date'}
      ,{56,'court_disp_code'}
      ,{57,'court_disp_desc_1'}
      ,{58,'court_disp_desc_2'}
      ,{59,'sent_date'}
      ,{60,'sent_jail'}
      ,{61,'sent_susp_time'}
      ,{62,'sent_court_cost'}
      ,{63,'sent_court_fine'}
      ,{64,'sent_susp_court_fine'}
      ,{65,'sent_probation'}
      ,{66,'sent_addl_prov_code'}
      ,{67,'sent_addl_prov_desc_1'}
      ,{68,'sent_addl_prov_desc_2'}
      ,{69,'sent_consec'}
      ,{70,'sent_agency_rec_cust_ori'}
      ,{71,'sent_agency_rec_cust'}
      ,{72,'appeal_date'}
      ,{73,'appeal_off_disp'}
      ,{74,'appeal_final_decision'}],SALT19.MAC_Character_Counts.Field_Identification);
export All_Profiles := SALT19.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
export process_date_profile := All_Profiles(FldNo=1);
export offender_key_profile := All_Profiles(FldNo=2);
export vendor_profile := All_Profiles(FldNo=3);
export state_origin_profile := All_Profiles(FldNo=4);
export source_file_profile := All_Profiles(FldNo=5);
export off_comp_profile := All_Profiles(FldNo=6);
export off_delete_flag_profile := All_Profiles(FldNo=7);
export off_date_profile := All_Profiles(FldNo=8);
export arr_date_profile := All_Profiles(FldNo=9);
export num_of_counts_profile := All_Profiles(FldNo=10);
export le_agency_cd_profile := All_Profiles(FldNo=11);
export le_agency_desc_profile := All_Profiles(FldNo=12);
export le_agency_case_number_profile := All_Profiles(FldNo=13);
export traffic_ticket_number_profile := All_Profiles(FldNo=14);
export traffic_dl_no_profile := All_Profiles(FldNo=15);
export traffic_dl_st_profile := All_Profiles(FldNo=16);
export arr_off_code_profile := All_Profiles(FldNo=17);
export arr_off_desc_1_profile := All_Profiles(FldNo=18);
export arr_off_desc_2_profile := All_Profiles(FldNo=19);
export arr_off_type_cd_profile := All_Profiles(FldNo=20);
export arr_off_type_desc_profile := All_Profiles(FldNo=21);
export arr_off_lev_profile := All_Profiles(FldNo=22);
export arr_statute_profile := All_Profiles(FldNo=23);
export arr_statute_desc_profile := All_Profiles(FldNo=24);
export arr_disp_date_profile := All_Profiles(FldNo=25);
export arr_disp_code_profile := All_Profiles(FldNo=26);
export arr_disp_desc_1_profile := All_Profiles(FldNo=27);
export arr_disp_desc_2_profile := All_Profiles(FldNo=28);
export pros_refer_cd_profile := All_Profiles(FldNo=29);
export pros_refer_profile := All_Profiles(FldNo=30);
export pros_assgn_cd_profile := All_Profiles(FldNo=31);
export pros_assgn_profile := All_Profiles(FldNo=32);
export pros_chg_rej_profile := All_Profiles(FldNo=33);
export pros_off_code_profile := All_Profiles(FldNo=34);
export pros_off_desc_1_profile := All_Profiles(FldNo=35);
export pros_off_desc_2_profile := All_Profiles(FldNo=36);
export pros_off_type_cd_profile := All_Profiles(FldNo=37);
export pros_off_type_desc_profile := All_Profiles(FldNo=38);
export pros_off_lev_profile := All_Profiles(FldNo=39);
export pros_act_filed_profile := All_Profiles(FldNo=40);
export court_case_number_profile := All_Profiles(FldNo=41);
export court_cd_profile := All_Profiles(FldNo=42);
export court_desc_profile := All_Profiles(FldNo=43);
export court_appeal_flag_profile := All_Profiles(FldNo=44);
export court_final_plea_profile := All_Profiles(FldNo=45);
export court_off_code_profile := All_Profiles(FldNo=46);
export court_off_desc_1_profile := All_Profiles(FldNo=47);
export court_off_desc_2_profile := All_Profiles(FldNo=48);
export court_off_type_cd_profile := All_Profiles(FldNo=49);
export court_off_type_desc_profile := All_Profiles(FldNo=50);
export court_off_lev_profile := All_Profiles(FldNo=51);
export court_statute_profile := All_Profiles(FldNo=52);
export court_additional_statutes_profile := All_Profiles(FldNo=53);
export court_statute_desc_profile := All_Profiles(FldNo=54);
export court_disp_date_profile := All_Profiles(FldNo=55);
export court_disp_code_profile := All_Profiles(FldNo=56);
export court_disp_desc_1_profile := All_Profiles(FldNo=57);
export court_disp_desc_2_profile := All_Profiles(FldNo=58);
export sent_date_profile := All_Profiles(FldNo=59);
export sent_jail_profile := All_Profiles(FldNo=60);
export sent_susp_time_profile := All_Profiles(FldNo=61);
export sent_court_cost_profile := All_Profiles(FldNo=62);
export sent_court_fine_profile := All_Profiles(FldNo=63);
export sent_susp_court_fine_profile := All_Profiles(FldNo=64);
export sent_probation_profile := All_Profiles(FldNo=65);
export sent_addl_prov_code_profile := All_Profiles(FldNo=66);
export sent_addl_prov_desc_1_profile := All_Profiles(FldNo=67);
export sent_addl_prov_desc_2_profile := All_Profiles(FldNo=68);
export sent_consec_profile := All_Profiles(FldNo=69);
export sent_agency_rec_cust_ori_profile := All_Profiles(FldNo=70);
export sent_agency_rec_cust_profile := All_Profiles(FldNo=71);
export appeal_date_profile := All_Profiles(FldNo=72);
export appeal_off_disp_profile := All_Profiles(FldNo=73);
export appeal_final_decision_profile := All_Profiles(FldNo=74);
ErrorRecord := record
  unsigned1 FieldNum;
  unsigned1 ErrorNum;
end;
ErrorRecord NoteErrors(h le,unsigned1 c) := transform
  self.ErrorNum := CHOOSE(c,
    Fields.InValid_process_date((string)le.process_date),
    Fields.InValid_offender_key((string)le.offender_key),
    Fields.InValid_vendor((string)le.vendor),
    Fields.InValid_state_origin((string)le.state_origin),
    Fields.InValid_source_file((string)le.source_file),
    Fields.InValid_off_comp((string)le.off_comp),
    Fields.InValid_off_delete_flag((string)le.off_delete_flag),
    Fields.InValid_off_date((string)le.off_date),
    Fields.InValid_arr_date((string)le.arr_date),
    Fields.InValid_num_of_counts((string)le.num_of_counts),
    Fields.InValid_le_agency_cd((string)le.le_agency_cd),
    Fields.InValid_le_agency_desc((string)le.le_agency_desc),
    Fields.InValid_le_agency_case_number((string)le.le_agency_case_number),
    Fields.InValid_traffic_ticket_number((string)le.traffic_ticket_number),
    Fields.InValid_traffic_dl_no((string)le.traffic_dl_no),
    Fields.InValid_traffic_dl_st((string)le.traffic_dl_st),
    Fields.InValid_arr_off_code((string)le.arr_off_code),
    Fields.InValid_arr_off_desc_1((string)le.arr_off_desc_1),
    Fields.InValid_arr_off_desc_2((string)le.arr_off_desc_2),
    Fields.InValid_arr_off_type_cd((string)le.arr_off_type_cd),
    Fields.InValid_arr_off_type_desc((string)le.arr_off_type_desc),
    Fields.InValid_arr_off_lev((string)le.arr_off_lev),
    Fields.InValid_arr_statute((string)le.arr_statute),
    Fields.InValid_arr_statute_desc((string)le.arr_statute_desc),
    Fields.InValid_arr_disp_date((string)le.arr_disp_date),
    Fields.InValid_arr_disp_code((string)le.arr_disp_code),
    Fields.InValid_arr_disp_desc_1((string)le.arr_disp_desc_1),
    Fields.InValid_arr_disp_desc_2((string)le.arr_disp_desc_2),
    Fields.InValid_pros_refer_cd((string)le.pros_refer_cd),
    Fields.InValid_pros_refer((string)le.pros_refer),
    Fields.InValid_pros_assgn_cd((string)le.pros_assgn_cd),
    Fields.InValid_pros_assgn((string)le.pros_assgn),
    Fields.InValid_pros_chg_rej((string)le.pros_chg_rej),
    Fields.InValid_pros_off_code((string)le.pros_off_code),
    Fields.InValid_pros_off_desc_1((string)le.pros_off_desc_1),
    Fields.InValid_pros_off_desc_2((string)le.pros_off_desc_2),
    Fields.InValid_pros_off_type_cd((string)le.pros_off_type_cd),
    Fields.InValid_pros_off_type_desc((string)le.pros_off_type_desc),
    Fields.InValid_pros_off_lev((string)le.pros_off_lev),
    Fields.InValid_pros_act_filed((string)le.pros_act_filed),
    Fields.InValid_court_case_number((string)le.court_case_number),
    Fields.InValid_court_cd((string)le.court_cd),
    Fields.InValid_court_desc((string)le.court_desc),
    Fields.InValid_court_appeal_flag((string)le.court_appeal_flag),
    Fields.InValid_court_final_plea((string)le.court_final_plea),
    Fields.InValid_court_off_code((string)le.court_off_code),
    Fields.InValid_court_off_desc_1((string)le.court_off_desc_1),
    Fields.InValid_court_off_desc_2((string)le.court_off_desc_2),
    Fields.InValid_court_off_type_cd((string)le.court_off_type_cd),
    Fields.InValid_court_off_type_desc((string)le.court_off_type_desc),
    Fields.InValid_court_off_lev((string)le.court_off_lev),
    Fields.InValid_court_statute((string)le.court_statute),
    Fields.InValid_court_additional_statutes((string)le.court_additional_statutes),
    Fields.InValid_court_statute_desc((string)le.court_statute_desc),
    Fields.InValid_court_disp_date((string)le.court_disp_date),
    Fields.InValid_court_disp_code((string)le.court_disp_code),
    Fields.InValid_court_disp_desc_1((string)le.court_disp_desc_1),
    Fields.InValid_court_disp_desc_2((string)le.court_disp_desc_2),
    Fields.InValid_sent_date((string)le.sent_date),
    Fields.InValid_sent_jail((string)le.sent_jail),
    Fields.InValid_sent_susp_time((string)le.sent_susp_time),
    Fields.InValid_sent_court_cost((string)le.sent_court_cost),
    Fields.InValid_sent_court_fine((string)le.sent_court_fine),
    Fields.InValid_sent_susp_court_fine((string)le.sent_susp_court_fine),
    Fields.InValid_sent_probation((string)le.sent_probation),
    Fields.InValid_sent_addl_prov_code((string)le.sent_addl_prov_code),
    Fields.InValid_sent_addl_prov_desc_1((string)le.sent_addl_prov_desc_1),
    Fields.InValid_sent_addl_prov_desc_2((string)le.sent_addl_prov_desc_2),
    Fields.InValid_sent_consec((string)le.sent_consec),
    Fields.InValid_sent_agency_rec_cust_ori((string)le.sent_agency_rec_cust_ori),
    Fields.InValid_sent_agency_rec_cust((string)le.sent_agency_rec_cust),
    Fields.InValid_appeal_date((string)le.appeal_date),
    Fields.InValid_appeal_off_disp((string)le.appeal_off_disp),
    Fields.InValid_appeal_final_decision((string)le.appeal_final_decision),
    0);
  self.FieldNum := IF(self.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
end;
Errors := normalize(h,74,NoteErrors(left,counter));
ErrorRecordsTotals := record
  Errors.FieldNum;
  Errors.ErrorNum;
  unsigned Cnt := count(group);
end;
TotalErrors := table(Errors,ErrorRecordsTotals,FieldNum,ErrorNum);
PrettyErrorTotals := record
  FieldName := CHOOSE(TotalErrors.FieldNum,'process_date','offender_key','vendor','state_origin','source_file','off_comp','off_delete_flag','off_date','arr_date','num_of_counts','le_agency_cd','le_agency_desc','le_agency_case_number','traffic_ticket_number','traffic_dl_no','traffic_dl_st','arr_off_code','arr_off_desc_1','arr_off_desc_2','arr_off_type_cd','arr_off_type_desc','arr_off_lev','arr_statute','arr_statute_desc','arr_disp_date','arr_disp_code','arr_disp_desc_1','arr_disp_desc_2','pros_refer_cd','pros_refer','pros_assgn_cd','pros_assgn','pros_chg_rej','pros_off_code','pros_off_desc_1','pros_off_desc_2','pros_off_type_cd','pros_off_type_desc','pros_off_lev','pros_act_filed','court_case_number','court_cd','court_desc','court_appeal_flag','court_final_plea','court_off_code','court_off_desc_1','court_off_desc_2','court_off_type_cd','court_off_type_desc','court_off_lev','court_statute','court_additional_statutes','court_statute_desc','court_disp_date','court_disp_code','court_disp_desc_1','court_disp_desc_2','sent_date','sent_jail','sent_susp_time','sent_court_cost','sent_court_fine','sent_susp_court_fine','sent_probation','sent_addl_prov_code','sent_addl_prov_desc_1','sent_addl_prov_desc_2','sent_consec','sent_agency_rec_cust_ori','sent_agency_rec_cust','appeal_date','appeal_off_disp','appeal_final_decision');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_offender_key(TotalErrors.ErrorNum),Fields.InValidMessage_vendor(TotalErrors.ErrorNum),Fields.InValidMessage_state_origin(TotalErrors.ErrorNum),Fields.InValidMessage_source_file(TotalErrors.ErrorNum),Fields.InValidMessage_off_comp(TotalErrors.ErrorNum),Fields.InValidMessage_off_delete_flag(TotalErrors.ErrorNum),Fields.InValidMessage_off_date(TotalErrors.ErrorNum),Fields.InValidMessage_arr_date(TotalErrors.ErrorNum),Fields.InValidMessage_num_of_counts(TotalErrors.ErrorNum),Fields.InValidMessage_le_agency_cd(TotalErrors.ErrorNum),Fields.InValidMessage_le_agency_desc(TotalErrors.ErrorNum),Fields.InValidMessage_le_agency_case_number(TotalErrors.ErrorNum),Fields.InValidMessage_traffic_ticket_number(TotalErrors.ErrorNum),Fields.InValidMessage_traffic_dl_no(TotalErrors.ErrorNum),Fields.InValidMessage_traffic_dl_st(TotalErrors.ErrorNum),Fields.InValidMessage_arr_off_code(TotalErrors.ErrorNum),Fields.InValidMessage_arr_off_desc_1(TotalErrors.ErrorNum),Fields.InValidMessage_arr_off_desc_2(TotalErrors.ErrorNum),Fields.InValidMessage_arr_off_type_cd(TotalErrors.ErrorNum),Fields.InValidMessage_arr_off_type_desc(TotalErrors.ErrorNum),Fields.InValidMessage_arr_off_lev(TotalErrors.ErrorNum),Fields.InValidMessage_arr_statute(TotalErrors.ErrorNum),Fields.InValidMessage_arr_statute_desc(TotalErrors.ErrorNum),Fields.InValidMessage_arr_disp_date(TotalErrors.ErrorNum),Fields.InValidMessage_arr_disp_code(TotalErrors.ErrorNum),Fields.InValidMessage_arr_disp_desc_1(TotalErrors.ErrorNum),Fields.InValidMessage_arr_disp_desc_2(TotalErrors.ErrorNum),Fields.InValidMessage_pros_refer_cd(TotalErrors.ErrorNum),Fields.InValidMessage_pros_refer(TotalErrors.ErrorNum),Fields.InValidMessage_pros_assgn_cd(TotalErrors.ErrorNum),Fields.InValidMessage_pros_assgn(TotalErrors.ErrorNum),Fields.InValidMessage_pros_chg_rej(TotalErrors.ErrorNum),Fields.InValidMessage_pros_off_code(TotalErrors.ErrorNum),Fields.InValidMessage_pros_off_desc_1(TotalErrors.ErrorNum),Fields.InValidMessage_pros_off_desc_2(TotalErrors.ErrorNum),Fields.InValidMessage_pros_off_type_cd(TotalErrors.ErrorNum),Fields.InValidMessage_pros_off_type_desc(TotalErrors.ErrorNum),Fields.InValidMessage_pros_off_lev(TotalErrors.ErrorNum),Fields.InValidMessage_pros_act_filed(TotalErrors.ErrorNum),Fields.InValidMessage_court_case_number(TotalErrors.ErrorNum),Fields.InValidMessage_court_cd(TotalErrors.ErrorNum),Fields.InValidMessage_court_desc(TotalErrors.ErrorNum),Fields.InValidMessage_court_appeal_flag(TotalErrors.ErrorNum),Fields.InValidMessage_court_final_plea(TotalErrors.ErrorNum),Fields.InValidMessage_court_off_code(TotalErrors.ErrorNum),Fields.InValidMessage_court_off_desc_1(TotalErrors.ErrorNum),Fields.InValidMessage_court_off_desc_2(TotalErrors.ErrorNum),Fields.InValidMessage_court_off_type_cd(TotalErrors.ErrorNum),Fields.InValidMessage_court_off_type_desc(TotalErrors.ErrorNum),Fields.InValidMessage_court_off_lev(TotalErrors.ErrorNum),Fields.InValidMessage_court_statute(TotalErrors.ErrorNum),Fields.InValidMessage_court_additional_statutes(TotalErrors.ErrorNum),Fields.InValidMessage_court_statute_desc(TotalErrors.ErrorNum),Fields.InValidMessage_court_disp_date(TotalErrors.ErrorNum),Fields.InValidMessage_court_disp_code(TotalErrors.ErrorNum),Fields.InValidMessage_court_disp_desc_1(TotalErrors.ErrorNum),Fields.InValidMessage_court_disp_desc_2(TotalErrors.ErrorNum),Fields.InValidMessage_sent_date(TotalErrors.ErrorNum),Fields.InValidMessage_sent_jail(TotalErrors.ErrorNum),Fields.InValidMessage_sent_susp_time(TotalErrors.ErrorNum),Fields.InValidMessage_sent_court_cost(TotalErrors.ErrorNum),Fields.InValidMessage_sent_court_fine(TotalErrors.ErrorNum),Fields.InValidMessage_sent_susp_court_fine(TotalErrors.ErrorNum),Fields.InValidMessage_sent_probation(TotalErrors.ErrorNum),Fields.InValidMessage_sent_addl_prov_code(TotalErrors.ErrorNum),Fields.InValidMessage_sent_addl_prov_desc_1(TotalErrors.ErrorNum),Fields.InValidMessage_sent_addl_prov_desc_2(TotalErrors.ErrorNum),Fields.InValidMessage_sent_consec(TotalErrors.ErrorNum),Fields.InValidMessage_sent_agency_rec_cust_ori(TotalErrors.ErrorNum),Fields.InValidMessage_sent_agency_rec_cust(TotalErrors.ErrorNum),Fields.InValidMessage_appeal_date(TotalErrors.ErrorNum),Fields.InValidMessage_appeal_off_disp(TotalErrors.ErrorNum),Fields.InValidMessage_appeal_final_decision(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
end;
ValErr := table(TotalErrors,PrettyErrorTotals);
export ValidityErrors := ValErr;
end;
