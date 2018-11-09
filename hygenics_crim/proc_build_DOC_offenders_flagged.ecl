import /*doxie_build,*/ut,lib_date;

//Flag inmates that are currently incarcerated curr_incar_flag = 'Y' or ''
/*
If the status meets the following criteria:

regexfind('^(ACTIVE|INCARCERATED|IN CUSTODY|INMATE)|LIFE|POPULATION',StringLib.StringToUpperCase(R.cur_stat_inm_desc))) = true
regexfind('^(ACTIVE|INCARCERATED|IN CUSTODY|INMATE)|LIFE|POPULATION',StringLib.StringToUpperCase(R.cur_stat_inm_desc))) = true

and if not blank the act_rel_dt date is greater than todays date (use sch_rel_dt, or ctrl_rel_dt if act_rel_dt date is blank)
then flag as incarcerated.
 
Else if regexfind('^(ACTIVE|INCARCERATED|IN CUSTODY|INMATE)|LIFE|POPULATION',StringLib.StringToUpperCase(R.cur_stat_inm_desc))) = true

And act_rel_dt, sch_rel_dt, or ctrl_rel_dt dates are blank and todays date - process date is <= 30 days and the file is categorized as a full file replace.

Else If the status is null and the act_rel_dt, sch_rel_dt, or ctrl_rel_dt dates are greater than todays date then flag as incarcerated.

Else If the status is null and the act_rel_dt is null and the sch_rel_dt, or ctrl_rel_dt dates are greater than todays date then flag as incarcerated.

These changes will fix the issues found on example line item 2 where the offender is flagged as active but the data has not been updated.

Line item 76 where the status is parole but because of the ctrl_date was greater than todays date it was flagged as incarcerated.  The other flaw exposed by this example is that the actual release date is less than todays date.  The actual release date should be considered before the other two dates.
*/
//vendor_list :=  ['AR','AL','AZ',     'CO','CT','DC','FL','GA',     'HI','IA',     'ID','IL','IN','KS','KY','LA','MD','ME','MI',     'MN','MO','MS','MT','NC','NE','ND','NH','NJ','NM','NV','NY','OH','OK','OR','PA','RI','SC','TN','TX','UT','VA',     'WA','WI','WV'];

	vendor_list :=  ['DB','DA','DD','DF','DH','DG','EQ','DI','DJ','DK','DL','DO','DP','DM','DQ','DN','SB','DR','DS','DU','DT','DV','DW','DZ','EU','DY','DX','EV','EX','EW','EY','EA','EB','EC','ED','EE','EF','EG','EH','EI','EJ','EK','EL','EM','EN','EO','EP','ER','ES','ET',
	                 'WL','WC','WD','WE','WF','WG','WH','WJ','WK','NC','WA','OR','EV','EG','VE','6H','6X','6Z','ZB','6W','10G' ];                                    

						 
//remove the persists before moving the code to prod.
offnd := distribute(hygenics_crim.proc_build_DOC_offenders(/*offender_key in ['1078976657589810636708R2293WF','10184887529313839336WJ']*/),hash(vendor,offender_key)) : persist('persist::Inputoffender' );
//pun 	:= distribute(hygenics_crim.AllPunishments(),hash(vendor,offender_key)): persist('persist::InputPunishment' );
pun 	:= distribute(hygenics_crim.Out_Moxie_DOC_Punishment(/*offender_key in ['1078976657589810636708R2293WF','10184887529313839336WJ']*/),hash(vendor,offender_key))/*: persist('persist::InputPunishment' )*/;
//====================================================================================================================

s_pun := sort(pun(event_dt <> '' or cur_stat_inm_desc <> '' or sch_rel_dt<> '' or ctl_rel_dt<> '' or act_rel_dt<> '' or latest_adm_dt <> '' or
                                    Par_cur_stat_desc <> '' or par_sch_end_dt<> '' or par_st_dt<> '' or par_act_end_dt<> '' or presump_par_rel_dt <> '' or 
																		pro_status <> '' or pro_st_dt <> '' or pro_end_dt <> ''),
              vendor,offender_key,event_dt,punishment_type,local);
//=======================================================================================================
//Basic Logic
//1)For sources in I_Eventdt_vendors,P_Eventdt_vendors get the latest I and P record using the event date and roll them up into one record. 
//2)For Sources 'GA','FL','NY','SC','WI','TN' get the latest record regarless of I or P values using event date
//3)For sources where event date is not fully populated use max date logic.
//4)For sources where event date is being used, If the event date is same and the punishment type is same get the max date values. 
//5)For NY , If the event date is same get the max date regardless of punishment type. 
//=======================================================================================================
//I_Eventdt_vendors := ['FL','GA','ID','IL','IN','KY','MS','NH','NJ','NY','UT',     'RI','SC','WI','TN','MO'] ;
  I_Eventdt_vendors := ['DI','DJ','DM','DQ','DN','DR','DY','EY','EA','ED','EM','DO','EI','EJ','ER','EK','EU','VE','6Z','ZB'] ;

//P_Eventdt_vendors := ['FL','GA','ID','IL','IN','KY','MS'     ,'NJ','NY','UT','VA','RI','SC','WI','TN','MO'] ;
  P_Eventdt_vendors := ['DI','DJ','DM','DQ','DN','DR','DY'     ,'EA','ED','WF'   ,'WJ'   ,'EM','EN','EI','EJ','ER','EK','EU','WD','6H','6X','6Z'] ;
	

