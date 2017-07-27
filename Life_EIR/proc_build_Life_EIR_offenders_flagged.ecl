import doxie_build,ut,lib_date,Corrections;

export proc_build_Life_EIR_offenders_flagged(dataset(Corrections.layout_offender) infile):= function

//Flag inmates that are currently incarcerated curr_incar_flag = 'Y' or ''
/*
If the status meets the following criteria:

regexfind('^(ACTIVE|INCARCERATED|IN CUSTODY|INMATE)|LIFE|POPULATION',StringLib.StringToUpperCase(R.cur_stat_inm_desc))) = true

and if not blank the act_rel_dt date is greater than today’s date (use sch_rel_dt, or ctrl_rel_dt if act_rel_dt date is blank)

then flag as incarcerated.

 
 
Else if regexfind('^(ACTIVE|INCARCERATED|IN CUSTODY|INMATE)|LIFE|POPULATION',StringLib.StringToUpperCase(R.cur_stat_inm_desc))) = true

And act_rel_dt, sch_rel_dt, or ctrl_rel_dt dates are blank and today’s date - process date is <= 30 days and the file is categorized as a full file replace.

 

Else If the status is null and the act_rel_dt, sch_rel_dt, or ctrl_rel_dt dates are greater than today’s date then flag as incarcerated.

 

Else If the status is null and the act_rel_dt is null and the sch_rel_dt, or ctrl_rel_dt dates are greater than today’s date then flag as incarcerated.

 

These changes will fix the issues found on example line item 2 where the offender is flagged as active but the data has not been updated.

Line item 76 where the status is parole but because of the ctrl_date was greater than today’s date it was flagged as incarcerated.  The other flaw exposed by this example is that the actual release date is less than today’s date.  The actual release date should be considered before the other two dates.
*/
vendor_list :=  ['AR','AL','AZ','CO','CT','DC','FL','GA','IA','ID','IL','IN','KS','KY','LA','MD','ME','MI','MN','MO','MS','MT','NC','NE','NH','NJ','NM','NV','NY','OH','OK','OR','PA','RI','SC','TN','TX','UT','VA','WA','WI','WV'];
//'CO','LA','MD','NY','OR', 
//vendor_list :=  ['AR','AL','AZ','CO','CT','DC','FL','GA','IA','ID','IL','IN','KS','KY','LA','MD','ME','MI','MN','MO','MS','MT','NC','NE','NH','NJ','NM','NV','NY','OH','OK','OR','PA','RI','SC','TN','TX','UT','VA','WA','WI','WV'];
//remove the persists before moving the code to prod.
offnd := distribute(infile,hash(vendor,offender_key)) ;//: persist('persist::Inputoffender' );
pun 	:= distribute(doxie_build.proc_build_DOC_punishment(),hash(vendor,offender_key));//: persist('persist::InputPunishment' );
//====================================================================================================================

s_pun := sort(pun,vendor,offender_key,event_dt,punishment_type,local);
//=======================================================================================================
//Basic Logic
//1)For sources in I_Eventdt_vendors,P_Eventdt_vendors get the latest I and P record using the event date and roll them up into one record. 
//2)For Sources 'GA','FL','NY','SC','WI','TN' get the latest record regarless of I or P values using event date
//3)For sources where event date is not fully populated use max date logic.
//4)For sources where event date is being used, If the event date is same and the punishment type is same get the max date values. 
//5)For NY , If the event date is same get the max date regardless of punishment type. 
//=======================================================================================================
I_Eventdt_vendors := ['FL','GA','ID','IL','IN','KY','MS','NH','NJ','NY','UT',     'WI','RI','SC','WI','TN','MO'] ;
P_Eventdt_vendors := ['FL','GA','ID','IL','IN','KY','MS'     ,'NJ','NY','UT','VA','WI','RI','SC','WI','TN','MO'] ;

