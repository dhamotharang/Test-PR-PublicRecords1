import /*corrections, CrimSrch, Crim_Common,*/ hygenics_crim;

	hygenics_crim.layout_crimpunishment tDOCtoCrimSrchPunishment(hygenics_crim.layout_crimpunishment pInput) := transform
		self.conviction_override_date		:= if((integer4)pInput.act_rel_dt=0,
																				if((integer4)pInput.par_st_dt=0,
																					if((integer4)pInput.ctl_rel_dt=0,
																							pInput.process_date,
																							pInput.ctl_rel_dt
																						),
																						pInput.par_st_dt
																					),
																					pInput.act_rel_dt
																				);
		self.conviction_override_date_type	:= case(self.conviction_override_date,
																								pInput.act_rel_dt => 'R',
																								pInput.par_st_dt  => 'P',
																								pInput.latest_adm_dt => 'I',
																								'');	
																						
	  self.fcra_date	          					:= Map(hygenics_crim._functions.Is_Valid(hygenics_crim._functions.getdate, pInput.latest_adm_dt)  = 'Y' => pInput.latest_adm_dt,
																							 hygenics_crim._functions.Is_Valid(hygenics_crim._functions.getdate, pInput.par_st_dt)      = 'Y' => pInput.par_st_dt,
																							 hygenics_crim._functions.Is_Valid(hygenics_crim._functions.getdate, pInput.pro_st_dt)      = 'Y' => pInput.pro_st_dt,
																							 '');
																							 
	  self.fcra_date_type	      					:= Map(hygenics_crim._functions.Is_Valid(hygenics_crim._functions.getdate, pInput.latest_adm_dt)  = 'Y' => 'L', 
		                                           hygenics_crim._functions.Is_Valid(hygenics_crim._functions.getdate, pInput.par_st_dt)      = 'Y' => 'R', 
		                                           hygenics_crim._functions.Is_Valid(hygenics_crim._functions.getdate, pInput.pro_st_dt)      = 'Y' => 'P', 
																						   '');																							
		self 								:= pInput;
	end;

pun := project(File_DOC_Punishment,tDOCtoCrimSrchPunishment(left));

	filterField(String s) := FUNCTION
		return StringLib.StringFilter(StringLib.StringToUpperCase(s),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	END;

	pun addPPID(pun l):= transform

		Vevent_dt 					:= filterField(l.event_dt);
		Vvendor 						:= filterField(l.vendor);
		Vpunishment_type 		:= filterField(l.punishment_type);
		Vsent_date 					:= filterField(l.sent_date);		
		Vsent_length 				:= filterField(l.sent_length);
		Vcur_stat_inm_desc 	:= filterField(l.cur_stat_inm_desc);		
		Vlatest_adm_dt 			:= filterField(l.latest_adm_dt);
		Vsch_rel_dt 				:= filterField(l.sch_rel_dt);		
		Vact_rel_dt 				:= filterField(l.act_rel_dt);
		Vctl_rel_dt 				:= filterField(l.ctl_rel_dt);		
		Vrelease_type 			:= filterField(l.release_type);
		Vpar_cur_stat_desc 	:= filterField(l.par_cur_stat_desc);		
		Vpar_status_dt 			:= filterField(l.par_status_dt);
		Vpar_st_dt 					:= filterField(l.par_st_dt);		
		Vpar_sch_end_dt 		:= filterField(l.par_sch_end_dt);
		Vpar_act_end_dt 		:= filterField(l.par_act_end_dt);		
		Vpar_cty 						:= filterField(l.par_cty);
		Vpro_st_dt 					:= filterField(l.pro_st_dt);		
		Vpro_end_dt 				:= filterField(l.pro_end_dt);
		Vpro_status 				:= filterField(l.pro_status);		
		Vcur_loc_inm 				:= filterField(l.cur_loc_inm);
		Vcur_loc_sec 				:= filterField(l.cur_loc_sec);
		Vpresump_par_rel_dt := filterField(l.presump_par_rel_dt);		
		Vsent_length_desc 	:= filterField(l.sent_length_desc);
		
		self.punishment_persistent_id := hash64(trim(l.offender_key, left, right) +
																				Vevent_dt +            
																				Vvendor +
																				Vpunishment_type +
																				Vsent_date + 
																				Vsent_length +      
																				Vcur_stat_inm_desc +
																				Vlatest_adm_dt +
																				Vsch_rel_dt +         
																				Vact_rel_dt +          
																				Vctl_rel_dt +           
																				Vrelease_type +
																				Vpar_cur_stat_desc +          
																				Vpar_status_dt +
																				Vpar_st_dt +           
																				Vpar_sch_end_dt +              
																				Vpar_act_end_dt +               
																				Vpar_cty +
																				Vpro_st_dt +          
																				Vpro_end_dt +           
																				Vpro_status +
																				Vcur_loc_inm +
																				Vcur_loc_sec +
																				Vpresump_par_rel_dt +
																				Vsent_length_desc);
		self := l;
	end;

lPunishmentProcessed := project(pun, addPPID(left)): persist('~thor_data200::persist::CrimSrch_Punishment_Joined');

export Punishment_Joined :=	lPunishmentProcessed;