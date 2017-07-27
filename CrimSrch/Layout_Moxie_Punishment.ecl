export Layout_Moxie_Punishment := record
	string8		date_first_reported;
	string8		date_last_reported;
	string60	offender_key;
	string8		event_date;
	string2		vendor;
	string20	source_file;
	string50	orig_offense_key;
	string1		punishment_type;
	string15	sent_length;
	string60	sent_length_desc;
	string50	inmate_cur_status_desc;
	string60	inmate_cur_loc;
	string8		admit_latest_date;
	string8		release_sched_date;
	string8		release_actual_date;
	string50	parole_cur_status_desc;
	string8		parole_start_date;
	string8		parole_sched_end_date;
	string8		parole_actual_end_date;
	string50	parole_county;
	string8		conviction_override_date;
	string1		conviction_override_date_type;
	//new fields added
	string8		cur_stat_inm_desc;
	string9		cur_loc_inm_cd;
	string25 	cur_loc_sec;
	string8		ctl_rel_dt;
	/*string8	pro_st_dt;
	string8	pro_end_dt;
	string50 	pro_status;
	string8		ctl_rel_dt;
	string8		presump_par_rel_dt;*/
end;