Import SexOffender, Risk_indicators, doxie_files, SexOffender_Services, RiskWise, ut, VerificationOfOccupancy, liensv2, std, doxie, data_services, Suppress, AML;



export IndAllLegalEvents(DATASET(Layouts.AMLDerogsLayoutV2) idsIN ,
													 boolean isFCRA = false,
                                                     doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END
  													) := FUNCTION

data_environment :=  IF(isFCRA, data_services.data_env.iFCRA, data_services.data_env.iNonFCRA);

//version 2
//  history date can't be 999999   needs a 6 digit date         TODO


//Adding Sex Offenders
sex_offender_did_key := SexOffender.Key_SexOffender_DID(isFCRA);
sex_offender_spk_key := SexOffender.Key_SexOffender_SPK(isFCRA);

idsDedup := dedup(sort(idsIN, seq, origdid, did), seq, origdid, did);

//get the SO ids
spk_ids := join(idsDedup, sex_offender_did_key, keyed(left.did = right.did), atmost(SexOffender_Services.Constants.MAX_RECS_PERDID), left outer);

Layouts.AMLDerogsLayoutV2 add_SO(spk_ids le, sex_offender_spk_key ri) := TRANSFORM
	self.potentialSO := (INTEGER)((unsigned6)ri.did<>0);
	SELF := le;
END;

addSOff := JOIN (spk_ids, sex_offender_spk_key, 
                   keyed(LEFT.seisint_primary_key=RIGHT.sspk) AND
		   (unsigned3)(RIGHT.dt_first_reported[1..6]) < left.historydate ,
                   add_SO(LEFT,RIGHT),
			 KEEP(1), ATMOST(keyed(LEFT.seisint_primary_key=RIGHT.sspk), riskwise.max_atmost), left outer);
			 

Layouts.AMLDerogsLayoutV2 RollSO(addSOff le, addSOff ri) := TRANSFORM
	self.potentialSO := if(le.potentialSO, le.potentialSO, ri.potentialSO);
	SELF := le;
END;			 
			 
RollSOff := rollup(sort(addSOff, seq, origdid, did), 
										left.seq = right.seq and 
										left.origdid = right.origdid and
										left.did = right.did,
										RollSO(left, right));

Layouts.AMLDerogsLayoutV2 SetSODID(idsIN le, addSOff ri) := TRANSFORM
	self.potentialSO := ri.potentialSO;
	SELF := le;
END;

GetOrigDIDs := join(idsIN, RollSOff, left.seq = right.seq and  left.origdid = right.origdid and left.did = right.did,
										SetSODID(left, right), left outer);
									

// currently incarcerated based on history date

VerificationOfOccupancy.Layouts.Layout_VOOShell GetVOOLayout(idsDedup le, Integer C) := TRANSFORM
  self.seq := c;
	self.historydate := IF(le.historyDate = 999999, (integer)((STRING)Std.Date.Today())[1..6], LE.HISTORYDATE);
	self.score := le.seq;
	self.did := le.did;
	self := le;
	self := [];
	
END;

GetVOOPrep  := project(idsDedup, GetVOOLayout(left, counter));
GetVOOIncar := VerificationOfOccupancy.getIncarceration(GetVOOPrep);
										
// ever incarcerate or on parole

// *******************************************************************************************************************
// need to determine if the person was ever  incarcerated
// *******************************************************************************************************************

CriminalHistLayout := RECORD
	UNSIGNED4 seq;
	unsigned3 historydate;
	unsigned6 origdid;
	unsigned6 origbdid;
	boolean   LinkedBusn;
	UNSIGNED6 DID;
	string8 	file_date;
	string8 	event_dt;  //punishment key
	string60 	offender_key;  
	string1 	curr_incar_flag;    //  may not need
	string1 	curr_parole_flag;    //  may not need
	string35 	case_num;     //offense key
	string8		off_date:='';    //offense key
	string8		ct_disp_dt:='';   //offense key
	String8   Convict_dt:='';   //offense key
	string8		stc_dt:='';        //offense key
	string8		inc_adm_dt:='';   //offense key
	string8		latest_adm_dt:='';
	string8		sch_rel_dt:='';
	string8		act_rel_dt:='';
	string8		ctl_rel_dt:='';
	string50	stc_desc_2:='';
	string8		par_st_dt:='';
	string8		par_sch_end_dt:='';
	string8		par_act_end_dt:='';
	// string1 	parole_active_flag;
	boolean 	incarcOffenses;
	boolean 	incarcOffenders;
	boolean 	incarcPunishments;
	boolean 	ParolePunishments;
	boolean 	ParoleOffenders;
	boolean   onParole;
	
