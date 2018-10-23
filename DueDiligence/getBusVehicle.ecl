IMPORT Address, BIPV2, Business_Risk_BIP, MDR, DueDiligence, SALT28, iesp, VehicleV2, VehicleV2_Services, TopBusiness_Services, STD;


EXPORT getBusVehicle(DATASET(DueDiligence.layouts.Busn_Internal) BusnData, 
											 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,     //***search level options set to SELEID
											 BIPV2.mod_sources.iParams linkingOptions,               //***These are all your DRM, GLBA, DPPA options
											 boolean ReportIsRequested = FALSE,  
											 boolean DebugMode = FALSE
											 ) := FUNCTION


	BusnKeys    := DueDiligence.CommonBusiness.GetLinkIDsForKFetch(BusnData);

	
	// --------------- Vehicle Data - Using Business IDs ----------------
	// *** Key fetch to get vehicle_keys from linkids
	// *** Notice, there is no sequence number in this linkid layout 
	// *** like you see in the attributues using the kFETCH2 
	// *** DPPA must be set to a value of 3 to get vehicle data 
	// ------------------------------------------------------------------
	VehicleRaw := VehicleV2.Key_Vehicle_linkids.kFetch(BusnKeys, 
																							Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																							0,
																							linkingOptions);
																				
	// ------                                                                                                               -----	
  // ------ Add our sequence number and History date from the BusnData to the Raw Vehicle records found for this Business ------
	// ------ Set the 3rd parameter to FALSE when using the KFETCH                                                          ------
	// ------                                                                                                                -----	
	VehicleRaw_with_seq := DueDiligence.CommonBusiness.AppendSeq(VehicleRaw, BusnData, FALSE);	
	
	//Clean dates used in logic and/or attribute levels here so all comparisions flow through consistently
	vehicleCleanDates := DueDiligence.Common.CleanDatasetDateFields(VehicleRaw_with_seq, 'date_first_seen, date_vendor_first_reported');
	
  // ------                                                                                    -----------
  // ------ When this query runs in ARCHIVE MODE the History date on the input contains a date -----------
	// ------ Use this function drop public records that are out of scope for this transaction   -----------
	// ------ If the History date is all 9's essentially no records will be dropped - also known -----------
	// ------ as CURRENT MODE.                                                                   -----------
	// ------                                                                                    -----------
	VehicleRecords := DueDiligence.Common.FilterRecords(vehicleCleanDates, date_first_seen, date_vendor_first_reported);	
	
	
	// ------                                                                                   -----																
	// ------   Select Owner(type=1), Registrant(type=4) or Lessor(type=2) records              -----
	// ------                                                                                   -----
	VehiclesSelectedForThisBusiness := VehicleRecords(orig_name_type = Constants.VEH_OWNER 
	                                               OR orig_name_type = Constants.VEH_REGISTRANT
																					       OR orig_name_type = Constants.VEH_LESSOR); 
																						 
	// ------                                                         -----																					 
	// ------ Get the vehicle details from the vehicle Main Key      -----
	// ------                                                         -----	
	          																			 
	VehicleDetails       := VehicleV2.Key_Vehicle_Main_Key;          																			 
  // ------                              ------------
  // ------ Define the TRANSFORM here    ------------
	 // ------ We are formatting the Vehicle -----------
	 // ------ Slim result set here         ------------
	 // ------ These are all the intermediate ----------
	 // ------ fields needed for the         -----------
	 // ------ attribute or the report      ------------
  // ------                              ------------
	DueDiligence.LayoutsInternal.VehicleSlimLayout  getVehicleDetails(RECORDOF(VehiclesSelectedForThisBusiness) le, RECORDOF(VehicleDetails) ri, integer internal_seq) := TRANSFORM
	       /*  data from left  (VehiclesSelectedForThisBusiness) */  
	       SELF.VehicleReportData.seq    := le.Seq,
				 SELF.VehicleReportData.ultID  := le.ultID,
				 SELF.VehicleReportData.orgID  := le.orgID,
				 SELF.VehicleReportData.seleID := le.seleID,
				 SELF.VehicleReportData.proxID := le.proxID,
				 SELF.VehicleReportData.powID  := le.powID,
				 
				 self.historyDateYYYYMMDD       := le.HistoryDate;
				 self.license_Plate_Type        := le.reg_license_plate_type_desc;                  //*** vehiclev2 LinkID's 
				 SELF.Registered_State          := le.reg_license_state;
				 
				 SELF.Registered_Year           := (integer)le.reg_latest_effective_date[1..4];
				 SELF.Registered_Month          := (integer)le.reg_latest_effective_date[5..6];
				 SELF.Registered_Day            := (integer)le.reg_latest_effective_date[7..8];
         
				 SELF.Title_State               :=  IF(le.ttl_number != '', le.state_origin, '');  
				 SELF.Title_Year                := (integer)le.ttl_latest_issue_date[1..4];
				 SELF.Title_Month               := (integer)le.ttl_latest_issue_date[5..6];
				 SELF.Title_Day                 := (integer)le.ttl_latest_issue_date[7..8];
				 
				 
				 self.sl_vehicleCount           := 1;  
				 /*  additional detailed data from right (VehicleDetails)  */ 
				 //self.Orig_name_type            := le.Orig_name_type;  
	       SELF.vehicle_key               := ri.vehicle_key;
				 self.Iteration_Key             := ri.Iteration_Key;  
	      // self.Source_Code               := le.Source_Code;
				 self.Orig_VIN                  := ri.orig_vin; 
	       self.Orig_Year                 := ri.orig_year; 
	       self.Orig_Make_Code            := ri.orig_make_code;
	       self.Orig_Make_Desc            := ri.orig_make_desc; 
         self.Vina_Price                := (unsigned6)ri.vina_price;
			   SELF.Class_Type                := ri.model_class;  
	      self := [];
   END;
	// ------                                                                 ------------
  // ------  JOIN the 2 tables together                                     ------------
	// ------ and format a slim record that contains all the vehicle details  ------------
  // ------                                                                 ------------																		 																			 																																					  
	VehicleSlim   :=   join(VehiclesSelectedForThisBusiness(Vehicle_key != ''),VehicleDetails,
	                        /* Where */  
			                    keyed(left.vehicle_key = right.vehicle_key),
													getVehicleDetails(left,right,counter),
													    ATMOST(1000),
																	LEFT OUTER);
																	
	// ------                                       -----																
	// ------   Sort records here                   -----
	// ------                                       -----
	Vehicles_sorted :=  sort(VehicleSlim, VehicleReportData.seq, VehicleReportData.ultid, VehicleReportData.orgid, VehicleReportData.seleid, Orig_VIN, vehicle_key,  vina_price);                                                    
																										
	// ------                                      -----
	// ------   Remove duplicates records here     -----
	// ------                                      -----
	
	DueDiligence.LayoutsInternal.VehicleSlimLayout  GetTheBestMakeYearModel(RECORDOF(Vehicles_sorted) bestleft, RECORDOF(Vehicles_sorted) bestright) := TRANSFORM
	                                          self.VehicleReportData.ultid              := bestleft.VehicleReportData.ultid;
	                                          self.VehicleReportData.orgid              := bestleft.VehicleReportData.orgid;
	                                          self.VehicleReportData.seleid             := bestleft.VehicleReportData.seleid;
																						self.VehicleReportData.seq                := bestleft.VehicleReportData.seq;
	                                          SELF.vehicle_key                          := bestleft.vehicle_key;
				                                    self.Iteration_Key                        := bestleft.Iteration_Key;  
	                                          self.Source_Code                          := bestleft.Source_Code;
	                                          SELF.sl_vehicleCount                      := bestleft.sl_vehicleCount;
																						SELF.historyDateYYYYMMDD                  := bestleft.historyDateYYYYMMDD;
																						self.Orig_name_type                       := bestleft.Orig_name_type;
																						/*  grab the most expensive priced vehicle */  
																            SELF.Vina_Price         :=  IF(bestleft.Vina_Price >= bestright.Vina_Price, bestleft.Vina_Price, bestright.Vina_Price);
																            /*  try and get the most information about the Make Model and Year   */  
																            SELF.Orig_Year          :=  IF(bestright.Orig_Year != '', bestright.Orig_Year, bestleft.Orig_Year);
																            SELF.Orig_Make_Code     :=  IF(bestright.Orig_Make_Code != '', bestright.Orig_Make_Code, bestleft.Orig_Make_Code);
																            SELF.Orig_Make_Desc     :=  IF(bestright.Orig_Make_Desc != '', bestright.Orig_Make_Desc, bestleft.Orig_Make_Desc);
                                            
                                            SELF.Title_State        :=  IF(bestright.Title_State != '', bestright.Title_State, bestleft.Title_State);
                                            SELF.Title_Year         :=  IF(bestright.Title_Year  != 0, bestright.Title_Year,  bestleft.Title_Year);
                                            SELF.Title_Month        :=  IF(bestright.Title_Month != 0, bestright.Title_Month, bestleft.Title_Month);
                                            SELF.Title_Day          :=  IF(bestright.Title_Day   != 0, bestright.Title_Day,   bestleft.Title_Day);   
                                            /*  take the remainder from the bestleft  */   
																						SELF                    :=  bestleft;  
																						self                    := [];
																						END;  
	BusVehicleUnique := rollup(Vehicles_sorted,
											 LEFT.VehicleReportData.ultid   = RIGHT.VehicleReportData.ultid AND
											 LEFT.VehicleReportData.orgid   = RIGHT.VehicleReportData.orgid AND
											 LEFT.VehicleReportData.seleid  = RIGHT.VehicleReportData.seleid AND
											 (LEFT.vehicle_key                = RIGHT.vehicle_key OR
                        LEFT.Orig_VIN                   = RIGHT.Orig_VIN),
											GetTheBestMakeYearModel(LEFT, RIGHT));   
																															
	// ------                                                                     -----
	// ------   ROLLUP the number vehicles left in the list of unique vehicles    -----
	// ------    to create a single row of vehicle information for each business  -----
	// ------     all while continuing use the VehicleSlimLayout                  -----
	SummaryCurrentVehicle := rollup(BusVehicleunique,
											 LEFT.VehicleReportData.ultid   = RIGHT.VehicleReportData.ultid AND
											 LEFT.VehicleReportData.orgid   = RIGHT.VehicleReportData.orgid AND
											 LEFT.VehicleReportData.seleid  = RIGHT.VehicleReportData.seleid,			
											 TRANSFORM(DueDiligence.LayoutsInternal.VehicleSlimLayout,
											          SELF.sl_vehicleCount    :=  LEFT.sl_vehicleCount + RIGHT.sl_vehicleCount;  
																/*  grab the most expensive priced vehicle */  
																SELF.Vina_Price         :=  IF(LEFT.Vina_Price >= RIGHT.Vina_Price, LEFT.Vina_Price, RIGHT.Vina_Price),
																SELF                    :=  LEFT));   
																
	// ------                                                                     -----
	// ------   Join the vehicles information to the Business internal record     -----
	// ------                                                                     -----
	UpdateBusnVehicleForAttributeLogic := JOIN(BusnData, SummaryCurrentVehicle,
												LEFT.Busn_info.BIP_IDS.UltID.LinkID  = RIGHT.VehicleReportData.ultID AND
												LEFT.Busn_info.BIP_IDS.OrgID.LinkID  = RIGHT.VehicleReportData.orgID AND
												LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.VehicleReportData.seleID,												
												TRANSFORM(DueDiligence.Layouts.Busn_Internal, 
																	SELF.VehicleCount          := RIGHT.sl_vehicleCount,
																	SELF.VehicleBaseValue      := RIGHT.Vina_Price,                 
																	SELF := LEFT), 
																	LEFT OUTER);
 	 
  
  
   // ------                                                                                    ------   
	 // ------ START BUILDING SECTIONS of the REPORT                                              ------ 
	 // ------                                                                                    ------ 
	 // ------ Limit the number of records for each business listed in the report                 ------
	 // ------ Start by sorting them in seleid sequence and getting the base value with the       ------
	 // ------ highest value at the top                                                           ------
	 // ------                                                                                    ------
	 // ------                                                                                    ------
	VehiclesCurrentlyOwnedButLimited   := dedup(sort(BusVehicleUnique,  VehicleReportData.seleID, -Vina_Price), VehicleReportData.seleid,  KEEP(iesp.constants.DDRAttributesConst.MaxVehicles)); 
  
  // -----                                                                                     ----- 
	 // ----- If the report is requested by the XML Service (not allowed by Batch)                -----
	 // ----- THEN add the vehicle data to that section of the report.                            -----
	 // ----- ELSE just leave the reporting sections empty                                        -----
	 // -----                                                                                     -----
	UpdateBusnVehicleWithReport  := IF(ReportIsRequested, 
	                                     DueDiligence.reportBusVehicle(UpdateBusnVehicleForAttributeLogic, VehiclesCurrentlyOwnedButLimited, DebugMode),
																			             /* ELSE */ 
																			                   UpdateBusnVehicleForAttributeLogic); 
	
																				
 // IF(DebugMode,     OUTPUT(CHOOSEN(VehicleRaw, 10),                        NAMED('Step1VehicleRaw')));
 // IF(DebugMode,     OUTPUT(COUNT  (VehicleRaw),                            NAMED('Step1')));
 
 // IF(DebugMode,     OUTPUT(CHOOSEN(VehiclesSelectedForThisBusiness, 10),  NAMED('Step2VehiclesSelectedForThisBusiness')));
 // IF(DebugMode,     OUTPUT(COUNT  (VehiclesSelectedForThisBusiness),       NAMED('Step2')));
 
 
 // IF(DebugMode,     OUTPUT(CHOOSEN(VehicleSlim, 10),                      NAMED('Step3VehicleDetails')));  
 // IF(DebugMode,     OUTPUT(COUNT  (VehicleSlim),                           NAMED('Step3')));
 
 // IF(DebugMode,     OUTPUT(CHOOSEN(Vehicles_sorted, 20),                  NAMED('Step4VehicleSorted')));  
 // IF(DebugMode,     OUTPUT(COUNT  (Vehicles_sorted),                       NAMED('Step4')));
 
 // IF(DebugMode,     OUTPUT(CHOOSEN(BusVehicleUnique, 20),                 NAMED('Step5VehicleUnique')));  
 // IF(DebugMode,     OUTPUT(COUNT  (BusVehicleUnique),                      NAMED('Step5')));
 
 IF(DebugMode,      OUTPUT(SummaryCurrentVehicle,                         NAMED('Step6SummaryVehicle')));   
   
	
	RETURN UpdateBusnVehicleWithReport;
END; 
