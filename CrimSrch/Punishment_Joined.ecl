import CrimSrch, Crim_Common;

Layout_Moxie_Punishment tDOCtoCrimSrchPunishment(Crim_Common.Layout_Moxie_DOC_Punishment.previous pInput)
 :=
  transform
	self.date_first_reported	:= pInput.process_date; 
	self.date_last_reported		:= pInput.process_date; 
	self.offender_key			:= pInput.offender_key; 
	self.event_date				:= pInput.event_dt; 
	self.vendor					:= pInput.vendor; 
	self.source_file			:= pInput.source_file; 
	self.orig_offense_key		:= pInput.offense_key; 
	self.punishment_type		:= pInput.punishment_type; 
	self.sent_length			:= pInput.sent_length; 
	self.sent_length_desc		:= pInput.sent_length_desc; 
	self.inmate_cur_status_desc	:= pInput.cur_stat_inm_desc; 
	self.inmate_cur_loc			:= pInput.cur_loc_inm; 
	self.admit_latest_date		:= pInput.latest_adm_dt; 
	self.release_sched_date		:= pInput.sch_rel_dt; 
	self.release_actual_date	:= pInput.act_rel_dt; 
	self.parole_cur_status_desc	:= pInput.par_cur_stat_desc; 
	self.parole_start_date		:= pInput.par_st_dt; 
	self.parole_sched_end_date	:= pInput.par_sch_end_dt; 
	self.parole_actual_end_date	:= pInput.par_act_end_dt; 
	self.parole_county			:= pInput.par_cty;
/*
	self.conviction_override_date		:= if((integer4)pInput.act_rel_dt<>0,
											  if(pInput.par_st_dt>pInput.act_rel_dt,
												 pInput.par_st_dt,
												 pInput.act_rel_dt
												),
											  if((integer4)pInput.par_st_dt<>0,
												 pInput.par_st_dt,
												 pInput.latest_adm_dt
												)
											 );
*/
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
												''
											   );
  end
 ;

lPunishmentProcessed := project(File_DOC_Punishment,tDOCtoCrimSrchPunishment(left));

#if(CrimSrch.Switch_ShouldUsePersists = CrimSrch.Switch_YesValue)
export Punishment_Joined
 :=	lPunishmentProcessed
 :	persist('persist::CrimSrch_Punishment_Joined')
 ;
#else
export Punishment_Joined
 :=	lPunishmentProcessed
 ;
#end