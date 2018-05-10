Import DueDiligence, SexOffender, Risk_indicators, doxie_files, SexOffender_Services, RiskWise, ut, VerificationOfOccupancy, liensv2, STD, iesp;


EXPORT getIndCriminal(DATASET(DueDiligence.LayoutsInternal.RelatedParty) Individuals ,
                      boolean ReportIsRequested = FALSE,  
                      boolean debugmode = FALSE,  
                      boolean isFCRA = false) := FUNCTION
	
  
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
  // ------ Rollup the offender data - but make sure you keep any evidence of incarceration   ------ 
	// ------  or parole                                                                         ------
	// ------                                                                                    ------
	OffenderDataDeduped := rollup(OffenderDataSorted, 
                                LEFT.seq = RIGHT.seq AND
                                LEFT.did = RIGHT.did AND
                                LEFT.offender_key = RIGHT.offender_key,
                                TRANSFORM(RECORDOF(LEFT),
                                           /* These are all evidence that indicates if the DID is currently incarcerated or EVER incarcerated */   
                                           SELF.Curr_incarc_offenders      := IF(LEFT.Curr_incarc_offenders   = 'Y', LEFT.Curr_incarc_offenders,   RIGHT.Curr_incarc_offenders);
                                           SELF.Ever_incarc_offenders      := IF(LEFT.Ever_incarc_offenders   = 'Y', LEFT.Ever_incarc_offenders,   RIGHT.Ever_incarc_offenders);
                                           /* These are all evidence that indicates if the DID is currently on Parole */   
                                           SELF.curr_parole_flag           := IF(LEFT.curr_parole_flag        = 'Y', LEFT.curr_parole_flag,        RIGHT.curr_parole_flag);
                                           /* Pass all remaining fields forward from the LEFT */  
                                           SELF := LEFT;));	

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
                                           SELF.sent_probation        := RIGHT.sent_probation,
                                           SELF                       := LEFT,  //Pass all of the remaining fields forward from the LEFT
                                           SELF                       := []),   //All other fields will get populated in further processing
                                LEFT OUTER,  
                                atmost(DueDiligence.Constants.MAX_ATMOST_OFFENSES), 
                                KEEP(DueDiligence.Constants.MAX_KEEP));	

 
  // ----                                                                                 ------	
	// ---- Dates in the raw data are not guaranteed to be clean.  Go through and           ------
	// ---- clean any dates(upto 10) used to calculate the attributes                       ------
	// ---- pass in the resultset and the name of each date in the result set that needs    ------
	// ---- to be cleaned.                                                                  ------
	// ----  CAUTION:  if you plan to a vendor supplied date to do a calculation and the    ------
	// ---- same date is displayed in the report you should show both the cleaned date and  ------
	// ---- and the vendor supplied date.                                                   ------
	// ----                                                                                 ------	
	OffenseRiskCleanDates   :=  DueDiligence.Common.CleanDatasetDateFields(WithCourtOffenseData, 'earliestOffenseDate'); 
	
	// ------                                                                                    ------
  // ------ Filter the offenses that are not in scope for this run when we have an archrive    ------ 
	// ------ date present in the input file                                                     ------
	// ------
	OffenseRiskFiltered      :=  DueDiligence.Common.FilterRecordsSingleDate(OffenseRiskCleanDates, earliestOffenseDate);  
  
	
	
	// ------                                                                                    ------
  // ------ Calculate how old each offense is and do some additional work on the data          ------ 
	// ------                                                                                    ------
	OffenseRiskCalculateAge  := PROJECT(OffenseRiskFiltered, TRANSFORM(DueDiligence.Layouts.CriminalOffenseLayout_by_DIDOffense, 
                                                                      SELF.offenseScore := IF(LEFT.offenseScore IN DueDiligence.Constants.UNKNOWN_OFFENSES,         //** If the offense score is UNKNOWN
                                                                                               DueDiligence.Common.LookAtOther(LEFT.courtOffenseLevel,                 
                                                                                                                                LEFT.charge, 
                                                                                                                                LEFT.courtDispDesc1, 
                                                                                                                                LEFT.courtDispDesc2,
                                                                                                                                LEFT.arr_off_lev_mapped,
                                                                                                                                LEFT.court_off_lev_mapped),              //** THEN look at courtoffenseLevel and/or charge
                                                                                               LEFT.offenseScore),                      //** ELSE just keep the offense score as is
                                                                      /*  Calculate how old each offense is based on the earliest offense date */  
                                                                      SELF.NumOfDaysAgo                := DueDiligence.Common.DaysApartWithZeroEmptyDate((STRING)LEFT.earliestOffenseDate, (STRING)LEFT.DateToUse),
                                                                      /* The earliest offense date was cleaned and defined as an integer by the clean date routine  */ 
                                                                      SELF.earliestOffenseDate         := (STRING)LEFT.earliestOffenseDate,
                                                                      SELF                             := LEFT;));
											
  // ------                                                                                    ------
  // ------ Sort the offenses in offender_key sequence so that we can roll up the data         ------ 
	// ------ to the offense and case number                                                     ------
	// ------                                                                                    ------	
  OffenseDataSorted  :=  sort(OffenseRiskCalculateAge, seq, did, offender_key, caseNum, -criminalOffenderLevel, earliestOffenseDate);                               //criminalOffenderLevel 4's should show up at the top
	
  
	// ------                                                                                    ------
  // ------ Rollup the offenses to get the proper count and eliminated duplicate records       ------ 
	// ------ Note:  If the case number is blank all rows will be lumped under 1 offense         ------
	// ------                                                                                    ------
	OffenseDataRolled := rollup(OffenseDataSorted, 
                              LEFT.seq = RIGHT.seq AND
                              LEFT.did = RIGHT.did AND
                              LEFT.offender_key = RIGHT.offender_key AND
                              LEFT.caseNum = RIGHT.caseNum AND
                              LEFT.criminalOffenderLevel = RIGHT.criminalOffenderLevel,
                              TRANSFORM(RECORDOF(LEFT),
                                         /* These are all evidence that indicates if the DID is currently incarcerated or EVER incarcerated */   
                                         SELF.Curr_incarc_offenders      := IF(LEFT.Curr_incarc_offenders   = 'Y', LEFT.Curr_incarc_offenders,   RIGHT.Curr_incarc_offenders);
                                         SELF.Curr_incarc_offenses       := IF(LEFT.Curr_incarc_offenses    = 'Y', LEFT.Curr_incarc_offenses,    RIGHT.Curr_incarc_offenses);
                                         SELF.Curr_incarc_punishments    := IF(LEFT.Curr_incarc_punishments = 'Y', LEFT.Curr_incarc_punishments, RIGHT.Curr_incarc_punishments);
                                         SELF.Ever_incarc_offenders      := IF(LEFT.Ever_incarc_offenders   = 'Y', LEFT.Ever_incarc_offenders,   RIGHT.Ever_incarc_offenders);
                                         SELF.Ever_incarc_offenses       := IF(LEFT.Ever_incarc_offenses    = 'Y', LEFT.Ever_incarc_offenses,    RIGHT.Ever_incarc_offenses);
                                         SELF.Ever_incarc_Punishments    := IF(LEFT.Ever_incarc_Punishments = 'Y', LEFT.Ever_incarc_Punishments, RIGHT.Ever_incarc_Punishments);
                                         /* These are all evidence that indicates if the DID is currently on Parole */   
                                         SELF.curr_parole_flag           := IF(LEFT.curr_parole_flag        = 'Y', LEFT.curr_parole_flag,        RIGHT.curr_parole_flag);
                                         SELF.Curr_parole_Punishments    := IF(LEFT.Curr_parole_Punishments = 'Y', LEFT.Curr_parole_Punishments, RIGHT.Curr_parole_Punishments);
                                         SELF.earliestOffenseDate        := IF((INTEGER)LEFT.earliestOffenseDate = 0, MAX(LEFT.earliestOffenseDate, RIGHT.earliestOffenseDate), MIN(LEFT.earliestOffenseDate, RIGHT.earliestOffenseDate));
                                         /* Pass all remaining fields forward from the LEFT */  
                                         SELF                            := LEFT;));	
  	
  
   projectOffenses := PROJECT(offenseDataRolled, TRANSFORM({UNSIGNED seq, UNSIGNED6 did, DATASET(DueDiligence.Layouts.CriminalOffenseLayout_by_DIDOffense) offenses},
                                                            SELF.offenses := DATASET([TRANSFORM(DueDiligence.Layouts.CriminalOffenseLayout_by_DIDOffense,
                                                                                                SELF := LEFT;)]);
                                                            SELF := LEFT;)); 
                                                            
   rollPersonOffenses := ROLLUP(SORT(projectOffenses, seq, did),
                                LEFT.seq = RIGHT.seq AND
                                LEFT.did = RIGHT.did,
                                TRANSFORM(RECORDOF(LEFT),
                                           SELF.offenses := LEFT.offenses + RIGHT.offenses;
                                           SELF := LEFT;));
  
  // ------                                                             ------
  // ------  Summarize the Data up to the DID/Individual                ------
  // ------                                                             ------
  // ------  criminalOffenderLevel indicates convicted or non-convicted ------
  // ------   (4 and 2 are convicted, while 3 is non-convicted          ------
  // ------  and used in conjunction with offenseScore to indicate      ------
  // ------   the type of offenses                                      ------
  // ------   (F = FELONY, M = MISDEMEANOR, T = TRAFFIC, I = INFRACTIONS -----
  // ------                                                             ------ 
	allPartyOffenses    :=  DueDiligence.subFunctions.ProcessOffenses(Individuals, OffenseDataRolled); 

  indivResults := PROJECT(allPartyOffenses, TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                                      SELF.seq := LEFT.seq;
                                                      SELF.inquiredDID := LEFT.did;
                                                      SELF.threePlusTrafConvictPast3Yrs := LEFT.TotalConvictedTraffic2T_NY >= 3;
                                                      SELF.twoOrLessTrafConvictPast3Yrs := LEFT.TotalConvictedTraffic2T_NY BETWEEN 1 AND 2;
                                                      SELF.threePlusInfractConvictPast3Yrs := LEFT.TotalConvictedInfractions2I_NY >= 3;
                                                      SELF.twoOrLessInfractConvictPast3Yrs := LEFT.TotalConvictedInfractions2I_NY BETWEEN 1 AND 2;
                                                      SELF.threePlusTrafConvictOver3Yrs := LEFT.TotalConvictedTraffic2T_OVERNYR >= 3;
                                                      SELF.twoOrLessTrafConvictOver3Yrs := LEFT.TotalConvictedTraffic2T_OVERNYR BETWEEN 1 AND 2;
                                                      SELF.threePlusInfractConvictOver3Yrs := LEFT.TotalConvictedInfractions2I_OVERNYR >= 3;
                                                      SELF.twoOrLessInfractConvictOver3Yrs := LEFT.TotalConvictedInfractions2I_OVERNYR BETWEEN 1 AND 2;
                                                      /*PerLegalStateCriminal*/
                                                      SELF.currentIncarcerationOrParole := LEFT.TotalCurrentParoles > 0 OR LEFT.TotalCurrentIncarcerations > 0;
                                                      SELF.felonyPast3Yrs := LEFT.TotalConvictedFelonies4F_NY;
                                                      SELF.felonyOver3Yrs := LEFT.TotalConvictedFelonies4F_OVERNYR;
                                                      SELF.previousIncarceration := LEFT.TotalEverIncarcerations > 0;
                                                      SELF.uncategorizedConvictionPast3Yrs := LEFT.TotalConvictedUnknowns4U_NY;
                                                      SELF.misdemeanorConvictionPast3Yrs := LEFT.TotalConvictedMisdemeanor4M_NY > 0;
                                                      SELF.uncategorizedConvictionOver3Yrs := LEFT.TotalConvictedUnknowns4U_OVERNYR;
                                                      SELF.misdemeanorConvictionOver3Years := LEFT.TotalConvictedMisdemeanor4M_OVERNYR > 0;
                                                      SELF := [];));
  
  
  offenseCalcs := JOIN(indivResults, allPartyOffenses,
                        LEFT.seq = RIGHT.seq AND
                        LEFT.inquiredDID = RIGHT.did,
                        TRANSFORM({UNSIGNED4 seq, UNSIGNED6 did, DueDiligence.LayoutsInternal.RelatedParty},
                                  SELF.party.EverIncarcer                           := RIGHT.TotalEverIncarcerations > 0, 
                                  SELF.party.CurrParole                             := RIGHT.TotalCurrentParoles > 0, 
                                  SELF.party.CurrIncarcer                           := RIGHT.TotalCurrentIncarcerations > 0, 
                                  
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
                                  
                                  SELF.party.NonConvictedTraffic1T_Ever             := RIGHT.TotalNonConvictedTraffic1T_EVER,
                                  SELF.party.NonConvictedInfraction1I_Ever          := RIGHT.TotalNonConvictedInfraction1I_EVER,
                                  
                                  SELF.party.ALLOffensesForThisDID                  := RIGHT.TotalOffensesThisDID,
                                  SELF.party.noEvidenceOfConvictedStateCrim         := RIGHT.TotalHitsStateCrim = 0;
                                  SELF.party.noEvidenceOfTrafficOrInfraction        := RIGHT.TotalHitsConvictedTrafficInfraction = 0; 
                                  
                                  trafInfrac := DueDiligence.getIndKRILegalTrafficInfraction(LEFT);
                                  SELF.party.trafficInfractionScore := trafInfrac.name;
                                  SELF.party.trafficInfractionFlags := trafInfrac.value;
                                  
                                  stateCrim := DueDiligence.getIndKRILegalStateCriminal(LEFT);
                                  SELF.party.stateCriminalLegalEventsScore := stateCrim.name;
                                  SELF.party.stateCriminalLegalEventsFlags := stateCrim.value;
                                  
                                  
                                  SELF := RIGHT;
                                  SELF := [];));
          
  
  popRelatedParty := JOIN(offenseCalcs, rollPersonOffenses,
                          LEFT.seq = RIGHT.seq AND
                          LEFT.did = RIGHT.did,
                          TRANSFORM(RECORDOF(LEFT),
                                      SELF.party.partyOffenses := RIGHT.offenses;
                                      SELF := LEFT;),
                          LEFT OUTER);
                          
  popAllParties := JOIN(Individuals, popRelatedParty,
                          LEFT.seq = RIGHT.seq AND
                          LEFT.party.did = RIGHT.did,
                          TRANSFORM(RECORDOF(LEFT),
                                     SELF.party.partyOffenses := RIGHT.party.partyOffenses;
                                     
                                     SELF.party.EverIncarcer := RIGHT.party.EverIncarcer;
                                     SELF.party.CurrParole := RIGHT.party.CurrParole; 
                                     SELF.party.CurrIncarcer := RIGHT.party.CurrIncarcer; 
                                      
                                     SELF.party.ConvictedFelonyCount4F_Ever := RIGHT.party.ConvictedFelonyCount4F_Ever;
                                     SELF.party.ConvictedFelonyCount4F_OVNYR := RIGHT.party.ConvictedFelonyCount4F_OVNYR;
                                     SELF.party.ConvictedFelonyCount4F_NYR := RIGHT.party.ConvictedFelonyCount4F_NYR;
                                     
                                     SELF.party.ConvictedUnknownCount4U_Ever := RIGHT.party.ConvictedUnknownCount4U_Ever;
                                     SELF.party.ConvictedUnknownCount4U_OVNYR := RIGHT.party.ConvictedUnknownCount4U_OVNYR;
                                     SELF.party.ConvictedUnknownCount4U_NYR := RIGHT.party.ConvictedUnknownCount4U_NYR;
                                     
                                     SELF.party.ConvictedMisdemeanorCount4M_Ever := RIGHT.party.ConvictedMisdemeanorCount4M_Ever;
                                     SELF.party.ConvictedMisdemeanorCount4M_OVNYR := RIGHT.party.ConvictedMisdemeanorCount4M_OVNYR;
                                     SELF.party.ConvictedMisdemeanorCount4M_NYR := RIGHT.party.ConvictedMisdemeanorCount4M_NYR;
                                     
                                     SELF.party.NonConvictedFelonyCount3f_Ever := RIGHT.party.NonConvictedFelonyCount3f_Ever;
                                     SELF.party.NonConvictedFelonyCount3F_OVNYR := RIGHT.party.NonConvictedFelonyCount3F_OVNYR;
                                     SELF.party.NonConvictedFelonyCount3F_NYR := RIGHT.party.NonConvictedFelonyCount3F_NYR;
                                     
                                     SELF.party.NonConvictedUnknownCount3U_EVER := RIGHT.party.NonConvictedUnknownCount3U_EVER;														
                                     SELF.party.NonConvictedUnknownCount3U_OVNYR := RIGHT.party.NonConvictedUnknownCount3U_OVNYR;
                                     SELF.party.NonConvictedUnknownCount3U_NYR := RIGHT.party.NonConvictedUnknownCount3U_NYR;
                                     
                                     SELF.party.NonConvictedMisdemeanorCount3M_EVER := RIGHT.party.NonConvictedMisdemeanorCount3M_EVER;
                                     SELF.party.NonConvictedMisdemeanorCount3M_OVNYR := RIGHT.party.NonConvictedMisdemeanorCount3M_OVNYR;
                                     SELF.party.NonConvictedMisdemeanorCount3M_NYR := RIGHT.party.NonConvictedMisdemeanorCount3M_NYR;
                                     
                                     SELF.party.ConvictedTraffic2T_Ever := RIGHT.party.ConvictedTraffic2T_Ever;
                                     SELF.party.ConvictedTraffic2T_OVNYR := RIGHT.party.ConvictedTraffic2T_OVNYR;
                                     SELF.party.ConvictedTraffic2T_NYR := RIGHT.party.ConvictedTraffic2T_NYR;
                                     
                                     SELF.party.ConvictedInfractions2I_Ever := RIGHT.party.ConvictedInfractions2I_Ever;
                                     SELF.party.ConvictedInfractions2I_OVNYR := RIGHT.party.ConvictedInfractions2I_OVNYR;
                                     SELF.party.ConvictedInfractions2I_NYR := RIGHT.party.ConvictedInfractions2I_NYR;
                                     
                                     SELF.party.NonConvictedTraffic1T_Ever := RIGHT.party.NonConvictedTraffic1T_Ever;
                                     SELF.party.NonConvictedInfraction1I_Ever := RIGHT.party.NonConvictedInfraction1I_Ever;
                                     
                                     SELF.party.ALLOffensesForThisDID := RIGHT.party.ALLOffensesForThisDID;
                                     SELF.party.noEvidenceOfConvictedStateCrim := RIGHT.party.noEvidenceOfConvictedStateCrim;
                                     SELF.party.noEvidenceOfTrafficOrInfraction := RIGHT.party.noEvidenceOfTrafficOrInfraction; 
                                     
                                     SELF.party.trafficInfractionScore := RIGHT.party.trafficInfractionScore;
                                     SELF.party.trafficInfractionFlags := RIGHT.party.trafficInfractionFlags;
                                     
                                     SELF.party.stateCriminalLegalEventsScore := RIGHT.party.stateCriminalLegalEventsScore;
                                     SELF.party.stateCriminalLegalEventsFlags := RIGHT.party.stateCriminalLegalEventsFlags;
                                  
                                     SELF := LEFT;),
                          LEFT OUTER);
  
  
 
									
	// ********************
	//   DEBUGGING OUTPUTS
	// ********************   	
	IF(DebugMode,     OUTPUT(CHOOSEN(StartBuildingOffenderData, 50),          NAMED('StartBuildingOffenderData')));
	IF(DebugMode,     OUTPUT(CHOOSEN(OffenderDataDeduped, 50),                NAMED('OffenderDataDeduped')));
	IF(DebugMode,     OUTPUT(CHOOSEN(WithPunishmentData, 50),                  NAMED('WithPunishmentData')));   	
	IF(DebugMode,     OUTPUT(CHOOSEN(WithoffensesData, 50),                    NAMED('WithoffensesData')));    	
	IF(DebugMode,     OUTPUT(CHOOSEN(WithOffendersRiskData, 150),              NAMED('WithOffendersRiskData')));
	IF(DebugMode,     OUTPUT(CHOOSEN(WithCourtOffenseData, 150),                NAMED('WithCourtOffenseData')));    
	IF(DebugMode,     OUTPUT(CHOOSEN(OffenseRiskCleanDates, 150),               NAMED('OffenseRiskCleanDates')));    	
	IF(DebugMode,     OUTPUT(CHOOSEN(OffenseRiskFiltered, 150),                  NAMED('OffenseRiskFiltered')));    	
	IF(DebugMode,     OUTPUT(CHOOSEN(OffenseRiskCalculateAge, 150),              NAMED('OffenseRiskCalculateAge')));    	
	IF(DebugMode,     OUTPUT(CHOOSEN(OffenseDataRolled, 150),                    NAMED('OffenseDataRolled')));    	
	
  
  
  // OUTPUT(StartBuildingOffenderData, NAMED('StartBuildingOffenderData'));
  // OUTPUT(OffenderDataDeduped, NAMED('OffenderDataDeduped'));
  // OUTPUT(WithPunishmentData, NAMED('WithPunishmentData'));
  // OUTPUT(WithoffensesData, NAMED('WithoffensesData'));
  // OUTPUT(WithOffendersRiskData, NAMED('WithOffendersRiskData'));
  // OUTPUT(WithCourtOffenseData, NAMED('WithCourtOffenseData'));
  // OUTPUT(OffenseRiskCalculateAge, NAMED('OffenseRiskCalculateAge'));
  // OUTPUT(OffenseDataSorted, NAMED('OffenseDataSorted'));
  // OUTPUT(OffenseDataRolled, NAMED('OffenseDataRolled'));
  // OUTPUT(projectOffenses, NAMED('projectOffenses'));
  // OUTPUT(rollPersonOffenses, NAMED('rollPersonOffenses'));

  // OUTPUT(allPartyOffenses, NAMED('allPartyOffenses'));
  // OUTPUT(indivResults, NAMED('indivResults'));
  
  // OUTPUT(offenseCalcs, NAMED('offenseCalcs'));
  // OUTPUT(popRelatedParty, NAMED('popRelatedParty'));
  // OUTPUT(popAllParties, NAMED('popAllParties'));



  RETURN popAllParties;

END;
