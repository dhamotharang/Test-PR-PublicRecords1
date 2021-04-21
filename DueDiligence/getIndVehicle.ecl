IMPORT Doxie, DueDiligence, iesp, MDR, Suppress, VehicleV2;

/*
	Following Keys being used:
        VehicleV2.key_vehicle_did
        VehicleV2.Key_Vehicle_Main_Key
        VehicleV2.Key_Vehicle_Party_Key	 
*/
EXPORT getIndVehicle(DATASET(DueDiligence.Layouts.Indv_Internal) inData,
                      doxie.IDataAccess modAccess = MODULE (doxie.IDataAccess) END) := FUNCTION


  getSpouseAsInquired := DueDiligence.CommonIndividual.GetRelationshipAsInquired(inData, spouses, DueDiligence.Constants.INQUIRED_INDIVIDUAL_SPOUSE);
  
  spouseAndInquired := getSpouseAsInquired + inData;
  
  uniqueIndiv := DEDUP(SORT(spouseAndInquired, individual.did), individual.did);
  
  

  
  //get all the vehicle keys tied to a given did
  vehicleByDID := JOIN(uniqueIndiv, VehicleV2.key_vehicle_did,
                        KEYED(LEFT.individual.did = RIGHT.append_did) AND
                        (RIGHT.is_minor = FALSE) AND
                        (EXISTS(LIMIT(VehicleV2.Key_Vehicle_Party_Key(KEYED(vehicle_key = RIGHT.vehicle_key) AND
                                                                       KEYED(iteration_key = RIGHT.iteration_key) AND
                                                                       KEYED(sequence_key = RIGHT.sequence_key) AND
                                                                       (UNSIGNED6)append_did = LEFT.individual.did AND
                                                                       orig_name_type <> '2' ),
                                 DueDiligence.Constants.MAX_10000, SKIP))),
                        TRANSFORM(DueDiligence.LayoutsInternal.VehicleKeys, 
                                  SELF.inputDID := LEFT.individual.did;
                                  SELF.vehicle_key := RIGHT.vehicle_key;
                                  SELF.iteration_key := RIGHT.iteration_key;
                                  SELF.sequence_key := RIGHT.sequence_key;
                                  SELF.historyDate := LEFT.historyDate;
                                  SELF := []),
                        LIMIT(DueDiligence.Constants.MAX_2000, SKIP));
    
    
    dedupAllVehicleKeys := DEDUP(vehicleByDID, ALL);
    
    sortKeys := SORT(dedupAllVehicleKeys, inputDID, vehicle_key, -iteration_key);
    groupKeys := GROUP(sortKeys, inputDID, vehicle_key, iteration_key);
    dedupVehByKeys := DEDUP(groupKeys, inputDID, vehicle_Key, iteration_Key, sequence_key);
    
    vehicleInfo := JOIN(dedupVehByKeys, VehicleV2.Key_Vehicle_Main_Key,
                        KEYED(LEFT.vehicle_key = RIGHT.vehicle_key) AND
                        KEYED((LEFT.iteration_key = '') OR LEFT.iteration_key = RIGHT.iteration_key) AND
                        RIGHT.source_code NOT in MDR.sourceTools.set_infutor_all_veh,
                        TRANSFORM(DueDiligence.LayoutsInternal.CarInfoLayout,
                                  
                                  SELF.year := RIGHT.best_model_year;
                                  SELF.make := IF(RIGHT.vina_make_desc != '', RIGHT.vina_make_desc, RIGHT.orig_make_desc);
                                  SELF.model := IF(RIGHT.vina_model_desc != '',RIGHT.vina_model_desc, RIGHT.orig_model_desc);
                                 
                                  SELF.vin := IF(RIGHT.vina_vin <> '', RIGHT.vina_vin, RIGHT.orig_vin);
                                  SELF.basePrice := (UNSIGNED)RIGHT.vina_price;
                                  
                                  SELF.global_sid := RIGHT.global_sid;
                                  SELF.classType := RIGHT.model_class;  
                                      
                                  //used to verify DPPA
                                  SELF.stateOrigin := RIGHT.state_origin;
                                  SELF.sourceCode := RIGHT.source_code;
                                  
                                  SELF.nonDMVSource := RIGHT.source_code IN MDR.sourceTools.set_infutor_all_veh;
                                  
                                  SELF := LEFT;
                                  SELF := [];),
                        LIMIT(DueDiligence.Constants.MAX_50, SKIP));
                                
    validDPPAData := vehicleInfo(modAccess.isValidDppaState(stateOrigin,,sourceCode) OR
                                (sourceCode in MDR.sourceTools.set_infutor_all_veh AND modAccess.isValidDppa()));
                                
    suppressVehicleInfo := suppress.mac_suppresssource(validDPPAData, modAccess, inputDID);
    ungroupVehicleInfo := DEDUP(UNGROUP(suppressVehicleInfo), ALL);
         
         
         

    partyInfoRaw  := JOIN(dedupVehByKeys, VehicleV2.Key_Vehicle_Party_Key,
                          KEYED(LEFT.Vehicle_key = RIGHT.Vehicle_key) AND
                          KEYED(LEFT.Iteration_key = RIGHT.Iteration_key) AND
                          KEYED(LEFT.Sequence_key = RIGHT.Sequence_key) AND
                          LEFT.inputDID = RIGHT.append_did AND //we only care about the data for the input (ie spouse or inquired)
                          RIGHT.source_code NOT in MDR.sourceTools.set_infutor_all_veh,
                          TRANSFORM(DueDiligence.LayoutsInternal.PartyInfoLayout,
                                    SELF.origNameType := RIGHT.orig_name_type;
                                    SELF.licensePlateType := RIGHT.reg_license_plate_type_desc;                   
                                    SELF.registeredState := RIGHT.reg_license_state;
                                    SELF.registeredDate := RIGHT.reg_latest_effective_date;
                                    SELF.registeredLatestEffectiveDate := RIGHT.reg_latest_effective_date;
                                    SELF.registeredLatestExpirationDate := RIGHT.reg_latest_expiration_date;
                                    
                                    SELF.titleState :=  IF(RIGHT.ttl_number != DueDiligence.Constants.EMPTY, RIGHT.state_origin, DueDiligence.Constants.EMPTY);  
                                    SELF.titleDate := RIGHT.ttl_latest_issue_date;
                                    SELF.titleLatestIssueDate := RIGHT.ttl_latest_issue_date;
                                    SELF.titleEarliestIssueDate := RIGHT.ttl_earliest_issue_date;
                                    
                                    SELF.dateFirstSeen := IF(RIGHT.date_first_seen > 0, RIGHT.date_first_seen, RIGHT.date_vendor_first_reported);
                                                                        
                                    SELF.history := RIGHT.history;
                                    SELF.partyID := RIGHT.append_did;
                                    
                                    SELF := LEFT;),
                          KEEP(DueDiligence.Constants.MAX_100),
                          LIMIT(DueDiligence.Constants.MAX_0));
                              
    groupedByPartyKeys := GROUP(SORT(partyInfoRaw, vehicle_key, -iteration_key), vehicle_key, iteration_key);
    Suppress.MAC_Suppress(groupedByPartyKeys, pullDIDs, modAccess.application_type, Suppress.Constants.LinkTypes.DID, partyID);
    
    
    //Clean dates used in logic and/or attribute levels here so all comparisions flow through consistently
    vehicleSlimCleanDate := DueDiligence.Common.CleanDatasetDateFields(UNGROUP(pullDIDs), 'dateFirstSeen');
    
    //Filter out records after our history date.
    partyInfoFiltered := DueDiligence.CommonDate.FilterRecordsSingleDate(vehicleSlimCleanDate, dateFirstSeen); 
    
    partyInfo := DEDUP(PROJECT(partyInfoFiltered, TRANSFORM(DueDiligence.LayoutsInternal.PartyInfoLayout, SELF := LEFT;)), ALL);
    

    //add all vehihcles with their parties
    rolledRecs := DENORMALIZE(ungroupVehicleInfo, partyInfo,
                              LEFT.inputDID = RIGHT.inputDID AND
                              LEFT.vehicle_key = RIGHT.vehicle_key AND 
                              LEFT.iteration_key = RIGHT.iteration_key AND
                              LEFT.sequence_key = RIGHT.sequence_key,
                              GROUP,
                              TRANSFORM(DueDiligence.LayoutsInternal.CarInfoLayout,
                                        
                                        party := ROWS(RIGHT);
                                        
                                        //get different kinds of records (owner/registrant)
                                        ownRecs := party(origNameType = '1');
                                        regRecs := party(origNameType = '4');
                                        
                                        uniqueOwn := DEDUP(SORT(ownRecs, EXCEPT sequence_key), EXCEPT sequence_key);
                                        uniqueReg := DEDUP(SORT(regRecs, EXCEPT sequence_key), EXCEPT sequence_key);
                                        
                                        tempCurrent := IF(EXISTS(ownRecs) AND ~EXISTS(uniqueOwn), SKIP, EXISTS(regRecs(history = '')) OR LEFT.isCurrent);
     
                                        partiesToKey := UNGROUP(party);
                                        
                                        regRoll := ROLLUP(SORT(partiesToKey(origNameType = '4'), partyID),
                                                          LEFT.partyID = RIGHT.partyID,
                                                          TRANSFORM(DueDiligence.LayoutsInternal.PartyInfoLayout,
                                                                    SELF.registeredState := IF(LEFT.registeredState <> '', LEFT.registeredState, RIGHT.registeredState);
                                                                    SELF.registeredDate := MAX(LEFT.registeredDate, RIGHT.registeredDate);
                                                                    SELF.licensePlateType := IF(LEFT.licensePlateType <> '', LEFT.licensePlateType, RIGHT.licensePlateType);
                                                                    SELF.registeredLatestEffectiveDate := (STRING8) MAX ((UNSIGNED)LEFT.registeredLatestEffectiveDate, (UNSIGNED)RIGHT.registeredLatestEffectiveDate);
                                                                    SELF.registeredLatestExpirationDate := (STRING8) MAX((UNSIGNED)LEFT.registeredLatestExpirationDate, (UNSIGNED)RIGHT.registeredLatestExpirationDate);
                                                                    
                                                                    SELF := LEFT;));
                                          
                                        ownRoll := ROLLUP(SORT(partiesToKey(origNameType = '1'), partyID),
                                                          LEFT.partyID = RIGHT.partyID,
                                                          TRANSFORM(DueDiligence.LayoutsInternal.PartyInfoLayout,
                                                                    SELF.titleState := IF(LEFT.titleState <> '', LEFT.titleState, RIGHT.titleState);
                                                                    SELF.titleDate := MAX(LEFT.titleDate, RIGHT.titleDate);
                                                                    SELF := LEFT;));
                                      
                                        
                                        histDate := IF(LEFT.historyDate = DueDiligence.Constants.date8Nines, STD.Date.Today(), LEFT.historyDate);
                                        
                                        //if the record is marked current, check to see if the data supports it
                                        SELF.isCurrent := tempCurrent AND (UNSIGNED4)regRoll[1].registeredLatestExpirationDate >= histDate;
                                        
                                        SELF.registrants := regRoll;
                                        SELF.owners := ownRoll;
                                        
                                        SELF := LEFT;),
                              GROUPED);
                              
                              
    unGrpData := UNGROUP(rolledRecs)(EXISTS(owners) OR EXISTS(registrants));


    sortVehRegistrations := SORT(unGrpData, inputDID, vin, -((UNSIGNED1)isCurrent),
                                  -MAX(registrants, registeredLatestEffectiveDate), -MAX(registrants, registeredLatestExpirationDate),
                                  -((UNSIGNED)iteration_key), -sequence_key, RECORD);

    sortVehTitles := SORT(unGrpData, inputDID, vin, IF(EXISTS(owners), 0, 1),
                          -MAX(owners, titleLatestIssueDate), -MAX(owners, titleEarliestIssueDate),
                          -((UNSIGNED)iteration_key), -sequence_key);


    vehRegis := PROJECT(SORT(DEDUP(sortVehRegistrations, inputDID, vin),
                              -((UNSIGNED1)isCurrent), -MAX(registrants, registeredLatestEffectiveDate), -MAX(registrants,registeredLatestExpirationDate),
                              -((UNSIGNED)iteration_key)),
                        TRANSFORM({DueDiligence.LayoutsInternal.CarInfoLayout, UNSIGNED1 priorityNum, UNSIGNED2 startNum},
                                  SELF.priorityNum := 1;
                                  SELF.startNum := COUNTER;
                                  SELF := LEFT;));



    titleHolders := DEDUP(sortVehTitles, inputDID, vin)(EXISTS(owners));
    regisNotOwner := vehRegis(~EXISTS(owners));

    regisAndTitles := JOIN(titleHolders, regisNotOwner,
                            LEFT.inputDID = RIGHT.inputDID AND 
                            LEFT.vin = RIGHT.vin, 
                            TRANSFORM({DueDiligence.LayoutsInternal.CarInfoLayout, UNSIGNED1 priorityNum, UNSIGNED2 startNum},
                                      SELF.priorityNum := 2;
                                      SELF.startNum := RIGHT.startNum;
                                      SELF := LEFT;));

    allVehRegisAndTitle := PROJECT(SORT(vehRegis + regisAndTitles, nonDMVSource, startNum, priorityNum),
                                    TRANSFORM(DueDiligence.LayoutsInternal.CarInfoLayout, SELF :=LEFT));



    sortInputVehicles := SORT(allVehRegisAndTitle, inputDID, vin, -isCurrent);

    rollInputVehicles := ROLLUP(sortInputVehicles,
                                LEFT.inputDID = RIGHT.inputDID AND
                                LEFT.vin = RIGHT.vin,
                                TRANSFORM(RECORDOF(allVehRegisAndTitle),
                                          SELF.registrants := LEFT.registrants + RIGHT.registrants;
                                          SELF.owners := LEFT.owners + RIGHT.owners;
                                          SELF := LEFT;));



    currVeh := rollInputVehicles(isCurrent);
    
    popInquired := PROJECT(inData, TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                    
                                              inqVroom := currVeh(inputDID = LEFT.inquiredDID);
                                              spsVroom := currVeh(inputDID IN SET(LEFT.spouses, did));
              
                                              vroom := inqVroom + spsVroom;
                                              
                                              uniqueVrooms := DEDUP(SORT(vroom, vin), vin);
                                              limitVehicles := CHOOSEN(SORT(uniqueVrooms, -basePrice, -year, make, model), iesp.constants.DDRAttributesConst.MaxVehicles);
                                              
                                              allSpouses := LEFT.spouses;
                                              
                                              inqInfo := DATASET([TRANSFORM(DueDiligence.Layouts.DIDAndName,
                                                                            SELF.did := LEFT.inquiredDID;
                                                                            SELF := LEFT.individual;
                                                                            SELF := [];)]);
                                              
                                              allVehicles := PROJECT(limitVehicles, TRANSFORM(DueDiligence.Layouts.VehicleDataLayout,
                                                                                              
                                                                                              inqOwned := inqVroom(vin = LEFT.vin);
                                                                                              spsOwned := spsVroom(vin = LEFT.vin);
                                                                                                                                       
                                                                                              SELF.inquiredOwned := EXISTS(inqOwned);
                                                                                              SELF.spouseOwned := EXISTS(spsOwned);
                                                                                              
                                                                                              //get the spouse info if found
                                                                                              spsInfo := PROJECT(allSpouses(did IN SET(spsOwned, inputDID)),
                                                                                                                 TRANSFORM(DueDiligence.Layouts.DIDAndName,
                                                                                                                            SELF.did := LEFT.did;
                                                                                                                            SELF.firstName := LEFT.firstName;
                                                                                                                            SELF.lastName := LEFT.lastName;
                                                                                                                            SELF := LEFT;
                                                                                                                            SELF := [];));
                                                                                              
                                                                                              
                                                                                              
                                                                                              SELF.vehicleOwners := IF(EXISTS(inqOwned), inqInfo) + spsInfo;
                                                                                              
                                                                                              SELF.registeredDate := (STRING8) MAX((UNSIGNED)inqOwned.registrants[1].registeredDate, (UNSIGNED)spsOwned.registrants[1].registeredDate);
                                                                                              SELF.titleDate := (STRING8) MAX((UNSIGNED)inqOwned.owners[1].titleDate, (UNSIGNED)spsOwned.owners[1].titleDate);
                                                                                              
                                                                                              
                                                                                              SELF.registeredState := IF(inqOwned.registrants[1].registeredState <> DueDiligence.Constants.EMPTY, inqOwned.registrants[1].registeredState, spsOwned.registrants[1].registeredState);
                                                                                              SELF.licensePlateType := IF(inqOwned.registrants[1].licensePlateType <> DueDiligence.Constants.EMPTY, inqOwned.registrants[1].licensePlateType, spsOwned.registrants[1].licensePlateType);
                                                                                              SELF.titleState := IF(inqOwned.owners[1].titleState <> DueDiligence.Constants.EMPTY, inqOwned.owners[1].titleState, spsOwned.owners[1].titleState);
                                                                                              
                                                                                              SELF := LEFT;));
                                              
                                              
                                              
                                              SELF.vehicleCount := COUNT(limitVehicles);
                                              SELF.vehicleBaseValue := MAX(limitVehicles, basePrice);
                                              SELF.perVehicle := allVehicles;  
                                              SELF := LEFT;));
            

  
 
 
 
 
 
    // OUTPUT(spouseAndInquired, NAMED('spouseAndInquired'));
    // OUTPUT(vehicleByDID, NAMED('vehicleByDID'));
    // OUTPUT(dedupAllVehicleKeys, NAMED('dedupAllVehicleKeys'));
    // OUTPUT(sortKeys, NAMED('sortKeys'));
    // OUTPUT(dedupVehByKeys, NAMED('dedupVehByKeys'));
    
    // OUTPUT(vehicleInfo, NAMED('vehicleInfo'));
    // OUTPUT(ungroupVehicleInfo, NAMED('ungroupVehicleInfo'));
    
    // OUTPUT(partyInfoRaw, NAMED('partyInfoRaw'));
    // OUTPUT(partyInfo, NAMED('partyInfo'));
    
    // OUTPUT(rolledRecs, NAMED('rolledRecs'));
    // OUTPUT(ungrpData, NAMED('ungrpData'));
    
    
    // OUTPUT(sortVehRegistrations, NAMED('sortVehRegistrations'));
    // OUTPUT(sortVehTitles, NAMED('sortVehTitles'));
    // OUTPUT(vehRegis, NAMED('vehRegis'));
    // OUTPUT(titleHolders, NAMED('titleHolders'));
    // OUTPUT(regisNotOwner, NAMED('regisNotOwner'));
    // OUTPUT(regisAndTitles, NAMED('regisAndTitles'));
    // OUTPUT(allVehRegisAndTitle, NAMED('allVehRegisAndTitle'));
    
    // OUTPUT(sortInputVehicles, NAMED('sortInputVehicles'));
    // OUTPUT(rollInputVehicles, NAMED('rollInputVehicles'));
       
    // OUTPUT(currVeh, NAMED('currVeh'));
    // OUTPUT(popInquired, NAMED('popInquired'));
    
       
   
    RETURN popInquired;   
  
 END;