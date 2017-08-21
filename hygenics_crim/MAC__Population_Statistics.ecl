export MAC__Population_Statistics(infile,Ref='',Input_process_date = '',Input_offender_key = '',Input_vendor = '',Input_state_origin = '',Input_source_file = '',Input_off_comp = '',Input_off_delete_flag = '',Input_off_date = '',Input_arr_date = '',Input_num_of_counts = '',Input_le_agency_cd = '',Input_le_agency_desc = '',Input_le_agency_case_number = '',Input_traffic_ticket_number = '',Input_traffic_dl_no = '',Input_traffic_dl_st = '',Input_arr_off_code = '',Input_arr_off_desc_1 = '',Input_arr_off_desc_2 = '',Input_arr_off_type_cd = '',Input_arr_off_type_desc = '',Input_arr_off_lev = '',Input_arr_statute = '',Input_arr_statute_desc = '',Input_arr_disp_date = '',Input_arr_disp_code = '',Input_arr_disp_desc_1 = '',Input_arr_disp_desc_2 = '',Input_pros_refer_cd = '',Input_pros_refer = '',Input_pros_assgn_cd = '',Input_pros_assgn = '',Input_pros_chg_rej = '',Input_pros_off_code = '',Input_pros_off_desc_1 = '',Input_pros_off_desc_2 = '',Input_pros_off_type_cd = '',Input_pros_off_type_desc = '',Input_pros_off_lev = '',Input_pros_act_filed = '',Input_court_case_number = '',Input_court_cd = '',Input_court_desc = '',Input_court_appeal_flag = '',Input_court_final_plea = '',Input_court_off_code = '',Input_court_off_desc_1 = '',Input_court_off_desc_2 = '',Input_court_off_type_cd = '',Input_court_off_type_desc = '',Input_court_off_lev = '',Input_court_statute = '',Input_court_additional_statutes = '',Input_court_statute_desc = '',Input_court_disp_date = '',Input_court_disp_code = '',Input_court_disp_desc_1 = '',Input_court_disp_desc_2 = '',Input_sent_date = '',Input_sent_jail = '',Input_sent_susp_time = '',Input_sent_court_cost = '',Input_sent_court_fine = '',Input_sent_susp_court_fine = '',Input_sent_probation = '',Input_sent_addl_prov_code = '',Input_sent_addl_prov_desc_1 = '',Input_sent_addl_prov_desc_2 = '',Input_sent_consec = '',Input_sent_agency_rec_cust_ori = '',Input_sent_agency_rec_cust = '',Input_appeal_date = '',Input_appeal_off_disp = '',Input_appeal_final_decision = '',OutFile) := MACRO
  #uniquename(of)
  %of% := record
    string512 fields;
  end;
  #uniquename(ot)
  %of% %ot%(infile le) := transform
    self.fields :=
    #IF( #TEXT(Input_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_process_date = (typeof(le.Input_process_date))'','',':process_date')
    #END
+
    #IF( #TEXT(Input_offender_key)='' )
      '' 
    #ELSE
        IF( le.Input_offender_key = (typeof(le.Input_offender_key))'','',':offender_key')
    #END
+
    #IF( #TEXT(Input_vendor)='' )
      '' 
    #ELSE
        IF( le.Input_vendor = (typeof(le.Input_vendor))'','',':vendor')
    #END
+
    #IF( #TEXT(Input_state_origin)='' )
      '' 
    #ELSE
        IF( le.Input_state_origin = (typeof(le.Input_state_origin))'','',':state_origin')
    #END
+
    #IF( #TEXT(Input_source_file)='' )
      '' 
    #ELSE
        IF( le.Input_source_file = (typeof(le.Input_source_file))'','',':source_file')
    #END
+
    #IF( #TEXT(Input_off_comp)='' )
      '' 
    #ELSE
        IF( le.Input_off_comp = (typeof(le.Input_off_comp))'','',':off_comp')
    #END
+
    #IF( #TEXT(Input_off_delete_flag)='' )
      '' 
    #ELSE
        IF( le.Input_off_delete_flag = (typeof(le.Input_off_delete_flag))'','',':off_delete_flag')
    #END