// output(s_pun(offender_key IN ['1078976657589810636708R2293WF','10184887529913839336WJ']));
// output(s_pun(offender_key ='1000206412010118501307712948EG10091086/02'));                                      
//output(s_pun(offender_key ='10002425928137075001DO'));
s_pun RollupXform(s_pun L,s_pun R) := TRANSFORM
 
  SELF.cur_stat_inm_desc := MAP ( regexfind('(^EXPIRED$|CLIENT DEAD|VACATED|SUICIDE|DEAD; DEATH|DEATH, DEATH|DECEASED|INACTIVE-DEATH|EXECUTION|DIED|DEATH - [A-Z]* CAUSE)|^(DEATH[ ]*)$|DEATH[ ,]*[0-9]+|^(DEAD[; ]*)$',StringLib.StringToUpperCase(R.cur_stat_inm_desc)) => R.cur_stat_inm_desc,
	                                regexfind('(^EXPIRED$|CLIENT DEAD|VACATED|SUICIDE|DEAD; DEATH|DEATH, DEATH|DECEASED|INACTIVE-DEATH|EXECUTION|DIED|DEATH - [A-Z]* CAUSE)|^(DEATH[ ]*)$|DEATH[ ,]*[0-9]+|^(DEAD[; ]*)$',StringLib.StringToUpperCase(L.cur_stat_inm_desc)) => L.cur_stat_inm_desc,
		
	                               (R.punishment_type = 'I' or R.vendor in ['DJ','DI','ED','EJ','ER','EK','EU']) and 
	                                R.vendor in I_Eventdt_vendors and 
	                                R.event_dt > L.event_dt => R.cur_stat_inm_desc,
																 
																 (L.punishment_type = 'P' and R.punishment_type = 'I' and R.vendor not in ['ED']) and 
	                                R.vendor in P_Eventdt_vendors and 
	                                R.event_dt = L.event_dt   => R.cur_stat_inm_desc,
																 
																 (L.punishment_type = 'I' and R.punishment_type = 'P' and R.vendor  in ['DV']) and 
	                                R.event_dt > L.event_dt   => R.cur_stat_inm_desc,
																 
																 (R.punishment_type = 'I' or R.vendor in ['DJ','DI','ED','EJ','ER','EK','EU']) and 
	                                R.vendor in I_Eventdt_vendors and 
	                                R.event_dt = L.event_dt and 
																 (R.sch_rel_dt > L.sch_rel_dt or 
	                                R.act_rel_dt > L.act_rel_dt or 
																  R.ctl_rel_dt > L.ctl_rel_dt or
																  R.latest_adm_dt > L.latest_adm_dt ) => R.cur_stat_inm_desc,
																 
	                                R.punishment_type = 'I' and
																 (R.sch_rel_dt > L.sch_rel_dt or 
	                                R.act_rel_dt > L.act_rel_dt or 
																  R.ctl_rel_dt > L.ctl_rel_dt or
																  R.latest_adm_dt > L.latest_adm_dt
																 ) => R.cur_stat_inm_desc,
																 
																  R.punishment_type = 'I' and
																 (L.sch_rel_dt    = R.sch_rel_dt or  (L.sch_rel_dt ='' and R.sch_rel_dt ='')) and 
																 (L.act_rel_dt    = R.act_rel_dt or  (L.act_rel_dt ='' and R.act_rel_dt ='')) and 
																 (L.ctl_rel_dt    = R.ctl_rel_dt or  (L.ctl_rel_dt ='' and R.ctl_rel_dt ='')) and 
																 (L.latest_adm_dt = R.latest_adm_dt or  (L.latest_adm_dt ='' and R.latest_adm_dt ='')) and 
																  R.event_dt > L.event_dt     => R.cur_stat_inm_desc,
																 
																  R.punishment_type = 'I' and
																 (L.sch_rel_dt    = R.sch_rel_dt or  (L.sch_rel_dt ='' and R.sch_rel_dt ='')) and 
																 (L.act_rel_dt    = R.act_rel_dt or  (L.act_rel_dt ='' and R.act_rel_dt ='')) and 
																 (L.ctl_rel_dt    = R.ctl_rel_dt or  (L.ctl_rel_dt ='' and R.ctl_rel_dt ='')) and 
																 (L.latest_adm_dt = R.latest_adm_dt or  (L.latest_adm_dt ='' and R.latest_adm_dt ='')) and 
																 R.event_dt = L.event_dt  and L.cur_stat_inm_desc = ''    => R.cur_stat_inm_desc,
																 
																 
																 R.punishment_type = 'I' and
																 (L.sch_rel_dt    = R.sch_rel_dt or  (L.sch_rel_dt ='' and R.sch_rel_dt ='')) and 
																 (L.act_rel_dt    = R.act_rel_dt or  (L.act_rel_dt ='' and R.act_rel_dt ='')) and 
																 (L.ctl_rel_dt    = R.ctl_rel_dt or  (L.ctl_rel_dt ='' and R.ctl_rel_dt ='')) and 
																 (L.latest_adm_dt = R.latest_adm_dt or  (L.latest_adm_dt ='' and R.latest_adm_dt ='')) and 
																 R.event_dt = L.event_dt  and R.cur_stat_inm_desc = ''    => L.cur_stat_inm_desc,
																 
																 L.cur_stat_inm_desc);
													 	 
	SELF.sch_rel_dt        := MAP( (R.punishment_type = 'I' or R.vendor in ['DJ','DI','ED','EJ','ER','EK','EU']) and 
	                               R.vendor in I_Eventdt_vendors and 
	                               R.event_dt > L.event_dt => R.sch_rel_dt,
																 
																(L.punishment_type = 'P' and R.punishment_type = 'I' and R.vendor not in ['ED']) and 
	                               R.vendor in P_Eventdt_vendors and 
	                               R.event_dt = L.event_dt   => R.sch_rel_dt,
																 
																  (L.punishment_type = 'I' and R.punishment_type = 'P' and R.vendor  in ['DV']) and 
	                                R.event_dt > L.event_dt   => R.sch_rel_dt,
																 
	                               (R.punishment_type = 'I' or R.vendor in ['DJ','DI','ED','EJ','ER','EK','EU']) and 
	                               R.vendor in I_Eventdt_vendors and 
	                               R.event_dt = L.event_dt and 
																 R.sch_rel_dt > L.sch_rel_dt => R.sch_rel_dt, 
																 
																 R.punishment_type = 'I' and 
																 R.sch_rel_dt > L.sch_rel_dt => R.sch_rel_dt, 
																 
																 L.sch_rel_dt);
																 
  SELF.latest_adm_dt     := MAP( (R.punishment_type = 'I' or R.vendor in ['DJ','DI','ED','EJ','ER','EK','EU']) and  
	                               R.vendor in I_Eventdt_vendors and 
	                               R.event_dt > L.event_dt => R.latest_adm_dt,
																 
																 (L.punishment_type = 'P' and R.punishment_type = 'I' and R.vendor not in ['ED']) and 
	                               R.vendor in P_Eventdt_vendors and 
	                               R.event_dt = L.event_dt   => R.latest_adm_dt,
																 
																  (L.punishment_type = 'I' and R.punishment_type = 'P' and R.vendor  in ['DV']) and 
	                                R.event_dt > L.event_dt   => R.latest_adm_dt,
	                               
																 (R.punishment_type = 'I' or R.vendor in ['DJ','DI','ED','EJ','ER','EK','EU']) and 
	                               R.vendor in I_Eventdt_vendors and 
	                               R.event_dt = L.event_dt and 
																 R.latest_adm_dt > L.latest_adm_dt => R.latest_adm_dt, 																 
																 
																 R.punishment_type = 'I' and 
																 R.latest_adm_dt > L.latest_adm_dt => R.latest_adm_dt, 
																 
																 L.latest_adm_dt);
																 
	SELF.act_rel_dt        := MAP( (R.punishment_type = 'I' or R.vendor in ['DJ','DI','ED','EJ','ER','EK','EU']) and 
	                               R.vendor in I_Eventdt_vendors and 
	                               R.event_dt > L.event_dt => R.act_rel_dt,
	                               
																 (L.punishment_type = 'P' and R.punishment_type = 'I' and R.vendor not in ['ED'] ) and 
	                               R.vendor in P_Eventdt_vendors and 
	                               R.event_dt = L.event_dt   => R.act_rel_dt,
																 
																 (L.punishment_type = 'I' and R.punishment_type = 'P' and R.vendor  in ['DV']) and 
	                                R.event_dt > L.event_dt   => R.act_rel_dt,
																 
																 (R.punishment_type = 'I' or R.vendor in ['DJ','DI','ED','EJ','ER','EK','EU']) and 
	                               R.vendor in I_Eventdt_vendors and 
	                               R.event_dt = L.event_dt and 
																 R.act_rel_dt > L.act_rel_dt => R.act_rel_dt, 
																 
																 R.punishment_type = 'I' and 
																 R.act_rel_dt > L.act_rel_dt => R.act_rel_dt, 
																 
																 L.act_rel_dt);
																 
	SELF.ctl_rel_dt        := MAP( (R.punishment_type = 'I' or R.vendor in ['DJ','DI','ED','EJ','ER','EK','EU'])  and  //In NY the P records also need to be checked for incar info
	                               R.vendor in I_Eventdt_vendors and 
	                               R.event_dt > L.event_dt => R.ctl_rel_dt,
																 
																 (L.punishment_type = 'P' and R.punishment_type = 'I' and R.vendor not in ['ED']) and 
	                               R.vendor in P_Eventdt_vendors and 
	                               R.event_dt = L.event_dt   => R.ctl_rel_dt,
																 
																  (L.punishment_type = 'I' and R.punishment_type = 'P' and R.vendor  in ['DV']) and 
	                                R.event_dt > L.event_dt   => R.ctl_rel_dt,
	                               
																 (R.punishment_type = 'I' or R.vendor in ['DJ','DI','ED','EJ','ER','EK','EU']) and 
	                               R.vendor in I_Eventdt_vendors and 
	                               R.event_dt = L.event_dt and 
																 R.ctl_rel_dt > L.ctl_rel_dt => R.ctl_rel_dt, 
																 
																 R.punishment_type = 'I' and 
																 R.ctl_rel_dt > L.ctl_rel_dt => R.ctl_rel_dt, 
																 
																 L.ctl_rel_dt);

	SELF.event_dt          := MAP( R.event_dt > L.event_dt => R.event_dt,
																 L.event_dt);																 
																 
	SELF.presump_par_rel_dt:= MAP( (R.punishment_type = 'I' or R.vendor in ['DJ','DI','ED','EJ','ER','EK','EU','WD']) and 
	                               R.vendor in I_Eventdt_vendors and 
	                               R.event_dt > L.event_dt => R.presump_par_rel_dt,
																 
																 (L.punishment_type = 'P' and R.punishment_type = 'I' and R.vendor not in ['ED']) and 
	                               R.vendor in P_Eventdt_vendors and 
	                               R.event_dt = L.event_dt   => R.presump_par_rel_dt,
																 
																  (L.punishment_type = 'I' and R.punishment_type = 'P' and R.vendor  in ['DV']) and 
	                                R.event_dt > L.event_dt   => R.presump_par_rel_dt,
	                               
																 (R.punishment_type = 'I' or R.vendor in ['DJ','DI','ED','EJ','ER','EK','EU']) and 
	                               R.vendor in I_Eventdt_vendors and 
	                               R.event_dt = L.event_dt and 
																 R.presump_par_rel_dt > L.presump_par_rel_dt => R.presump_par_rel_dt, 
																 
																 R.punishment_type = 'I' and 
																 R.presump_par_rel_dt > L.presump_par_rel_dt => R.presump_par_rel_dt, 
																 
																 L.presump_par_rel_dt);																 
	
	SELF.par_cur_stat_desc := MAP( (R.punishment_type = 'P' or R.vendor in ['DJ','DI','ED','EJ','ER','EK','EM','EU','WD']) and 
	                               R.vendor in P_Eventdt_vendors and 
	                               R.event_dt > L.event_dt => R.par_cur_stat_desc,
																 
																 (L.punishment_type = 'I' and R.punishment_type = 'P' and R.vendor not in ['ED']) and 
	                               R.vendor in P_Eventdt_vendors and 
	                               R.event_dt = L.event_dt   => R.par_cur_stat_desc,
																 
																 (L.punishment_type = 'I' and R.vendor in ['DO']) and 
	                                R.event_dt > L.event_dt   => R.par_cur_stat_desc,
																 
																 R.punishment_type = 'I' and
																 (L.par_sch_end_dt = R.par_sch_end_dt or  (L.par_sch_end_dt ='' and R.par_sch_end_dt ='')) and 
																 (L.par_act_end_dt = R.par_act_end_dt or  (L.par_act_end_dt ='' and R.par_act_end_dt ='')) and 
																 (L.par_st_dt      = R.par_st_dt or  (L.par_st_dt ='' and R.par_st_dt ='')) and 
																 R.event_dt = L.event_dt  and L.par_cur_stat_desc = ''    => R.par_cur_stat_desc,
																 
																 
																 R.punishment_type = 'I' and
																 (L.par_sch_end_dt = R.par_sch_end_dt or  (L.par_sch_end_dt ='' and R.par_sch_end_dt ='')) and 
																 (L.par_act_end_dt = R.par_act_end_dt or  (L.par_act_end_dt ='' and R.par_act_end_dt ='')) and 
																 (L.par_st_dt      = R.par_st_dt or  (L.par_st_dt ='' and R.par_st_dt ='')) and 
																 R.event_dt = L.event_dt  and R.par_cur_stat_desc = ''    => L.par_cur_stat_desc,
																 
																 (R.punishment_type = 'P' or R.vendor in ['DJ','DI','ED','EJ','ER','EK','EM','EU','WD']) and 
	                               R.vendor in P_Eventdt_vendors and 
	                               R.event_dt = L.event_dt   and
																 (R.par_sch_end_dt >= L.par_sch_end_dt or 
	                                R.par_act_end_dt >= L.par_act_end_dt or
																  R.par_st_dt      >= L.par_st_dt   	 )   => R.par_cur_stat_desc,
																 
	                               R.punishment_type = 'P' and 
																 (R.par_sch_end_dt >= L.par_sch_end_dt or 
	                                R.par_act_end_dt >= L.par_act_end_dt or
																  R.par_st_dt      >= L.par_st_dt      )   => R.par_cur_stat_desc,
																
																 R.punishment_type = 'P' and 
																 (L.par_sch_end_dt = R.par_sch_end_dt or  (L.par_sch_end_dt ='' and R.par_sch_end_dt ='')) and 
																 (L.par_act_end_dt = R.par_act_end_dt or  (L.par_act_end_dt ='' and R.par_act_end_dt ='')) and 
																 (L.par_st_dt      = R.par_st_dt or  (L.par_st_dt ='' and R.par_st_dt ='')) and 
																 R.event_dt >= L.event_dt           =>R.par_cur_stat_desc,
																
															   L.par_cur_stat_desc);
																 
	SELF.par_st_dt         := MAP ((R.punishment_type = 'P' or R.vendor in ['DJ','DI','ED','EJ','ER','EK','EM','EU','WD']) and 
	                               R.vendor in P_Eventdt_vendors and 
	                               R.event_dt > L.event_dt    => R.par_st_dt,
																 
																 (L.punishment_type = 'I' and R.punishment_type = 'P' and R.vendor not in ['ED']) and 
	                               R.vendor in P_Eventdt_vendors and 
	                               R.event_dt = L.event_dt   => R.par_st_dt,
																 
																 (R.punishment_type = 'P' or R.vendor in ['DJ','DI','ED','EJ','ER','EK','EM','EU','WD']) and 
	                               R.vendor in P_Eventdt_vendors and 
	                               R.event_dt = L.event_dt   and
																 R.par_st_dt >= L.par_st_dt => R.par_st_dt, 
																 
																 R.punishment_type = 'P' and
	                               R.par_st_dt >= L.par_st_dt => R.par_st_dt, 
																 L.par_st_dt);		
																 
  SELF.par_sch_end_dt    := MAP ((R.punishment_type = 'P' or R.vendor in ['DJ','DI','ED','EJ','ER','EK','EM','EU','WD']) and 
	                               R.vendor in P_Eventdt_vendors and 
	                               R.event_dt > L.event_dt              => R.par_sch_end_dt,
																 
																 (L.punishment_type = 'I' and R.punishment_type = 'P' and R.vendor not in ['ED']) and 
	                               R.vendor in P_Eventdt_vendors and 
	                               R.event_dt = L.event_dt   => R.par_sch_end_dt,
																 
																 (R.punishment_type = 'P' or R.vendor in ['DJ','DI','ED','EJ','ER','EK','EM','EU','WD']) and 
	                               R.vendor in P_Eventdt_vendors and 
	                               R.event_dt = L.event_dt   and
																 R.par_sch_end_dt >= L.par_sch_end_dt => R.par_sch_end_dt,
																 
																 R.punishment_type = 'P' and
	                               R.par_sch_end_dt >= L.par_sch_end_dt => R.par_sch_end_dt, 
																 L.par_sch_end_dt);
																 
	SELF.par_act_end_dt    := MAP ((R.punishment_type = 'P' or R.vendor in ['DJ','DI','ED','EJ','ER','EK','EM','EU','WD']) and 
	                               R.vendor in P_Eventdt_vendors and 
	                               R.event_dt > L.event_dt              => R.par_act_end_dt,																 
																 															 
																 (L.punishment_type = 'I' and R.punishment_type = 'P' and R.vendor not in ['ED'] ) and 
	                               R.vendor in P_Eventdt_vendors and 
	                               R.event_dt = L.event_dt   => R.par_act_end_dt,
																 
																 (R.punishment_type = 'P' or R.vendor in ['DJ','DI','	ED','EJ','ER','EK','EM','EU','WD']) and 
	                               R.vendor in P_Eventdt_vendors and 
	                               R.event_dt = L.event_dt   and
																 R.par_act_end_dt >= L.par_act_end_dt => R.par_act_end_dt,
																 
																 R.punishment_type = 'P' and
	                               R.par_act_end_dt >= L.par_act_end_dt => R.par_act_end_dt, 
																 L.par_act_end_dt);


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	SELF.pro_status        := MAP( (R.punishment_type = 'P' or R.vendor in ['DJ','DI','ED','EJ','ER','EK','EM','EU']) and 
	                               R.vendor in P_Eventdt_vendors and 
	                               R.event_dt > L.event_dt => R.pro_status,
																 
																 (L.punishment_type = 'I' and R.punishment_type = 'P' and R.vendor not in ['ED']) and 
	                               R.vendor in P_Eventdt_vendors and 
	                               R.event_dt = L.event_dt   => R.pro_status,
																 
																 (R.punishment_type = 'P' or R.vendor in ['DJ','DI','ED','EJ','ER','EK','EM','EU']) and 
	                               R.vendor in P_Eventdt_vendors and 
	                               R.event_dt = L.event_dt   and
																 (R.par_sch_end_dt >= L.par_sch_end_dt or 
	                                R.par_act_end_dt >= L.par_act_end_dt or
																  R.par_st_dt      >= L.par_st_dt   	 )   => R.pro_status,
																 
	                               R.punishment_type = 'P' and 
																 (R.par_sch_end_dt >= L.par_sch_end_dt or 
	                                R.par_act_end_dt >= L.par_act_end_dt or
																  R.par_st_dt      >= L.par_st_dt      )   => R.pro_status,
																
																 R.punishment_type = 'P' and 
																 R.par_sch_end_dt ='' and R.par_act_end_dt = '' and R.par_st_dt = '' and 
																 L.par_sch_end_dt = '' and L.par_act_end_dt = '' and L.par_st_dt = '' and
																 R.event_dt >= L.event_dt           =>R.pro_status,
																
															   L.pro_status);
																 
	SELF.pro_st_dt         := MAP ((R.punishment_type = 'P' or R.vendor in ['DJ','DI','ED','EJ','ER','EK','EM','EU']) and 
	                               R.vendor in P_Eventdt_vendors and 
	                               R.event_dt > L.event_dt    => R.pro_st_dt,
																 
																 (L.punishment_type = 'I' and R.punishment_type = 'P' and R.vendor not in ['ED']) and 
	                               R.vendor in P_Eventdt_vendors and 
	                               R.event_dt = L.event_dt   => R.pro_st_dt,
																 
																 (R.punishment_type = 'P' or R.vendor in ['DJ','DI','ED','EJ','ER','EK','EM','EU']) and 
	                               R.vendor in P_Eventdt_vendors and 
	                               R.event_dt = L.event_dt   and
																 R.pro_st_dt >= L.pro_st_dt => R.pro_st_dt, 
																 
																 R.punishment_type = 'P' and
	                               R.pro_st_dt >= L.pro_st_dt => R.pro_st_dt, 
																 L.pro_st_dt);		
																 
  SELF.pro_end_dt        := MAP ((R.punishment_type = 'P' or R.vendor in ['DJ','DI','ED','EJ','ER','EK','EM','EU']) and 
	                               R.vendor in P_Eventdt_vendors and 
	                               R.event_dt > L.event_dt              => R.pro_end_dt,
																 
																 (L.punishment_type = 'I' and R.punishment_type = 'P' and R.vendor not in ['ED']) and 
	                               R.vendor in P_Eventdt_vendors and 
	                               R.event_dt = L.event_dt   => R.pro_end_dt,
																 
																 (R.punishment_type = 'P' or R.vendor in ['DJ','DI','ED','EJ','ER','EK','EM','EU']) and 
	                               R.vendor in P_Eventdt_vendors and 
	                               R.event_dt = L.event_dt   and
																 R.pro_end_dt >= L.pro_end_dt => R.pro_end_dt,
																 
																 R.punishment_type = 'P' and
	                               R.pro_end_dt >= L.pro_end_dt => R.pro_end_dt, 
																 L.pro_end_dt);
																 
												 
  SELF := R;
	

