import PromoteSupers, doxie_build, hygenics_crim;

	recordof(Punishment_Joined) tr_rightPadDates(Punishment_Joined l) := transform  //DF-28911
	
	self.process_date := hygenics_crim._functions.rightPadDate(l.process_date);	
	self.event_dt := hygenics_crim._functions.rightPadDate(l.event_dt);	
	self.sent_date := hygenics_crim._functions.rightPadDate(l.sent_date);	
	self.cur_sec_class_dt := hygenics_crim._functions.rightPadDate(l.cur_sec_class_dt);	
	self.gain_time_eff_dt := hygenics_crim._functions.rightPadDate(l.gain_time_eff_dt);	
	self.latest_adm_dt := hygenics_crim._functions.rightPadDate(l.latest_adm_dt);	
	self.sch_rel_dt := hygenics_crim._functions.rightPadDate(l.sch_rel_dt);	
	self.act_rel_dt := hygenics_crim._functions.rightPadDate(l.act_rel_dt);	
	self.ctl_rel_dt := hygenics_crim._functions.rightPadDate(l.ctl_rel_dt);	
	self.presump_par_rel_dt := hygenics_crim._functions.rightPadDate(l.presump_par_rel_dt);	
	self.mutl_part_pgm_dt := hygenics_crim._functions.rightPadDate(l.mutl_part_pgm_dt);	
	self.par_status_dt := hygenics_crim._functions.rightPadDate(l.par_status_dt);	
	self.par_st_dt := hygenics_crim._functions.rightPadDate(l.par_st_dt);	
	self.par_sch_end_dt := hygenics_crim._functions.rightPadDate(l.par_sch_end_dt);	
	self.par_act_end_dt := hygenics_crim._functions.rightPadDate(l.par_act_end_dt);	
	self.pro_st_dt := hygenics_crim._functions.rightPadDate(l.pro_st_dt);	
  self.pro_end_dt := hygenics_crim._functions.rightPadDate(l.pro_end_dt);	
	self.conviction_override_date := hygenics_crim._functions.rightPadDate(l.conviction_override_date);	
	self.fcra_date := hygenics_crim._functions.rightPadDate(l.fcra_date);	
  self := l;
  end;
	
	pad_dates_Punishment_Joined := PROJECT(Punishment_Joined,tr_rightPadDates(left));

//PromoteSupers.MAC_SF_BuildProcess(Punishment_Joined,'~thor_data400::base::corrections_punishment_' + doxie_build.buildstate, outPun, 2, , true);

PromoteSupers.MAC_SF_BuildProcess(pad_dates_Punishment_Joined,'~thor_data400::base::corrections_punishment_' + doxie_build.buildstate, outPun, 2, , true); //DF-28911

export Out_Punishment := outPun;