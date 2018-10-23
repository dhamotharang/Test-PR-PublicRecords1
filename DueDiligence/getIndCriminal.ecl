IMPORT doxie_files, DueDiligence, STD, UT;


EXPORT getIndCriminal(DATASET(DueDiligence.LayoutsInternal.RelatedParty) individuals) := FUNCTION
    
    firstPopulatedString(field) := FUNCTIONMACRO
      RETURN IF(LEFT.field = '', RIGHT.field, LEFT.field);
    ENDMACRO;



    //get the raw data for criminal
    rawCriminalData := DueDiligence.getIndCriminalRawData(individuals);


    //lets figure out the unique party names - grab all source data along with top level data used to tie back the source data
    formatForAttrCalcs := PROJECT(rawCriminalData, TRANSFORM({DueDiligence.LayoutsInternal.IndCrimLayoutFinal -sources, DueDiligence.Layouts.CriminalSources -partyNames, STRING120 partyName},
                                                          
                                                              SELF.attr_currentlyIncarceratedOrParoled := TRIM(LEFT.offenseIncarcerationProbationParole) IN [DueDiligence.Constants.INCARCERATION_TEXT, DueDiligence.Constants.PAROLE_TEXT];
                                                              SELF.attr_previouslyIncarcerated := LEFT.temp_previouslyIncarcerated;
                                                              
                                                              
                                                              criminalActivityDate := DueDiligence.Common.DaysApartWithZeroEmptyDate(LEFT.offenseDDFirstReportedActivity, (STRING)LEFT.historyDate);
                                                              past3Years := ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK);
                                                              

                                                              SELF.attr_felonyPast3Yrs := LEFT.offenseChargeLevelCalculated = DueDiligence.Constants.FELONY AND 
                                                                                          LEFT.offenseConviction = DueDiligence.Constants.YES AND 
                                                                                          LEFT.offenseTrafficRelated = DueDiligence.Constants.NO AND
                                                                                          criminalActivityDate <= past3Years;
                                                                                          
                                                              SELF.attr_felonyOver3Yrs := LEFT.offenseChargeLevelCalculated = DueDiligence.Constants.FELONY AND 
                                                                                          LEFT.offenseConviction = DueDiligence.Constants.YES AND 
                                                                                          LEFT.offenseTrafficRelated = DueDiligence.Constants.NO AND
                                                                                          criminalActivityDate > past3Years;


                                                              SELF.attr_uncategorizedConvictionPast3Yrs := LEFT.offenseChargeLevelCalculated = DueDiligence.Constants.UNKNOWN AND 
                                                                                                           LEFT.offenseConviction = DueDiligence.Constants.YES AND 
                                                                                                           LEFT.offenseTrafficRelated = DueDiligence.Constants.NO AND
                                                                                                           criminalActivityDate <= past3Years;
                                                                                                           
                                                              SELF.attr_uncategorizedConvictionOver3Yrs := LEFT.offenseChargeLevelCalculated = DueDiligence.Constants.UNKNOWN AND 
                                                                                                           LEFT.offenseConviction = DueDiligence.Constants.YES AND 
                                                                                                           LEFT.offenseTrafficRelated = DueDiligence.Constants.NO AND
                                                                                                           criminalActivityDate > past3Years;
                                                                                                           
                                                              
                                                              SELF.attr_misdemeanorConvictionPast3Yrs := LEFT.offenseChargeLevelCalculated = DueDiligence.Constants.MISDEMEANOR AND 
                                                                                                         LEFT.offenseConviction = DueDiligence.Constants.YES AND 
                                                                                                         LEFT.offenseTrafficRelated = DueDiligence.Constants.NO AND
                                                                                                         criminalActivityDate <= past3Years;
                                                                                                         
                                                              SELF.attr_misdemeanorConvictionOver3Yrs := LEFT.offenseChargeLevelCalculated = DueDiligence.Constants.MISDEMEANOR AND 
                                                                                                         LEFT.offenseConviction = DueDiligence.Constants.YES AND 
                                                                                                         LEFT.offenseTrafficRelated = DueDiligence.Constants.NO AND
                                                                                                         criminalActivityDate > past3Years;

                                                              SELF.temp_chargeLevelCalcWeight := CASE(LEFT.offenseChargeLevelCalculated,
                                                                                                          DueDiligence.Constants.FELONY => 1,
                                                                                                          DueDiligence.Constants.MISDEMEANOR => 2,
                                                                                                          DueDiligence.Constants.TRAFFIC => 3,
                                                                                                          DueDiligence.Constants.INFRACTION => 4,
                                                                                                          5);
                                                                                                          

                                                              SELF.validate_trafficRelated := LEFT.offenseTrafficRelated;
                                                              SELF.validate_category := LEFT.temp_category;
                                                              SELF.validate_eventType := DueDiligence.translateExpression.expressionTextByEnum(LEFT.offenseDDLegalEventTypeCode);
                                                                                                      
                                                              SELF := LEFT;                                                            
                                                              SELF := [];));
                                                            
    dedupAllData := DEDUP(formatForAttrCalcs, ALL);
    
    transformPartyNames := PROJECT(dedupAllData, TRANSFORM({DueDiligence.LayoutsInternal.IndCrimLayoutFinal -sources, DueDiligence.Layouts.CriminalSources},
                                                            SELF.partyNames := DATASET([TRANSFORM({STRING120 name}, SELF.name := LEFT.partyName;)]);
                                                            SELF := LEFT;));

    //sort and roll parties by all sources, to get a list of the party names and to remove duplicate source data
    sortPartyNames := SORT(transformPartyNames, seq, did, ultID, orgID, seleID, source, sort_key, sort_eventTypeCodeFull, offenseDDFirstReportedActivity, offenseCharge, 
                            offenseConviction, offenseChargeLevelReported, courtDisposition1, courtDisposition2, offenseReportedDate, offenseArrestDate, offenseCourtDispDate, 
                            offenseAppealDate, offenseSentenceDate, offenseSentenceStartDate, DOCConvictionOverrideDate, DOCScheduledReleaseDate, DOCActualReleaseDate, DOCInmateStatus, 
                            DOCParoleStatus, offenseMaxTerm);
   
    rollPartyNames := ROLLUP(sortPartyNames,
                              LEFT.seq = RIGHT.seq AND
                              LEFT.did = RIGHT.did AND
                              LEFT.ultID = RIGHT.ultID AND
                              LEFT.orgID = RIGHT.orgID AND
                              LEFT.seleID = RIGHT.seleID AND
                              LEFT.sort_key = RIGHT.sort_key AND
                              LEFT.sort_eventTypeCodeFull = RIGHT.sort_eventTypeCodeFull AND
                              LEFT.offenseDDFirstReportedActivity = RIGHT.offenseDDFirstReportedActivity AND
                              LEFT.offenseCharge = RIGHT.offenseCharge AND
                              LEFT.offenseConviction = RIGHT.offenseConviction AND
                              LEFT.offenseChargeLevelCalculated = RIGHT.offenseChargeLevelCalculated AND
                              LEFT.offenseChargeLevelReported = RIGHT.offenseChargeLevelReported AND
                              LEFT.source = RIGHT.source AND
                              LEFT.courtDisposition1 = RIGHT.courtDisposition1 AND
                              LEFT.courtDisposition2 = RIGHT.courtDisposition2 AND
                              LEFT.offenseReportedDate = RIGHT.offenseReportedDate AND
                              LEFT.offenseArrestDate = RIGHT.offenseArrestDate AND
                              LEFT.offenseCourtDispDate = RIGHT.offenseCourtDispDate AND
                              LEFT.offenseAppealDate = RIGHT.offenseAppealDate AND
                              LEFT.offenseSentenceDate = RIGHT.offenseSentenceDate AND
                              LEFT.offenseSentenceStartDate = RIGHT.offenseSentenceStartDate AND
                              LEFT.DOCConvictionOverrideDate = RIGHT.DOCConvictionOverrideDate AND
                              LEFT.DOCScheduledReleaseDate = RIGHT.DOCScheduledReleaseDate AND
                              LEFT.DOCActualReleaseDate = RIGHT.DOCActualReleaseDate AND
                              LEFT.DOCInmateStatus = RIGHT.DOCInmateStatus AND
                              LEFT.DOCParoleStatus = RIGHT.DOCParoleStatus AND
                              LEFT.offenseMaxTerm = RIGHT.offenseMaxTerm,
                              TRANSFORM(RECORDOF(LEFT),
                                        SELF.partyNames := LEFT.partyNames + RIGHT.partyNames;
                                        SELF := LEFT;));
                                        
                                        
    //rollup the sources now
    transformSources := PROJECT(rollPartyNames, TRANSFORM({DueDiligence.LayoutsInternal.IndCrimLayoutFinal},
                                                          SELF.sources := DATASET([TRANSFORM(DueDiligence.Layouts.CriminalSources, SELF := LEFT;)]);
                                                          SELF := LEFT;));
                                                            
    sortSources := SORT(transformSources, seq, did, ultID, orgID, seleID, source, sort_key, -offenseDDFirstReportedActivity, temp_chargeLevelCalcWeight, -offenseDDLegalEventTypeCode, -offenseDDLastReportedActivity, offenseCharge);
    
    rollSources := ROLLUP(sortSources,
                              LEFT.seq = RIGHT.seq AND
                              LEFT.did = RIGHT.did AND
                              LEFT.ultID = RIGHT.ultID AND
                              LEFT.orgID = RIGHT.orgID AND
                              LEFT.seleID = RIGHT.seleID AND
                              LEFT.source = RIGHT.source AND
                              LEFT.sort_key = RIGHT.sort_key AND
                              LEFT.offenseDDFirstReportedActivity = RIGHT.offenseDDFirstReportedActivity,
                              TRANSFORM(RECORDOF(LEFT),
                                        // grab top level - first populated value or greatest value
                                        SELF.state := firstPopulatedString(state);
                                        SELF.source := firstPopulatedString(source);
                                        SELF.caseNumber := firstPopulatedString(caseNumber);
                                        SELF.offenseStatute := firstPopulatedString(offenseStatute);
                                        SELF.offenseDDLastReportedActivity := MAX(LEFT.offenseDDLastReportedActivity, RIGHT.offenseDDLastReportedActivity);
                                        SELF.offenseDDLastCourtDispDate := MAX(LEFT.offenseDDLastCourtDispDate, RIGHT.offenseDDLastCourtDispDate);
                                        SELF.offenseDDLegalEventTypeCode := MAX(LEFT.offenseDDLegalEventTypeCode, RIGHT.offenseDDLegalEventTypeCode);
                                        SELF.offenseCharge := IF(STD.Str.ToUpperCase(TRIM(LEFT.offenseCharge)) IN ['', 'NOT SPECIFIED', 'OTHER'], RIGHT.offenseCharge, LEFT.offenseCharge);
                                        
                                        SELF.offenseDDChargeLevelCalculated := MAP(LEFT.offenseDDChargeLevelCalculated = 'F' OR RIGHT.offenseDDChargeLevelCalculated = 'F' => 'F',
                                                                                   LEFT.offenseDDChargeLevelCalculated = 'M' OR RIGHT.offenseDDChargeLevelCalculated = 'M' => 'M',
                                                                                   LEFT.offenseDDChargeLevelCalculated = 'T' OR RIGHT.offenseDDChargeLevelCalculated = 'T' => 'T',
                                                                                   LEFT.offenseDDChargeLevelCalculated = 'I' OR RIGHT.offenseDDChargeLevelCalculated = 'I' => 'I',
                                                                                   LEFT.offenseDDChargeLevelCalculated = 'U' OR RIGHT.offenseDDChargeLevelCalculated = 'U' => 'U',
                                                                                   DueDiligence.Constants.EMPTY);
                                                                                   
                                        SELF.offenseChargeLevelReported := firstPopulatedString(offenseChargeLevelReported);
                                        SELF.offenseConviction := IF(LEFT.offenseConviction = DueDiligence.Constants.Yes, LEFT.offenseConviction, RIGHT.offenseConviction);
                                        SELF.offenseIncarcerationProbationParole := firstPopulatedString(offenseIncarcerationProbationParole); 
                                        SELF.offenseTrafficRelated := MAP(LEFT.offenseTrafficRelated = 'N' OR RIGHT.offenseTrafficRelated = 'N' => 'N',
                                                                          LEFT.offenseTrafficRelated = 'Y' OR RIGHT.offenseTrafficRelated = 'Y' => 'Y',
                                                                          LEFT.offenseTrafficRelated = DueDiligence.Constants.EMPTY => RIGHT.offenseTrafficRelated,
                                                                          LEFT.offenseTrafficRelated);
                                       
                                              
                                              
                                        // grab additional details - first populated value
                                        SELF.county := firstPopulatedString(county); 
                                        SELF.countyCourt := firstPopulatedString(countyCourt); 
                                        SELF.city := firstPopulatedString(city); 
                                        SELF.agency := firstPopulatedString(agency); 
                                        SELF.race := firstPopulatedString(race); 
                                        SELF.sex := firstPopulatedString(sex); 
                                        SELF.hairColor := firstPopulatedString(hairColor); 
                                        SELF.eyeColor := firstPopulatedString(eyeColor); 
                                        SELF.height := firstPopulatedString(height); 
                                        SELF.weight := firstPopulatedString(weight);
                                        
                                        
                                        //roll attribute logic per the sources
                                        SELF.attr_currentlyIncarceratedOrParoled := LEFT.attr_currentlyIncarceratedOrParoled OR RIGHT.attr_currentlyIncarceratedOrParoled;
                                        SELF.attr_previouslyIncarcerated := LEFT.attr_previouslyIncarcerated OR RIGHT.attr_previouslyIncarcerated;

                                        SELF.attr_felonyPast3Yrs := LEFT.attr_felonyPast3Yrs OR RIGHT.attr_felonyPast3Yrs;                          
                                        SELF.attr_felonyOver3Yrs := LEFT.attr_felonyOver3Yrs OR RIGHT.attr_felonyOver3Yrs;

                                        SELF.attr_uncategorizedConvictionPast3Yrs := LEFT.attr_uncategorizedConvictionPast3Yrs OR RIGHT.attr_uncategorizedConvictionPast3Yrs;
                                        SELF.attr_uncategorizedConvictionOver3Yrs := LEFT.attr_uncategorizedConvictionOver3Yrs OR RIGHT.attr_uncategorizedConvictionOver3Yrs;
                                        
                                        SELF.attr_misdemeanorConvictionPast3Yrs := LEFT.attr_misdemeanorConvictionPast3Yrs OR RIGHT.attr_misdemeanorConvictionPast3Yrs;
                                        SELF.attr_misdemeanorConvictionOver3Yrs := LEFT.attr_misdemeanorConvictionOver3Yrs OR RIGHT.attr_misdemeanorConvictionOver3Yrs;
                                        
                                        SELF.attr_legalEventCat9 := LEFT.attr_legalEventCat9 OR RIGHT.attr_legalEventCat9;
                                        SELF.attr_legalEventCat8 := LEFT.attr_legalEventCat8 OR RIGHT.attr_legalEventCat8;
                                        SELF.attr_legalEventCat7 := LEFT.attr_legalEventCat7 OR RIGHT.attr_legalEventCat7;
                                        SELF.attr_legalEventCat6 := LEFT.attr_legalEventCat6 OR RIGHT.attr_legalEventCat6;
                                        SELF.attr_legalEventCat5 := LEFT.attr_legalEventCat5 OR RIGHT.attr_legalEventCat5;
                                        SELF.attr_legalEventCat4 := LEFT.attr_legalEventCat4 OR RIGHT.attr_legalEventCat4;
                                        SELF.attr_legalEventCat3 := LEFT.attr_legalEventCat3 OR RIGHT.attr_legalEventCat3;
                                        SELF.attr_legalEventCat2 := LEFT.attr_legalEventCat2 OR RIGHT.attr_legalEventCat2;
                              
                                        SELF.sources := LEFT.sources + RIGHT.sources;
                                        SELF := LEFT;));


    //roll up all offenses now by person
    formatCrimData := PROJECT(rollSources, TRANSFORM({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout,  BOOLEAN attr_currentlyIncarceratedOrParoled,
                                                                          BOOLEAN attr_felonyPast3Yrs, BOOLEAN attr_felonyOver3Yrs, BOOLEAN attr_previouslyIncarcerated,
                                                                          BOOLEAN attr_uncategorizedConvictionPast3Yrs, BOOLEAN attr_uncategorizedConvictionOver3Yrs,
                                                                          BOOLEAN attr_misdemeanorConvictionPast3Yrs, BOOLEAN attr_misdemeanorConvictionOver3Yrs, 
                                                                          BOOLEAN attr_legalEventCat9, BOOLEAN attr_legalEventCat8, BOOLEAN attr_legalEventCat7;
                                                                          BOOLEAN attr_legalEventCat6, BOOLEAN attr_legalEventCat5, BOOLEAN attr_legalEventCat4;
                                                                          BOOLEAN attr_legalEventCat3, BOOLEAN attr_legalEventCat2;
                                                                          DATASET(DueDiligence.Layouts.CriminalOffenses) indCrimOffenses},
                                                      
                                                      SELF.indCrimOffenses := DATASET([TRANSFORM(DueDiligence.Layouts.CriminalOffenses, SELF := LEFT;)]);
                                                      SELF := LEFT;
                                                      SELF := [];));
                                                      

    sortformatCrimData := SORT(formatCrimData, seq, did, ultID, orgID, seleID);  
    
    rollCrimToDID := ROLLUP(sortformatCrimData,
                            LEFT.seq = RIGHT.seq AND
                            LEFT.did = RIGHT.did AND
                            LEFT.ultID = RIGHT.ultID AND
                            LEFT.orgID = RIGHT.orgID AND
                            LEFT.seleID = RIGHT.seleID,
                            TRANSFORM(RECORDOF(LEFT),
                                      SELF.attr_currentlyIncarceratedOrParoled := LEFT.attr_currentlyIncarceratedOrParoled OR RIGHT.attr_currentlyIncarceratedOrParoled;
                                      SELF.attr_felonyPast3Yrs := LEFT.attr_felonyPast3Yrs OR RIGHT.attr_felonyPast3Yrs;
                                      SELF.attr_felonyOver3Yrs := LEFT.attr_felonyOver3Yrs OR RIGHT.attr_felonyOver3Yrs;
                                      SELF.attr_previouslyIncarcerated := LEFT.attr_previouslyIncarcerated OR RIGHT.attr_previouslyIncarcerated;
                                      SELF.attr_uncategorizedConvictionPast3Yrs := LEFT.attr_uncategorizedConvictionPast3Yrs OR RIGHT.attr_uncategorizedConvictionPast3Yrs;
                                      SELF.attr_uncategorizedConvictionOver3Yrs := LEFT.attr_uncategorizedConvictionOver3Yrs OR RIGHT.attr_uncategorizedConvictionOver3Yrs;
                                      SELF.attr_misdemeanorConvictionPast3Yrs := LEFT.attr_misdemeanorConvictionPast3Yrs OR RIGHT.attr_misdemeanorConvictionPast3Yrs;
                                      SELF.attr_misdemeanorConvictionOver3Yrs := LEFT.attr_misdemeanorConvictionOver3Yrs OR RIGHT.attr_misdemeanorConvictionOver3Yrs;
                                      
                                      SELF.attr_legalEventCat9 := LEFT.attr_legalEventCat9 OR RIGHT.attr_legalEventCat9;
                                      SELF.attr_legalEventCat8 := LEFT.attr_legalEventCat8 OR RIGHT.attr_legalEventCat8;
                                      SELF.attr_legalEventCat7 := LEFT.attr_legalEventCat7 OR RIGHT.attr_legalEventCat7;
                                      SELF.attr_legalEventCat6 := LEFT.attr_legalEventCat6 OR RIGHT.attr_legalEventCat6;
                                      SELF.attr_legalEventCat5 := LEFT.attr_legalEventCat5 OR RIGHT.attr_legalEventCat5;
                                      SELF.attr_legalEventCat4 := LEFT.attr_legalEventCat4 OR RIGHT.attr_legalEventCat4;
                                      SELF.attr_legalEventCat3 := LEFT.attr_legalEventCat3 OR RIGHT.attr_legalEventCat3;
                                      SELF.attr_legalEventCat2 := LEFT.attr_legalEventCat2 OR RIGHT.attr_legalEventCat2;
                                      
                                      SELF.indCrimOffenses := LEFT.indCrimOffenses + RIGHT.indCrimOffenses;
                                      SELF := LEFT;));



    //for each person determine state criminal data levels
    indivCrimLayout := PROJECT(rollCrimToDID, TRANSFORM({RECORDOF(LEFT)crimOffenses, DueDiligence.Layouts.Indv_Internal indv},
                                                        
                                                        SELF.crimOffenses := LEFT;
                                                        
                                                        SELF.indv.seq := LEFT.seq;
                                                        SELF.indv.inquiredDID := LEFT.did;
                                                       
                                                        /*PerStateLegalEvent*/
                                                        SELF.indv.currentIncarcerationOrParole := LEFT.attr_currentlyIncarceratedOrParoled;
                                                        SELF.indv.felonyPast3Yrs := LEFT.attr_felonyPast3Yrs;
                                                        SELF.indv.felonyOver3Yrs := LEFT.attr_felonyOver3Yrs;
                                                        SELF.indv.previousIncarceration := LEFT.attr_previouslyIncarcerated;
                                                        SELF.indv.uncategorizedConvictionPast3Yrs := LEFT.attr_uncategorizedConvictionPast3Yrs;
                                                        SELF.indv.misdemeanorConvictionPast3Yrs := LEFT.attr_misdemeanorConvictionPast3Yrs;
                                                        SELF.indv.uncategorizedConvictionOver3Yrs := LEFT.attr_uncategorizedConvictionOver3Yrs;
                                                        SELF.indv.misdemeanorConvictionOver3Years := LEFT.attr_misdemeanorConvictionOver3Yrs;
                                                        
                                                        /*PerLegalEventType*/
                                                        SELF.indv.atleastOneCategory9 := LEFT.attr_legalEventCat9;
                                                        SELF.indv.atleastOneCategory8 := LEFT.attr_legalEventCat8;
                                                        SELF.indv.atleastOneCategory7 := LEFT.attr_legalEventCat7;
                                                        SELF.indv.atleastOneCategory6 := LEFT.attr_legalEventCat6;
                                                        SELF.indv.atleastOneCategory5 := LEFT.attr_legalEventCat5;
                                                        SELF.indv.atleastOneCategory4 := LEFT.attr_legalEventCat4;
                                                        SELF.indv.atleastOneCategory3 := LEFT.attr_legalEventCat3;
                                                        SELF.indv.atleastOneCategory2 := LEFT.attr_legalEventCat2;
                                                        SELF := [];));
    
    
    //join all individuals and potential crim data
    addCrimData := JOIN(individuals, indivCrimLayout,
                        LEFT.seq = RIGHT.indv.seq AND
                        LEFT.did = RIGHT.indv.inquiredDID,
                        TRANSFORM(DueDiligence.LayoutsInternal.RelatedParty,
                        
                                  stateCrim := DueDiligence.getIndKRILegalStateCriminal(RIGHT.indv);  
                                  SELF.party.stateCriminalLegalEventsScore := stateCrim.name;
                                  SELF.party.stateCriminalLegalEventsFlags := stateCrim.value;
                                  
                                  legalEventType := DueDiligence.getIndKRILegalEventType(RIGHT.indv);
                                  SELF.party.legalEventTypeScore := legalEventType.name;
                                  SELF.party.legalEventTypeFlags := legalEventType.value;

                                  SELF.party.indOffenses := RIGHT.crimOffenses.indCrimOffenses;
                                  
                                  SELF := LEFT;),
                        LEFT OUTER,
                        ATMOST(1));
   
   
   
   
   
    
    // OUTPUT(rawCriminalData, NAMED('rawCriminalData'));
    // OUTPUT(formatForAttrCalcs, NAMED('formatForAttrCalcs'));
    // OUTPUT(dedupAllData, NAMED('dedupSlimPartyNames'));
    // OUTPUT(transformPartyNames, NAMED('transformPartyNames'));
    // OUTPUT(rollPartyNames, NAMED('rollPartyNames'));
    
    // OUTPUT(transformSources, NAMED('transformSources'));
    // OUTPUT(sortSources, NAMED('sortSources'));
    // OUTPUT(rollSources, NAMED('rollSources'));
    
    // OUTPUT(formatCrimData, NAMED('formatCrimData'));
    // OUTPUT(rollCrimToDID, NAMED('rollCrimToDID'));
    // OUTPUT(indivCrimLayout, NAMED('indivCrimLayout'));
    
    // OUTPUT(addCrimData, NAMED('addCrimData'));
    
   
   

    RETURN addCrimData;
END;
