﻿Import SexOffender, Risk_indicators, doxie_files, SexOffender_Services, RiskWise, ut, VerificationOfOccupancy, liensv2, STD;



export getIndCriminal(DATASET(DueDiligence.LayoutsInternal.RelatedParty) Individuals ,
													 boolean debugmode = FALSE,  
													 boolean isFCRA = false
  													) := FUNCTION
														
 	todaysdate		:= (STRING8)Std.Date.Today(); 
	// ------                                             ------
	// ------                                             ------
	// ------  Start by getting data about the offender   ------
	// ------  for this DID (individual)                  ------
	// ------  it starts out collecting information in    ------
	// ------  CriminalOffensesLayout_by_DID(and offense) ------
	// ------  and eventually rolling up each offenses    ------
	// ------  upto the relatedParty                      ------
	// ------  Data is pulled from the NONFCRA versions of
	// ------  following keys                             ------
	// ------     doxie_files.Key_Offenders               ------
	// ------ 	  doxie_files.Key_Offenses                 ------
	// ------     doxie_files.Key_Punishment              ------             
	// ------     doxie_files.key_offenders_risk          ------
	// ------                                             ------
	// ------  Start by getting data about the offender   ------
	// ------  for this DID (individual)                  ------  
	// ------      KEY_ OFFENDERS                         ------
	// ------  Note: Not all DIDs are offenders           ------
	StartBuildingOffenderData := JOIN(Individuals, doxie_files.Key_Offenders(isFCRA), 
									keyed(LEFT.party.did = RIGHT.sdid), 
									TRANSFORM (DueDiligence.Layouts.CriminalOffenseLayout_by_DIDOffense,
									          /* pass the data needed from the left */
														SELF.seq               := LEFT.seq,                     //this is the sequence number that ties back to the input transaction (could be business or individual) 
														SELF.did               := LEFT.party.did,
														self.historyDate       := LEFT.Historydate,
														SELF.ToDaysDate        := (integer)todaysdate;                  //capture the run date
														/* Essentially this is today's date if history date is all 9's OR the history date itself */    
										    tempDateToUse          := DueDiligence.Common.GetMyDate(LEFT.historydate);
										    SELF.DateToUse         := tempDateToUse,
														/* pass the data needed from the right */  
														self.file_date     	   := RIGHT.file_date;
		            self.offender_key 	    := RIGHT.Offender_key;
														/*  the values in the curr_incar_flag, curr_parole_flag and are not always populated */ 
														/*  so this is just 1 of 3 things that we use to show evidence of incarceration      */
              self.Ever_incarc_offenders   := IF(RIGHT.curr_incar_flag = 'Y', 'Y', 'N'); 
							       self.Curr_incarc_Offenders 		:= IF(((string)tempDateToUse) = ((string)todaysdate) AND      /*  If you are running in CURRENT MODE it should be todays date */   
										                                       RIGHT.curr_incar_flag = 'Y', 'Y', 'N'); 	                 
		            self.curr_parole_flag        := RIGHT.curr_parole_flag;
														SELF                         := LEFT, 
	             SELF                         := []),   //All other fields will get populated in further processing
									INNER,  //Only those records that exist in both the leftrecset and rightrecset to Produce a list of just DID's that are offenders.
									ATMOST(DueDiligence.Constants.MAX_ATMOST_OFFENSES), 
									KEEP(DueDiligence.Constants.MAX_KEEP));
	
	// ------                                                                                    ------
 // ------ Sort the Offender Data before the ROLLUP to make sure it is in sequence            ------ 
	// ------                                                                                    ------	
	 OffenderDataSorted  := sort(StartBuildingOffenderData, seq, did, offender_key);
	// ------                                                                                    ------
 // ------ Use this TRANSFORM for the ROLLUP  of the OFFENDER DATA                            ------ 
	// ------                                                                                    ------	
	recordof(OffenderDataSorted) deduptheOffenderData(OffenderDataSorted le, OffenderDataSorted ri)  := TRANSFORM
	                              SELF.seq                        := ri.seq;
																															SELF.did                        := ri.did;
																															/* These are all evidence that indicates if the DID is currently incarcerated or EVER incarcerated */   
																															SELF.Curr_incarc_offenders      := IF(le.Curr_incarc_offenders   = 'Y', le.Curr_incarc_offenders,   ri.Curr_incarc_offenders);
																															SELF.Ever_incarc_offenders      := IF(le.Ever_incarc_offenders   = 'Y', le.Ever_incarc_offenders,   ri.Ever_incarc_offenders);
																															/* These are all evidence that indicates if the DID is currently on Parole */   
																															SELF.curr_parole_flag           := IF(le.curr_parole_flag        = 'Y', le.curr_parole_flag,        ri.curr_parole_flag);
																															/* Pass all remaining fields forward from the LEFT */  
																															SELF                            := le;
	                              END;
	
	// ------                                                                                    ------
  // ------ Rollup the offender data - but make sure you keep any evidence of incarceration   ------ 
	// ------  or parole                                                                         ------
	// ------                                                                                    ------
	OffenderDataDeduped := rollup(OffenderDataSorted, deduptheOffenderData(left, right), seq, did, offender_key);	

 // ------                                             ------
	// ------  Each offense could have punishments        ------
	// ------  Punishments include incarceration          ------ 
	// ------  and possible parole dates                  ------
	// ------      KEY_ PUNISHMENT                        ------
	// ------                                             ------
	
	WithPunishmentData := JOIN (OffenderDataDeduped, doxie_files.Key_Punishment(isFCRA), 
									 keyed(left.Offender_key = right.ok), 
          TRANSFORM (DueDiligence.Layouts.CriminalOffenseLayout_by_DIDOffense,
									          /* pass the data needed from the LEFT */
														SELF.seq                   := LEFT.seq,                                                            //***this is the sequence number that ties back to the input transaction (could be business or individual) 
														SELF.did                   := LEFT.did,
														/* pass the data needed from the RIGHT */
														SELF.punishment_type       := RIGHT.punishment_type,
														SELF.curr_stat_inm         := RIGHT.cur_stat_inm_desc,
														IncarBegin_date	           := IF(RIGHT.latest_adm_dt[1..6] <> '', RIGHT.latest_adm_dt[1..6], '');  //this is the begin date of incarceration
														IncarEnd_date		            := MAP(                                                   //choose any of these 3
														                                  RIGHT.act_rel_dt <> ''		=>	RIGHT.act_rel_dt[1..6],	//as the end date of incarceration 
											                                     RIGHT.ctl_rel_dt <> ''		=>	RIGHT.ctl_rel_dt[1..6],	//release dates if populated
											                                     RIGHT.sch_rel_dt <> ''		=>	RIGHT.sch_rel_dt[1..6],
																								                                                   '');
		            ParoleBegin_date	          := IF(RIGHT.par_st_dt <> '', RIGHT.par_st_dt, '');                       //this is the begin date of parole
		            ParoleEnd_date		           := MAP(                                                                  //choose any of these 2
								                                        RIGHT.par_sch_end_dt <> ''		=>	RIGHT.par_sch_end_dt,	             //this is the end date of parole 
											                                     RIGHT.par_act_end_dt <> ''		=>	RIGHT.par_act_end_dt,	             //end dates if populated
												  																			              /* default */                  '');
														/* From the punishment - if the IncarBegin date is BEFORE the history date, that is evidence of EVER incarceration */ 
														/*  Notice we are not checking the end date for EVER                                                          */  
														SELF.Ever_incarc_Punishments  := IF(IncarBegin_date <> '' and 
														                                    IncarBegin_date < (string)LEFT.historydate,       'Y', 'N');
														self.Curr_incarc_Punishments 	:= IF(IncarBegin_date <> '' and 
														                                    IncarEnd_date   <> '' and 
																																                  IncarBegin_date <= (string)LEFT.historydate and 
																																									         IncarEnd_date   >= (string)LEFT.historydate,      'Y', 'N');   
														/* From the punishment - if the parolebegin date is BEFORE the history date AND the paroleEnd date is AFTER the history date, that is evidence of current parole */  
														self.Curr_parole_Punishments 	:= IF((ParoleBegin_date <> '' AND
														                                    ParoleEnd_date <> ''    AND
														                                    ParoleBegin_date < (string)LEFT.historydate   AND
																															                   ParoleEnd_date   > (string)LEFT.historydate)  OR
																                                  TRIM(RIGHT.cur_stat_inm_desc) = 'PAROLE',               'Y', 'N');   
														/* pass the rest of the data from the LEFT  */  
										    SELF                         := LEFT),
									 LEFT OUTER,  /* At least one record for every record in the leftrecset. */  
									 atmost(DueDiligence.Constants.MAX_ATMOST_OFFENSES), 
									 KEEP(DueDiligence.Constants.MAX_KEEP));					
	
	// ------                                             ------
	// ------  Get data for an offense from the           ------
	// ------      KEY_ OFFENSES                          ------
	WithoffensesData := join(WithPunishmentData, doxie_files.Key_Offenses(isFCRA), 
									keyed(left.Offender_key = right.ok),
									TRANSFORM (DueDiligence.Layouts.CriminalOffenseLayout_by_DIDOffense,
									          /* pass the data needed from the LEFT */
														SELF.seq                   := LEFT.seq,                                                         //***this is the sequence number that ties back to the input transaction (could be business or individual) 
														SELF.did                   := LEFT.did,
														/* from the RIGHT - find the position of the data */
														/*  Look for the 1st word 'Date:' in the string field     */
														posBeg                     := stringlib.stringfind(RIGHT.stc_desc_2, 'Date:', 1);                //format is 'Sent Start Date: yyyymmdd Sent End Date: yyyymmdd'
		            Incarbeg_dt	               := if(posBeg <> 0, RIGHT.stc_desc_2[posBeg+6..posBeg+11], '');        //position at start date and grab yyyymm
		            Incarbeg_dt_isNumeric      := Risk_Indicators.IsAllNumeric(IncarBeg_dt);
		            IncarBegin_date            := if(Incarbeg_dt_isNumeric, Incarbeg_dt, '');
		            SELF.stc_desc_2            := RIGHT.stc_desc_2,
		            SELF.Ever_incarc_offenses  := IF(IncarBegin_date <> '' and 
								                                       IncarBegin_date < (string)LEFT.historydate, 'Y', 'N'),
								      /*  Look for the 2nd word 'Date:' in the string field     */  
								      posEnd                     := stringlib.stringfind(RIGHT.stc_desc_2, 'Date:', 2);
											   Incarend_dt	               := if(posEnd <> 0, RIGHT.stc_desc_2[posEnd+6..posEnd+11], '');        //position at end date and grab yyyymm
												  Incarend_dt_isNumeric      := Risk_Indicators.IsAllNumeric(Incarend_dt);
													 IncarEnd_date	             := if(Incarend_dt_isNumeric, 
													                                     Incarend_dt, 
																															               /*ELSE*/  
													                                     IF(TRIM(RIGHT.stc_lgth_desc) = 'LIFE', '999999', ''));       //if life sentence, set end date to max
														SELF.Curr_incarc_offenses 	:= IF(IncarBegin_date <> '' AND 
														                              IncarEnd_date   <> '' AND 
																													               IncarBegin_date <= (string)LEFT.historydate AND 
																																				        IncarEnd_date   >= (string)LEFT.historydate,   'Y', 'N'); 	
														/* pass the rest of the data from the LEFT  */  
										    SELF                       := LEFT), 
									LEFT OUTER,  /* At least one record for every record in the leftrecset. */  
									ATMOST(DueDiligence.Constants.MAX_ATMOST_OFFENSES), 
									KEEP(DueDiligence.Constants.MAX_KEEP));	
	
	// ------                                                  ------
	// ------  Pick up some information about each             ------
	// ------  offense the offender has been accused of.       ------ 
	// ------  Each OFFENDER could have more than 1 OFFENSE    ------
	// ------  listed in this result set and each OFFENSE      ------
	// ------  will contain values to indicate the type of     ------
	// ------  OFFENSE (based on offender level, offense score ------
	// ------  and court offense level                         ------
	// ------         KEY_ OFFENDERS_RISK                      ------  
	// ------                                                  ------
 WithOffendersRiskData := JOIN (WithoffensesData, doxie_files.key_offenders_risk, 
                     (LEFT.did != 0) AND 
									      KEYED (LEFT.did = RIGHT.sdid) AND
									            (LEFT.offender_key = RIGHT.offender_key), 
              TRANSFORM (DueDiligence.Layouts.CriminalOffenseLayout_by_DIDOffense,
									             /* pass the data needed from the LEFT */
														   SELF.seq                   := LEFT.seq,                             //***this is the sequence number that ties back to the input transaction (could be business or individual) 
														   SELF.did                   := LEFT.did,
													       	/* pass the data needed from the RIGHT */
													   	 SELF.convictionFlag        := RIGHT.conviction_flag;
														   SELF.trafficFlag           := RIGHT.traffic_flag;
														   SELF.untouchedearliestOffenseDate := RIGHT.earliest_offense_date,  //***preserve the earliest_offense_date for the report
														   SELF.earliestOffenseDate   := RIGHT.earliest_offense_date,         //***this date is used to calculate the age of offense and will be cleaned in a later step
														   SELF.charge                := RIGHT.offense.court_off_desc_1,
													   	 SELF.courtOffenseLevel		   := RIGHT.offense.court_off_lev,
														   SELF.untouchedOffenseScore := RIGHT.offense_Score,                 //***preserve the offense score that was found from the key 
														   SELF.offenseScore          := RIGHT.offense_Score,                 //*** this score could get updated in a later step with logic to handle the 'UNKNOWN' convictions.
														   SELF.criminalOffenderLevel := RIGHT.criminal_offender_level, 
														   SELF.courtStatute          := RIGHT.offense.court_statute,
														   SELF.courtStatuteDesc      := RIGHT.offense.court_statute_desc,
														   SELF.courtDispDesc1        := RIGHT.offense.court_disp_desc_1,
														   SELF.courtDispDesc2        := RIGHT.offense.court_disp_desc_2,
														   SELF.offenseDate           := RIGHT.offense.off_date,
														   SELF.arrestDate            := RIGHT.offense.arr_date,
														   SELF.courtDispDate         := RIGHT.offense.court_disp_date,
														   SELF.sentenceDate          := RIGHT.offense.sent_date,
														   SELF.appealDate            := RIGHT.offense.appeal_date,
														   SELF.caseNum               := RIGHT.case_num,
														   SELF.caseCourt             := RIGHT.case_court,
														   SELF.courtType             := RIGHT.source_file,   
														   SELF.file_date             := RIGHT.file_date,
														   SELF.countyOfOrigin        := RIGHT.county_of_origin,
														   SELF.origState             := RIGHT.orig_state,
														   SELF                       := LEFT,  //Pass all of the remaining fields forward from the LEFT
	                SELF                       := []),   //All other fields will get populated in further processing
									 LEFT OUTER,  
									 atmost(DueDiligence.Constants.MAX_ATMOST_OFFENSES), 
									 KEEP(DueDiligence.Constants.MAX_KEEP));	

 // ------                                                  ------
	// ------  Pick up some information about each             ------
	// ------  offense the offender has been accused of.       ------ 
	// ------         KEY_ COURT_OFFENSES                      ------  
	// ------                                                  ------
 WithCourtOffenseData := JOIN (WithOffendersRiskData, doxie_files.Key_Court_Offenses(isFCRA), 
              keyed(left.Offender_key = right.ofk), 
              TRANSFORM (DueDiligence.Layouts.CriminalOffenseLayout_by_DIDOffense,
									             /* pass the data needed from the LEFT */
														   SELF.seq                   := LEFT.seq,                             //***this is the sequence number that ties back to the input transaction (could be business or individual) 
														   SELF.did                   := LEFT.did,
													       	/* pass the data needed from the RIGHT */
													   	SELF.arr_off_lev_mapped    := RIGHT.arr_off_lev_mapped,
														   SELF.court_off_lev_mapped  := RIGHT.court_off_lev_mapped,
														   SELF                       := LEFT,  //Pass all of the remaining fields forward from the LEFT
	                SELF                       := []),   //All other fields will get populated in further processing
									 LEFT OUTER,  
									 atmost(DueDiligence.Constants.MAX_ATMOST_OFFENSES), 
									 KEEP(DueDiligence.Constants.MAX_KEEP));	

 
  //*****BEGIN FOR TESTING ONLY
   //   BuildSomeTestCases  := DueDiligence.ForTesting_Business_LAF.MockUpCriminalData(WithOffenseRiskData);	

  //****END FOR TESTING ONLY
 
 
 // ----                                                                                 ------	
	// ---- Dates in the raw data are not guaranteed to be clean.  Go through and           ------
	// ---- clean any dates(upto 10) used to calculate the attributes                       ------
	// ---- pass in the resultset and the name of each date in the result set that needs    ------
	// ---- to be cleaned.                                                                  ------
	// ----  CAUTION:  if you plan to a vendor supplied date to do a calculation and the    ------
	// ---- same date is displayed in the report you should show both the cleaned date and  ------
	// ---- and the vendor supplied date.                                                   ------
	// ----                                                                                 ------
	//OffenseRiskCleanDates   :=  DueDiligence.Common.CleanDatasetDateFields(BuildSomeTestCases, 'earliestOffenseDate'); 
	
	OffenseRiskCleanDates   :=  DueDiligence.Common.CleanDatasetDateFields(WithCourtOffenseData, 'earliestOffenseDate'); 
	
	// ------                                                                                    ------
 // ------ Filter the offenses that are not in scope for this run when we have an archrive    ------ 
	// ------ date present in the input file                                                     ------
	// ------
	OffenseRiskFiltered      :=  DueDiligence.Common.FilterRecordsSingleDate(OffenseRiskCleanDates, earliestOffenseDate);    
	
	// ------                                                                                    ------
 // ------ Calculate how old each offense is and do some additional work on the data          ------ 
	// ------                                                                                    ------
	OffenseRiskCalculateAge  := PROJECT(OffenseRiskFiltered, TRANSFORM(RECORDOF (OffenseRiskFiltered), 
	                                    SELF.offenseScore                := IF(LEFT.offenseScore IN DueDiligence.Constants.UNKNOWN_OFFENSES,         //** If the offense score is UNKNOWN
																			                                       DueDiligence.Common.LookAtOther(LEFT.courtOffenseLevel,                 
																				                                                                     LEFT.charge, 
																																																						 LEFT.courtDispDesc1, 
																																																						 LEFT.courtDispDesc2,
																																																						 LEFT.arr_off_lev_mapped,
																																																						LEFT.court_off_lev_mapped),              //** THEN look at courtoffenseLevel and/or charge
																			                                       LEFT.offenseScore),                                                     //** ELSE just keep the offense score as is
	                                      /*  Calculate how old each offense is based on the earliest offense date */  
																			SELF.NumOfDaysAgo                := DueDiligence.Common.DaysApartWithZeroEmptyDate((STRING)LEFT.earliestOffenseDate, (STRING)LEFT.DateToUse),
																			SELF                             := LEFT;));
											
 // ------                                                                                    ------
 // ------ Sort the offenses in offender_key sequence so that we can roll up the data         ------ 
	// ------ to the offense and case number                                                     ------
	// ------                                                                                    ------	
	
  OffenseDataSorted  :=  sort(OffenseRiskCalculateAge, seq, did, offender_key, caseNum, -criminalOffenderLevel);                               //criminalOffenderLevel 4's should show up at the top
	
	// ------                                                                                    ------
 // ------ Use this TRANSFORM for the ROLLUP                                                  ------ 
	// ------                                                                                    ------	
	recordof(OffenseDataSorted) rollupthecriminaloffenses(OffenseDataSorted le, OffenseDataSorted ri)  := TRANSFORM
	                              SELF.seq                        := ri.seq;
																															SELF.did                        := ri.did;
																															/* These are all evidence that indicates if the DID is currently incarcerated or EVER incarcerated */   
																															SELF.Curr_incarc_offenders      := IF(le.Curr_incarc_offenders   = 'Y', le.Curr_incarc_offenders,   ri.Curr_incarc_offenders);
																															SELF.Curr_incarc_offenses       := IF(le.Curr_incarc_offenses    = 'Y', le.Curr_incarc_offenses,    ri.Curr_incarc_offenses);
																															SELF.Curr_incarc_punishments    := IF(le.Curr_incarc_punishments = 'Y', le.Curr_incarc_punishments, ri.Curr_incarc_punishments);
																															SELF.Ever_incarc_offenders      := IF(le.Ever_incarc_offenders   = 'Y', le.Ever_incarc_offenders,   ri.Ever_incarc_offenders);
																															SELF.Ever_incarc_offenses       := IF(le.Ever_incarc_offenses    = 'Y', le.Ever_incarc_offenses,    ri.Ever_incarc_offenses);
																															SELF.Ever_incarc_Punishments    := IF(le.Ever_incarc_Punishments = 'Y', le.Ever_incarc_Punishments, ri.Ever_incarc_Punishments);
																															/* These are all evidence that indicates if the DID is currently on Parole */   
																															SELF.curr_parole_flag           := IF(le.curr_parole_flag        = 'Y', le.curr_parole_flag,        ri.curr_parole_flag);
																															SELF.Curr_parole_Punishments    := IF(le.Curr_parole_Punishments = 'Y', le.Curr_parole_Punishments, ri.Curr_parole_Punishments);
																															/* Pass all remaining fields forward from the LEFT */  
																															SELF                            := le;
	                              END;
	// ------                                                                                    ------
  // ------ Rollup the offenses to get the proper count and eliminated duplicate records       ------ 
	// ------ Note:  If the case number is blank all rows will be lumped under 1 offense         ------
	// ------                                                                                    ------
	OffenseDataRolled := rollup(OffenseDataSorted, rollupthecriminaloffenses(left, right), seq, did, offender_key, caseNum, criminalOffenderLevel);	
  	
		// ------                                                             ------
	  // ------  Summarize the Data up to the DID/Individual                ------
		// ------                                                             ------
		// ------  criminalOffenderLevel indicates convicted or non-convicted ------
		// ------   (4 and 2 are convicted, while 3 is non-convicted          ------
		// ------  and used in conjunction with offenseScore to indicate      ------
		// ------   the type of offenses                                      ------
		// ------   (F = FELONY, M = MISDEMEANOR, T = TRAFFIC, I = INFRACTIONS -----
		// ------                                                             ------
		SummaryOffensesFelony := table(OffenseDataRolled,
	                               /* columns in the table */  
	                              {seq, 
																 did, 
																 HistoryDate,
																 DateToUse,
                                   																 
																 TotalEverIncarcerations                                      := SUM(GROUP, (integer)(Ever_incarc_offenses  = DueDiligence.Constants.YES
																                                                                 OR Ever_incarc_offenders = DueDiligence.Constants.YES
																																																                                 OR Ever_incarc_Punishments = DueDiligence.Constants.YES)),																														 
                 TotalCurrentIncarcerations                                   := SUM(GROUP, (integer)(Curr_incarc_offenses  = DueDiligence.Constants.YES
																                                                                 OR Curr_incarc_offenders  = DueDiligence.Constants.YES
																																																                                 OR Curr_incarc_Punishments = DueDiligence.Constants.YES)),																																																 
																 TotalCurrentParoles                                          := SUM(GROUP, (integer)(curr_parole_flag = DueDiligence.Constants.YES
																                                                                 OR Curr_parole_Punishments = DueDiligence.Constants.YES)), 																																			
                                   																 
																 TotalConvictedFelonies4F_OVERNYR    /*4F Over n years */     := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.NONTRAFFIC_CONVICTED  
		                                                                               AND  offenseScore = DueDiligence.Constants.FELONY  
																																		                                               AND  NumOfDaysAgo > ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK))),
																																																									 
																 TotalConvictedFelonies4F_NY    /*4F in last N# of years*/    := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.NONTRAFFIC_CONVICTED  
																                                                                 AND  offenseScore = DueDiligence.Constants.FELONY  
																																																                                 AND  NumOfDaysAgo <= ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK))),
																																																																 
																 TotalConvictedFelonies4F_EVER    /*4F EVER*/                 := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.NONTRAFFIC_CONVICTED  
		                                                                               AND  offenseScore = DueDiligence.Constants.FELONY)),  																													
																																		 
																 TotalConvictedUnknowns4U_OVERNYR  /*4U Over N years */       := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.NONTRAFFIC_CONVICTED
																                                                                 AND  offenseScore IN DueDiligence.Constants.UNKNOWN_OFFENSES
																																																                                 AND  NumOfDaysAgo > ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK))),
																																																 
																 TotalConvictedUnknowns4U_NY    /*4U in last N# of years*/    := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.NONTRAFFIC_CONVICTED
																                                                                 AND  offenseScore IN DueDiligence.Constants.UNKNOWN_OFFENSES
																																																                                 AND  NumOfDaysAgo <= ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK))),
																																																 
																 TotalConvictedFelonies4U_EVER  /*4U EVER*/   								        := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.NONTRAFFIC_CONVICTED
																                                                                 AND  offenseScore IN DueDiligence.Constants.UNKNOWN_OFFENSES)),  			 
																																										 
																 TotalConvictedMisdemeanor4M_OVERNYR /*4M*/                   := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.NONTRAFFIC_CONVICTED
																                                                                 AND  offenseScore = DueDiligence.Constants.MISDEMEANOR
																																																                                 AND  NumOfDaysAgo > ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK))),
																																																 
																 TotalConvictedMisdemeanor4M_NY /*4M*/                        := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.NONTRAFFIC_CONVICTED
																                                                                 AND  offenseScore = DueDiligence.Constants.MISDEMEANOR
																																																                                 AND  NumOfDaysAgo <= ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK))),
																																																 
																 TotalConvictedMisdemeanor4M_EVER  /*4M EVER*/   						        := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.NONTRAFFIC_CONVICTED
																                                                                 AND  offenseScore = DueDiligence.Constants.MISDEMEANOR)), 
																																																
																TotalNonConvictedFelonies3F_OVERNYR /*3F  */                   := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.NONTRAFFIC_NOT_CONVICTED
																                                                                 AND  offenseScore = DueDiligence.Constants.FELONY
                                                                                 AND  NumOfDaysAgo > ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK))),
																																																 
																TotalNonConvictedFelonies3F_NY /*3F in last N# of years*/     := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.NONTRAFFIC_NOT_CONVICTED
																                                                                 AND  offenseScore = DueDiligence.Constants.FELONY
																																																                                 AND  NumOfDaysAgo <= ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK))),
																																																 
																TotalNonConvictedFelonies3F_EVER /*3F EVER*/                  := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.NONTRAFFIC_NOT_CONVICTED
																                                                                 AND  offenseScore = DueDiligence.Constants.FELONY)), 
																																																  																																					
																TotalNonConvictedUnknowns3U_OVERNYR /*3U  */                  := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.NONTRAFFIC_NOT_CONVICTED
																                                                                 AND  offenseScore IN DueDiligence.Constants.UNKNOWN_OFFENSES
																																																                                 AND  NumOfDaysAgo > ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK))),
																																																																 
																TotalNonConvictedUnknowns3U_NY /*3U in last N# of years*/     := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.NONTRAFFIC_NOT_CONVICTED
																                                                                 AND  offenseScore IN DueDiligence.Constants.UNKNOWN_OFFENSES
																																																                                 AND  NumOfDaysAgo <= ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK))),
																																																 
																TotalNonConvictedUnknowns3U_EVER/*3U EVER*/                   := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.NONTRAFFIC_NOT_CONVICTED
																                                                                 AND  offenseScore IN DueDiligence.Constants.UNKNOWN_OFFENSES)), 
	 
																TotalNonConvictedMisdemeanor3M_OVERNYR /*3M in last year*/    := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.NONTRAFFIC_NOT_CONVICTED
																                                                                 AND  offenseScore = DueDiligence.Constants.MISDEMEANOR
																																																                                 AND  NumOfDaysAgo > ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK))),
																																																 
																TotalNonConvictedMisdemeanor3M_NY /*3M in last N# of years*/  := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.NONTRAFFIC_NOT_CONVICTED
																                                                                 AND  offenseScore = DueDiligence.Constants.MISDEMEANOR
																																																                                 AND  NumOfDaysAgo <= ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK))),
																																																 
															  TotalNonConvictedMisdemeanor3M_EVER /*3M EVER*/               := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.NONTRAFFIC_NOT_CONVICTED
																                                                                 AND  offenseScore = DueDiligence.Constants.MISDEMEANOR)),
																																																 
																TotalConvictedTraffic2T_OVERNYR     /*2T*/                     := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.TRAFFIC_CONVICTED
																                                                                 AND  offenseScore = DueDiligence.Constants.TRAFFIC
																																																                                 AND  NumOfDaysAgo > ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK))),
																																																
																TotalConvictedTraffic2T_NY     /*2T*/                         := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.TRAFFIC_CONVICTED
																                                                                 AND  offenseScore = DueDiligence.Constants.TRAFFIC
																																															 	                                AND  NumOfDaysAgo <= ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK))),
																																																																
																TotalConvictedTraffic2T_EVER     /*2T*/                       := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.TRAFFIC_CONVICTED
																                                                                 AND  offenseScore = DueDiligence.Constants.TRAFFIC)),
																																															 	                                
																																																																															
																TotalConvictedInfractions2I_OVERNYR /*2I*/                    := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.TRAFFIC_CONVICTED
																                                                                 AND  offenseScore = DueDiligence.Constants.INFRACTION
																																																                                 AND  NumOfDaysAgo > ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK))),
																																																
																TotalConvictedInfractions2I_NY  /*2I*/                        := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.TRAFFIC_CONVICTED
																                                                                 AND  offenseScore = DueDiligence.Constants.INFRACTION
																																																                                 AND  NumOfDaysAgo <= ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK))),
																																																																 
																TotalConvictedInfractions2I_EVER  /*2I*/                      := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.TRAFFIC_CONVICTED
																                                                                 AND  offenseScore = DueDiligence.Constants.INFRACTION)),
																																																                                 
																																																
															  /*  Calculate the TOTAL of all OFFENSES for this DID  */   
																TotalOffensesThisDID                                          := COUNT(GROUP) 
				
															  /*end of columns in the table */ },
																/* Grouped by */  
																seq, did);
																
	// ------                                                                                    ------
	// ------ Do the final join back to the businessExecutives input                             ------ 
  // ------ with the criminal offenses found for these executives                              ------
	// ------                                                                                    ------ 	
  AddCriminalOffenses := JOIN(Individuals, SummaryOffensesFelony,
									LEFT.seq       = RIGHT.seq AND
									LEFT.party.did = RIGHT.did,
									//left.origdid = right.origdid,
									TRANSFORM(DueDiligence.LayoutsInternal.RelatedParty,
									          /*  If the curr_incar_flag was set to yes on any of the offenses it was counted and rolled up to the DID */  
									     SELF.party.EverIncarcer                           := IF(RIGHT.TotalEverIncarcerations > 0, true, false), 
														SELF.party.CurrParole                             := IF(RIGHT.TotalCurrentParoles > 0, true, false), 
														SELF.party.CurrIncarcer                           := IF(RIGHT.TotalCurrentIncarcerations > 0, true, false), 
														
									     SELF.party.ConvictedFelonyCount4F_Ever            := RIGHT.TotalConvictedFelonies4F_EVER,
														SELF.party.ConvictedFelonyCount4F_OVNYR           := RIGHT.TotalConvictedFelonies4F_OVERNYR,
														SELF.party.ConvictedFelonyCount4F_NYR             := RIGHT.TotalConvictedFelonies4F_NY,
														
														SELF.party.ConvictedUnknownCount4U_Ever           := RIGHT.TotalConvictedFelonies4U_EVER,
														SELF.party.ConvictedUnknownCount4U_OVNYR          := RIGHT.TotalConvictedUnknowns4U_OVERNYR,
														SELF.party.ConvictedUnknownCount4U_NYR            := RIGHT.TotalConvictedUnknowns4U_NY,
														
														SELF.party.ConvictedMisdemeanorCount4M_Ever       := RIGHT.TotalConvictedMisdemeanor4M_EVER,
														SELF.party.ConvictedMisdemeanorCount4M_OVNYR      := RIGHT.TotalConvictedMisdemeanor4M_OVERNYR,
														SELF.party.ConvictedMisdemeanorCount4M_NYR        := RIGHT.TotalConvictedMisdemeanor4M_NY,
														
														SELF.party.NonConvictedFelonyCount3f_Ever         := RIGHT.TotalNonConvictedFelonies3F_EVER,
														SELF.party.NonConvictedFelonyCount3F_OVNYR        := RIGHT.TotalNonConvictedFelonies3F_OVERNYR,
														SELF.party.NonConvictedFelonyCount3F_NYR          := RIGHT.TotalNonConvictedFelonies3F_NY,
														
              SELF.party.NonConvictedUnknownCount3U_EVER        := RIGHT.TotalNonConvictedUnknowns3U_EVER,														
														SELF.party.NonConvictedUnknownCount3U_OVNYR       := RIGHT.TotalNonConvictedUnknowns3U_OVERNYR,
														SELF.party.NonConvictedUnknownCount3U_NYR         := RIGHT.TotalNonConvictedUnknowns3U_NY,
														
														SELF.party.NonConvictedMisdemeanorCount3M_EVER    := RIGHT.TotalNonConvictedMisdemeanor3M_EVER,
														SELF.party.NonConvictedMisdemeanorCount3M_OVNYR   := RIGHT.TotalNonConvictedMisdemeanor3M_OVERNYR,
														SELF.party.NonConvictedMisdemeanorCount3M_NYR     := RIGHT.TotalNonConvictedMisdemeanor3M_NY,
														
														SELF.party.ConvictedTraffic2T_Ever                := RIGHT.TotalConvictedTraffic2T_EVER,
														SELF.party.ConvictedTraffic2T_OVNYR               := RIGHT.TotalConvictedTraffic2T_OVERNYR,
														SELF.party.ConvictedTraffic2T_NYR                 := RIGHT.TotalConvictedTraffic2T_NY,
														
														SELF.party.ConvictedInfractions2I_Ever            := RIGHT.TotalConvictedInfractions2I_EVER,
														SELF.party.ConvictedInfractions2I_OVNYR           := RIGHT.TotalConvictedInfractions2I_OVERNYR,
														SELF.party.ConvictedInfractions2I_NYR             := RIGHT.TotalConvictedInfractions2I_NY,
														
														SELF.party.ALLOffensesForThisDID                  := RIGHT.TotalOffensesThisDID,
														self := left),
									left outer);
	

	
	// -----                                   ----
	// ----- FOR SPECIAL VALIDATION            ----
	// ----- Convert the list into             ----
	// -----  a DATASET this will              ----
	// ----- allow me to INSERT the entire     ----	
  // ----- DATASET as a WHOLE to create      ----
  // ----- a CHILD DATASET of OFFENSES for   ----
  // ----- each DID in the Related Parties   ----
  // -----                                   ----
   DIDOffensesPreSort  := PROJECT(OffenseDataRolled, 
	                                 TRANSFORM(DueDiligence.LayoutsInternal.CriminalDATASETLayout,
	                                    SELF.DIDOffenses := PROJECT(LEFT, 
																			                                              TRANSFORM(DueDiligence.Layouts.CriminalOffenseLayout_by_DIDOffense,
																			                                                    SELF.earliestOffenseDate   := (STRING8)LEFT.earliestOffenseDate,
																																				                                   SELF                       := LEFT;));
																		                  	SELF := LEFT;));
																			
	// -----                             ----
	// ----- FOR SPECIAL VALIDATION      ----
	// ----- SORT the newly created      ----
	// -----  DATASET of Offenses in     ----
	// -----  seq and DID sequences      ----
																																		
	DIDOffensesSorted    := SORT(DIDOffensesPreSort, seq, did);
	rollcriminaloffenses := ROLLUP(DIDOffensesSorted,
													 LEFT.seq = RIGHT.seq AND  
												  LEFT.did = RIGHT.did,  
			 										TRANSFORM(DueDiligence.LayoutsInternal.CriminalDATASETLayout,
			 															SELF.DIDOffenses := LEFT.DIDOffenses + RIGHT.DIDOffenses;
			 															SELF := LEFT;));
																																			
	// -----                             ----
	// ----- FOR SPECIAL VALIDATION      ----
  // ----- Using a DENORMALIZE to JOIN ----
  // -----  and
	// ----- INSERT the DATASET into     ----
	// -----  a PARENT - in this case    ----
	// -----  Related Party              ----															
	addCriminalToRelatedParty := DENORMALIZE(AddCriminalOffenses, rollcriminaloffenses,
															LEFT.seq = RIGHT.seq   AND
												   LEFT.party.did = RIGHT.did,   
	 														TRANSFORM(DueDiligence.LayoutsInternal.RelatedParty,
	 																			SELF.party.partyOffenses := RIGHT.DIDOffenses;
	 																			SELF := LEFT;));
									
	// ********************
	//   DEBUGGING OUTPUTS
	// ********************   	
	 IF(DebugMode,     OUTPUT(CHOOSEN(StartBuildingOffenderData, 50),          NAMED('StartBuildingOffenderData')));
	 IF(DebugMode,     OUTPUT(CHOOSEN(OffenderDataDeduped, 50),                NAMED('OffenderDataDeduped')));
	 IF(DebugMode,     OUTPUT(CHOOSEN(WithPunishmentData, 50),                  NAMED('WithPunishmentData')));    	
	 //IF(DebugMode,     OUTPUT(CHOOSEN(WithPunishmentData, 50),               NAMED('WithPunishmentData')));    	
	 IF(DebugMode,     OUTPUT(CHOOSEN(WithoffensesData, 50),                    NAMED('WithoffensesData')));    	
	 IF(DebugMode,     OUTPUT(CHOOSEN(WithOffendersRiskData, 150),              NAMED('WithOffendersRiskData')));
	 IF(DebugMode,     OUTPUT(CHOOSEN(WithCourtOffenseData, 150),                NAMED('WithCourtOffenseData')));    	    	 	
	// IF(DebugMode,     OUTPUT(CHOOSEN(BuildSomeTestCases, 150),         NAMED('BuildSomeTestCases')));    	
	 IF(DebugMode,     OUTPUT(CHOOSEN(OffenseRiskCleanDates, 150),               NAMED('OffenseRiskCleanDates')));    	
	 IF(DebugMode,     OUTPUT(CHOOSEN(OffenseRiskFiltered, 150),                  NAMED('OffenseRiskFiltered')));    	
	 IF(DebugMode,     OUTPUT(CHOOSEN(OffenseRiskCalculateAge, 150),              NAMED('OffenseRiskCalculateAge')));    	
	 IF(DebugMode,     OUTPUT(CHOOSEN(OffenseDataRolled, 150),                    NAMED('OffenseDataRolled')));    	
	 IF(DebugMode,     OUTPUT(CHOOSEN(SummaryOffensesFelony, 150),                NAMED('SummaryOffensesFelony')));    	
	 IF(DebugMode,     OUTPUT(CHOOSEN(AddCriminalOffenses, 150),                   NAMED('AddCriminalOffenses')));    	
	 IF(DebugMode,     OUTPUT(CHOOSEN(DIDOffensesPreSort, 150),                   NAMED('DIDOffensesPreSort')));    	
	 IF(DebugMode,     OUTPUT(CHOOSEN(DIDOffensesSorted, 150),                   NAMED('DIDOffensesSorted')));    	
	 IF(DebugMode,     OUTPUT(CHOOSEN(rollcriminaloffenses, 150),                   NAMED('rollcriminaloffenses')));    	
	 IF(DebugMode,     OUTPUT(CHOOSEN(addCriminalToRelatedParty, 150),                   NAMED('addCriminalToRelatedParty')));    	

RETURN addCriminalToRelatedParty;

END;
