IMPORT BIPv2, DueDiligence, STD, UT, VehicleV2;

/*
	Following Keys being used:
        VehicleV2.Key_Vehicle_Main_Key		 
*/
EXPORT getSharedVehicle(DATASET(DueDiligence.LayoutsInternal.VehicleSlimLayout) inVehicleData, UNSIGNED1 dppa) := FUNCTION
  
  
  //Clean dates used in logic and/or attribute levels here so all comparisions flow through consistently
	vehicleSlimCleanDate := DueDiligence.Common.CleanDatasetDateFields(inVehicleData, 'dateFirstSeen');
	
	//Filter out records after our history date.
	vehicleFilt := DueDiligence.Common.FilterRecordsSingleDate(vehicleSlimCleanDate, dateFirstSeen);      

  //retrieve the vehichle data for all the vehicle data within our history range
  //this allows us to get as much info about a vehicle
  vehicleDetails := JOIN(vehicleFilt, VehicleV2.Key_Vehicle_Main_Key,
															KEYED(LEFT.vehicle_key = RIGHT.vehicle_key) AND
                              KEYED(LEFT.iteration_Key = RIGHT.iteration_Key),
															TRANSFORM(DueDiligence.LayoutsInternal.VehicleSlimLayout,  
																				SELF.seq := LEFT.seq,
																				SELF.ultid := LEFT.ultid;
                                        SELF.orgid := LEFT.orgid;
                                        SELF.seleid := LEFT.seleid;
                                        SELF.did := LEFT.did;
																				//additional detailed data from right (VehicleDetails)
																				SELF.vehicle_key := LEFT.vehicle_key;
																				SELF.iteration_Key := LEFT.iteration_Key;  
																				SELF.vin := IF(RIGHT.vina_vin != DueDiligence.Constants.EMPTY, RIGHT.vina_vin, RIGHT.orig_vin); 
																				SELF.year := IF(RIGHT.vina_model_year != DueDiligence.Constants.EMPTY, RIGHT.vina_model_year, RIGHT.orig_year); 
																				SELF.make := IF(RIGHT.vina_make_desc != DueDiligence.Constants.EMPTY, RIGHT.vina_make_desc, RIGHT.orig_make_desc);
                                        SELF.model := IF(RIGHT.VINA_VP_Series_Name != DueDiligence.Constants.EMPTY, 
                                                          RIGHT.VINA_VP_Series_Name,
                                                          TRIM(RIGHT.Orig_Model_Desc) + ' ' + IF(RIGHT.Orig_Series_Desc[1..3] != '000', TRIM(RIGHT.Orig_Series_Desc), DueDiligence.Constants.EMPTY));
																				SELF.basePrice := (UNSIGNED6)RIGHT.vina_price;
																				SELF.classType := RIGHT.model_class;  
                                        
                                        //used to verify DPPA
                                        SELF.stateOrigin := RIGHT.state_origin;
                                        SELF.sourceCode := RIGHT.source_code;
                                        
																				SELF := LEFT;
																				SELF := [];),  
														 ATMOST(DueDiligence.Constants.MAX_ATMOST));
                             
  permissibleVehicles := vehicleDetails(UT.PermissionTools.dppa.state_ok(stateOrigin, dppa,, sourceCode));   
  
 
  //Get the vehicle details from the vehicle Main Key       
  //Select only the currently owned vehicles               														
	//and Owner(type=1), Registrant(type=4) or               
  //Lessor(type=2) records
	ownedVehicles := permissibleVehicles(Vehicle_key != DueDiligence.Constants.EMPTY AND 
                                        nameType IN [DueDiligence.Constants.VEH_OWNER, DueDiligence.Constants.VEH_REGISTRANT, DueDiligence.Constants.VEH_LESSOR]);
                             
	//Sort records here                                                       
	sortedVehicles :=  SORT(ownedVehicles, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did, vehicle_key, -iteration_Key, -sequence_key);                                                 
																										                                    
	//Remove duplicates records here - and get first populated data for a given vehicle                                                
	uniqueVehhicleDetails := ROLLUP(sortedVehicles,
																 LEFT.seq = RIGHT.seq AND
                                 LEFT.ultid = RIGHT.ultid AND
																 LEFT.orgid = RIGHT.orgid AND
																 LEFT.seleid = RIGHT.seleid AND
																 LEFT.did = RIGHT.did AND
																 LEFT.vehicle_key = RIGHT.vehicle_key,
																 TRANSFORM(DueDiligence.LayoutsInternal.VehicleSlimLayout,
																						SELF.ultid := LEFT.ultid;
	                                          SELF.orgid := LEFT.orgid;
	                                          SELF.seleid := LEFT.seleid;
																						SELF.did := LEFT.did;
																						SELF.seq := LEFT.seq;
	                                          SELF.vehicle_key := LEFT.vehicle_key;
				                                    SELF.iteration_Key := LEFT.iteration_Key;  
																						
																						//grab the most expensive priced vehicle 
																            SELF.basePrice := MAX(LEFT.basePrice, RIGHT.basePrice);
																						
																            //try and get the most information about the vehicle
																            SELF.year := DueDiligence.Common.firstPopulatedString(year);
																            SELF.make := DueDiligence.Common.firstPopulatedString(make);
																            SELF.model := DueDiligence.Common.firstPopulatedString(model);
																            SELF.vin := DueDiligence.Common.firstPopulatedString(vin);
                                            
                                            //get most recent title and registration dates
                                            recentTitle := IF(LEFT.titleDate >= RIGHT.titleDate, LEFT, RIGHT);
                                            recentRegistration := IF(LEFT.registeredDate >= RIGHT.registeredDate, LEFT, RIGHT);
                                            
                                            SELF.titleState := recentTitle.titleState;
                                            SELF.titleDate := recentTitle.titleDate;
																						
																						SELF.registeredState := recentRegistration.registeredState;
                                            SELF.registeredDate := recentRegistration.registeredDate;
																						
                                            SELF.licensePlateType := DueDiligence.Common.firstPopulatedString(licensePlateType);
                                            SELF.classType := DueDiligence.Common.firstPopulatedString(classType);
                                            
                                            SELF.historyFlag := DueDiligence.Constants.EMPTY; //details do not need/care about this info
                                            
																						//take the remainder from the left
																						SELF := LEFT;  
																						SELF := [];));
  
  
  
  //take the filtered data from input, and filter those that are current
  currentVehicleInput := vehicleFilt(historyFlag = DueDiligence.Constants.EMPTY);
  
  //get rid of the duplicate input vehicles by vehicle_key (since this is the level for details)
  uniqueCurrentVehicleInput := DEDUP(SORT(currentVehicleInput, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did, vehicle_key), seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did, vehicle_key);
  
  //join the current vehicle information with that of the details
  addVehicleDetails := JOIN(uniqueCurrentVehicleInput, uniqueVehhicleDetails,
                            LEFT.seq = RIGHT.seq AND
                            LEFT.ultid = RIGHT.ultid AND
                            LEFT.orgid = RIGHT.orgid AND
                            LEFT.seleid = RIGHT.seleid AND
                            LEFT.did = RIGHT.did AND 
                            LEFT.vehicle_key = RIGHT.vehicle_key,
                            TRANSFORM(RIGHT));
                            
  //now take all the vehicle details and rollup based on the VIN number to remove duplicate rows of a vehicle reported by different sources
  sortByVIN := SORT(addVehicleDetails, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did, vin, licensePlateType, classType, -registeredDate);
  
  rollByVin := ROLLUP(sortByVIN,
                       LEFT.seq = RIGHT.seq AND
                       LEFT.ultid = RIGHT.ultid AND
                       LEFT.orgid = RIGHT.orgid AND
                       LEFT.seleid = RIGHT.seleid AND
                       LEFT.did = RIGHT.did AND
                       LEFT.vin = RIGHT.vin,
                       TRANSFORM(DueDiligence.LayoutsInternal.VehicleSlimLayout,
                                  //grab the most expensive priced vehicle 
                                  SELF.basePrice := MAX(LEFT.basePrice, RIGHT.basePrice);
                                  
                                  //try and get the most information about the vehicle
                                  SELF.year := DueDiligence.Common.firstPopulatedString(year);
                                  SELF.make := DueDiligence.Common.firstPopulatedString(make);
                                  SELF.model := DueDiligence.Common.firstPopulatedString(model);
                                  SELF.vin := DueDiligence.Common.firstPopulatedString(vin);
                                  
                                  //get most recent title and registration dates
                                  recentTitle := IF(LEFT.titleDate >= RIGHT.titleDate, LEFT, RIGHT);
                                  recentRegistration := IF(LEFT.registeredDate >= RIGHT.registeredDate, LEFT, RIGHT);
                                  
                                  SELF.titleState := recentTitle.titleState;
                                  SELF.titleDate := recentTitle.titleDate;
                                  
                                  SELF.registeredState := recentRegistration.registeredState;
                                  SELF.registeredDate := recentRegistration.registeredDate;
                                  
                                  SELF.licensePlateType := DueDiligence.Common.firstPopulatedString(licensePlateType);
                                  SELF.classType := DueDiligence.Common.firstPopulatedString(classType);
                                 
                                  //take the remainder from the left
                                  SELF := LEFT;  
                                  SELF := [];));
                            
  //limit the data to what the dataset can hold
  sortGroupVehicle := GROUP(SORT(rollByVin, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did, -basePrice, -year, make, model), seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did);
  limitedVehicles := DueDiligence.Common.GetMaxRecords(sortGroupVehicle, DueDiligence.Constants.MAX_VEHICLE);  
    
                        
	
  convertVehicleListToDATASET := PROJECT(limitedVehicles, TRANSFORM(DueDiligence.LayoutsInternal.SharedVehicleSlim,
                                                                    SELF.seq := LEFT.seq;  
                                                                    SELF.ultid := LEFT.ultid;
                                                                    SELF.orgid := LEFT.orgid;
                                                                    SELF.seleid := LEFT.seleid;
                                                                    SELF.did := LEFT.did;
                                                                    SELF.allVehicles := DATASET([TRANSFORM(DueDiligence.Layouts.VehicleDataLayout, SELF := LEFT; SELF := [];)]);
                                                                    SELF.maxBasePrice := LEFT.basePrice;
                                                                    SELF := LEFT;
                                                                    SELF := [];));   
  
                                                                   
	//ROLLUP the number vehicles left in the list of unique vehicles    
	//to create a single row of vehicle information for each unique id   
	sortConverted := SORT(convertVehicleListToDATASET, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did);
	summaryCurrentVehicle := ROLLUP(sortConverted,
																	 LEFT.seq = RIGHT.seq AND
                                   LEFT.ultid = RIGHT.ultid AND
																	 LEFT.orgid = RIGHT.orgid AND
																	 LEFT.seleid = RIGHT.seleid AND
																	 LEFT.did = RIGHT.did, 
																	 TRANSFORM(DueDiligence.LayoutsInternal.SharedVehicleSlim,
                                              SELF.allVehicles := LEFT.allVehicles + RIGHT.allVehicles; 
                                              //grab the most expensive priced vehicle 
                                              SELF.maxBasePrice := MAX(LEFT.maxBasePrice, RIGHT.maxBasePrice),
                                              SELF := LEFT;));   
                                
                                


                                
  // OUTPUT(vehicleFilt, NAMED('vehicleFilt'));
  // OUTPUT(ownedVehicles, NAMED('ownedVehicles'));
  // OUTPUT(vehicleDetails, NAMED('vehicleDetails'));
  // OUTPUT(permissibleVehicles, NAMED('permissibleVehicles'));
  // OUTPUT(sortedVehicles, NAMED('sortedVehicles'));
  // OUTPUT(uniqueVehhicleDetails, NAMED('uniqueVehhicleDetails'));
  // OUTPUT(uniqueCurrentVehicleInput, NAMED('uniqueCurrentVehicleInput'));
  // OUTPUT(addVehicleDetails, NAMED('addVehicleDetails'));
  // OUTPUT(sortByVIN, NAMED('sortByVIN'));
  // OUTPUT(rollByVin, NAMED('rollByVin'));
  // OUTPUT(convertVehicleListToDATASET, NAMED('convertVehicleListToDATASET'));
  // OUTPUT(sortConverted, NAMED('sortConverted'));
  // OUTPUT(summaryCurrentVehicle, NAMED('summaryCurrentVehicle'));


  RETURN summaryCurrentVehicle;
END;
			