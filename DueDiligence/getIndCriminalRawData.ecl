IMPORT doxie_files, DueDiligence, Risk_Indicators, STD, BIPv2, ut;

/*
	Following Keys being used:
      doxie_files.Key_Offenders
      doxie_files.Key_Court_Offenses
      doxie_files.Key_Offenses
      doxie_files.Key_Punishment
      doxie_files.key_offenders_risk
*/
EXPORT getIndCriminalRawData(DATASET(DueDiligence.LayoutsInternal.RelatedParty) individuals) := FUNCTION  


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
                            KEYED(RIGHT.sdid = LEFT.did),
                            TRANSFORM(DueDiligence.LayoutsInternal.IndCrimLayoutFlat,
                                        SELF.seq := LEFT.seq;
                                        SELF.did := LEFT.did;
                                        SELF.ultID := LEFT.ultID;
                                        SELF.orgID := LEFT.orgID;
                                        SELF.seleID := LEFT.seleID;
                                        
                                        SELF.historyDate := IF(LEFT.historyDate = DueDiligence.Constants.date8Nines, STD.Date.Today(), LEFT.historyDate);
                                        
                                        SELF.offenderKey := RIGHT.offender_key;
                                        
                                        SELF.race := RIGHT.race_desc;
                                        SELF.sex := RIGHT.sex;
                                        SELF.hairColor := RIGHT.hair_color_desc;
                                        SELF.eyeColor := RIGHT.eye_color_desc;
                                        SELF.height := RIGHT.height;
                                        SELF.weight := RIGHT.weight;
                                        SELF.partyName := RIGHT.pty_nm;
                                        SELF.uniquePartyNames := DATASET([TRANSFORM({STRING120 name}, SELF.name := RIGHT.pty_nm;)]);
                                        
                                        SELF.county := RIGHT.county_of_origin;
                                        SELF.countyCourt := RIGHT.case_court;
                                                                                         
                                        SELF.currentlyIncarcerated := RIGHT.curr_incar_flag = 'Y';
                                        SELF.currentlyParoled := RIGHT.curr_parole_flag = 'Y';
                                        SELF.currentlyProbation := RIGHT.curr_probation_flag = 'Y';
                                        
                                        SELF.caseNumber := STD.Str.FilterOut(RIGHT.case_num, '-');
                                        
                                        SELF := [];),
                            ATMOST(DueDiligence.Constants.MAX_5000), 
                            KEEP(DueDiligence.Constants.MAX_1000));
     
    dedupOffenders := DEDUP(getOffenderData, ALL); 
    
    //most differences will be the party name, so lets roll them here
    uniqueOffendersSort := SORT(dedupOffenders, seq, did, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), offenderKey, caseNumber, partyName);
                                  
    uniqueOffendersRollup := ROLLUP(uniqueOffendersSort,
                                    LEFT.seq = RIGHT.seq AND
                                    LEFT.did = RIGHT.did AND
                                    LEFT.ultID = RIGHT.ultID AND
                                    LEFT.orgID = RIGHT.orgID AND
                                    LEFT.seleID = RIGHT.seleID AND
                                    LEFT.offenderKey = RIGHT.offenderKey AND
                                    LEFT.caseNumber = RIGHT.caseNumber,
                                    TRANSFORM(DueDiligence.LayoutsInternal.IndCrimLayoutFlat,
                                              namesMatch := LEFT.partyName = RIGHT.partyName;
                                              
                                              SELF.partyName := IF(namesMatch, LEFT.partyName, RIGHT.partyName);
                                              SELF.uniquePartyNames := IF(namesMatch, LEFT.uniquePartyNames, LEFT.uniquePartyNames + RIGHT.uniquePartyNames);
                                              
                                              SELF := LEFT;));
                                    
        
        
    getOffenderRiskData := JOIN(individuals, doxie_files.key_offenders_risk(),
                                LEFT.did != 0 AND 
                                KEYED(LEFT.did = RIGHT.sdid),
                                TRANSFORM(DueDiligence.LayoutsInternal.IndCrimLayoutFlat,
                                          SELF.seq := LEFT.seq;
                                          SELF.did := LEFT.did;
                                          SELF.ultID := LEFT.ultID;
                                          SELF.orgID := LEFT.orgID;
                                          SELF.seleID := LEFT.seleID;
                                          
                                          SELF.offenderKey := RIGHT.offender_key;
                                                                                  
                                          SELF.offenseTrafficRelated := RIGHT.traffic_flag;
                                          SELF.conviction := RIGHT.conviction_flag;
                                          
                                          // additional data
                                          SELF.temp_offenseScore := RIGHT.offense_score; 
                                          SELF.caseNumber := STD.Str.FilterOut(RIGHT.case_num, '-');
                                          
                                          SELF := [];),
                              ATMOST(DueDiligence.Constants.MAX_5000), 
                              KEEP(DueDiligence.Constants.MAX_1000));    
                              
     dedupOffenderRisk := DEDUP(getOffenderRiskData, ALL);                          
                              
                              
    //because an individual could have NUMEROUS offenses, join by did first then join the data together to work with a smaller subset of data
    offenderData := JOIN(uniqueOffendersRollup, dedupOffenderRisk,
                          LEFT.seq = RIGHT.seq AND
                          LEFT.did = RIGHT.did AND
                          LEFT.ultID = RIGHT.ultID AND
                          LEFT.orgID = RIGHT.orgID AND
                          LEFT.seleID = RIGHT.seleID AND
                          LEFT.offenderKey = RIGHT.offenderKey AND
                          LEFT.caseNumber = RIGHT.caseNumber,
                          TRANSFORM(DueDiligence.LayoutsInternal.IndCrimLayoutFlat,
                                    SELF.temp_offenseScore := RIGHT.temp_offenseScore;
                                    SELF.offenseTrafficRelated := RIGHT.offenseTrafficRelated;
                                    SELF.conviction := RIGHT.conviction;
                                    SELF.caseNumber := RIGHT.caseNumber;
                                    SELF := LEFT;),
                          ATMOST(DueDiligence.Constants.MAX_5000), 
                          KEEP(DueDiligence.Constants.MAX_1000),
                          LEFT OUTER);
                          
    dedupOffenderData := DEDUP(offenderData, ALL);                  
                                      
                                     
    addNonDOCData := JOIN(dedupOffenderData, doxie_files.Key_Court_Offenses(),
                          KEYED(LEFT.offenderKey = RIGHT.ofk) AND
                          RIGHT.data_type IN [DATA_TYPE_CRIMINAL, DATA_TYPE_ARREST_LOG],
                          TRANSFORM(DueDiligence.LayoutsInternal.IndCrimLayoutFlat,
                                      // grouping data
                                      SELF.sort_key := STD.Str.FilterOut(RIGHT.court_case_number, '-');
                                      SELF.temp_offenseDate := RIGHT.off_date;
                                      SELF.temp_category := RIGHT.offense_category;
                                      
                                      earliestDate1 := getEarliestDate((UNSIGNED)RIGHT.off_date, (UNSIGNED)RIGHT.arr_date);
                                      earliestDate3 := getEarliestDate(earliestDate1, (UNSIGNED)RIGHT.court_disp_date);
                                      earliestDate4 := getEarliestDate(earliestDate3, (UNSIGNED)RIGHT.sent_date);
                                      
                                      SELF.temp_calcdFirstSeenDate := earliestDate4;
                                      
                                      agencyCaseNumberPopulated := TRIM(RIGHT.le_agency_case_number) <> DueDiligence.Constants.EMPTY;
                                      agencyCaseNumber := IF(agencyCaseNumberPopulated, STD.Str.FilterOut(RIGHT.le_agency_case_number, '-'), LEFT.caseNumber);
                                      
                                                                 
                                      //top level data
                                      SELF.state := RIGHT.state_origin;
                                      SELF.source := mapCourtCaseTypes(RIGHT.data_type);
                                      SELF.offenseStatute := RIGHT.court_statute;
                                      SELF.caseNumber := IF(RIGHT.data_type = DATA_TYPE_ARREST_LOG, agencyCaseNumber, LEFT.caseNumber);
                                      SELF.charge := IF(RIGHT.data_type = DATA_TYPE_ARREST_LOG, RIGHT.arr_off_desc_1, RIGHT.court_off_desc_1);
                                      SELF.chargeLevelReported := IF(RIGHT.data_type = DATA_TYPE_CRIMINAL, RIGHT.court_off_lev_mapped, RIGHT.arr_off_lev_mapped);
                                      SELF.offenseDDLastReportedActivity := MAX((UNSIGNED)RIGHT.off_date, (UNSIGNED)RIGHT.arr_date, 
                                                                                (UNSIGNED)RIGHT.court_disp_date, (UNSIGNED)RIGHT.sent_date);                                       
                                     
                                      
                                      //additional data
                                      SELF.city := RIGHT.offense_town;
                                      SELF.agency := RIGHT.le_agency_desc;
                                      SELF.reportedDate := (UNSIGNED)RIGHT.off_date;
                                      SELF.arrestDate := (UNSIGNED)RIGHT.arr_date;
                                      SELF.courtDispDate := (UNSIGNED)RIGHT.court_disp_date;
                                      SELF.appealDate := (UNSIGNED)RIGHT.appeal_date;
                                      SELF.sentenceDate := (UNSIGNED)RIGHT.sent_date;
                                      SELF.sentenceStartDate := (UNSIGNED)RIGHT.sent_jail; 
                                      
                                      //source data
                                      SELF.courtDisposition1 := RIGHT.court_disp_desc_1;
                                      SELF.courtDisposition2 := RIGHT.court_disp_desc_2;
                                      
                                      //misc data - used in calculating offense score
                                      SELF.temp_courtOffLevel := RIGHT.court_off_lev;
                                      
                                      SELF := LEFT;),
                          ATMOST(DueDiligence.Constants.MAX_5000), 
                          KEEP(DueDiligence.Constants.MAX_1000));                                 
  
  
    addDOCDataOffense := JOIN(dedupOffenderData, doxie_files.Key_Offenses(),
                              KEYED(LEFT.offenderKey = RIGHT.ok) AND
                              RIGHT.data_type = DATA_TYPE_DOC,
                              TRANSFORM(DueDiligence.LayoutsInternal.IndCrimLayoutFlat,
                              
                                        SELF.parole := RIGHT.parole;
                                        SELF.probation := RIGHT.probation;
                                        SELF.incarAdmitDate := (UNSIGNED)RIGHT.inc_adm_dt;
                              
                                        
                                        //grouping data
                                        SELF.sort_key := STD.Str.FilterOut(RIGHT.offense_key, '-');
                                        SELF.temp_offenseDate := RIGHT.off_date;
                                        SELF.temp_category := RIGHT.offense_category;
                                        
                                        earliestDate1 := getEarliestDate((UNSIGNED)RIGHT.off_date, (UNSIGNED)RIGHT.arr_date);
                                        earliestDate3 := getEarliestDate(earliestDate1, (UNSIGNED)RIGHT.stc_dt);
                                        earliestDate4 := getEarliestDate(earliestDate3, (UNSIGNED)RIGHT.ct_disp_dt);
                                        
                                        SELF.temp_calcdFirstSeenDate := earliestDate4;
                                          
                                          
                                          
                                        //top level data
                                        SELF.state := RIGHT.orig_state;
                                        SELF.source := mapCourtCaseTypes(RIGHT.data_type);
                                        SELF.offenseStatute := RIGHT.off_code;
                                        SELF.offenseDDLastReportedActivity := MAX((UNSIGNED)RIGHT.off_date, (UNSIGNED)RIGHT.arr_date, 
                                                                                  (UNSIGNED)RIGHT.stc_dt, (UNSIGNED)RIGHT.ct_disp_dt);
                                        
                                        SELF.chargeLevelReported := RIGHT.off_lev;
                                        SELF.charge := RIGHT.off_desc_1;
                                        SELF.caseNumber := IF(TRIM(RIGHT.case_num) <> DueDiligence.Constants.EMPTY, STD.Str.FilterOut(RIGHT.case_num, '-'), LEFT.caseNumber);
                                        
                                        
                                        incarBeginDate := getIncarcerationSentenceDate(RIGHT.stc_desc_2, 'Start');
                                        incarEndDate := getIncarcerationSentenceDate(RIGHT.stc_desc_2, 'End');
                                                                                
                                        
                                        //additional data
                                        SELF.city := RIGHT.offensetown;
                                        SELF.agency := RIGHT.cty_conv;
                                        SELF.reportedDate := (UNSIGNED)RIGHT.off_date;
                                        SELF.arrestDate := (UNSIGNED)RIGHT.arr_date;
                                        SELF.sentenceDate := (UNSIGNED)RIGHT.stc_dt;
                                        SELF.sentenceStartDate := (UNSIGNED)incarBeginDate;
                                        SELF.sentenceEndDate := (UNSIGNED)incarEndDate;
                                        SELF.DOCConvictionOverrideDate := (UNSIGNED)RIGHT.conviction_override_date;
                                        
                                        //source data
                                        SELF.maxTerm := RIGHT.max_term_desc;
                                        SELF.countyCourt := IF(RIGHT.court_desc <> DueDiligence.Constants.EMPTY, RIGHT.court_desc, LEFT.countyCourt);
                                        SELF.temp_offenseScore := IF(RIGHT.off_typ <> DueDiligence.Constants.EMPTY, RIGHT.off_typ, LEFT.temp_offenseScore);

                                        SELF := LEFT;),
                              ATMOST(DueDiligence.Constants.MAX_5000), 
                              KEEP(DueDiligence.Constants.MAX_1000));
                              
                              
    dedupDOCOffenses := DEDUP(addDOCDataOffense, ALL);
                              
                                        
    addDOCDataPunishment := JOIN(dedupDOCOffenses, doxie_files.Key_Punishment(),
                                  KEYED(LEFT.offenderKey = RIGHT.ok),
                                  TRANSFORM(DueDiligence.LayoutsInternal.IndCrimLayoutFlat,                                            
                                            
                                            //get the release dates
                                            releaseDate := getReleaseDate((UNSIGNED)RIGHT.act_rel_dt, (UNSIGNED)RIGHT.ctl_rel_dt, (UNSIGNED)RIGHT.sch_rel_dt);
                                            paroleReleaseDate := getReleaseDate((UNSIGNED)RIGHT.par_act_end_dt, (UNSIGNED)RIGHT.par_sch_end_dt, (UNSIGNED)RIGHT.presump_par_rel_dt);
                                            
                                            
                                            parCurStatDesc := STD.Str.ToUpperCase(TRIM(RIGHT.par_cur_stat_desc));
                                            inmateStatusDesc := STD.Str.ToUpperCase(TRIM(RIGHT.cur_stat_inm_desc));
                                            
                                            incarBeginDate := MAP(LEFT.sentenceStartDate <> 0 => LEFT.sentenceStartDate,
                                                                  LEFT.incarAdmitDate <> 0 => LEFT.incarAdmitDate,
                                                                  RIGHT.latest_adm_dt <> DueDiligence.Constants.EMPTY => (UNSIGNED)RIGHT.latest_adm_dt,
                                                                  LEFT.sentenceDate <> 0 => LEFT.sentenceDate,
                                                                  LEFT.arrestDate <> 0 => LEFT.arrestDate,
                                                                  0);
                                                                  
                                            calcIncarEndDate := MAP(LEFT.sentenceEndDate <> 0 => LEFT.sentenceEndDate,
                                                                    releaseDate <> 0 => releaseDate,
                                                                    LEFT.maxTerm <> DueDiligence.Constants.EMPTY AND incarBeginDate <> 0 => updateDate(LEFT.maxTerm, incarBeginDate),
                                                                    0);
                                            
                                            calcParoleEndDate := MAP(paroleReleaseDate <> 0 => paroleReleaseDate,
                                                                      LEFT.parole <> DueDiligence.Constants.EMPTY AND incarBeginDate <> 0 => updateDate(LEFT.parole, incarBeginDate),
                                                                      0);
                                            
                                            calcProbationEndDate := IF(LEFT.probation <> DueDiligence.Constants.EMPTY AND incarBeginDate <> 0, updateDate(LEFT.probation, incarBeginDate), 0);
                       
                                            incarParoleProbIndicator := getCurrentlyIncarParoleProb(LEFT.historyDate, incarBeginDate, calcIncarEndDate, calcParoleEndDate, calcProbationEndDate,
                                                                                                    inmateStatusDesc, parCurStatDesc, LEFT.currentlyIncarcerated, LEFT.currentlyParoled, 
                                                                                                    LEFT.currentlyProbation);
         
          	
            
                                            //additional data
                                            SELF.docScheduledReleaseDate := (UNSIGNED)RIGHT.sch_rel_dt;
                                            SELF.docActualReleaseDate := (UNSIGNED)RIGHT.act_rel_dt;
                                            SELF.docInmateStatus := inmateStatusDesc;                                            

                                            SELF.docParoleActualReleaseDate := (UNSIGNED)RIGHT.par_act_end_dt;
                                            SELF.docParolePresumptiveReleaseDate := (UNSIGNED)RIGHT.presump_par_rel_dt;
                                            SELF.docParoleScheduledReleaseDate := (UNSIGNED)RIGHT.par_sch_end_dt;
                                            SELF.docParoleCurrentStatus := RIGHT.par_cur_stat_desc;
                                            SELF.docCurrentKnownInmateStatus := inmateStatusDesc;
                                            SELF.docCurrentLocationSecurity := RIGHT.cur_loc_sec;
                                                                                        
                                            SELF.offenseIncarcerationProbationParole := STD.Str.ToUpperCase(MAP(incarParoleProbIndicator = TYPE_INCARCERATION => DueDiligence.ConstantsLegal.INCARCERATION_TEXT,
                                                                                                                incarParoleProbIndicator = TYPE_PAROLE => DueDiligence.ConstantsLegal.PAROLE_TEXT,
                                                                                                                incarParoleProbIndicator = TYPE_PROBATION => DueDiligence.ConstantsLegal.PROBATION_TEXT,
                                                                                                                incarParoleProbIndicator = TYPE_PREV_INCARCERATION => DueDiligence.ConstantsLegal.PREVIOUSLY_INCARCERATED_TEXT,
                                                                                                                incarParoleProbIndicator = TYPE_RELEASED => RELEASED_DISCHARGE,
                                                                                                                incarParoleProbIndicator = TYPE_UNKNOWN => UNKNOWN,
                                                                                                                DueDiligence.Constants.EMPTY));
                                            
                                            paroleCurrentStatusDescription := MAP(parCurStatDesc = 'INMATE' => DueDiligence.ConstantsLegal.INCARCERATION_TEXT,
																																									parCurStatDesc = 'DISCHARGE' => DueDiligence.ConstantsLegal.PREVIOUSLY_INCARCERATED_TEXT, 
																																									DueDiligence.Constants.EMPTY);
                                                                                  
                                            SELF.docParoleStatus := paroleCurrentStatusDescription;
                                            
                                            SELF.currentlyIncarcerated := incarParoleProbIndicator = TYPE_INCARCERATION;
                                            SELF.currentlyParoled := incarParoleProbIndicator = TYPE_PAROLE;
                                            SELF.currentlyProbation := incarParoleProbIndicator = TYPE_PROBATION;
                                            SELF.temp_previouslyIncarcerated := incarParoleProbIndicator = TYPE_PREV_INCARCERATION OR incarParoleProbIndicator = TYPE_RELEASED;
    
                                            
                                            SELF := LEFT;),
                                  ATMOST(DueDiligence.Constants.MAX_5000), 
                                  KEEP(DueDiligence.Constants.MAX_1000),
                                  LEFT OUTER); 
                                  
                                  
                                  
                                  
                                  
                                  
                                  
    dedupPunishments := DEDUP(addDOCDataPunishment, ALL);

   
    allOffenseData := addNonDOCData + dedupPunishments;
    dedupAllOffenseData := DEDUP(allOffenseData, ALL); 


   
    finalCalculations := PROJECT(dedupAllOffenseData, TRANSFORM(DueDiligence.LayoutsInternal.IndCrimLayoutFinal,
                                                                SELF.seq := LEFT.seq;
                                                                SELF.ultID := LEFT.ultID;
                                                                SELF.orgID := LEFT.orgID;
                                                                SELF.seleID := LEFT.seleID;
                                                                SELF.did := LEFT.did;
                                                                SELF.historyDate := LEFT.historyDate;
                                                                SELF.sort_key := LEFT.sort_key;
                                                                SELF.category := LEFT.temp_category;
                                                                
                                                                
                                                                trafficRelated := IF(LEFT.offenseTrafficRelated = DueDiligence.Constants.YES OR LEFT.temp_category = 1073741824, DueDiligence.Constants.YES, LEFT.offenseTrafficRelated);
                                                                
                                                                chargeLevelCalculated := DueDiligence.Common.LookAtOther(LEFT.temp_offenseScore,
                                                                                                                          LEFT.temp_courtOffLevel,                 
                                                                                                                          LEFT.charge,
                                                                                                                          LEFT.courtDisposition1,
                                                                                                                          LEFT.courtDisposition2,
                                                                                                                          LEFT.chargeLevelReported,
                                                                                                                          trafficRelated);
                                                                                                    
                                                                                                    
                                                                SELF.attr_stateLegalEvent9 := LEFT.currentlyIncarcerated;
                                                                SELF.attr_stateLegalEvent6 := LEFT.temp_previouslyIncarcerated OR LEFT.currentlyParoled OR LEFT.currentlyProbation;
                                                                
                                                                SELF.currIncar := LEFT.currentlyIncarcerated;
                                                                SELF.currParole := LEFT.currentlyParoled;
                                                                SELF.currProbation := LEFT.currentlyProbation;
                                                                SELF.prevIncar := LEFT.temp_previouslyIncarcerated;

                                                                 
                                                                //top level fields
                                                                SELF.state := LEFT.state;
                                                                SELF.source := LEFT.source;
                                                                SELF.caseNumber := LEFT.caseNumber;
                                                                SELF.offenseStatute := LEFT.offenseStatute;
                                                                SELF.offenseDDFirstReportedActivity := (UNSIGNED)IF(LEFT.temp_offenseDate = DueDiligence.Constants.EMPTY, (STRING8)LEFT.temp_calcdFirstSeenDate, LEFT.temp_offenseDate);
                                                                SELF.offenseDDLastReportedActivity := LEFT.offenseDDLastReportedActivity;
                                                                SELF.offenseDDLastCourtDispDate := LEFT.offenseDDLastCourtDispDate;
                                                                // SELF.offenseCategoryID;
                                                                // SELF.offenseCategoryDescription;
                                                                SELF.offenseCharge := LEFT.charge;
                                                                SELF.offenseDDChargeLevelCalculated := chargeLevelCalculated;
                                                                SELF.offenseChargeLevelReported := LEFT.chargeLevelReported;
                                                                SELF.offenseConviction := LEFT.conviction;
                                                                SELF.offenseIncarcerationProbationParole := LEFT.offenseIncarcerationProbationParole;
                                                                SELF.offenseTrafficRelated := trafficRelated;
                                                                
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
                                                                SELF.sources := DATASET([TRANSFORM(DueDiligence.Layouts.CriminalSources,
                                                                                                    SELF.charge := LEFT.charge;
                                                                                                    SELF.conviction := LEFT.conviction;
                                                                                                    SELF.chargeLevelCalculated := chargeLevelCalculated;
                                                                                                    SELF.chargeLevelReported := LEFT.chargeLevelReported;
                                                                                                    SELF.source := LEFT.source;
                                                                                                    SELF.courtDisposition1 := LEFT.courtDisposition1;
                                                                                                    SELF.courtDisposition2 := LEFT.courtDisposition2;
                                                                                                    SELF.reportedDate := LEFT.reportedDate;
                                                                                                    SELF.arrestDate := LEFT.arrestDate;
                                                                                                    SELF.courtDispDate := LEFT.courtDispDate;
                                                                                                    SELF.appealDate := LEFT.appealDate;
                                                                                                    SELF.sentenceDate := LEFT.sentenceDate;
                                                                                                    SELF.sentenceStartDate := LEFT.sentenceStartDate;
                                                                                                    SELF.DOCConvictionOverrideDate := LEFT.DOCConvictionOverrideDate;
                                                                                                    SELF.DOCScheduledReleaseDate := LEFT.DOCScheduledReleaseDate;
                                                                                                    SELF.DOCActualReleaseDate := LEFT.DOCActualReleaseDate;
                                                                                                    SELF.DOCInmateStatus := LEFT.DOCInmateStatus;
                                                                                                    SELF.DOCCurrentKnownInmateStatus := LEFT.DOCInmateStatus;
                                                                                                    SELF.DOCParoleStatus := LEFT.DOCParoleStatus;
                                                                                                    SELF.maxTerm := LEFT.maxTerm;
                                                                                                    SELF.currentlyIncarcerated := LEFT.currentlyIncarcerated;
                                                                                                    SELF.currentlyParoled := LEFT.currentlyParoled;
                                                                                                    SELF.currentlyProbation := LEFT.currentlyProbation;
                                                                                                    SELF.DOCParoleActualReleaseDate := LEFT.DOCParoleActualReleaseDate;
                                                                                                    SELF.DOCParolePresumptiveReleaseDate := LEFT.DOCParolePresumptiveReleaseDate;
                                                                                                    SELF.DOCParoleScheduledReleaseDate := LEFT.DOCParoleScheduledReleaseDate;
                                                                                                    SELF.DOCParoleCurrentStatus := LEFT.DOCParoleCurrentStatus;
                                                                                                    SELF.DOCCurrentLocationSecurity := LEFT.DOCCurrentLocationSecurity;
                                                                                                    SELF.partyNames := LEFT.uniquePartyNames;
                                                                                                    SELF := LEFT;
                                                                                                    SELF := [];)]);
                                                                                                    
                                                                      
                                                                SELF := LEFT;
                                                                SELF := [];));
    
       

    //Clean dates used in logic levels here so all comparisions flow through consistently
    crimCleanDate := DueDiligence.Common.CleanDatasetDateFields(finalCalculations, 'offenseDDFirstReportedActivity');
    
    //put data back into IndCrimLayoutFinal structure
    convertLayout := PROJECT(crimCleanDate, TRANSFORM(DueDiligence.LayoutsInternal.IndCrimLayoutFinal,
                                                      SELF.offenseDDFirstReportedActivity := LEFT.offenseDDFirstReportedActivity;
                                                      SELF := LEFT;));
    
    //Filter out records after our history date.
    crimFilter := DueDiligence.CommonDate.FilterRecordsSingleDate(convertLayout, offenseDDFirstReportedActivity);
    
   
    sortSources := SORT(crimFilter, seq, did, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), source, sort_key, offenseCharge, caseNumber, offenseDDFirstReportedActivity, -offenseDDLastReportedActivity);
    
    rollSources := ROLLUP(sortSources,
                          LEFT.seq = RIGHT.seq AND
                          LEFT.ultID = RIGHT.ultID AND
                          LEFT.orgID = RIGHT.orgID AND
                          LEFT.seleID = RIGHT.seleID AND
                          LEFT.did = RIGHT.did AND
                          LEFT.source = RIGHT.source AND
                          LEFT.sort_key = RIGHT.sort_key AND
                          LEFT.offenseCharge = RIGHT.offenseCharge AND
                          LEFT.caseNumber = RIGHT.caseNumber,
                          TRANSFORM(DueDiligence.LayoutsInternal.IndCrimLayoutFinal,

                                    //grab top level - first populated value or greatest value
                                    SELF.state := DueDiligence.v3Common.General.firstPopulatedString(state);
                                    SELF.source := DueDiligence.v3Common.General.firstPopulatedString(source);
                                    SELF.caseNumber := DueDiligence.v3Common.General.firstPopulatedString(caseNumber);
                                    SELF.offenseStatute := DueDiligence.v3Common.General.firstPopulatedString(offenseStatute);
                                    SELF.offenseDDFirstReportedActivity := IF(LEFT.offenseDDFirstReportedActivity = 0, RIGHT.offenseDDFirstReportedActivity, LEFT.offenseDDFirstReportedActivity);
                                    SELF.offenseDDLastReportedActivity := MAX(LEFT.offenseDDLastReportedActivity, RIGHT.offenseDDLastReportedActivity);
                                    SELF.offenseDDLastCourtDispDate := MAX(LEFT.offenseDDLastCourtDispDate, RIGHT.offenseDDLastCourtDispDate);
                                    SELF.offenseCharge := IF(STD.Str.ToUpperCase(TRIM(LEFT.offenseCharge)) IN ['', 'NOT SPECIFIED', 'OTHER'], RIGHT.offenseCharge, LEFT.offenseCharge);

                                    SELF.offenseDDChargeLevelCalculated := MAP(LEFT.offenseDDChargeLevelCalculated = DueDiligence.ConstantsLegal.FELONY OR RIGHT.offenseDDChargeLevelCalculated = DueDiligence.ConstantsLegal.FELONY => DueDiligence.ConstantsLegal.FELONY,
                                                                               LEFT.offenseDDChargeLevelCalculated = DueDiligence.ConstantsLegal.MISDEMEANOR OR RIGHT.offenseDDChargeLevelCalculated = DueDiligence.ConstantsLegal.MISDEMEANOR => DueDiligence.ConstantsLegal.MISDEMEANOR,
                                                                               LEFT.offenseDDChargeLevelCalculated = DueDiligence.ConstantsLegal.TRAFFIC OR RIGHT.offenseDDChargeLevelCalculated = DueDiligence.ConstantsLegal.TRAFFIC => DueDiligence.ConstantsLegal.TRAFFIC,
                                                                               LEFT.offenseDDChargeLevelCalculated = DueDiligence.ConstantsLegal.INFRACTION OR RIGHT.offenseDDChargeLevelCalculated = DueDiligence.ConstantsLegal.INFRACTION => DueDiligence.ConstantsLegal.INFRACTION,
                                                                               LEFT.offenseDDChargeLevelCalculated = DueDiligence.Constants.UNKNOWN OR RIGHT.offenseDDChargeLevelCalculated = DueDiligence.Constants.UNKNOWN => DueDiligence.Constants.UNKNOWN,
                                                                               DueDiligence.Constants.EMPTY);
                                                              
                                                                                                 
                                    SELF.offenseChargeLevelReported := DueDiligence.v3Common.General.firstPopulatedString(offenseChargeLevelReported);
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
                                    incarcerated := LEFT.currIncar OR RIGHT.currIncar;
                                    paroled := LEFT.currParole OR RIGHT.currParole;
                                    probation := LEFT.currProbation OR RIGHT.currProbation;
                                    prevIncarceration := LEFT.prevIncar OR RIGHT.prevIncar;

                                    // SELF.currIncar := incarcerated AND NOT (paroled OR probation); //removed v6
                                    SELF.currIncar := incarcerated; //v6
                                    SELF.currParole := paroled;
                                    SELF.currProbation := probation;
                                    SELF.prevIncar := prevIncarceration OR (incarcerated AND (paroled OR probation));

                                    // SELF.attr_stateLegalEvent9 := incarcerated AND NOT (paroled OR probation OR prevIncarceration); //removed 6
                                    // SELF.attr_stateLegalEvent6 := prevIncarceration OR (incarcerated AND (paroled OR probation)) OR paroled OR probation; //removed v6
                                    SELF.attr_stateLegalEvent9 := incarcerated;  //v6
                                    SELF.attr_stateLegalEvent6 := prevIncarceration OR paroled OR probation;  //v6

                                    SELF.offenseIncarcerationProbationParole := MAP(incarcerated AND NOT (paroled OR probation OR prevIncarceration) => DueDiligence.ConstantsLegal.INCARCERATION_TEXT,
                                                                                    paroled AND NOT probation => DueDiligence.ConstantsLegal.PAROLE_TEXT,
                                                                                    probation => DueDiligence.ConstantsLegal.PROBATION_TEXT,
                                                                                    prevIncarceration OR (incarcerated AND (paroled OR probation)) => DueDiligence.ConstantsLegal.PREVIOUSLY_INCARCERATED_TEXT,
                                                                                    LEFT.offenseIncarcerationProbationParole = DueDiligence.Constants.EMPTY => RIGHT.offenseIncarcerationProbationParole,
                                                                                    LEFT.offenseIncarcerationProbationParole);

                                    SELF.sources := LEFT.sources + RIGHT.sources;
                                    SELF := LEFT;));
    
    
   

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
    // OUTPUT(dedupAllOffenseData, NAMED('dedupAllOffenseData'));

    // OUTPUT(finalCalculations, NAMED('finalCalculations'));
    // OUTPUT(crimCleanDate, NAMED('crimCleanDate'));
    // OUTPUT(crimFilter, NAMED('crimFilter'));
    
    // OUTPUT(sortSources, NAMED('sortSources'));
    // OUTPUT(rollSources, NAMED('rollSources'));
    

                                                                      
    RETURN rollSources;
END;