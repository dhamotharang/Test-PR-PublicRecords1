import Doxie,	Autokey_batch, Corrections;

export Assorted_Layouts := MODULE

	EXPORT Layout_IN := RECORD
		Autokey_batch.Layouts.rec_inBatchMaster;
		string25	docnum  := '' ;	
	END;
	
	EXPORT key := RECORD
			STRING30  acctno := '';
			String1   Match_type := '';
			STRING20  sdid := '';				
			string60 offender_key := '';
	END;
	
	EXPORT offender := RECORD
		    //offender
			//thor_data400::key::corrections_offenders::20071130::public
			string9  ssn;
			string30 lname;
			string30 fname;
			string30 mname;
			string1  pty_typ;
			string2  citizenship;
			string2 state_origin;
			string10	dle_num;
			string9	fbi_num;
			string10	ins_num;
			string15	id_num;
      string10 doc_num;
			string8  dob;
			string8  dob_alias;
			string25 place_of_birth;
			string25 street_address_1;
			string25 street_address_2;
			string25 street_address_3;
			string10 street_address_4;
			string10 street_address_5;
			Corrections.Layout_Offender.curr_incar_flag;
			Corrections.Layout_Offender.curr_parole_flag;
			Corrections.Layout_Offender.curr_probation_flag;
			string3  race;
			string30 race_desc;
			string7  sex;
			string3  hair_color;
			string15 hair_color_desc;
			string3  eye_color;
			string15 eye_color_desc;
			string3  skin_color;
			string15 skin_color_desc;
			string3  height;
			string3  weight;
			string5  party_status;
			string60 party_status_desc;
			string1  data_type;
			string45 datasource;
			qstring10 prim_range;
			string2   predir;
			qstring28 prim_name;
			qstring4  addr_suffix;
			string2   postdir;
			qstring10 unit_desig;
			qstring8  sec_range;
			qstring25 p_city_name;
			qstring25 v_city_name;
			string2   st;
			qstring5  zip5;
			qstring4  zip4;
	END;
	
	/*EXPORT offenses:= RECORD
	    //offenses
			//thor_data400::key::corrections_offenses_public_built
			// thor_data400::key::corrections_offenses::20071130::public 
			string8 process_date;
			string8 off_date;
			string8 arr_date;
			string3 num_of_counts;
			string20 off_code;
			string31 chg;
			string75 off_desc_1;
			string50 off_desc_2;
			string30 add_off_desc;
			string1 off_typ;
			string2 off_lev;
			string40 court_desc;
			string30 cty_conv;
			string8 stc_dt;
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
  		// Match_type
  END;
*/

	EXPORT Offenses := RECORD
			string8	process_date;
			// string20	offender_key;
			string35	case_num_1;
			string8	off_date_1;
			string8	arr_date_1;
			string3	num_of_counts_1;
			string20	off_code_1;
			string31	chg_1;
			string75	off_desc_1_1;
			string50	off_desc_2_1;
			string2	add_off_cd_1;
			string30	add_off_desc_1;
			string1	off_typ_1;
			string2	off_lev_1;
			string40	court_desc_1;
			string30	cty_conv_1;
			string8	stc_dt_1;
			string3	stc_comp_1;
			string50	stc_desc_1_1;
			string50	stc_desc_2_1;
			string50	stc_desc_3_1;
			string50	stc_desc_4_1;
			string15	stc_lgth_1;
			string50	stc_lgth_desc_1;
			string8	inc_adm_dt_1;
			string10	min_term_1;
			string35	min_term_desc_1;
			string10	max_term_1;
			string35	max_term_desc_1;
			
			string35	case_num_2;
			string8	off_date_2;
			string8	arr_date_2;
			string3	num_of_counts_2;
			string20	off_code_2;
			string31	chg_2;
			string75	off_desc_1_2;
			string50	off_desc_2_2;
			string2	add_off_cd_2;
			string30	add_off_desc_2;
			string1	off_typ_2;
			string2	off_lev_2;
			string40	court_desc_2;
			string30	cty_conv_2;
			string8	stc_dt_2;
			string3	stc_comp_2;
			string50	stc_desc_1_2;
			string50	stc_desc_2_2;
			string50	stc_desc_3_2;
			string50	stc_desc_4_2;
			string15	stc_lgth_2;
			string50	stc_lgth_desc_2;
			string8	inc_adm_dt_2;
			string10	min_term_2;
			string35	min_term_desc_2;
			string10	max_term_2;
			string35	max_term_desc_2;
			
			string35	case_num_3;
			string8	off_date_3;
			string8	arr_date_3;
			string3	num_of_counts_3;
			string20	off_code_3;
			string31	chg_3;
			string75	off_desc_1_3;
			string50	off_desc_2_3;
			string2	add_off_cd_3;
			string30	add_off_desc_3;
			string1	off_typ_3;
			string2	off_lev_3;
			string40	court_desc_3;
			string30	cty_conv_3;
			string8	stc_dt_3;
			string3	stc_comp_3;
			string50	stc_desc_1_3;
			string50	stc_desc_2_3;
			string50	stc_desc_3_3;
			string50	stc_desc_4_3;
			string15	stc_lgth_3;
			string50	stc_lgth_desc_3;
			string8	inc_adm_dt_3;
			string10	min_term_3;
			string35	min_term_desc_3;
			string10	max_term_3;
			string35	max_term_desc_3;
			
			string35	case_num_4;
			string8	off_date_4;
			string8	arr_date_4;
			string3	num_of_counts_4;
			string20	off_code_4;
			string31	chg_4;
			string75	off_desc_1_4;
			string50	off_desc_2_4;
			string2	add_off_cd_4;
			string30	add_off_desc_4;
			string1	off_typ_4;
			string2	off_lev_4;
			string40	court_desc_4;
			string30	cty_conv_4;
			string8	stc_dt_4;
			string3	stc_comp_4;
			string50	stc_desc_1_4;
			string50	stc_desc_2_4;
			string50	stc_desc_3_4;
			string50	stc_desc_4_4;
			string15	stc_lgth_4;
			string50	stc_lgth_desc_4;
			string8	inc_adm_dt_4;
			string10	min_term_4;
			string35	min_term_desc_4;
			string10	max_term_4;
			string35	max_term_desc_4;
			
			string35	case_num_5;
			string8	off_date_5;
			string8	arr_date_5;
			string3	num_of_counts_5;
			string20	off_code_5;
			string31	chg_5;
			string75	off_desc_1_5;
			string50	off_desc_2_5;
			string2	add_off_cd_5;
			string30	add_off_desc_5;
			string1	off_typ_5;
			string2	off_lev_5;
			string40	court_desc_5;
			string30	cty_conv_5;
			string8	stc_dt_5;
			string3	stc_comp_5;
			string50	stc_desc_1_5;
			string50	stc_desc_2_5;
			string50	stc_desc_3_5;
			string50	stc_desc_4_5;
			string15	stc_lgth_5;
			string50	stc_lgth_desc_5;
			string8	inc_adm_dt_5;
			string10	min_term_5;
			string35	min_term_desc_5;
			string10	max_term_5;
			string35	max_term_desc_5;
			
			string35	case_num_6;
			string8	off_date_6;
			string8	arr_date_6;
			string3	num_of_counts_6;
			string20	off_code_6;
			string31	chg_6;
			string75	off_desc_1_6;
			string50	off_desc_2_6;
			string2	add_off_cd_6;
			string30	add_off_desc_6;
			string1	off_typ_6;
			string2	off_lev_6;
			string40	court_desc_6;
			string30	cty_conv_6;
			string8	stc_dt_6;
			string3	stc_comp_6;
			string50	stc_desc_1_6;
			string50	stc_desc_2_6;
			string50	stc_desc_3_6;
			string50	stc_desc_4_6;
			string15	stc_lgth_6;
			string50	stc_lgth_desc_6;
			string8	inc_adm_dt_6;
			string10	min_term_6;
			string35	min_term_desc_6;
			string10	max_term_6;
			string35	max_term_desc_6;

	END;