+
    #IF( #TEXT(Input_off_date)='' )
      '' 
    #ELSE
        IF( le.Input_off_date = (typeof(le.Input_off_date))'','',':off_date')
    #END
+
    #IF( #TEXT(Input_arr_date)='' )
      '' 
    #ELSE
        IF( le.Input_arr_date = (typeof(le.Input_arr_date))'','',':arr_date')
    #END
+
    #IF( #TEXT(Input_num_of_counts)='' )
      '' 
    #ELSE
        IF( le.Input_num_of_counts = (typeof(le.Input_num_of_counts))'','',':num_of_counts')
    #END
+
    #IF( #TEXT(Input_le_agency_cd)='' )
      '' 
    #ELSE
        IF( le.Input_le_agency_cd = (typeof(le.Input_le_agency_cd))'','',':le_agency_cd')
    #END
+
    #IF( #TEXT(Input_le_agency_desc)='' )
      '' 
    #ELSE
        IF( le.Input_le_agency_desc = (typeof(le.Input_le_agency_desc))'','',':le_agency_desc')
    #END
+
    #IF( #TEXT(Input_le_agency_case_number)='' )
      '' 
    #ELSE
        IF( le.Input_le_agency_case_number = (typeof(le.Input_le_agency_case_number))'','',':le_agency_case_number')
    #END
+
    #IF( #TEXT(Input_traffic_ticket_number)='' )
      '' 
    #ELSE
        IF( le.Input_traffic_ticket_number = (typeof(le.Input_traffic_ticket_number))'','',':traffic_ticket_number')
    #END
+
    #IF( #TEXT(Input_traffic_dl_no)='' )
      '' 
    #ELSE
        IF( le.Input_traffic_dl_no = (typeof(le.Input_traffic_dl_no))'','',':traffic_dl_no')
    #END
+
    #IF( #TEXT(Input_traffic_dl_st)='' )
      '' 
    #ELSE
        IF( le.Input_traffic_dl_st = (typeof(le.Input_traffic_dl_st))'','',':traffic_dl_st')
    #END
+
    #IF( #TEXT(Input_arr_off_code)='' )
      '' 
    #ELSE
        IF( le.Input_arr_off_code = (typeof(le.Input_arr_off_code))'','',':arr_off_code')
    #END
+
    #IF( #TEXT(Input_arr_off_desc_1)='' )
      '' 
    #ELSE
        IF( le.Input_arr_off_desc_1 = (typeof(le.Input_arr_off_desc_1))'','',':arr_off_desc_1')
    #END
+
    #IF( #TEXT(Input_arr_off_desc_2)='' )
      '' 
    #ELSE
        IF( le.Input_arr_off_desc_2 = (typeof(le.Input_arr_off_desc_2))'','',':arr_off_desc_2')
    #END
+
    #IF( #TEXT(Input_arr_off_type_cd)='' )
      '' 
    #ELSE
        IF( le.Input_arr_off_type_cd = (typeof(le.Input_arr_off_type_cd))'','',':arr_off_type_cd')
    #END
+
    #IF( #TEXT(Input_arr_off_type_desc)='' )
      '' 
    #ELSE
        IF( le.Input_arr_off_type_desc = (typeof(le.Input_arr_off_type_desc))'','',':arr_off_type_desc')
    #END
+
    #IF( #TEXT(Input_arr_off_lev)='' )
      '' 
    #ELSE
        IF( le.Input_arr_off_lev = (typeof(le.Input_arr_off_lev))'','',':arr_off_lev')
    #END
+
    #IF( #TEXT(Input_arr_statute)='' )
      '' 
    #ELSE
        IF( le.Input_arr_statute = (typeof(le.Input_arr_statute))'','',':arr_statute')
    #END
+
    #IF( #TEXT(Input_arr_statute_desc)='' )
      '' 
    #ELSE
        IF( le.Input_arr_statute_desc = (typeof(le.Input_arr_statute_desc))'','',':arr_statute_desc')
    #END
