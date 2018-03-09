IMPORT iesp, DueDiligence;

EXPORT getBusReport(DATASET(DueDiligence.layouts.Busn_Internal) BusnData, 
											   //Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
													 //BOOLEAN includeReportData,
													 boolean DebugMode = FALSE
											     ) := FUNCTION
													 


  //UpdateBusnExecsCriminalSection    := DueDiligence.reportBusExecutiveOfficers(BusnData, DebugMode);
	UpdateBusnExecCriminalWithReport  := DueDiligence.reportBusExecCriminal(BusnData, DebugMode);
 													   																			  
    
  //Add the established date to business information
  getEstablishDate := PROJECT(UpdateBusnExecCriminalWithReport, TRANSFORM({DueDiligence.LayoutsInternal.InternalBIPIDsLayout, iesp.share.t_Date estDate},
                                                    SELF.seq := LEFT.seq;
																										SELF.ultID := LEFT.busn_info.BIP_IDs.UltID.LinkID;
																										SELF.orgID := LEFT.busn_info.BIP_IDs.OrgID.LinkID;
																										SELF.seleID := LEFT.busn_info.BIP_IDS.SeleID.LinkID;
                                                    
                                                    date := IF(LEFT.sosIncorporationDate > 0, LEFT.sosIncorporationDate, LEFT.dateVendorFirstReported); 
                                                    
                                                    SELF.estDate.year := (UNSIGNED)date[1..4];
                                                    SELF.estDate.month := (UNSIGNED)date[5..6];
                                                    SELF.estDate.day := (UNSIGNED)date[7..8];
                                                    SELF := [];));
                                                    
  addEstablishDate := JOIN(BusnData, getEstablishDate,
                            #EXPAND(DueDiligence.Constants.mac_JOINLinkids_BusInternal()),
                            TRANSFORM(RECORDOF(LEFT),
                                      SELF.businessReport.businessInformation.EstablishedDate := RIGHT.estDate;
                                      SELF := LEFT;));
		
  //***This section is for Operating Locations  ***//
	AddOperatingLocToReport   :=  DueDiligence.reportBusOperLocations(addEstablishDate, DebugMode);

	//***This section is for Operating Information  ***//
	AddOperatingInfoToReport   :=  DueDiligence.reportBusOperatingInformation(AddOperatingLocToReport, DebugMode);
	
  	
																													
													 
	// ********************
	//   DEBUGGING OUTPUTS
	// *********************

	  IF(DebugMode,      OUTPUT(UpdateBusnExecCriminalWithReport,           NAMED('UpdateBusnExecCriminalWithReport')));								 
   	IF(DebugMode,      OUTPUT(CHOOSEN(AddOperatingInfoToReport, 100),     NAMED('AddOperatingInfoToReport')));		
    
    
  // OUTPUT(addEstablishDate, NAMED('addEstablishDate'));  

	RETURN AddOperatingInfoToReport;
END;