END;
	
	offenderKey 	:= doxie_files.Key_Offenders(isFCRA);
	offensesKey 	:= doxie_files.Key_Offenses(isFCRA);
	punishmentKey := doxie_files.Key_Punishment(isFCRA);
	todaysdate		:= ut.GetDate;

//Join target DIDs to offender key and set incarceration flag if "currently incarcerated" flag is on - pick up offender keys also
	CriminalHistLayout get_offenderKeys(idsDedup l, offenderKey r) := transform
		self.seq    				:= l.seq;
		self.historydate  	:= IF(l.historyDate = 999999, (integer)((STRING)Std.Date.Today())[1..6], l.historyDate);
		self.DID           	:= l.did;
		self.origdid        := l.origdid;
		self.origbdid       := l.origbdid;
		self.LinkedBusn     := l.LinkedBusn;
		self.file_date     	:= r.file_date;
		self.offender_key 	:= r.Offender_key;
		self.curr_incar_flag  := r.curr_incar_flag;
		self.curr_parole_flag := r.curr_parole_flag;
		self.incarcOffenders  :=  r.curr_incar_flag = 'Y'; 	//set if running in current mode
		self								:= l;
		self  := [];
	end;	

	offenderKeys := join(idsDedup, offenderKey, 
									keyed(left.did = right.sdid), 
									get_offenderKeys(left, right),
									left outer, atmost(5000), keep(1000));

	ddOffenderKey := dedup(sort(offenderKeys, seq, did, offender_key),seq, did, offender_key);    
	



//Join the offender keys to punishments and set incarceration flag if admit date < history date and any release date > history date
	CriminalHistLayout get_punishments(ddOffenderKey l, punishmentKey r) := transform
		IncarBegin_date	:= if(r.latest_adm_dt[1..6] <> '', r.latest_adm_dt[1..6], '');  //this is the begin date of incarceration
		ParoleBegin_date	:= if(r.par_st_dt <> '', r.par_st_dt, '');  //this is the begin date of parole
		ParoleEnd_date		:= map(r.par_sch_end_dt <> ''		=>	r.par_sch_end_dt,	//this is the end date of parole - choose any of these 2
											 r.par_act_end_dt <> ''		=>	r.par_act_end_dt,	//end dates if populated
																																	'');
		self.incarcPunishments 	:= IncarBegin_date <> '' and IncarBegin_date < (string)l.historydate  ; 
		self.ParolePunishments 	:= (ParoleBegin_date <> '' and ParoleEnd_date <> '' and ParoleBegin_date < (string)l.historydate and ParoleEnd_date > (string)l.historydate)  OR
																 r.cur_stat_inm_desc = 'PAROLE'; 

		self.par_st_dt   						:= r.par_st_dt;
		self.par_sch_end_dt   			:= r.par_sch_end_dt;
		self.par_act_end_dt					:= r.par_act_end_dt;
		self.event_dt               := r.event_dt;
		self.incarcOffenders        := l.incarcOffenders;
		self.latest_adm_dt          := r.latest_adm_dt;
		self.act_rel_dt             := r.act_rel_dt;
		self.ctl_rel_dt             := r.ctl_rel_dt;
		self.sch_rel_dt             := r.sch_rel_dt;
		self												:= l;
	end;	

	punishments := join(ddOffenderKey, punishmentKey, 
									keyed(left.Offender_key = right.ok),
									get_punishments(left, right),
									left outer, atmost(5000), keep(1000));

	sortedPunishments := sort(punishments, seq, did, Offender_key) ; 
	
	ParoleOffenders := dedup(sort(Punishments, seq, did, -event_dt), seq, did); 

	
//rollup by sequence to set the incarceration flag if any of the person's offender records show that he/she is currently incarcerated
  CriminalHistLayout rollPunishments(sortedPunishments l, sortedPunishments r) := transform
		self.incarcPunishments := if(l.incarcPunishments, l.incarcPunishments, r.incarcPunishments);
		self.incarcOffenders 	:= if(l.incarcOffenders, l.incarcOffenders, r.incarcOffenders);
		self.ParolePunishments 	:= if(l.ParolePunishments, l.ParolePunishments, r.ParolePunishments);
		self										:= l;
	end;
	
  rolledPunishments := rollup(sortedPunishments,
												left.seq = right.seq and  left.did = right.did and  left.Offender_key = right.offender_key,
												rollPunishments(left,right) );

