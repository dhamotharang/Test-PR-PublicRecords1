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
  OffenseDataSorted  :=  sort(OffenseRiskCalculateAge, seq, did, offender_key, caseNum, -criminalOffenderLevel);                               //criminalOffenderLevel 4's should show up at the top
	
  
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
                                         /* Pass all remaining fields forward from the LEFT */  
                                         SELF                            := LEFT;));	
  	
  // ------                                                             ------
  // ------  Summarize the Data up to the DID/Individual                ------
  // ------                                                             ------
  // ------  criminalOffenderLevel indicates convicted or non-convicted ------
  // ------   (4 and 2 are convicted, while 3 is non-convicted          ------
  // ------  and used in conjunction with offenseScore to indicate      ------
  // ------   the type of offenses                                      ------
  // ------   (F = FELONY, M = MISDEMEANOR, T = TRAFFIC, I = INFRACTIONS -----
  // ------                                                             ------
  calcTotals := PROJECT(OffenseDataRolled, TRANSFORM({UNSIGNED4 seq, UNSIGNED6 did, UNSIGNED4 HistoryDate, UNSIGNED4 DateToUse, UNSIGNED2 TotalEverIncarcerations, 
                                                                      UNSIGNED2 TotalCurrentIncarcerations, UNSIGNED2 TotalCurrentParoles, UNSIGNED2 TotalConvictedFelonies4F_OVERNYR, 
                                                                      UNSIGNED2 TotalConvictedFelonies4F_NY, UNSIGNED2 TotalConvictedFelonies4F_EVER, 
                                                                      UNSIGNED2 TotalConvictedUnknowns4U_OVERNYR, UNSIGNED2 TotalConvictedUnknowns4U_NY, 
                                                                      UNSIGNED2 TotalConvictedFelonies4U_EVER, UNSIGNED2 TotalConvictedMisdemeanor4M_OVERNYR, 
                                                                      UNSIGNED2 TotalConvictedMisdemeanor4M_NY, UNSIGNED2 TotalConvictedMisdemeanor4M_EVER, 
                                                                      UNSIGNED2 TotalNonConvictedFelonies3F_OVERNYR, UNSIGNED2 TotalNonConvictedFelonies3F_NY, 
                                                                      UNSIGNED2 TotalNonConvictedFelonies3F_EVER, UNSIGNED2 TotalNonConvictedUnknowns3U_OVERNYR, 
                                                                      UNSIGNED2 TotalNonConvictedUnknowns3U_NY, UNSIGNED2 TotalNonConvictedUnknowns3U_EVER, 
                                                                      UNSIGNED2 TotalNonConvictedMisdemeanor3M_OVERNYR, UNSIGNED2 TotalNonConvictedMisdemeanor3M_NY, 
                                                                      UNSIGNED2 TotalNonConvictedMisdemeanor3M_EVER, UNSIGNED2 TotalConvictedTraffic2T_OVERNYR, 
                                                                      UNSIGNED2 TotalConvictedTraffic2T_NY, UNSIGNED2 TotalConvictedTraffic2T_EVER, 
                                                                      UNSIGNED2 TotalConvictedInfractions2I_OVERNYR, UNSIGNED2 TotalConvictedInfractions2I_NY, 
                                                                      UNSIGNED2 TotalConvictedInfractions2I_EVER, UNSIGNED2 TotalOffensesThisDID, 
                                                                      UNSIGNED2 TotalHitsStateCrim, UNSIGNED2 TotalHitsTrafficInfraction},
                                                                      
                                                      SELF.TotalEverIncarcerations := (INTEGER)(LEFT.Ever_incarc_offenses  = DueDiligence.Constants.YES OR
                                                                                                LEFT.Ever_incarc_offenders = DueDiligence.Constants.YES OR
                                                                                                LEFT.Ever_incarc_Punishments = DueDiligence.Constants.YES); 
                                                                                                
                                                      SELF.TotalCurrentIncarcerations := (INTEGER)(LEFT.Curr_incarc_offenses  = DueDiligence.Constants.YES OR
                                                                                                   LEFT.Curr_incarc_offenders  = DueDiligence.Constants.YES OR
                                                                                                   LEFT.Curr_incarc_Punishments = DueDiligence.Constants.YES);
                                                                                                   
                                                      SELF.TotalCurrentParoles := (INTEGER)(LEFT.curr_parole_flag = DueDiligence.Constants.YES OR
                                                                                            LEFT.Curr_parole_Punishments = DueDiligence.Constants.YES);
                                                      
                                                      SELF.TotalConvictedFelonies4F_OVERNYR := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.NONTRAFFIC_CONVICTED, DueDiligence.Constants.FELONY, '>');
                                                      SELF.TotalConvictedFelonies4F_NY := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.NONTRAFFIC_CONVICTED, DueDiligence.Constants.FELONY, '<=');                                               
                                                      SELF.TotalConvictedFelonies4F_EVER := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.NONTRAFFIC_CONVICTED, DueDiligence.Constants.FELONY, DueDiligence.Constants.EMPTY);
                                                                                                      
                                                      SELF.TotalConvictedUnknowns4U_OVERNYR := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.NONTRAFFIC_CONVICTED, DueDiligence.Constants.UNKNOWN_OFFENSES, '>');
                                                      SELF.TotalConvictedUnknowns4U_NY := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.NONTRAFFIC_CONVICTED, DueDiligence.Constants.UNKNOWN_OFFENSES, '<=');
                                                      SELF.TotalConvictedFelonies4U_EVER := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.NONTRAFFIC_CONVICTED, DueDiligence.Constants.UNKNOWN_OFFENSES, DueDiligence.Constants.EMPTY);
                                                                                                      
                                                      SELF.TotalConvictedMisdemeanor4M_OVERNYR := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.NONTRAFFIC_CONVICTED, DueDiligence.Constants.MISDEMEANOR, '>');
                                                      SELF.TotalConvictedMisdemeanor4M_NY := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.NONTRAFFIC_CONVICTED, DueDiligence.Constants.MISDEMEANOR, '<=');
                                                      SELF.TotalConvictedMisdemeanor4M_EVER := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.NONTRAFFIC_CONVICTED, DueDiligence.Constants.MISDEMEANOR, DueDiligence.Constants.EMPTY);
                                                                                                       
                                                      SELF.TotalNonConvictedFelonies3F_OVERNYR := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.NONTRAFFIC_NOT_CONVICTED, DueDiligence.Constants.FELONY, '>');
                                                      SELF.TotalNonConvictedFelonies3F_NY := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.NONTRAFFIC_NOT_CONVICTED, DueDiligence.Constants.FELONY, '<=');
                                                      SELF.TotalNonConvictedFelonies3F_EVER := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.NONTRAFFIC_NOT_CONVICTED, DueDiligence.Constants.FELONY, DueDiligence.Constants.EMPTY);
                                                      
                                                      SELF.TotalNonConvictedUnknowns3U_OVERNYR := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.NONTRAFFIC_NOT_CONVICTED, DueDiligence.Constants.UNKNOWN_OFFENSES, '>');
                                                      SELF.TotalNonConvictedUnknowns3U_NY := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.NONTRAFFIC_NOT_CONVICTED, DueDiligence.Constants.UNKNOWN_OFFENSES, '<=');
                                                      SELF.TotalNonConvictedUnknowns3U_EVER := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.NONTRAFFIC_NOT_CONVICTED, DueDiligence.Constants.UNKNOWN_OFFENSES, DueDiligence.Constants.EMPTY);
                                                      
                                                      SELF.TotalNonConvictedMisdemeanor3M_OVERNYR := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.NONTRAFFIC_NOT_CONVICTED, DueDiligence.Constants.MISDEMEANOR, '>');
                                                      SELF.TotalNonConvictedMisdemeanor3M_NY := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.NONTRAFFIC_NOT_CONVICTED, DueDiligence.Constants.MISDEMEANOR, '<=');
                                                      SELF.TotalNonConvictedMisdemeanor3M_EVER := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.NONTRAFFIC_NOT_CONVICTED, DueDiligence.Constants.MISDEMEANOR, DueDiligence.Constants.EMPTY);
                                                      
                                                      SELF.TotalConvictedTraffic2T_OVERNYR := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.TRAFFIC_CONVICTED, DueDiligence.Constants.TRAFFIC, '>');
                                                      SELF.TotalConvictedTraffic2T_NY := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.TRAFFIC_CONVICTED, DueDiligence.Constants.TRAFFIC, '<=');
                                                      SELF.TotalConvictedTraffic2T_EVER := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.TRAFFIC_CONVICTED, DueDiligence.Constants.TRAFFIC, DueDiligence.Constants.EMPTY);
                                                      
                                                      SELF.TotalConvictedInfractions2I_OVERNYR := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.TRAFFIC_CONVICTED, DueDiligence.Constants.INFRACTION, '>');
                                                      SELF.TotalConvictedInfractions2I_NY := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.TRAFFIC_CONVICTED, DueDiligence.Constants.INFRACTION, '<=');
                                                      SELF.TotalConvictedInfractions2I_EVER := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.TRAFFIC_CONVICTED, DueDiligence.Constants.INFRACTION, DueDiligence.Constants.EMPTY);
                                                      
                                                      SELF.TotalOffensesThisDID := 1;
                                                      SELF.TotalHitsStateCrim := (INTEGER)(SELF.TotalCurrentIncarcerations > 0 OR SELF.TotalCurrentParoles > 0 OR 
                                                                                  SELF.TotalConvictedFelonies4F_NY > 0 OR
                                                                                  SELF.TotalConvictedFelonies4F_OVERNYR > 0 OR
                                                                                  SELF.TotalEverIncarcerations > 0 OR
                                                                                  SELF.TotalConvictedUnknowns4U_NY >  0 OR
                                                                                  SELF.TotalConvictedMisdemeanor4M_NY > 0 OR
                                                                                  SELF.TotalConvictedUnknowns4U_OVERNYR > 0 OR
                                                                                  SELF.TotalConvictedMisdemeanor4M_OVERNYR > 0);
                                                                                  
                                                      SELF.TotalHitsTrafficInfraction := (INTEGER)(SELF.TotalConvictedTraffic2T_NY > 0 OR
                                                                                                   SELF.TotalConvictedInfractions2I_NY > 0 OR
                                                                                                   SELF.TotalConvictedTraffic2T_OVERNYR > 0 OR
                                                                                                   SELF.TotalConvictedInfractions2I_OVERNYR > 0);                           
                                                      
                                                      SELF := LEFT;
                                                      SELF := [];));
  
  rollTotals := ROLLUP(calcTotals,
                        LEFT.seq = RIGHT.seq AND
                        LEFT.did = RIGHT.did,
                        TRANSFORM(RECORDOF(LEFT),
                                    
                                   SELF.TotalEverIncarcerations := LEFT.TotalEverIncarcerations + RIGHT.TotalEverIncarcerations;
                                   SELF.TotalCurrentIncarcerations := LEFT.TotalCurrentIncarcerations + RIGHT.TotalCurrentIncarcerations;
                                   SELF.TotalCurrentParoles := LEFT.TotalCurrentParoles + RIGHT.TotalCurrentParoles;
                                   
                                   SELF.TotalConvictedFelonies4F_OVERNYR := LEFT.TotalConvictedFelonies4F_OVERNYR + RIGHT.TotalConvictedFelonies4F_OVERNYR;
                                   SELF.TotalConvictedFelonies4F_NY := LEFT.TotalConvictedFelonies4F_NY + RIGHT.TotalConvictedFelonies4F_NY;                                               
                                   SELF.TotalConvictedFelonies4F_EVER := LEFT.TotalConvictedFelonies4F_EVER + RIGHT.TotalConvictedFelonies4F_EVER;
                                                                                   
                                   SELF.TotalConvictedUnknowns4U_OVERNYR := LEFT.TotalConvictedUnknowns4U_OVERNYR + RIGHT.TotalConvictedUnknowns4U_OVERNYR;
                                   SELF.TotalConvictedUnknowns4U_NY := LEFT.TotalConvictedUnknowns4U_NY + RIGHT.TotalConvictedUnknowns4U_NY;
                                   SELF.TotalConvictedFelonies4U_EVER := LEFT.TotalConvictedFelonies4U_EVER + RIGHT.TotalConvictedFelonies4U_EVER;
                                                                                   
                                   SELF.TotalConvictedMisdemeanor4M_OVERNYR := LEFT.TotalConvictedMisdemeanor4M_OVERNYR + RIGHT.TotalConvictedMisdemeanor4M_OVERNYR;
                                   SELF.TotalConvictedMisdemeanor4M_NY := LEFT.TotalConvictedMisdemeanor4M_NY + RIGHT.TotalConvictedMisdemeanor4M_NY;
                                   SELF.TotalConvictedMisdemeanor4M_EVER := LEFT.TotalConvictedMisdemeanor4M_EVER + RIGHT.TotalConvictedMisdemeanor4M_EVER;
                                                                                    
                                   SELF.TotalNonConvictedFelonies3F_OVERNYR := LEFT.TotalNonConvictedFelonies3F_OVERNYR + RIGHT.TotalNonConvictedFelonies3F_OVERNYR;
                                   SELF.TotalNonConvictedFelonies3F_NY := LEFT.TotalNonConvictedFelonies3F_NY + RIGHT.TotalNonConvictedFelonies3F_NY;
                                   SELF.TotalNonConvictedFelonies3F_EVER := LEFT.TotalNonConvictedFelonies3F_EVER + RIGHT.TotalNonConvictedFelonies3F_EVER;
                                   
                                   SELF.TotalNonConvictedUnknowns3U_OVERNYR := LEFT.TotalNonConvictedUnknowns3U_OVERNYR + RIGHT.TotalNonConvictedUnknowns3U_OVERNYR;
                                   SELF.TotalNonConvictedUnknowns3U_NY := LEFT.TotalNonConvictedUnknowns3U_NY + RIGHT.TotalNonConvictedUnknowns3U_NY;
                                   SELF.TotalNonConvictedUnknowns3U_EVER := LEFT.TotalNonConvictedUnknowns3U_EVER + RIGHT.TotalNonConvictedUnknowns3U_EVER;
                                   
                                   SELF.TotalNonConvictedMisdemeanor3M_OVERNYR := LEFT.TotalNonConvictedMisdemeanor3M_OVERNYR + RIGHT.TotalNonConvictedMisdemeanor3M_OVERNYR;
                                   SELF.TotalNonConvictedMisdemeanor3M_NY := LEFT.TotalNonConvictedMisdemeanor3M_NY + RIGHT.TotalNonConvictedMisdemeanor3M_NY;
                                   SELF.TotalNonConvictedMisdemeanor3M_EVER := LEFT.TotalNonConvictedMisdemeanor3M_EVER + RIGHT.TotalNonConvictedMisdemeanor3M_EVER;
                                   
                                   SELF.TotalConvictedTraffic2T_OVERNYR := LEFT.TotalConvictedTraffic2T_OVERNYR + RIGHT.TotalConvictedTraffic2T_OVERNYR;
                                   SELF.TotalConvictedTraffic2T_NY := LEFT.TotalConvictedTraffic2T_NY + RIGHT.TotalConvictedTraffic2T_NY;
                                   SELF.TotalConvictedTraffic2T_EVER := LEFT.TotalConvictedTraffic2T_EVER + RIGHT.TotalConvictedTraffic2T_EVER;
                                   
                                   SELF.TotalConvictedInfractions2I_OVERNYR := LEFT.TotalConvictedInfractions2I_OVERNYR + RIGHT.TotalConvictedInfractions2I_OVERNYR;
                                   SELF.TotalConvictedInfractions2I_NY := LEFT.TotalConvictedInfractions2I_NY + RIGHT.TotalConvictedInfractions2I_NY;
                                   SELF.TotalConvictedInfractions2I_EVER := LEFT.TotalConvictedInfractions2I_EVER + RIGHT.TotalConvictedInfractions2I_EVER;
                                   
                                   SELF.TotalOffensesThisDID := LEFT.TotalOffensesThisDID + RIGHT.TotalOffensesThisDID;
                                   SELF.TotalHitsStateCrim := LEFT.TotalHitsStateCrim + RIGHT.TotalHitsStateCrim;
                                   SELF.TotalHitsTrafficInfraction := LEFT.TotalHitsTrafficInfraction + RIGHT.TotalHitsTrafficInfraction;
                                   
                                   SELF := LEFT;));
  
	// SummaryOffensesFelony    :=  DueDiligence.subFunctions.ProcessOffenses(OffenseDataRolled);  
																
	// ------                                                                                    ------
	// ------ Do the final join back to the businessExecutives input                             ------ 
  // ------ with the criminal offenses found for these executives                              ------
	// ------                                                                                    ------ 	
  AddCriminalOffenses := JOIN(Individuals, rollTotals,
                              LEFT.seq       = RIGHT.seq AND
                              LEFT.party.did = RIGHT.did,
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
                                        SELF.party.noEvidenceOfConvictedStateCrim         := RIGHT.TotalHitsStateCrim = 0;
                                        SELF.party.noEvidenceOfTrafficOrInfraction         := RIGHT.TotalHitsTrafficInfraction = 0;
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
	IF(DebugMode,     OUTPUT(CHOOSEN(WithoffensesData, 50),                    NAMED('WithoffensesData')));    	
	IF(DebugMode,     OUTPUT(CHOOSEN(WithOffendersRiskData, 150),              NAMED('WithOffendersRiskData')));
	IF(DebugMode,     OUTPUT(CHOOSEN(WithCourtOffenseData, 150),                NAMED('WithCourtOffenseData')));    
	IF(DebugMode,     OUTPUT(CHOOSEN(OffenseRiskCleanDates, 150),               NAMED('OffenseRiskCleanDates')));    	
	IF(DebugMode,     OUTPUT(CHOOSEN(OffenseRiskFiltered, 150),                  NAMED('OffenseRiskFiltered')));    	
	IF(DebugMode,     OUTPUT(CHOOSEN(OffenseRiskCalculateAge, 150),              NAMED('OffenseRiskCalculateAge')));    	
	IF(DebugMode,     OUTPUT(CHOOSEN(OffenseDataRolled, 150),                    NAMED('OffenseDataRolled')));    	
	// IF(DebugMode,     OUTPUT(CHOOSEN(SummaryOffensesFelony, 150),                NAMED('SummaryOffensesFelony')));    	
	IF(DebugMode,     OUTPUT(CHOOSEN(AddCriminalOffenses, 150),                   NAMED('AddCriminalOffenses')));    	
	IF(DebugMode,     OUTPUT(CHOOSEN(DIDOffensesPreSort, 150),                   NAMED('DIDOffensesPreSort')));    	
	IF(DebugMode,     OUTPUT(CHOOSEN(DIDOffensesSorted, 150),                   NAMED('DIDOffensesSorted')));    	
	IF(DebugMode,     OUTPUT(CHOOSEN(rollcriminaloffenses, 150),                   NAMED('rollcriminaloffenses')));    	
	IF(DebugMode,     OUTPUT(CHOOSEN(addCriminalToRelatedParty, 150),                   NAMED('addCriminalToRelatedParty')));
  
  
  
  // OUTPUT(StartBuildingOffenderData, NAMED('StartBuildingOffenderData'));
  // OUTPUT(OffenderDataDeduped, NAMED('OffenderDataDeduped'));
  // OUTPUT(WithPunishmentData, NAMED('WithPunishmentData'));
  // OUTPUT(WithoffensesData, NAMED('WithoffensesData'));
  // OUTPUT(WithOffendersRiskData, NAMED('WithOffendersRiskData'));
  // OUTPUT(WithCourtOffenseData, NAMED('WithCourtOffenseData'));
  // OUTPUT(OffenseRiskCalculateAge, NAMED('OffenseRiskCalculateAge'));
  // OUTPUT(OffenseDataRolled, NAMED('OffenseDataRolled'));
  // OUTPUT(AddCriminalOffenses, NAMED('AddCriminalOffenses'));
  // OUTPUT(DIDOffensesPreSort, NAMED('DIDOffensesPreSort'));
  // OUTPUT(DIDOffensesSorted, NAMED('DIDOffensesSorted'));
  // OUTPUT(rollcriminaloffenses, NAMED('rollcriminaloffenses'));
  // OUTPUT(addCriminalToRelatedParty, NAMED('addCriminalToRelatedParty'));
  
  // OUTPUT(calcTotals, NAMED('calcTotals'));
  // OUTPUT(rollTotals, NAMED('rollTotals'));

  RETURN addCriminalToRelatedParty;

END;
