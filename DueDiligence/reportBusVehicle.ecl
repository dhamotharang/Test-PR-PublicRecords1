IMPORT Address, BIPV2, Business_Risk_BIP, LN_PropertyV2, MDR, DueDiligence, UT, iesp, Census_Data;

EXPORT reportBusVehicle(DATASET(DueDiligence.layouts.Busn_Internal) UpdateBusnVehicleForAttributeLogic, 
											   DATASET(DueDiligence.LayoutsInternal.VehicleSlimLayout) VehicleCurrentlyOwnedButLimited,
											   boolean DebugMode = FALSE
											   ) := FUNCTION

	 
	 													
	// ------                                                                                    ------
  // ------ create the ChildDataset of Property                                                ------
	// ------                                                                                    ------
	VehicleChildDatasetLayout    := RECORD
	  unsigned2                      seq;                                                        //*  This is the seqence number of the parent  
	  DATASET(iesp.duediligencereport.t_DDRMotorVehicle) VehicleChild;
	END;
	 
	 
	iesp.duediligencereport.t_DDRMotorVehicle   FormatTheListOfVehicle(RECORDOF(VehicleCurrentlyOwnedButLimited) le, Integer VehicleSeq) := TRANSFORM 
                                                 SELF.Sequence                      := VehicleSeq;
 	                                               
																								 SELF.VIN.VIN                       := le.Orig_VIN;  
																								 SELF.Vehicle.Make                  := le.Orig_Make_Desc;   
																	               SELF.Vehicle.Model                 := le.Orig_Model_Desc;  
				                                         SELF                               := [];
																								 END;  
	 
	  
	VehicleChildDataset  :=   
		PROJECT(VehicleCurrentlyOwnedButLimited,
			TRANSFORM(VehicleChildDatasetLayout,
				SELF.seq             := LEFT.VehicleReportData.seq,
				SELF.VehicleChild       := PROJECT(LEFT, FormatTheListOfVehicle(LEFT, COUNTER)))); 
				       
				                                         
	
	 /*  define the TRANSFORM used by the DENORMALIZE FUNCTION                        */  
	  DueDiligence.Layouts.Busn_Internal CreateNestedData(UpdateBusnVehicleForAttributeLogic le, VehicleChildDataset ri, Integer VCount) := TRANSFORM
												          SELF.BusinessReport.BusinessAttributeDetails.EconomicAttributeDataDetails.MotorVehicleOwnership.MotorVehicleCount  := le.VehicleCount,
																	//SELF.BusinessReport.BusinessAttributeDetails.EconomicAttributeDataDetails.PropertyOwnerShip.TaxAssessedValue      := le.PropTaxValue,
																	SELF.BusinessReport.BusinessAttributeDetails.EconomicAttributeDataDetails.MotorVehicleOwnership.MotorVehicles := le.BusinessReport.BusinessAttributeDetails.EconomicAttributeDataDetails.MotorVehicleOwnership.MotorVehicles + ri.VehicleChild;
																	SELF := le;
																	END; 
																	
	 /* perform the DENORMALIZE (join) by Seq #                                        */   															 															
	 UpdateBusnPropertyWithReport := DENORMALIZE(UpdateBusnVehicleForAttributeLogic, VehicleChildDataset,
	                                             LEFT.seq = RIGHT.seq, 
												                       CreateNestedData(Left, Right, Counter));  
		
	
	// ********************
	//   DEBUGGING OUTPUTS
	// *********************
	 
	  IF(DebugMode,     OUTPUT(COUNT  (VehicleCurrentlyOwnedButLimited),         NAMED('HowManyvehiclesCurrentlyOwnedButLimited')));
	 
	  IF(DebugMode,     OUTPUT(CHOOSEN(VehicleChildDataset, 100),  NAMED('VehicleChildDataset')));
	 
	 
		Return UpdateBusnPropertyWithReport;
		
	END;   
	