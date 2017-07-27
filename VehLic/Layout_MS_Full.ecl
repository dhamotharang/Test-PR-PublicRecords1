export Layout_MS_Full :=
record
    string8                       process_date;
    string1                       rec_stat;
    string7                       title_num;
    string1                       master_rec_stat;
    string8                       trap_ref;
    string20                      vin;
    string9                       title_group1;
    string1                       veh_type;
    string1                       title_check_digit;
    string2                       title_trc_digit;
    string2                       veh_year;
    string2                       num_cylinders;
    string2                       num_passengers;
    string6                       purchase_date;
    string16                      title_group1_new;
    string9                       title_group2;
    string3                       title_own_county;
    string6                       title_issue_date;
    string2                       lst_title_trans_type;
    string6                       lst_title_tran_date;
    string17                      title_group2_new;
    string9                       title_group3;
    string1                       title_stat;
    string1                       use_tx_code;
    string3                       veh_gross_weight;
    string6                       ln_1_date;
    string6                       ln_2_date;
    string17                      title_group3_new;
    string1                       num_lein;
    string6                       des_agent_num;
    string11                      des_agent_num_new;
    string6                       title_micro_num;
    string11                      title_micro_num_new;
    string1                       type_own_code;
    string1                       lessee_reg_code;
    string4                       veh_make;
    string3                       veh_mod;
    string3                       veh_bod_style;
    string1                       veh_color1;
    string1                       veh_color2;
    string1                       title_type;
    string1                       fuel_type;
    string1                       fuel_per_type;
    string1                       n_u_code;
    string30                      title_own_name;
    string30                      title_own_street;
    string15                      title_own_city;
    string2                       title_own_st;
    string5                       title_own_zip;
    string9                       title_own_zip_new;
    string6                       ln_1_num;
    string11                      ln_1_num_new;
    string6                       ln_2_num;
    string11                      ln_2_num_new;
    string5                       odometer;
    string8                       odometer_new;
    string3                       dept_or_comm;
    string3                       deptst_or_city;
    string10                      tag_num;
    string1                       tag_stat;
    string2                       tag_type;
    string1                       st_county_iss_code;
    string6                       reg_group1;
    string2                       tag_exp_month;
    string2                       tag_exp_year;
    string6                       tag_issue_date;
    string10                      reg_group1_new;
    string8                       reg_group2;
    string1                       item_issue_code;
    string3                       tax_dist;
    string2                       lst_reg_tran_typ;
    string6                       lst_reg_tran_date;
    string3                       cnty_off;
    string15                      reg_group2_new;
    string3                       reg_group3_st;
    string1                       prev_tag_stat;
    string2                       prev_tag_exp_mo;
    string2                       prev_tag_exp_year;
    string5                       reg_group3_st_new;
    string10                      prev_tag_number;
    string2                       prev_tag_typ;
    string7                       prop_cod;
    string30                      reg_name;
    string30                      reg_street;
    string15                      reg_city;
    string2                       reg_state;
    string5                       reg_zip;
    string9                       reg_zip_new;
    string1                       advl_ex_cd;
    string8                       decal_num;
    string1                       bp_irp_flag;
    string3                       last_cics_upd;
    string5                       last_cics_upd_new;
    string15                      oldvin;
    string1                       credit_stat;
    string1                       value_cod;
    string2                       prev_tag_state;
    string4                       msrp_val;
    string6                       msrp_val_new;
    string3                       credit_cnty;
    string1                       indiv_fleet;
    string2                       veh_year_century;
    string2                       purchase_date_century;
    string2                       title_iss_date_century;
    string2                       last_title_tran_date_century;
    string2                       ln_1_dat_cen;
    string2                       ln_2_dat_cen;
    string2                       tag_exp_cen;
    string2                       tag_iss_dat_cen;
    string2                       last_reg_tran_dat_cen;
    string2                       prev_tag_exp_cen;
    string2                       last_cics_upd_cen;
    string1                       w_addr_phys_loc;
    string2                       w_prev_tax_code;
    string26                      filler;
    string10                      title_prim_range;
    string2                       title_predir;
    string28                      title_prim_name;
    string4                       title_addr_suffix;
    string2                       title_postdir;
    string10                      title_unit_desig;
    string8                       title_sec_range;
    string25                      title_p_city_name;
    string25                      title_v_city_name;
    string2                       title_st;
    string5                       title_zip;
    string4                       title_zip4;
    string4                       title_cart;
    string1                       title_cr_sort_sz;
    string4                       title_lot;
    string1                       title_lot_order;
    string2                       title_dpbc;
    string1                       title_chk_digit;
    string2                       title_rec_type;
    string2                       title_fips_st;
    string3                       title_county;
    string10                      title_geo_lat;
    string11                      title_geo_long;
    string4                       title_msa;
    string7                       title_geo_blk;
    string1                       title_geo_match;
    string4                       title_err_stat;
    string10                      reg_prim_range;
    string2                       reg_predir;
    string28                      reg_prim_name;
    string4                       reg_addr_suffix;
    string2                       reg_postdir;
    string10                      reg_unit_desig;
    string8                       reg_sec_range;
    string25                      reg_p_city_name;
    string25                      reg_v_city_name;
    string2                       reg_st;
    string5                       reg_zip5;
    string4                       reg_zip4;
    string4                       reg_cart;
    string1                       reg_cr_sort_sz;
    string4                       reg_lot;
    string1                       reg_lot_order;
    string2                       reg_dpbc;
    string1                       reg_chk_digit;
    string2                       reg_rec_type;
    string2                       reg_fips_st;
    string3                       reg_county;
    string10                      reg_geo_lat;
    string11                      reg_geo_long;
    string4                       reg_msa;
    string7                       reg_geo_blk;
    string1                       reg_geo_match;
    string4                       reg_err_stat;
    string1                       title_own_name_p1_bus;
    string30                      title_own_name_p1;
    string1                       title_own_name_co_bus;
    string30                      title_own_name_co;
    string1                       reg_name_p1_bus;
    string30                      reg_name_p1;
    string1                       reg_name_co_bus;
    string30                      reg_name_co;
    string5                       title_title1;
    string20                      title_fname1;
    string20                      title_mname1;
    string20                      title_lname1;
    string5                       title_suffix1;
    string50                      title_company1;
    string5                       title_title2;
    string20                      title_fname2;
    string20                      title_mname2;
    string20                      title_lname2;
    string5                       title_suffix2;
    string50                      title_company2;
    string5                       reg_title1;
    string20                      reg_fname1;
    string20                      reg_mname1;
    string20                      reg_lname1;
    string5                       reg_suffix1;
    string50                      reg_company1;
    string5                       reg_title2;
    string20                      reg_fname2;
    string20                      reg_mname2;
    string20                      reg_lname2;
    string5                       reg_suffix2;
    string50                      reg_company2;
end;