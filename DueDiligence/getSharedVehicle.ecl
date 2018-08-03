
IMPORT BIPv2, DueDiligence, LN_PropertyV2;

/*
	Following Keys being used:
			 
*/
EXPORT getSharedVehicle(DATASET(DueDiligence.LayoutsInternal.VehicleSlimLayout) inVehicleData) := FUNCTION


  // ------                                       -----																
	// ------   Sort records here                   -----
	// ------                                       -----
	Vehicles_sorted :=  sort(inVehicleData, VehicleReportData.seq, VehicleReportData.ultid, VehicleReportData.orgid, VehicleReportData.seleid, VehicleReportData.did, Orig_VIN, vehicle_key,  vina_price);                                                    
																										
	// ------                                      -----
	// ------   Remove duplicates records here     -----
	// ------                                      -----


  DueDiligence.LayoutsInternal.VehicleSlimLayout  GetTheBestMakeYearModel(RECORDOF(Vehicles_sorted) bestleft, RECORDOF(Vehicles_sorted) bestright) := TRANSFORM
	                                          self.VehicleReportData.ultid              := bestleft.VehicleReportData.ultid;
	                                          self.VehicleReportData.orgid              := bestleft.VehicleReportData.orgid;
	                                          self.VehicleReportData.seleid             := bestleft.VehicleReportData.seleid;
																						self.VehicleReportData.did                := bestleft.VehicleReportData.did;
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
                                            
	ListOfVehicleUnique := rollup(Vehicles_sorted,
											 LEFT.VehicleReportData.ultid   = RIGHT.VehicleReportData.ultid AND
											 LEFT.VehicleReportData.orgid   = RIGHT.VehicleReportData.orgid AND
											 LEFT.VehicleReportData.seleid  = RIGHT.VehicleReportData.seleid AND
                       LEFT.VehicleReportData.did     = RIGHT.VehicleReportData.did    AND
                       LEFT.VehicleReportData.seq     = RIGHT.VehicleReportData.seq    AND
											 (LEFT.vehicle_key                = RIGHT.vehicle_key OR
                        LEFT.Orig_VIN                   = RIGHT.Orig_VIN),
											GetTheBestMakeYearModel(LEFT, RIGHT));   
	
  ConvertVehicleListToDATASET := PROJECT(ListOfVehicleUnique, TRANSFORM(DueDiligence.LayoutsInternal.SharedVehicleSlim,
                                                  SELF.ultid       := LEFT.VehicleReportData.ultid;
                                                  SELF.orgid       := LEFT.VehicleReportData.orgid;
                                                  SELF.seleid      := LEFT.VehicleReportData.seleid;
                                                  SELF.did         := LEFT.VehicleReportData.did;
                                                  SELF.seq         := LEFT.VehicleReportData.seq;
                                                  SELF.proxid      := 0;
                                                  SELF.powid       := 0;  
                                                  SELF.allVehicles := DATASET([TRANSFORM(DueDiligence.Layouts.VehicleDataLayout, SELF := LEFT; SELF := [];)]);
                                                  SELF.totalVehicleCount := 1;
                                                  SELF.maxBasePrice := LEFT.Vina_Price;
                                                  SELF := LEFT;));   
  
	// ------                                                                     -----
	// ------   ROLLUP the number vehicles left in the list of unique vehicles    -----
	// ------    to create a single row of vehicle information for each unique id -----
	// ------                        -----
	SummaryCurrentVehicle := rollup(ConvertVehicleListToDATASET,
											 LEFT.ultid   = RIGHT.ultid AND
											 LEFT.orgid   = RIGHT.orgid AND
											 LEFT.seleid  = RIGHT.seleid AND
                       LEFT.did     = RIGHT.did   AND
                       LEFT.seq     = RIGHT.seq, 
											 TRANSFORM(DueDiligence.LayoutsInternal.SharedVehicleSlim,
                                SELF.allVehicles          :=  LEFT.allVehicles + RIGHT.allVehicles;
											          SELF.totalvehicleCount    :=  LEFT.totalVehicleCount + RIGHT.totalVehicleCount;  
																/*  grab the most expensive priced vehicle */  
																SELF.maxBasePrice         :=  MAX(LEFT.maxBasePrice, RIGHT.maxBasePrice),
																SELF                      :=  LEFT));   
                                
                                
                                
     // OUTPUT(Vehicles_sorted,       NAMED('Vehicles_sorted'));
     // OUTPUT(ListOfVehicleUnique,   NAMED('ListOfVehicleUnique'));
     // OUTPUT(SummaryCurrentVehicle, NAMED('SummaryCurrentVehicle'));


    RETURN SummaryCurrentVehicle;
END;
																