+
    #IF( #TEXT(Input_arr_disp_date)='' )
      '' 
    #ELSE
        IF( le.Input_arr_disp_date = (typeof(le.Input_arr_disp_date))'','',':arr_disp_date')
    #END
+
    #IF( #TEXT(Input_arr_disp_code)='' )
      '' 
    #ELSE
        IF( le.Input_arr_disp_code = (typeof(le.Input_arr_disp_code))'','',':arr_disp_code')
    #END
+
    #IF( #TEXT(Input_arr_disp_desc_1)='' )
      '' 
    #ELSE
        IF( le.Input_arr_disp_desc_1 = (typeof(le.Input_arr_disp_desc_1))'','',':arr_disp_desc_1')
    #END
+
    #IF( #TEXT(Input_arr_disp_desc_2)='' )
      '' 
    #ELSE
        IF( le.Input_arr_disp_desc_2 = (typeof(le.Input_arr_disp_desc_2))'','',':arr_disp_desc_2')
    #END
+
    #IF( #TEXT(Input_pros_refer_cd)='' )
      '' 
    #ELSE
        IF( le.Input_pros_refer_cd = (typeof(le.Input_pros_refer_cd))'','',':pros_refer_cd')
    #END
+
    #IF( #TEXT(Input_pros_refer)='' )
      '' 
    #ELSE
        IF( le.Input_pros_refer = (typeof(le.Input_pros_refer))'','',':pros_refer')
    #END
+
    #IF( #TEXT(Input_pros_assgn_cd)='' )
      '' 
    #ELSE
        IF( le.Input_pros_assgn_cd = (typeof(le.Input_pros_assgn_cd))'','',':pros_assgn_cd')
    #END
+
    #IF( #TEXT(Input_pros_assgn)='' )
      '' 
    #ELSE
        IF( le.Input_pros_assgn = (typeof(le.Input_pros_assgn))'','',':pros_assgn')
    #END
+
    #IF( #TEXT(Input_pros_chg_rej)='' )
      '' 
    #ELSE
        IF( le.Input_pros_chg_rej = (typeof(le.Input_pros_chg_rej))'','',':pros_chg_rej')
    #END
+
    #IF( #TEXT(Input_pros_off_code)='' )
      '' 
    #ELSE
        IF( le.Input_pros_off_code = (typeof(le.Input_pros_off_code))'','',':pros_off_code')
    #END
+
    #IF( #TEXT(Input_pros_off_desc_1)='' )
      '' 
    #ELSE
        IF( le.Input_pros_off_desc_1 = (typeof(le.Input_pros_off_desc_1))'','',':pros_off_desc_1')
    #END
+
    #IF( #TEXT(Input_pros_off_desc_2)='' )
      '' 
    #ELSE
        IF( le.Input_pros_off_desc_2 = (typeof(le.Input_pros_off_desc_2))'','',':pros_off_desc_2')
    #END
+
    #IF( #TEXT(Input_pros_off_type_cd)='' )
      '' 
    #ELSE
        IF( le.Input_pros_off_type_cd = (typeof(le.Input_pros_off_type_cd))'','',':pros_off_type_cd')
    #END
+
    #IF( #TEXT(Input_pros_off_type_desc)='' )
      '' 
    #ELSE
        IF( le.Input_pros_off_type_desc = (typeof(le.Input_pros_off_type_desc))'','',':pros_off_type_desc')
    #END
+
    #IF( #TEXT(Input_pros_off_lev)='' )
      '' 
    #ELSE
        IF( le.Input_pros_off_lev = (typeof(le.Input_pros_off_lev))'','',':pros_off_lev')
    #END
+
    #IF( #TEXT(Input_pros_act_filed)='' )
      '' 
    #ELSE
        IF( le.Input_pros_act_filed = (typeof(le.Input_pros_act_filed))'','',':pros_act_filed')
    #END
+
    #IF( #TEXT(Input_court_case_number)='' )
      '' 
    #ELSE
        IF( le.Input_court_case_number = (typeof(le.Input_court_case_number))'','',':court_case_number')
    #END