END;
R_pun := ROLLUP(s_pun ,
                  LEFT.vendor = RIGHT.vendor and
									LEFT.offender_key = RIGHT.offender_key,
                  RollupXform(LEFT,RIGHT),local) : persist ('~persist::corrections_punishment_rolledup');

                                      
//output(r_pun(offender_key in ['EM0000530490','EM000481091']));
//output(r_pun(offender_key ='10448522296201701763DV'));
//output(r_pun(offender_key ='DI001158'));

//=====states with an ORBIT update type of "full-replace"==============================================================
// set_ffStates := ['AL','AZ','CO','CT','FL','GA','ID','IL','KS','MD','MI','MN','MO','MS','MT',
                 // 'NC','NE','NH','NJ','NV','NY','OH','OK','OR','RI','SC','TN','TX','UT','WI','WV'];

//---------------------------------------------------------------
//For some states we need to look at the party_status_desc field. 
//Set_UsePrtyStat_state := ['AZ','MI','MI_ALT,'MN','ND','NYWEB','OHWEB','WA','OR','SC','TN','WVALT'];
  Set_UsePrtyStat_state := ['DD','DV','DW'   ,'DZ','EW','WF'   ,'WJ'   ,'EP','EG','EJ','EK','ET','6Z','ZB','6W'];
//Set_UsePartyStat_for_Supervision := ['AZ','CT','MI','MI_ALT,'MN','ND','NYWEB','OHWEB','WA','OR','SC','TN','WVALT'];
  Set_UsePartyStat_for_Supervision := ['DD','DG','DV','DW'   ,'DZ','EW','WF'   ,'WJ'   ,'EP','EG','EJ','EK','ET','DQ','6Z','6W'];
offnd trecs(offnd L, R_pun R) := transform

//replaced all process_date logic with check_dt
check_dt := MAP(L.src_upload_date <> '' => L.src_upload_date,L.process_date);
                 
//==================================INCARCERATION =======================================================================
                                          

Inc_StatusRule1  := MAP(// CT has names of the location instead of status in R.cur_stat_inm_desc
                        L.offender_key = R.offender_key and R.vendor ='DG' and  
                        regexfind('PAROLE|PROBATION',StringLib.StringToUpperCase(R.cur_stat_inm_desc)) =false  and
												 ( stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' 0')[1..4] = 'LIFE' OR
												  (unsigned) stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' ')[1..8] > (unsigned)_functions.GetDate OR 
												  (length(trim(stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' ')[1..8])) = 6 AND  
												   (unsigned) stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' ')[1..6] > (unsigned)(_functions.GetDate[1..6] )
												  )
											   ) => '1',
//PRE[-]*RELEASE|
                        L.offender_key = R.offender_key and //R.vendor not in ['DZ'] and
                        regexfind('^(RECEPTION|ACTIVE|[CURRENTLY ]*INCARCERAT.*|INCAR-ICC|INMATE|INITIAL|SENTENCED)|^FUTURE[ ]*$|^IN, ADMISSION|COMMUNITY CORR, INCARCERATEDS|COMMUNITY CORR, LOCAL DETENTION|ERVING SENTENCE|NEW ADMISSION|RESTITUTION RESIDENT|CUSTODY|TEMP RESIDENT|OUT TO COURT|LIFE|POPULATION|CONTROLLING SENTENCE|DEATH.*ROW|DEATH SENTENCE|PRISON|CORRECTION|CONFINEMENT|FEDERAL INMATE|CONVICTED|RECEIVED|RELEASE DATE TO BE SET|PAROLE VIOLAT|CONSECUTIVE|CONCURRENT',StringLib.StringToUpperCase(R.cur_stat_inm_desc)) and
												
												regexfind('(PAROLED|EXPIRED|COMMUNITY SERVICES|UNSENTENCED|RESIDENTIAL|ACTIVE, RID|HOUSE|HOME.*C[UST]*[ONFIN]*|POSTPRISON|ACTIVE.*PAROLE|ACTIVE.*PROBATION)',StringLib.StringToUpperCase(R.cur_stat_inm_desc),0)='' and
								        ( stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' 0')[1..4] = 'LIFE' OR
												  (unsigned) stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' ')[1..8] > (unsigned)_functions.GetDate OR 
												  (length(trim(stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' ')[1..8])) = 6 AND  
												   (unsigned) stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' ')[1..6] > (unsigned)(_functions.GetDate[1..6] )
												  )
											  ) => '1',
												        

//---------------------------------------------------------------------------------------------------------------------------------------------											 
// PRE[-]*RELEASE| Removed this from reg exp for OK. Check which sources have pre_release. 
											  L.offender_key = R.offender_key and 
												((regexfind('^(RECEPTION|ACTIVE|[CURRENTLY ]*INCARCERAT.*|INCAR-ICC|INMATE|INITIAL|SENTENCED)|^IN, ADMISSION|COMMUNITY CORR, INCARCERATED|COMMUNITY CORR, LOCAL DETENTION|SERVING SENTENCE|NEW ADMISSION|RESTITUTION RESIDENT|CUSTODY|TEMP RESIDENT|OUT TO COURT|LIFE|POPULATION|CONTROLLING SENTENCE|DEATH.*ROW|DEATH SENTENCE|PRISON|CORRECTION|CONFINEMENT|FEDERAL INMATE|CONVICTED|RECEIVED|RELEASE DATE TO BE SET|PAROLE VIOLAT|CONSECUTIVE|CONCURRENT',StringLib.StringToUpperCase(R.cur_stat_inm_desc)) and
												  regexfind('(PAROLED|EXPIRED|COMMUNITY SERVICES|UNSENTENCED|RESIDENTIAL|ACTIVE, RID|HOUSE|HOME.*C[UST]*[ONFIN]*|POSTPRISON|ACTIVE.*PAROLE|ACTIVE.*PROBATION)',StringLib.StringToUpperCase(R.cur_stat_inm_desc),0)='' //and 
													//R.vendor not in ['EK'] 
												 ) or
												 (StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) in Lookup_FlagOffender.Incar_lookup and L.vendor in Set_UsePrtyStat_state)
												) and 
								        stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' 0') ='' and
								        //R.vendor in set_ffStates and //all sources are full replace
								        LIB_Date.DaysApart( _functions.GetDate ,check_dt)< 91 => '1',		
