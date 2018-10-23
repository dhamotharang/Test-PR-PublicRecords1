IMPORT DueDiligence, iesp;

EXPORT reportIndAircraft(DATASET(DueDiligence.Layouts.Indv_Internal) inData) := FUNCTION

    //pull aircraft data from the inquired  
    sharedAir := NORMALIZE(inData, LEFT.perAircraft, TRANSFORM(DueDiligence.LayoutsInternalReport.SharedAircraftLayout,
                                                                SELF.seq := LEFT.seq;
                                                                SELF.did := LEFT.inquiredDID;
                                                                
                                                                SELF.yearMakeModel.year := RIGHT.year;
                                                                SELF.yearMakeModel.make := RIGHT.make;
                                                                SELF.yearMakeModel.model := RIGHT.model;
                                                                
                                                                SELF.manufactureModelCode := RIGHT.manufactureModelCode;
                                                                
                                                                SELF.tailNumber := RIGHT.tailNumber;
                                                                SELF.aircraft.vin := RIGHT.vin;
                                                                    
                                                                SELF.registrationDate := iesp.ECL2ESP.toDatestring8(RIGHT.registrationDate);
                                                                
                                                                SELF.inquiredOwned := RIGHT.inquiredOwned;
                                                                SELF.spouseOwned := RIGHT.spouseOwned;
                                                                SELF.owners := PROJECT(RIGHT.aircraftOwners, TRANSFORM(DueDiligence.Layouts.DIDAndName, SELF := LEFT;));
                                                                
                                                                SELF := [];));
                                                                

    sharedDetails := DueDiligence.reportSharedAircraft(sharedAir);
    
    perAir := PROJECT(sharedDetails, TRANSFORM({UNSIGNED6 seq, UNSIGNED6 did, iesp.duediligencepersonreport.t_DDRPersonAircraftOwnership},
                                                SELF.aircrafts := DATASET([TRANSFORM(iesp.duediligencepersonreport.t_DDRPersonAircraft,
                                                                                      SELF.OwnershipType.SubjectOwned := LEFT.inquiredOwned;
                                                                                      SELF.OwnershipType.SpouseOwned := LEFT.spouseOwned;
                                                                                      SELF.OwnershipType.Owners := PROJECT(LEFT.owners, TRANSFORM(iesp.duediligenceshared.t_DDRPersonNameWithLexID,
                                                                                                                                                  SELF.lexID := (STRING)LEFT.did;
                                                                                                                                                  SELF.Name := iesp.ECL2ESP.SetName(LEFT.firstName, LEFT.middleName, LEFT.lastName, LEFT.suffix, DueDiligence.Constants.EMPTY))); 
                                                                                      SELF := LEFT;)]); 
                                                SELF := LEFT;));
                                            
                                            
                                            
    //combine aircraft to each inquired
    sortAir := SORT(perAir, seq, did);
    rollAir := ROLLUP(sortAir,
                      LEFT.seq = RIGHT.seq AND
                      LEFT.did = RIGHT.did,
                      TRANSFORM(RECORDOF(LEFT),
                                SELF.aircrafts := LEFT.aircrafts + RIGHT.aircrafts;
                                SELF := LEFT;));
                                
                                
    //add formatted data to report
    addAircraftToReport := JOIN(inData, rollAir,
                                LEFT.seq = RIGHT.seq AND
                                LEFT.inquiredDID = RIGHT.did,
                                TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                          SELF.PersonReport.PersonAttributeDetails.Economic.Aircraft.Aircrafts := RIGHT.aircrafts;
                                          SELF := LEFT;),
                                LEFT OUTER,
                                ATMOST(1));
                                            
                                            
                                            
                                            
    // OUTPUT(sharedAir, NAMED('sharedAir'));                                        
    // OUTPUT(sharedDetails, NAMED('sharedDetails'));                                        
    // OUTPUT(perAir, NAMED('perAir'));                                        
    // OUTPUT(rollAir, NAMED('rollAir'));                                        
    // OUTPUT(addAircraftToReport, NAMED('addAircraftToReport'));                                        
                                            
    RETURN addAircraftToReport;
END;