s_pun RollupXform(s_pun L,s_pun R) := TRANSFORM
 
  SELF.cur_stat_inm_desc := MAP ((R.punishment_type = 'I' or R.vendor in ['GA','FL','NY','SC','WI','TN','MO']) and 
	                               R.vendor in I_Eventdt_vendors and 
	                               R.event_dt > L.event_dt => R.cur_stat_inm_desc,
																 
																 (L.punishment_type = 'P' and R.punishment_type = 'I' and R.vendor not in ['NY']) and 
	                               R.vendor in P_Eventdt_vendors and 
	                               R.event_dt = L.event_dt   => R.cur_stat_inm_desc,
																 
																 (R.punishment_type = 'I' or R.vendor in ['GA','FL','NY','SC','WI','TN','MO']) and 
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
																 R.sch_rel_dt= '' and R.act_rel_dt ='' and R.ctl_rel_dt ='' and R.latest_adm_dt ='' and
																 L.sch_rel_dt='' and L.act_rel_dt ='' and L.ctl_rel_dt ='' and  L.latest_adm_dt='' and 
																 R.event_dt >= L.event_dt     => R.cur_stat_inm_desc,
																 
																 L.cur_stat_inm_desc);
													 	 
	SELF.sch_rel_dt        := MAP( (R.punishment_type = 'I' or R.vendor in ['GA','FL','NY','SC','WI','TN','MO']) and 
	                               R.vendor in I_Eventdt_vendors and 
	                               R.event_dt > L.event_dt => R.sch_rel_dt,
																 
																(L.punishment_type = 'P' and R.punishment_type = 'I' and R.vendor not in ['NY']) and 
	                               R.vendor in P_Eventdt_vendors and 
	                               R.event_dt = L.event_dt   => R.sch_rel_dt,
																 
	                               (R.punishment_type = 'I' or R.vendor in ['GA','FL','NY','SC','WI','TN','MO']) and 
	                               R.vendor in I_Eventdt_vendors and 
	                               R.event_dt = L.event_dt and 
																 R.sch_rel_dt > L.sch_rel_dt => R.sch_rel_dt, 
																 
																 R.punishment_type = 'I' and 
																 R.sch_rel_dt > L.sch_rel_dt => R.sch_rel_dt, 
																 
																 L.sch_rel_dt);
																 
  SELF.latest_adm_dt     := MAP( (R.punishment_type = 'I' or R.vendor in ['GA','FL','NY','SC','WI','TN','MO']) and  
	                               R.vendor in I_Eventdt_vendors and 
	                               R.event_dt > L.event_dt => R.latest_adm_dt,
																 
																 (L.punishment_type = 'P' and R.punishment_type = 'I' and R.vendor not in ['NY']) and 
	                               R.vendor in P_Eventdt_vendors and 
	                               R.event_dt = L.event_dt   => R.latest_adm_dt,
	                               
																 (R.punishment_type = 'I' or R.vendor in ['GA','FL','NY','SC','WI','TN','MO']) and 
	                               R.vendor in I_Eventdt_vendors and 
	                               R.event_dt = L.event_dt and 
																 R.latest_adm_dt > L.latest_adm_dt => R.latest_adm_dt, 																 
																 
																 R.punishment_type = 'I' and 
																 R.latest_adm_dt > L.latest_adm_dt => R.latest_adm_dt, 
																 
																 L.latest_adm_dt);
																 
	SELF.act_rel_dt        := MAP( (R.punishment_type = 'I' or R.vendor in ['GA','FL','NY','SC','WI','TN','MO']) and 
	                               R.vendor in I_Eventdt_vendors and 
	                               R.event_dt > L.event_dt => R.act_rel_dt,
	                               
																 (L.punishment_type = 'P' and R.punishment_type = 'I' and R.vendor not in ['NY'] ) and 
	                               R.vendor in P_Eventdt_vendors and 
	                               R.event_dt = L.event_dt   => R.act_rel_dt,
																 
																 (R.punishment_type = 'I' or R.vendor in ['GA','FL','NY','SC','WI','TN','MO']) and 
	                               R.vendor in I_Eventdt_vendors and 
	                               R.event_dt = L.event_dt and 
																 R.act_rel_dt > L.act_rel_dt => R.act_rel_dt, 
																 
																 R.punishment_type = 'I' and 
																 R.act_rel_dt > L.act_rel_dt => R.act_rel_dt, 
																 
																 L.act_rel_dt);
																 
	SELF.ctl_rel_dt        := MAP( (R.punishment_type = 'I' or R.vendor in ['GA','FL','NY','SC','WI','TN','MO'])  and  //In NY the P records also need to be checked for incar info
	                               R.vendor in I_Eventdt_vendors and 
	                               R.event_dt > L.event_dt => R.ctl_rel_dt,
																 
																 (L.punishment_type = 'P' and R.punishment_type = 'I' and R.vendor not in ['NY']) and 
	                               R.vendor in P_Eventdt_vendors and 
	                               R.event_dt = L.event_dt   => R.ctl_rel_dt,
	                               
																 (R.punishment_type = 'I' or R.vendor in ['GA','FL','NY','SC','WI','TN','MO']) and 
	                               R.vendor in I_Eventdt_vendors and 
	                               R.event_dt = L.event_dt and 
																 R.ctl_rel_dt > L.ctl_rel_dt => R.ctl_rel_dt, 
																 
																 R.punishment_type = 'I' and 
																 R.ctl_rel_dt > L.ctl_rel_dt => R.ctl_rel_dt, 
																 
																 L.ctl_rel_dt);

	SELF.event_dt          := MAP( R.event_dt > L.event_dt => R.event_dt,
																 L.event_dt);																 
																 
	SELF.presump_par_rel_dt:= MAP( (R.punishment_type = 'I' or R.vendor in ['GA','FL','NY','SC','WI','TN','MO']) and 
	                               R.vendor in I_Eventdt_vendors and 
	                               R.event_dt > L.event_dt => R.presump_par_rel_dt,
																 
																 (L.punishment_type = 'P' and R.punishment_type = 'I' and R.vendor not in ['NY']) and 
	                               R.vendor in P_Eventdt_vendors and 
	                               R.event_dt = L.event_dt   => R.presump_par_rel_dt,
	                               
																 (R.punishment_type = 'I' or R.vendor in ['GA','FL','NY','SC','WI','TN','MO']) and 
	                               R.vendor in I_Eventdt_vendors and 
	                               R.event_dt = L.event_dt and 
																 R.presump_par_rel_dt > L.presump_par_rel_dt => R.presump_par_rel_dt, 
																 
																 R.punishment_type = 'I' and 
																 R.presump_par_rel_dt > L.presump_par_rel_dt => R.presump_par_rel_dt, 
																 
																 L.presump_par_rel_dt);																 
	
	SELF.par_cur_stat_desc := MAP( (R.punishment_type = 'P' or R.vendor in ['GA','FL','NY','SC','WI','TN','UT','MO']) and 
	                               R.vendor in P_Eventdt_vendors and 
	                               R.event_dt > L.event_dt => R.par_cur_stat_desc,
																 
																 (L.punishment_type = 'I' and R.punishment_type = 'P' and R.vendor not in ['NY']) and 
	                               R.vendor in P_Eventdt_vendors and 
	                               R.event_dt = L.event_dt   => R.par_cur_stat_desc,
																 
																 (R.punishment_type = 'P' or R.vendor in ['GA','FL','NY','SC','WI','TN','UT','MO']) and 
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
																 R.par_sch_end_dt ='' and R.par_act_end_dt = '' and R.par_st_dt = '' and 
																 L.par_sch_end_dt = '' and L.par_act_end_dt = '' and L.par_st_dt = '' and
																 R.event_dt >= L.event_dt           =>R.par_cur_stat_desc,
																
															   L.par_cur_stat_desc);
																 
	SELF.par_st_dt         := MAP ((R.punishment_type = 'P' or R.vendor in ['GA','FL','NY','SC','WI','TN','UT','MO']) and 
	                               R.vendor in P_Eventdt_vendors and 
	                               R.event_dt > L.event_dt    => R.par_st_dt,
																 
																 (L.punishment_type = 'I' and R.punishment_type = 'P' and R.vendor not in ['NY']) and 
	                               R.vendor in P_Eventdt_vendors and 
	                               R.event_dt = L.event_dt   => R.par_st_dt,
																 
																 (R.punishment_type = 'P' or R.vendor in ['GA','FL','NY','SC','WI','TN','UT','MO']) and 
	                               R.vendor in P_Eventdt_vendors and 
	                               R.event_dt = L.event_dt   and
																 R.par_st_dt >= L.par_st_dt => R.par_st_dt, 
																 
																 R.punishment_type = 'P' and
	                               R.par_st_dt >= L.par_st_dt => R.par_st_dt, 
																 L.par_st_dt);		
																 
  SELF.par_sch_end_dt    := MAP ((R.punishment_type = 'P' or R.vendor in ['GA','FL','NY','SC','WI','TN','UT','MO']) and 
	                               R.vendor in P_Eventdt_vendors and 
	                               R.event_dt > L.event_dt              => R.par_sch_end_dt,
																 
																 (L.punishment_type = 'I' and R.punishment_type = 'P' and R.vendor not in ['NY']) and 
	                               R.vendor in P_Eventdt_vendors and 
	                               R.event_dt = L.event_dt   => R.par_sch_end_dt,
																 
																 (R.punishment_type = 'P' or R.vendor in ['GA','FL','NY','SC','WI','TN','UT','MO']) and 
	                               R.vendor in P_Eventdt_vendors and 
	                               R.event_dt = L.event_dt   and
																 R.par_sch_end_dt >= L.par_sch_end_dt => R.par_sch_end_dt,
																 
																 R.punishment_type = 'P' and
	                               R.par_sch_end_dt >= L.par_sch_end_dt => R.par_sch_end_dt, 
																 L.par_sch_end_dt);
																 
	SELF.par_act_end_dt    := MAP ((R.punishment_type = 'P' or R.vendor in ['GA','FL','NY','SC','WI','TN','UT','MO']) and 
	                               R.vendor in P_Eventdt_vendors and 
	                               R.event_dt > L.event_dt              => R.par_act_end_dt,																 
																 															 
																 (L.punishment_type = 'I' and R.punishment_type = 'P' and R.vendor not in ['NY'] ) and 
	                               R.vendor in P_Eventdt_vendors and 
	                               R.event_dt = L.event_dt   => R.par_act_end_dt,
																 
																 (R.punishment_type = 'P' or R.vendor in ['GA','FL','NY','SC','WI','TN','UT','MO']) and 
	                               R.vendor in P_Eventdt_vendors and 
	                               R.event_dt = L.event_dt   and
																 R.par_act_end_dt >= L.par_act_end_dt => R.par_act_end_dt,
																 
																 R.punishment_type = 'P' and
	                               R.par_act_end_dt >= L.par_act_end_dt => R.par_act_end_dt, 
																 L.par_act_end_dt);
												 
  SELF := R;
	

