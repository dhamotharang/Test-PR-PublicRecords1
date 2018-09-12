IMPORT BIPv2, DueDiligence, UT, VehicleV2;

/*
	Following Keys being used:
        VehicleV2.Key_Vehicle_Main_Key		 
*/
EXPORT getSharedVehicle(DATASET(DueDiligence.LayoutsInternal.VehicleSlimLayout) inVehicleData, UNSIGNED1 dppa) := FUNCTION

  //Get the vehicle details from the vehicle Main Key       
  //Select only the currently owned vehicles               														
	//and Owner(type=1), Registrant(type=4) or               
  //Lessor(type=2) records
	currentlyOwned := inVehicleData(Vehicle_key != DueDiligence.Constants.EMPTY AND 
                                  nameType IN [DueDiligence.Constants.VEH_OWNER, DueDiligence.Constants.VEH_REGISTRANT, DueDiligence.Constants.VEH_LESSOR] AND
                                  historyFlag = DueDiligence.Constants.EMPTY);
	
  VehicleCurrentMain := JOIN(currentlyOwned, VehicleV2.Key_Vehicle_Main_Key,
															KEYED(LEFT.vehicle_key = RIGHT.vehicle_key),
															TRANSFORM(DueDiligence.LayoutsInternal.VehicleSlimLayout,  
																				SELF.seq := LEFT.seq,
																				SELF.ultid := LEFT.ultid;
                                        SELF.orgid := LEFT.orgid;
                                        SELF.seleid := LEFT.seleid;
                                        SELF.did := LEFT.did;
																				//additional detailed data from right (VehicleDetails)
																				SELF.vehicle_key := RIGHT.vehicle_key;
																				SELF.Iteration_Key := RIGHT.Iteration_Key;  
																				SELF.vin := IF(RIGHT.vina_vin != DueDiligence.Constants.EMPTY, RIGHT.vina_vin, RIGHT.orig_vin); 
																				SELF.year := RIGHT.orig_year; 
																				SELF.make := IF(RIGHT.vina_make_desc != DueDiligence.Constants.EMPTY, RIGHT.vina_make_desc, RIGHT.orig_make_desc);
                                        SELF.model := IF(RIGHT.vina_model_desc != DueDiligence.Constants.EMPTY, RIGHT.vina_model_desc, RIGHT.orig_model_desc);
																				SELF.basePrice := (UNSIGNED6)RIGHT.vina_price;
																				SELF.classType := RIGHT.model_class;  
                                        
                                        //used to verify DPPA
                                        SELF.stateOrigin := RIGHT.state_origin;
                                        SELF.sourceCode := RIGHT.source_code;
                                        
																				SELF := LEFT;
																				SELF := [];),  
														 ATMOST(DueDiligence.Constants.MAX_ATMOST),
														 //keep All records from the LEFT even the no matches
														 LEFT OUTER);
                             
  permissibleVehicles := VehicleCurrentMain(UT.PermissionTools.dppa.state_ok(stateOrigin, dppa,, sourceCode));                           
                             
	//Sort records here                                                       
	Vehicles_sorted :=  SORT(permissibleVehicles, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did, vin, vehicle_key);                                                    
																										                                    
	//Remove duplicates records here                                                 
	ListOfVehicleUnique := ROLLUP(Vehicles_sorted,
																 LEFT.ultid = RIGHT.ultid AND
																 LEFT.orgid = RIGHT.orgid AND
																 LEFT.seleid = RIGHT.seleid AND
																 LEFT.did = RIGHT.did AND
																 LEFT.seq = RIGHT.seq AND
																 (LEFT.vehicle_key = RIGHT.vehicle_key OR LEFT.vin = RIGHT.vin),
																 TRANSFORM(DueDiligence.LayoutsInternal.VehicleSlimLayout,
																						SELF.ultid := LEFT.ultid;
	                                          SELF.orgid := LEFT.orgid;
	                                          SELF.seleid := LEFT.seleid;
																						SELF.did := LEFT.did;
																						SELF.seq := LEFT.seq;
	                                          SELF.vehicle_key := LEFT.vehicle_key;
				                                    SELF.Iteration_Key := LEFT.Iteration_Key;  
																						
																						//grab the most expensive priced vehicle 
																            SELF.basePrice := MAX(LEFT.basePrice, RIGHT.basePrice);
																						
																            //try and get the most information about the Make Model and Year 
																            SELF.year := IF(LEFT.year != DueDiligence.Constants.EMPTY, LEFT.year, RIGHT.year);
																            SELF.make := IF(LEFT.make != DueDiligence.Constants.EMPTY, LEFT.make, RIGHT.make);
																            SELF.model := IF(LEFT.model != DueDiligence.Constants.EMPTY, LEFT.model, RIGHT.model);
                                            
                                            SELF.titleState := IF(LEFT.titleState != DueDiligence.Constants.EMPTY, LEFT.titleState, RIGHT.titleState);
                                            SELF.titleDate := IF(LEFT.titleDate != DueDiligence.Constants.EMPTY, LEFT.titleDate,  RIGHT.titleDate);
																						
																						SELF.registeredState := IF(LEFT.registeredState != DueDiligence.Constants.EMPTY, LEFT.registeredState, RIGHT.registeredState);
                                            SELF.registeredDate := IF(LEFT.registeredDate != DueDiligence.Constants.EMPTY, LEFT.registeredDate, RIGHT.registeredDate);
																						
                                            SELF.licensePlateType := IF(LEFT.licensePlateType != DueDiligence.Constants.EMPTY, LEFT.licensePlateType, RIGHT.licensePlateType);   
                                            SELF.classType := IF(LEFT.classType != DueDiligence.Constants.EMPTY, LEFT.classType, RIGHT.classType);   
                                            
																						//take the remainder from the left
																						SELF := LEFT;  
																						SELF := [];));
	
  ConvertVehicleListToDATASET := PROJECT(ListOfVehicleUnique, TRANSFORM(DueDiligence.LayoutsInternal.SharedVehicleSlim,
                                                                        SELF.ultid := LEFT.ultid;
                                                                        SELF.orgid := LEFT.orgid;
                                                                        SELF.seleid := LEFT.seleid;
                                                                        SELF.did := LEFT.did;
                                                                        SELF.seq := LEFT.seq;
                                                                        SELF.proxid := LEFT.proxID;
                                                                        SELF.powid := LEFT.powID;  
                                                                        SELF.allVehicles := DATASET([TRANSFORM(DueDiligence.Layouts.VehicleDataLayout, SELF := LEFT; SELF := [];)]);
                                                                        SELF.maxBasePrice := LEFT.basePrice;
                                                                        SELF := LEFT;
                                                                        SELF := [];));   
  
                                                                   
	//ROLLUP the number vehicles left in the list of unique vehicles    
	//to create a single row of vehicle information for each unique id   
	sortConverted := SORT(ConvertVehicleListToDATASET, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did);
	SummaryCurrentVehicle := ROLLUP(sortConverted,
																	 LEFT.ultid = RIGHT.ultid AND
																	 LEFT.orgid = RIGHT.orgid AND
																	 LEFT.seleid = RIGHT.seleid AND
																	 LEFT.did = RIGHT.did AND
																	 LEFT.seq = RIGHT.seq, 
																	 TRANSFORM(DueDiligence.LayoutsInternal.SharedVehicleSlim,
                                              SELF.allVehicles := LEFT.allVehicles + RIGHT.allVehicles; 
                                              //grab the most expensive priced vehicle 
                                              SELF.maxBasePrice := MAX(LEFT.maxBasePrice, RIGHT.maxBasePrice),
                                              SELF := LEFT;));   
                                
                                
                                
  // OUTPUT(currentlyOwned, NAMED('currentlyOwned'));
  // OUTPUT(VehicleCurrentMain, NAMED('VehicleCurrentMain'));
  // OUTPUT(permissibleVehicles, NAMED('permissibleVehicles'));
  // OUTPUT(Vehicles_sorted, NAMED('Vehicles_sorted'));
  // OUTPUT(ListOfVehicleUnique, NAMED('ListOfVehicleUnique'));
  // OUTPUT(ConvertVehicleListToDATASET, NAMED('ConvertVehicleListToDATASET'));
  // OUTPUT(sortConverted, NAMED('sortConverted'));
  // OUTPUT(SummaryCurrentVehicle, NAMED('SummaryCurrentVehicle'));


  RETURN SummaryCurrentVehicle;
END;
			