//Join the offender keys to offenses and set incarceration flag if history date falls between the begin and end dates
	CriminalHistLayout get_offenses(sortedPunishments l, offensesKey r) := transform
		posBeg := stringlib.stringfind(r.stc_desc_2, 'Date:', 1);  //format is 'Sent Start Date: yyyymmdd Sent End Date: yyyymmdd'
	
		Incarbeg_dt	:= if(posBeg <> 0, r.stc_desc_2[posBeg+6..posBeg+11], '');  //position at start date and grab yyyymm

		Incarbeg_dt_isNumeric := Risk_Indicators.IsAllNumeric(IncarBeg_dt);

		IncarBegin_date := if(Incarbeg_dt_isNumeric, Incarbeg_dt, '');
		self.stc_desc_2 := r.stc_desc_2;
		self.incarcOffenses 	:= IncarBegin_date <> '' and IncarBegin_date < (string)l.historydate; 	
		self									:= l;
	end;	

	offenses := join(sortedPunishments, offensesKey, 
									keyed(left.Offender_key = right.ok),
									get_offenses(left, right),
									left outer, atmost(5000), keep(1000));

	sortedOffenses := sort(offenses, seq, origdid, did, offender_key);  
	
//rollup by sequence to set the incarceration flag if any of the person's offender records show that he/she is currently incarcerated
  CriminalHistLayout rollOffenses(sortedOffenses le, sortedOffenses ri) := transform
		self.incarcOffenses := if(le.incarcOffenses,le.incarcOffenses, ri.incarcOffenses);
		self.incarcPunishments := if(le.incarcPunishments,le.incarcPunishments, ri.incarcPunishments);
		self.incarcOffenders 	:= if(le.incarcOffenders,le.incarcOffenders, ri.incarcOffenders);
		self.ParolePunishments 	:= if(le.ParolePunishments,le.ParolePunishments, ri.ParolePunishments);
		// self.ParoleOffenders   := if(use_left, le.ParoleOffenders, ri.ParoleOffenders);
		self										:= le;
	end;
	
  rolledOffenses := rollup(sortedOffenses, left.seq = right.seq and left.did = right.did,
														rollOffenses(left,right));	
	
	
		Layouts.AMLDerogsLayoutV2 setAllOffense(GetOrigDIDs le, rolledOffenses ri)  := TRANSFORM
		SELF.EverIncarcer  := if(ri.incarcOffenses or ri.incarcPunishments or ri.incarcOffenders, 1, 0);
		self.CurrParole  := if(ri.ParolePunishments, 1, 0);
		self.potentialSO := le.potentialSO;
		self := le
	
	END;
	
	IncarHistory := join(GetOrigDIDs, rolledOffenses, left.did = right.did and left.seq = right.seq,
								setAllOffense(left,right), left outer);
								

  AddParole := join(IncarHistory , ParoleOffenders, 
										left.seq = right.seq and
										left.origdid = right.origdid and
										left.did = right.did,
										transform(Layouts.AMLDerogsLayoutV2, 
															self.CurrParole := left.CurrParole or right.curr_parole_flag = 'Y',
															self := left;),
										left outer);
										
							
// join to currently incarcerated rec	

Layouts.AMLDerogsLayoutV2 addCurrIncarceration( AddParole le, GetVOOIncar ri)  := TRANSFORM
		SELF.CurrIncarcer := If(ri.incarc_offenders or ri.incarc_offenses or ri.incarc_punishments, true, false);
		self := le;
END;
		
addCurrIncar  := join( AddParole, GetVOOIncar,
										left.seq = right.Score and
										left.did = right.did,
										addCurrIncarceration(left, right), left outer);
										
// check felonies and criminal counts

koff_nonFCRA	:= doxie_files.key_offenders_risk;

CriminalLayout := RECORD
  UNSIGNED4 seq;
	unsigned4 historydate;
	unsigned3  mygetdate;
	unsigned6 origdid;
	unsigned6 origbdid;
	boolean   LinkedBusn;
	UNSIGNED6 DID;
	string35  crim_case_num;
	UNSIGNED2 FelonyCount3yr := 0;
	UNSIGNED2 FelonyCount := 0;
	UNSIGNED2 FelonyCount1yr := 0;
	UNSIGNED2 nonfelonycriminalCount := 0;
	UNSIGNED2 nonfelonycriminalcount12 := 0;
	string8 earliest_offense_date;
	
END;
	

