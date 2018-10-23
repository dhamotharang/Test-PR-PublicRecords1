IMPORT DueDiligence, faa;

/*
	Following Keys being used:
			faa.key_aircraft_did
      faa.key_aircraft_id
*/
EXPORT getIndAircraft(DATASET(DueDiligence.Layouts.Indv_Internal) inData) := FUNCTION


    getSpouseAsInquired := DueDiligence.CommonIndividual.getRelationship(inData, spouses, DueDiligence.Constants.INQUIRED_INDIVIDUAL_SPOUSE);
  
    spouseAndInquired := getSpouseAsInquired + inData;
    
    
    aircraftByDID := JOIN(spouseAndInquired, faa.key_aircraft_did(), 
                          KEYED(LEFT.individual.did = RIGHT.did),
                          TRANSFORM(DueDiligence.LayoutsInternal.AircraftSlimLayout,
                                    SELF.seq := LEFT.seq;
                                    SELF.did := LEFT.inquiredDID;
                                    SELF.historyDate := LEFT.historyDateRaw;
                                    
                                    inquiredOwned := LEFT.indvType = DueDiligence.Constants.INQUIRED_INDIVIDUAL;
                                    spouseOwned := LEFT.indvType = DueDiligence.Constants.INQUIRED_INDIVIDUAL_SPOUSE;
                                    
                                    SELF.inquiredOwned := inquiredOwned;
                                    SELF.spouseOwned := spouseOwned;
                                    
                                    SELF.aircraftOwners := IF(inquiredOwned OR spouseOwned, 
                                                              DATASET([TRANSFORM(DueDiligence.Layouts.DIDAndName, SELF := LEFT.individual;)]), 
                                                              DATASET([], DueDiligence.Layouts.DIDAndName));
                                                          
                                    SELF.tailNumber := RIGHT.n_number;
                                    SELF.id := RIGHT.aircraft_id;
                                    
                                    SELF := [];),
                          KEEP(100), 
                          ATMOST(DueDiligence.Constants.MAX_ATMOST_1000));
                          
                            
    // sortAircraftByDID := SORT(propDataToUse, seq, did, LNFaresId);
    
    // rollAircraftByDID := ROLLUP(sortIndProps,
                                // LEFT.seq = RIGHT.seq AND
                                // LEFT.did = RIGHT.did AND
                                // LEFT.LNFaresId = RIGHT.LNFaresId,
                                // TRANSFORM(RECORDOF(LEFT),
                                          // SELF.inquiredOwned := LEFT.inquiredOwned OR RIGHT.inquiredOwned;
                                          // SELF.spouseOwned := LEFT.spouseOwned OR RIGHT.spouseOwned;
                                          // SELF.ownerNames := LEFT.ownerNames + RIGHT.ownerNames;
                                          // SELF := LEFT;));
                          
                          
    aircraftDetails := JOIN(aircraftByDID, faa.key_aircraft_id(),
                            KEYED(LEFT.id = RIGHT.aircraft_id),
                            TRANSFORM(DueDiligence.LayoutsInternal.AircraftSlimLayout,
                                      SELF.year := RIGHT.year_mfr;
                                      SELF.make := RIGHT.aircraft_mfr_name;
                                      SELF.model := RIGHT.model_name;
                                      SELF.vin := RIGHT.serial_number;
                                      SELF.registrationDate := RIGHT.cert_issue_date;
                                      SELF.manufactureModelCode := RIGHT.mfr_mdl_code;
                                      
                                      SELF.dateFirstSeen := (UNSIGNED)RIGHT.date_first_seen;
                                      SELF.dateLastSeen := (UNSIGNED)RIGHT.date_last_seen;
                                      
                                      SELF.statusFlag := RIGHT.current_flag;
                                      
                                      SELF := LEFT;),
                            KEEP(100),
                            ATMOST(DueDiligence.Constants.MAX_ATMOST_1000));
                            

                                 
    sharedData := DueDiligence.getSharedAircraft(aircraftDetails); 
  
  
    addAircraft := JOIN(inData, sharedData,
                        LEFT.seq = RIGHT.seq AND
                        LEFT.inquiredDID = RIGHT.did,												
                        TRANSFORM(DueDiligence.Layouts.Indv_Internal, 
                                  SELF.aircraftCount := COUNT(RIGHT.aircraft);
                                  SELF.perAircraft := RIGHT.aircraft;
                                  SELF := LEFT;),
                        LEFT OUTER);                                  
                          
    	





    // OUTPUT(spouseAndInquired, NAMED('spouseAndInquired'));
    // OUTPUT(aircraftByDID, NAMED('aircraftByDID'));
    // OUTPUT(aircraftDetails, NAMED('aircraftDetails'));
    // OUTPUT(sharedData, NAMED('sharedData'));
    // OUTPUT(addAircraft, NAMED('addAircraft'));


    RETURN addAircraft;
END;