+
    #IF( #TEXT(Input_court_cd)='' )
      '' 
    #ELSE
        IF( le.Input_court_cd = (typeof(le.Input_court_cd))'','',':court_cd')
    #END
+
    #IF( #TEXT(Input_court_desc)='' )
      '' 
    #ELSE
        IF( le.Input_court_desc = (typeof(le.Input_court_desc))'','',':court_desc')
    #END
+
    #IF( #TEXT(Input_court_appeal_flag)='' )
      '' 
    #ELSE
        IF( le.Input_court_appeal_flag = (typeof(le.Input_court_appeal_flag))'','',':court_appeal_flag')
    #END
+
    #IF( #TEXT(Input_court_final_plea)='' )
      '' 
    #ELSE
        IF( le.Input_court_final_plea = (typeof(le.Input_court_final_plea))'','',':court_final_plea')
    #END
+
    #IF( #TEXT(Input_court_off_code)='' )
      '' 
    #ELSE
        IF( le.Input_court_off_code = (typeof(le.Input_court_off_code))'','',':court_off_code')
    #END
+
    #IF( #TEXT(Input_court_off_desc_1)='' )
      '' 
    #ELSE
        IF( le.Input_court_off_desc_1 = (typeof(le.Input_court_off_desc_1))'','',':court_off_desc_1')
    #END
+
    #IF( #TEXT(Input_court_off_desc_2)='' )
      '' 
    #ELSE
        IF( le.Input_court_off_desc_2 = (typeof(le.Input_court_off_desc_2))'','',':court_off_desc_2')
    #END
+
    #IF( #TEXT(Input_court_off_type_cd)='' )
      '' 
    #ELSE
        IF( le.Input_court_off_type_cd = (typeof(le.Input_court_off_type_cd))'','',':court_off_type_cd')
    #END
+
    #IF( #TEXT(Input_court_off_type_desc)='' )
      '' 
    #ELSE
        IF( le.Input_court_off_type_desc = (typeof(le.Input_court_off_type_desc))'','',':court_off_type_desc')
    #END
+
    #IF( #TEXT(Input_court_off_lev)='' )
      '' 
    #ELSE
        IF( le.Input_court_off_lev = (typeof(le.Input_court_off_lev))'','',':court_off_lev')
    #END
+
    #IF( #TEXT(Input_court_statute)='' )
      '' 
    #ELSE
        IF( le.Input_court_statute = (typeof(le.Input_court_statute))'','',':court_statute')
    #END
+
    #IF( #TEXT(Input_court_additional_statutes)='' )
      '' 
    #ELSE
        IF( le.Input_court_additional_statutes = (typeof(le.Input_court_additional_statutes))'','',':court_additional_statutes')
    #END
+
    #IF( #TEXT(Input_court_statute_desc)='' )
      '' 
    #ELSE
        IF( le.Input_court_statute_desc = (typeof(le.Input_court_statute_desc))'','',':court_statute_desc')
    #END
+
    #IF( #TEXT(Input_court_disp_date)='' )
      '' 
    #ELSE
        IF( le.Input_court_disp_date = (typeof(le.Input_court_disp_date))'','',':court_disp_date')
    #END
+
    #IF( #TEXT(Input_court_disp_code)='' )
      '' 
    #ELSE
        IF( le.Input_court_disp_code = (typeof(le.Input_court_disp_code))'','',':court_disp_code')
    #END
+
    #IF( #TEXT(Input_court_disp_desc_1)='' )
      '' 
    #ELSE
        IF( le.Input_court_disp_desc_1 = (typeof(le.Input_court_disp_desc_1))'','',':court_disp_desc_1')
    #END
+
    #IF( #TEXT(Input_court_disp_desc_2)='' )
      '' 
    #ELSE
        IF( le.Input_court_disp_desc_2 = (typeof(le.Input_court_disp_desc_2))'','',':court_disp_desc_2')
    #END
+
    #IF( #TEXT(Input_sent_date)='' )
      '' 
    #ELSE
        IF( le.Input_sent_date = (typeof(le.Input_sent_date))'','',':sent_date')
    #END