END;
R_pun := ROLLUP(s_pun ,
                  LEFT.vendor = RIGHT.vendor and
									LEFT.offender_key = RIGHT.offender_key,
                  RollupXform(LEFT,RIGHT),local);// : persist ('persist::corrections_punishment_rolledup');

//=====states with an ORBIT update type of "full-replace"==============================================================
set_ffStates := [
'AL',
'AZ',
'CO',
'CT',
'FL',
'GA',
'ID',
'IL',
'KS',
'MD',
'MI',
'MN',
'MO',
'MS',
'MT',
'NC',
'NE',
'NH',
'NJ',
'NV',
'NY',
'OH',
'OK',
'OR',
'RI',
'SC',
'TN',
'TX',
'UT',
'WI',
'WV'
];

//---------------------------------------------------------------
//For some states we need to look at the party_status_desc field. 
Set_UsePrtyStat_state := ['AZ','MI','MN','WA','OR','SC','TN'];

Set_UsePartyStat_for_Supervision := ['AZ','CT','MI','MN','WA','OR','SC','TN'];

offnd trecs(offnd L, R_pun R) := transform
//==================================INCARCERATION =======================================================================
Inc_StatusRule1  := MAP(L.offender_key = R.offender_key and 
                        regexfind('^(RECEPTION|ACTIVE|INCARCERAT.*|INCAR-ICC|INMATE|INITIAL)|NEW ADMISSION|RESTITUTION RESIDENT|CUSTODY|TEMP RESIDENT|OUT TO COURT|LIFE|POPULATION|CONTROLLING SENTENCE|PRE[-]*RELEASE|DEATH.*ROW|DEATH SENTENCE|PRISON|CORRECTION|CONFINEMENT|SENTENCED|FEDERAL INMATE|CONVICTED|RECEIVED|RELEASE DATE TO BE SET|PAROLE VIOLAT|CONSECUTIVE|CONCURRENT',StringLib.StringToUpperCase(R.cur_stat_inm_desc)) and
												regexfind('(RESIDENTIAL|HOME.*C[UST]*[ONFIN]*|POSTPRISON)',StringLib.StringToUpperCase(R.cur_stat_inm_desc),0)='' and
								        ( stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' 0')[1..4] = 'LIFE' OR
												  (unsigned) stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' ')[1..8] > (unsigned)ut.GetDate OR 
												  (length(trim(stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' ')[1..8])) = 6 AND  
												   (unsigned) stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' ')[1..6] > (unsigned)(ut.GetDate[1..6] )
												  )
											  ) => '1',
												
