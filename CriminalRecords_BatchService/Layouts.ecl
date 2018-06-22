import BatchShare, Corrections, doxie, doxie_files, FFD;

export Layouts := MODULE
	shared offender_key 	:= recordof(doxie_files.Key_Offenders_OffenderKey());
	shared offenses_key 	:= recordof(doxie_files.Key_Offenses());
	shared punishment_key := recordof(doxie_files.Key_Punishment());
	shared court_offense_key := recordof(doxie_files.Key_court_offenses());
	
	export batch_pii_in := record
		BatchShare.Layouts.ShareAcct;
		BatchShare.Layouts.ShareDid;
		BatchShare.Layouts.ShareName;
		BatchShare.Layouts.SharePII;
		STRING		stAddr{MAXLENGTH(120)};
		STRING25	city;
		STRING25	state;
		STRING10	zip;
		BatchShare.Layouts.ShareAddress;
	end;
	
	export lookup_id_pii := record
		batch_pii_in.acctno;
		UNSIGNED1	matchResult;
		UNSIGNED6	did;
		offender_key.offender_key;
	END;
	
	EXPORT batch_pii_out := RECORD
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
		BatchShare.Layouts.ShareErrors;
		FFD.Layouts.ConsumerStatementBatch.SequenceNumber;
		FFD.Layouts.ConsumerFlags;
		typeof(Corrections.Layout_Offender.did) INCR_did := '';
    string12 inquiry_lexid := '';
	END;
	
	export batch_pii_out_pre := RECORD(batch_pii_out)
		dataset (FFD.Layouts.ConsumerStatementBatch) StatementsAndDisputes;
	end;
	
	
	export batch_pii_int := RECORD
		batch_pii_out;
		lookup_id_pii.offender_key;
		UNSIGNED6	did;
	END;
	
	export batch_pii_int_offender := RECORD
		recordof(offender_key);
		STRING4 pfirst;
		FFD.Layouts.CommonRawRecordElements
	END;
	
	export batch_in := RECORD
		BatchShare.Layouts.ShareAcct;
		BatchShare.Layouts.ShareDid;
		BatchShare.Layouts.ShareName;
		BatchShare.Layouts.ShareAddress;
		BatchShare.Layouts.SharePII;
		string25	docnum  := '' ;	
	END;
	
	EXPORT lookup_id := RECORD
		batch_in.acctno;
		String1   Match_type := '';
		batch_in.did;				
		offender_key.offender_key;
		String3 too_many_code :='';
		String1 too_many_flag   := '';
	END;
	
	EXPORT offender := RECORD
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
	
	EXPORT Offenses := RECORD
		string8	process_date;
		//offense 1
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
		//offense 2
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
		// offense 3
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
		//offense 4
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
		//offense 5
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
		//offense 6
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

    // *** Beginning of new fields for the 06/13/2017 offenses categories filtering enhancement 
    unsigned8 offense_category_1; // to assist with results filtering and debugging only
    unsigned8 offense_category_2; // to assist with results filtering and debugging only
    unsigned8 offense_category_3; // to assist with results filtering and debugging only
    unsigned8 offense_category_4; // to assist with results filtering and debugging only
    unsigned8 offense_category_5; // to assist with results filtering and debugging only
    unsigned8 offense_category_6; // to assist with results filtering and debugging only

    // up to 5 decoded category values per each of the 6 offense occurrences
		string50  off_cat_1_1; 
		string50  off_cat_2_1;
		string50  off_cat_3_1;
		string50  off_cat_4_1;
		string50  off_cat_5_1; 
		string50  off_cat_1_2; 
		string50  off_cat_2_2;
		string50  off_cat_3_2;
		string50  off_cat_4_2;
		string50  off_cat_5_2; 
		string50  off_cat_1_3;
		string50  off_cat_2_3;
		string50  off_cat_3_3;
		string50  off_cat_4_3;
		string50  off_cat_5_3;
		string50  off_cat_1_4;
		string50  off_cat_2_4;
		string50  off_cat_3_4;
		string50  off_cat_4_4;
		string50  off_cat_5_4;
		string50  off_cat_1_5;
		string50  off_cat_2_5;
		string50  off_cat_3_5;
		string50  off_cat_4_5;
		string50  off_cat_5_5;
		string50  off_cat_1_6;
		string50  off_cat_2_6;
		string50  off_cat_3_6;
		string50  off_cat_4_6;
		string50  off_cat_5_6;

	END;
		
	EXPORT punishment := RECORD
		string1 punishment_type;
		//in_punishment 1
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
		//in_punishment 2
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
		//in_punishment 3
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
		//in_punishment 4
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
		//in_punishment 5
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
		//in_punishment 6
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
		//par_punishment 1
		string8	par_event_dt_1;
		string8	presump_par_rel_dt_1;
		string8	par_cur_stat_1;
		string50	par_cur_stat_desc_1;
		string8	par_st_dt_1;
		string8	par_sch_end_dt_1;
		string8	par_act_end_dt_1;
		string50	par_cty_1;
		//par_punishment 2
		string8	par_event_dt_2;
		string8	presump_par_rel_dt_2;
		string8	par_cur_stat_2;
		string50	par_cur_stat_desc_2;
		string8	par_st_dt_2;
		string8	par_sch_end_dt_2;
		string8	par_act_end_dt_2;
		string50	par_cty_2;
		//par_punishment 3
		string8	par_event_dt_3;
		string8	presump_par_rel_dt_3;
		string8	par_cur_stat_3;
		string50	par_cur_stat_desc_3;
		string8	par_st_dt_3;
		string8	par_sch_end_dt_3;
		string8	par_act_end_dt_3;
		string50	par_cty_3;	
		//par_punishment 4
		string8	par_event_dt_4;
		string8	presump_par_rel_dt_4;
		string8	par_cur_stat_4;
		string50	par_cur_stat_desc_4;
		string8	par_st_dt_4;
		string8	par_sch_end_dt_4;
		string8	par_act_end_dt_4;
		string50	par_cty_4;
		//par_punishment 5
		string8	par_event_dt_5;
		string8	presump_par_rel_dt_5;
		string8	par_cur_stat_5;
		string50	par_cur_stat_desc_5;
		string8	par_st_dt_5;
		string8	par_sch_end_dt_5;
		string8	par_act_end_dt_5;
		string50	par_cty_5;
		//par_punishment 6
		string8	par_event_dt_6;
		string8	presump_par_rel_dt_6;
		string8	par_cur_stat_6;
		string50	par_cur_stat_desc_6;
		string8	par_st_dt_6;
		string8	par_sch_end_dt_6;
		string8	par_act_end_dt_6;
		string50	par_cty_6;		
	END;
	
	EXPORT batch_out := RECORD
		lookup_id;
		offender;
		offenses;
		punishment;
		BatchShare.Layouts.ShareErrors;
		STRING20 sdid;
		FFD.Layouts.ConsumerStatementBatch.SequenceNumber;
		FFD.Layouts.ConsumerFlags;
    STRING12 inquiry_lexid := '';
  END;
	
	EXPORT batch_out_pre := RECORD	
		batch_out;
		dataset (FFD.Layouts.ConsumerStatementBatch) StatementsAndDisputes;
	END;
	
	EXPORT batch_int := RECORD
		string2 output_type;
		batch_out and not BatchShare.Layouts.ShareErrors;
		string8 fcra_date;
		string1 fcra_conviction_flag;
		string1 fcra_traffic_flag;
		dataset (FFD.Layouts.ConsumerStatementBatch) StatementsAndDisputes;
	END;	
	
	EXPORT batch_int_offenses := RECORD
		lookup_id;
		offenses_key and not [offender_key];
		FFD.Layouts.CommonRawRecordElements;
	END;
	
	EXPORT batch_int_court_offense := RECORD
		lookup_id;
		court_offense_key and not [offender_key];
		FFD.Layouts.CommonRawRecordElements;
	END;
	
	EXPORT batch_int_punishment := RECORD
		lookup_id;
		punishment_key and not [offender_key];
		FFD.Layouts.CommonRawRecordElements;
	END;
END;