IMPORT doxie_files, DueDiligence, Risk_Indicators, STD;

/*
	Following Keys being used:
			doxie_files.Key_Offenders
      doxie_files.Key_Court_Offenses
      doxie_files.Key_Offenses
      doxie_files.Key_Punishment
      doxie_files.key_offenders_risk
*/
EXPORT getIndCriminalRawData(DATASET(DueDiligence.LayoutsInternal.RelatedParty) individuals) := FUNCTION  
    
    mapCourtCaseTypes(STRING1 dataType) := FUNCTION
      RETURN MAP(dataType = '1' => 'Department of Corrections',
                 dataType = '2' => 'Criminal Court',
                 dataType = '5' => 'Arrest Log',
                 'Unknown'); 
    END;
    
    getEarliestDate(UNSIGNED date1, UNSIGNED date2) := FUNCTION
      RETURN MAP(date1 = DueDiligence.Constants.NUMERIC_ZERO AND date2 = DueDiligence.Constants.NUMERIC_ZERO => DueDiligence.Constants.NUMERIC_ZERO,
                 date1 = DueDiligence.Constants.NUMERIC_ZERO => date2,
                 date2 = DueDiligence.Constants.NUMERIC_ZERO => date1,
                 IF(date1 < date2, date1, date2));
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
                                        
                                        SELF.county := RIGHT.county_of_origin;
                                        SELF.countyCourt := RIGHT.case_court;
                                        SELF.offenseIncarcerationProbationParole := MAP(RIGHT.curr_incar_flag = 'Y' => DueDiligence.Constants.INCARCERATION_TEXT,
                                                                                         RIGHT.curr_parole_flag = 'Y' => DueDiligence.Constants.PAROLE_TEXT,
                                                                                         RIGHT.curr_probation_flag = 'Y' => DueDiligence.Constants.PROBATION_TEXT,
                                                                                         DueDiligence.Constants.EMPTY);

                                        SELF := [];),
                            ATMOST(DueDiligence.Constants.MAX_ATMOST_OFFENSES), 
                            KEEP(DueDiligence.Constants.MAX_KEEP));
     
    dedupOffenders := DEDUP(getOffenderData, ALL); 
        
        
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
                                          SELF.offenseConviction := RIGHT.conviction_flag;
                                          
                                          // additional data
                                          SELF.temp_offenseScore := RIGHT.offense_score; 
                                          SELF.caseNumber := STD.Str.FilterOut(RIGHT.case_num, '-');
                                          
                                          SELF := [];),
                              ATMOST(DueDiligence.Constants.MAX_ATMOST_OFFENSES), 
                              KEEP(DueDiligence.Constants.MAX_KEEP));    
                              
     dedupOffenderRisk := DEDUP(getOffenderRiskData, ALL);                          
                              
                              
    //because an individual could have NUMEROUS offenses, join by did first then join the data together to work with a smaller subset of data
    offenderData := JOIN(dedupOffenders, dedupOffenderRisk,
                          LEFT.seq = RIGHT.seq AND
                          LEFT.did = RIGHT.did AND
                          LEFT.ultID = RIGHT.ultID AND
                          LEFT.orgID = RIGHT.orgID AND
                          LEFT.seleID = RIGHT.seleID AND
                          LEFT.offenderKey = RIGHT.offenderKey,
                          TRANSFORM(DueDiligence.LayoutsInternal.IndCrimLayoutFlat,
                                    SELF.temp_offenseScore := RIGHT.temp_offenseScore;
                                    SELF.offenseTrafficRelated := RIGHT.offenseTrafficRelated;
                                    SELF.offenseConviction := RIGHT.offenseConviction;
                                    SELF.caseNumber := RIGHT.caseNumber;
                                    SELF := LEFT;),
                          ATMOST(DueDiligence.Constants.MAX_ATMOST_OFFENSES), 
                          KEEP(DueDiligence.Constants.MAX_KEEP),
                          LEFT OUTER);
                                      
                                     
    addNonDOCData := JOIN(offenderData, doxie_files.Key_Court_Offenses(),
                          KEYED(LEFT.offenderKey = RIGHT.ofk) AND
                          RIGHT.data_type IN ['2', '5'],
                          TRANSFORM(DueDiligence.LayoutsInternal.IndCrimLayoutFlat,
                                      // grouping data
                                      SELF.sort_key := STD.Str.FilterOut(RIGHT.court_case_number, '-');
                                      SELF.temp_date := RIGHT.off_date;
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
                                      SELF.caseNumber := IF(RIGHT.data_type = '5', agencyCaseNumber, LEFT.caseNumber);
                                      SELF.offenseCharge := IF(RIGHT.data_type = '5', RIGHT.arr_off_desc_1, RIGHT.court_off_desc_1);
                                      SELF.offenseChargeLevelReported := IF(RIGHT.data_type = '2', RIGHT.court_off_lev_mapped, RIGHT.arr_off_lev_mapped);
                                      SELF.offenseDDLastReportedActivity := MAX((UNSIGNED)RIGHT.off_date, (UNSIGNED)RIGHT.arr_date, 
                                                                                (UNSIGNED)RIGHT.court_disp_date, (UNSIGNED)RIGHT.sent_date);     
                                      SELF.offenseDDLastCourtDispDate := (UNSIGNED)RIGHT.court_disp_date;
                                     
                                     
                                      
                                      //additional data
                                      SELF.city := RIGHT.offense_town;
                                      SELF.agency := RIGHT.le_agency_desc;
                                      SELF.offenseReportedDate := (UNSIGNED)RIGHT.off_date;
                                      SELF.offenseArrestDate := (UNSIGNED)RIGHT.arr_date;
                                      SELF.offenseCourtDispDate := (UNSIGNED)RIGHT.court_disp_date;
                                      SELF.offenseAppealDate := (UNSIGNED)RIGHT.appeal_date;
                                      SELF.offenseSentenceDate := (UNSIGNED)RIGHT.sent_date;
                                      SELF.offenseSentenceStartDate := (UNSIGNED)RIGHT.sent_jail; 
                                      
                                      //source data
                                      SELF.courtDisposition1 := RIGHT.court_disp_desc_1;
                                      SELF.courtDisposition2 := RIGHT.court_disp_desc_2;
                                      
                                      //misc data - used in calculating offense score
                                      SELF.temp_courtOffLevel := RIGHT.court_off_lev;
                                      
                                      SELF := LEFT;),
                          ATMOST(DueDiligence.Constants.MAX_ATMOST_OFFENSES), 
                          KEEP(DueDiligence.Constants.MAX_KEEP));                                 
  
  
    addDOCDataOffense := JOIN(offenderData, doxie_files.Key_Offenses(),
                              KEYED(LEFT.offenderKey = RIGHT.ok) AND
                              RIGHT.data_type = '1',
                              TRANSFORM(DueDiligence.LayoutsInternal.IndCrimLayoutFlat,
                                        //grouping data
                                        SELF.sort_key := STD.Str.FilterOut(RIGHT.offense_key, '-');
                                        SELF.temp_date := RIGHT.off_date;
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
                                        
                                        SELF.offenseChargeLevelReported := RIGHT.off_lev;
                                        SELF.offenseCharge := RIGHT.off_desc_1;
                                        SELF.caseNumber := IF(TRIM(RIGHT.case_num) <> DueDiligence.Constants.EMPTY, STD.Str.FilterOut(RIGHT.case_num, '-'), LEFT.caseNumber);
                                        
                                        //get incarceration dates to determine if ever incarcerated
                                        posBeg := stringlib.stringfind(RIGHT.stc_desc_2, 'Date:', 1);                //format is 'Sent Start Date: yyyymmdd Sent End Date: yyyymmdd'
                                      
                                        incarBegDateFull := if(posBeg <> 0, RIGHT.stc_desc_2[posBeg+6..posBeg+13], DueDiligence.Constants.EMPTY);
                                        incarBegDateYearMonth := incarBegDateFull[1..6];
                                        IncarBegin_date := IF(Risk_Indicators.IsAllNumeric(incarBegDateFull), 
                                                                incarBegDateFull, 
                                                                IF(Risk_Indicators.IsAllNumeric(incarBegDateYearMonth), 
                                                                      incarBegDateYearMonth, 
                                                                      DueDiligence.Constants.EMPTY));
                                        
                                        IncarBegin_date_compare := MAP(LENGTH(IncarBegin_date) = 8 => incarBegDateFull,
                                                                        LENGTH(IncarBegin_date) = 6 => incarBegDateYearMonth + '01',
                                                                        DueDiligence.Constants.EMPTY);
                                                                        
                                        SELF.temp_previouslyIncarcerated  := IncarBegin_date_compare <> DueDiligence.Constants.EMPTY AND IncarBegin_date_compare < (STRING8)LEFT.historydate;
                                        
                                        //additional data
                                        SELF.city := RIGHT.offensetown;
                                        SELF.agency := RIGHT.cty_conv;
                                        SELF.offenseReportedDate := (UNSIGNED)RIGHT.off_date;
                                        SELF.offenseArrestDate := (UNSIGNED)RIGHT.arr_date;
                                        SELF.offenseSentenceDate := (UNSIGNED)RIGHT.stc_dt;
                                        SELF.offenseSentenceStartDate := (UNSIGNED)IncarBegin_date;
                                        SELF.DOCConvictionOverrideDate := (UNSIGNED)RIGHT.conviction_override_date;
                                        
                                        //source data
                                        SELF.offenseMaxTerm := RIGHT.max_term_desc;

                                        SELF := LEFT;),
                              ATMOST(DueDiligence.Constants.MAX_ATMOST_OFFENSES), 
                              KEEP(DueDiligence.Constants.MAX_KEEP));
                                        
                                        
    addDOCDataPunishment := JOIN(addDOCDataOffense, doxie_files.Key_Punishment(),
                                  KEYED(LEFT.offenderKey = RIGHT.ok),
                                  TRANSFORM(DueDiligence.LayoutsInternal.IndCrimLayoutFlat,
                                            //additional data
                                            SELF.docScheduledReleaseDate := (UNSIGNED)RIGHT.sch_rel_dt;
                                            SELF.docActualReleaseDate := (UNSIGNED)RIGHT.act_rel_dt;
                                            SELF.docInmateStatus := RIGHT.cur_stat_inm_desc;
                                            SELF.docParoleStatus := RIGHT.par_cur_stat_desc; 
                                            
                                            SELF.temp_previouslyIncarcerated := LEFT.temp_previouslyIncarcerated OR 
                                                                                (RIGHT.latest_adm_dt <> DueDiligence.Constants.EMPTY AND 
                                                                                 RIGHT.latest_adm_dt < (STRING8)LEFT.historydate);
                                            
                                            SELF := LEFT;),
                                  ATMOST(DueDiligence.Constants.MAX_ATMOST_OFFENSES), 
                                  KEEP(DueDiligence.Constants.MAX_KEEP),
                                  LEFT OUTER);                                   


    allOffenseData := addNonDOCData + addDOCDataPunishment;
    
    dedupAllOffenseData := DEDUP(allOffenseData, ALL); 


    
    addLegalEventType := PROJECT(dedupAllOffenseData, TRANSFORM(DueDiligence.LayoutsInternal.IndCrimLayoutFlat,
    
                                                                      //calculate the offense score for each offense
                                                                      calcdOffenseScore := IF(LEFT.temp_offenseScore IN DueDiligence.Constants.UNKNOWN_OFFENSES,
                                                                                               DueDiligence.Common.LookAtOther(LEFT.temp_courtOffLevel,                 
                                                                                                                                LEFT.offenseCharge,
                                                                                                                                LEFT.courtDisposition1,
                                                                                                                                LEFT.courtDisposition2,
                                                                                                                                LEFT.offenseChargeLevelReported,
                                                                                                                                LEFT.offenseTrafficRelated),
                                                                                               LEFT.temp_offenseScore);
                                                                       
                                                                                               
                                                                      
                                                                      //calculate the event type levels for each offense
                                                                      charge := LEFT.offenseCharge;
                                                                      offenseLevel := calcdOffenseScore;
                                                                      category := LEFT.temp_category;
                                                                      traffic := LEFT.offenseTrafficRelated;
                                                                 
                                                                    
                                                                      typeLevel_9 := DueDiligence.translateExpression.getMaxLevel(charge, offenseLevel, category, traffic, DueDiligence.translateExpression.LEVEL_9);
                                                                      typeLevel_8 := DueDiligence.translateExpression.getMaxLevel(charge, offenseLevel, category, traffic, DueDiligence.translateExpression.LEVEL_8);                                                                                                                                
                                                                      typeLevel_7 := DueDiligence.translateExpression.getMaxLevel(charge, offenseLevel, category, traffic, DueDiligence.translateExpression.LEVEL_7);                                                                                                                                
                                                                      typeLevel_6 := DueDiligence.translateExpression.getMaxLevel(charge, offenseLevel, category, traffic, DueDiligence.translateExpression.LEVEL_6);                                                                                                                                
                                                                      typeLevel_5 := DueDiligence.translateExpression.getMaxLevel(charge, offenseLevel, category, traffic, DueDiligence.translateExpression.LEVEL_5);                                                                                                                                
                                                                      typeLevel_4 := DueDiligence.translateExpression.getMaxLevel(charge, offenseLevel, category, traffic, DueDiligence.translateExpression.LEVEL_4);                                                                                                                                
                                                                      typeLevel_3 := DueDiligence.translateExpression.getMaxLevel(charge, offenseLevel, category, traffic, DueDiligence.translateExpression.LEVEL_3);                                                                                                                                
                                                                      typeLevel_2 := DueDiligence.translateExpression.getMaxLevel(charge, offenseLevel, category, traffic, DueDiligence.translateExpression.LEVEL_2);
                                                                      
                                                                      legalSubCategory := MAX(typeLevel_9, typeLevel_8, typeLevel_7, typeLevel_6,
                                                                                              typeLevel_5, typeLevel_4, typeLevel_3, typeLevel_2);
                                                                                                            
                                                                      
                                                                      SELF.attr_legalEventCat9 := typeLevel_9 > 0;
                                                                      SELF.attr_legalEventCat8 := typeLevel_8 > 0;
                                                                      SELF.attr_legalEventCat7 := typeLevel_7 > 0;
                                                                      SELF.attr_legalEventCat6 := typeLevel_6 > 0;
                                                                      SELF.attr_legalEventCat5 := typeLevel_5 > 0;
                                                                      SELF.attr_legalEventCat4 := typeLevel_4 > 0;
                                                                      SELF.attr_legalEventCat3 := typeLevel_3 > 0;
                                                                      SELF.attr_legalEventCat2 := typeLevel_2 > 0;
                                                                                                            
                                                                      SELF.offenseDDLegalEventTypeCode := legalSubCategory;
                                                                                                            
                                                                      SELF.sort_eventTypeCodeFull := MAP(legalSubCategory > 0 => (STRING)legalSubCategory,
                                                                                                         LEFT.temp_category = 1099511627776 => LEFT.offenseCharge,
                                                                                                         (STRING)LEFT.temp_category);
                                                                            
                                                                      firstReportedActivityString := IF(LEFT.temp_date = DueDiligence.Constants.EMPTY, (STRING)LEFT.temp_calcdFirstSeenDate, LEFT.temp_date);     
                                                                      
                                                                      SELF.offenseDDFirstReportedActivity := firstReportedActivityString;
                                                                      SELF.temp_firstReportedActivity := firstReportedActivityString;
                                                                      
                                                                      SELF.offenseDDChargeLevelCalculated := calcdOffenseScore; 
                                                                      SELF.offenseChargeLevelCalculated := calcdOffenseScore;
 
                                                                      SELF := LEFT;));
    
    

    //Clean dates used in logic levels here so all comparisions flow through consistently
    crimCleanDate := DueDiligence.Common.CleanDatasetDateFields(addLegalEventType, 'temp_firstReportedActivity');
    
    // Filter out records after our history date.
    crimFilter := DueDiligence.Common.FilterRecordsSingleDate(crimCleanDate, temp_firstReportedActivity);
    
    


    // OUTPUT(getOffenderData, NAMED('getOffenderData'));
    // OUTPUT(dedupOffenders, NAMED('dedupOffenders'));
    // OUTPUT(getOffenderRiskData, NAMED('getOffenderRiskData'));
    // OUTPUT(dedupOffenderRisk, NAMED('dedupOffenderRisk'));
    // OUTPUT(offenderData, NAMED('offenderData'));
    // OUTPUT(addNonDOCData, NAMED('addNonDOCData'));
    // OUTPUT(addDOCDataOffense, NAMED('addDOCDataOffense'));
    // OUTPUT(addDOCDataPunishment, NAMED('addDOCDataPunishment'));
    // OUTPUT(dedupAllOffenseData, NAMED('dedupAllOffenseData'));

    // OUTPUT(addLegalEventType, NAMED('addLegalEventType'));
    // OUTPUT(crimCleanDate, NAMED('crimCleanDate'));
    // OUTPUT(crimFilter, NAMED('crimFilter'));
                                                                      
    RETURN crimFilter;

END;