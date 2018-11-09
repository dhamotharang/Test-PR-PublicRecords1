IMPORT Address, BIPV2, Business_Risk_BIP, LN_PropertyV2, MDR, DueDiligence, SALT28, iesp, VehicleV2, VehicleV2_Services, TopBusiness_Services;


EXPORT getBusVehicle(DATASET(DueDiligence.layouts.Busn_Internal) BusnData, 
											 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,     //***search level options set to SELEID
											 BIPV2.mod_sources.iParams linkingOptions,               //***These are all your DRM, GLBA, DPPA options
											 //ReportIsRequested = TRUE,  
											 boolean DebugMode = FALSE
											 ) := FUNCTION


	BusnKeys    := DueDiligence.Common.GetLinkIDsForKFetch(BusnData);

	
	// --------------- Vehicle Data - Using Business IDs ----------------
	// *** Key fetch to get vehicle_keys from linkids
	// *** Notice, there is no sequence number in this linkid layout 
	// *** like you see in the attributues using the kFETCH2 
	// ------------------------------------------------------------------
	VehicleRaw := VehicleV2.Key_Vehicle_linkids.kFetch(BusnKeys, 
																							Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																							0,
																							linkingOptions);
																				
	// ------                                                                                                               -----	
  // ------ Add our sequence number and History date from the BusnData to the Raw Vehicle records found for this Business ------
	// ------ Set the 3rd parameter to FALSE when using the KFETCH                                                          ------
	// ------                                                                                                                -----	
	VehicleRaw_with_seq := DueDiligence.Common.AppendSeq(VehicleRaw, BusnData, FALSE);	
	
  // ------                                                                                    -----------
  // ------ When this query runs in ARCHIVE MODE the History date on the input contains a date -----------
	// ------ Use this function drop public records that are out of scope for this transaction   -----------
	// ------ If the History date is all 9's essentially no records will be dropped - also known -----------
	// ------ as CURRENT MODE.                                                                   -----------
	// ------                                                                                    -----------
	VehicleRecords := DueDiligence.Common.FilterRecords(VehicleRaw_with_seq, date_first_seen, date_vendor_first_reported);	
	
	
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
				 self.sl_vehicleCount           := 1;  
				 /*  additional detailed data from right (VehicleDetails)  */ 
				 ///self.Orig_name_type            := le.Orig_name_type;  
	       SELF.vehicle_key               := ri.vehicle_key;
				 self.Iteration_Key             := ri.Iteration_Key;  
	      // self.Source_Code               := le.Source_Code;
				 self.Orig_VIN               := ri.orig_vin; 
	       self.Orig_Year              := ri.orig_year; 
	       self.Orig_Make_Code         := ri.orig_make_code;
	       self.Orig_Make_Desc         := ri.orig_make_desc; 
         self.Vina_Price             := (unsigned6)ri.vina_price; 
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
																	LEFT OUTER);
																	
	// ------                                       -----																
	// ------   Sort records here                   -----
	// ------                                       -----
	Vehicles_sorted :=  sort(VehicleSlim, VehicleReportData.ultid, VehicleReportData.orgid, VehicleReportData.seleid, vehicle_key, vina_price);                                                    
																										
	// ------                                      -----
	// ------   Remove duplicates records here     -----
	// ------                                      -----
	
	DueDiligence.LayoutsInternal.VehicleSlimLayout  GetTheBestMakeYearModel(RECORDOF(Vehicles_sorted) bestleft, RECORDOF(Vehicles_sorted) bestright) := TRANSFORM
	                                          self.VehicleReportData.ultid              := bestleft.VehicleReportData.ultid;
	                                          self.VehicleReportData.orgid              := bestleft.VehicleReportData.orgid;
	                                          self.VehicleReportData.seleid             := bestleft.VehicleReportData.seleid;
	                                          SELF.vehicle_key        := bestleft.vehicle_key;
				                                    self.Iteration_Key      := bestleft.Iteration_Key;  
	                                          self.Source_Code        := bestleft.Source_Code;
	                                          SELF.sl_vehicleCount    := bestleft.sl_vehicleCount;
																						SELF.historyDateYYYYMMDD := bestleft.historyDateYYYYMMDD;
																						self.Orig_name_type      := bestleft.Orig_name_type;
																						/*  grab the most expensive priced vehicle */  
																            SELF.Vina_Price         :=  IF(bestleft.Vina_Price >= bestright.Vina_Price, bestleft.Vina_Price, bestright.Vina_Price);
																            /*  try and get the most information about the Make Model and Year   */  
																            SELF.Orig_Year          :=  IF(bestright.Orig_Year != '', bestright.Orig_Year, bestleft.Orig_Year);
																            SELF.Orig_Make_Code     :=  IF(bestright.Orig_Make_Code != '', bestright.Orig_Make_Code, bestleft.Orig_Make_Code);
																            SELF.Orig_Make_Desc     :=  IF(bestright.Orig_Make_Desc != '', bestright.Orig_Make_Desc, bestleft.Orig_Make_Desc);
																						self := [];
																						END;  
	BusVehicleUnique := rollup(Vehicles_sorted,
											 LEFT.VehicleReportData.ultid   = RIGHT.VehicleReportData.ultid AND
											 LEFT.VehicleReportData.orgid   = RIGHT.VehicleReportData.orgid AND
											 LEFT.VehicleReportData.seleid  = RIGHT.VehicleReportData.seleid AND
											 LEFT.vehicle_key = RIGHT.vehicle_key,  
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
	VehiclesCurrentlyOwnedButLimited   := dedup(sort(BusVehicleUnique,  VehicleReportData.seleID, -Vina_Price), VehicleReportData.seleid,  KEEP(iesp.constants.DDRAttributesConst.MaxAssets)); 
  
	//UpdateBusnVehicleWithReport  := UpdateBusnPropertyForAttributeLogic; 
	UpdateBusnVehicleWithReport  := DueDiligence.reportBusVehicle(UpdateBusnVehicleForAttributeLogic,
	                                                                VehiclesCurrentlyOwnedButLimited,
	 																																DebugMode);   
	 																				

 IF(DebugMode,     OUTPUT(CHOOSEN(VehicleRaw, 100),                       NAMED('Step1VehicleRaw')));
 IF(DebugMode,     OUTPUT(COUNT  (VehicleRaw),                            NAMED('Step1')));
 
 IF(DebugMode,     OUTPUT(CHOOSEN(VehiclesSelectedForThisBusiness, 100),  NAMED('Step2VehiclesSelectedForThisBusiness')));
 IF(DebugMode,     OUTPUT(COUNT  (VehiclesSelectedForThisBusiness),       NAMED('Step2')));
 
 
 IF(DebugMode,     OUTPUT(CHOOSEN(VehicleSlim, 100),                      NAMED('Step3VehicleDetails')));  
 IF(DebugMode,     OUTPUT(COUNT  (VehicleSlim),                           NAMED('Step3')));
 
 IF(DebugMode,     OUTPUT(CHOOSEN(Vehicles_sorted, 100),                  NAMED('Step4VehicleSorted')));  
 IF(DebugMode,     OUTPUT(COUNT  (Vehicles_sorted),                       NAMED('Step4')));
 
 IF(DebugMode,     OUTPUT(CHOOSEN(BusVehicleUnique, 100),                 NAMED('Step5VehicleUnique')));  
 IF(DebugMode,     OUTPUT(COUNT  (BusVehicleUnique),                      NAMED('Step5')));
 
 IF(DebugMode,      OUTPUT(SummaryCurrentVehicle,                         NAMED('Step6SummaryVehicle')));   
   
 
 //UpdateBusnVehicleWithReport   := Update_BusnVehicle;  
	
	RETURN UpdateBusnVehicleWithReport;
END; 
