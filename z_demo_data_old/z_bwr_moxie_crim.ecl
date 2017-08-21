import lib_fileservices,crim_common;

// court_crim

court_crim_activity := record
	string8 process_date;
  string60 offender_key;
  string2 vendor;
  string2 state_origin;
  string20 source_file;
  string4 off_comp;
  string35 case_number;
  string2 event_type;
  string9 event_sort_key;
  string8 event_date;
  string10 event_location_code;
  string50 event_location_desc;
  string8 event_desc_code;
  string50 event_desc_1;
  string50 event_desc_2;

end;

ds1 := dataset([{'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'},
{'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'},
{'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'},
{'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'},
{'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'},
{'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'}],court_crim_activity);

codid_new := record
	string8 process_date;
  string60 offender_key;
  string2 vendor;
  string2 state_origin;
  string1 data_type;
  string20 source_file;
  string35 case_number;
  string40 case_court;
  string50 case_name;
  string5 case_type;
  string25 case_type_desc;
  string8 case_filing_dt;
  string56 pty_nm;
  string1 pty_nm_fmt;
  string20 orig_lname;
  string20 orig_fname;
  string20 orig_mname;
  string10 orig_name_suffix;
  string1 pty_typ;
  string1 nitro_flag;
  string9 orig_ssn;
  string10 dle_num;
  string9 fbi_num;
  string10 doc_num;
  string10 ins_num;
  string15 id_num;
  string25 dl_num;
  string2 dl_state;
  string2 citizenship;
  string8 dob;
  string8 dob_alias;
  string2 place_of_birth;
  string25 street_address_1;
  string25 street_address_2;
  string25 street_address_3;
  string10 street_address_4;
  string10 street_address_5;
  string5 race;
  string30 race_desc;
  string1 sex;
  string5 hair_color;
  string25 hair_color_desc;
  string5 eye_color;
  string25 eye_color_desc;
  string5 skin_color;
  string25 skin_color_desc;
  string3 height;
  string3 weight;
  string10 party_status;
string60 party_status_desc;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 suffix;
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
  string3 ace_fips_county;
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
  string5 name_suffix;
  string3 cleaning_score;
  string9 ssn;
  string12 did;
  string12 pgid;
end;

ds2 := dataset([{'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'},
{'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'},
{'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'},
{'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'},
{'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'},
{'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'}
],codid_new);


co_new := record
	string8 process_date;
  string60 offender_key;
  string2 vendor;
  string2 state_origin;
  string20 source_file;
  string4 off_comp;
  string1 off_delete_flag;
  string8 off_date;
  string8 arr_date;
  string3 num_of_counts;
  string10 le_agency_cd;
  string50 le_agency_desc;
  string35 le_agency_case_number;
  string35 traffic_ticket_number;
  string25 traffic_dl_no;
  string2 traffic_dl_st;
  string20 arr_off_code;
  string75 arr_off_desc_1;
  string50 arr_off_desc_2;
  string5 arr_off_type_cd;
  string30 arr_off_type_desc;
  string5 arr_off_lev;
  string20 arr_statute;
  string70 arr_statute_desc;
  string8 arr_disp_date;
  string5 arr_disp_code;
  string30 arr_disp_desc_1;
  string30 arr_disp_desc_2;
  string10 pros_refer_cd;
  string50 pros_refer;
  string10 pros_assgn_cd;
  string50 pros_assgn;
  string1 pros_chg_rej;
  string20 pros_off_code;
  string75 pros_off_desc_1;
  string50 pros_off_desc_2;
  string5 pros_off_type_cd;
  string30 pros_off_type_desc;
  string5 pros_off_lev;
  string30 pros_act_filed;
  string35 court_case_number;
  string10 court_cd;
  string40 court_desc;
  string1 court_appeal_flag;
  string30 court_final_plea;
  string20 court_off_code;
  string75 court_off_desc_1;
  string50 court_off_desc_2;
  string5 court_off_type_cd;
  string30 court_off_type_desc;
  string5 court_off_lev;
  string20 court_statute;
  string50 court_additional_statutes;
  string70 court_statute_desc;
  string8 court_disp_date;
  string5 court_disp_code;
  string40 court_disp_desc_1;
  string40 court_disp_desc_2;
  string8 sent_date;
  string50 sent_jail;
  string50 sent_susp_time;
  string8 sent_court_cost;
  string9 sent_court_fine;
  string9 sent_susp_court_fine;
  string50 sent_probation;
  string5 sent_addl_prov_code;
  string40 sent_addl_prov_desc_1;
  string40 sent_addl_prov_desc_2;
  string2 sent_consec;
  string10 sent_agency_rec_cust_ori;
  string50 sent_agency_rec_cust;
  string8 appeal_date;
  string40 appeal_off_disp;
  string40 appeal_final_decision;

end;

ds3 := dataset([{'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'},
{'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'},
{'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'},
{'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'},
{'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'},
{'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'}
],co_new);