// checkDays(string8 d1, string8 d2, unsigned2 days) := ut.DaysApart(d1,d2) <= days and d1>d2;

CriminalLayout addCrimCount(addCurrIncar le, koff_NonFCRA ri) := TRANSFORM
	myGetDate := risk_indicators.iid_constants.myGetDate(le.historydate);
	self.mygetdate := (integer)mygetdate;
	isFelony := ri.criminal_offender_level='4' and ri.offense_score='F';
	nonfelony := (unsigned6)ri.did<>0 and ri.offense_score<>'F';
	self.earliest_offense_date := ri.earliest_offense_date;
	self.FelonyCount3yr := (INTEGER)(isfelony and risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)ri.earliest_offense_date,ut.DaysInNYears(3),le.historydate));
	self.FelonyCount    := (INTEGER)isFelony;
  SELF.FelonyCount1yr := (INTEGER)(isfelony and risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)ri.earliest_offense_date,ut.DaysInNYears(1),le.historydate));	

	SELF.nonfelonycriminalCount := (INTEGER)nonfelony ;
	SELF.nonfelonycriminalcount12 := (INTEGER)(nonfelony and risk_indicators.iid_constants.checkdays((STRING8)myGetDate,(STRING8)ri.earliest_offense_date,ut.DaysInNYears(1),le.historydate));
	self.crim_case_num := ri.case_num;
	SELF := le;
END;

CrimCounts := JOIN (addCurrIncar, koff_nonFCRA, 
                   (LEFT.did != 0) AND keyed(LEFT.did=RIGHT.sdid) AND
									 (unsigned3)(RIGHT.earliest_offense_date[1..6]) < left.historydate, 
                   addCrimCount(LEFT,RIGHT),
									 LEFT OUTER,  atmost(5000), KEEP(1000));

CrimCountSort := sort(ungroup(CrimCounts), seq, origdid, did, crim_case_num);


CriminalLayout  rollCrimCounts(CrimCountSort le, CrimCountSort ri) := TRANSFORM
  sameCrimCase := le.crim_case_num = ri.crim_case_num;
	self.FelonyCount3yr := le.FelonyCount3yr+IF(sameCrimCase,0,ri.FelonyCount3yr);
	self.FelonyCount := le.FelonyCount+IF(sameCrimCase,0,ri.FelonyCount);
	self.FelonyCount1yr := le.FelonyCount1yr+IF(sameCrimCase,0,ri.FelonyCount1yr);
	self.nonfelonycriminalCount := le.nonfelonycriminalCount+IF(sameCrimCase,0,ri.nonfelonycriminalCount);
	self.nonfelonycriminalcount12 := le.nonfelonycriminalcount12+IF(sameCrimCase,0,ri.nonfelonycriminalcount12);
	self.crim_case_num := if(~sameCrimCase, ri.crim_case_num, le.crim_case_num);
	self.earliest_offense_date := if(le.earliest_offense_date > ri.earliest_offense_date, le.earliest_offense_date, ri.earliest_offense_date);
	
	SELF := le;
END;

rollCrimCaseNum := ROLLUP(CrimCountSort,
													LEFT.seq = RIGHT.seq AND
													LEFT.origdid = RIGHT.origdid AND
													LEFT.did = RIGHT.did AND
													LEFT.crim_case_num = RIGHT.crim_case_num,
													TRANSFORM(RECORDOF(LEFT),
																		SELF.FelonyCount3yr := (INTEGER)(LEFT.FelonyCount3yr > 0 or RIGHT.FelonyCount3yr > 0);
																		SELF.FelonyCount := (INTEGER)(LEFT.FelonyCount > 0 or RIGHT.FelonyCount > 0);
																		SELF.FelonyCount1yr := (INTEGER)(LEFT.FelonyCount1yr > 0 or RIGHT.FelonyCount1yr > 0);
																		SELF.nonfelonycriminalCount := (INTEGER)(LEFT.nonfelonycriminalCount > 0 or RIGHT.nonfelonycriminalCount > 0);
																		SELF.nonfelonycriminalcount12 := (INTEGER)(LEFT.nonfelonycriminalcount12 > 0 or RIGHT.nonfelonycriminalcount12 > 0);
																		SELF.earliest_offense_date := if(LEFT.earliest_offense_date > RIGHT.earliest_offense_date, LEFT.earliest_offense_date, RIGHT.earliest_offense_date);
																		SELF := LEFT;));
							
rolledCrimCounts :=  rollup(rollCrimCaseNum, left.seq = right.seq and left.origdid = right.origdid and left.did = right.did,
														rollCrimCounts(left,right));				
							