//---------------------------------------------------------------------------------------------------------------------------------------------												
											
												L.offender_key <> '' and R.offender_key ='' and 
												StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) in Lookup_FlagOffender.Incar_lookup and L.vendor in Set_UsePrtyStat_state and 
												//L.vendor in set_ffStates and //all sources are full replace
								        LIB_Date.DaysApart( _functions.GetDate ,check_dt)< 91 => '1',
												
										    R.cur_stat_inm_desc = '' => '3',
												'0');
//---------------------------------------------------------------------------------------------------------------------------------------------												
Inc_prtystatRule	 := MAP(L.offender_key <> '' and //R.offender_key ='' and 
												StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) in Lookup_FlagOffender.Incar_lookup and L.vendor in Set_UsePrtyStat_state and 
												//L.vendor in set_ffStates and //all sources are full replace
								        LIB_Date.DaysApart( _functions.GetDate ,check_dt)< 91 => '1',
												
												L.offender_key <> '' and //R.offender_key ='' and 
												StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) in Lookup_FlagOffender.Incar_lookup and L.vendor in Set_UsePrtyStat_state and 
												(stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' 0')[1..4] = 'LIFE' OR
												 (unsigned) stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' ')[1..8] > (unsigned)_functions.GetDate  
												) => '1',
											  
										    
												'0');
//---------------------------------------------------------------------------------------------------------------------------------------------														
							          
												
Inc_DateRule1	 		  := MAP(L.offender_key = R.offender_key and 
                          (R.cur_stat_inm_desc = '' and R.act_rel_dt between _functions.GetDate and '30000000') => '1' ,	
													
											     L.offender_key = R.offender_key and
												   R.cur_stat_inm_desc = '' and trim(R.act_rel_dt) = 'LIFE'  => '1',
													 
													 L.offender_key = R.offender_key and
												   R.cur_stat_inm_desc = '' and trim(R.act_rel_dt) = '99999999' and StringLib.StringToUpperCase(R.sent_length_desc) = 'LIFE'  => '1',
													 
											     R.act_rel_dt = '' => '3',
							             '0');
												
Inc_DateRule2	 		  := MAP( L.offender_key = R.offender_key and R.cur_stat_inm_desc = '' and R.act_rel_dt = '' and R.ctl_rel_dt ='' and
                            R.sch_rel_dt between _functions.GetDate and '30000000' => '1',	
														
														L.offender_key = R.offender_key and R.cur_stat_inm_desc = '' and R.act_rel_dt = '' and R.ctl_rel_dt ='' and
                            trim(R.sch_rel_dt) = 'LIFE'  => '1',
														
														L.offender_key = R.offender_key and R.cur_stat_inm_desc = '' and R.act_rel_dt = '' and R.ctl_rel_dt ='' and
												    trim(R.sch_rel_dt) = '99999999' and StringLib.StringToUpperCase(R.sent_length_desc) = 'LIFE'  => '1',
							              
														R.sch_rel_dt = '' => '3',
							              '0');
												
Inc_DateRule3	 		  := MAP( L.offender_key = R.offender_key and R.cur_stat_inm_desc = '' and R.act_rel_dt = '' and 
                            R.ctl_rel_dt between _functions.GetDate and '30000000' => '1',
														
														L.offender_key = R.offender_key and R.cur_stat_inm_desc = '' and R.act_rel_dt = '' and 
                            trim(R.ctl_rel_dt) = 'LIFE' => '1',
							              
														
														L.offender_key = R.offender_key and R.cur_stat_inm_desc = '' and R.act_rel_dt = '' and  
												    trim(R.ctl_rel_dt) = '99999999' and StringLib.StringToUpperCase(R.sent_length_desc) = 'LIFE'  => '1',
														
												    R.ctl_rel_dt = '' => '3',
							              '0');
                          // added for HI and NH WEB. Checked the website when all the other fields are null and par_st_dt is in future then status is INC  
Inc_DateRule4	 		  := MAP( R.vendor IN ['DL','WD'] and L.offender_key = R.offender_key and R.cur_stat_inm_desc = '' and R.act_rel_dt = '' and R.ctl_rel_dt ='' and R.sch_rel_dt ='' and
                            R.par_st_dt > _functions.GetDate and R.par_st_dt < '30000000' => '1',
														
												    R.par_st_dt = '' => '3',
							              '0');

           
												
//Rule to identify 'Not Incarcerated'
inc_No_Rule     := MAP(((L.offender_key = R.offender_key and 
											   (regexfind('(^EXPIRED$|CLIENT DEAD|VACATED|DEAD; DEATH|DEATH - ACCIDENTAL|DEATH BY INMATE|SUICIDE|DEATH, DEATH|DECEASED|INACTIVE-DEATH|EXECUTION|DIED|DEATH - [A-Z]* CAUSE)|^(DEATH[ ]*)$|DEATH[ ,]*[0-9]+|^(DEAD[; ]*)$',StringLib.StringToUpperCase(R.cur_stat_inm_desc)) OR
											    regexfind('(SUICIDE|DECEASED|INACTIVE-DEATH|EXECUTION|DEAD; DEATH|DIED|DEATH - UNKNOWN CAUSE)|^(DEATH[ ]*)$|^(DEAD[; ]*)$',StringLib.StringToUpperCase(R.par_cur_stat_desc)))
												) OR
												  regexfind('(^EXPIRED$|SUICIDE|CLIENT DEAD|DECEASED|FUGITIVE|INACTIVE-DEATH|EXECUTION|DEAD; DEATH|DIED|DEATH - UNKNOWN CAUSE)|^(DEATH[ ]*)$|DEATH[ ,]*[0-9]+|^(DEAD[; ]*)$',StringLib.StringToUpperCase(L.party_status_desc)) 
											 ) => 'D',
//---------------------------------------------------------------------------------------------------------------------------------------------
                       ((L.offender_key = R.offender_key and 
											   ( (regexfind('(^EXPIRED$|VACATED|REL. C/S|ESCAPE|ABSCOND)',StringLib.StringToUpperCase(R.cur_stat_inm_desc)) and
                                      (~regexfind('(RETURN|IN[- ]*CUSTODY)',StringLib.StringToUpperCase(R.cur_stat_inm_desc)))) OR
											   
												   (regexfind('(ESCAPE|ABSCONDE)',StringLib.StringToUpperCase(R.par_cur_stat_desc)) and
                            (~regexfind('(RETURN|IN[- ]*CUSTODY)',StringLib.StringToUpperCase(R.par_cur_stat_desc))))
												 )
												) OR
												 (regexfind('(ESCAPE|ABSCONDE|FUGITIVE)',StringLib.StringToUpperCase(L.party_status_desc)) and
												  (~regexfind('(RETURN|IN[- ]*CUSTODY)',StringLib.StringToUpperCase(L.party_status_desc)))) 
											 ) and 
											 
											 //R.vendor in set_ffStates and //all sources are full replace
								       LIB_Date.DaysApart( _functions.GetDate ,check_dt)< 91 => 'D',
//---------------------------------------------------------------------------------------------------------------------------------------------

                       L.offender_key = R.offender_key and 
                       ((regexfind('^(RELEASE[ ]*)$|^EXPIRED$|^DI[ ]*$|^DI, ABSC[ ]*$|^DI, ADMISSION|^PO[ ]*$|^PO, ABSC[ ]*$|^PO, ADMISSION|VACATED|REL. C/S|ALT[-ERNATIVE ]*SECURE|FURLOUGH|(POSTPRISON|DEPORTED|EXPIRED|PARDONED|AUTH ABSENCE (AWL)|ISC|MANDATORY SUPERVISION|INTERSTATE COMPACT|SFII-SUPERVISED FURL.II|[CONDITIONAL]*[EARLY]* RELEASE|INACTV|INACTIVE|RELEASED|HOME.*C[UST]*[ONFIN]*|DISCHARGED|OUT TO COURT|PAROLE|ESCAPE|EXPIR.*[SENT]*.*[EXP]*|ON PAROLE|DECEASED|ABSCONDE|POST INCARCERATION|SERVING IN ABSENTIA|INTENSIVE SUPERVISION|ACTIVE, ERS|GOVERNOR SUSPENS|HOUSE ARREST)',StringLib.StringToUpperCase(R.cur_stat_inm_desc)) and
											   regexfind('DISCHARGE FROM PROBATION|DISCHARGE FROM PAROLE',StringLib.StringToUpperCase(R.cur_stat_inm_desc),0) = ''
												) OR
											   regexfind('(SUSPENDED SENTENCE|EXPIRATION OF SENTENCE)',StringLib.StringToUpperCase(R.par_cur_stat_desc),0) <> ''
      						     ) and
								       stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' 0') <> '' and 
											 R.act_rel_dt <> '88888888' and
											 ((unsigned) stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' ')[1..8] <= (unsigned)_functions.GetDate OR 
												  (length(trim(stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' ')[1..8])) = 6 AND  
												   (unsigned) stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' ')[1..6] <= (unsigned)(_functions.GetDate[1..6] )
												  )
											 ) => '2',										 
											 
//---------------------------------------------------------------------------------------------------------------------------------------------
                       // The dates are <= today
											  L.offender_key = R.offender_key and 
											 regexfind('DISCHARGE FROM PROBATION|DISCHARGE FROM PAROLE',StringLib.StringToUpperCase(R.cur_stat_inm_desc),0) = '' and
											 (stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' 0') <> '' and 
							  			 (unsigned) stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' ')[1..8] <= (unsigned)_functions.GetDate) => '2' ,
//---------------------------------------------------------------------------------------------------------------------------------------------			
                       // CT has names of the location instead of status in R.cur_stat_inm_desc
                        L.offender_key = R.offender_key and R.vendor ='DG' and  
                        regexfind('PAROLE|PROBATION',StringLib.StringToUpperCase(R.cur_stat_inm_desc)) =false  and
												 stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' 0') <> '' and   R.act_rel_dt <> '88888888' and
											 ((unsigned) stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' ')[1..8] <= (unsigned)_functions.GetDate OR 
												  (length(trim(stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' ')[1..8])) = 6 AND  
												   (unsigned) stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' ')[1..6] <= (unsigned)(_functions.GetDate[1..6] )
												  )
											 )=> '2',
