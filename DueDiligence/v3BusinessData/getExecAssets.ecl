IMPORT DueDiligence;


EXPORT getExecAssets(DATASET(DueDiligence.v3Layouts.Internal.BusinessTemp) inData,
                      DueDiligence.DDInterface.iDDRegulatoryCompliance regulatoryAccess) := FUNCTION
 
 
    //get all unique people for all the BEOs with LexIDs
    beoDataTemp := NORMALIZE(inData, LEFT.beos,
                            TRANSFORM({UNSIGNED inquiredBusSeq, UNSIGNED inquiredBus, DueDiligence.Layouts.Indv_Internal, DueDiligence.v3Layouts.Internal.SlimExec existingBEOData},
                                      SELF.inquiredBusSeq := LEFT.seq;
                                      SELF.inquiredBus := LEFT.inquiredBusiness.seleID;
                                      SELF.historyDate := LEFT.historyDate;
                                      SELF.historyDateRaw := LEFT.historyDateRaw;
                                      
                                      SELF.individual.did := RIGHT.lexID;
                                      SELF.individual.firstName := RIGHT.firstName;
                                      SELF.individual.middleName := RIGHT.middleName;
                                      SELF.individual.lastName := RIGHT.lastName;
                                      SELF.individual.fullName := RIGHT.fullName;
                                      SELF.individual.suffix := RIGHT.suffix;
                                      
                                      SELF.inquiredDID := RIGHT.lexID;
                                      SELF.indvType := DueDiligence.Constants.INQUIRED_INDIVIDUAL;
                                      
                                      SELF.existingBEOData := RIGHT;
                                      
                                      SELF := [];));
                                      
    beoData := PROJECT(beoDataTemp, TRANSFORM(RECORDOF(LEFT), SELF.seq := COUNTER; SELF := LEFT;));
                                    
    dedupBEOs := DEDUP(SORT(beoData(inquiredDID > 0), inquiredDID, seq), inquiredDID);
    
    uniqueBEOs := PROJECT(dedupBEOs, TRANSFORM(DueDiligence.Layouts.Indv_Internal, SELF.seq := COUNTER; SELF := LEFT;));
    


    modAccess := DueDiligence.v3Common.General.GetModAccess(regulatoryAccess);

 
    propertyInfo := DueDiligence.getIndProperty(uniqueBEOs, regulatoryAccess.drm);
    
    watercraftInfo := DueDiligence.getIndWatercraft(uniqueBEOs, modAccess);
    
    vehicleInfo := DueDiligence.getIndVehicle(uniqueBEOs, modAccess);
    
    aircraftInfo := DueDiligence.getIndAircraft(uniqueBEOs);
    
    
    
    
    addPropData := JOIN(beoData(inquiredDID > 0), propertyInfo,
                        LEFT.inquiredDID = RIGHT.inquiredDID,
                        TRANSFORM({UNSIGNED busSeq, UNSIGNED inquiredBus, DueDiligence.v3Layouts.Internal.SlimExec},
                                  SELF.busSeq := LEFT.inquiredBusSeq;
                                  SELF.inquiredBus := LEFT.inquiredBus;
                                  SELF.lexID := LEFT.inquiredDID;
                                  
                                  SELF.numProperties := RIGHT.ownedPropCount;
                                  SELF.totalTaxAssessedVal := RIGHT.totalAssesedValue;
                                  
                                  SELF := LEFT.existingBEOData;
                                  
                                  SELF := [];),
                        LEFT OUTER,
                        ATMOST(1));
                        

    addWaterData := JOIN(addPropData, watercraftInfo,
                          LEFT.lexID = RIGHT.inquiredDID,
                          TRANSFORM({UNSIGNED busSeq, UNSIGNED inquiredBus, DueDiligence.v3Layouts.Internal.SlimExec},
                                    SELF.numWatercraft := RIGHT.watercraftCount;
                                    SELF.maxWatercraftLengthRaw := RIGHT.watercraftLength;
                                    SELF := LEFT;),
                          LEFT OUTER,
                          ATMOST(1));
                        
                        
    addVehicleData := JOIN(addWaterData, vehicleInfo,
                            LEFT.lexID = RIGHT.inquiredDID,
                            TRANSFORM({UNSIGNED busSeq, UNSIGNED inquiredBus, DueDiligence.v3Layouts.Internal.SlimExec},
                                      SELF.numVehicles := RIGHT.VehicleCount;
                                      SELF.maxBaseVehicleVal := RIGHT.VehicleBaseValue;
                                      SELF := LEFT;),
                            LEFT OUTER,
                            ATMOST(1));
                        
                        
    addAircraftData := JOIN(addVehicleData, aircraftInfo,
                            LEFT.lexID = RIGHT.inquiredDID,
                            TRANSFORM({UNSIGNED busSeq, UNSIGNED inquiredBus, DueDiligence.v3Layouts.Internal.SlimExec},
                                      SELF.numAircraft := RIGHT.aircraftCount;
                                      SELF := LEFT;),
                            LEFT OUTER,
                            ATMOST(1));
                            
    noDIDBeos := PROJECT(beoData(inquiredDID = 0), TRANSFORM({UNSIGNED busSeq, UNSIGNED inquiredBus, DueDiligence.v3Layouts.Internal.SlimExec},
                                                            SELF.busSeq := LEFT.inquiredBusSeq;
                                                            SELF.inquiredBus := LEFT.inquiredBus;
                                                            SELF := LEFT.existingBEOData;
                                                            SELF := [];));                     
    
    transBEOData := PROJECT(addAircraftData + noDIDBeos, TRANSFORM({UNSIGNED busSeq, UNSIGNED inquiredBus, DATASET(DueDiligence.v3Layouts.Internal.SlimExec) allBEOData},
                                                                    SELF.busSeq := LEFT.busSeq;
                                                                    SELF.inquiredBus := LEFT.inquiredBus;
                                                                    SELF.allBEOData := DATASET([TRANSFORM(DueDiligence.v3Layouts.Internal.SlimExec,
                                                                                                          SELF := LEFT;
                                                                                                          SELF := [];)]);
                                                                    SELF := [];));
                            

    rollBEOData := ROLLUP(SORT(transBEOData, busSeq, inquiredBus),
                          LEFT.busSeq = RIGHT.busSeq AND
                          LEFT.inquiredBus = RIGHT.inquiredBus,
                          TRANSFORM(RECORDOF(LEFT),
                                    SELF.allBEOData := LEFT.allBEOData + RIGHT.allBEOData;
                                    SELF := LEFT;));
                                    
                                    
    updateBEOs := JOIN(inData, rollBEOData,
                        LEFT.seq = RIGHT.busSeq AND
                        LEFT.inquiredBusiness.seleID = RIGHT.inquiredBus,
                        TRANSFORM(DueDiligence.v3Layouts.Internal.BusinessTemp,
                                  SELF.beos := RIGHT.allBEOData;
                                  SELF := LEFT;),
                        LEFT OUTER,
                        ATMOST(1));
 
 
 
 
    
    
    // OUTPUT(beoData, NAMED('beoData'));
    // OUTPUT(dedupBEOs, NAMED('dedupBEOs'));
    // OUTPUT(uniqueBEOs, NAMED('uniqueBEOs'));
    
    // OUTPUT(propertyInfo, NAMED('propertyInfo'));
    // OUTPUT(watercraftInfo, NAMED('watercraftInfo'));
    // OUTPUT(vehicleInfo, NAMED('vehicleInfo'));
    // OUTPUT(aircraftInfo, NAMED('aircraftInfo'));
    
    // OUTPUT(addPropData, NAMED('addPropData'));
    // OUTPUT(addWaterData, NAMED('addWaterData'));
    // OUTPUT(addVehicleData, NAMED('addVehicleData'));
    // OUTPUT(addAircraftData, NAMED('addAircraftData'));
    
    // OUTPUT(transBEOData, NAMED('transBEOData'));
    // OUTPUT(rollBEOData, NAMED('rollBEOData'));
    // OUTPUT(updateBEOs, NAMED('updateBEOs'));
    
    
    RETURN updateBEOs;
END;