IMPORT doxie_files, DueDiligence, dx_crim_offense_cat, iesp, Risk_Indicators, STD;

/*
	Following Keys being used:
      doxie_files.Key_Offenders
      doxie_files.Key_Court_Offenses
      doxie_files.Key_Offenses
      doxie_files.Key_Punishment
      doxie_files.key_offenders_risk
      dx_crim_offense_cat.key
*/
EXPORT getCriminalData(DATASET(DueDiligence.v3Layouts.InternalPerson.SlimPersonDetails) individuals) := FUNCTION


    //Constants
    DATA_TYPE_DOC := '1';
    DATA_TYPE_CRIMINAL := '2';
    DATA_TYPE_ARREST_LOG := '5';
    
    RELEASED_DISCHARGE := 'Released';
    UNKNOWN := 'Unknown';
    
    TYPE_INCARCERATION := 'I';
    TYPE_PAROLE := 'P';
    TYPE_PROBATION := 'B';
    TYPE_PREV_INCARCERATION := 'A';
    TYPE_RELEASED := 'R';
    TYPE_UNKNOWN := 'U';

    
    mapCourtCaseTypes(STRING1 dataType) := FUNCTION
      RETURN MAP(dataType = DATA_TYPE_DOC => 'Department of Corrections',
                 dataType = DATA_TYPE_CRIMINAL => 'Criminal Court',
                 dataType = DATA_TYPE_ARREST_LOG => 'Arrest Log',
                 'Unknown'); 
    END;
    
    
    getEarliestDate(UNSIGNED date1, UNSIGNED date2) := FUNCTION
      RETURN MAP(date1 = DueDiligence.Constants.NUMERIC_ZERO AND date2 = DueDiligence.Constants.NUMERIC_ZERO => DueDiligence.Constants.NUMERIC_ZERO,
                 date1 = DueDiligence.Constants.NUMERIC_ZERO => date2,
                 date2 = DueDiligence.Constants.NUMERIC_ZERO => date1,
                 IF(date1 < date2, date1, date2));
    END;
    
    
    getIncarcerationSentenceDate(STRING sentenceDescription, STRING startEnd) := FUNCTION
      lookingFor := 'Sent ' + TRIM(startEnd, ALL) + ' Date:';
      posBeg := STD.Str.Find(sentenceDescription, lookingFor, 1);  //format is 'Sent Start Date: yyyymmdd'
      
      lengthOfSearch := posBeg + LENGTH(lookingFor);
                                      
      sentDateFullSearch := IF(posBeg <> 0, sentenceDescription[lengthOfSearch..lengthOfSearch + 9], DueDiligence.Constants.EMPTY);
      sentDateFull := TRIM(sentDateFullSearch, ALL);
      sentDateYearMonth := sentDateFull[..6];
      
      sentDate := IF(Risk_Indicators.IsAllNumeric(sentDateFull), 
                      sentDateFull, 
                      IF(Risk_Indicators.IsAllNumeric(sentDateYearMonth), 
                          sentDateYearMonth, 
                          DueDiligence.Constants.EMPTY));
      
      finalSentDate:= MAP(LENGTH(TRIM(sentDate)) = 8 => sentDate,
                            LENGTH(TRIM(sentDate)) = 6 => sentDate + '01',
                            DueDiligence.Constants.EMPTY);
                            
      RETURN finalSentDate;
    END;
    
    getReleaseDate(UNSIGNED4 priorityDate1, UNSIGNED4 priorityDate2, UNSIGNED4 priorityDate3) := FUNCTION
      RETURN MAP(priorityDate1 <> 0 => priorityDate1,
                  priorityDate2 <> 0 => priorityDate2,
                  priorityDate3 <> 0 => priorityDate3,
                  0);
    END;
    
    updateDate(STRING dataToSearch, UNSIGNED dateToUpdate) := FUNCTION
        findYr := STD.Str.Find(STD.Str.ToUpperCase(dataToSearch) , 'YEAR', 1);     //format: #Years
        findMonth := STD.Str.Find(STD.Str.ToUpperCase(dataToSearch), 'MONTH', 1);  //format: #Months
        findDay := STD.Str.Find(STD.Str.ToUpperCase(dataToSearch), 'DAY', 1);      //format: #Days

        year := (UNSIGNED)dataToSearch[..findYr-1];
        month := (UNSIGNED)dataToSearch[..findMonth-1];
        day := (UNSIGNED)dataToSearch[..findDay-1];
        
        RETURN STD.Date.AdjustCalendar(dateToUpdate, year, month, day);
    END;
    
    getCurrentlyIncarParoleProb(UNSIGNED historyDate, UNSIGNED sentBegin, UNSIGNED sentEnd, UNSIGNED paroleEndDate, UNSIGNED probationEndDate, 
                                STRING inmateStatus, STRING paroleStatus, BOOLEAN curIncarFlag, BOOLEAN curParoleFlag, BOOLEAN curProbFlag) := FUNCTION
    

      
      released := inmateStatus IN DueDiligence.ConstantsLegal.SET_INMATE_STATUS_DISCHARGED OR paroleStatus IN DueDiligence.ConstantsLegal.SET_INMATE_STATUS_DISCHARGED;
      paroled := inmateStatus IN DueDiligence.ConstantsLegal.SET_INMATE_STATUS_PAROLE OR paroleStatus IN DueDiligence.ConstantsLegal.SET_INMATE_STATUS_PAROLE;
      probation := inmateStatus IN DueDiligence.ConstantsLegal.SET_INMATE_STATUS_PROBATION OR paroleStatus IN DueDiligence.ConstantsLegal.SET_INMATE_STATUS_PROBATION;
      prevIncar := inmateStatus IN DueDiligence.ConstantsLegal.SET_INMATE_STATUS_PREVIOUSLY_INCARCERATED OR paroleStatus IN DueDiligence.ConstantsLegal.SET_INMATE_STATUS_PREVIOUSLY_INCARCERATED;

      
      RETURN MAP(curIncarFlag AND curParoleFlag = FALSE AND curProbFlag = FALSE => TYPE_INCARCERATION,
                 curIncarFlag = FALSE AND curParoleFlag AND curProbFlag = FALSE => TYPE_PAROLE,
                 curIncarFlag = FALSE AND curParoleFlag = FALSE AND curProbFlag => TYPE_PROBATION,
                   
                 sentBegin > 0 AND sentEnd = 0 AND paroleEndDate = 0 AND probationEndDate > 0 AND sentBegin > probationEndDate => TYPE_UNKNOWN,
                 sentBegin > 0 AND sentEnd = 0 AND paroleEndDate > 0 AND probationEndDate = 0 AND sentBegin > paroleEndDate => TYPE_UNKNOWN,
                 sentBegin > 0 AND sentEnd > 0 AND sentBegin > sentEnd => TYPE_UNKNOWN,
                 
                 sentBegin > 0 AND sentEnd >= historyDate AND paroleEndDate = 0 AND probationEndDate = 0 AND NOT (released OR paroled OR probation) => TYPE_INCARCERATION,
                 sentBegin > 0 AND sentEnd = 0 AND paroleEndDate = 0 AND probationEndDate = 0 AND NOT (released OR paroled OR probation) => TYPE_INCARCERATION,

                 sentBegin > 0 AND sentEnd >= historyDate AND paroleEndDate > 0 AND probationEndDate = 0 AND NOT (released OR probation) => TYPE_PAROLE,
                 sentBegin > 0 AND sentEnd = 0 AND paroleEndDate >= historyDate AND probationEndDate = 0 AND NOT (released OR probation) => TYPE_PAROLE,
                 sentBegin = 0 AND sentEnd = 0 AND paroleEndDate >= historyDate AND probationEndDate = 0 AND NOT (released OR probation) => TYPE_PAROLE,
                                  
                 sentBegin > 0 AND sentEnd = 0 AND paroleEndDate = 0 AND probationEndDate >= historyDate AND NOT (released OR paroled) => TYPE_PROBATION,
                 sentBegin = 0 AND sentEnd = 0 AND paroleEndDate = 0 AND probationEndDate >= historyDate AND NOT (released OR paroled) => TYPE_PROBATION,
                 sentBegin > 0 AND sentEnd >= historyDate AND paroleEndDate = 0 AND probationEndDate > 0 AND NOT (released OR paroled) => TYPE_PROBATION,
                 
                 sentBegin > 0 AND sentEnd > 0 AND sentEnd < historyDate => TYPE_PREV_INCARCERATION,
                 sentBegin = 0 AND sentEnd > 0 AND sentEnd < historyDate => TYPE_PREV_INCARCERATION,
                 
                 paroled => TYPE_PAROLE,
                 probation => TYPE_PROBATION,
                 prevIncar => TYPE_PREV_INCARCERATION,
                 released => TYPE_RELEASED,

                 paroleEndDate > 0 AND paroleEndDate >= historyDate => TYPE_PAROLE,
                 probationEndDate > 0 AND probationEndDate >= historyDate => TYPE_PROBATION,
                 sentEnd > 0 AND sentEnd >= historyDate => TYPE_INCARCERATION,
                 
                 inmateStatus IN DueDiligence.ConstantsLegal.SET_INMATE_STATUS_UNKNOWN => TYPE_UNKNOWN,
                 TYPE_PREV_INCARCERATION);
                             
    END;
    
    

 
 
 
 
 
 
 
 
 
    getOffenderData := JOIN(individuals, doxie_files.Key_Offenders(),
                            KEYED(LEFT.lexID = RIGHT.sdid),
                            TRANSFORM(DueDiligence.v3Layouts.InternalPersonLegal.CrimDetails,
                                        
                                        SELF.did := LEFT.lexID;
                                        
                                        SELF.historyDate := IF(LEFT.historyDate = DueDiligence.Constants.date8Nines, STD.Date.Today(), LEFT.historyDate);
                                        
                                        SELF.offenderKey := RIGHT.offender_key;
                                        
                                        SELF.race := RIGHT.race_desc;
                                        SELF.sex := RIGHT.sex;
                                        SELF.hairColor := RIGHT.hair_color_desc;
                                        SELF.eyeColor := RIGHT.eye_color_desc;
                                        SELF.height := RIGHT.height;
                                        SELF.weight := RIGHT.weight;
                                        SELF.additionalCalcDetails.partyName := RIGHT.pty_nm;
                                        SELF.det.partyNames := DATASET([TRANSFORM({STRING120 name}, SELF.name := RIGHT.pty_nm;)]);
                                        
                                        SELF.county := RIGHT.county_of_origin;
                                        SELF.countyCourt := RIGHT.case_court;
                                                                                         
                                        SELF.det.currentlyIncarcerated := RIGHT.curr_incar_flag = 'Y';
                                        SELF.det.currentlyParoled := RIGHT.curr_parole_flag = 'Y';
                                        SELF.det.currentlyProbation := RIGHT.curr_probation_flag = 'Y';
                                        
                                        SELF.caseNumber := STD.Str.FilterOut(RIGHT.case_num, '-');
                                        
                                        SELF := [];),
                            ATMOST(DueDiligence.Constants.MAX_5000), 
                            KEEP(DueDiligence.Constants.MAX_1000));
     
    dedupOffenders := DEDUP(getOffenderData, ALL); 
    
    //most differences will be the party name, so lets roll them here
    uniqueOffendersSort := SORT(dedupOffenders, did, offenderKey, caseNumber, additionalCalcDetails.partyName);
                                  
    uniqueOffendersRollup := ROLLUP(uniqueOffendersSort,
                                    LEFT.did = RIGHT.did AND
                                    LEFT.offenderKey = RIGHT.offenderKey AND
                                    LEFT.caseNumber = RIGHT.caseNumber,
                                    TRANSFORM(DueDiligence.v3Layouts.InternalPersonLegal.CrimDetails,
                                              namesMatch := LEFT.additionalCalcDetails.partyName = RIGHT.additionalCalcDetails.partyName;
                                              
                                              SELF.additionalCalcDetails.partyName := IF(namesMatch, LEFT.additionalCalcDetails.partyName, RIGHT.additionalCalcDetails.partyName);
                                              SELF.det.partyNames := IF(namesMatch, LEFT.det.partyNames, LEFT.det.partyNames + RIGHT.det.partyNames);
                                              
                                              SELF := LEFT;));
                                    
        
        
    getOffenderRiskData := JOIN(individuals, doxie_files.key_offenders_risk(),
                                LEFT.lexID != 0 AND 
                                KEYED(LEFT.lexID = RIGHT.sdid),
                                TRANSFORM(DueDiligence.v3Layouts.InternalPersonLegal.CrimDetails,
                                          SELF.did := LEFT.lexID;
                                          
                                          SELF.offenderKey := RIGHT.offender_key;
                                                                                  
                                          SELF.offenseTrafficRelated := RIGHT.traffic_flag;
                                          SELF.det.conviction := RIGHT.conviction_flag;
                                          
                                          // additional data
                                          SELF.additionalCalcDetails.offenseScore := RIGHT.offense_score; 
                                          SELF.caseNumber := STD.Str.FilterOut(RIGHT.case_num, '-');
                                          
                                          SELF := [];),
                              ATMOST(DueDiligence.Constants.MAX_5000), 
                              KEEP(DueDiligence.Constants.MAX_1000));    
                              
     dedupOffenderRisk := DEDUP(getOffenderRiskData, ALL);                          
                              
                              
    //because an individual could have NUMEROUS offenses, join by did first then join the data together to work with a smaller subset of data
    offenderData := JOIN(uniqueOffendersRollup, dedupOffenderRisk,
                          LEFT.did = RIGHT.did AND
                          LEFT.offenderKey = RIGHT.offenderKey AND
                          LEFT.caseNumber = RIGHT.caseNumber,
                          TRANSFORM(DueDiligence.v3Layouts.InternalPersonLegal.CrimDetails,
                                    SELF.additionalCalcDetails.offenseScore := RIGHT.additionalCalcDetails.offenseScore;
                                    SELF.offenseTrafficRelated := RIGHT.offenseTrafficRelated;
                                    SELF.det.conviction := RIGHT.det.conviction;
                                    SELF.caseNumber := RIGHT.caseNumber;
                                    SELF := LEFT;),
                          ATMOST(DueDiligence.Constants.MAX_5000), 
                          KEEP(DueDiligence.Constants.MAX_1000),
                          LEFT OUTER);
                          
    dedupOffenderData := DEDUP(offenderData, ALL);                  
                                      
                                     
    addNonDOCData := JOIN(dedupOffenderData, doxie_files.Key_Court_Offenses(),
                          KEYED(LEFT.offenderKey = RIGHT.ofk) AND
                          RIGHT.data_type IN [DATA_TYPE_CRIMINAL, DATA_TYPE_ARREST_LOG],
                          TRANSFORM(DueDiligence.v3Layouts.InternalPersonLegal.CrimDetails,
                                      // grouping data
                                      SELF.sortKey := STD.Str.FilterOut(RIGHT.court_case_number, '-');
                                      SELF.additionalCalcDetails.offenseDate := RIGHT.off_date;
                                      SELF.additionalCalcDetails.category := RIGHT.offense_category;
                                      
                                      earliestDate1 := getEarliestDate((UNSIGNED)RIGHT.off_date, (UNSIGNED)RIGHT.arr_date);
                                      earliestDate3 := getEarliestDate(earliestDate1, (UNSIGNED)RIGHT.court_disp_date);
                                      earliestDate4 := getEarliestDate(earliestDate3, (UNSIGNED)RIGHT.sent_date);
                                      
                                      SELF.additionalCalcDetails.calcdFirstSeen := earliestDate4;
                                      
                                      agencyCaseNumberPopulated := TRIM(RIGHT.le_agency_case_number) <> DueDiligence.Constants.EMPTY;
                                      agencyCaseNumber := IF(agencyCaseNumberPopulated, STD.Str.FilterOut(RIGHT.le_agency_case_number, '-'), LEFT.caseNumber);
                                      
                                                                 
                                      //top level data
                                      SELF.state := RIGHT.state_origin;
                                      SELF.source := mapCourtCaseTypes(RIGHT.data_type);
                                      SELF.offenseStatute := RIGHT.court_statute;
                                      SELF.caseNumber := IF(RIGHT.data_type = DATA_TYPE_ARREST_LOG, agencyCaseNumber, LEFT.caseNumber);
                                      SELF.det.charge := IF(RIGHT.data_type = DATA_TYPE_ARREST_LOG, RIGHT.arr_off_desc_1, RIGHT.court_off_desc_1);
                                      SELF.det.chargeLevelReported := IF(RIGHT.data_type = DATA_TYPE_CRIMINAL, RIGHT.court_off_lev_mapped, RIGHT.arr_off_lev_mapped);
                                      SELF.offenseDDLastReportedActivity := MAX((UNSIGNED)RIGHT.off_date, (UNSIGNED)RIGHT.arr_date, 
                                                                                (UNSIGNED)RIGHT.court_disp_date, (UNSIGNED)RIGHT.sent_date);                                       
                                     
                                      
                                      //additional data
                                      SELF.city := RIGHT.offense_town;
                                      SELF.agency := RIGHT.le_agency_desc;
                                      SELF.det.reportedDate := (UNSIGNED)RIGHT.off_date;
                                      SELF.det.arrestDate := (UNSIGNED)RIGHT.arr_date;
                                      SELF.det.courtDispDate := (UNSIGNED)RIGHT.court_disp_date;
                                      SELF.det.appealDate := (UNSIGNED)RIGHT.appeal_date;
                                      SELF.det.sentenceDate := (UNSIGNED)RIGHT.sent_date;
                                      SELF.det.sentenceStartDate := (UNSIGNED)RIGHT.sent_jail; 
                                      
                                      //source data
                                      SELF.det.courtDisposition1 := RIGHT.court_disp_desc_1;
                                      SELF.det.courtDisposition2 := RIGHT.court_disp_desc_2;
                                      
                                      //misc data - used in calculating offense score
                                      SELF.additionalCalcDetails.offenseLevel := RIGHT.court_off_lev;
                                      
                                      SELF := LEFT;),
                          ATMOST(DueDiligence.Constants.MAX_5000), 
                          KEEP(DueDiligence.Constants.MAX_1000));                                 
  
  
    addDOCDataOffense := JOIN(dedupOffenderData, doxie_files.Key_Offenses(),
                              KEYED(LEFT.offenderKey = RIGHT.ok) AND
                              RIGHT.data_type = DATA_TYPE_DOC,
                              TRANSFORM(DueDiligence.v3Layouts.InternalPersonLegal.CrimDetails,
                              
                                        SELF.additionalCalcDetails.parole := RIGHT.parole;
                                        SELF.additionalCalcDetails.probation := RIGHT.probation;
                                        SELF.additionalCalcDetails.incarAdmitDate := (UNSIGNED)RIGHT.inc_adm_dt;
                              
                                        
                                        //grouping data
                                        SELF.sortKey := STD.Str.FilterOut(RIGHT.offense_key, '-');
                                        SELF.additionalCalcDetails.offenseDate := RIGHT.off_date;
                                        SELF.additionalCalcDetails.category := RIGHT.offense_category;
                                        
                                        earliestDate1 := getEarliestDate((UNSIGNED)RIGHT.off_date, (UNSIGNED)RIGHT.arr_date);
                                        earliestDate3 := getEarliestDate(earliestDate1, (UNSIGNED)RIGHT.stc_dt);
                                        earliestDate4 := getEarliestDate(earliestDate3, (UNSIGNED)RIGHT.ct_disp_dt);
                                        
                                        SELF.additionalCalcDetails.calcdFirstSeen := earliestDate4;
                                          
                                          
                                          
                                        //top level data
                                        SELF.state := RIGHT.orig_state;
                                        SELF.source := mapCourtCaseTypes(RIGHT.data_type);
                                        SELF.offenseStatute := RIGHT.off_code;
                                        SELF.offenseDDLastReportedActivity := MAX((UNSIGNED)RIGHT.off_date, (UNSIGNED)RIGHT.arr_date, 
                                                                                  (UNSIGNED)RIGHT.stc_dt, (UNSIGNED)RIGHT.ct_disp_dt);
                                        
                                        SELF.det.chargeLevelReported := RIGHT.off_lev;
                                        SELF.det.charge := RIGHT.off_desc_1;
                                        SELF.caseNumber := IF(TRIM(RIGHT.case_num) <> DueDiligence.Constants.EMPTY, STD.Str.FilterOut(RIGHT.case_num, '-'), LEFT.caseNumber);
                                        
                                        
                                        incarBeginDate := getIncarcerationSentenceDate(RIGHT.stc_desc_2, 'Start');
                                        incarEndDate := getIncarcerationSentenceDate(RIGHT.stc_desc_2, 'End');
                                                                                
                                        
                                        //additional data
                                        SELF.city := RIGHT.offensetown;
                                        SELF.agency := RIGHT.cty_conv;
                                        SELF.det.reportedDate := (UNSIGNED)RIGHT.off_date;
                                        SELF.det.arrestDate := (UNSIGNED)RIGHT.arr_date;
                                        SELF.det.sentenceDate := (UNSIGNED)RIGHT.stc_dt;
                                        SELF.det.sentenceStartDate := (UNSIGNED)incarBeginDate;
                                        SELF.additionalCalcDetails.sentenceEndDate := (UNSIGNED)incarEndDate;
                                        SELF.det.docConvictionOverrideDate := (UNSIGNED)RIGHT.conviction_override_date;
                                        
                                        //source data
                                        SELF.det.maxTerm := RIGHT.max_term_desc;
                                        SELF.countyCourt := IF(RIGHT.court_desc <> DueDiligence.Constants.EMPTY, RIGHT.court_desc, LEFT.countyCourt);
                                        SELF.additionalCalcDetails.offenseScore := IF(RIGHT.off_typ <> DueDiligence.Constants.EMPTY, RIGHT.off_typ, LEFT.additionalCalcDetails.offenseScore);

                                        SELF := LEFT;),
                              ATMOST(DueDiligence.Constants.MAX_5000), 
                              KEEP(DueDiligence.Constants.MAX_1000));
                              
                              
    dedupDOCOffenses := DEDUP(addDOCDataOffense, ALL);
                              
                                        
    addDOCDataPunishment := JOIN(dedupDOCOffenses, doxie_files.Key_Punishment(),
                                  KEYED(LEFT.offenderKey = RIGHT.ok),
                                  TRANSFORM(DueDiligence.v3Layouts.InternalPersonLegal.CrimDetails,                                            
                                            
                                            //get the release dates
                                            releaseDate := getReleaseDate((UNSIGNED)RIGHT.act_rel_dt, (UNSIGNED)RIGHT.ctl_rel_dt, (UNSIGNED)RIGHT.sch_rel_dt);
                                            paroleReleaseDate := getReleaseDate((UNSIGNED)RIGHT.par_act_end_dt, (UNSIGNED)RIGHT.par_sch_end_dt, (UNSIGNED)RIGHT.presump_par_rel_dt);
                                            
                                            
                                            parCurStatDesc := STD.Str.ToUpperCase(TRIM(RIGHT.par_cur_stat_desc));
                                            inmateStatusDesc := STD.Str.ToUpperCase(TRIM(RIGHT.cur_stat_inm_desc));
                                            
                                            incarBeginDate := MAP(LEFT.det.sentenceStartDate <> 0 => LEFT.det.sentenceStartDate,
                                                                  LEFT.additionalCalcDetails.incarAdmitDate <> 0 => LEFT.additionalCalcDetails.incarAdmitDate,
                                                                  RIGHT.latest_adm_dt <> DueDiligence.Constants.EMPTY => (UNSIGNED)RIGHT.latest_adm_dt,
                                                                  LEFT.det.sentenceDate <> 0 => LEFT.det.sentenceDate,
                                                                  LEFT.det.arrestDate <> 0 => LEFT.det.arrestDate,
                                                                  0);
                                                                  
                                            calcIncarEndDate := MAP(LEFT.additionalCalcDetails.sentenceEndDate <> 0 => LEFT.additionalCalcDetails.sentenceEndDate,
                                                                    releaseDate <> 0 => releaseDate,
                                                                    LEFT.det.maxTerm <> DueDiligence.Constants.EMPTY AND incarBeginDate <> 0 => updateDate(LEFT.det.maxTerm, incarBeginDate),
                                                                    0);
                                            
                                            calcParoleEndDate := MAP(paroleReleaseDate <> 0 => paroleReleaseDate,
                                                                      LEFT.additionalCalcDetails.parole <> DueDiligence.Constants.EMPTY AND incarBeginDate <> 0 => updateDate(LEFT.additionalCalcDetails.parole, incarBeginDate),
                                                                      0);
                                            
                                            calcProbationEndDate := IF(LEFT.additionalCalcDetails.probation <> DueDiligence.Constants.EMPTY AND incarBeginDate <> 0, updateDate(LEFT.additionalCalcDetails.probation, incarBeginDate), 0);
                       
                                            incarParoleProbIndicator := getCurrentlyIncarParoleProb(LEFT.historyDate, incarBeginDate, calcIncarEndDate, calcParoleEndDate, calcProbationEndDate,
                                                                                                    inmateStatusDesc, parCurStatDesc, LEFT.det.currentlyIncarcerated, LEFT.det.currentlyParoled, 
                                                                                                    LEFT.det.currentlyProbation);
         
          	
                                            //additional data
                                            SELF.det.docScheduledReleaseDate := (UNSIGNED)RIGHT.sch_rel_dt;
                                            SELF.det.docActualReleaseDate := (UNSIGNED)RIGHT.act_rel_dt;
                                            SELF.det.docInmateStatus := inmateStatusDesc;                                            

                                            SELF.det.docParoleActualReleaseDate := (UNSIGNED)RIGHT.par_act_end_dt;
                                            SELF.det.docParolePresumptiveReleaseDate := (UNSIGNED)RIGHT.presump_par_rel_dt;
                                            SELF.det.docParoleScheduledReleaseDate := (UNSIGNED)RIGHT.par_sch_end_dt;
                                            SELF.det.docParoleCurrentStatus := RIGHT.par_cur_stat_desc;
                                            SELF.det.docCurrentKnownInmateStatus := inmateStatusDesc;
                                            SELF.det.docCurrentLocationSecurity := RIGHT.cur_loc_sec;
                                            
                      
                                            paroleCurrentStatusDescription := MAP(parCurStatDesc = 'INMATE' => DueDiligence.ConstantsLegal.INCARCERATION_TEXT,
																																									parCurStatDesc = 'DISCHARGE' => DueDiligence.ConstantsLegal.PREVIOUSLY_INCARCERATED_TEXT, 
																																									DueDiligence.Constants.EMPTY);
                                            
                                            SELF.offenseIncarcerationProbationParole := STD.Str.ToUpperCase(MAP(incarParoleProbIndicator = TYPE_INCARCERATION => DueDiligence.ConstantsLegal.INCARCERATION_TEXT,
                                                                                                                incarParoleProbIndicator = TYPE_PAROLE => DueDiligence.ConstantsLegal.PAROLE_TEXT,
                                                                                                                incarParoleProbIndicator = TYPE_PROBATION => DueDiligence.ConstantsLegal.PROBATION_TEXT,
                                                                                                                incarParoleProbIndicator = TYPE_PREV_INCARCERATION => DueDiligence.ConstantsLegal.PREVIOUSLY_INCARCERATED_TEXT,
                                                                                                                incarParoleProbIndicator = TYPE_RELEASED => RELEASED_DISCHARGE,
                                                                                                                incarParoleProbIndicator = TYPE_UNKNOWN => UNKNOWN,
                                                                                                                DueDiligence.Constants.EMPTY));
                                            
                                            SELF.det.docParoleStatus := paroleCurrentStatusDescription;
                                            
                                            SELF.det.currentlyIncarcerated := incarParoleProbIndicator = TYPE_INCARCERATION;
                                            SELF.det.currentlyParoled := incarParoleProbIndicator = TYPE_PAROLE;
                                            SELF.det.currentlyProbation := incarParoleProbIndicator = TYPE_PROBATION;
                                            SELF.det.previouslyIncarcerated := incarParoleProbIndicator = TYPE_PREV_INCARCERATION OR incarParoleProbIndicator = TYPE_RELEASED;
    
                                            
                                            SELF := LEFT;),
                                  ATMOST(DueDiligence.Constants.MAX_5000), 
                                  KEEP(DueDiligence.Constants.MAX_1000),
                                  LEFT OUTER); 
                                  
                                  
                                  
                                  
                                  
                                  
                                  
    dedupPunishments := DEDUP(addDOCDataPunishment, ALL);

   
    allOffenseData := addNonDOCData + dedupPunishments;
    
    convertFinal := PROJECT(allOffenseData, TRANSFORM({DueDiligence.v3Layouts.InternalPersonLegal.CrimDetails -additionalCalcDetails, iesp.duediligenceshared.t_DDRLegalSourceInfo espDetails},
                                                      SELF.did := LEFT.did;
                                                      SELF.historyDate := LEFT.historyDate;
                                                      SELF.sortKey := LEFT.sortKey;                                                
                                                      
                                                      trafficRelated := IF(LEFT.offenseTrafficRelated = DueDiligence.Constants.YES OR LEFT.additionalCalcDetails.category = 1073741824, DueDiligence.Constants.YES, LEFT.offenseTrafficRelated);
                                                      
                                                      chargeLevelCalculated := DueDiligence.Common.LookAtOther(LEFT.additionalCalcDetails.offenseScore,
                                                                                                                LEFT.additionalCalcDetails.offenseLevel,                 
                                                                                                                LEFT.det.charge,
                                                                                                                LEFT.det.courtDisposition1,
                                                                                                                LEFT.det.courtDisposition2,
                                                                                                                LEFT.det.chargeLevelReported,
                                                                                                                trafficRelated);
                                                      
                                                      //top level fields
                                                      SELF.state := LEFT.state;
                                                      SELF.source := LEFT.source;
                                                      SELF.caseNumber := LEFT.caseNumber;
                                                      SELF.offenseStatute := LEFT.offenseStatute;
                                                      SELF.offenseDDFirstReportedActivity := (UNSIGNED)IF(LEFT.additionalCalcDetails.offenseDate = DueDiligence.Constants.EMPTY, (STRING8)LEFT.additionalCalcDetails.calcdFirstSeen, LEFT.additionalCalcDetails.offenseDate);
                                                      SELF.offenseDDLastReportedActivity := LEFT.offenseDDLastReportedActivity;
                                                      SELF.offenseDDLastCourtDispDate := LEFT.det.courtDispDate;
                                                      SELF.offenseCharge := LEFT.det.charge;
                                                      SELF.offenseDDChargeLevelCalculated := chargeLevelCalculated;
                                                      SELF.offenseConviction := LEFT.det.conviction;
                                                      SELF.offenseIncarcerationProbationParole := LEFT.offenseIncarcerationProbationParole;
                                                      SELF.offenseTrafficRelated := trafficRelated;
                                                      SELF.offenseChargeLevelReported := LEFT.det.chargeLevelReported;
                                                      
                                                      //additonal details
                                                      SELF.county := LEFT.county;
                                                      SELF.countyCourt := LEFT.countyCourt;
                                                      SELF.city := LEFT.city;
                                                      SELF.agency := LEFT.agency;
                                                      SELF.race := LEFT.race;
                                                      SELF.sex := LEFT.sex;
                                                      SELF.hairColor := LEFT.hairColor;
                                                      SELF.eyeColor := LEFT.eyeColor;
                                                      SELF.height := LEFT.height;
                                                      SELF.weight := LEFT.weight;
                                                      
                                                      //source details
                                                      SELF.det.previouslyIncarcerated := LEFT.det.previouslyIncarcerated;
                                                      SELF.det.currentlyIncarcerated := LEFT.det.currentlyIncarcerated;
                                                      SELF.det.currentlyParoled := LEFT.det.currentlyParoled;
                                                      SELF.det.currentlyProbation := LEFT.det.currentlyProbation;
                                                      
                                                      details := DATASET([TRANSFORM(iesp.duediligenceshared.t_DDRLegalSourceInfo,
                                                                                          SELF.OffenseCharge := LEFT.det.charge;
                                                                                          SELF.OffenseConviction := DueDiligence.translateCodeToText.YesNoUnknownText(LEFT.det.conviction);
                                                                                          SELF.OffenseChargeLevelReported := LEFT.det.chargeLevelReported;
                                                                                          SELF.Source := LEFT.source;
                                                                                          SELF.CourtDisposition1 := LEFT.det.courtDisposition1;
                                                                                          SELF.CourtDisposition2 := LEFT.det.courtDisposition2;
                                                                                          SELF.OffenseReportedDate := iesp.ECL2ESP.toDate(LEFT.det.reportedDate);
                                                                                          SELF.OffenseArrestDate := iesp.ECL2ESP.toDate(LEFT.det.arrestDate);
                                                                                          SELF.OffenseCourtDispDate := iesp.ECL2ESP.toDate(LEFT.det.courtDispDate);
                                                                                          SELF.OffenseAppealDate := iesp.ECL2ESP.toDate(LEFT.det.appealDate);
                                                                                          SELF.OffenseSentenceDate := iesp.ECL2ESP.toDate(LEFT.det.sentenceDate);
                                                                                          SELF.OffenseSentenceStartDate := iesp.ECL2ESP.toDate(LEFT.det.sentenceStartDate);
                                                                                          SELF.docConvictionOverrideDate := iesp.ECL2ESP.toDate(LEFT.det.docConvictionOverrideDate);
                                                                                          SELF.docScheduledReleaseDate := iesp.ECL2ESP.toDate(LEFT.det.docScheduledReleaseDate);
                                                                                          SELF.docActualReleaseDate := iesp.ECL2ESP.toDate(LEFT.det.docActualReleaseDate);
                                                                                          
                                                                                          SELF.docParoleActualReleaseDate := iesp.ECL2ESP.toDate(LEFT.det.docParoleActualReleaseDate);
                                                                                          SELF.docParolePresumptiveReleaseDate := iesp.ECL2ESP.toDate(LEFT.det.docParolePresumptiveReleaseDate);
                                                                                          SELF.docParoleScheduledReleaseDate := iesp.ECL2ESP.toDate(LEFT.det.docParoleScheduledReleaseDate);
                                                                                          
                                                                                          SELF.docCurrentLocationSecurity := LEFT.det.docCurrentLocationSecurity;
                                                                                          SELF.docParoleCurrentStatus := LEFT.det.docParoleCurrentStatus;
                                                                                          SELF.docCurrentKnownInmateStatus := LEFT.det.docCurrentKnownInmateStatus;
                                                                                          SELF.currentIncarcerationFlag := LEFT.det.currentlyIncarcerated;
                                                                                          SELF.currentParoleFlag := LEFT.det.currentlyParoled;
                                                                                          SELF.currentProbationFlag :=  LEFT.det.currentlyProbation;
                                                                                          
                                                                                          SELF.docInmateStatus := LEFT.det.docInmateStatus;
                                                                                          SELF.docParoleStatus := LEFT.det.docParoleStatus;
                                                                                          SELF.offenseMaxTerm := LEFT.det.maxTerm;
                                                                                          SELF.partyNames := PROJECT(LEFT.det.partyNames[1..iesp.Constants.DDRAttributesConst.MaxLegalPartyNames], 
                                                                                                                     TRANSFORM(iesp.share.t_StringArrayItem,
                                                                                                                               SELF.value := LEFT.name;));)]);
                                                      SELF.details := details;
                                                      SELF.espDetails := details[1];
                                                      
                                                      SELF := [];));
                                                
    dedupAllOffenseData := DEDUP(convertFinal, ALL); 
    
    //Clean dates used in logic levels here so all comparisions flow through consistently
    crimCleanDate := DueDiligence.Common.CleanDatasetDateFields(dedupAllOffenseData, 'offenseDDFirstReportedActivity');
    
    //put data back into IndCrimLayoutFinal structure
    convertLayout := PROJECT(crimCleanDate, TRANSFORM(DueDiligence.v3Layouts.InternalPersonLegal.CrimDetails -additionalCalcDetails,
                                                      SELF.offenseDDFirstReportedActivity := LEFT.offenseDDFirstReportedActivity;
                                                      SELF := LEFT;));
    
    //Filter out records after our history date.
    crimFilter := DueDiligence.CommonDate.FilterRecordsSingleDate(convertLayout, offenseDDFirstReportedActivity);
    
    
    
    
    
    
    
    //get all the unique details for a given top level combo
    slimDetailGrouping := PROJECT(crimFilter, TRANSFORM({UNSIGNED6 did, STRING25 source, STRING35 sortKey, STRING75 offenseCharge, STRING35 caseNumber, iesp.duediligenceshared.t_DDRLegalSourceInfo espDetails, DATASET(iesp.duediligenceshared.t_DDRLegalSourceInfo) details},
                                                         SELF := LEFT;
                                                         SELF := [];));
                                                                  
    slimESPDetails := DEDUP(slimDetailGrouping, ALL);
    
    grpCrimDetails := GROUP(SORT(slimESPDetails, did, source, sortKey, offenseCharge, caseNumber, -espDetails.offenseReportedDate, -espDetails.currentIncarcerationFlag, -espDetails.currentParoleFlag, -espDetails.currentProbationFlag), did, source, sortKey, offenseCharge, caseNumber);
    maxCrimDetails := DueDiligence.v3Common.General.GetMaxNumberOfRecords(grpCrimDetails, iesp.Constants.DDRAttributesConst.MaxLegalSources);
        
    
    //rollDetails to top level combo
    grpESPDetails := ROLLUP(SORT(maxCrimDetails, did, source, sortKey, offenseCharge, caseNumber, -espDetails.offenseReportedDate, -espDetails.currentIncarcerationFlag, -espDetails.currentParoleFlag, -espDetails.currentProbationFlag),
                            LEFT.did = RIGHT.did AND
                            LEFT.source = RIGHT.source AND
                            LEFT.sortKey = RIGHT.sortKey AND
                            LEFT.offenseCharge = RIGHT.offenseCharge AND
                            LEFT.caseNumber = RIGHT.caseNumber,
                            TRANSFORM(RECORDOF(LEFT),
                                      SELF.details := LEFT.details + RIGHT.details;
                                      SELF := LEFT;));

    
    sortSources := SORT(crimFilter, did, source, sortKey, offenseCharge, caseNumber, offenseDDFirstReportedActivity, -offenseDDLastReportedActivity);
    
    rollTopLevel := ROLLUP(sortSources,
                            LEFT.did = RIGHT.did AND
                            LEFT.source = RIGHT.source AND
                            LEFT.sortKey = RIGHT.sortKey AND
                            LEFT.offenseCharge = RIGHT.offenseCharge AND
                            LEFT.caseNumber = RIGHT.caseNumber,
                            TRANSFORM(RECORDOF(LEFT),
                                      //grab top level - first populated value or greatest value
                                      SELF.state := DueDiligence.v3Common.General.firstPopulatedString(state);
                                      SELF.source := DueDiligence.v3Common.General.firstPopulatedString(source);
                                      SELF.caseNumber := DueDiligence.v3Common.General.firstPopulatedString(caseNumber);
                                      SELF.offenseStatute := DueDiligence.v3Common.General.firstPopulatedString(offenseStatute);
                                      SELF.offenseDDFirstReportedActivity := IF(LEFT.offenseDDFirstReportedActivity = 0, RIGHT.offenseDDFirstReportedActivity, LEFT.offenseDDFirstReportedActivity);
                                      SELF.offenseDDLastReportedActivity := MAX(LEFT.offenseDDLastReportedActivity, RIGHT.offenseDDLastReportedActivity);
                                      SELF.offenseDDLastCourtDispDate := MAX(LEFT.offenseDDLastCourtDispDate, RIGHT.offenseDDLastCourtDispDate);
                                      SELF.offenseCharge := IF(STD.Str.ToUpperCase(TRIM(LEFT.offenseCharge)) IN ['', 'NOT SPECIFIED', 'OTHER'], RIGHT.offenseCharge, LEFT.offenseCharge);
                                      
                                      
                                      SELF.offenseChargeLevelReported := LEFT.det.chargeLevelReported;

                                      SELF.offenseDDChargeLevelCalculated := MAP(LEFT.offenseDDChargeLevelCalculated = DueDiligence.ConstantsLegal.FELONY OR RIGHT.offenseDDChargeLevelCalculated = DueDiligence.ConstantsLegal.FELONY => DueDiligence.ConstantsLegal.FELONY,
                                                                                 LEFT.offenseDDChargeLevelCalculated = DueDiligence.ConstantsLegal.MISDEMEANOR OR RIGHT.offenseDDChargeLevelCalculated = DueDiligence.ConstantsLegal.MISDEMEANOR => DueDiligence.ConstantsLegal.MISDEMEANOR,
                                                                                 LEFT.offenseDDChargeLevelCalculated = DueDiligence.ConstantsLegal.TRAFFIC OR RIGHT.offenseDDChargeLevelCalculated = DueDiligence.ConstantsLegal.TRAFFIC => DueDiligence.ConstantsLegal.TRAFFIC,
                                                                                 LEFT.offenseDDChargeLevelCalculated = DueDiligence.ConstantsLegal.INFRACTION OR RIGHT.offenseDDChargeLevelCalculated = DueDiligence.ConstantsLegal.INFRACTION => DueDiligence.ConstantsLegal.INFRACTION,
                                                                                 LEFT.offenseDDChargeLevelCalculated = DueDiligence.Constants.UNKNOWN OR RIGHT.offenseDDChargeLevelCalculated = DueDiligence.Constants.UNKNOWN => DueDiligence.Constants.UNKNOWN,
                                                                                 DueDiligence.Constants.EMPTY);
                                                                
                                                                                                   
                                      SELF.offenseConviction := IF(LEFT.offenseConviction = DueDiligence.Constants.Yes, LEFT.offenseConviction, RIGHT.offenseConviction);
                                      SELF.offenseTrafficRelated := MAP(LEFT.offenseTrafficRelated = DueDiligence.Constants.YES OR RIGHT.offenseTrafficRelated = DueDiligence.Constants.YES => DueDiligence.Constants.YES,
                                                                        LEFT.offenseTrafficRelated = DueDiligence.Constants.EMPTY => RIGHT.offenseTrafficRelated,
                                                                        LEFT.offenseTrafficRelated);



                                      //grab additional details - first populated value
                                      SELF.county := DueDiligence.v3Common.General.firstPopulatedString(county); 
                                      SELF.countyCourt := DueDiligence.v3Common.General.firstPopulatedString(countyCourt); 
                                      SELF.city := DueDiligence.v3Common.General.firstPopulatedString(city); 
                                      SELF.agency := DueDiligence.v3Common.General.firstPopulatedString(agency); 
                                      SELF.race := DueDiligence.v3Common.General.firstPopulatedString(race); 
                                      SELF.sex := DueDiligence.v3Common.General.firstPopulatedString(sex); 
                                      SELF.hairColor := DueDiligence.v3Common.General.firstPopulatedString(hairColor); 
                                      SELF.eyeColor := DueDiligence.v3Common.General.firstPopulatedString(eyeColor); 
                                      SELF.height := DueDiligence.v3Common.General.firstPopulatedString(height); 
                                      SELF.weight := DueDiligence.v3Common.General.firstPopulatedString(weight);


                                      //roll attribute logic per the sources
                                      incarcerated := LEFT.det.currentlyIncarcerated OR RIGHT.det.currentlyIncarcerated;
                                      paroled := LEFT.det.currentlyParoled OR RIGHT.det.currentlyParoled;
                                      probation := LEFT.det.currentlyProbation OR RIGHT.det.currentlyProbation;
                                      prevIncarceration := LEFT.det.previouslyIncarcerated OR RIGHT.det.previouslyIncarcerated;

                                      SELF.det.currentlyIncarcerated := incarcerated;
                                      SELF.det.currentlyParoled := paroled;
                                      SELF.det.currentlyProbation := probation;
                                      SELF.det.previouslyIncarcerated := prevIncarceration OR (incarcerated AND (paroled OR probation));

                                      SELF.offenseIncarcerationProbationParole := MAP(incarcerated AND NOT (paroled OR probation OR prevIncarceration) => DueDiligence.ConstantsLegal.INCARCERATION_TEXT,
                                                                                      paroled AND NOT probation => DueDiligence.ConstantsLegal.PAROLE_TEXT,
                                                                                      probation => DueDiligence.ConstantsLegal.PROBATION_TEXT,
                                                                                      prevIncarceration OR (incarcerated AND (paroled OR probation)) => DueDiligence.ConstantsLegal.PREVIOUSLY_INCARCERATED_TEXT,
                                                                                      LEFT.offenseIncarcerationProbationParole = DueDiligence.Constants.EMPTY => RIGHT.offenseIncarcerationProbationParole,
                                                                                      LEFT.offenseIncarcerationProbationParole);
                                                                                      
                                      SELF := LEFT;));
                                      
                                      
    updateWithOffenseType := JOIN(rollTopLevel, dx_crim_offense_cat.key(),
                                  KEYED(TRIM(LEFT.offenseCharge, LEFT, RIGHT) = RIGHT.offenseCharge),
                                  TRANSFORM(DueDiligence.v3Layouts.InternalPersonLegal.CrimDetails -additionalCalcDetails -det -details,
                                  
                                            info := DueDiligence.translateExpression.expressionDCT[(UNSIGNED)RIGHT.id]; 
                                            
                                            //grab the offense category id
                                            //if the category does not exist, an id of 0 and level of 0 is returned (Uncategorized)
                                            //if the category exists, grab the level and description (category) from the key to be used
                                            //if no charge was found, would not hit this logic; since the offenseCategoryID field is unsigned
                                            //offenseCategoryID would be 0 and will fill in the text in the project next to Uncategorized                                            
                                            SELF.offenseTypeID := info.id;
                                            SELF.offenseTypeLevel := info.level;
                                            SELF.offenseTypeDescription := RIGHT.category;
                                            
                                            SELF.sourceContainsIncarceration := LEFT.det.currentlyIncarcerated;
                                            SELF.sourceContainsParoled := LEFT.det.currentlyParoled;
                                            SELF.sourceContainsProbation := LEFT.det.currentlyProbation;
                                            SELF.sourceContainsPrevIncarceration := LEFT.det.previouslyIncarcerated;
                                            
                                            SELF := LEFT;),
                                  LEFT OUTER,
                                  ATMOST(1));
                                  
    updateOffenseType := PROJECT(updateWithOffenseType, TRANSFORM(DueDiligence.v3Layouts.InternalPersonLegal.CrimDetails -additionalCalcDetails -det -details,
    
                                                                  trafficRelated := LEFT.offenseTrafficRelated = DueDiligence.Constants.YES;
                                                                  offenseTypeTraffic := LEFT.offenseTypeID = DueDiligence.translateExpression.OffenseID.TRAFFIC;
                                                                  
                                                                  SELF.offenseTrafficRelated := IF(trafficRelated OR offenseTypeTraffic, DueDiligence.Constants.YES, LEFT.offenseTrafficRelated);
                                                                    
                                                                  //set the text to uncagegorized if we did not find the charge
                                                                  SELF.offenseTypeDescription := IF(LEFT.offenseTypeID = 0 AND LEFT.offenseTypeDescription = DueDiligence.Constants.EMPTY, DueDiligence.translateExpression.DEFAULT_UNCATEGORIZED_TEXT, LEFT.offenseTypeDescription);
                                                                  
                                                                  SELF := LEFT;));
                                                                  
                                                                  
                                                                  
                                                                  
    joinCrimData := JOIN(updateOffenseType, grpESPDetails,
                          LEFT.did = RIGHT.did AND
                          LEFT.source = RIGHT.source AND
                          LEFT.sortKey = RIGHT.sortKey AND
                          LEFT.offenseCharge = RIGHT.offenseCharge AND
                          LEFT.caseNumber = RIGHT.caseNumber,
                          TRANSFORM(DueDiligence.v3Layouts.InternalPersonLegal.FinalCrimData,
                                    SELF.did := LEFT.did;
                                    SELF.historyDate := LEFT.historyDate;
                                    
                                    SELF.ddFirstReportedActivity := LEFT.offenseDDFirstReportedActivity;
                                    
                                    SELF.currentlyIncarcerated := LEFT.sourceContainsIncarceration;
                                    SELF.currentlyParoled := LEFT.sourceContainsParoled;
                                    SELF.currentlyProbation := LEFT.sourceContainsProbation;
                                    SELF.prevIncarcerated := LEFT.sourceContainsPrevIncarceration;
                                    
                                    //top level data
                                    SELF.state := LEFT.state;
                                    SELF.source := LEFT.source;
                                    SELF.caseNumber := LEFT.caseNumber;
                                    SELF.offenseStatute := LEFT.offenseStatute;
                                    SELF.offenseDDFirstReported := iesp.ECL2ESP.toDate(LEFT.offenseDDFirstReportedActivity);
                                    SELF.offenseDDLastReportedActivity := iesp.ECL2ESP.toDate(LEFT.offenseDDLastReportedActivity);
                                    SELF.offenseDDMostRecentCourtDispDate := iesp.ECL2ESP.toDate(LEFT.offenseDDLastCourtDispDate);
                                    
                                    offenseTypeDetails := DueDiligence.translateExpression.expressionDCT[LEFT.offenseTypeID];
                                   
                                    SELF.offenseID := LEFT.offenseTypeID;
                                    SELF.offensePriorityOrder := offenseTypeDetails.priorityOrder;
                                    SELF.offenseLevel := LEFT.offenseTypeLevel;
                                    SELF.offenseDDLegalEventTypeMapped := LEFT.offenseTypeDescription;
                                    
                                    SELF.offenseCharge := LEFT.offenseCharge;
                                    SELF.offenseDDChargeLevelCalculated := DueDiligence.translateCodeToText.OffenseLevelText(LEFT.offenseDDChargeLevelCalculated);
                                    SELF.offenseChargeLevelReported := LEFT.offenseChargeLevelReported;
                                    SELF.offenseConviction := DueDiligence.translateCodeToText.YesNoUnknownText(LEFT.offenseConviction);
                                    SELF.offenseIncarcerationProbationParole := LEFT.offenseIncarcerationProbationParole;
                                    SELF.offenseTrafficRelated := DueDiligence.translateCodeToText.YesNoUnknownText(LEFT.offenseTrafficRelated);

                                    //additional details
                                    SELF.county := LEFT.county;
                                    SELF.countyCourt := LEFT.countyCourt;
                                    SELF.city := LEFT.city;
                                    SELF.agency := LEFT.agency;
                                    SELF.race := LEFT.race;
                                    SELF.sex := DueDiligence.translateCodeToText.GenderText(LEFT.sex);
                                    SELF.hairColor := LEFT.hairColor;
                                    SELF.eyeColor := LEFT.eyeColor;
                                    SELF.height := LEFT.height;
                                    SELF.weight := LEFT.weight;
                                   
                                    //sources
                                    SELF.sources := RIGHT.details;
                                    
                                    SELF := [];));


        
    //limit data returned that way it consistent regardless if requesting just attributes and/or report
    groupFinalData := GROUP(SORT(joinCrimData, did, -source, -ddFirstReportedActivity, caseNumber), did);
    
    limitedResults := DueDiligence.v3Common.General.GetMaxNumberOfRecords(groupFinalData, iesp.constants.DDRAttributesConst.MaxLegalEvents);
    
   
    
    
    
                                    
    
    
    
   

    // OUTPUT(getOffenderData, NAMED('getOffenderData'));
    // OUTPUT(dedupOffenders, NAMED('dedupOffenders'));
    // OUTPUT(uniqueOffendersSort, NAMED('uniqueOffendersSort'));
    // OUTPUT(uniqueOffendersRollup, NAMED('uniqueOffendersRollup'));
    // OUTPUT(getOffenderRiskData, NAMED('getOffenderRiskData'));
    // OUTPUT(dedupOffenderRisk, NAMED('dedupOffenderRisk'));
    // OUTPUT(offenderData, NAMED('offenderData'));
    // OUTPUT(dedupOffenderData, NAMED('dedupOffenderData'));
    // OUTPUT(addNonDOCData, NAMED('addNonDOCData'));
    // OUTPUT(addDOCDataOffense, NAMED('addDOCDataOffense'));
    // OUTPUT(dedupDOCOffenses, NAMED('dedupDOCOffenses'));
    // OUTPUT(addDOCDataPunishment, NAMED('addDOCDataPunishment'));
    // OUTPUT(dedupPunishments, NAMED('dedupPunishments'));
    
    // OUTPUT(allOffenseData, NAMED('allOffenseData'));
    // OUTPUT(convertFinal, NAMED('convertFinal'));
    // OUTPUT(dedupAllOffenseData, NAMED('dedupAllOffenseData'));
    
    // OUTPUT(crimCleanDate, NAMED('crimCleanDate'));
    // OUTPUT(convertLayout, NAMED('convertLayout'));
    // OUTPUT(crimFilter, NAMED('crimFilter'));
    
    
    // OUTPUT(slimDetailGrouping, NAMED('slimDetailGrouping'));
    // OUTPUT(slimESPDetails, NAMED('slimESPDetails'));
    
    // OUTPUT(grpCrimDetails, NAMED('grpCrimDetails'));
    // OUTPUT(maxCrimDetails, NAMED('maxCrimDetails'));
    // OUTPUT(grpESPDetails, NAMED('grpESPDetails'));
    
    // OUTPUT(sortSources, NAMED('sortSources'));
    // OUTPUT(rollTopLevel, NAMED('rollTopLevel'));
    // OUTPUT(updateWithOffenseType, NAMED('updateWithOffenseType'));
    // OUTPUT(updateOffenseType, NAMED('updateOffenseType'));
    // OUTPUT(joinCrimData, NAMED('joinCrimData'));
    // OUTPUT(limitedResults, NAMED('limitedResults'));

    
     
    
        

                                                                      
    RETURN limitedResults;
END;