//---------------------------------------------------------------------------------------------------------------------------------------------											 
											  L.offender_key = R.offender_key and 
												((regexfind('^(RECEPTION|ACTIVE|INCARCERAT.*|INCAR-ICC|INMATE|INITIAL)|NEW ADMISSION|RESTITUTION RESIDENT|CUSTODY|TEMP RESIDENT|OUT TO COURT|LIFE|POPULATION|CONTROLLING SENTENCE|PRE[-]*RELEASE|DEATH.*ROW|DEATH SENTENCE|PRISON|CORRECTION|CONFINEMENT|SENTENCED|FEDERAL INMATE|CONVICTED|RECEIVED|RELEASE DATE TO BE SET|PAROLE VIOLAT|CONSECUTIVE|CONCURRENT',StringLib.StringToUpperCase(R.cur_stat_inm_desc)) and
												  regexfind('(RESIDENTIAL|HOME.*C[UST]*[ONFIN]*|POSTPRISON)',StringLib.StringToUpperCase(R.cur_stat_inm_desc),0)='' and 
													R.vendor not in ['TN'] 
												 ) or
												 (StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) in doxie_build.Lookup_FlagOffender.Incar_lookup and L.vendor in Set_UsePrtyStat_state)
												) and 
								        stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' 0') ='' and
								        R.vendor in set_ffStates and
								        LIB_Date.DaysApart( ut.GetDate ,L.process_date)< 31 => '1',		
//---------------------------------------------------------------------------------------------------------------------------------------------												
												L.offender_key <> '' and R.offender_key ='' and 
												StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) in doxie_build.Lookup_FlagOffender.Incar_lookup and L.vendor in Set_UsePrtyStat_state and 
												L.vendor in set_ffStates and
								        LIB_Date.DaysApart( ut.GetDate ,L.process_date)< 31 => '1',
												
										    R.cur_stat_inm_desc = '' => '3',
							          '0');
												
Inc_DateRule1	 		  := MAP(L.offender_key = R.offender_key and 
                          (R.cur_stat_inm_desc = '' and R.act_rel_dt between ut.GetDate and '30000000') => '1' ,	
													
											     L.offender_key = R.offender_key and
												   R.cur_stat_inm_desc = '' and trim(R.act_rel_dt) = 'LIFE'  => '1',
													 
													 L.offender_key = R.offender_key and
												   R.cur_stat_inm_desc = '' and trim(R.act_rel_dt) = '99999999' and StringLib.StringToUpperCase(R.sent_length_desc) = 'LIFE'  => '1',
													 
											     R.act_rel_dt = '' => '3',
							             '0');
												
Inc_DateRule2	 		  := MAP( L.offender_key = R.offender_key and R.cur_stat_inm_desc = '' and R.act_rel_dt = '' and R.ctl_rel_dt ='' and
                            R.sch_rel_dt between ut.GetDate and '30000000' => '1',	
														
														L.offender_key = R.offender_key and R.cur_stat_inm_desc = '' and R.act_rel_dt = '' and R.ctl_rel_dt ='' and
                            trim(R.sch_rel_dt) = 'LIFE'  => '1',
														
														L.offender_key = R.offender_key and R.cur_stat_inm_desc = '' and R.act_rel_dt = '' and R.ctl_rel_dt ='' and
												    trim(R.sch_rel_dt) = '99999999' and StringLib.StringToUpperCase(R.sent_length_desc) = 'LIFE'  => '1',
							              
														R.sch_rel_dt = '' => '3',
							              '0');
												
Inc_DateRule3	 		  := MAP( L.offender_key = R.offender_key and R.cur_stat_inm_desc = '' and R.act_rel_dt = '' and 
                            R.ctl_rel_dt between ut.GetDate and '30000000' => '1',
														
														L.offender_key = R.offender_key and R.cur_stat_inm_desc = '' and R.act_rel_dt = '' and 
                            trim(R.ctl_rel_dt) = 'LIFE' => '1',
							              
														
														L.offender_key = R.offender_key and R.cur_stat_inm_desc = '' and R.act_rel_dt = '' and  
												    trim(R.ctl_rel_dt) = '99999999' and StringLib.StringToUpperCase(R.sent_length_desc) = 'LIFE'  => '1',
														
												    R.ctl_rel_dt = '' => '3',
							              '0');
												
