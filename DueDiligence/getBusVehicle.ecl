IMPORT BIPV2, Business_Risk_BIP, DueDiligence, VehicleV2, STD;

/*
	Following Keys being used:
        VehicleV2.Key_Vehicle_linkids.kFetch 
*/
EXPORT getBusVehicle(DATASET(DueDiligence.layouts.Busn_Internal) indata, 
											 Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
											 BIPV2.mod_sources.iParams linkingOptions) := FUNCTION


	busnKeys := DueDiligence.CommonBusiness.GetLinkIDsForKFetch(indata);

	vehicleRaw := VehicleV2.Key_Vehicle_linkids.kFetch(busnKeys, 
                                                      Business_Risk_BIP.Common.SetLinkSearchLevel(options.LinkSearchLevel),
                                                      0,
                                                      linkingOptions);
																				
	//Add back the Seq numbers
	vehicleRawSeq := DueDiligence.CommonBusiness.AppendSeq(vehicleRaw, indata, FALSE);	
  
	transformVehicles := PROJECT(vehicleRawSeq, TRANSFORM(DueDiligence.LayoutsInternal.VehicleSlimLayout,  
                                                          SELF.licensePlateType := LEFT.reg_license_plate_type_desc;                   
                                                          SELF.registeredState := LEFT.reg_license_state;
                                                          SELF.registeredDate := LEFT.reg_latest_effective_date;
                                                          SELF.titleState :=  IF(LEFT.ttl_number != DueDiligence.Constants.EMPTY, LEFT.state_origin, DueDiligence.Constants.EMPTY);  
                                                          SELF.titleDate := LEFT.ttl_latest_issue_date;
                                                          SELF.nameType := LEFT.orig_name_type;
                                                          SELF.historyFlag := LEFT.history;
                                                          SELF.dateFirstSeen := IF(LEFT.date_first_seen > 0, LEFT.date_first_seen, LEFT.date_vendor_first_reported);
                                                          SELF := LEFT;
                                                          SELF := [];));
                                                          
                                                          
  vehicleSummary := DueDiligence.getSharedVehicle(transformVehicles, options.DPPA_Purpose);   
  
  
  addVehicleDetails := JOIN(indata, vehicleSummary,
                            #EXPAND(DueDiligence.Constants.mac_JOINLinkids_BusInternal()),												
                            TRANSFORM(DueDiligence.Layouts.Busn_Internal, 
                                      SELF.VehicleCount := COUNT(RIGHT.allVehicles);
                                      SELF.VehicleBaseValue := RIGHT.maxBasePrice;
                                      SELF.busVehicle := RIGHT.allVehicles;
                                      SELF := LEFT), 
                            LEFT OUTER,
                            ATMOST(1));
                                                          
                                                          
                                                      
  
  // OUTPUT(CHOOSEN(vehicleRawSeq, 100), NAMED('vehicleRawSeq'));
  // OUTPUT(CHOOSEN(transformVehicles, 100), NAMED('transformVehicles'));
  // OUTPUT(CHOOSEN(vehicleSummary, 100), NAMED('vehicleSummary'));
	
	RETURN addVehicleDetails;
END; 
