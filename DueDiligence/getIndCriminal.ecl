﻿IMPORT BIPv2, DueDiligence, UT;


EXPORT getIndCriminal(DATASET(DueDiligence.LayoutsInternal.RelatedParty) individuals) := FUNCTION


    //get the raw data for criminal
    rawCriminalData := DueDiligence.getIndCriminalRawData(individuals);                                  
                                    
    //calc offense type based on top level data
    updateWithOffenseType := PROJECT(rawCriminalData, TRANSFORM(DueDiligence.LayoutsInternal.IndCrimLayoutFinal,
    
                                                            charge := LEFT.offenseCharge;
                                                            offenseLevel := LEFT.offenseDDChargeLevelCalculated;
                                                            category := LEFT.category;
                                                            traffic := LEFT.offenseTrafficRelated;
        
        
                                                            typeLevel_9 := DueDiligence.translateExpression.getMaxLevel(charge, offenseLevel, category, traffic, DueDiligence.translateExpression.LEVEL_9);
                                                            typeLevel_8 := DueDiligence.translateExpression.getMaxLevel(charge, offenseLevel, category, traffic, DueDiligence.translateExpression.LEVEL_8);                                                                                                                                
                                                            typeLevel_7 := DueDiligence.translateExpression.getMaxLevel(charge, offenseLevel, category, traffic, DueDiligence.translateExpression.LEVEL_7);                                                                                                                                
                                                            typeLevel_6 := DueDiligence.translateExpression.getMaxLevel(charge, offenseLevel, category, traffic, DueDiligence.translateExpression.LEVEL_6);                                                                                                                                
                                                            typeLevel_5 := DueDiligence.translateExpression.getMaxLevel(charge, offenseLevel, category, traffic, DueDiligence.translateExpression.LEVEL_5);                                                                                                                                
                                                            typeLevel_4 := DueDiligence.translateExpression.getMaxLevel(charge, offenseLevel, category, traffic, DueDiligence.translateExpression.LEVEL_4);                                                                                                                                
                                                            typeLevel_3 := DueDiligence.translateExpression.getMaxLevel(charge, offenseLevel, category, traffic, DueDiligence.translateExpression.LEVEL_3);                                                                                                                                
                                                            typeLevel_2 := DueDiligence.translateExpression.getMaxLevel(charge, offenseLevel, category, traffic, DueDiligence.translateExpression.LEVEL_2);
                                                            
                                                            maxPriority := MAX(typeLevel_9, typeLevel_8, typeLevel_7, typeLevel_6,
                                                                               typeLevel_5, typeLevel_4, typeLevel_3, typeLevel_2);
                                                                               
                                                            maxOffenseLevel := DueDiligence.translateExpression.dctByPriority[maxPriority].level;
                                                            
                                                            SELF.attr_offenseType9 := maxOffenseLevel = DueDiligence.translateExpression.LEVEL_9;
                                                            SELF.attr_offenseType8 := maxOffenseLevel = DueDiligence.translateExpression.LEVEL_8;
                                                            SELF.attr_offenseType7 := maxOffenseLevel = DueDiligence.translateExpression.LEVEL_7;
                                                            SELF.attr_offenseType6 := maxOffenseLevel = DueDiligence.translateExpression.LEVEL_6;
                                                            SELF.attr_offenseType5 := maxOffenseLevel = DueDiligence.translateExpression.LEVEL_5;
                                                            SELF.attr_offenseType4 := maxOffenseLevel = DueDiligence.translateExpression.LEVEL_4;
                                                            SELF.attr_offenseType3 := maxOffenseLevel = DueDiligence.translateExpression.LEVEL_3;
                                                            SELF.attr_offenseType2 := maxOffenseLevel = DueDiligence.translateExpression.LEVEL_2;  
                                                            SELF.attr_offenseType0 := maxOffenseLevel = DueDiligence.translateExpression.LEVEL_0;
                                                                                                  
                                                            SELF.offenseDDLegalEventTypeCode := maxPriority;     
                                                            
                                                            SELF.offenseTrafficRelated := IF(traffic = DueDiligence.Constants.YES OR maxPriority = DueDiligence.translateExpression.OffensePriority.TRAFFIC_OFFENSES,
                                                                                              DueDiligence.Constants.YES,
                                                                                              traffic);
                                                                                      
                                                                                              
                                                            criminalActivityDate := DueDiligence.CommonDate.DaysApartAccountingForZero((STRING8)LEFT.offenseDDFirstReportedActivity, (STRING8)LEFT.historyDate);
                                                            past3Years := ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK);
                                                            
                                                            reportedLast3Yrs := LEFT.offenseDDFirstReportedActivity <> 0 AND criminalActivityDate <= past3Years;
                                                            reportedOver3YrsOrCannotCalcDate := ((LEFT.offenseDDFirstReportedActivity <> 0 AND criminalActivityDate > past3Years) OR LEFT.offenseDDFirstReportedActivity = 0);
                                                             
                                                             
                                                             
                                                            nonFelonies := [DueDiligence.Constants.MISDEMEANOR, DueDiligence.Constants.INFRACTION, 
                                                                            DueDiligence.Constants.TRAFFIC, DueDiligence.Constants.UNKNOWN, DueDiligence.Constants.EMPTY];
                                                            
                                                            convictedFelony := LEFT.offenseDDChargeLevelCalculated = DueDiligence.Constants.FELONY AND LEFT.offenseConviction = DueDiligence.Constants.YES;
                                                            convictedNonFelony := LEFT.offenseDDChargeLevelCalculated IN nonFelonies AND LEFT.offenseConviction = DueDiligence.Constants.YES;
                                                                           
                                                            SELF.felonyPast3Years := LEFT.offenseDDChargeLevelCalculated = DueDiligence.Constants.FELONY AND reportedLast3Yrs;
                                                                                         
                                                            SELF.attr_stateLegalEvent8 := convictedFelony AND reportedLast3Yrs;
                                                            SELF.attr_stateLegalEvent7 := convictedFelony AND reportedOver3YrsOrCannotCalcDate;
                                                            
                                                            SELF.attr_stateLegalEvent5 := convictedNonFelony AND reportedLast3Yrs;
                                                            SELF.attr_stateLegalEvent4 := convictedNonFelony AND reportedOver3YrsOrCannotCalcDate;
                                                            
                                                            SELF.attr_stateLegalEvent3 := LEFT.offenseDDChargeLevelCalculated = DueDiligence.Constants.FELONY AND LEFT.offenseConviction <> DueDiligence.Constants.YES;
                                                            SELF.attr_stateLegalEvent2 := LEFT.offenseDDChargeLevelCalculated IN nonFelonies AND LEFT.offenseConviction <> DueDiligence.Constants.YES;
                                                                                             
                                                            SELF := LEFT;));


    //roll up all offenses now by person
    formatCrimData := PROJECT(updateWithOffenseType, TRANSFORM({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, DueDiligence.LayoutsInternal.LegalFlags, DueDiligence.Layouts.LegalAttributes, DATASET(DueDiligence.Layouts.CriminalOffenses) indCrimOffenses},
                                                                
                                                                SELF.indCrimOffenses := DATASET([TRANSFORM(DueDiligence.Layouts.CriminalOffenses, SELF := LEFT;)]);
                                                                SELF := LEFT;
                                                                SELF := [];));
                                                      

    sortformatCrimData := SORT(formatCrimData, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did);  
   
    rollCrimToDID := ROLLUP(sortformatCrimData,
                            LEFT.seq = RIGHT.seq AND
                            LEFT.ultID = RIGHT.ultID AND
                            LEFT.orgID = RIGHT.orgID AND
                            LEFT.seleID = RIGHT.seleID AND
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
                                      
                                      SELF.indCrimOffenses := LEFT.indCrimOffenses + RIGHT.indCrimOffenses;
                                      
                                      SELF.currIncar := LEFT.currIncar OR RIGHT.currIncar;
                                      SELF.currParole := LEFT.currParole OR RIGHT.currParole;
                                      SELF.currProbation := LEFT.currProbation OR RIGHT.currProbation;
                                      SELF.prevIncar := LEFT.prevIncar OR RIGHT.prevIncar;
                                      SELF.felonyPast3Years := LEFT.felonyPast3Years OR RIGHT.felonyPast3Years;
                                      
                                      SELF := LEFT;));



    //for each person determine state criminal data levels
    indivCrimLayout := PROJECT(rollCrimToDID, TRANSFORM({RECORDOF(LEFT) crimOffenses, DueDiligence.Layouts.Indv_Internal indv},
                                                        
                                                        SELF.crimOffenses := LEFT;
                                                        
                                                        SELF.indv.seq := LEFT.seq;
                                                        SELF.indv.individual.did := LEFT.did;
                                                       
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
                        LEFT.did = RIGHT.indv.individual.did,
                        TRANSFORM(DueDiligence.LayoutsInternal.RelatedParty,
                        
                                  stateCrim := DueDiligence.getIndKRILegalStateCriminal(RIGHT.indv);  
                                  SELF.party.stateCriminalLegalEventsScore := stateCrim.name;
                                  SELF.party.stateCriminalLegalEventsFlags := stateCrim.value;
                                  
                                  legalEventType := DueDiligence.getIndKRILegalEventType(RIGHT.indv);
                                  SELF.party.legalEventTypeScore := legalEventType.name;
                                  SELF.party.legalEventTypeFlags := legalEventType.value;

                                  SELF.party.indOffenses := RIGHT.crimOffenses.indCrimOffenses;
                                  
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

    // OUTPUT(formatCrimData, NAMED('formatCrimData'));
    // OUTPUT(rollCrimToDID, NAMED('rollCrimToDID'));
    // OUTPUT(indivCrimLayout, NAMED('indivCrimLayout'));

    // OUTPUT(addCrimData, NAMED('addCrimData'));
    
  
   

    RETURN addCrimData;
END;