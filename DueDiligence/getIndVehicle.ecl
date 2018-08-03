IMPORT DueDiligence, _Control, VehicleV2;

/*
	Following Keys being used:
        VehicleV2.key_vehicle_did
        VehicleV2.Key_Vehicle_Party_Key
        VehicleV2.Key_Vehicle_Main_Key		 
*/
EXPORT getIndVehicle(DATASET(DueDiligence.Layouts.Indv_Internal) inData,
                      STRING dataRestrictionMask) := FUNCTION


  getSpouseAsInquired := DueDiligence.CommonIndividual.getRelationship(inData, spouses, DueDiligence.Constants.INQUIRED_INDIVIDUAL_SPOUSE);
  
  spouseAndInquired := getSpouseAsInquired + inData;
  
  // ------                                                         -----																					 
	// ------ Get the DIDs that have a vehicle listed in our data     -----
  // ------ and pick up the vehicle_key, iteration_key and          -----
  // ------ sequence_key to be used to look up additonal details    -----
  // ------ found in other vehicle keys                             -----
	// ------                                                         -----	
   vehicleByDID := JOIN(spouseAndInquired, VehicleV2.key_vehicle_did,
                    //***individual DID could be a SPOUSE of the inquired DID or the
                    //***inquired  DID                        
                    KEYED(LEFT.individual.did = RIGHT.append_did),  
                    TRANSFORM({DueDiligence.LayoutsInternal.VehicleSlimLayout, string15 Sequence_Key, unsigned6 individual_did},
                        SELF.VehicleReportData.seq := LEFT.seq;
                        SELF.VehicleReportData.did := LEFT.inquiredDID;               
                        SELF.Vehicle_Key           := RIGHT.vehicle_key;
                        SELF.Iteration_Key         := RIGHT.iteration_key;
                        SELF.Sequence_Key          := RIGHT.sequence_key;
                        SELF.individual_did        := LEFT.individual.did;  //*** pass this on for validation purposes only
                        
                        inquiredOwned              := LEFT.indvType = DueDiligence.Constants.INQUIRED_INDIVIDUAL;   
                        spouseOwned                := LEFT.indvType = DueDiligence.Constants.INQUIRED_INDIVIDUAL_SPOUSE;
                                      
                        SELF.inquiredOwned         := inquiredOwned;
                        SELF.spouseOwned          := spouseOwned;
                                      
                        SELF.vehicleOwners         := IF(inquiredOwned OR spouseOwned, 
                                                            DATASET([TRANSFORM(DueDiligence.Layouts.DIDAndName, SELF := LEFT.individual;)]), 
                                                            DATASET([], DueDiligence.Layouts.DIDAndName));
                        SELF := [];),              //***Initialize the remaining field to null
                    //*** Keep only the records that match on both side ***//
                    KEEP(500), 
                    ATMOST(DueDiligence.Constants.MAX_ATMOST_1000));
                    
  // ------                                                                 ------------
  // ------  JOIN the results to Vehicle Party Key and                      ------------
	// ------  start a slim record that contains all the vehicle details      ------------
  // ------                                                                 ------------
  // ------            VehicleV2.Key_Vehicle_Party_Key                      ------------ 
  // ------  and select only records where history field is empty           ------------
  // ------  to get just the currently owned vehicles                       ------------
  
  
   VehicleSlimParty  :=  JOIN(vehicleByDID, VehicleV2.Key_Vehicle_Party_Key,                                 
                            keyed(LEFT.Vehicle_Key   = RIGHT.vehicle_key)   AND
                            keyed(LEFT.Iteration_Key = RIGHT.iteration_key) AND 
                            keyed(LEFT.Sequence_Key  = right.sequence_key),
                                TRANSFORM({RECORDOF(LEFT), string1 history},  
                                    self.license_Plate_Type        := RIGHT.reg_license_plate_type_desc;                   
				                            SELF.Registered_State          := RIGHT.reg_license_state;
				                            SELF.Registered_Year           := (integer)RIGHT.reg_latest_effective_date[1..4];
				                            SELF.Registered_Month          := (integer)RIGHT.reg_latest_effective_date[5..6];
				                            SELF.Registered_Day            := (integer)RIGHT.reg_latest_effective_date[7..8];
				                            SELF.Title_State               :=  IF(RIGHT.ttl_number != '', RIGHT.state_origin, '');  
				                            SELF.Title_Year                := (integer)RIGHT.ttl_latest_issue_date[1..4];
				                            SELF.Title_Month               := (integer)RIGHT.ttl_latest_issue_date[5..6];
				                            SELF.Title_Day                 := (integer)RIGHT.ttl_latest_issue_date[7..8];
                                    SELF.orig_name_type            := RIGHT.orig_name_type;
                                    SELF.history                   := RIGHT.history;
				                            SELF                           := LEFT;),
                              //*** keep only the records that match on both sides ***//
                              ATMOST(DueDiligence.Constants.MAX_ATMOST));
                                     
  // ------                                                         -----																					 
	// ------ Get the vehicle details from the vehicle Main Key       -----
  // ------  Select only the currently owned vehicles               -----														
	// ------  and Owner(type=1), Registrant(type=4) or               -----
  // ------      Lessor(type=2) records                             -----
	// ------                                                         -----	        																			
  VehicleCurrentMain   :=   JOIN(VehicleSlimParty(Vehicle_key != ''
                                             AND (orig_name_type=  Constants.VEH_OWNER OR orig_name_type = Constants.VEH_REGISTRANT OR orig_name_type = Constants.VEH_LESSOR)
                                             AND history =''), VehicleV2.Key_Vehicle_Main_Key,
			                      keyed(LEFT.vehicle_key = RIGHT.vehicle_key),
                            TRANSFORM(DueDiligence.LayoutsInternal.VehicleSlimLayout,
	                              //***Pass the data from LEFT  
	                              SELF.VehicleReportData.seq    := LEFT.VehicleReportData.seq,
				                        SELF.VehicleReportData.ultID  := LEFT.VehicleReportData.ultID,
				                        SELF.VehicleReportData.orgID  := LEFT.VehicleReportData.orgID,
				                        SELF.VehicleReportData.seleID := LEFT.VehicleReportData.seleID,
				                        SELF.VehicleReportData.proxID := LEFT.VehicleReportData.proxID,
				                        SELF.VehicleReportData.powID  := LEFT.VehicleReportData.powID,
                                SELF.VehicleReportData.did    := LEFT.VehicleReportData.did,
				                        self.historyDateYYYYMMDD      := LEFT.historyDateYYYYMMDD;
				                        self.sl_vehicleCount          := 1;  
				                        /*  additional detailed data from right (VehicleDetails)  */ 
	                              SELF.vehicle_key               := RIGHT.vehicle_key;
				                        self.Iteration_Key             := RIGHT.Iteration_Key;  
	                              // self.Source_Code               := le.Source_Code;
				                        self.Orig_VIN                  := RIGHT.orig_vin; 
	                              self.Orig_Year                 := RIGHT.orig_year; 
	                              self.Orig_Make_Code            := RIGHT.orig_make_code;
	                              self.Orig_Make_Desc            := RIGHT.orig_make_desc; 
                                self.Vina_Price                := (unsigned6)RIGHT.vina_price;
			                          SELF.Class_Type                := RIGHT.model_class;  
			                          SELF                           := LEFT;  //***pass the fields from the LEFT 
	                              self                           := [];),  
                           ATMOST(DueDiligence.Constants.MAX_ATMOST),
                           //*** keep All records from the LEFT even the no matches ***//
                           LEFT OUTER);
   
                    
   VehicleSummary := DueDiligence.getSharedVehicle(VehicleCurrentMain);
   
   
   addIndVehicleData := JOIN(inData, VehicleSummary,
												LEFT.seq = RIGHT.seq AND
												LEFT.inquiredDID = RIGHT.did,
												TRANSFORM(DueDiligence.Layouts.Indv_Internal,
																					SELF.VehicleCount := RIGHT.totalvehicleCount;
																					SELF.VehicleBaseValue := RIGHT.maxBasePrice;
                                          /*  Populate the DATASET of Vehicles for reporting */  
                                          SELF.perVehicle       := RIGHT.AllVehicles;  
																					SELF := LEFT;),
                       //*** keep All records from the LEFT even the no matches ***//
								       LEFT OUTER);

  
//#IF(DEBUG_MODE_DueDiligence)
//	OUTPUT(inData,               NAMED('inData_BeforeAddingVehicle'));
 // OUTPUT(getSpouseAsInquired,  NAMED('getSpouseAsInquired'));
 // OUTPUT(spouseAndInquired,    NAMED('spouseAndInquired'));
 // OUTPUT(vehicleByDID,         NAMED('vehicleByDID'));
 // OUTPUT(VehicleSlimParty,     NAMED('VehicleSlimParty'));  
 // OUTPUT(VehicleCurrentMain,   NAMED('VehicleCurrentMain'));  
 // OUTPUT(VehicleSummary,       NAMED('VehicleSummary'));  
 // OUTPUT(addIndVehicleData,    NAMED('inData_AfterAddingVehicle'));  
//#END
	   
   
  RETURN addIndVehicleData;   
  
 
 
 END;      //***end of FUNCTION  