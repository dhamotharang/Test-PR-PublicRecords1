import doxie, doxie_build, corrections, hygenics_search, ut;

export key_prep_punishment (boolean IsFCRA = false) := function

d := File_Punishment_Keybuilding;
  
	corrections.Layout_CrimPunishment get_prob_records (d L) := transform
		self.event_dt      			:= Map(l.pro_end_dt <> '' => l.pro_end_dt,
																		l.pro_st_dt);
		self.punishment_type 		:='I';
		self.sent_date       		:='';
		self.sent_length     		:='';
		self.sent_length_desc		:='';
		self.cur_stat_inm    		:='PROB';
		self.cur_stat_inm_desc	:=l.pro_status;
		self.cur_loc_inm_cd  		:='';
		self.inm_com_cty_cd  		:='';
		self.inm_com_cty     		:='';
		self.cur_sec_class_dt		:='';
		self.cur_loc_sec     		:='';
		self.gain_time       		:='';
		self.gain_time_eff_dt		:='';
		self.latest_adm_dt   		:=l.pro_st_dt;
		self.sch_rel_dt      		:='';
		self.act_rel_dt      		:=l.pro_end_dt;
		self.ctl_rel_dt      		:='';
		self.presump_par_rel_dt	:='';
		self.mutl_part_pgm_dt		:='';
		self.release_type    		:='';
		self.office_region   		:='';
		self.par_cur_stat    		:='';
		self.par_cur_stat_desc	:='';
		self.par_status_dt   		:='';
		self.par_st_dt       		:='';
		self.par_sch_end_dt  		:='';
		self.par_act_end_dt  		:='';
		self.par_cty_cd      		:='';
		self.par_cty         		:='';
		self.parole_active_flag := '';
		self := L;
	end;

	df_prob := PROJECT(d(pro_status <> '' or pro_end_dt <> '' or pro_st_dt <> ''),get_prob_records(left)); 
	df_rest := PROJECT(d,TRANSFORM(corrections.Layout_CrimPunishment,SELF := LEFT));     
	df_all 	:= df_prob + df_rest;
               
s_df_all := dedup(sort(df_all(sent_length <> ''   or sent_length_desc<> '' or 				
									 cur_stat_inm <> ''  or cur_stat_inm_desc <> '' or 				
									cur_loc_inm_cd <> '' or cur_loc_inm <> '' or 				
									inm_com_cty_cd <> '' or inm_com_cty <> '' or 				
									cur_sec_class_dt <> '' or cur_loc_sec <> '' or 				
									gain_time <> '' or 	gain_time_eff_dt <> '' or 				
									latest_adm_dt <> '' or sch_rel_dt <> '' or 				
									act_rel_dt <> '' or ctl_rel_dt <> '' or 				
									presump_par_rel_dt <> '' or mutl_part_pgm_dt <> '' or 				
									par_cur_stat <> '' or par_cur_stat_desc <> '' or 				
									par_st_dt <> ''    or par_sch_end_dt <> '' or 				
									par_act_end_dt <> '' or par_cty_cd <> '' or 				
									par_cty <> '' or 			supv_officer <> '' or office_phone <> '' or 
	                tdcjid_unit_type <> '' or tdcjid_unit_assigned <> '' or 
									tdcjid_admit_date <> '' or prison_status <> '' or 
									recv_dept_code <> '' or recv_dept_date <> '' or 
									parole_active_flag <> '' or casepull_date <> '' ) ,record), except punishment_persistent_id);

df2 := s_df_all(Vendor not in hygenics_search.sCourt_Vendors_To_Omit);
//DF-21868 Deprecate specified fields in thor_200::key::criminal_punishment::fcra::qa::offender_key.punishment_type
ut.MAC_CLEAR_FIELDS(df2, df2_cleared, hygenics_crim.constants('').fields_to_clear_punishment_type);

df 	:= s_df_all;

string file_name := if(IsFCRA, 
					 '~thor_200::key::criminal_punishment::fcra::'+doxie.Version_SuperKey+'::offender_key.punishment_type',
					 '~thor_data400::key::corrections_punishment_'+doxie_build.buildstate + thorlib.wuid());

return if (IsFCRA,
           index(df2_cleared,{ok := df2_cleared.offender_key, pt := df2_cleared.punishment_type},{df2_cleared}, file_name, OPT),
           index(df,{ok := df.offender_key, pt := df.punishment_type},{df}, file_name));

end;
                     