//--------------------------------------------------------------------------------------------------------------------------------------------------------								 
											 //The dates empty, so look for the values in (party status or cur_stat_inm_desc) and the process date should not be older than 91. 
											 L.offender_key = R.offender_key and 
											 ((StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) in Lookup_FlagOffender.not_Incar_lookup and L.vendor in Set_UsePrtyStat_state) or
											  (regexfind('^(RELEASE[ ]*)$|^DI[ ]*$|^DI, ABSC[ ]*$|^DI, ADMISSION|^PO[ ]*$|^PO, ABSC[ ]*$|^PO, ADMISSION|VACATED|REL. C/S|ALT[-ERNATIVE ]*SECURE|FURLOUGH|(POSTPRISON|DEPORTED|PARDONED|AUTH ABSENCE (AWL)|ISC|ALTERNATIVE SECURE|INTERSTATE COMPACT|SFII-SUPERVISED FURL.II|[CONDITIONAL]*[EARLY]* RELEASE|INACTV|INACTIVE|RELEASED|HOME.*C[UST]*[ONFIN]*|DISCHARGE|OUT TO COURT|EXPIR.*[SENT]*.*[EXP]*|OUT TO COURT|POST INCARCERATION|SERVING IN ABSENTIA|INTENSIVE SUPERVISION)',StringLib.StringToUpperCase(R.cur_stat_inm_desc))  and 
												 regexfind('DISCHARGE FROM PROBATION|DISCHARGE FROM PAROLE',StringLib.StringToUpperCase(R.cur_stat_inm_desc),0) = '' and 
												 R.vendor not in ['EK']
												)) and 
								        ( stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' 0') =''  or R.act_rel_dt = '88888888' ) and
								        //R.vendor in set_ffStates and //all sources are full replace
								        LIB_Date.DaysApart( _functions.GetDate ,check_dt)< 91 => '2',
//---------------------------------------------------------------------------------------------------------------------------------------------												
												//Punishment record does not exists so use the party_status_desc and the process date should not be older than 91.
												L.offender_key <> '' and R.offender_key ='' and 
												StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) in Lookup_FlagOffender.not_Incar_lookup and L.vendor in Set_UsePrtyStat_state and 
												//L.vendor in set_ffStates and ////all sources are full replace
								        LIB_Date.DaysApart( _functions.GetDate ,check_dt)< 91 => '2',
//---------------------------------------------------------------------------------------------------------------------------------												
												// Added for HI and LA Parole
												L.offender_key = R.offender_key and R.cur_stat_inm_desc = '' and R.act_rel_dt = '' and R.ctl_rel_dt ='' and R.sch_rel_dt ='' and
                        R.par_st_dt <> '' and R.par_st_dt <= _functions.GetDate => '2',
														
											  '3');
                                          

//==================================\PAROLE=======================================================================				
Par_StatusRule1 :=  MAP(  L.offender_key = R.offender_key and 
                        ((regexfind('^(ACTIVE, PAROLE|PAROLE|ON PAROLE)|PAR/HOME CONFINEMENT|^PA[ ]*$|^PA, ABSC[ ]*$|^PA, ADMISSION',StringLib.StringToUpperCase(R.cur_stat_inm_desc)) AND 
												  regexfind('(EXPIRED|DISCHARGED|HOLD|VIOLAT|REVOK)',StringLib.StringToUpperCase(R.cur_stat_inm_desc),0)=''
												 )  OR
												 (regexfind('^(ACTIVE, PAROLE|ACTIVE|ON PAROLE|WORK RELEASE|SUPERVISED RELEASE)|PAROLE|RELEASE TO PAR|MS COMPACT-OUT OF STATE, PAROLE|SUPERVISING OFFICER',StringLib.StringToUpperCase(R.par_cur_stat_desc)) 
												  
												 ) Or 
												 (StringLib.StringToUpperCase(trim(L.party_status_desc,left,right))in Lookup_FlagOffender.Par_lookup and L.vendor in Set_UsePartyStat_for_Supervision
												 ) or
												 R.Par_cur_stat ='P') and                                                                                                           
												 regexfind('(EXPIRED|DISCHARGED|DEPORTED|PAR HEARING TYPE|DEATH NOT VERIFIED|INDETERMINATE|PENDING ARRIVAL|INACTIVE|IN CUSTODY|EXPIRATION|ABSCONDER|DISCH.*[FROM]*[BY]*.*PAR|PRESUMPTIVE|VIOLAT|RELEASE FROM PAROLE|TERMINATED|ARREST DATE WHILE ON PAROLE:)',StringLib.StringToUpperCase(R.par_cur_stat_desc),0) = '' and
                        (unsigned) stringlib.stringfilterout(R.par_act_end_dt+R.Par_sch_end_dt,' ')[1..8] > (unsigned)_functions.GetDate => '1',
								
				
//---------------------------------------------------------------------------------------------------------------------------------------------												
												  
													L.offender_key = R.offender_key and 
												 ((regexfind('^(ACTIVE, PAROLE|PAROLE|ON PAROLE)|PAR/HOME CONFINEMENT|^PA[ ]*$|^PA, ABSC[ ]*$|^PA, ADMISSION',StringLib.StringToUpperCase(R.cur_stat_inm_desc)) AND 
												   regexfind('(EXPIRED|DISCHARGED|HOLD|VIOLAT|REVOK)',StringLib.StringToUpperCase(R.cur_stat_inm_desc),0)='' 
												  ) OR
													regexfind('^(ACTIVE, PAROLE|ACTIVE|ON PAROLE|WORK RELEASE|SUPERVISED RELEASE)|PAROLE|RELEASE TO PAR|MS COMPACT-OUT OF STATE, PAROLE',StringLib.StringToUpperCase(R.par_cur_stat_desc)) Or 
												  (StringLib.StringToUpperCase(trim(L.party_status_desc,left,right))in Lookup_FlagOffender.Par_lookup and L.vendor in Set_UsePartyStat_for_Supervision
												  ) or
						  					  R.Par_cur_stat ='P'
												 )  and 
												 regexfind('(HEARING ACTION: SERVE OUT, NEXT PAROLE ELIGIBILITY|HEARING ACTION: PAROLE RECOMMENDED|DECLINED PAROLE|PAROLE REVOKED|EXPIRED|DISCHARGED|DEPORTED|PAR HEARING TYPE|DEATH NOT VERIFIED|INDETERMINATE|PENDING ARRIVAL|INACTIVE|IN CUSTODY|EXPIRATION|DISCH.*[FROM]*[BY]*.*PAR|PRESUMPTIVE|VIOLAT|RELEASE FROM PAROLE|PAROLE LENGTH MAY ALSO BE PROBATION LENGTH.  SOURC|TERMINATED)',StringLib.StringToUpperCase(R.par_cur_stat_desc),0) = '' and
												 stringlib.stringfilterout(R.par_act_end_dt+R.Par_sch_end_dt,' 0') = '' and
								         //R.vendor in set_ffStates and  // all sources are full replace
												 LIB_Date.DaysApart( _functions.GetDate ,check_dt)< 91 => '1',
//---------------------------------------------------------------------------------------------------------------------------------------------												 
												 L.offender_key <> '' and R.offender_key ='' and 
												 StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) in Lookup_FlagOffender.Par_lookup and L.vendor in Set_UsePartyStat_for_Supervision and 
												 //L.vendor in set_ffStates and ////all sources are full replace
								         LIB_Date.DaysApart( _functions.GetDate ,check_dt)< 91 => '1',
												
												 '0');		
Par_DateRule1	 	:= MAP(L.offender_key = R.offender_key and R.par_st_dt = '' and 
                         R.par_cur_stat_desc = '' and R.par_act_end_dt between _functions.GetDate and '30000000' => '1' ,	
                       L.offender_key = R.offender_key and R.par_st_dt <= _functions.GetDate and 
                         R.par_cur_stat_desc = '' and R.par_act_end_dt between _functions.GetDate and '30000000' => '1' ,	
							         '0');
												
Par_DateRule2	 	:= MAP(L.offender_key = R.offender_key and 
                         R.par_cur_stat_desc = '' and R.par_act_end_dt = ''  and R.par_st_dt = '' and 
                         R.Par_sch_end_dt between _functions.GetDate and '30000000' => '1',	
                       L.offender_key = R.offender_key and 
                         R.par_cur_stat_desc = '' and R.par_act_end_dt = ''  and R.par_st_dt <= _functions.GetDate and
                         R.Par_sch_end_dt between _functions.GetDate and '30000000' => '1',	
							         '0');			
														
Par_dateRule3  := MAP( L.offender_key = R.offender_key and 
                        R.par_cur_stat_desc = '' and R.par_act_end_dt = '' and R.par_st_dt <> '' and 
                        R.par_st_dt <= _functions.GetDate   and LIB_Date.DaysApart( _functions.GetDate ,check_dt)< 91  => '1',
							          '0');		
												
Par_No_Rule    := MAP( L.offender_key = R.offender_key and 
                        (regexfind('^(PAROLE|ON PAROLE)|PAROLE; EXPIRED|PAROLE; DISCHARGED|^PS[ ]*$|^PS, ABSC[ ]*|^PS, ADMISSION|^PS, CMPO[ ]*$|^PS, IMMI[ ]*$|^PS, INAC[ ]*$|^PS, REVP[ ]*$|^PS, UNSU[ ]*$',StringLib.StringToUpperCase(R.cur_stat_inm_desc)) OR
												 regexfind('^(PAROLE REVOKED|DECLINED|PAROLE VIOLAT|ACTIVE|INACTIVE|RELEASED)|PAROLE|EXPIRATION|DISCHARGE|DISCH.*FROM.*PAR|RELEASE.*FROM PAROLE|TERMINATED.*PAROLE',StringLib.StringToUpperCase(R.par_cur_stat_desc)) Or 
												(StringLib.StringToUpperCase(trim(L.party_status_desc,left,right))in Lookup_FlagOffender.Par_lookup and L.vendor in Set_UsePartyStat_for_Supervision
												   ) or
												 R.Par_cur_stat ='P') and 
												 regexfind('(PRESUMPTIVE|MAXIMUM EXPIRATION|RELEASED TO )',StringLib.StringToUpperCase(R.par_cur_stat_desc),0) = '' and
												 stringlib.stringfilterout(R.par_act_end_dt+R.Par_sch_end_dt,' 0') <> '' and 
                        (unsigned) stringlib.stringfilterout(R.par_act_end_dt+R.Par_sch_end_dt,' ')[1..8] <= (unsigned)_functions.GetDate => '2',
//---------------------------------------------------------------------------------------------------------------------------------------------												
                        L.offender_key = R.offender_key and 
											  (regexfind('(PAROLE REVOKED|PAROLE; EXPIRED|PAROLE; DISCHARGED|DEPORTED|PAROLE VIOLAT)|^PS[ ]*$|^PS, ABSC[ ]*|^PS, ADMISSION|^PS, CMPO[ ]*$|^PS, IMMI[ ]*$|^PS, INAC[ ]*$|^PS, REVP[ ]*$|^PS, UNSU[ ]*$',StringLib.StringToUpperCase(R.cur_stat_inm_desc)) OR
												 regexfind('(PAROLE REVOKED|DECLINED|DEPORTED|PAROLE VIOLAT|INACTIVE|EXPIRATION|DISCH.*FROM.*PAR|RELEASED|RELEASE.*FROM PAROLE|TERMINATED.*PAROLE)',StringLib.StringToUpperCase(R.par_cur_stat_desc),0) <> '' or
												(StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) in Lookup_FlagOffender.not_Par_lookup and L.vendor in Set_UsePartyStat_for_Supervision)) and
												regexfind('(PRESUMPTIVE|MAXIMUM EXPIRATION|RELEASED TO)',StringLib.StringToUpperCase(R.par_cur_stat_desc),0) = '' and
												stringlib.stringfilterout(R.par_act_end_dt+R.Par_sch_end_dt,' 0') ='' and
								        //R.vendor in set_ffStates and ////all sources are full replace
								        LIB_Date.DaysApart( _functions.GetDate ,check_dt)< 91 => '2',
												
											 (stringlib.stringfilterout(R.par_act_end_dt+R.Par_sch_end_dt,' 0') <> '' and 
							  			 (unsigned) stringlib.stringfilterout(R.par_act_end_dt+R.Par_sch_end_dt,' ')[1..8] <= (unsigned)_functions.GetDate) => '2' ,
