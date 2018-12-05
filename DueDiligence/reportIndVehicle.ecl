IMPORT DueDiligence, UT, iesp;

EXPORT reportIndVehicle(DATASET(DueDiligence.Layouts.Indv_Internal) inData) := FUNCTION
    
    
    //Extract all of the vehicles for each individual and create a DATASET of vehicles for each unique identifier (DID)
    ExtractIndVehicles := PROJECT(inData, TRANSFORM(DueDiligence.LayoutsInternal.SharedVehicleSlim,
                                           SELF.seq := LEFT.seq;
                                           SELF.did := LEFT.inquiredDID;
                                           //this is our DATASET of vehicles  
                                           SELF.allVehicles := LEFT.perVehicle;
                                           SELF             := [];));
                                           
                                           
    //Call this routine to produce a normalized structure  
    sharedReportVehicleData := DueDiligence.reportSharedVehicle(ExtractIndVehicles);  

    
    //add formatted report data to the report and pass this result set back to the calling routine
    addVehicleToReport := JOIN(inData, sharedReportVehicleData,
                                  LEFT.seq = RIGHT.seq AND
                                  LEFT.inquiredDID = RIGHT.did,
                                  TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                            SELF.PersonReport.PersonAttributeDetails.Economic.Vehicle.MotorVehicles := RIGHT.MotorVehicles;
                                            SELF := LEFT;),
                                  LEFT OUTER,
                                  ATMOST(1));
  
  

	// ********************
	//   DEBUGGING OUTPUTS
	// *********************

 // OUTPUT(ExtractIndVehicles,       NAMED('ExtractIndVehicles'));
 // OUTPUT(sharedReportVehicleData,  NAMED('sharedReportVehicleData'));
 // OUTPUT(reportVehicle,            NAMED('reportVehicle'));
 // OUTPUT(rollReportVehicle,        NAMED('rollReportVehicle'));
 // OUTPUT(addVehicleToReport,       NAMED('addVehicleToReport'));
 
  Return addVehicleToReport;
		
	END;   
	