//Rule to identify 'Not Incarcerated'
inc_No_Rule     := MAP(((L.offender_key = R.offender_key and 
											   (regexfind('(SUICIDE|DECEASED|INACTIVE-DEATH|EXECUTION|DIED|DEATH - UNKNOWN CAUSE)|^(DEATH[ ]*)$|^(DEAD[ ]*)$',StringLib.StringToUpperCase(R.cur_stat_inm_desc)) OR
											    regexfind('(SUICIDE|DECEASED|INACTIVE-DEATH|EXECUTION|DIED|DEATH - UNKNOWN CAUSE)|^(DEATH[ ]*)$|^(DEAD[ ]*)$',StringLib.StringToUpperCase(R.par_cur_stat_desc)))
												) OR
												  regexfind('(SUICIDE|CLIENT DEAD|DECEASED|INACTIVE-DEATH|EXECUTION|DIED|DEATH - UNKNOWN CAUSE)|^(DEATH[ ]*)$|^(DEAD[ ]*)$',StringLib.StringToUpperCase(L.party_status_desc)) 
											 ) => 'D',
//---------------------------------------------------------------------------------------------------------------------------------------------
                       ((L.offender_key = R.offender_key and 
											   ( (regexfind('(ESCAPE|ABSCONDE)',StringLib.StringToUpperCase(R.cur_stat_inm_desc)) and
                            (~regexfind('(RETURN|IN[- ]*CUSTODY)',StringLib.StringToUpperCase(R.cur_stat_inm_desc)))) OR
											   
												   (regexfind('(ESCAPE|ABSCONDE)',StringLib.StringToUpperCase(R.par_cur_stat_desc)) and
                            (~regexfind('(RETURN|IN[- ]*CUSTODY)',StringLib.StringToUpperCase(R.par_cur_stat_desc))))
												 )
												) OR
												 (regexfind('(ESCAPE|ABSCONDE)',StringLib.StringToUpperCase(L.party_status_desc)) and
												  (~regexfind('(RETURN|IN[- ]*CUSTODY)',StringLib.StringToUpperCase(L.party_status_desc)))) 
											 ) and 
											 R.vendor in set_ffStates and
								       LIB_Date.DaysApart( ut.GetDate ,L.process_date)< 31 => 'D',
//---------------------------------------------------------------------------------------------------------------------------------------------
                       L.offender_key = R.offender_key and 
                       ((regexfind('^(RELEASE[ ]*)$|(POSTPRISON|DEPORTED|PARDONED|AUTH ABSENCE (AWL)|ISC|INTERSTATE COMPACT|SFII-SUPERVISED FURL.II|[CONDITIONAL]*[EARLY]* RELEASE|INACTV|INACTIVE|RELEASED|HOME.*C[UST]*[ONFIN]*|DISCHARGED|OUT TO COURT|PAROLE|ESCAPE|EXPIR.*[SENT]*.*[EXP]*|ON PAROLE|DECEASED|ABSCONDE|POST INCARCERATION|SERVING IN ABSENTIA|INTENSIVE SUPERVISION)',StringLib.StringToUpperCase(R.cur_stat_inm_desc)) and
											   regexfind('DISCHARGE FROM PROBATION|DISCHARGE FROM PAROLE',StringLib.StringToUpperCase(R.cur_stat_inm_desc),0) = ''
												) OR
											   regexfind('(SUSPENDED SENTENCE|EXPIRATION OF SENTENCE)',StringLib.StringToUpperCase(R.par_cur_stat_desc),0) <> ''
      						     ) and
								       stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' 0') <> '' and 
											 R.act_rel_dt <> '88888888' and
											 ((unsigned) stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' ')[1..8] <= (unsigned)ut.GetDate OR 
												  (length(trim(stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' ')[1..8])) = 6 AND  
												   (unsigned) stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' ')[1..6] <= (unsigned)(ut.GetDate[1..6] )
												  )
											 ) => '2',
//---------------------------------------------------------------------------------------------------------------------------------------------
                       // The dates are <= today
											  L.offender_key = R.offender_key and 
											 regexfind('DISCHARGE FROM PROBATION|DISCHARGE FROM PAROLE',StringLib.StringToUpperCase(R.cur_stat_inm_desc),0) = '' and
											 (stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' 0') <> '' and 
							  			 (unsigned) stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' ')[1..8] <= (unsigned)ut.GetDate) => '2' ,
//---------------------------------------------------------------------------------------------------------------------------------------------											 
											 //The dates empty, so look for the values in (party status or cur_stat_inm_desc) and the process date should not be older than 31. 
											 L.offender_key = R.offender_key and 
											 ((StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) in doxie_build.Lookup_FlagOffender.not_Incar_lookup and L.vendor in Set_UsePrtyStat_state) or
											  (regexfind('^(RELEASE[ ]*)$|(POSTPRISON|DEPORTED|PARDONED|AUTH ABSENCE (AWL)|ISC|INTERSTATE COMPACT|SFII-SUPERVISED FURL.II|[CONDITIONAL]*[EARLY]* RELEASE|INACTV|INACTIVE|RELEASED|HOME.*C[UST]*[ONFIN]*|DISCHARGE|OUT TO COURT|EXPIR.*[SENT]*.*[EXP]*|OUT TO COURT|POST INCARCERATION|SERVING IN ABSENTIA|INTENSIVE SUPERVISION)',StringLib.StringToUpperCase(R.cur_stat_inm_desc))  and 
												 regexfind('DISCHARGE FROM PROBATION|DISCHARGE FROM PAROLE',StringLib.StringToUpperCase(R.cur_stat_inm_desc),0) = '' and 
												 R.vendor not in ['TN']
												)) and 
								        ( stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' 0') =''  or R.act_rel_dt = '88888888' ) and
								        R.vendor in set_ffStates and
								        LIB_Date.DaysApart( ut.GetDate ,L.process_date)< 31 => '2',
//---------------------------------------------------------------------------------------------------------------------------------------------												
												//Punishment record does not exists so use the party_status_desc and the process date should not be older than 31.
												L.offender_key <> '' and R.offender_key ='' and 
												StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) in doxie_build.Lookup_FlagOffender.not_Incar_lookup and L.vendor in Set_UsePrtyStat_state and 
												L.vendor in set_ffStates and
								        LIB_Date.DaysApart( ut.GetDate ,L.process_date)< 31 => '2',
												
											  '3');
    		