//---------------------------------------------------------------------------------------------------------------------------------------------									 
											 	L.offender_key <> '' and R.offender_key ='' and 
												StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) in Lookup_FlagOffender.not_Par_lookup and L.vendor in Set_UsePartyStat_for_Supervision and 
												//L.vendor in set_ffStates and //all sources are full replace
								        LIB_Date.DaysApart( _functions.GetDate ,check_dt)< 91 => '2',
												
											 '3');   														            



//==================================\PROBATION=======================================================================
prob_StatusRule1 	:=  MAP( L.offender_key = R.offender_key and 
                           Regexfind('^(PROBATION[ ]*)|^CD[ ]$|^CD, ABSC[ ]*$|^CD, ADMISSION|^PR[ ]*$|^PR, ABSC[ ]*$|^PR, ADMISSION|COMMUNITY CORR, UNDER SUPERVISION BY|COMMUNITY SUPERVISION|ACTIVE, PROBATION|STRAIGHT PROBATION|UNSUPERVISED PROBATION|RELEASED TO PROBATION|DISCHARGE TO PROBATION',StringLib.StringToUpperCase(R.cur_stat_inm_desc)) and
													 Regexfind('(EXPIRED|INACTIVE|EXPIRATION|ABSCONDER|PROBATION DISCHARGED|DISCHARGE FROM|REVOK)',StringLib.StringToUpperCase(R.cur_stat_inm_desc),0) ='' and 
													 stringlib.stringfilterout(R.pro_end_dt,' 0') <> ''  and
													 (unsigned) stringlib.stringfilterout(R.pro_end_dt,' ')[1..8] > (unsigned)_functions.GetDate =>'1',

//-------------------------------------------------------------------------------------------------------------------------------------------------
                           L.offender_key = R.offender_key and 
                           Regexfind('^(PROBATION[ ]*)|ACTIVE|COMMUNITY CORR, UNDER SUPERVISION BY|COMMUNITY SUPERVISION|ACTIVE, PROBATION|SPLIT SENTENCE|STRAIGHT PROBATION|UNSUPERVISED PROBATION|RELEASED TO [SHOCK ]*PROBATION|DISCHARGE TO PROBATION|MS COMPACT-OUT OF STATE, PROBATION',StringLib.StringToUpperCase(R.pro_status)) and
													 Regexfind('(EXPIRED|INACTIVE|EXPIRATION|ABSCONDER|PROBATION DISCHARGED|DISCHARGE FROM|REVOK)',StringLib.StringToUpperCase(R.cur_stat_inm_desc),0) ='' and 
													 stringlib.stringfilterout(R.pro_end_dt,' 0') <> ''  and
													 (unsigned) stringlib.stringfilterout(R.pro_end_dt,' ')[1..8] > (unsigned)_functions.GetDate =>'1',
//---------------------------------------------------------------------------------------------------------------------------------------------
									 
                           L.offender_key = R.offender_key and 
													 ((regexfind('^(COMMUNITY CORR, UNDER SUPERVISION BY|OUT-OF-STATE PROBATION|ACTIVE, PROBATION|STRAIGHT PROBATION|UNSUPERVISED PROBATION|STRAIGHT PROBATION-NO PRISON|RELEASED TO PROBATION|DISCHARGE TO PROBATION)|^(PROBATION[ ]*)$',StringLib.StringToUpperCase(R.par_cur_stat_desc)) and
														 regexfind('(EXPIRED|INACTIVE|EXPIRATION|ABSCONDER|DISCHARGE|REVOK)',StringLib.StringToUpperCase(R.par_cur_stat_desc),0) = '' 
													  )OR
													  (StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) in Lookup_FlagOffender.Prob_lookup and L.vendor in Set_UsePartyStat_for_Supervision) 
													 )and 
													 (unsigned) stringlib.stringfilterout(R.pro_end_dt,' ')[1..8] > (unsigned)_functions.GetDate => '1',
													
//---------------------------------------------------------------------------------------------------------------------------------------------
												   L.offender_key = R.offender_key and 
												  ((regexfind('^(ACTIVE|COMMUNITY CORR, UNDER SUPERVISION BY|OUT-OF-STATE PROBATION|ACTIVE, PROBATION|STRAIGHT PROBATION|UNSUPERVISED PROBATION|STRAIGHT PROBATION-NO PRISON|RELEASED TO PROBATION|COMMUNITY SUPERVISION)|^(PROBATION[ ]*)$',StringLib.StringToUpperCase(R.pro_status)) and
														regexfind('(EXPIRED|INACTIVE|EXPIRATION|ABSCONDER|DISCHARGE)',StringLib.StringToUpperCase(R.pro_status),0) = '' 
													 ) OR
													 (Regexfind('^(COMMUNITY CORR, UNDER SUPERVISION BY|PROBATION[ ]*|ACTIVE, PROBATION|STRAIGHT PROBATION|UNSUPERVISED PROBATION|RELEASED TO PROBATION|DISCHARGE TO PROBATION|COMMUNITY SUPERVISION)|^CD[ ]*$|^CD, ABSC[ ]*$|^CD, ADMISSION|^PR[ ]*$|^PR, ABSC[ ]*$|^PR, ADMISSION',StringLib.StringToUpperCase(R.cur_stat_inm_desc)) and
													  Regexfind('(EXPIRED|INACTIVE|EXPIRATION|ABSCONDER|PROBATION DISCHARGED|DISCHARGE FROM|REVOK)',StringLib.StringToUpperCase(R.cur_stat_inm_desc),0) ='' /*and
													  stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' 0') =''*/
													 )  OR
													 (regexfind('^(COMMUNITY CORR, UNDER SUPERVISION BY|OUT-OF-STATE PROBATION|ACTIVE, PROBATION|UNSUPERVISED PROBATION|STRAIGHT PROBATION|RELEASED TO PROBATION|COMMUNITY SUPERVISION)|^(PROBATION[ ]*)$',StringLib.StringToUpperCase(R.par_cur_stat_desc)) and
														regexfind('(INACTIVE|EXPIRATION|ABSCONDER|DISCHARGE)',StringLib.StringToUpperCase(R.par_cur_stat_desc),0) = '' 
													 ) OR
													 
													 (StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) in Lookup_FlagOffender.Prob_lookup and L.vendor in Set_UsePartyStat_for_Supervision) 
													) and 
													 
													 //stringlib.stringfilterout(R.par_act_end_dt+R.Par_sch_end_dt,' 0') = ''   and
													 stringlib.stringfilterout(R.pro_end_dt,' 0') = ''   and
								           //R.vendor in set_ffStates and //all sources are full replace
													 LIB_Date.DaysApart( _functions.GetDate ,check_dt)< 91 => '1',
//---------------------------------------------------------------------------------------------------------------------------------------------													 
													L.offender_key <> '' and R.offender_key ='' and 
												  StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) in Lookup_FlagOffender.Prob_lookup and L.vendor in Set_UsePartyStat_for_Supervision and 
												  //L.vendor in set_ffStates and //all sources are full replace
								          LIB_Date.DaysApart( _functions.GetDate ,check_dt)< 91 => '1', 
				
							            '0');
													
Prob_No_Rule      :=  MAP( L.offender_key = R.offender_key and 
                           Regexfind('^(PROBATION[ ]*|STRAIGHT PROBATION|INACTIVE PROBATION.*PAROLE|DISCHARGE FROM PROBATION|PROBATION DISCHARGED)',StringLib.StringToUpperCase(R.cur_stat_inm_desc)) and
													 
													 stringlib.stringfilterout(R.pro_end_dt,' 0') <> ''  and
													 (unsigned) stringlib.stringfilterout(R.pro_end_dt,' ')[1..8] <= (unsigned)_functions.GetDate =>'2',
//---------------------------------------------------------------------------------------------------------------------------------------------
									         L.offender_key = R.offender_key and 
													 ((regexfind('^(OUT-OF-STATE PROBATION|SPLIT SENTENCE|DISCHARGE FROM PROBATION|ACTIVE, PROBATION|RELEASED TO PROBATION|STRAIGHT PROBATION|PROBATION DISCHARGED|STRAIGHT PROBATION-NO PRISON|INACTIVE|INACTIVE PROBATION/PAROLE)|^(PROBATION[ ]*)$',StringLib.StringToUpperCase(R.pro_status)) 
													  )OR
													  (StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) in Lookup_FlagOffender.Prob_lookup and L.vendor in Set_UsePartyStat_for_Supervision) 
													 )and 
													 stringlib.stringfilterout(R.pro_end_dt,' 0') <> ''  and
													 (unsigned)stringlib.stringfilterout(R.pro_end_dt,' ')[1..8] <= (unsigned)_functions.GetDate => '2',
													 
//---------------------------------------------------------------------------------------------------------------------------------------------
                           L.offender_key = R.offender_key and 
													 ((regexfind('^(OUT-OF-STATE PROBATION|STRAIGHT PROBATION|PROBATION DISCHARGED|STRAIGHT PROBATION-NO PRISON|INACTIVE PROBATION/PAROLE)|^(PROBATION[ ]*)$',StringLib.StringToUpperCase(R.par_cur_stat_desc)) 
													  )OR
													  (StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) in Lookup_FlagOffender.Prob_lookup and L.vendor in Set_UsePartyStat_for_Supervision) 
													 )and 
													 stringlib.stringfilterout(R.pro_end_dt,' 0') <> ''  and
													 (unsigned)stringlib.stringfilterout(R.pro_end_dt,' ')[1..8] <= (unsigned)_functions.GetDate => '2',
													 