crim_a := record
string8 process_date;
  string20 offender_key;
  string2 state_origin;
  string20 source_file;
  string15 id_num;
  string56 pty_nm;
  string1 pty_nm_fmt;
  string20 orig_lname;
  string20 orig_fname;
  string20 orig_mname;
  string6 orig_name_suffix;
  string1 pty_typ;
  string1 nitro_flag;
  string9 orig_ssn;
  string10 dle_num;
  string9 fbi_num;
  string10 doc_num;
  string10 ins_num;
  string2 citizenship;
  string8 dob;
  string8 dob_alias;
  string2 place_of_birth;
  string25 street_address_1;
  string25 street_address_2;
  string25 street_address_3;
  string10 street_address_4;
  string10 street_address_5;
  string3 race;
  string30 race_desc;
  string1 sex;
  string3 hair_color;
  string15 hair_color_desc;
  string3 eye_color;
  string15 eye_color_desc;
  string3 skin_color;
  string15 skin_color_desc;
  string3 height;
  string3 weight;
  string5 party_status;
  string60 party_status_desc;
  string1 data_type;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
string25 v_city_name;
  string2 st;
  string5 zip;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dpbc;
  string1 chk_digit;
  string2 rec_type;
  string2 ace_fips_st;
  string3 ace_fips_county;
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
  string5 name_suffix;
  string3 cleaning_score;
  string9 ssn;
  string12 did;
  string12 pgid;

end;

ds4 := dataset([{'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'},
{'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'},
{'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'},
{'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'},
{'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'},
{'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'}
],crim_a);


co_d := record
	string8 process_date;
  string20 offender_key;
  string2 vendor;
  string20 source_file;
  string15 id_num;
  string56 pty_nm;
  string1 pty_nm_fmt;
  string20 orig_lname;
  string20 orig_fname;
  string20 orig_mname;
  string6 orig_name_suffix;
  string1 pty_typ;
  string1 nitro_flag;
  string9 orig_ssn;
  string10 dle_num;
  string9 fbi_num;
  string10 doc_num;
  string10 ins_num;
  string2 citizenship;
  string8 dob;
  string8 dob_alias;
  string2 place_of_birth;
  string25 street_address_1;
  string25 street_address_2;
  string25 street_address_3;
  string10 street_address_4;
  string10 street_address_5;
  string3 race;
  string30 race_desc;
  string1 sex;
  string3 hair_color;
  string15 hair_color_desc;
  string3 eye_color;
  string15 eye_color_desc;
  string3 skin_color;
  string15 skin_color_desc;
  string3 height;
  string3 weight;
  string5 party_status;
  string60 party_status_desc;
  string1 data_type;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 suffix;
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
  string3 ace_fips_county;
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
  string5 name_suffix;
  string3 cleaning_score;
  string9 ssn;
  string12 did;
  string12 pgid;
end;

ds5 := dataset([{'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'},
{'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'},
{'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'},
{'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'},
{'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'},
{'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'}
],co_d);

co_rec := record
	string8 process_date;
  string20 offender_key;
  string2 vendor;
  string20 source_file;
  string50 offense_key;
  string8 off_date;
  string8 arr_date;
  string35 case_num;
  string3 num_of_counts;
  string20 off_code;
  string31 chg;
  string1 chg_typ_flg;
  string75 off_desc_1;
  string50 off_desc_2;
  string2 add_off_cd;
  string30 add_off_desc;
  string1 off_typ;
  string2 off_lev;
  string8 arr_disp_date;
  string3 arr_disp_cd;
  string50 arr_disp_desc_1;
  string50 arr_disp_desc_2;
  string50 arr_disp_desc_3;
  string5 court_cd;
  string40 court_desc;
  string40 ct_dist;
  string1 ct_fnl_plea_cd;
  string30 ct_fnl_plea;
  string8 ct_off_code;
  string17 ct_chg;
  string1 ct_chg_typ_flg;
  string50 ct_off_desc_1;
  string50 ct_off_desc_2;
  string1 ct_addl_desc_cd;
  string2 ct_off_lev;
  string8 ct_disp_dt;
  string4 ct_disp_cd;
  string50 ct_disp_desc_1;
  string50 ct_disp_desc_2;
  string2 cty_conv_cd;
  string30 cty_conv;
  string1 adj_wthd;
  string8 stc_dt;
  string3 stc_cd;
  string3 stc_comp;
  string50 stc_desc_1;
  string50 stc_desc_2;
  string50 stc_desc_3;
  string50 stc_desc_4;
 string15 stc_lgth;
  string50 stc_lgth_desc;
  string8 inc_adm_dt;
  string10 min_term;
  string35 min_term_desc;
  string10 max_term;
  string35 max_term_desc;

end;

ds6 := dataset([{'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'},
{'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'},
{'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'},
{'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'},
{'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'},
{'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'}
],co_rec);