//==================================\PAROLE=======================================================================				
Par_StatusRule1 :=  MAP(  L.offender_key = R.offender_key and 
                        ((regexfind('^(PAROLE|ON PAROLE|COMMUNITY SUPERVISION)|PAR/HOME CONFINEMENT',StringLib.StringToUpperCase(R.cur_stat_inm_desc)) AND 
												  regexfind('(HOLD|VIOLAT|REVOK)',StringLib.StringToUpperCase(R.cur_stat_inm_desc),0)=''
												 )  OR
												 regexfind('^(ACTIVE|ON PAROLE|WORK RELEASE|SUPERVISED RELEASE)|PAROLE|RELEASE TO PAR',StringLib.StringToUpperCase(R.par_cur_stat_desc)) Or 
												 (StringLib.StringToUpperCase(trim(L.party_status_desc,left,right))in doxie_build.Lookup_FlagOffender.Par_lookup and L.vendor in Set_UsePartyStat_for_Supervision
												 ) or
												 R.Par_cur_stat ='P') and                                                                                                           
												 regexfind('(DEPORTED|DEATH NOT VERIFIED|INDETERMINATE|PENDING ARRIVAL|INACTIVE|IN CUSTODY|EXPIRATION|ABSCONDER|DISCH.*[FROM]*[BY]*.*PAR|PRESUMPTIVE|VIOLAT|RELEASE FROM PAROLE|TERMINATED)',StringLib.StringToUpperCase(R.par_cur_stat_desc),0) = '' and
                        (unsigned) stringlib.stringfilterout(R.par_act_end_dt+R.Par_sch_end_dt,' ')[1..8] > (unsigned)ut.GetDate => '1',
												
//---------------------------------------------------------------------------------------------------------------------------------------------												
												  
													L.offender_key = R.offender_key and 
												 ((regexfind('^(PAROLE|ON PAROLE|COMMUNITY SUPERVISION)|PAR/HOME CONFINEMENT',StringLib.StringToUpperCase(R.cur_stat_inm_desc)) AND 
												   regexfind('(HOLD|VIOLAT|REVOK)',StringLib.StringToUpperCase(R.cur_stat_inm_desc),0)='' 
												  ) OR
													regexfind('^(ACTIVE|ON PAROLE|WORK RELEASE|SUPERVISED RELEASE)|PAROLE|RELEASE TO PAR',StringLib.StringToUpperCase(R.par_cur_stat_desc)) Or 
												  (StringLib.StringToUpperCase(trim(L.party_status_desc,left,right))in doxie_build.Lookup_FlagOffender.Par_lookup and L.vendor in Set_UsePartyStat_for_Supervision
												  ) or
						  					  R.Par_cur_stat ='P'
												 )  and 
												 regexfind('(DEPORTED|DEATH NOT VERIFIED|INDETERMINATE|PENDING ARRIVAL|INACTIVE|IN CUSTODY|EXPIRATION|DISCH.*[FROM]*[BY]*.*PAR|PRESUMPTIVE|VIOLAT|RELEASE FROM PAROLE|TERMINATED)',StringLib.StringToUpperCase(R.par_cur_stat_desc),0) = '' and
												 stringlib.stringfilterout(R.par_act_end_dt+R.Par_sch_end_dt,' 0') = '' and
								         R.vendor in set_ffStates and
												 LIB_Date.DaysApart( ut.GetDate ,L.process_date)< 31 => '1',
//---------------------------------------------------------------------------------------------------------------------------------------------												 
												 L.offender_key <> '' and R.offender_key ='' and 
												 StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) in doxie_build.Lookup_FlagOffender.Par_lookup and L.vendor in Set_UsePartyStat_for_Supervision and 
												 L.vendor in set_ffStates and
								         LIB_Date.DaysApart( ut.GetDate ,L.process_date)< 31 => '1',
												
												 '0');		
Par_DateRule1	 	:= MAP(L.offender_key = R.offender_key and 
                           R.par_cur_stat_desc = '' and R.par_act_end_dt between ut.GetDate and '30000000' => '1' ,	

							             '0');
												
Par_DateRule2	 	:= MAP( L.offender_key = R.offender_key and 
                            R.par_cur_stat_desc = '' and R.par_act_end_dt = '' and R.ctl_rel_dt ='' and
                            R.Par_sch_end_dt between ut.GetDate and '30000000' => '1',	

							              '0');												 
												
Par_No_Rule     := MAP( L.offender_key = R.offender_key and 
                        (regexfind('^(PAROLE|ON PAROLE)',StringLib.StringToUpperCase(R.cur_stat_inm_desc)) OR
												 regexfind('^(DEPORTED|PAROLE VIOLAT|ACTIVE|INACTIVE|RELEASED)|PAROLE|EXPIRATION|DISCHARGE|DISCH.*FROM.*PAR|RELEASE.*FROM PAROLE|TERMINATED.*PAROLE',StringLib.StringToUpperCase(R.par_cur_stat_desc)) Or 
												(StringLib.StringToUpperCase(trim(L.party_status_desc,left,right))in doxie_build.Lookup_FlagOffender.Par_lookup and L.vendor in Set_UsePartyStat_for_Supervision
												   ) or
												 R.Par_cur_stat ='P') and 
												 regexfind('(PRESUMPTIVE|MAXIMUM EXPIRATION|RELEASED TO )',StringLib.StringToUpperCase(R.par_cur_stat_desc),0) = '' and
												 stringlib.stringfilterout(R.par_act_end_dt+R.Par_sch_end_dt,' 0') <> '' and 
                        (unsigned) stringlib.stringfilterout(R.par_act_end_dt+R.Par_sch_end_dt,' ')[1..8] <= (unsigned)ut.GetDate => '2',
//---------------------------------------------------------------------------------------------------------------------------------------------												
                        L.offender_key = R.offender_key and 
											  (regexfind('(PAROLE REVOKED|DEPORTED|PAROLE VIOLAT)',StringLib.StringToUpperCase(R.cur_stat_inm_desc)) OR
												 regexfind('(PAROLE REVOKED|DEPORTED|PAROLE VIOLAT|INACTIVE|EXPIRATION|DISCH.*FROM.*PAR|RELEASED|RELEASE.*FROM PAROLE|TERMINATED.*PAROLE)',StringLib.StringToUpperCase(R.par_cur_stat_desc),0) <> '' or
												(StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) in doxie_build.Lookup_FlagOffender.not_Par_lookup and L.vendor in Set_UsePartyStat_for_Supervision)) and
												regexfind('(PRESUMPTIVE|MAXIMUM EXPIRATION|RELEASED TO)',StringLib.StringToUpperCase(R.par_cur_stat_desc),0) = '' and
												stringlib.stringfilterout(R.par_act_end_dt+R.Par_sch_end_dt,' 0') ='' and
								        R.vendor in set_ffStates and
								        LIB_Date.DaysApart( ut.GetDate ,L.process_date)< 31 => '2',
												
											 (stringlib.stringfilterout(R.par_act_end_dt+R.Par_sch_end_dt,' 0') <> '' and 
							  			 (unsigned) stringlib.stringfilterout(R.par_act_end_dt+R.Par_sch_end_dt,' ')[1..8] <= (unsigned)ut.GetDate) => '2' ,
