IMPORT DueDiligence, VehicleV2;

/*
	Following Keys being used:
        VehicleV2.key_vehicle_did
        VehicleV2.Key_Vehicle_Party_Key	 
*/
EXPORT getIndVehicle(DATASET(DueDiligence.Layouts.Indv_Internal) inData, UNSIGNED1 dppa) := FUNCTION


  getSpouseAsInquired := DueDiligence.CommonIndividual.getRelationship(inData, spouses, DueDiligence.Constants.INQUIRED_INDIVIDUAL_SPOUSE);
  
  spouseAndInquired := getSpouseAsInquired + inData;
  
                                                        																					 
	//Get the DIDs that have a vehicle listed in our data     
  //and pick up the vehicle_key, iteration_key and          
  //sequence_key to be used to look up additonal details    
  //found in other vehicle keys                                                                                   	
  vehicleByDID := JOIN(spouseAndInquired, VehicleV2.key_vehicle_did,
                        //individual DID could be a SPOUSE of the inquired DID or the inquired  DID                        
                        KEYED(LEFT.individual.did = RIGHT.append_did),  
                        TRANSFORM(DueDiligence.LayoutsInternal.VehicleSlimLayout,
                                  SELF.seq := LEFT.seq;
                                  SELF.did := LEFT.inquiredDID;               
                                  SELF.Vehicle_Key := RIGHT.vehicle_key;
                                  SELF.Iteration_Key := RIGHT.iteration_key;
                                  SELF.Sequence_Key := RIGHT.sequence_key;
                                  
                                  inquiredOwned := LEFT.indvType = DueDiligence.Constants.INQUIRED_INDIVIDUAL;   
                                  spouseOwned := LEFT.indvType = DueDiligence.Constants.INQUIRED_INDIVIDUAL_SPOUSE;
                                                
                                  SELF.inquiredOwned := inquiredOwned;
                                  SELF.spouseOwned := spouseOwned;
                                                
                                  SELF.vehicleOwners := IF(inquiredOwned OR spouseOwned, 
                                                            DATASET([TRANSFORM(DueDiligence.Layouts.DIDAndName, SELF := LEFT.individual;)]), 
                                                            DATASET([], DueDiligence.Layouts.DIDAndName));
                                                            
                                  SELF.historyDate := LEFT.historyDate;
                                  SELF := [];),
                        //Keep only the records that match on both side
                        KEEP(500), 
                        ATMOST(DueDiligence.Constants.MAX_ATMOST_1000));
                    
  
  sortVehicles := SORT(vehicleByDID, Vehicle_Key, Iteration_Key, Sequence_Key);
  
  //remove duplices where both spouse and inquired own the same vehicle
  rollVehicles := ROLLUP(sortVehicles,
                          LEFT.Vehicle_Key = RIGHT.Vehicle_Key AND
                          LEFT.Iteration_Key = RIGHT.Iteration_Key AND
                          LEFT.Sequence_Key = RIGHT.Sequence_Key,
                          TRANSFORM(DueDiligence.LayoutsInternal.VehicleSlimLayout,
                                    SELF.inquiredOwned := LEFT.inquiredOwned OR RIGHT.inquiredOwned;
                                    SELF.spouseOwned := LEFT.spouseOwned OR RIGHT.spouseOwned;
                                    SELF.vehicleOwners := LEFT.vehicleOwners + RIGHT.vehicleOwners;
                                    SELF := LEFT;));
                    
                                                                
  // JOIN the results to Vehicle Party Key and                      
	// start a slim record that contains all the vehicle details      
  //                                                                
  //           VehicleV2.Key_Vehicle_Party_Key                       
  // and select only records where history field is empty           
  // to get just the currently owned vehicles                       
  vehicleSlimParty := JOIN(rollVehicles, VehicleV2.Key_Vehicle_Party_Key,                                 
                            KEYED(LEFT.Vehicle_Key = RIGHT.vehicle_key)   AND
                            KEYED(LEFT.Iteration_Key = RIGHT.iteration_key) AND 
                            KEYED(LEFT.Sequence_Key  = RIGHT.sequence_key),
                            TRANSFORM(DueDiligence.LayoutsInternal.VehicleSlimLayout,  
																			SELF.licensePlateType := RIGHT.reg_license_plate_type_desc;                   
																			SELF.registeredState := RIGHT.reg_license_state;
																			SELF.registeredDate := RIGHT.reg_latest_effective_date;
																			SELF.titleState :=  IF(RIGHT.ttl_number != DueDiligence.Constants.EMPTY, RIGHT.state_origin, DueDiligence.Constants.EMPTY);  
																			SELF.titleDate := RIGHT.ttl_latest_issue_date;
																			SELF.nameType := RIGHT.orig_name_type;
																			SELF.historyFlag := RIGHT.history;
                                      SELF.dateFirstSeen := IF(RIGHT.date_first_seen > 0, RIGHT.date_first_seen, RIGHT.date_vendor_first_reported);
																			SELF := LEFT;),
                            //keep only the records that match on both sides
                            ATMOST(DueDiligence.Constants.MAX_ATMOST));

              
  vehicleSummary := DueDiligence.getSharedVehicle(vehicleSlimParty, dppa);
   
   
  addIndVehicleData := JOIN(inData, vehicleSummary,
															LEFT.seq = RIGHT.seq AND
															LEFT.inquiredDID = RIGHT.did,
															TRANSFORM(DueDiligence.Layouts.Indv_Internal,
																								SELF.VehicleCount := COUNT(RIGHT.AllVehicles);
																								SELF.VehicleBaseValue := RIGHT.maxBasePrice;
																								SELF.perVehicle := RIGHT.AllVehicles;  
																								SELF := LEFT;),
														  LEFT OUTER,
                              ATMOST(1));

  

 //	OUTPUT(inData,               NAMED('inData_BeforeAddingVehicle'));
 // OUTPUT(getSpouseAsInquired, NAMED('getSpouseAsInquired'));
 // OUTPUT(spouseAndInquired, NAMED('spouseAndInquired'));
 // OUTPUT(vehicleByDID, NAMED('vehicleByDID'));
 // OUTPUT(sortVehicles, NAMED('sortVehicles'));
 // OUTPUT(rollVehicles, NAMED('rollVehicles'));
 // OUTPUT(VehicleSlimParty, NAMED('VehicleSlimParty'));  
 // OUTPUT(vehicleSummary, NAMED('VehicleSummary'));  
 // OUTPUT(addIndVehicleData, NAMED('inData_AfterAddingVehicle'));  
 


	   
   
  RETURN addIndVehicleData;   
  
 
 
 END;      //***end of FUNCTION  