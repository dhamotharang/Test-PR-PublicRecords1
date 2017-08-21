
EXPORT watchdog__layout_best := RECORD
   unsigned integer6 did;
   qstring10 phone;
   qstring9 ssn;
   integer4 dob;
   qstring5 title;
   qstring20 fname;
   qstring20 mname;
   qstring20 lname;
   qstring5 name_suffix;
   qstring10 prim_range;
   string2 predir;
   qstring28 prim_name;
   qstring4 suffix;
   string2 postdir;
   qstring10 unit_desig;
   qstring8 sec_range;
   qstring25 city_name;
   string2 st;
   qstring5 zip;
   qstring4 zip4;
   unsigned integer3 addr_dt_last_seen;
   qstring8 dod;
   qstring17 prpty_deed_id;
   qstring22 vehicle_vehnum;
   qstring22 bkrupt_crtcode_caseno;
   integer4 main_count;
   integer4 search_count;
   qstring15 dl_number;
   qstring12 bdid;
   integer4 run_date;
   integer4 total_records;
  END;

export layout_compid_clean := RECORD
  unsigned integer6 did;
  integer8 did_score;
  RECORD
   unsigned integer6 rid;
   string4 rec_last_updt_yymm_date;
   string9 rec_soundex_key;
   string8 rec_source_matrix_name;
   string8 rec_source_matrix_lic;
   string8 rec_source_matrix_ssn;
   string8 rec_source_matrix_dob;
   string8 rec_source_matrix_addr;
   string8 rec_source_matrix_gender;
   string28 drvr_last_name;
   string20 drvr_first_name;
   string15 drvr_mid_name;
   string3 drvr_suf_name;
   string1 drvr_sex_code;
   string6 drvr_birth_ymd_date;
   string9 drvr_social_security_num;
   string1 drvr_curr_addr_code;
   string5 drvr_curr_zip_num;
   string35 drvr_curr_addr;
   string20 drvr_curr_city_name;
   string2 drvr_curr_state_code;
   string4 drvr_curr_zip_ext_num;
   string1 drvr_deceased_flag;
   string4 drvr_deceased_yymm_date;
   string11 drvr_curr_apt_num;
   string20 drvr_lic_num;
   string6 drvr_lic_expire_ymd_date;
   string6 drvr_lic_issue_ymd_date;
   string10 drvr_lic_type_code;
   string15 drvr_lic_restrict_desc;
   string1 drvr_commrcl_lic_ind;
   string2 drvr_lic_state_code;
   string4 drvr_prior_addr_yymm_date1;
   string1 drvr_prior_addr_source_ind1;
   string1 drvr_prior_addr_code1;
   string5 drvr_prior_zip_num1;
   string35 drvr_prior_addr1;
   string20 drvr_prior_city_name1;
   string2 drvr_prior_state_code1;
   string4 drvr_prior_zip_ext_num1;
   string11 drvr_prior_apt_num1;
   string1 drvr_prior_ncoa_flag1;
   string4 drvr_prior_ncoa_yymm_date1;
   string4 drvr_prior_addr_yymm_date2;
   string1 drvr_prior_addr_source_ind2;
   string1 drvr_prior_addr_code2;
   string5 drvr_prior_zip_num2;
   string35 drvr_prior_addr2;
   string20 drvr_prior_city_name2;
   string2 drvr_prior_state_code2;
   string4 drvr_prior_zip_ext_num2;
   string11 drvr_prior_apt_num2;
   string1 drvr_prior_ncoa_flag2;
   string4 drvr_prior_ncoa_yymm_date2;
   string4 drvr_prior_addr_yymm_date3;
   string1 drvr_prior_addr_source_ind3;
   string1 drvr_prior_addr_code3;
   string5 drvr_prior_zip_num3;
   string35 drvr_prior_addr3;
   string20 drvr_prior_city_name3;
   string2 drvr_prior_state_code3;
   string4 drvr_prior_zip_ext_num3;
   string11 drvr_prior_apt_num3;
   string1 drvr_prior_ncoa_flag3;
   string4 drvr_prior_ncoa_yymm_date3;
   string6 drvr_load_date;
   string1 drvr_load_source;
   string1 drvr_lic_permit_flag;
   string20 drvr_suppl_lic_data;
   string8 drvr_srce_cnfrm_dte_name1;
   string8 drvr_srce_cnfrm_dte_ssn1;
   string8 drvr_srce_cnfrm_dte_addr1;
   string8 drvr_srce_cnfrm_dte_lic1;
   string8 drvr_srce_cnfrm_dte_dob1;
   string8 drvr_srce_cnfrm_dte_sex1;
   string8 drvr_srce_cnfrm_dte_name2;
   string8 drvr_srce_cnfrm_dte_ssn2;
   string8 drvr_srce_cnfrm_dte_addr2;
   string8 drvr_srce_cnfrm_dte_lic2;
   string8 drvr_srce_cnfrm_dte_dob2;
   string8 drvr_srce_cnfrm_dte_sex2;
   string8 drvr_srce_cnfrm_dte_name3;
   string8 drvr_srce_cnfrm_dte_ssn3;
   string8 drvr_srce_cnfrm_dte_addr3;
   string8 drvr_srce_cnfrm_dte_lic3;
   string8 drvr_srce_cnfrm_dte_dob3;
   string8 drvr_srce_cnfrm_dte_sex3;
   string8 drvr_srce_cnfrm_dte_name4;
   string8 drvr_srce_cnfrm_dte_ssn4;
   string8 drvr_srce_cnfrm_dte_addr4;
   string8 drvr_srce_cnfrm_dte_lic4;
   string8 drvr_srce_cnfrm_dte_dob4;
   string8 drvr_srce_cnfrm_dte_sex4;
   string8 drvr_srce_cnfrm_dte_name5;
   string8 drvr_srce_cnfrm_dte_ssn5;
   string8 drvr_srce_cnfrm_dte_addr5;
   string8 drvr_srce_cnfrm_dte_lic5;
   string8 drvr_srce_cnfrm_dte_dob5;
   string8 drvr_srce_cnfrm_dte_sex5;
   string8 drvr_srce_cnfrm_dte_name6;
   string8 drvr_srce_cnfrm_dte_ssn6;
   string8 drvr_srce_cnfrm_dte_addr6;
   string8 drvr_srce_cnfrm_dte_lic6;
   string8 drvr_srce_cnfrm_dte_dob6;
   string8 drvr_srce_cnfrm_dte_sex6;
   string8 drvr_srce_cnfrm_dte_name7;
   string8 drvr_srce_cnfrm_dte_ssn7;
   string8 drvr_srce_cnfrm_dte_addr7;
   string8 drvr_srce_cnfrm_dte_lic7;
   string8 drvr_srce_cnfrm_dte_dob7;
   string8 drvr_srce_cnfrm_dte_sex7;
   string8 drvr_srce_cnfrm_dte_name8;
   string8 drvr_srce_cnfrm_dte_ssn8;
   string8 drvr_srce_cnfrm_dte_addr8;
   string8 drvr_srce_cnfrm_dte_lic8;
   string8 drvr_srce_cnfrm_dte_dob8;
   string8 drvr_srce_cnfrm_dte_sex8;
   string1 lf;
  END compid;
  watchdog__layout_best watchdog;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string25 v_city_name;
  string2 st;
  string5 zip5;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dpbc;
  string1 chk_digit;
  string2 rec_type;
  string2 ace_fips_st;
  string3 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 suffix;
  string3 score;
  string9 drvr_social_security_num;
  string8 dob;
  string10 ind;
  qstring1 rec_tp;
  qstring1 valid_ssn;
  qstring1 eq_best_dob;
  qstring1 neq_best_dob;
  qstring1 ln_blank_dob;
  qstring1 cp_blank_dob;
  qstring1 eq_best_ssn;
  qstring1 neq_best_ssn;
  qstring1 ln_blank_ssn;
  qstring1 cp_blank_ssn;
  qstring1 eq_best_name;
  qstring1 neq_best_name;
  qstring1 ln_blank_name;
  qstring1 cp_blank_name;
  qstring1 eq_best_addr;
  qstring1 neq_best_addr;
  qstring1 ln_blank_addr;
  qstring1 cp_blank_addr;
  qstring1 eq_best_dl;
  qstring1 neq_best_dl;
  qstring1 ln_blank_dl;
  qstring1 cp_blank_dl;
 END;
