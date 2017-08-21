


sort_crim_Punishment_doc := sort(distribute(File_Crim_Punishment,hash(offender_key)),       	
 	 	offender_key,	
	  event_dt,		
	 	vendor,		
	 	source_file,		
	 	offense_key,		
	 	punishment_type,
	 	sent_length,		
	 	sent_length_desc,		
	 	cur_stat_inm,		
	 	cur_stat_inm_desc,		
	 	cur_loc_inm_cd,		
	 	cur_loc_inm,		
	 	inm_com_cty_cd,		
	 	inm_com_cty,		
	 	cur_sec_class_dt,		
	 	cur_loc_sec,		
	 	gain_time,		
	 	gain_time_eff_dt,		
	 	latest_adm_dt,		
	 	sch_rel_dt,		
	 	act_rel_dt,		
	 	ctl_rel_dt,		
	 	presump_par_rel_dt,		
	 	mutl_part_pgm_dt,		
	 	par_cur_stat,
	 	par_cur_stat_desc,		
	 	par_st_dt,		
	 	par_sch_end_dt,		
	 	par_act_end_dt,		
	 	par_cty_cd,		
	 	par_cty,	
		process_date,local);		

dedup_crim_Punishment_doc := DEDUP(sort_crim_Punishment_doc, RECORD, EXCEPT Process_date, KEEP 1,RIGHT,LOCAL);


export File_DOC_Crim_Punishment := dedup_crim_Punishment_doc;