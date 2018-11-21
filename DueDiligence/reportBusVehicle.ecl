IMPORT DueDiligence;

EXPORT reportBusVehicle(DATASET(DueDiligence.layouts.Busn_Internal) inData) := FUNCTION

    //extract all of the vehicles for each business and create a DATASET of vehicles for each unique identifier (Ult, Org, Sele)
    extractVehicles := PROJECT(inData, TRANSFORM(DueDiligence.LayoutsInternal.SharedVehicleSlim,
                                                     SELF.seq := LEFT.seq;
                                                     SELF.ultID := LEFT.Busn_info.BIP_IDS.UltID.LinkID;
                                                     SELF.orgID := LEFT.Busn_info.BIP_IDS.OrgID.LinkID;
                                                     SELF.seleID := LEFT.Busn_info.BIP_IDS.SeleID.LinkID;    
                                                     SELF.allVehicles := LEFT.busVehicle;
                                                     SELF := [];));
                                           
                                           
    //call this routine to produce a normalized structure  
    sharedReportVehicleData := DueDiligence.reportSharedVehicle(extractVehicles);  
    
    
    // add formatted report data to the report
    addVehicleToReport := JOIN(inData, sharedReportVehicleData,
                                #EXPAND(DueDiligence.Constants.mac_JOINLinkids_BusInternal()),
                                TRANSFORM(DueDiligence.Layouts.Busn_Internal,
                                          SELF.BusinessReport.BusinessAttributeDetails.Economic.MotorVehicle.MotorVehicles := RIGHT.motorVehicles;
                                          SELF.BusinessReport.BusinessAttributeDetails.Economic.MotorVehicle.MotorVehicleCount := LEFT.vehicleCount;
                                          SELF := LEFT;),
                                LEFT OUTER,
                                ATMOST(1));
    
    
    
    // OUTPUT(extractVehicles, NAMED('extractVehicles'));
    // OUTPUT(sharedReportVehicleData, NAMED('sharedReportVehicleData'));
    // OUTPUT(addVehicleToReport, NAMED('addVehicleToReport'));

    RETURN addVehicleToReport;
		
END;   
	