cp_rec := record
  string8 process_date;
  string20 offender_key;
  string8 event_dt;
  string2 vendor;
  string20 source_file;
  string50 offense_key;
  string1 punishment_type;
  string15 sent_length;
  string60 sent_length_desc;
  string8 cur_stat_inm;
  string50 cur_stat_inm_desc;
  string8 cur_loc_inm_cd;
  string60 cur_loc_inm;
  string8 inm_com_cty_cd;
  string25 inm_com_cty;
  string8 cur_sec_class_dt;
  string25 cur_loc_sec;
  string3 gain_time;
  string8 gain_time_eff_dt;
  string8 latest_adm_dt;
  string8 sch_rel_dt;
  string8 act_rel_dt;
  string8 ctl_rel_dt;
  string8 presump_par_rel_dt;
  string8 mutl_part_pgm_dt;
  string8 par_cur_stat;
  string50 par_cur_stat_desc;
  string8 par_st_dt;
  string8 par_sch_end_dt;
  string8 par_act_end_dt;
  string8 par_cty_cd;
  string50 par_cty;
end;

ds7 := dataset([{'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'},
{'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'},
{'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'},
{'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'},
{'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'},
{'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'}],cp_rec);

DestinationIP := 'edata12-bld.br.seisint.com';


DesprayFile(string FileName,string Destfilename)
 :=
  if(lib_fileservices.fileservices.FileExists(FileName),
	 lib_fileservices.FileServices.Despray(FileName,DestinationIP,'/thor_back5/local_data/demo/'+Destfilename,,,,TRUE),
	 output(FileName + ' does not exist')
	)
 ;

DKCKeys(string KeyFileName,string Destfilename)
 :=
  if(lib_fileservices.fileservices.FileExists(KeyFileName),
	 lib_fileservices.FileServices.DKC(KeyFileName,DestinationIP,'/thor_back5/local_data/demo/'+Destfilename,,,,TRUE),
	 output(KeyFileName + ' does not exist')
	)
 ;


rMoxieFileForKeybuildLayout
 :=
  record
	codid_new;
	unsigned integer8 __filepos{virtual(fileposition)};
  end
 ;

h := dataset('~thor::out::court_crim::moxie::offender2_did',rMoxieFileForKeybuildLayout,flat);

unsigned8 moxietransform(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
  if (filepos<headersize, rawsize+filepos, filepos);

rawsize := sizeof(codid_new) * count(h) : global;
headersize := sizeof(codid_new) : global;

dfile := INDEX(h,{f:= moxietransform(__filepos, rawsize, headersize)},{h},'~thor_data400::key::moxie.crim_offender2_did.fpos.data.key');

Crim_Offender2_FPos_Data_Key := buildindex(dfile,moxie,overwrite);

rMoxieFileForKeybuildLayout1
 :=
  record
	co_new;
	unsigned integer8 __filepos{virtual(fileposition)};
  end
 ;

h1 := dataset('~thor::out::court_crim::moxie::offenses',rMoxieFileForKeybuildLayout1,flat);

unsigned8 moxietransform1(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
  if (filepos<headersize, rawsize+filepos, filepos);

rawsize1 := sizeof(co_new) * count(h1) : global;
headersize1 := sizeof(co_new) : global;

dfile1 := INDEX(h1,{f:= moxietransform1(__filepos, rawsize, headersize)},{h1},'~thor_data400::key::moxie.court_offenses.fpos.data.key');


Court_Offenses_FPos_Data_Key  := buildindex(dfile1,moxie,overwrite);


export bwr_moxie_crim := sequential(
output(ds1,,'~thor::out::court_crim::moxie::activity',overwrite),
DesprayFile('~thor::out::court_crim::moxie::activity','crim_court/court_crim_activity.d00'),
output(ds2,,'~thor::out::court_crim::moxie::offender2_did',overwrite),
Crim_Offender2_FPos_Data_Key,
DKCKeys('~thor_data400::key::moxie.crim_offender2_did.fpos.data.key','crim_court/crim_offender2_did.fpos.data.key'),
output(ds3,,'~thor::out::court_crim::moxie::offenses',overwrite),
Court_Offenses_FPos_Data_Key,
DKCKeys('~thor_data400::key::moxie.court_offenses.fpos.data.key','crim_court/court_offenses.fpos.data.key'),
output(ds4,,'~thor::out::crim::moxie::associates',overwrite),
DesprayFile('~thor::out::crim::moxie::associates','crim/crim_associates_did.d00'),
output(ds5,,'~thor::out::crim::moxie::offender_did',overwrite),
DesprayFile('~thor::out::crim::moxie::offender_did','crim/crim_offender_did.d00'),
output(ds6,,'~thor::out::crim::moxie::offenses',overwrite),
DesprayFile('~thor::out::crim::moxie::offenses','crim/crim_offenses.d00'),
output(ds7,,'~thor::out::crim::moxie::punishment',overwrite),
DesprayFile('~thor::out::crim::moxie::punishment','crim/crim_punishment.d00')
);