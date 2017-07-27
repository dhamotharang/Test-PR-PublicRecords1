import Risk_Indicators, doxie, doxie_files, ut, riskwise, Std;

EXPORT getIncarceration(DATASET(VerificationOfOccupancy.Layouts.Layout_VOOShell) VOOShell) := FUNCTION

// *******************************************************************************************************************
// For attribute 'OccupancyOverride' - need to determine if the person was incarcerated
// *******************************************************************************************************************

	isFCRA 				:= false;
	offenderKey 	:= doxie_files.Key_Offenders(isFCRA);
	offensesKey 	:= doxie_files.Key_Offenses(isFCRA);
	punishmentKey := doxie_files.Key_Punishment(isFCRA);
	todaysdate		:= (STRING8)Std.Date.Today();

//Join target DIDs to offender key and set incarceration flag if "currently incarcerated" flag is on - pick up offender keys also
	VerificationOfOccupancy.Layouts.Layout_VOOShell get_offenderKeys(VOOShell l, offenderKey r) := transform
		self.incarc_Offenders 		:= ((string)l.historydate)[1..6] = ((string)todaysdate)[1..6] and r.curr_incar_flag = 'Y'; 	//set if running in current mode
		self.incarc_Offender_key 	:= r.Offender_key; 	
		self											:= l;
	end;	

	offenderKeys := join(VOOShell, offenderKey, 
									keyed(left.did = right.sdid), // and 
									// right.curr_incar_flag = 'Y',
									get_offenderKeys(left, right),
									left outer, atmost(riskwise.max_atmost * 5));

	sortedOffenderKeys := sort(offenderKeys, seq, incarc_Offender_key, -incarc_Offenders);  
	
//rollup by sequence and offender key to set the incarceration flag for each offender record
  VerificationOfOccupancy.Layouts.Layout_VOOShell rollOffenderKeys(VerificationOfOccupancy.Layouts.Layout_VOOShell l, VerificationOfOccupancy.Layouts.Layout_VOOShell r) := transform
		self.incarc_Offenders 	:= if(r.incarc_Offenders, r.incarc_Offenders, l.incarc_Offenders);
		self										:= l;
	end;
	
  rolledOffenderKeys := rollup(sortedOffenderKeys, rollOffenderKeys(left,right), seq, incarc_Offender_key);

//Join the offender keys to punishments and set incarceration flag if admit date < history date and any release date > history date
	VerificationOfOccupancy.Layouts.Layout_VOOShell get_punishments(rolledOffenderKeys l, punishmentKey r) := transform
		begin_date	:= if(r.latest_adm_dt[1..6] <> '', r.latest_adm_dt[1..6], '');  //this is the begin date of incarceration
		end_date		:= map(r.act_rel_dt <> ''		=>	r.act_rel_dt[1..6],	//this is the end date of incarceration - choose any of these 3
											 r.ctl_rel_dt <> ''		=>	r.ctl_rel_dt[1..6],	//release dates if populated
											 r.sch_rel_dt <> ''		=>	r.sch_rel_dt[1..6],
																								'');
		self.incarc_Punishments 	:= begin_date <> '' and end_date <> '' and begin_date <= (string)l.historydate and end_date >= (string)l.historydate; 	
		self											:= l;
	end;	

	punishments := join(rolledOffenderKeys, punishmentKey, 
									keyed(left.incarc_Offender_key = right.ok),
									get_punishments(left, right),
									left outer, atmost(riskwise.max_atmost));

	sortedPunishments := sort(punishments, seq, incarc_Offender_key, -incarc_Punishments);  
	
//rollup by sequence to set the incarceration flag if any of the person's offender records show that he/she is currently incarcerated
  VerificationOfOccupancy.Layouts.Layout_VOOShell rollPunishments(VerificationOfOccupancy.Layouts.Layout_VOOShell l, VerificationOfOccupancy.Layouts.Layout_VOOShell r) := transform
		self.incarc_Punishments := if(r.incarc_Punishments, r.incarc_Punishments, l.incarc_Punishments);
		self.incarc_Offenders 	:= if(r.incarc_Offenders, r.incarc_Offenders, l.incarc_Offenders);
		self										:= l;
	end;
	
  rolledPunishments := rollup(sortedPunishments, rollPunishments(left,right), seq, incarc_Offender_key);

//Join the offender keys to offenses and set incarceration flag if history date falls between the begin and end dates
	VerificationOfOccupancy.Layouts.Layout_VOOShell get_offenses(rolledPunishments l, offensesKey r) := transform
		posBeg := stringlib.stringfind(r.stc_desc_2, 'Date:', 1);  //format is 'Sent Start Date: yyyymmdd Sent End Date: yyyymmdd'
		posEnd := stringlib.stringfind(r.stc_desc_2, 'Date:', 2);
		
		beg_dt	:= if(posBeg <> 0, r.stc_desc_2[posBeg+6..posBeg+11], '');  //position at start date and grab yyyymm
		end_dt	:= if(posEnd <> 0, r.stc_desc_2[posEnd+6..posEnd+11], '');  //position at end date and grab yyyymm

		beg_dt_isNumeric := Risk_Indicators.IsAllNumeric(beg_dt);
		end_dt_isNumeric := Risk_Indicators.IsAllNumeric(end_dt);

		begin_date := if(beg_dt_isNumeric, beg_dt, '');  
		end_date	 := if(end_dt_isNumeric, end_dt, if(trim(r.stc_lgth_desc) = 'LIFE', '999999', ''));  //if life sentence, set end date to max

		self.incarc_Offenses 	:= begin_date <> '' and end_date <> '' and begin_date <= (string)l.historydate and end_date >= (string)l.historydate; 	
		self									:= l;
	end;	

	offenses := join(rolledPunishments, offensesKey, 
									keyed(left.incarc_Offender_key = right.ok),
									get_offenses(left, right),
									left outer, atmost(riskwise.max_atmost * 5));

	sortedOffenses := sort(offenses, seq, -incarc_Offenses);  
	
//rollup by sequence to set the incarceration flag if any of the person's offender records show that he/she is currently incarcerated
  VerificationOfOccupancy.Layouts.Layout_VOOShell rollOffenses(VerificationOfOccupancy.Layouts.Layout_VOOShell l, VerificationOfOccupancy.Layouts.Layout_VOOShell r) := transform
		self.incarc_Offenses := if(r.incarc_Offenses, r.incarc_Offenses, l.incarc_Offenses);
		self.incarc_Punishments := if(r.incarc_Punishments, r.incarc_Punishments, l.incarc_Punishments);
		self.incarc_Offenders 	:= if(r.incarc_Offenders, r.incarc_Offenders, l.incarc_Offenders);
		self										:= l;
	end;
	
  rolledOffenses := rollup(sortedOffenses, rollOffenses(left,right), seq);

// output(offenderKeys, named('offenderKeys'));
// output(sortedOffenderKeys, named('sortedOffenderKeys'));
// output(rolledOffenderKeys, named('rolled_OffenderKeys'));
// output(punishments, named('punishments'));
// output(sortedPunishments, named('sortedPunishments'));
// output(rolledPunishments, named('rolledPunishments'));
// output(offenses, named('offenses'));
// output(sortedOffenses, named('sortedOffenses'));
// output(rolledOffenses, named('rolledOffenses'));
										
return rolledOffenses;	
	
END;