//---------------------------------------------------------------------------------------------------------------------------------------------									 
											 	L.offender_key <> '' and R.offender_key ='' and 
												StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) in doxie_build.Lookup_FlagOffender.not_Par_lookup and L.vendor in Set_UsePartyStat_for_Supervision and 
												L.vendor in set_ffStates and
								        LIB_Date.DaysApart( ut.GetDate ,L.process_date)< 31 => '2',
												
											 '3');
    														
//==================================\PROBATION=======================================================================
prob_StatusRule1 	:=  MAP( L.offender_key = R.offender_key and 
                           Regexfind('^(PROBATION[ ]*)|UNSUPERVISED PROBATION|RELEASED TO PROBATION|DISCHARGE TO PROBATION',StringLib.StringToUpperCase(R.cur_stat_inm_desc)) and
													 Regexfind('(INACTIVE|EXPIRATION|ABSCONDER|PROBATION DISCHARGED|DISCHARGE FROM|REVOK)',StringLib.StringToUpperCase(R.cur_stat_inm_desc),0) ='' and 
													 stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' 0') <> ''  and
													 (unsigned) stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' ')[1..8] > (unsigned)ut.GetDate =>'1',
//---------------------------------------------------------------------------------------------------------------------------------------------
									 
                           L.offender_key = R.offender_key and 
													 ((regexfind('^(OUT-OF-STATE PROBATION|UNSUPERVISED PROBATION|STRAIGHT PROBATION-NO PRISON|RELEASED TO PROBATION|DISCHARGE TO PROBATION)|^(PROBATION[ ]*)$',StringLib.StringToUpperCase(R.par_cur_stat_desc)) and
														 regexfind('(INACTIVE|EXPIRATION|ABSCONDER|DISCHARGE|REVOK)',StringLib.StringToUpperCase(R.par_cur_stat_desc),0) = '' 
													  )OR
													  (StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) in doxie_build.Lookup_FlagOffender.Prob_lookup and L.vendor in Set_UsePartyStat_for_Supervision) 
													 )and 
													 (unsigned) stringlib.stringfilterout(R.par_act_end_dt+R.Par_sch_end_dt,' ')[1..8] > (unsigned)ut.GetDate => '1',
													
//---------------------------------------------------------------------------------------------------------------------------------------------
												   L.offender_key = R.offender_key and 
												  ((Regexfind('^(PROBATION[ ]*|UNSUPERVISED PROBATION|RELEASED TO PROBATION|DISCHARGE TO PROBATION)',StringLib.StringToUpperCase(R.cur_stat_inm_desc)) and
													  Regexfind('(INACTIVE|EXPIRATION|ABSCONDER|PROBATION DISCHARGED|DISCHARGE FROM|REVOK)',StringLib.StringToUpperCase(R.cur_stat_inm_desc),0) ='' and
													  stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' 0') =''
													 )  OR
													 (regexfind('^(OUT-OF-STATE PROBATION|UNSUPERVISED PROBATION|STRAIGHT PROBATION-NO PRISON|RELEASED TO PROBATION)|^(PROBATION[ ]*)$',StringLib.StringToUpperCase(R.par_cur_stat_desc)) and
														regexfind('(INACTIVE|EXPIRATION|ABSCONDER|DISCHARGE)',StringLib.StringToUpperCase(R.par_cur_stat_desc),0) = '' 
													 ) OR
													 (StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) in doxie_build.Lookup_FlagOffender.Prob_lookup and L.vendor in Set_UsePartyStat_for_Supervision) 
													) and 
													 
													 stringlib.stringfilterout(R.par_act_end_dt+R.Par_sch_end_dt,' 0') = ''   and
								           R.vendor in set_ffStates and
													 LIB_Date.DaysApart( ut.GetDate ,L.process_date)< 31 => '1',
//---------------------------------------------------------------------------------------------------------------------------------------------													 
													L.offender_key <> '' and R.offender_key ='' and 
												  StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) in doxie_build.Lookup_FlagOffender.Prob_lookup and L.vendor in Set_UsePartyStat_for_Supervision and 
												  L.vendor in set_ffStates and
								          LIB_Date.DaysApart( ut.GetDate ,L.process_date)< 31 => '1', 
				
							            '0');
													
Prob_No_Rule      :=  MAP( L.offender_key = R.offender_key and 
                           Regexfind('^(PROBATION[ ]*|INACTIVE PROBATION.*PAROLE|DISCHARGE FROM PROBATION|PROBATION DISCHARGED)',StringLib.StringToUpperCase(R.cur_stat_inm_desc)) and
													 
													 stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' 0') <> ''  and
													 (unsigned) stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' ')[1..8] <= (unsigned)ut.GetDate =>'2',
//---------------------------------------------------------------------------------------------------------------------------------------------
									 
                           L.offender_key = R.offender_key and 
													 ((regexfind('^(OUT-OF-STATE PROBATION|PROBATION DISCHARGED|STRAIGHT PROBATION-NO PRISON|INACTIVE PROBATION/PAROLE)|^(PROBATION[ ]*)$',StringLib.StringToUpperCase(R.par_cur_stat_desc)) 
													  )OR
													  (StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) in doxie_build.Lookup_FlagOffender.Prob_lookup and L.vendor in Set_UsePartyStat_for_Supervision) 
													 )and 
													 stringlib.stringfilterout(R.par_act_end_dt+R.Par_sch_end_dt,' 0') <> ''  and
													 (unsigned)stringlib.stringfilterout(R.par_act_end_dt+R.Par_sch_end_dt,' ')[1..8] <= (unsigned)ut.GetDate => '2',
