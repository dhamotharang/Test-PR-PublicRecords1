IMPORT BIPv2, DueDiligence, dx_crim_offense_cat, STD, UT;

/*
	Following Keys being used:
      dx_crim_offense_cat.key
*/
EXPORT getIndCriminal(DATASET(DueDiligence.LayoutsInternal.RelatedParty) individuals) := FUNCTION


    //get the raw data for criminal
    rawCriminalData := DueDiligence.getIndCriminalRawData(individuals);  
    
    updateWithOffenseType := JOIN(rawCriminalData, dx_crim_offense_cat.key(),
                                  KEYED(TRIM(LEFT.offenseCharge, LEFT, RIGHT) = RIGHT.offenseCharge),
                                  TRANSFORM(DueDiligence.LayoutsInternal.IndCrimLayoutFinal,
                                  
                                            info := DueDiligence.translateExpression.expressionDCT[(UNSIGNED)RIGHT.id]; 
                                            
                                            //grab the offense category id
                                            //if the category does not exist, an id of 0 and level of 0 is returned (Uncategorized)
                                            //if the category exists, grab the level and description (category) from the key to be used
                                            //if no charge was found, would not hit this logic; since the offenseCategoryID field is unsigned
                                            //offenseCategoryID would be 0 and will fill in the text in the project next to Uncategorized                                            
                                            SELF.offenseCategoryID := info.id;
                                            SELF.offenseCategoryDescription := RIGHT.category;
                                            
                                            SELF := LEFT;),
                                  LEFT OUTER,
                                  ATMOST(1));
                                    
    //calc offense type based on top level data
    updateWithStateLegal := PROJECT(updateWithOffenseType, TRANSFORM(DueDiligence.LayoutsInternal.IndCrimLayoutFinal,
    
                                                                      trafficRelated := LEFT.offenseTrafficRelated = DueDiligence.Constants.YES;
                                                                      offenseTypeTraffic := LEFT.offenseCategoryID = DueDiligence.translateExpression.OffenseID.TRAFFIC;
                                                                      
                                                                      SELF.offenseTrafficRelated := IF(trafficRelated OR offenseTypeTraffic, DueDiligence.Constants.YES, LEFT.offenseTrafficRelated);
                                                                                                
                                                                                                        
                                                                      criminalActivityDate := DueDiligence.CommonDate.DaysApartWithZeroEmptyDate((STRING8)LEFT.offenseDDFirstReportedActivity, (STRING8)LEFT.historyDate);
                                                                      past3Years := ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK);
                                                                      
                                                                      reportedLast3Yrs := LEFT.offenseDDFirstReportedActivity <> 0 AND criminalActivityDate <= past3Years;
                                                                      reportedOver3YrsOrCannotCalcDate := ((LEFT.offenseDDFirstReportedActivity <> 0 AND criminalActivityDate > past3Years) OR LEFT.offenseDDFirstReportedActivity = 0);
                                                                       
                                                                       
                                                                       
                                                                      nonFelonies := [DueDiligence.ConstantsLegal.MISDEMEANOR, DueDiligence.ConstantsLegal.INFRACTION, 
                                                                                      DueDiligence.ConstantsLegal.TRAFFIC, DueDiligence.Constants.UNKNOWN, DueDiligence.Constants.EMPTY];
                                                                      
                                                                      convictedFelony := LEFT.offenseDDChargeLevelCalculated = DueDiligence.ConstantsLegal.FELONY AND LEFT.offenseConviction = DueDiligence.Constants.YES;
                                                                      convictedNonFelony := LEFT.offenseDDChargeLevelCalculated IN nonFelonies AND LEFT.offenseConviction = DueDiligence.Constants.YES;
                                                                                                  
                                                                                                   
                                                                      SELF.attr_stateLegalEvent8 := convictedFelony AND reportedLast3Yrs;
                                                                      SELF.attr_stateLegalEvent7 := convictedFelony AND reportedOver3YrsOrCannotCalcDate;
                                                                      
                                                                      SELF.attr_stateLegalEvent5 := convictedNonFelony AND reportedLast3Yrs;
                                                                      SELF.attr_stateLegalEvent4 := convictedNonFelony AND reportedOver3YrsOrCannotCalcDate;
                                                                      
                                                                      SELF.attr_stateLegalEvent3 := LEFT.offenseDDChargeLevelCalculated = DueDiligence.ConstantsLegal.FELONY AND LEFT.offenseConviction <> DueDiligence.Constants.YES;
                                                                      SELF.attr_stateLegalEvent2 := LEFT.offenseDDChargeLevelCalculated IN nonFelonies AND LEFT.offenseConviction <> DueDiligence.Constants.YES;
                                                                      
                                                                      
                                                                      offenseIDLevel := DueDiligence.translateExpression.expressionDCT[LEFT.offenseCategoryID];
                                                                      
                                                                      SELF.attr_offenseType9 := offenseIDLevel.level = DueDiligence.translateExpression.LEVEL_9;
                                                                      SELF.attr_offenseType8 := offenseIDLevel.level = DueDiligence.translateExpression.LEVEL_8;
                                                                      SELF.attr_offenseType7 := offenseIDLevel.level = DueDiligence.translateExpression.LEVEL_7;
                                                                      SELF.attr_offenseType6 := offenseIDLevel.level = DueDiligence.translateExpression.LEVEL_6;
                                                                      SELF.attr_offenseType5 := offenseIDLevel.level = DueDiligence.translateExpression.LEVEL_5;
                                                                      SELF.attr_offenseType4 := offenseIDLevel.level = DueDiligence.translateExpression.LEVEL_4;
                                                                      SELF.attr_offenseType3 := offenseIDLevel.level = DueDiligence.translateExpression.LEVEL_3;
                                                                      SELF.attr_offenseType2 := offenseIDLevel.level = DueDiligence.translateExpression.LEVEL_2;  
                                                                      SELF.attr_offenseType0 := offenseIDLevel.level = DueDiligence.translateExpression.LEVEL_0;
                                                                      
                                                                      //set the text to uncagegorized if we did not find the charge
                                                                      SELF.offenseCategoryDescription := IF(LEFT.offenseCategoryID = 0 AND LEFT.offenseCategoryDescription = DueDiligence.Constants.EMPTY, DueDiligence.translateExpression.DEFAULT_UNCATEGORIZED_TEXT, LEFT.offenseCategoryDescription);
                                                                      
                                                                      
                                                                      isTrafficOffense := offenseTypeTraffic OR LEFT.offenseCategoryID = DueDiligence.translateExpression.OffenseID.DUI;                                                                      
                                                                      
                                                                      SELF.trafficOffenseFound := isTrafficOffense;
                                                                      SELF.otherOffenseFound := isTrafficOffense = FALSE;
                                                                      SELF.felonyPast3Years := LEFT.offenseDDChargeLevelCalculated = DueDiligence.ConstantsLegal.FELONY AND reportedLast3Yrs;
                                                                       
                                                                                                       
                                                                      SELF := LEFT;));


    //roll up all offenses now by person
    formatCrimData := PROJECT(updateWithStateLegal, TRANSFORM({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, DueDiligence.LayoutsInternal.LegalFlags, DueDiligence.LayoutsInternal.LegalAttributes, DATASET(DueDiligence.Layouts.CriminalOffenses) indCrimOffenses},
                                                              SELF.indCrimOffenses := DATASET([TRANSFORM(DueDiligence.Layouts.CriminalOffenses, SELF := LEFT;)]);
                                                              SELF := LEFT;
                                                              SELF := [];));
                                                      

    sortformatCrimData := SORT(formatCrimData, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did);  
   
    rollCrimToDID := ROLLUP(sortformatCrimData,
                            #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()) AND
                            LEFT.did = RIGHT.did,
                            TRANSFORM(RECORDOF(LEFT),
                                      SELF.attr_stateLegalEvent9 := LEFT.attr_stateLegalEvent9 OR RIGHT.attr_stateLegalEvent9;
                                      SELF.attr_stateLegalEvent8 := LEFT.attr_stateLegalEvent8 OR RIGHT.attr_stateLegalEvent8;
                                      SELF.attr_stateLegalEvent7 := LEFT.attr_stateLegalEvent7 OR RIGHT.attr_stateLegalEvent7;
                                      SELF.attr_stateLegalEvent6 := LEFT.attr_stateLegalEvent6 OR RIGHT.attr_stateLegalEvent6;
                                      SELF.attr_stateLegalEvent5 := LEFT.attr_stateLegalEvent5 OR RIGHT.attr_stateLegalEvent5;
                                      SELF.attr_stateLegalEvent4 := LEFT.attr_stateLegalEvent4 OR RIGHT.attr_stateLegalEvent4;
                                      SELF.attr_stateLegalEvent3 := LEFT.attr_stateLegalEvent3 OR RIGHT.attr_stateLegalEvent3;
                                      SELF.attr_stateLegalEvent2 := LEFT.attr_stateLegalEvent2 OR RIGHT.attr_stateLegalEvent2;
                                      
                                      SELF.attr_offenseType9 := LEFT.attr_offenseType9 OR RIGHT.attr_offenseType9;
                                      SELF.attr_offenseType8 := LEFT.attr_offenseType8 OR RIGHT.attr_offenseType8;
                                      SELF.attr_offenseType7 := LEFT.attr_offenseType7 OR RIGHT.attr_offenseType7;
                                      SELF.attr_offenseType6 := LEFT.attr_offenseType6 OR RIGHT.attr_offenseType6;
                                      SELF.attr_offenseType5 := LEFT.attr_offenseType5 OR RIGHT.attr_offenseType5;
                                      SELF.attr_offenseType4 := LEFT.attr_offenseType4 OR RIGHT.attr_offenseType4;
                                      SELF.attr_offenseType3 := LEFT.attr_offenseType3 OR RIGHT.attr_offenseType3;
                                      SELF.attr_offenseType2 := LEFT.attr_offenseType2 OR RIGHT.attr_offenseType2;
                                      SELF.attr_offenseType0 := LEFT.attr_offenseType0 OR RIGHT.attr_offenseType0;
                                      
                                      SELF.trafficOffenseFound := LEFT.trafficOffenseFound OR RIGHT.trafficOffenseFound;
                                      SELF.otherOffenseFound := LEFT.otherOffenseFound OR RIGHT.otherOffenseFound;
                                      
                                      SELF.currIncar := LEFT.currIncar OR RIGHT.currIncar;
                                      SELF.currParole := LEFT.currParole OR RIGHT.currParole;
                                      SELF.currProbation := LEFT.currProbation OR RIGHT.currProbation;
                                      SELF.prevIncar := LEFT.prevIncar OR RIGHT.prevIncar;
                                      SELF.felonyPast3Years := LEFT.felonyPast3Years OR RIGHT.felonyPast3Years;
                                      
                                      SELF.indCrimOffenses := LEFT.indCrimOffenses + RIGHT.indCrimOffenses;
                                      SELF := LEFT;));



    //for each person determine state criminal data levels
    indivCrimLayout := PROJECT(rollCrimToDID, TRANSFORM({RECORDOF(LEFT) crimOffenses, DueDiligence.Layouts.Indv_Internal indv},
                                                        
                                                        SELF.crimOffenses := LEFT;
                                                        
                                                        SELF.indv.seq := LEFT.seq;
                                                        SELF.indv.inquiredDID := LEFT.did;
                                                       
                                                        //PerStateLegalEvent
                                                        SELF.indv.currentIncarceration := LEFT.attr_stateLegalEvent9;
                                                        SELF.indv.felonyConvictionPast3Yrs := LEFT.attr_stateLegalEvent8;
                                                        SELF.indv.felonyConvictionOver3YrsOrNoDate := LEFT.attr_stateLegalEvent7;
                                                        SELF.indv.previousIncarcerationOrParoleOrProbation := LEFT.attr_stateLegalEvent6;
                                                        SELF.indv.nonFelonyConvictionPast3Yrs := LEFT.attr_stateLegalEvent5;
                                                        SELF.indv.nonFelonyConvictionOver3YrsOrNoDate := LEFT.attr_stateLegalEvent4;
                                                        SELF.indv.felonyNotConvicted := LEFT.attr_stateLegalEvent3;
                                                        SELF.indv.nonFelonyNotConvicted := LEFT.attr_stateLegalEvent2;
                                                        
                                                        //PerLegalEventType
                                                        SELF.indv.atleastOneCategory9 := LEFT.attr_offenseType9;
                                                        SELF.indv.atleastOneCategory8 := LEFT.attr_offenseType8;
                                                        SELF.indv.atleastOneCategory7 := LEFT.attr_offenseType7;
                                                        SELF.indv.atleastOneCategory6 := LEFT.attr_offenseType6;
                                                        SELF.indv.atleastOneCategory5 := LEFT.attr_offenseType5;
                                                        SELF.indv.atleastOneCategory4 := LEFT.attr_offenseType4;
                                                        SELF.indv.atleastOneCategory3 := LEFT.attr_offenseType3;
                                                        SELF.indv.atleastOneCategory2 := LEFT.attr_offenseType2;
                                                        SELF.indv.atleastOneCategory0 := LEFT.attr_offenseType0;
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
                                  
                                  SELF.trafficOffenseFound := RIGHT.crimOffenses.trafficOffenseFound;
                                  SELF.otherOffenseFound := RIGHT.crimOffenses.otherOffenseFound;
                                  SELF.currIncar := RIGHT.crimOffenses.currIncar;
                                  SELF.currParole := RIGHT.crimOffenses.currParole;
                                  SELF.currProbation := RIGHT.crimOffenses.currProbation;
                                  SELF.prevIncar := RIGHT.crimOffenses.prevIncar;
                                  SELF.felonyPast3Years := RIGHT.crimOffenses.felonyPast3Years;
                                  
                                  SELF := LEFT;),
                        LEFT OUTER,
                        ATMOST(1));
   
   
   
   
   
    
    // OUTPUT(rawCriminalData, NAMED('rawCriminalData'));		
    // OUTPUT(updateWithOffenseType, NAMED('updateWithOffenseType'));	
    // OUTPUT(updateWithStateLegal, NAMED('updateWithStateLegal'));	

    // OUTPUT(formatCrimData, NAMED('formatCrimData'));
    // OUTPUT(rollCrimToDID, NAMED('rollCrimToDID'));
    // OUTPUT(indivCrimLayout, NAMED('indivCrimLayout'));

    // OUTPUT(addCrimData, NAMED('addCrimData'));
    
  
   

    RETURN addCrimData;
END;