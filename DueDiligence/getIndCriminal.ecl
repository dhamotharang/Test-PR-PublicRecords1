IMPORT BIPv2, doxie_files, DueDiligence, STD, UT;


EXPORT getIndCriminal(DATASET(DueDiligence.LayoutsInternal.RelatedParty) individuals) := FUNCTION


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
    
		//remove duplicate data where they are all the same in this new layout
    dedupAllData := DEDUP(formatForAttrCalcs, ALL);
    
    transformPartyNames := PROJECT(dedupAllData, TRANSFORM({DueDiligence.LayoutsInternal.IndCrimLayoutFinal -sources,  STRING120 dedupName, DATASET({STRING120 name}) partyNames},
                                                            SELF.partyNames := DATASET([TRANSFORM({STRING120 name}, SELF.name := LEFT.partyName;)]);
																														SELF.dedupName := LEFT.partyName;
                                                            SELF := LEFT;));
																														
		//get unique party names for a given offense
		sortUniquePartyNames := SORT(transformPartyNames, seq, did, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), source, sort_key, -offenseDDFirstReportedActivity, offenseDDLegalEventTypeCode, dedupName);
		dedupUniquePartyNames := DEDUP(sortUniquePartyNames, seq, did, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), source, sort_key, offenseDDFirstReportedActivity, offenseDDLegalEventTypeCode, dedupName);

    //sort and roll parties by offense
    sortPartyNames := SORT(dedupUniquePartyNames, seq, did, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), source, sort_key, -offenseDDFirstReportedActivity, offenseDDLegalEventTypeCode, temp_chargeLevelCalcWeight, -offenseDDLastReportedActivity, offenseCharge);
   
	  //get unique party names for an offense
    uniquePartyNames := ROLLUP(sortPartyNames,
                              LEFT.seq = RIGHT.seq AND
															LEFT.did = RIGHT.did AND
															LEFT.ultID = RIGHT.ultID AND
															LEFT.orgID = RIGHT.orgID AND
															LEFT.seleID = RIGHT.seleID AND
															LEFT.source = RIGHT.source AND
															LEFT.sort_key = RIGHT.sort_key AND
															LEFT.offenseDDFirstReportedActivity = RIGHT.offenseDDFirstReportedActivity AND
															LEFT.offenseDDLegalEventTypeCode = RIGHT.offenseDDLegalEventTypeCode,
                              TRANSFORM(RECORDOF(LEFT),
                                        SELF.partyNames := LEFT.partyNames + RIGHT.partyNames;
                                        SELF := LEFT;));
																				
																				
		transformSources := JOIN(dedupAllData, uniquePartyNames,
									LEFT.seq = RIGHT.seq AND
									LEFT.did = RIGHT.did AND
									LEFT.ultID = RIGHT.ultID AND
									LEFT.orgID = RIGHT.orgID AND
									LEFT.seleID = RIGHT.seleID AND
									LEFT.source = RIGHT.source AND
									LEFT.sort_key = RIGHT.sort_key AND
									LEFT.offenseDDFirstReportedActivity = RIGHT.offenseDDFirstReportedActivity AND
									LEFT.offenseDDLegalEventTypeCode = RIGHT.offenseDDLegalEventTypeCode,
									TRANSFORM(DueDiligence.LayoutsInternal.IndCrimLayoutFinal,
														SELF.sources := DATASET([TRANSFORM(DueDiligence.Layouts.CriminalSources, 
																											SELF.partyNames := RIGHT.partyNames;
																											SELF := LEFT;)]);
														SELF := LEFT;));

                                                            
    sortSources := SORT(transformSources, seq, did, ultID, orgID, seleID, source, sort_key, -offenseDDFirstReportedActivity, offenseDDLegalEventTypeCode, temp_chargeLevelCalcWeight, -offenseDDLastReportedActivity, offenseCharge);
    
    rollSources := ROLLUP(sortSources,
													LEFT.seq = RIGHT.seq AND
													LEFT.did = RIGHT.did AND
													LEFT.ultID = RIGHT.ultID AND
													LEFT.orgID = RIGHT.orgID AND
													LEFT.seleID = RIGHT.seleID AND
													LEFT.source = RIGHT.source AND
													LEFT.sort_key = RIGHT.sort_key AND
													LEFT.offenseDDFirstReportedActivity = RIGHT.offenseDDFirstReportedActivity AND
													LEFT.offenseDDLegalEventTypeCode = RIGHT.offenseDDLegalEventTypeCode,
													TRANSFORM(DueDiligence.LayoutsInternal.IndCrimLayoutFinal,
																		// grab top level - first populated value or greatest value
																		SELF.state := DueDiligence.Common.firstPopulatedString(state);
																		SELF.source := DueDiligence.Common.firstPopulatedString(source);
																		SELF.caseNumber := DueDiligence.Common.firstPopulatedString(caseNumber);
																		SELF.offenseStatute := DueDiligence.Common.firstPopulatedString(offenseStatute);
																		SELF.offenseDDLastReportedActivity := MAX(LEFT.offenseDDLastReportedActivity, RIGHT.offenseDDLastReportedActivity);
																		SELF.offenseDDLastCourtDispDate := MAX(LEFT.offenseDDLastCourtDispDate, RIGHT.offenseDDLastCourtDispDate);
																		SELF.offenseDDLegalEventTypeCode := MAX(LEFT.offenseDDLegalEventTypeCode, RIGHT.offenseDDLegalEventTypeCode);
																		SELF.offenseCharge := IF(STD.Str.ToUpperCase(TRIM(LEFT.offenseCharge)) IN ['', 'NOT SPECIFIED', 'OTHER'], RIGHT.offenseCharge, LEFT.offenseCharge);
																		
																		tempCalcdLevel := MAP(LEFT.offenseDDChargeLevelCalculated = DueDiligence.Constants.FELONY OR RIGHT.offenseDDChargeLevelCalculated = DueDiligence.Constants.FELONY => DueDiligence.Constants.FELONY,
																													 LEFT.offenseDDChargeLevelCalculated = DueDiligence.Constants.MISDEMEANOR OR RIGHT.offenseDDChargeLevelCalculated = DueDiligence.Constants.MISDEMEANOR => DueDiligence.Constants.MISDEMEANOR,
																													 LEFT.offenseDDChargeLevelCalculated = DueDiligence.Constants.TRAFFIC OR RIGHT.offenseDDChargeLevelCalculated = DueDiligence.Constants.TRAFFIC => DueDiligence.Constants.TRAFFIC,
																													 LEFT.offenseDDChargeLevelCalculated = DueDiligence.Constants.INFRACTION OR RIGHT.offenseDDChargeLevelCalculated = DueDiligence.Constants.INFRACTION => DueDiligence.Constants.INFRACTION,
																													 LEFT.offenseDDChargeLevelCalculated = DueDiligence.Constants.UNKNOWN OR RIGHT.offenseDDChargeLevelCalculated = DueDiligence.Constants.UNKNOWN => DueDiligence.Constants.UNKNOWN,
																													 DueDiligence.Constants.EMPTY);
																		
																		SELF.offenseDDChargeLevelCalculated := tempCalcdLevel;
																		
																		SELF.offenseIncarcerationProbationParole := MAP(LEFT.offenseIncarcerationProbationParole = DueDiligence.Constants.INCARCERATION_TEXT OR RIGHT.offenseIncarcerationProbationParole = DueDiligence.Constants.INCARCERATION_TEXT => DueDiligence.Constants.INCARCERATION_TEXT,
																																										LEFT.offenseIncarcerationProbationParole = DueDiligence.Constants.PAROLE_TEXT OR RIGHT.offenseIncarcerationProbationParole = DueDiligence.Constants.PAROLE_TEXT => DueDiligence.Constants.PAROLE_TEXT,
																																										LEFT.offenseIncarcerationProbationParole = DueDiligence.Constants.PROBATION_TEXT OR RIGHT.offenseIncarcerationProbationParole = DueDiligence.Constants.PROBATION_TEXT => DueDiligence.Constants.PROBATION_TEXT,
																																										LEFT.offenseIncarcerationProbationParole = DueDiligence.Constants.PREVIOUSLY_INCARCERATED_TEXT OR RIGHT.offenseIncarcerationProbationParole = DueDiligence.Constants.PREVIOUSLY_INCARCERATED_TEXT => DueDiligence.Constants.PREVIOUSLY_INCARCERATED_TEXT,
																																										LEFT.offenseIncarcerationProbationParole = DueDiligence.Constants.EMPTY => RIGHT.offenseIncarcerationProbationParole,
																																										LEFT.offenseIncarcerationProbationParole);
																																										
																																																											 
																		SELF.offenseChargeLevelReported := DueDiligence.Common.firstPopulatedString(offenseChargeLevelReported);
																		SELF.offenseConviction := IF(LEFT.offenseConviction = DueDiligence.Constants.Yes, LEFT.offenseConviction, RIGHT.offenseConviction);
																		SELF.offenseTrafficRelated := MAP((LEFT.offenseTrafficRelated = DueDiligence.Constants.YES OR RIGHT.offenseTrafficRelated = DueDiligence.Constants.YES) OR
																																			(LEFT.offenseChargeLevelReported IN [DueDiligence.Constants.TRAFFIC, 'TRAFFIC'] OR RIGHT.offenseChargeLevelReported IN [DueDiligence.Constants.TRAFFIC, 'TRAFFIC']) OR
																																			(LEFT.offenseDDLegalEventTypeCode = DueDiligence.translateExpression.ExpressionEnum.TRAFFIC_OFFENSES OR RIGHT.offenseDDLegalEventTypeCode = DueDiligence.translateExpression.ExpressionEnum.TRAFFIC_OFFENSES) OR
																																			tempCalcdLevel = DueDiligence.Constants.TRAFFIC => DueDiligence.Constants.YES,
																																			LEFT.offenseTrafficRelated = DueDiligence.Constants.EMPTY => RIGHT.offenseTrafficRelated,
																																			LEFT.offenseTrafficRelated);
																	 
																					
																					
																		// grab additional details - first populated value
																		SELF.county := DueDiligence.Common.firstPopulatedString(county); 
																		SELF.countyCourt := DueDiligence.Common.firstPopulatedString(countyCourt); 
																		SELF.city := DueDiligence.Common.firstPopulatedString(city); 
																		SELF.agency := DueDiligence.Common.firstPopulatedString(agency); 
																		SELF.race := DueDiligence.Common.firstPopulatedString(race); 
																		SELF.sex := DueDiligence.Common.firstPopulatedString(sex); 
																		SELF.hairColor := DueDiligence.Common.firstPopulatedString(hairColor); 
																		SELF.eyeColor := DueDiligence.Common.firstPopulatedString(eyeColor); 
																		SELF.height := DueDiligence.Common.firstPopulatedString(height); 
																		SELF.weight := DueDiligence.Common.firstPopulatedString(weight);
																		
																		
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
                                                       
                                                        //PerStateLegalEvent
                                                        SELF.indv.currentIncarcerationOrParole := LEFT.attr_currentlyIncarceratedOrParoled;
                                                        SELF.indv.felonyPast3Yrs := LEFT.attr_felonyPast3Yrs;
                                                        SELF.indv.felonyOver3Yrs := LEFT.attr_felonyOver3Yrs;
                                                        SELF.indv.previousIncarceration := LEFT.attr_previouslyIncarcerated;
                                                        SELF.indv.uncategorizedConvictionPast3Yrs := LEFT.attr_uncategorizedConvictionPast3Yrs;
                                                        SELF.indv.misdemeanorConvictionPast3Yrs := LEFT.attr_misdemeanorConvictionPast3Yrs;
                                                        SELF.indv.uncategorizedConvictionOver3Yrs := LEFT.attr_uncategorizedConvictionOver3Yrs;
                                                        SELF.indv.misdemeanorConvictionOver3Years := LEFT.attr_misdemeanorConvictionOver3Yrs;
                                                        
                                                        //PerLegalEventType
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
   
   
   
   
   
    
		// OUTPUT(transformPartyNames, NAMED('transformPartyNames'));																		
		// OUTPUT(sortUniquePartyNames, NAMED('sortUniquePartyNames'));																		
		// OUTPUT(dedupUniquePartyNames, NAMED('dedupUniquePartyNames'));																		
		// OUTPUT(sortPartyNames, NAMED('sortPartyNames'));																		
		// OUTPUT(uniquePartyNames, NAMED('uniquePartyNames'));																		
		// OUTPUT(transformSources, NAMED('transformSources'));																		
		// OUTPUT(sortSources, NAMED('sortSources'));																		
		// OUTPUT(rollSources, NAMED('rollSources'));	
    
    // OUTPUT(formatCrimData, NAMED('formatCrimData'));
    // OUTPUT(rollCrimToDID, NAMED('rollCrimToDID'));
    // OUTPUT(indivCrimLayout, NAMED('indivCrimLayout'));
    
    // OUTPUT(addCrimData, NAMED('addCrimData'));
    
  
   

    RETURN addCrimData;
END;