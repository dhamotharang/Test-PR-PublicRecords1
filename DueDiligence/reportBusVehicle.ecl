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
	  DATASET(iesp.duediligenceshared.t_DDRMotorVehicle) VehicleChild;
	END;
	 
	 
	iesp.duediligenceshared.t_DDRMotorVehicle   FormatTheListOfVehicle(RECORDOF(VehicleCurrentlyOwnedButLimited) le, Integer VehicleSeq) := TRANSFORM 
         SELF.MotorVehicle.VIN                       := le.Orig_VIN;
         SELF.Vehicle.Year                  := le.Orig_Year;
         SELF.Vehicle.Make                  := le.Orig_Make_Desc;   
         SELF.Vehicle.Model                 := le.Orig_Model_Desc; 
         SELF.LicensePlateType.DetailType   := le.license_Plate_Type;       
         SELF.ClassType.DetailType          := le.Class_Type;               
         SELF.BasePrice                     := le.Vina_Price;
         SELF.Title.State                   := le.Title_State;             
         SELF.Title.Date.Year               := le.Title_Year;               
         SELF.Title.Date.Month              := le.Title_Month;              
         SELF.Title.Date.Day                := le.Title_Day;                
         SELF.Registration.State            := le.Registered_State;
         SELF.Registration.Date.Year        := le.Registered_Year;                    
         SELF.Registration.Date.Month       := le.Registered_Month;                   
         SELF.Registration.Date.Day         := le.Registered_Day;                     
         SELF                               := [];
	END;  
	 
	  
	VehicleChildDataset  :=   
		PROJECT(VehicleCurrentlyOwnedButLimited,
			TRANSFORM(VehicleChildDatasetLayout,
				SELF.seq             := LEFT.VehicleReportData.seq,
				SELF.VehicleChild       := PROJECT(LEFT, FormatTheListOfVehicle(LEFT, COUNTER)))); 
				       
				                                         
	
	 /*  define the TRANSFORM used by the DENORMALIZE FUNCTION                        */  
	  DueDiligence.Layouts.Busn_Internal CreateNestedData(UpdateBusnVehicleForAttributeLogic le, VehicleChildDataset ri, Integer VCount) := TRANSFORM
												          SELF.BusinessReport.BusinessAttributeDetails.Economic.MotorVehicle.MotorVehicleCount  := le.VehicleCount,
																	SELF.BusinessReport.BusinessAttributeDetails.Economic.MotorVehicle.MotorVehicles := le.BusinessReport.BusinessAttributeDetails.Economic.MotorVehicle.MotorVehicles + ri.VehicleChild;
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
	