AddCrimcounts := join(addCurrIncar, rolledCrimCounts, 
											left.seq = right.seq and
											left.origdid = right.origdid and
											left.did = right.did,
											transform(Layouts.AMLDerogsLayoutV2, 
																	self.FelonyCount3yr := right.FelonyCount3yr,
																	self.FelonyCount := right.FelonyCount,
																	self.FelonyCount1yr := right.FelonyCount1yr,
																	self.nonfelonycriminalCount := right.nonfelonycriminalCount,
																	self.nonfelonycriminalcount12 := right.nonfelonycriminalcount12,
																	self := left),
												left outer);
											
										
kld			:= liensv2.key_liens_DID;
klr_nonFCRA	:= liensv2.key_liens_party_id;

LiensLayout:= RECORD
  unsigned4		seq := 0;
	unsigned4		historydate;
	unsigned6   origdid;
	unsigned6   origbdid;
	boolean     LinkedBusn;
	unsigned6 	did;
	STRING50 		rmsid; // liens extras
	string50 		tmsid; // liens extras
	unsigned4	  date_first_seen;
	unsigned4	  date_last_seen;
	unsigned2   liensUnreleasedCnt;
	unsigned2   liensUnreleasedCnt12;
	unsigned2   liensReleasedCnt;
	unsigned2   liensReleasedCnt12;
END;

LiensLayout add_liens(idsDedup le, kld ri) := TRANSFORM
	self.tmsid := ri.tmsid;
	SELF.rmsid := ri.rmsid;
	SELF := le;
	self := [];
END;

  
liens_added := JOIN(idsDedup, kld, keyed(LEFT.did=RIGHT.did), add_liens(LEFT,RIGHT), LEFT OUTER, KEEP(500),
					ATMOST(keyed(left.did=right.did), Riskwise.max_atmost));
					
{LiensLayout, unsigned4 global_sid} get_liens_nonFCRA(liens_added le, klr_nonFCRA ri) := TRANSFORM
	self.global_sid := ri.global_sid;
	myGetDate := risk_indicators.iid_constants.myGetDate(le.historydate);	
  self.date_first_seen := (INTEGER)ri.date_first_seen;
	self.date_last_seen  := (INTEGER)ri.date_last_seen ;
	SELF.liensUnreleasedCnt := (INTEGER)(ri.rmsid<>'' AND (INTEGER)ri.date_last_seen=0 );
																						
	SELF.liensReleasedCnt := (INTEGER)(ri.rmsid<>'' AND  (INTEGER)ri.date_last_seen<>0 );
																			
	SELF.liensUnreleasedCnt12 := (INTEGER)(ri.rmsid<>'' AND (INTEGER)ri.date_last_seen=0 and
															risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)ri.date_first_seen,ut.DaysInNYears(1),le.historydate));
	SELF.liensReleasedCnt12 := (INTEGER)(ri.rmsid<>'' AND (INTEGER)ri.date_last_seen<>0 and 
																			risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)ri.date_first_seen,ut.DaysInNYears(1),le.historydate));
	self.origdid := le.origdid;
	self.did := le.did;
	self.historydate := le.historydate;
	self.seq := le.seq;
	self.origbdid  := le.origbdid;
	self.LinkedBusn := le.LinkedBusn;
  SELF := le;
END;

liens_full_unsuppressed := JOIN (liens_added, klr_nonFCRA, 
                    LEFT.rmsid<>'' AND
                    keyed(left.tmsid=right.tmsid) and keyed(LEFT.rmsid=RIGHT.rmsid) AND 
										right.name_type='D' and 
										(unsigned3)(RIGHT.date_first_seen[1..6]) < left.historydate,	
                    get_liens_nonFCRA(LEFT,RIGHT),
										LEFT OUTER, KEEP(1000),
				ATMOST(keyed(left.tmsid=right.tmsid) and keyed(left.rmsid=right.rmsid), Riskwise.max_atmost));
				
liens_full_flagged := Suppress.MAC_FlagSuppressedSource(liens_full_unsuppressed, mod_access, data_env := data_environment);

liens_full := PROJECT(liens_full_flagged, TRANSFORM(LiensLayout, 
	SELF.date_first_seen := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.date_first_seen);
	SELF.date_last_seen  := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.date_last_seen);
	SELF.liensUnreleasedCnt := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.liensUnreleasedCnt);
	SELF.liensReleasedCnt := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.liensReleasedCnt);
	SELF.liensUnreleasedCnt12 := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.liensUnreleasedCnt12);
	SELF.liensReleasedCnt12 := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.liensReleasedCnt12);
    SELF := LEFT;
)); 
			