//---------------------------------------------------------------------------------------------------------------------------------------------

													L.offender_key = R.offender_key and 
													( (regexfind('^(INACTIVE|INACTIVE PROBATION.*PAROLE|PROBATION DISCHARGED|PROBATION REVOKED|PROBATION EXPIR|PROBATION REVOK|DISCHARGE FROM PROBATION)',StringLib.StringToUpperCase(R.pro_status)) and
													   stringlib.stringfilterout(R.pro_end_dt,' 0') ='' 
														)or
														(regexfind('^(INACTIVE PROBATION.*PAROLE|PROBATION DISCHARGED|PROBATION REVOKED|PROBATION EXPIR|PROBATION REVOK|DISCHARGE FROM PROBATION)',StringLib.StringToUpperCase(R.cur_stat_inm_desc)) and
													   stringlib.stringfilterout(R.pro_end_dt,' 0') ='' 
														)or
													  regexfind('^(INACTIVE PROBATION.*PAROLE|PROBATION DISCHARGED|PROBATION REVOKED|PROBATION EXPIR|PROBATION REVOK|DISCHARGE FROM PROBATION)',StringLib.StringToUpperCase(R.par_cur_stat_desc)) OR													 
													 (StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) in Lookup_FlagOffender.not_Prob_lookup  and L.vendor in Set_UsePartyStat_for_Supervision)
 												  ) and 
													  stringlib.stringfilterout(R.pro_end_dt,' 0') = ''  and
													
								          //R.vendor in set_ffStates and //all sources are full replace
													LIB_Date.DaysApart( _functions.GetDate ,check_dt)< 91 => '2',
										
//---------------------------------------------------------------------------------------------------------------------------------------------													 
													L.offender_key <> '' and R.offender_key ='' and 
												  StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) in Lookup_FlagOffender.not_Prob_lookup and L.vendor in Set_UsePartyStat_for_Supervision and 
												  //L.vendor in set_ffStates and //all sources are full replace
								          LIB_Date.DaysApart( _functions.GetDate ,check_dt) < 91 => '2', 
													
													'3'	);
//-------------------------------------------------------------------------------------------------------------------------													

string curr_incar_flag	:=  MAP( Inc_No_Rule = 'D' => 'N',

																 L.vendor ='6W' and Inc_prtystatRule ='1' => 'Y',
																 
                                 L.vendor ='DZ' and Inc_prtystatRule ='1' => 'Y',
																 
																 L.vendor ='DZ' and Inc_prtystatRule ='0' and  Inc_No_Rule = '2' =>'N',
																 L.vendor ='DZ' and Inc_prtystatRule ='0' => 'U',
																 
																 // OK Violent off reg 
           											 L.vendor ='ZB' and Inc_prtystatRule ='1' => 'Y',
																 
                                 //IA - cur_inm is null and prob_status is populated 
																   L.vendor ='DO' and R.cur_stat_inm_desc = '' and R.pro_status = 'PROBATION' and 
																	 (Inc_DateRule1 = '1' or Inc_DateRule2 = '1' or Inc_DateRule3 = '1' ) => 'N',																 
																 
																 //IL
																 L.vendor ='DQ' and R.par_st_dt <> '' and R.par_st_dt <= _functions.GetDate and 
																 (Inc_StatusRule1 = '1' or  Inc_DateRule1 = '1' or Inc_DateRule2 = '1' or Inc_DateRule3 = '1' or Inc_DateRule4 ='1') => 'N' ,
                                 
																 //ND = EW //checked the website, dates are not accurate and neither is party_status is.
																 //L.vendor ='EW' and Inc_prtystatRule ='1' => 'Y',
																 //L.vendor ='EW' and Inc_prtystatRule ='0' => 'N',
																   L.vendor ='EW' => 'U', 
																 //MS -dates are messed up - need to ask HD
																 //  L.vendor ='DY' => 'U',
																																		 
                                 // MO ->EU. When the punishment type =P the act and sch dates cannot be used even though they are populated. 
																 // Pro status is populated but website says parole/prob so prob and parole flags are set to 'U'
																 // Pro status is populated but website says parole/prob so prob and parole flags are set to 'U'
                                  L.vendor = 'EU' and R.punishment_type <>  'I' and (Inc_StatusRule1 = '1' or  Inc_DateRule1 = '1' or Inc_DateRule2 = '1' or Inc_DateRule3 = '1' or Inc_DateRule4 ='1') => 'N' ,
																	
                                 (Inc_StatusRule1 = '1' or  Inc_DateRule1 = '1' or Inc_DateRule2 = '1' or Inc_DateRule3 = '1' or Inc_DateRule4 ='1') => 'Y' ,
                                 
																 L.vendor ='WF' and Inc_prtystatRule ='1' and stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' 0') =''=> 'Y',		
																 L.vendor ='WJ' and Inc_prtystatRule ='1' and stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' 0') ='' => 'Y',	
																 Inc_No_Rule = '2' =>'N',
                                 'U');						
																 
string Parole_flag	    :=  MAP( Inc_No_Rule     = 'D' => 'N',
                                 Par_StatusRule1 = '1' or Par_DateRule1 = '1' or  Par_DateRule2 = '1' or Par_dateRule3 = '1' => 'Y',
                                 Par_No_Rule     = '2' => 'N',
							                   'U');
															 													
string Prob_flag	      :=  MAP( Inc_No_Rule      = 'D' => 'N',

                                 //IA - cur_inm is null and prob_status is populated //checked website
																   L.vendor ='DO' and R.cur_stat_inm_desc = '' and Prob_StatusRule1 = '1' and 
																	 (Inc_DateRule1 = '1' or Inc_DateRule2 = '1' or Inc_DateRule3 = '1' ) => 'Y',
																	 
                                 Prob_StatusRule1 = '1' => 'Y',
                                 Prob_No_Rule     = '2' => 'N',
                                 'U');		
																
//--------------------------------------------------------------------------------------------																
self.curr_incar_flag	   :=IF(L.vendor not in vendor_list,'',
                               MAP( 
															      L.vendor = 'DJ' => 'U', //remove this once GA data becomes current
																		//L.vendor = 'DO' => 'U', //remove this once DO data becomes current. Need to research with hygenics
																		L.vendor = 'DW' => 'U', //remove this once MI ALT data becomes current
                                    L.vendor IN [ 'DL','DT','EP','EN','DR','ES'] => 'U',															      
																		L.vendor = 'DH' and curr_incar_flag ='Y' and Parole_flag = 'Y' and  //checked the website sch_release_dt = Est. Sentence end date, not necessarily the date he was released from prison.
															      R.cur_stat_inm_desc = '' => 'N',
																		
															      L.vendor = 'DD' and curr_incar_flag ='Y' and Parole_flag = 'Y' 
																		/*and 
															      R.punishment_type = 'P'*/ => 'U',
																		
																		//GA DOC WEB Only party status is useful
																     L.vendor ='VE' and LIB_Date.DaysApart( _functions.GetDate ,check_dt) < 91 and
																		 regexfind('^ACTIVE',L.party_status_desc)  => 'Y',	
																		
																		 L.vendor ='VE' and LIB_Date.DaysApart( _functions.GetDate ,check_dt) < 91 and
																		(StringLib.Stringfind(L.party_status_desc,'^INACTIVE',1) >0  or 
                                     StringLib.Stringfind(L.party_status_desc,'PAROLE',1) >0  )  => 'N',
																    //L.vendor ='VE' and L.party_status_desc ='' => 'U',	
																		
																		//NC checked the website. Only party status is useful
																    L.vendor ='EV' and LIB_Date.DaysApart( _functions.GetDate ,check_dt) < 91 and
																		regexfind('^ACTIVE',L.party_status_desc)  => 'Y',	
																		
																		L.vendor ='EV' and LIB_Date.DaysApart( _functions.GetDate ,check_dt) < 91 and
																		StringLib.Stringfind(L.party_status_desc,'INACTIVE',1) >0  => 'N',
																    L.vendor ='EV' and L.party_status_desc ='' => 'U',	
																		
																		//FL checked the website. party status needs to be checked as well
																    L.vendor ='DI' and curr_incar_flag ='Y' and L.party_status_desc <> '' and 
																		StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) in Lookup_FlagOffender.not_Incar_lookup => 'N',
																		
																		L.vendor ='DI' and curr_incar_flag ='N' and L.party_status_desc <> '' and
																		StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) in Lookup_FlagOffender.Incar_lookup => 'U ',
																    
																    L.vendor ='DQ' and curr_incar_flag ='Y' and L.party_status_desc <> '' and
																		StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) not in Lookup_FlagOffender.Incar_lookup => 'N',
																    
																		L.vendor = 'EY' and curr_incar_flag ='Y' and Parole_flag = 'Y' => 'U', //EY=NH
																		
																		//L.vendor = 'EB' and curr_incar_flag ='Y' and Parole_flag = 'Y' => 'U', //EB=NM																		
																		//L.vendor = 'EK' and curr_incar_flag ='Y' and Parole_flag = 'Y' => 'U', 
																		L.vendor = 'EK' and curr_incar_flag ='Y' and StringLib.StringToUpperCase(trim(R.cur_stat_inm_desc,left,right)) IN ['DISCHARGED','ISC'] => 'U',	
																		
																		//ET =WV Alt. If dt say Inc and status says inc then inc = Y
																		L.vendor = 'ET' and curr_incar_flag ='Y' and L.party_status_desc <> '' and
																		StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) in Lookup_FlagOffender.Incar_lookup => 'Y',				
																		//ET =WV Alt. If dt say Inc and status says no then inc = U
																		L.vendor = 'ET' and curr_incar_flag ='Y' and L.party_status_desc <> '' and
																		StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) not in Lookup_FlagOffender.Incar_lookup => 'U',
																		
                                    //DV =MI . If dt say Inc and status says inc then inc = Y
																		L.vendor = 'DV' and curr_incar_flag ='Y' and L.party_status_desc <> '' and
																		StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) in Lookup_FlagOffender.Incar_lookup => 'Y',				
																		//ET =MI. If dt say Inc and status says no then inc = U
																		L.vendor = 'DV' and curr_incar_flag ='Y' and L.party_status_desc <> '' and
																		StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) not in Lookup_FlagOffender.Incar_lookup => 'U',
																		
																		//MS -dates are messed up - need to ask HD
																    //L.vendor ='DY' => 'U',																		
																		L.vendor = 'ED' => 'U', //remove this once NY data becomes current
																		//L.vendor = 'ER' => 'U', //remove this once WI data becomes current
																		//L.vendor = 'EV' =>'U',
																		L.vendor = 'EF' =>'U',
																		L.vendor = 'EM' =>'U',//UT data old
																		L.vendor = 'EQ' =>'U',//DC data old
																		L.vendor = 'WG' =>'U',//NCWEB data old

																		Parole_flag = 'Y'  and curr_incar_flag = 'Y'   => 'U',
																		curr_incar_flag ='Y' and Prob_flag = 'Y' => 'U',
																		
																		curr_incar_flag = 'Y' => 'Y',
                                    curr_incar_flag = 'N' => 'N',
														        
																		Parole_flag = 'Y' or Prob_flag ='Y' =>'N',
														        'U')
															);	
