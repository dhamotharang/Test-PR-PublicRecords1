/*
 NOTE:	Referenced in CRIM_COMMON.Layout_Moxie_DOC_Offenses, so changes here
		will change that layout as well.
*/

export Layout_In_DOC_Offenses := module
 export new := 
  record
    string8 	process_date;
    string20	offender_key;
    string2 	vendor;
    string20	source_file;
    string50	offense_key;
    string8 	off_date;
    string8 	arr_date;
    string35	case_num;
	string3		total_num_of_offenses; //new field
    string3 	num_of_counts;
    string20	off_code;
    string31	chg;
    string1 	chg_typ_flg;
	string4		off_of_record; //new field
    string75	off_desc_1;
    string50	off_desc_2;
    string2 	add_off_cd;
    string30	add_off_desc;
    string1 	off_typ;
    string2 	off_lev;
    string8 	arr_disp_date;
    string3 	arr_disp_cd;
    string50	arr_disp_desc_1;
    string50	arr_disp_desc_2;
    string50	arr_disp_desc_3;
    string5 	court_cd;
    string40	court_desc;
    string40	ct_dist;
    string1 	ct_fnl_plea_cd;
    string30	ct_fnl_plea;
    string8 	ct_off_code;
    string17	ct_chg;
    string1 	ct_chg_typ_flg;
    string50	ct_off_desc_1;
    string50	ct_off_desc_2;
    string1 	ct_addl_desc_cd;
    string2 	ct_off_lev;
    string8 	ct_disp_dt;
    string4 	ct_disp_cd;
    string50	ct_disp_desc_1;
    string50	ct_disp_desc_2;
    string2 	cty_conv_cd;
    string30	cty_conv;
    string1 	adj_wthd;
    string8 	stc_dt; //sentence_date (1-4)
    string3 	stc_cd;
    string3 	stc_comp;
    string50	stc_desc_1;
    string50	stc_desc_2;
    string50	stc_desc_3;
    string50	stc_desc_4;
    string15	stc_lgth;
    string50	stc_lgth_desc;
    string8 	inc_adm_dt;
    string10	min_term;
    string35	min_term_desc;
    string10	max_term;
    string35	max_term_desc;
  end
 ;
 export previous := 
  record
    string8 	process_date;
    string20	offender_key;
    string2 	vendor;
    string20	source_file;
    string50	offense_key;
    string8 	off_date;
    string8 	arr_date;
    string35	case_num;
    string3 	num_of_counts;
    string20	off_code;
    string31	chg;
    string1 	chg_typ_flg;
    string75	off_desc_1;
    string50	off_desc_2;
    string2 	add_off_cd;
    string30	add_off_desc;
    string1 	off_typ;
    string2 	off_lev;
    string8 	arr_disp_date;
    string3 	arr_disp_cd;
    string50	arr_disp_desc_1;
    string50	arr_disp_desc_2;
    string50	arr_disp_desc_3;
    string5 	court_cd;
    string40	court_desc;
    string40	ct_dist;
    string1 	ct_fnl_plea_cd;
    string30	ct_fnl_plea;
    string8 	ct_off_code;
    string17	ct_chg;
    string1 	ct_chg_typ_flg;
    string50	ct_off_desc_1;
    string50	ct_off_desc_2;
    string1 	ct_addl_desc_cd;
    string2 	ct_off_lev;
    string8 	ct_disp_dt;
    string4 	ct_disp_cd;
    string50	ct_disp_desc_1;
    string50	ct_disp_desc_2;
    string2 	cty_conv_cd;
    string30	cty_conv;
    string1 	adj_wthd;
    string8 	stc_dt;
    string3 	stc_cd;
    string3 	stc_comp;
    string50	stc_desc_1;
    string50	stc_desc_2;
    string50	stc_desc_3;
    string50	stc_desc_4;
    string15	stc_lgth;
    string50	stc_lgth_desc;
    string8 	inc_adm_dt;
    string10	min_term;
    string35	min_term_desc;
    string10	max_term;
    string35	max_term_desc;
  end
 ;
 end
 ;