/*	
	EXPORT punishment := RECORD
			//punishment
			//thor_data400::key::corrections_punishment_public_built
			//thor_data400::key::corrections_punishment::20071130::public
			string8 event_dt;
			string1 punishment_type;
			// string15 sent_length;
			// string60 sent_length_desc;
			// string8 cur_stat_inm;
			// string50 cur_stat_inm_desc;
			// string8 cur_loc_inm_cd;
			// string60 cur_loc_inm;
			// string8 cur_sec_class_dt;
			// string25 cur_loc_sec;
			// string3 gain_time;
			// string8 gain_time_eff_dt;
			string8 presump_par_rel_dt;
			string8 par_cur_stat;
			string50 par_cur_stat_desc;
			string8 par_st_dt;
			string8 par_sch_end_dt;
			string8 par_act_end_dt;
			string50 par_cty;
			string8 latest_adm_dt_1;
			string8 sch_rel_dt_1;
			string8 act_rel_dt_1;
			string8 ctl_rel_dt_1;
			string8 latest_adm_dt_2;
			string8 sch_rel_dt_2;
			string8 act_rel_dt_2;
			string8 ctl_rel_dt_2;
			string8 latest_adm_dt_3;
			string8 sch_rel_dt_3;
			string8 act_rel_dt_3;
			string8 ctl_rel_dt_3;
		  string8 latest_adm_dt_4;
			string8 sch_rel_dt_4;
			string8 act_rel_dt_4;
			string8 ctl_rel_dt_4;
			string8 latest_adm_dt_5;
			string8 sch_rel_dt_5;
			string8 act_rel_dt_5;
			string8 ctl_rel_dt_5;
			string8 latest_adm_dt_6;
			string8 sch_rel_dt_6;
			string8 act_rel_dt_6;
			string8 ctl_rel_dt_6;

			// Match_type		
  END;
*/

	EXPORT par_punishment := RECORD
			
			string8	par_event_dt_1;
			string8	presump_par_rel_dt_1;
			string8	par_cur_stat_1;
			string50	par_cur_stat_desc_1;
			string8	par_st_dt_1;
			string8	par_sch_end_dt_1;
			string8	par_act_end_dt_1;
			string50	par_cty_1;

			string8	par_event_dt_2;
			string8	presump_par_rel_dt_2;
			string8	par_cur_stat_2;
			string50	par_cur_stat_desc_2;
			string8	par_st_dt_2;
			string8	par_sch_end_dt_2;
			string8	par_act_end_dt_2;
			string50	par_cty_2;
			
			string8	par_event_dt_3;
			string8	presump_par_rel_dt_3;
			string8	par_cur_stat_3;
			string50	par_cur_stat_desc_3;
			string8	par_st_dt_3;
			string8	par_sch_end_dt_3;
			string8	par_act_end_dt_3;
			string50	par_cty_3;	
			
			string8	par_event_dt_4;
			string8	presump_par_rel_dt_4;
			string8	par_cur_stat_4;
			string50	par_cur_stat_desc_4;
			string8	par_st_dt_4;
			string8	par_sch_end_dt_4;
			string8	par_act_end_dt_4;
			string50	par_cty_4;
			
			string8	par_event_dt_5;
			string8	presump_par_rel_dt_5;
			string8	par_cur_stat_5;
			string50	par_cur_stat_desc_5;
			string8	par_st_dt_5;
			string8	par_sch_end_dt_5;
			string8	par_act_end_dt_5;
			string50	par_cty_5;
			
			string8	par_event_dt_6;
			string8	presump_par_rel_dt_6;
			string8	par_cur_stat_6;
			string50	par_cur_stat_desc_6;
			string8	par_st_dt_6;
			string8	par_sch_end_dt_6;
			string8	par_act_end_dt_6;
			string50	par_cty_6;		
	END;

  EXPORT in_Punishment := RECORD
			// string8	process_date
			// string20	offender_key
			// string8	event_dt;
		
			string8	in_event_dt_1;
			string15	sent_length_1;
			string60	sent_length_desc_1;
			string8	cur_stat_inm_1;
			string50	cur_stat_inm_desc_1;
			string8	cur_loc_inm_cd_1;
			string60	cur_loc_inm_1;
			string8	cur_sec_class_dt_1;
			string25	cur_loc_sec_1;
			string3	gain_time_1;
			string8	gain_time_eff_dt_1;
			string8	latest_adm_dt_1;
			string8	sch_rel_dt_1;
			string8	act_rel_dt_1;
			string8	ctl_rel_dt_1;
			
			string8	in_event_dt_2;
			string15	sent_length_2;
			string60	sent_length_desc_2;
			string8	cur_stat_inm_2;
			string50	cur_stat_inm_desc_2;
			string8	cur_loc_inm_cd_2;
			string60	cur_loc_inm_2;
			string8	cur_sec_class_dt_2;
			string25	cur_loc_sec_2;
			string3	gain_time_2;
			string8	gain_time_eff_dt_2;
			string8	latest_adm_dt_2;
			string8	sch_rel_dt_2;
			string8	act_rel_dt_2;
			string8	ctl_rel_dt_2;

			string8	in_event_dt_3;			
			string15	sent_length_3;
			string60	sent_length_desc_3;
			string8	cur_stat_inm_3;
			string50	cur_stat_inm_desc_3;
			string8	cur_loc_inm_cd_3;
			string60	cur_loc_inm_3;
			string8	cur_sec_class_dt_3;
			string25	cur_loc_sec_3;
			string3	gain_time_3;
			string8	gain_time_eff_dt_3;
			string8	latest_adm_dt_3;
			string8	sch_rel_dt_3;
			string8	act_rel_dt_3;
			string8	ctl_rel_dt_3;
			
			string8	in_event_dt_4;			
			string15	sent_length_4;
			string60	sent_length_desc_4;
			string8	cur_stat_inm_4;
			string50	cur_stat_inm_desc_4;
			string8	cur_loc_inm_cd_4;
			string60	cur_loc_inm_4;
			string8	cur_sec_class_dt_4;
			string25	cur_loc_sec_4;
			string3	gain_time_4;
			string8	gain_time_eff_dt_4;
			string8	latest_adm_dt_4;
			string8	sch_rel_dt_4;
			string8	act_rel_dt_4;
			string8	ctl_rel_dt_4;
			
			string8	in_event_dt_5;			
			string15	sent_length_5;
			string60	sent_length_desc_5;
			string8	cur_stat_inm_5;
			string50	cur_stat_inm_desc_5;
			string8	cur_loc_inm_cd_5;
			string60	cur_loc_inm_5;
			string8	cur_sec_class_dt_5;
			string25	cur_loc_sec_5;
			string3	gain_time_5;
			string8	gain_time_eff_dt_5;
			string8	latest_adm_dt_5;
			string8	sch_rel_dt_5;
			string8	act_rel_dt_5;
			string8	ctl_rel_dt_5;
			
			string8	in_event_dt_6;			
			string15	sent_length_6;
			string60	sent_length_desc_6;
			string8	cur_stat_inm_6;
			string50	cur_stat_inm_desc_6;
			string8	cur_loc_inm_cd_6;
			string60	cur_loc_inm_6;
			string8	cur_sec_class_dt_6;
			string25	cur_loc_sec_6;
			string3	gain_time_6;
			string8	gain_time_eff_dt_6;
			string8	latest_adm_dt_6;
			string8	sch_rel_dt_6;
			string8	act_rel_dt_6;
			string8	ctl_rel_dt_6;
	END;
	
	EXPORT punishment := RECORD
				// string1	punishment_type;
				// string1	punishment_type;
			  in_punishment;
				par_punishment;
	END;
	
	EXPORT Layout_OUT := RECORD
	    // unsigned2 penalt := 0;
			string2 output_type;
			key;
			offender;
			offenses;
			punishment;
  END;
	
		EXPORT Layout_OUT1 := RECORD
			key;
			offender;
			offenses;
			punishment;
			String3 too_many_code :='';
			String1 too_many_flag   := '';
  END;
	
	EXPORT Layout_PII_In := RECORD
		doxie.layout_references_acctno.acctno;

		STRING20	name_first;
		STRING20	name_middle;
		STRING20	name_last;
		STRING10	name_suffix;

		STRING12	ssn;
		UNSIGNED	dob;

		STRING		stAddr{MAXLENGTH(120)};
		STRING25	city;
		STRING25	state;
		STRING10	zip;
	END;

	EXPORT Layout_PII_Out := RECORD
		doxie.layout_references_acctno.acctno;
		string1 Incarceration_Flag;
		typeof(Corrections.Layout_Offender.orig_state) INCR_state_origin;
		typeof(Corrections.Layout_Offender.doc_num) INCR_doc_num;
		typeof(Corrections.Layout_Offender.dob) INCR_dob;
		Corrections.Layout_CrimPunishment.event_dt;
		Corrections.Layout_CrimPunishment.punishment_type;
		Corrections.Layout_CrimPunishment.sent_length;
		Corrections.Layout_CrimPunishment.sent_length_desc;
		Corrections.Layout_CrimPunishment.cur_stat_inm;
		Corrections.Layout_CrimPunishment.cur_stat_inm_desc;
		Corrections.Layout_CrimPunishment.cur_loc_inm;
		Corrections.Layout_CrimPunishment.cur_sec_class_dt;
		Corrections.Layout_CrimPunishment.cur_loc_sec;
		Corrections.Layout_CrimPunishment.gain_time;
		Corrections.Layout_CrimPunishment.gain_time_eff_dt;
		Corrections.Layout_CrimPunishment.latest_adm_dt;
		Corrections.Layout_CrimPunishment.sch_rel_dt;
		Corrections.Layout_CrimPunishment.act_rel_dt;
		Corrections.Layout_CrimPunishment.ctl_rel_dt;
		Corrections.Layout_CrimPunishment.presump_par_rel_dt;
		STRING	match_type{MAXLENGTH(8)};
		// BUG #97804 - Return Name and SSN
		typeof(Corrections.Layout_Offender.ssn) INCR_ssn;
		typeof(Corrections.Layout_Offender.fname) INCR_fname;
		typeof(Corrections.Layout_Offender.lname) INCR_lname;
	END;


END;