self.curr_parole_flag    := IF(L.vendor not in vendor_list,'',
                               MAP( 
															 
															      L.vendor = 'DJ' => 'U', //remove this once GA data becomes current
																		//L.vendor = 'DO' => 'U', //remove this once DO data becomes current. Need to research with hygenics
                                    L.vendor = 'DW' => 'U', //remove this once MI ALT data becomes current															 
                                    L.vendor IN [ 'DL','DT','EP','EN','DR','ES'] => 'U',															     
																	  L.vendor = 'DH' and curr_incar_flag ='Y' and Parole_flag = 'Y' and  //checked the website sch_release_dt = Est. Sentence end date, not necessarily the date he was released from prison.
															      R.cur_stat_inm_desc = '' => 'Y',

																		//GA DOC WEB Only party status is useful
																    L.vendor ='VE' and LIB_Date.DaysApart( _functions.GetDate ,check_dt) < 91 and
																		(regexfind('^ACTIVE',L.party_status_desc)  or 
																		 StringLib.Stringfind(L.party_status_desc,'^INACTIVE',1) >0) => 'N',	
																		
																		L.vendor ='VE' and LIB_Date.DaysApart( _functions.GetDate ,check_dt) < 91 and
																		(StringLib.Stringfind(L.party_status_desc,'PAROLE',1) >0 )  => 'Y',	
																		
																		//NC checked the website. Only party status is useful
																    L.vendor ='EV' and LIB_Date.DaysApart( _functions.GetDate ,check_dt) < 91 and
																		StringLib.Stringfind(L.party_status_desc,'PAROLE,',1) >0 => 'Y',
                                    																	
																		L.vendor ='EV' and LIB_Date.DaysApart( _functions.GetDate ,check_dt) < 91 and
																		StringLib.Stringfind(L.party_status_desc,'PAROLE,',1) =0 and 
																		Prob_flag <> 'Y' and curr_incar_flag <> 'Y' => 'U',	
																		L.vendor ='EV' and L.party_status_desc ='' => 'U',																			
																		
															      L.vendor = 'DD' and curr_incar_flag ='Y' and Parole_flag = 'Y' //and 
															      /*R.punishment_type = 'P'*/ => 'U',//DD =AZ
																		L.vendor = 'EY' and curr_incar_flag ='Y' and Parole_flag = 'Y' => 'U', //EY=NH
																		//L.vendor = 'EB' and curr_incar_flag ='Y' and Parole_flag = 'Y' => 'U', //EB=NM
																		L.vendor ='DI' and curr_incar_flag ='Y' and L.party_status_desc <> '' and
																		StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) in Lookup_FlagOffender.Incar_lookup => 'N',
																    L.vendor ='DI' => parole_flag,
																		
																		
																    L.vendor ='DQ' and curr_incar_flag ='Y' and Parole_flag = 'Y' and L.party_status_desc <> '' and
																		StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) not in Lookup_FlagOffender.Incar_lookup => 'Y',
																    L.vendor ='DQ' and curr_incar_flag ='Y' and  L.party_status_desc <> '' and L.party_status_desc <> '' and
																		StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) in Lookup_FlagOffender.Incar_lookup => 'N',
																    L.vendor ='DQ' => parole_flag,
																		
																		//L.vendor = 'EK' and curr_incar_flag ='Y' and Parole_flag = 'Y' => 'U',	
																		L.vendor = 'EK' and Parole_flag = 'Y' and L.party_status_desc <> '' and
																		StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) = 'INACTIVE PAROLE' => 'U',
																		L.vendor = 'EK' and curr_incar_flag ='Y' and L.party_status_desc <> '' and
																		StringLib.StringToUpperCase(trim(R.cur_stat_inm_desc,left,right)) IN ['DISCHARGED','ISC'] => Parole_flag ,	
																		
																		
																		// KY DOC WEB If Parole and party status says inc then it is not parole. 
																		L.vendor = 'ET' and Parole_flag ='Y' and L.party_status_desc <> '' and
																		StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) in Lookup_FlagOffender.Incar_lookup => 'N',
																		
																		//ET =WV Alt. If dt say Inc and status says no then inc = U
																		L.vendor = 'ET' and curr_incar_flag ='Y' and L.party_status_desc <> '' and
																		StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) not in Lookup_FlagOffender.Incar_lookup => Parole_flag,
																		//act_par_rel > today and sch_rel_dt > today then not sure if it is parole.
																		L.vendor = 'ET' and curr_incar_flag ='Y' and Parole_flag ='Y' => 'U',
																		
																		
																		
																		// If dates say Parole and party status says inc then it is not parole. 
																		L.vendor = 'ET' and Parole_flag ='Y' and L.party_status_desc <> '' and
																		StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) in Lookup_FlagOffender.Incar_lookup => 'N',
																		
																		//ET =WV Alt. If dt say Inc and status says no then inc = U
																		L.vendor = 'ET' and curr_incar_flag ='Y' and L.party_status_desc <> '' and
																		StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) not in Lookup_FlagOffender.Incar_lookup => Parole_flag,
																		//act_par_rel > today and sch_rel_dt > today then not sure if it is parole.
																		L.vendor = 'ET' and curr_incar_flag ='Y' and Parole_flag ='Y' => 'U',
																		
                                   //ET =MI. If dt say Inc and status says no then inc = U
																		L.vendor = 'DV' and curr_incar_flag ='Y' and L.party_status_desc <> '' and
																		StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) not in Lookup_FlagOffender.Incar_lookup => parole_flag,
																		
																		//MS -dates are messed up - need to ask HD
																    //L.vendor ='DY' => 'U',																				
																		L.vendor = 'ED' => 'U', //remove this once NY data becomes current
																		//L.vendor = 'ER' => 'U', //remove this once WI data becomes current
																		//L.vendor = 'EV' =>'U',
																		L.vendor = 'EF' =>'U',
																		L.vendor = 'EM' =>'U',
																		L.vendor = 'EQ' =>'U',
																		L.vendor = 'WG'  =>'U',//NCWEB data old
																		L.vendor = 'WD' and curr_incar_flag ='Y' and Parole_flag = 'Y' => 'U',
																		
                                    Parole_flag = 'Y'  and Prob_flag = 'Y' => 'U' ,																		
																		curr_incar_flag ='Y' and Parole_flag = 'Y' => 'U',																		
																		
															      Parole_flag = 'Y' => 'Y',
                                    Parole_flag = 'N' => 'N',
													          curr_incar_flag ='Y' or Prob_flag ='Y' =>'N',
													          'U')
														  );		
self.curr_probation_flag := IF(L.vendor not in vendor_list,'',
                               MAP( 
															      L.vendor = 'DJ' => 'U', //remove this once GA data becomes current
																		//L.vendor = 'DO' => 'U', //remove this once DO data becomes current. Need to research with hygenics
																		L.vendor = 'DW' => 'U', //remove this once MI ALT data becomes current
                                    L.vendor IN [ 'DL','DT','EP','EN','DR','ES'] => 'U',															      
																		L.vendor = 'DP'	and LIB_Date.DaysApart( _functions.GetDate ,check_dt) < 91 => 'Y',
																	
                                    //GA DOC WEB Only party status is useful
																    L.vendor ='VE' and LIB_Date.DaysApart( _functions.GetDate ,check_dt) < 91 and
																		(regexfind('^ACTIVE',L.party_status_desc)  or 
																		 StringLib.Stringfind(L.party_status_desc,'^INACTIVE',1) >0) => 'N',	
																		
																		L.vendor ='VE' and LIB_Date.DaysApart( _functions.GetDate ,check_dt) < 91 and
																		(StringLib.Stringfind(L.party_status_desc,'PROBATION',1) >0 )  => 'Y',
																		
																    //NC checked the website. Only party status is useful
																    L.vendor ='EV' and LIB_Date.DaysApart( _functions.GetDate ,check_dt) < 91 and
																		StringLib.Stringfind(L.party_status_desc,'PROBATION,',1) >0 => 'Y',																	
                                    
                                    L.vendor ='EV' and LIB_Date.DaysApart( _functions.GetDate ,check_dt) < 91 and
																		StringLib.Stringfind(L.party_status_desc,'PROBATION,',1) =0 and 
																		Parole_flag <> 'Y' and curr_incar_flag <> 'Y' => 'U',																		
																	  L.vendor ='EV' and L.party_status_desc ='' => 'U',																	
																	
															      L.vendor = 'EK' and curr_incar_flag ='Y' and Parole_flag = 'Y' => 'U', //EK =TN
																		L.vendor = 'EK' and curr_incar_flag ='Y' and L.party_status_desc <> '' and
																		StringLib.StringToUpperCase(trim(R.cur_stat_inm_desc,left,right)) IN ['DISCHARGED','ISC'] => Parole_flag,	
															      
																		L.vendor ='DQ' and curr_incar_flag ='Y' and Prob_flag = 'Y' and L.party_status_desc <> '' and
																		StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) not in Lookup_FlagOffender.Incar_lookup => 'Y',
																    L.vendor ='DQ' and curr_incar_flag ='Y' and  L.party_status_desc <> '' and
																		StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) not in Lookup_FlagOffender.Incar_lookup => Prob_flag,
																    
																		//MS -dates are messed up - need to ask HD
																    //L.vendor ='DY' => 'U',
																		L.vendor = 'ED' => 'U', //remove this once NY data becomes current
																		//L.vendor = 'ER' => 'U', //remove this once WI data becomes current
																		//L.vendor = 'EV' =>'U',
																		L.vendor = 'EF' =>'U',
																		L.vendor = 'EM' =>'U',
																		L.vendor = 'EQ' =>'U',
                                    L.vendor = 'WG'  =>'U',//NCWEB data old
																		
																		Parole_flag = 'Y'  and Prob_flag = 'Y'   => 'U',
																		curr_incar_flag ='Y' and Prob_flag = 'Y' => 'U',
																		
																		Prob_flag = 'Y' => 'Y',
			                              Prob_flag = 'N' => 'N',
													          Parole_flag = 'Y' or curr_incar_flag ='Y' =>'N',
                                    'U')
															);	
self := L;


end;

flaggedRecs := join(offnd,R_pun,
				            left.offender_key = right.offender_key,
				            trecs(left,right),left outer,local):persist('~thor400_20::persist::offenders_flagged');
										//ut.MAC_SF_BuildProcess(flaggedRecs,'~thor_Data400::base::corrections_offenders_' + buildstate,outOffnd,2);
										//ut.MAC_SF_BuildProcess(pun,'~thor_data400::base::corrections_punishment_' + buildstate,outPun,2);

export proc_build_DOC_offenders_flagged:= flaggedRecs;
                    //sequential(outOffnd
										//,outPun);
								