LiensLayout roll_liens(liens_full le, liens_full ri) := TRANSFORM
	sameLien := le.tmsid=ri.tmsid and le.rmsid=ri.rmsid;
	SELF.liensUnreleasedCnt := le.liensUnreleasedCnt + IF(sameLien ,0,ri.liensUnreleasedCnt);
	
	SELF.liensUnreleasedCnt12 := le.liensUnreleasedCnt12 + IF(sameLien ,0,ri.liensUnreleasedCnt12);
	
	SELF.liensReleasedCnt := le.liensReleasedCnt + IF(sameLien ,0,ri.liensReleasedCnt);
	
	SELF.liensReleasedCnt12 := le.liensReleasedCnt12 + IF(sameLien,0,ri.liensReleasedCnt12);
	SELF.tmsid := IF(~sameLien, ri.tmsid, le.tmsid);
	SELF.rmsid := IF(~sameLien, ri.rmsid, le.rmsid);
	self.date_last_seen := If(~sameLien, ri.date_last_seen, le.date_last_seen);
	self.date_first_seen := If(~sameLien, ri.date_first_seen, le.date_first_seen);
	self.origdid := le.origdid;
	self.did := le.did;
	self.historydate := le.historydate;
	self.seq := le.seq;
	self.origbdid  := le.origbdid;
	self.LinkedBusn := le.LinkedBusn;	
	SELF := ri;
END;

liens_sorted := SORT(liens_full,seq, origdid, did,tmsid,rmsid,-date_first_seen);
liens_rolled := ROLLUP(liens_sorted,LEFT.did=RIGHT.did and
											left.seq = right.seq and
											left.origdid = right.origdid,
											roll_liens(LEFT,RIGHT)); 


AddLiens := join(AddCrimcounts, liens_rolled,
									left.seq = right.seq and
									left.did = right.did and
									left.origdid = right.origdid,
									transform(Layouts.AMLDerogsLayoutV2,
														self.liensUnreleasedCnt := right.liensUnreleasedCnt,
														self.liensUnreleasedCnt12 := right.liensUnreleasedCnt12,
														self.liensReleasedCnt := right.liensReleasedCnt,
														self.liensReleasedCnt12 := right.liensReleasedCnt12,
														self := left),
									left outer);

// output(idsIN, named('idsIN'), overwrite);
// output(GetVOOPrep, named('GetVOOPrep'), overwrite);
// output(GetVOOIncar, named('GetVOOIncar'), overwrite);
// output(spk_ids, named('spk_ids'), overwrite);
// output(addSOff, named('addSOff'), overwrite);
// output(RollSOff, named('RollSOff'), overwrite);
// output(GetOrigDIDs, named('GetOrigDIDs'), overwrite);
// output(offenderKeys, named('offenderKeys'), overwrite);


// output(ddOffenderKey, named('ddOffenderKey'), overwrite);
// output(punishments, named('punishments'), overwrite);
// output(sortedPunishments, named('sortedPunishments'), overwrite);
// output(ParoleOffenders, named('ParoleOffenders'), overwrite);
// output(rolledPunishments, named('rolledPunishmentsAML'), overwrite);
// output(offenses, named('offenses'), overwrite);
// output(sortedOffenses, named('sortedOffenses'), overwrite);
// output(rolledOffenses, named('rolledOffensesAML'), overwrite);
// output(IncarHistory, named('OffenseHistoryAML'), overwrite);
// output(AddParole, named('AddParoleAML'), overwrite);
// output(addCurrIncar, named('addCurrIncarAML'), overwrite);
// output(CrimCounts, named('CrimCountsAML'), overwrite, all);
// output(CrimCountSort, named('CrimCountSort'), overwrite, all);
// output(rollCrimCaseNum, named('rollCrimCaseNum'), overwrite, all);
// output(rolledCrimCounts, named('rolledCrimCounts'), overwrite);
// output(AddCrimcounts, named('AddCrimcounts'), overwrite);
// output(liens_added, named('liens_added'), overwrite);
// output(liens_full, named('liens_full'), overwrite);
// output(liens_sorted, named('liens_sorted'), overwrite);
// output(liens_rolled, named('liens_rolled'), overwrite);
// output(AddLiens, named('AddLiens'), overwrite);


RETURN AddLiens;

END;