+
    #IF( #TEXT(Input_sent_jail)='' )
      '' 
    #ELSE
        IF( le.Input_sent_jail = (typeof(le.Input_sent_jail))'','',':sent_jail')
    #END
+
    #IF( #TEXT(Input_sent_susp_time)='' )
      '' 
    #ELSE
        IF( le.Input_sent_susp_time = (typeof(le.Input_sent_susp_time))'','',':sent_susp_time')
    #END
+
    #IF( #TEXT(Input_sent_court_cost)='' )
      '' 
    #ELSE
        IF( le.Input_sent_court_cost = (typeof(le.Input_sent_court_cost))'','',':sent_court_cost')
    #END
+
    #IF( #TEXT(Input_sent_court_fine)='' )
      '' 
    #ELSE
        IF( le.Input_sent_court_fine = (typeof(le.Input_sent_court_fine))'','',':sent_court_fine')
    #END
+
    #IF( #TEXT(Input_sent_susp_court_fine)='' )
      '' 
    #ELSE
        IF( le.Input_sent_susp_court_fine = (typeof(le.Input_sent_susp_court_fine))'','',':sent_susp_court_fine')
    #END
+
    #IF( #TEXT(Input_sent_probation)='' )
      '' 
    #ELSE
        IF( le.Input_sent_probation = (typeof(le.Input_sent_probation))'','',':sent_probation')
    #END
+
    #IF( #TEXT(Input_sent_addl_prov_code)='' )
      '' 
    #ELSE
        IF( le.Input_sent_addl_prov_code = (typeof(le.Input_sent_addl_prov_code))'','',':sent_addl_prov_code')
    #END
+
    #IF( #TEXT(Input_sent_addl_prov_desc_1)='' )
      '' 
    #ELSE
        IF( le.Input_sent_addl_prov_desc_1 = (typeof(le.Input_sent_addl_prov_desc_1))'','',':sent_addl_prov_desc_1')
    #END
+
    #IF( #TEXT(Input_sent_addl_prov_desc_2)='' )
      '' 
    #ELSE
        IF( le.Input_sent_addl_prov_desc_2 = (typeof(le.Input_sent_addl_prov_desc_2))'','',':sent_addl_prov_desc_2')
    #END
+
    #IF( #TEXT(Input_sent_consec)='' )
      '' 
    #ELSE
        IF( le.Input_sent_consec = (typeof(le.Input_sent_consec))'','',':sent_consec')
    #END
+
    #IF( #TEXT(Input_sent_agency_rec_cust_ori)='' )
      '' 
    #ELSE
        IF( le.Input_sent_agency_rec_cust_ori = (typeof(le.Input_sent_agency_rec_cust_ori))'','',':sent_agency_rec_cust_ori')
    #END
+
    #IF( #TEXT(Input_sent_agency_rec_cust)='' )
      '' 
    #ELSE
        IF( le.Input_sent_agency_rec_cust = (typeof(le.Input_sent_agency_rec_cust))'','',':sent_agency_rec_cust')
    #END
+
    #IF( #TEXT(Input_appeal_date)='' )
      '' 
    #ELSE
        IF( le.Input_appeal_date = (typeof(le.Input_appeal_date))'','',':appeal_date')
    #END
+
    #IF( #TEXT(Input_appeal_off_disp)='' )
      '' 
    #ELSE
        IF( le.Input_appeal_off_disp = (typeof(le.Input_appeal_off_disp))'','',':appeal_off_disp')
    #END
+
    #IF( #TEXT(Input_appeal_final_decision)='' )
      '' 
    #ELSE
        IF( le.Input_appeal_final_decision = (typeof(le.Input_appeal_final_decision))'','',':appeal_final_decision')
    #END
;
  end;
  #uniquename(op)
  %op% := project(infile,%ot%(left));
  #uniquename(ort)
  %ort% := record
    %op%.fields;
    unsigned cnt := count(group);
  end;
  outfile := topn( table( %op%, %ort%, fields, few ), 1000, -cnt );
ENDMACRO;

