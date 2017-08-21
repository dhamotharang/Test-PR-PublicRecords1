import ut;
export Fields := MODULE
//Individual field level validation
export InValid_process_date(string s) := WHICH();
export InValidMessage_process_date(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_process_date(string s0) := FUNCTION
return s0;
end;
export InValid_offender_key(string s) := WHICH();
export InValidMessage_offender_key(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_offender_key(string s0) := FUNCTION
return s0;
end;
export InValid_vendor(string s) := WHICH();
export InValidMessage_vendor(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_vendor(string s0) := FUNCTION
return s0;
end;
export InValid_state_origin(string s) := WHICH();
export InValidMessage_state_origin(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_state_origin(string s0) := FUNCTION
return s0;
end;
export InValid_source_file(string s) := WHICH();
export InValidMessage_source_file(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_source_file(string s0) := FUNCTION
return s0;
end;
export InValid_off_comp(string s) := WHICH();
export InValidMessage_off_comp(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_off_comp(string s0) := FUNCTION
return s0;
end;
export InValid_off_delete_flag(string s) := WHICH();
export InValidMessage_off_delete_flag(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_off_delete_flag(string s0) := FUNCTION
return s0;
end;
export InValid_off_date(string s) := WHICH();
export InValidMessage_off_date(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_off_date(string s0) := FUNCTION
return s0;
end;
export InValid_arr_date(string s) := WHICH();
export InValidMessage_arr_date(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_arr_date(string s0) := FUNCTION
return s0;
end;
export InValid_num_of_counts(string s) := WHICH();
export InValidMessage_num_of_counts(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_num_of_counts(string s0) := FUNCTION
return s0;
end;
export InValid_le_agency_cd(string s) := WHICH();
export InValidMessage_le_agency_cd(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_le_agency_cd(string s0) := FUNCTION
return s0;
end;
export InValid_le_agency_desc(string s) := WHICH();
export InValidMessage_le_agency_desc(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_le_agency_desc(string s0) := FUNCTION
return s0;
end;
export InValid_le_agency_case_number(string s) := WHICH();
export InValidMessage_le_agency_case_number(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_le_agency_case_number(string s0) := FUNCTION
return s0;
end;
export InValid_traffic_ticket_number(string s) := WHICH();
export InValidMessage_traffic_ticket_number(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_traffic_ticket_number(string s0) := FUNCTION
return s0;
end;
export InValid_traffic_dl_no(string s) := WHICH();
export InValidMessage_traffic_dl_no(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_traffic_dl_no(string s0) := FUNCTION
return s0;
end;
export InValid_traffic_dl_st(string s) := WHICH();
export InValidMessage_traffic_dl_st(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_traffic_dl_st(string s0) := FUNCTION
return s0;
end;
export InValid_arr_off_code(string s) := WHICH();
export InValidMessage_arr_off_code(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_arr_off_code(string s0) := FUNCTION
return s0;
end;
export InValid_arr_off_desc_1(string s) := WHICH();
export InValidMessage_arr_off_desc_1(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_arr_off_desc_1(string s0) := FUNCTION
return s0;
end;
export InValid_arr_off_desc_2(string s) := WHICH();
export InValidMessage_arr_off_desc_2(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_arr_off_desc_2(string s0) := FUNCTION
return s0;
end;
export InValid_arr_off_type_cd(string s) := WHICH();
export InValidMessage_arr_off_type_cd(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_arr_off_type_cd(string s0) := FUNCTION
return s0;
end;
export InValid_arr_off_type_desc(string s) := WHICH();
export InValidMessage_arr_off_type_desc(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_arr_off_type_desc(string s0) := FUNCTION
return s0;
end;
export InValid_arr_off_lev(string s) := WHICH();
export InValidMessage_arr_off_lev(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_arr_off_lev(string s0) := FUNCTION
return s0;
end;
export InValid_arr_statute(string s) := WHICH();
export InValidMessage_arr_statute(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_arr_statute(string s0) := FUNCTION
return s0;
end;
export InValid_arr_statute_desc(string s) := WHICH();
export InValidMessage_arr_statute_desc(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_arr_statute_desc(string s0) := FUNCTION
return s0;
end;
export InValid_arr_disp_date(string s) := WHICH();
export InValidMessage_arr_disp_date(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_arr_disp_date(string s0) := FUNCTION
return s0;
end;
export InValid_arr_disp_code(string s) := WHICH();
export InValidMessage_arr_disp_code(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_arr_disp_code(string s0) := FUNCTION
return s0;
end;
export InValid_arr_disp_desc_1(string s) := WHICH();
export InValidMessage_arr_disp_desc_1(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_arr_disp_desc_1(string s0) := FUNCTION
return s0;
end;
export InValid_arr_disp_desc_2(string s) := WHICH();
export InValidMessage_arr_disp_desc_2(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_arr_disp_desc_2(string s0) := FUNCTION
return s0;
end;
export InValid_pros_refer_cd(string s) := WHICH();
export InValidMessage_pros_refer_cd(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_pros_refer_cd(string s0) := FUNCTION
return s0;
end;
export InValid_pros_refer(string s) := WHICH();
export InValidMessage_pros_refer(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_pros_refer(string s0) := FUNCTION
return s0;
end;
export InValid_pros_assgn_cd(string s) := WHICH();
export InValidMessage_pros_assgn_cd(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_pros_assgn_cd(string s0) := FUNCTION
return s0;
end;
export InValid_pros_assgn(string s) := WHICH();
export InValidMessage_pros_assgn(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_pros_assgn(string s0) := FUNCTION
return s0;
end;
export InValid_pros_chg_rej(string s) := WHICH();
export InValidMessage_pros_chg_rej(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_pros_chg_rej(string s0) := FUNCTION
return s0;
end;
export InValid_pros_off_code(string s) := WHICH();
export InValidMessage_pros_off_code(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_pros_off_code(string s0) := FUNCTION
return s0;
end;
export InValid_pros_off_desc_1(string s) := WHICH();
export InValidMessage_pros_off_desc_1(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_pros_off_desc_1(string s0) := FUNCTION
return s0;
end;
export InValid_pros_off_desc_2(string s) := WHICH();
export InValidMessage_pros_off_desc_2(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_pros_off_desc_2(string s0) := FUNCTION
return s0;
end;
export InValid_pros_off_type_cd(string s) := WHICH();
export InValidMessage_pros_off_type_cd(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_pros_off_type_cd(string s0) := FUNCTION
return s0;
end;
export InValid_pros_off_type_desc(string s) := WHICH();
export InValidMessage_pros_off_type_desc(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_pros_off_type_desc(string s0) := FUNCTION
return s0;
end;
export InValid_pros_off_lev(string s) := WHICH();
export InValidMessage_pros_off_lev(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_pros_off_lev(string s0) := FUNCTION
return s0;
end;
export InValid_pros_act_filed(string s) := WHICH();
export InValidMessage_pros_act_filed(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_pros_act_filed(string s0) := FUNCTION
return s0;
end;
export InValid_court_case_number(string s) := WHICH();
export InValidMessage_court_case_number(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_court_case_number(string s0) := FUNCTION
return s0;
end;
export InValid_court_cd(string s) := WHICH();
export InValidMessage_court_cd(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_court_cd(string s0) := FUNCTION
return s0;
end;
export InValid_court_desc(string s) := WHICH();
export InValidMessage_court_desc(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_court_desc(string s0) := FUNCTION
return s0;
end;
export InValid_court_appeal_flag(string s) := WHICH();
export InValidMessage_court_appeal_flag(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_court_appeal_flag(string s0) := FUNCTION
return s0;
end;
export InValid_court_final_plea(string s) := WHICH();
export InValidMessage_court_final_plea(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_court_final_plea(string s0) := FUNCTION
return s0;
end;
export InValid_court_off_code(string s) := WHICH();
export InValidMessage_court_off_code(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_court_off_code(string s0) := FUNCTION
return s0;
end;
export InValid_court_off_desc_1(string s) := WHICH();
export InValidMessage_court_off_desc_1(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_court_off_desc_1(string s0) := FUNCTION
return s0;
end;
export InValid_court_off_desc_2(string s) := WHICH();
export InValidMessage_court_off_desc_2(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_court_off_desc_2(string s0) := FUNCTION
return s0;
end;
export InValid_court_off_type_cd(string s) := WHICH();
export InValidMessage_court_off_type_cd(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_court_off_type_cd(string s0) := FUNCTION
return s0;
end;
export InValid_court_off_type_desc(string s) := WHICH();
export InValidMessage_court_off_type_desc(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_court_off_type_desc(string s0) := FUNCTION
return s0;
end;
export InValid_court_off_lev(string s) := WHICH();
export InValidMessage_court_off_lev(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_court_off_lev(string s0) := FUNCTION
return s0;
end;
export InValid_court_statute(string s) := WHICH();
export InValidMessage_court_statute(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_court_statute(string s0) := FUNCTION
return s0;
end;
export InValid_court_additional_statutes(string s) := WHICH();
export InValidMessage_court_additional_statutes(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_court_additional_statutes(string s0) := FUNCTION
return s0;
end;
export InValid_court_statute_desc(string s) := WHICH();
export InValidMessage_court_statute_desc(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_court_statute_desc(string s0) := FUNCTION
return s0;
end;
export InValid_court_disp_date(string s) := WHICH();
export InValidMessage_court_disp_date(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_court_disp_date(string s0) := FUNCTION
return s0;
end;
export InValid_court_disp_code(string s) := WHICH();
export InValidMessage_court_disp_code(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_court_disp_code(string s0) := FUNCTION
return s0;
end;
export InValid_court_disp_desc_1(string s) := WHICH();
export InValidMessage_court_disp_desc_1(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_court_disp_desc_1(string s0) := FUNCTION
return s0;
end;
export InValid_court_disp_desc_2(string s) := WHICH();
export InValidMessage_court_disp_desc_2(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_court_disp_desc_2(string s0) := FUNCTION
return s0;
end;
export InValid_sent_date(string s) := WHICH();
export InValidMessage_sent_date(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_sent_date(string s0) := FUNCTION
return s0;
end;
export InValid_sent_jail(string s) := WHICH();
export InValidMessage_sent_jail(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_sent_jail(string s0) := FUNCTION
return s0;
end;
export InValid_sent_susp_time(string s) := WHICH();
export InValidMessage_sent_susp_time(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_sent_susp_time(string s0) := FUNCTION
return s0;
end;
export InValid_sent_court_cost(string s) := WHICH();
export InValidMessage_sent_court_cost(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_sent_court_cost(string s0) := FUNCTION
return s0;
end;
export InValid_sent_court_fine(string s) := WHICH();
export InValidMessage_sent_court_fine(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_sent_court_fine(string s0) := FUNCTION
return s0;
end;
export InValid_sent_susp_court_fine(string s) := WHICH();
export InValidMessage_sent_susp_court_fine(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_sent_susp_court_fine(string s0) := FUNCTION
return s0;
end;
export InValid_sent_probation(string s) := WHICH();
export InValidMessage_sent_probation(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_sent_probation(string s0) := FUNCTION
return s0;
end;
export InValid_sent_addl_prov_code(string s) := WHICH();
export InValidMessage_sent_addl_prov_code(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_sent_addl_prov_code(string s0) := FUNCTION
return s0;
end;
export InValid_sent_addl_prov_desc_1(string s) := WHICH();
export InValidMessage_sent_addl_prov_desc_1(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_sent_addl_prov_desc_1(string s0) := FUNCTION
return s0;
end;
export InValid_sent_addl_prov_desc_2(string s) := WHICH();
export InValidMessage_sent_addl_prov_desc_2(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_sent_addl_prov_desc_2(string s0) := FUNCTION
return s0;
end;
export InValid_sent_consec(string s) := WHICH();
export InValidMessage_sent_consec(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_sent_consec(string s0) := FUNCTION
return s0;
end;
export InValid_sent_agency_rec_cust_ori(string s) := WHICH();
export InValidMessage_sent_agency_rec_cust_ori(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_sent_agency_rec_cust_ori(string s0) := FUNCTION
return s0;
end;
export InValid_sent_agency_rec_cust(string s) := WHICH();
export InValidMessage_sent_agency_rec_cust(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_sent_agency_rec_cust(string s0) := FUNCTION
return s0;
end;
export InValid_appeal_date(string s) := WHICH();
export InValidMessage_appeal_date(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_appeal_date(string s0) := FUNCTION
return s0;
end;
export InValid_appeal_off_disp(string s) := WHICH();
export InValidMessage_appeal_off_disp(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_appeal_off_disp(string s0) := FUNCTION
return s0;
end;
export InValid_appeal_final_decision(string s) := WHICH();
export InValidMessage_appeal_final_decision(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_appeal_final_decision(string s0) := FUNCTION
return s0;
end;
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
//Find those highly occuring pivot values to remove them from consideration
#uniquename(tr)
  %tr% := table(in_left+in_right,{ val := pivot_exp; });
#uniquename(r1)
  %r1% := record
    %tr%.val;    unsigned Cnt := COUNT(GROUP);
  end;
#uniquename(t1)
  %t1% := table(%tr%,%r1%,val,local); // Pre-aggregate before distribute
#uniquename(r2)
  %r2% := record
    %t1%.val;    unsigned Cnt := SUM(GROUP,%t1%.Cnt);
  end;
#uniquename(t2)
  %t2% := table(%t1%,%r2%,val); // Now do global aggregate
Bad_Pivots := %t2%(Cnt>100);
#uniquename(dl)
  %dl% := RECORD
    BOOLEAN Diff_process_date;
    BOOLEAN Diff_offender_key;
    BOOLEAN Diff_vendor;
    BOOLEAN Diff_state_origin;
    BOOLEAN Diff_source_file;
    BOOLEAN Diff_off_comp;
    BOOLEAN Diff_off_delete_flag;
    BOOLEAN Diff_off_date;
    BOOLEAN Diff_arr_date;
    BOOLEAN Diff_num_of_counts;
    BOOLEAN Diff_le_agency_cd;
    BOOLEAN Diff_le_agency_desc;
    BOOLEAN Diff_le_agency_case_number;
    BOOLEAN Diff_traffic_ticket_number;
    BOOLEAN Diff_traffic_dl_no;
    BOOLEAN Diff_traffic_dl_st;
    BOOLEAN Diff_arr_off_code;
    BOOLEAN Diff_arr_off_desc_1;
    BOOLEAN Diff_arr_off_desc_2;
    BOOLEAN Diff_arr_off_type_cd;
    BOOLEAN Diff_arr_off_type_desc;
    BOOLEAN Diff_arr_off_lev;
    BOOLEAN Diff_arr_statute;
    BOOLEAN Diff_arr_statute_desc;
    BOOLEAN Diff_arr_disp_date;
    BOOLEAN Diff_arr_disp_code;
    BOOLEAN Diff_arr_disp_desc_1;
    BOOLEAN Diff_arr_disp_desc_2;
    BOOLEAN Diff_pros_refer_cd;
    BOOLEAN Diff_pros_refer;
    BOOLEAN Diff_pros_assgn_cd;
    BOOLEAN Diff_pros_assgn;
    BOOLEAN Diff_pros_chg_rej;
    BOOLEAN Diff_pros_off_code;
    BOOLEAN Diff_pros_off_desc_1;
    BOOLEAN Diff_pros_off_desc_2;
    BOOLEAN Diff_pros_off_type_cd;
    BOOLEAN Diff_pros_off_type_desc;
    BOOLEAN Diff_pros_off_lev;
    BOOLEAN Diff_pros_act_filed;
    BOOLEAN Diff_court_case_number;
    BOOLEAN Diff_court_cd;
    BOOLEAN Diff_court_desc;
    BOOLEAN Diff_court_appeal_flag;
    BOOLEAN Diff_court_final_plea;
    BOOLEAN Diff_court_off_code;
    BOOLEAN Diff_court_off_desc_1;
    BOOLEAN Diff_court_off_desc_2;
    BOOLEAN Diff_court_off_type_cd;
    BOOLEAN Diff_court_off_type_desc;
    BOOLEAN Diff_court_off_lev;
    BOOLEAN Diff_court_statute;
    BOOLEAN Diff_court_additional_statutes;
    BOOLEAN Diff_court_statute_desc;
    BOOLEAN Diff_court_disp_date;
    BOOLEAN Diff_court_disp_code;
    BOOLEAN Diff_court_disp_desc_1;
    BOOLEAN Diff_court_disp_desc_2;
    BOOLEAN Diff_sent_date;
    BOOLEAN Diff_sent_jail;
    BOOLEAN Diff_sent_susp_time;
    BOOLEAN Diff_sent_court_cost;
    BOOLEAN Diff_sent_court_fine;
    BOOLEAN Diff_sent_susp_court_fine;
    BOOLEAN Diff_sent_probation;
    BOOLEAN Diff_sent_addl_prov_code;
    BOOLEAN Diff_sent_addl_prov_desc_1;
    BOOLEAN Diff_sent_addl_prov_desc_2;
    BOOLEAN Diff_sent_consec;
    BOOLEAN Diff_sent_agency_rec_cust_ori;
    BOOLEAN Diff_sent_agency_rec_cust;
    BOOLEAN Diff_appeal_date;
    BOOLEAN Diff_appeal_off_disp;
    BOOLEAN Diff_appeal_final_decision;
    UNSIGNED Num_Diffs;
    STRING Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := transform
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_offender_key := le.offender_key <> ri.offender_key;
    SELF.Diff_vendor := le.vendor <> ri.vendor;
    SELF.Diff_state_origin := le.state_origin <> ri.state_origin;
    SELF.Diff_source_file := le.source_file <> ri.source_file;
    SELF.Diff_off_comp := le.off_comp <> ri.off_comp;
    SELF.Diff_off_delete_flag := le.off_delete_flag <> ri.off_delete_flag;
    SELF.Diff_off_date := le.off_date <> ri.off_date;
    SELF.Diff_arr_date := le.arr_date <> ri.arr_date;
    SELF.Diff_num_of_counts := le.num_of_counts <> ri.num_of_counts;
    SELF.Diff_le_agency_cd := le.le_agency_cd <> ri.le_agency_cd;
    SELF.Diff_le_agency_desc := le.le_agency_desc <> ri.le_agency_desc;
    SELF.Diff_le_agency_case_number := le.le_agency_case_number <> ri.le_agency_case_number;
    SELF.Diff_traffic_ticket_number := le.traffic_ticket_number <> ri.traffic_ticket_number;
    SELF.Diff_traffic_dl_no := le.traffic_dl_no <> ri.traffic_dl_no;
    SELF.Diff_traffic_dl_st := le.traffic_dl_st <> ri.traffic_dl_st;
    SELF.Diff_arr_off_code := le.arr_off_code <> ri.arr_off_code;
    SELF.Diff_arr_off_desc_1 := le.arr_off_desc_1 <> ri.arr_off_desc_1;
    SELF.Diff_arr_off_desc_2 := le.arr_off_desc_2 <> ri.arr_off_desc_2;
    SELF.Diff_arr_off_type_cd := le.arr_off_type_cd <> ri.arr_off_type_cd;
    SELF.Diff_arr_off_type_desc := le.arr_off_type_desc <> ri.arr_off_type_desc;
    SELF.Diff_arr_off_lev := le.arr_off_lev <> ri.arr_off_lev;
    SELF.Diff_arr_statute := le.arr_statute <> ri.arr_statute;
    SELF.Diff_arr_statute_desc := le.arr_statute_desc <> ri.arr_statute_desc;
    SELF.Diff_arr_disp_date := le.arr_disp_date <> ri.arr_disp_date;
    SELF.Diff_arr_disp_code := le.arr_disp_code <> ri.arr_disp_code;
    SELF.Diff_arr_disp_desc_1 := le.arr_disp_desc_1 <> ri.arr_disp_desc_1;
    SELF.Diff_arr_disp_desc_2 := le.arr_disp_desc_2 <> ri.arr_disp_desc_2;
    SELF.Diff_pros_refer_cd := le.pros_refer_cd <> ri.pros_refer_cd;
    SELF.Diff_pros_refer := le.pros_refer <> ri.pros_refer;
    SELF.Diff_pros_assgn_cd := le.pros_assgn_cd <> ri.pros_assgn_cd;
    SELF.Diff_pros_assgn := le.pros_assgn <> ri.pros_assgn;
    SELF.Diff_pros_chg_rej := le.pros_chg_rej <> ri.pros_chg_rej;
    SELF.Diff_pros_off_code := le.pros_off_code <> ri.pros_off_code;
    SELF.Diff_pros_off_desc_1 := le.pros_off_desc_1 <> ri.pros_off_desc_1;
    SELF.Diff_pros_off_desc_2 := le.pros_off_desc_2 <> ri.pros_off_desc_2;
    SELF.Diff_pros_off_type_cd := le.pros_off_type_cd <> ri.pros_off_type_cd;
    SELF.Diff_pros_off_type_desc := le.pros_off_type_desc <> ri.pros_off_type_desc;
    SELF.Diff_pros_off_lev := le.pros_off_lev <> ri.pros_off_lev;
    SELF.Diff_pros_act_filed := le.pros_act_filed <> ri.pros_act_filed;
    SELF.Diff_court_case_number := le.court_case_number <> ri.court_case_number;
    SELF.Diff_court_cd := le.court_cd <> ri.court_cd;
    SELF.Diff_court_desc := le.court_desc <> ri.court_desc;
    SELF.Diff_court_appeal_flag := le.court_appeal_flag <> ri.court_appeal_flag;
    SELF.Diff_court_final_plea := le.court_final_plea <> ri.court_final_plea;
    SELF.Diff_court_off_code := le.court_off_code <> ri.court_off_code;
    SELF.Diff_court_off_desc_1 := le.court_off_desc_1 <> ri.court_off_desc_1;
    SELF.Diff_court_off_desc_2 := le.court_off_desc_2 <> ri.court_off_desc_2;
    SELF.Diff_court_off_type_cd := le.court_off_type_cd <> ri.court_off_type_cd;
    SELF.Diff_court_off_type_desc := le.court_off_type_desc <> ri.court_off_type_desc;
    SELF.Diff_court_off_lev := le.court_off_lev <> ri.court_off_lev;
    SELF.Diff_court_statute := le.court_statute <> ri.court_statute;
    SELF.Diff_court_additional_statutes := le.court_additional_statutes <> ri.court_additional_statutes;
    SELF.Diff_court_statute_desc := le.court_statute_desc <> ri.court_statute_desc;
    SELF.Diff_court_disp_date := le.court_disp_date <> ri.court_disp_date;
    SELF.Diff_court_disp_code := le.court_disp_code <> ri.court_disp_code;
    SELF.Diff_court_disp_desc_1 := le.court_disp_desc_1 <> ri.court_disp_desc_1;
    SELF.Diff_court_disp_desc_2 := le.court_disp_desc_2 <> ri.court_disp_desc_2;
    SELF.Diff_sent_date := le.sent_date <> ri.sent_date;
    SELF.Diff_sent_jail := le.sent_jail <> ri.sent_jail;
    SELF.Diff_sent_susp_time := le.sent_susp_time <> ri.sent_susp_time;
    SELF.Diff_sent_court_cost := le.sent_court_cost <> ri.sent_court_cost;
    SELF.Diff_sent_court_fine := le.sent_court_fine <> ri.sent_court_fine;
    SELF.Diff_sent_susp_court_fine := le.sent_susp_court_fine <> ri.sent_susp_court_fine;
    SELF.Diff_sent_probation := le.sent_probation <> ri.sent_probation;
    SELF.Diff_sent_addl_prov_code := le.sent_addl_prov_code <> ri.sent_addl_prov_code;
    SELF.Diff_sent_addl_prov_desc_1 := le.sent_addl_prov_desc_1 <> ri.sent_addl_prov_desc_1;
    SELF.Diff_sent_addl_prov_desc_2 := le.sent_addl_prov_desc_2 <> ri.sent_addl_prov_desc_2;
    SELF.Diff_sent_consec := le.sent_consec <> ri.sent_consec;
    SELF.Diff_sent_agency_rec_cust_ori := le.sent_agency_rec_cust_ori <> ri.sent_agency_rec_cust_ori;
    SELF.Diff_sent_agency_rec_cust := le.sent_agency_rec_cust <> ri.sent_agency_rec_cust;
    SELF.Diff_appeal_date := le.appeal_date <> ri.appeal_date;
    SELF.Diff_appeal_off_disp := le.appeal_off_disp <> ri.appeal_off_disp;
    SELF.Diff_appeal_final_decision := le.appeal_final_decision <> ri.appeal_final_decision;
    SELF.Val := (STRING)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_offender_key,1,0)+ IF( SELF.Diff_vendor,1,0)+ IF( SELF.Diff_state_origin,1,0)+ IF( SELF.Diff_source_file,1,0)+ IF( SELF.Diff_off_comp,1,0)+ IF( SELF.Diff_off_delete_flag,1,0)+ IF( SELF.Diff_off_date,1,0)+ IF( SELF.Diff_arr_date,1,0)+ IF( SELF.Diff_num_of_counts,1,0)+ IF( SELF.Diff_le_agency_cd,1,0)+ IF( SELF.Diff_le_agency_desc,1,0)+ IF( SELF.Diff_le_agency_case_number,1,0)+ IF( SELF.Diff_traffic_ticket_number,1,0)+ IF( SELF.Diff_traffic_dl_no,1,0)+ IF( SELF.Diff_traffic_dl_st,1,0)+ IF( SELF.Diff_arr_off_code,1,0)+ IF( SELF.Diff_arr_off_desc_1,1,0)+ IF( SELF.Diff_arr_off_desc_2,1,0)+ IF( SELF.Diff_arr_off_type_cd,1,0)+ IF( SELF.Diff_arr_off_type_desc,1,0)+ IF( SELF.Diff_arr_off_lev,1,0)+ IF( SELF.Diff_arr_statute,1,0)+ IF( SELF.Diff_arr_statute_desc,1,0)+ IF( SELF.Diff_arr_disp_date,1,0)+ IF( SELF.Diff_arr_disp_code,1,0)+ IF( SELF.Diff_arr_disp_desc_1,1,0)+ IF( SELF.Diff_arr_disp_desc_2,1,0)+ IF( SELF.Diff_pros_refer_cd,1,0)+ IF( SELF.Diff_pros_refer,1,0)+ IF( SELF.Diff_pros_assgn_cd,1,0)+ IF( SELF.Diff_pros_assgn,1,0)+ IF( SELF.Diff_pros_chg_rej,1,0)+ IF( SELF.Diff_pros_off_code,1,0)+ IF( SELF.Diff_pros_off_desc_1,1,0)+ IF( SELF.Diff_pros_off_desc_2,1,0)+ IF( SELF.Diff_pros_off_type_cd,1,0)+ IF( SELF.Diff_pros_off_type_desc,1,0)+ IF( SELF.Diff_pros_off_lev,1,0)+ IF( SELF.Diff_pros_act_filed,1,0)+ IF( SELF.Diff_court_case_number,1,0)+ IF( SELF.Diff_court_cd,1,0)+ IF( SELF.Diff_court_desc,1,0)+ IF( SELF.Diff_court_appeal_flag,1,0)+ IF( SELF.Diff_court_final_plea,1,0)+ IF( SELF.Diff_court_off_code,1,0)+ IF( SELF.Diff_court_off_desc_1,1,0)+ IF( SELF.Diff_court_off_desc_2,1,0)+ IF( SELF.Diff_court_off_type_cd,1,0)+ IF( SELF.Diff_court_off_type_desc,1,0)+ IF( SELF.Diff_court_off_lev,1,0)+ IF( SELF.Diff_court_statute,1,0)+ IF( SELF.Diff_court_additional_statutes,1,0)+ IF( SELF.Diff_court_statute_desc,1,0)+ IF( SELF.Diff_court_disp_date,1,0)+ IF( SELF.Diff_court_disp_code,1,0)+ IF( SELF.Diff_court_disp_desc_1,1,0)+ IF( SELF.Diff_court_disp_desc_2,1,0)+ IF( SELF.Diff_sent_date,1,0)+ IF( SELF.Diff_sent_jail,1,0)+ IF( SELF.Diff_sent_susp_time,1,0)+ IF( SELF.Diff_sent_court_cost,1,0)+ IF( SELF.Diff_sent_court_fine,1,0)+ IF( SELF.Diff_sent_susp_court_fine,1,0)+ IF( SELF.Diff_sent_probation,1,0)+ IF( SELF.Diff_sent_addl_prov_code,1,0)+ IF( SELF.Diff_sent_addl_prov_desc_1,1,0)+ IF( SELF.Diff_sent_addl_prov_desc_2,1,0)+ IF( SELF.Diff_sent_consec,1,0)+ IF( SELF.Diff_sent_agency_rec_cust_ori,1,0)+ IF( SELF.Diff_sent_agency_rec_cust,1,0)+ IF( SELF.Diff_appeal_date,1,0)+ IF( SELF.Diff_appeal_off_disp,1,0)+ IF( SELF.Diff_appeal_final_decision,1,0);
  END;
// Now need to remove bad pivots from comparison
#uniquename(L)
  %L% := JOIN(in_left,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(R)
  %R% := JOIN(in_right,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(DiffL)
  %DiffL% := JOIN(%L%,%R%,evaluate(left,pivot_exp)=evaluate(right,pivot_exp),%fd%(left,right),hash);
#uniquename(Closest)
  %Closest% := DEDUP(SORT(%DiffL%,Val,Num_Diffs,local),Val,local); // Join will have distributed by pivot_exp
#uniquename(AggRec)
  %AggRec% := RECORD
    Count_Diff_process_date := COUNT(GROUP,%Closest%.Diff_process_date);
    Count_Diff_offender_key := COUNT(GROUP,%Closest%.Diff_offender_key);
    Count_Diff_vendor := COUNT(GROUP,%Closest%.Diff_vendor);
    Count_Diff_state_origin := COUNT(GROUP,%Closest%.Diff_state_origin);
    Count_Diff_source_file := COUNT(GROUP,%Closest%.Diff_source_file);
    Count_Diff_off_comp := COUNT(GROUP,%Closest%.Diff_off_comp);
    Count_Diff_off_delete_flag := COUNT(GROUP,%Closest%.Diff_off_delete_flag);
    Count_Diff_off_date := COUNT(GROUP,%Closest%.Diff_off_date);
    Count_Diff_arr_date := COUNT(GROUP,%Closest%.Diff_arr_date);
    Count_Diff_num_of_counts := COUNT(GROUP,%Closest%.Diff_num_of_counts);
    Count_Diff_le_agency_cd := COUNT(GROUP,%Closest%.Diff_le_agency_cd);
    Count_Diff_le_agency_desc := COUNT(GROUP,%Closest%.Diff_le_agency_desc);
    Count_Diff_le_agency_case_number := COUNT(GROUP,%Closest%.Diff_le_agency_case_number);
    Count_Diff_traffic_ticket_number := COUNT(GROUP,%Closest%.Diff_traffic_ticket_number);
    Count_Diff_traffic_dl_no := COUNT(GROUP,%Closest%.Diff_traffic_dl_no);
    Count_Diff_traffic_dl_st := COUNT(GROUP,%Closest%.Diff_traffic_dl_st);
    Count_Diff_arr_off_code := COUNT(GROUP,%Closest%.Diff_arr_off_code);
    Count_Diff_arr_off_desc_1 := COUNT(GROUP,%Closest%.Diff_arr_off_desc_1);
    Count_Diff_arr_off_desc_2 := COUNT(GROUP,%Closest%.Diff_arr_off_desc_2);
    Count_Diff_arr_off_type_cd := COUNT(GROUP,%Closest%.Diff_arr_off_type_cd);
    Count_Diff_arr_off_type_desc := COUNT(GROUP,%Closest%.Diff_arr_off_type_desc);
    Count_Diff_arr_off_lev := COUNT(GROUP,%Closest%.Diff_arr_off_lev);
    Count_Diff_arr_statute := COUNT(GROUP,%Closest%.Diff_arr_statute);
    Count_Diff_arr_statute_desc := COUNT(GROUP,%Closest%.Diff_arr_statute_desc);
    Count_Diff_arr_disp_date := COUNT(GROUP,%Closest%.Diff_arr_disp_date);
    Count_Diff_arr_disp_code := COUNT(GROUP,%Closest%.Diff_arr_disp_code);
    Count_Diff_arr_disp_desc_1 := COUNT(GROUP,%Closest%.Diff_arr_disp_desc_1);
    Count_Diff_arr_disp_desc_2 := COUNT(GROUP,%Closest%.Diff_arr_disp_desc_2);
    Count_Diff_pros_refer_cd := COUNT(GROUP,%Closest%.Diff_pros_refer_cd);
    Count_Diff_pros_refer := COUNT(GROUP,%Closest%.Diff_pros_refer);
    Count_Diff_pros_assgn_cd := COUNT(GROUP,%Closest%.Diff_pros_assgn_cd);
    Count_Diff_pros_assgn := COUNT(GROUP,%Closest%.Diff_pros_assgn);
    Count_Diff_pros_chg_rej := COUNT(GROUP,%Closest%.Diff_pros_chg_rej);
    Count_Diff_pros_off_code := COUNT(GROUP,%Closest%.Diff_pros_off_code);
    Count_Diff_pros_off_desc_1 := COUNT(GROUP,%Closest%.Diff_pros_off_desc_1);
    Count_Diff_pros_off_desc_2 := COUNT(GROUP,%Closest%.Diff_pros_off_desc_2);
    Count_Diff_pros_off_type_cd := COUNT(GROUP,%Closest%.Diff_pros_off_type_cd);
    Count_Diff_pros_off_type_desc := COUNT(GROUP,%Closest%.Diff_pros_off_type_desc);
    Count_Diff_pros_off_lev := COUNT(GROUP,%Closest%.Diff_pros_off_lev);
    Count_Diff_pros_act_filed := COUNT(GROUP,%Closest%.Diff_pros_act_filed);
    Count_Diff_court_case_number := COUNT(GROUP,%Closest%.Diff_court_case_number);
    Count_Diff_court_cd := COUNT(GROUP,%Closest%.Diff_court_cd);
    Count_Diff_court_desc := COUNT(GROUP,%Closest%.Diff_court_desc);
    Count_Diff_court_appeal_flag := COUNT(GROUP,%Closest%.Diff_court_appeal_flag);
    Count_Diff_court_final_plea := COUNT(GROUP,%Closest%.Diff_court_final_plea);
    Count_Diff_court_off_code := COUNT(GROUP,%Closest%.Diff_court_off_code);
    Count_Diff_court_off_desc_1 := COUNT(GROUP,%Closest%.Diff_court_off_desc_1);
    Count_Diff_court_off_desc_2 := COUNT(GROUP,%Closest%.Diff_court_off_desc_2);
    Count_Diff_court_off_type_cd := COUNT(GROUP,%Closest%.Diff_court_off_type_cd);
    Count_Diff_court_off_type_desc := COUNT(GROUP,%Closest%.Diff_court_off_type_desc);
    Count_Diff_court_off_lev := COUNT(GROUP,%Closest%.Diff_court_off_lev);
    Count_Diff_court_statute := COUNT(GROUP,%Closest%.Diff_court_statute);
    Count_Diff_court_additional_statutes := COUNT(GROUP,%Closest%.Diff_court_additional_statutes);
    Count_Diff_court_statute_desc := COUNT(GROUP,%Closest%.Diff_court_statute_desc);
    Count_Diff_court_disp_date := COUNT(GROUP,%Closest%.Diff_court_disp_date);
    Count_Diff_court_disp_code := COUNT(GROUP,%Closest%.Diff_court_disp_code);
    Count_Diff_court_disp_desc_1 := COUNT(GROUP,%Closest%.Diff_court_disp_desc_1);
    Count_Diff_court_disp_desc_2 := COUNT(GROUP,%Closest%.Diff_court_disp_desc_2);
    Count_Diff_sent_date := COUNT(GROUP,%Closest%.Diff_sent_date);
    Count_Diff_sent_jail := COUNT(GROUP,%Closest%.Diff_sent_jail);
    Count_Diff_sent_susp_time := COUNT(GROUP,%Closest%.Diff_sent_susp_time);
    Count_Diff_sent_court_cost := COUNT(GROUP,%Closest%.Diff_sent_court_cost);
    Count_Diff_sent_court_fine := COUNT(GROUP,%Closest%.Diff_sent_court_fine);
    Count_Diff_sent_susp_court_fine := COUNT(GROUP,%Closest%.Diff_sent_susp_court_fine);
    Count_Diff_sent_probation := COUNT(GROUP,%Closest%.Diff_sent_probation);
    Count_Diff_sent_addl_prov_code := COUNT(GROUP,%Closest%.Diff_sent_addl_prov_code);
    Count_Diff_sent_addl_prov_desc_1 := COUNT(GROUP,%Closest%.Diff_sent_addl_prov_desc_1);
    Count_Diff_sent_addl_prov_desc_2 := COUNT(GROUP,%Closest%.Diff_sent_addl_prov_desc_2);
    Count_Diff_sent_consec := COUNT(GROUP,%Closest%.Diff_sent_consec);
    Count_Diff_sent_agency_rec_cust_ori := COUNT(GROUP,%Closest%.Diff_sent_agency_rec_cust_ori);
    Count_Diff_sent_agency_rec_cust := COUNT(GROUP,%Closest%.Diff_sent_agency_rec_cust);
    Count_Diff_appeal_date := COUNT(GROUP,%Closest%.Diff_appeal_date);
    Count_Diff_appeal_off_disp := COUNT(GROUP,%Closest%.Diff_appeal_off_disp);
    Count_Diff_appeal_final_decision := COUNT(GROUP,%Closest%.Diff_appeal_final_decision);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
end;
