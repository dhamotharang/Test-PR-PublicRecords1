/*
 NOTE:	This layout is referenced in CRIM_COMMON.Layout_Moxie_DOC_Punishment,
		since they are the same.  Changes here will change that layout, too.
*/
export Layout_In_DOC_Punishment
 := module
 export new := 
  record
	string8 	process_date;		
	string20 	offender_key;		
	string8  	event_dt;		
	string2 	vendor;		
	string20 	source_file;		
	string50 	offense_key;		
	string1 	punishment_type;
	string8		sent_date; //new field
	string15 	sent_length;		
	string60 	sent_length_desc;		
	string8 	cur_stat_inm;		
	string50 	cur_stat_inm_desc;		
	string8 	cur_loc_inm_cd;		
	string60 	cur_loc_inm;		
	string8 	inm_com_cty_cd;		
	string25 	inm_com_cty;		
	string8 	cur_sec_class_dt;		
	string25 	cur_loc_sec;		
	string3 	gain_time;		
	string8 	gain_time_eff_dt;		
	string8 	latest_adm_dt;		
	string8 	sch_rel_dt;		
	string8 	act_rel_dt;		
	string8 	ctl_rel_dt;		
	string8 	presump_par_rel_dt;		
	string8 	mutl_part_pgm_dt;		
	string4 	release_type;	//new field
	string2 	office_region;	//new field
	string8 	par_cur_stat;
	string50 	par_cur_stat_desc;		
	string8		par_status_dt; //new field
	string8 	par_st_dt;		
	string8 	par_sch_end_dt;		
	string8 	par_act_end_dt;		
	string8 	par_cty_cd;		
	string50 	par_cty;		
	string30 	supv_office;	//new field
	string30 	supv_officer;	//new field
	string14 	office_phone;	//new field
	//Future	fields///////////////////////	
	string2 	TDCJID_unit_type;		
	string15 	TDCJID_unit_assigned;		
	string1 	TDCJID_admit_date;		
	string1 	prison_status;		
	string2 	recv_dept_code;		
	string10 	recv_dept_date;		
	string1 	parole_active_flag;		
	string10 	casepull_date;		
	//////////////////////////////////////	
  end
 ;
 export previous := 
  record
	string8 	process_date;		
	string20 	offender_key;		
	string8  	event_dt;		
	string2 	vendor;		
	string20 	source_file;		
	string50 	offense_key;		
	string1 	punishment_type;
	string15 	sent_length;		
	string60 	sent_length_desc;		
	string8 	cur_stat_inm;		
	string50 	cur_stat_inm_desc;		
	string8 	cur_loc_inm_cd;		
	string60 	cur_loc_inm;		
	string8 	inm_com_cty_cd;		
	string25 	inm_com_cty;		
	string8 	cur_sec_class_dt;		
	string25 	cur_loc_sec;		
	string3 	gain_time;		
	string8 	gain_time_eff_dt;		
	string8 	latest_adm_dt;		
	string8 	sch_rel_dt;		
	string8 	act_rel_dt;		
	string8 	ctl_rel_dt;		
	string8 	presump_par_rel_dt;		
	string8 	mutl_part_pgm_dt;		
	string8 	par_cur_stat;
	string50 	par_cur_stat_desc;		
	string8 	par_st_dt;		
	string8 	par_sch_end_dt;		
	string8 	par_act_end_dt;		
	string8 	par_cty_cd;		
	string50 	par_cty;		
  end
 ;
 end
 ;