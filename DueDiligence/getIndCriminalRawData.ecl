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
    
    
 
 
 
    offenderData := JOIN(individuals, doxie_files.Key_Offenders(),
                          RIGHT.sdid = LEFT.did,
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

                                      SELF := [];));
                                      
                                      
                                     
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
                                      
                                      
                                                                 
                                      //top level data
                                      SELF.state := RIGHT.state_origin;
                                      SELF.source := mapCourtCaseTypes(RIGHT.data_type);
                                      SELF.offenseStatute := RIGHT.court_statute;
                                      SELF.caseNumber := STD.Str.FilterOut(IF(RIGHT.data_type = '5', RIGHT.le_agency_case_number, DueDiligence.Constants.EMPTY), '-');
                                      SELF.offenseCharge := IF(RIGHT.data_type = '5', RIGHT.arr_off_desc_1, RIGHT.court_off_desc_1);
                                      SELF.offenseChargeLevelReported := IF(RIGHT.data_type = '2', RIGHT.court_off_lev_mapped, RIGHT.arr_off_lev_mapped);
                                      SELF.offenseDDLastReportedActivity := MAX((UNSIGNED)RIGHT.off_date, (UNSIGNED)RIGHT.arr_date, 
                                                                                (UNSIGNED)RIGHT.court_disp_date, (UNSIGNED)RIGHT.sent_date);                                          
                                     
                                     
                                      
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
                                      
                                      SELF := LEFT;));                                 
  
  
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
                                        SELF.caseNumber := STD.Str.FilterOut(RIGHT.case_num, '-');
                                        
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

                                        SELF := LEFT;));
                                        
                                        
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
                                  LEFT OUTER);                                   


    allOffenseData := addNonDOCData + addDOCDataPunishment;
    dedupAllOffenseData := DEDUP(allOffenseData, ALL); 


    addOffenderRiskData := JOIN(dedupAllOffenseData, doxie_files.key_offenders_risk(),
                                LEFT.did != 0 AND 
                                KEYED(LEFT.did = RIGHT.sdid) AND
                                LEFT.offenderKey = RIGHT.offender_key,
                                TRANSFORM(DueDiligence.LayoutsInternal.IndCrimLayoutFlat,
                                          
                                          offenseScore := RIGHT.offense_score;
                                          
                                          calcdOffenseScore := IF(offenseScore IN DueDiligence.Constants.UNKNOWN_OFFENSES,
                                                                   DueDiligence.Common.LookAtOther(RIGHT.offense.court_off_lev,                 
                                                                                                    RIGHT.offense.court_off_desc_1, 
                                                                                                    RIGHT.offense.court_disp_desc_1, 
                                                                                                    RIGHT.offense.court_disp_desc_2,
                                                                                                    LEFT.offenseChargeLevelReported),
                                                                   offenseScore);
                                                                   
                                          
                                          SELF.offenseDDChargeLevelCalculated := calcdOffenseScore; 
                                          SELF.offenseChargeLevelCalculated := calcdOffenseScore;
                                          SELF.offenseTrafficRelated := RIGHT.traffic_flag;
                                          SELF.offenseConviction := RIGHT.conviction_flag;
                                          
                                          SELF.caseNumber := STD.Str.FilterOut(IF(LEFT.caseNumber = DueDiligence.Constants.EMPTY, RIGHT.case_num, LEFT.caseNumber), '-');
                                          
                                          // additional data
                                          SELF.source := IF(LEFT.source = DueDiligence.Constants.EMPTY, RIGHT.case_type_desc, LEFT.source);
                                          
                                          SELF := LEFT;),
                                LEFT OUTER);

    dedupAllWithOffenderRisk := DEDUP(addOffenderRiskData, ALL);
    
    addLegalEventType := PROJECT(dedupAllWithOffenderRisk, TRANSFORM(DueDiligence.LayoutsInternal.IndCrimLayoutFlat,
                                                  
                                                                      expression := DueDiligence.RegularExpressions(LEFT.offenseCharge, 
                                                                                                                    LEFT.offenseDDChargeLevelCalculated, 
                                                                                                                    LEFT.offenseTrafficRelated);
                                                                    
                                                                      typeLevel_9 := MAX(expression.foundCorruptionOrBribery,
                                                                                          expression.foundLaundering,
                                                                                          expression.foundOrganizedCrime,
                                                                                          expression.foundTerror,
                                                                                          expression.foundIdentityTheft,
                                                                                          expression.foundCounterfeit,
                                                                                          expression.foundFalsePretense,
                                                                                          expression.foundInterceptCommunication,
                                                                                          expression.foundInsiderTrading,
                                                                                          expression.foundTreasonOrEspionage,
                                                                                          expression.foundExtortion,
                                                                                          expression.foundConcealmentOfFunds,
                                                                                          expression.foundHijacking,
                                                                                          expression.foundWire,               
                                                                                          expression.foundChopShop);
                                                                                                                                
                                                                      typeLevel_8 := MAX(expression.foundTraffickingOrSmuggling,
                                                                                          expression.foundExplosives,
                                                                                          expression.foundWeapons,
                                                                                          expression.foundDrugs,
                                                                                          expression.foundDistributionManufacturingTransportation);
                                                                                                                                
                                                                      typeLevel_7 := MAX(expression.foundFraud,                 
                                                                                         expression.foundCheckFraud,          
                                                                                         expression.foundForgery,              
                                                                                         expression.foundEmbezzlement,         
                                                                                         expression.foundTaxOffenses);      
                                                                                                                                
                                                                      typeLevel_6 := MAX(expression.foundGrandLarceny,
                                                                                         expression.foundBankRobbery,
                                                                                         expression.foundArmedRobbery,
                                                                                         expression.foundRobbery,
                                                                                         expression.foundFelonlyTheft,
                                                                                         expression.foundMisdemeanorTheft,
                                                                                         expression.foundLarceny,
                                                                                         expression.foundOrganizedRetailTheft,
                                                                                         expression.foundArson,
                                                                                         expression.foundBurglary,
                                                                                         expression.foundBreakingAndEntering,
                                                                                         expression.foundMurderHomocideManslaughter,   
                                                                                         expression.foundAssultWithIntentToKill,       
                                                                                         expression.foundKidnappingOrAbduction);  
                                                                                                                                
                                                                      typeLevel_5 := MAX(expression.foundSolicitation,
                                                                                         expression.foundPorn,
                                                                                         expression.foundProstitution,
                                                                                         expression.foundSexualAssaultAndBattery,
                                                                                         expression.foundSexualAbuse,
                                                                                         expression.foundStatutoryRape,
                                                                                         expression.foundRape,
                                                                                         expression.foundMolestation);
                                                                                                                                
                                                                      typeLevel_4 := MAX(expression.foundAggravatedAssaultOrBattery,
                                                                                          expression.foundAssaultWithDeadlyWeapon,
                                                                                          expression.foundAssault,
                                                                                          expression.foundDomesticViolence,
                                                                                          expression.foundAnimalFighting,
                                                                                          expression.foundStalkingOrHarassment,
                                                                                          expression.foundCyberStalking,
                                                                                          expression.foundViolateRestrainingOrder,
                                                                                          expression.foundResistingArrest,
                                                                                          expression.foundPropertyDestruction,
                                                                                          expression.foundVandalism);
                                                                                                                                
                                                                      typeLevel_3 := MAX(expression.foundPerjury,
                                                                                         expression.foundObstruction,
                                                                                         expression.foundTampering,
                                                                                         expression.foundComputerOffenses,
                                                                                         expression.foundGamblingOrBitcoin);
                                                                                                                                
                                                                      typeLevel_2 := MAX(expression.foundShoplifting,
                                                                                          expression.foundAlienOffenses,
                                                                                          expression.foundTrafficOffenses,
                                                                                          expression.foundDUI,
                                                                                          expression.foundTrespassing,
                                                                                          expression.foundDisorderlyConduct,
                                                                                          expression.foundPublicIntoxication);
                                                                      
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
 
                                                                      SELF := LEFT;));
    
    

    //Clean dates used in logic levels here so all comparisions flow through consistently
    crimCleanDate := DueDiligence.Common.CleanDatasetDateFields(addLegalEventType, 'temp_firstReportedActivity');
    
    // Filter out records after our history date.
    crimFilter := DueDiligence.Common.FilterRecordsSingleDate(crimCleanDate, temp_firstReportedActivity);
    
    


    // OUTPUT(offenderData, NAMED('offenderData'));
    // OUTPUT(addNonDOCData, NAMED('addNonDOCData'));
    // OUTPUT(addDOCDataOffense, NAMED('addDOCDataOffense'));
    // OUTPUT(addDOCDataPunishment, NAMED('addDOCDataPunishment'));
    // OUTPUT(dedupAllOffenseData, NAMED('dedupAllOffenseData'));
    // OUTPUT(addOffenderRiskData, NAMED('addOffenderRiskData'));
    // OUTPUT(dedupAllWithOffenderRisk, NAMED('dedupAllWithOffenderRisk'));
    // OUTPUT(addLegalEventType, NAMED('addLegalEventType'));
    // OUTPUT(crimCleanDate, NAMED('crimCleanDate'));
    // OUTPUT(crimFilter, NAMED('crimFilter'));
                                                                      
    RETURN crimFilter;

END;