//---------------------------------------------------------------------------------------------------------------------------------------------

													L.offender_key = R.offender_key and 
													( (regexfind('^(INACTIVE PROBATION.*PAROLE|PROBATION DISCHARGED|PROBATION REVOKED|PROBATION EXPIR|PROBATION REVOK|DISCHARGE FROM PROBATION)',StringLib.StringToUpperCase(R.cur_stat_inm_desc)) and
													   stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' 0') ='' 
														)or
													  regexfind('^(INACTIVE PROBATION.*PAROLE|PROBATION DISCHARGED|PROBATION REVOKED|PROBATION EXPIR|PROBATION REVOK|DISCHARGE FROM PROBATION)',StringLib.StringToUpperCase(R.par_cur_stat_desc)) OR													 
													 (StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) in doxie_build.Lookup_FlagOffender.not_Prob_lookup  and L.vendor in Set_UsePartyStat_for_Supervision)) and 
													  stringlib.stringfilterout(R.par_act_end_dt+R.Par_sch_end_dt,' 0') = ''  and
													
								          R.vendor in set_ffStates and
													LIB_Date.DaysApart( ut.GetDate ,L.process_date)< 31 => '2',
										
//---------------------------------------------------------------------------------------------------------------------------------------------													 
													L.offender_key <> '' and R.offender_key ='' and 
												  StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) in doxie_build.Lookup_FlagOffender.not_Prob_lookup and L.vendor in Set_UsePartyStat_for_Supervision and 
												  L.vendor in set_ffStates and
								          LIB_Date.DaysApart( ut.GetDate ,L.process_date) < 31 => '2', 
													
													'3'	);
//-------------------------------------------------------------------------------------------------------------------------													

//assert(Inc_StatusRule1 = '1', 'Inc_StatusRule1 = 1');
//assert(Inc_StatusRule1 <> '1', 'Inc_StatusRule1 <> 1');

string curr_incar_flag	:=  MAP( Inc_No_Rule = 'D' => 'N',
                                 (Inc_StatusRule1 = '1' or  Inc_DateRule1 = '1' or Inc_DateRule2 = '1' or Inc_DateRule3 = '1') => 'Y' ,
                                 Inc_No_Rule = '2' =>'N',
                                 'U');						
																 
string Parole_flag	    :=  MAP( Inc_No_Rule     = 'D' => 'N',
                                 Par_StatusRule1 = '1' or Par_DateRule1 = '1' or  Par_DateRule2 = '1' => 'Y',
                                 Par_No_Rule     = '2' => 'N',
							                   'U');
															 													
string Prob_flag	      :=  MAP( Inc_No_Rule      = 'D' => 'N',
                                 Prob_StatusRule1 = '1' => 'Y',
                                 Prob_No_Rule     = '2' => 'N',
                                 'U');		
																
//--------------------------------------------------------------------------------------------																
self.curr_incar_flag	   := IF(L.vendor not in vendor_list,'',
                               MAP( L.vendor = 'MN' and curr_incar_flag ='Y' and Parole_flag = 'Y' and 
															      stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' 0') = '' => 'N',
																		L.vendor = 'MN' and curr_incar_flag ='Y' and Parole_flag = 'Y' and 
																		stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' 0') <> '' => 'Y',
																		L.vendor = 'TN' and curr_incar_flag ='Y' and Parole_flag = 'Y' => 'U', 
																		L.vendor = 'TN' and curr_incar_flag ='Y' and StringLib.StringToUpperCase(trim(R.cur_stat_inm_desc,left,right)) IN ['DISCHARGED','ISC'] => 'U',	
																		curr_incar_flag = 'Y' => 'Y',
                                    curr_incar_flag = 'N' => 'N',
														        Parole_flag = 'Y' or Prob_flag ='Y' =>'N',
														        'U')
															);	 
self.curr_parole_flag    := IF(L.vendor not in vendor_list,'',
                               MAP( L.vendor = 'MN' and curr_incar_flag ='Y' and Parole_flag = 'Y' and
															      stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' 0') = ''=> 'Y',
																		L.vendor = 'MN' and curr_incar_flag ='Y' and Parole_flag = 'Y' and
															      stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' 0') <> '' => 'N',																		
																		L.vendor = 'TN' and curr_incar_flag ='Y' and Parole_flag = 'Y' => 'U',	
																		L.vendor = 'TN' and Parole_flag = 'Y' and StringLib.StringToUpperCase(trim(L.party_status_desc,left,right)) = 'INACTIVE PAROLE' => 'U',
																		L.vendor = 'TN' and curr_incar_flag ='Y' and StringLib.StringToUpperCase(trim(R.cur_stat_inm_desc,left,right)) IN ['DISCHARGED','ISC'] => 'U',	
																		L.vendor = 'GA' => 'U', //remove this once GA data becomes current
															      Parole_flag = 'Y' => 'Y',
                                    Parole_flag = 'N' => 'N',
													          curr_incar_flag ='Y' or Prob_flag ='Y' =>'N',
													          'U')
														  );		 
self.curr_probation_flag := IF(L.vendor not in vendor_list,'',
                               MAP( L.vendor = 'GA' => 'U', //remove this once GA data becomes current
															      L.vendor = 'TN' and curr_incar_flag ='Y' and Parole_flag = 'Y' => 'U',
																		L.vendor = 'TN' and curr_incar_flag ='Y' and StringLib.StringToUpperCase(trim(R.cur_stat_inm_desc,left,right)) IN ['DISCHARGED','ISC'] => 'U',	
															      Prob_flag = 'Y' => 'Y',
			                              Prob_flag = 'N' => 'N',
													          Parole_flag = 'Y' or curr_incar_flag ='Y' =>'N',
                                    'U')
															);	
self := L;


end;

flaggedRecs := join(offnd,R_pun,
				            left.offender_key = right.offender_key,
				            trecs(left,right),left outer,local);


return flaggedRecs;

end;
											
								







