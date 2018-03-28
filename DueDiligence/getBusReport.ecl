IMPORT BIPV2, Business_Risk_BIP, iesp, DueDiligence;

EXPORT getBusReport(DATASET(DueDiligence.layouts.Busn_Internal) BusnData, 
                            Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
                            BIPV2.mod_sources.iParams linkingOptions,
                            string6 DD_SSNMask,
													  boolean DebugMode = FALSE
											      ) := FUNCTION
													 

	UpdateBusnExecCriminalWithReport  := DueDiligence.reportBusExecCriminal(BusnData, DD_SSNMask, DebugMode);
 													   																			  
    
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
                                                    
  addEstablishDate := JOIN(UpdateBusnExecCriminalWithReport, getEstablishDate,
                            #EXPAND(DueDiligence.Constants.mac_JOINLinkids_BusInternal()),
                            TRANSFORM(RECORDOF(LEFT),
                                      SELF.businessReport.businessInformation.EstablishedDate := RIGHT.estDate;
                                      SELF := LEFT;),
                            LEFT OUTER);
		
  //***This section is for Operating Locations  ***//
	AddOperatingLocToReport    :=  DueDiligence.reportBusOperLocations(addEstablishDate, DebugMode);

	//***This section is for Operating Information  ***//
	AddOperatingInfoToReport   :=  DueDiligence.reportBusOperatingInformation(AddOperatingLocToReport, DebugMode);
	
  //***This section is for Registered Agents  ***//	
  addRegisteredAgents        := DueDiligence.reportBusRegisteredAgents(AddOperatingInfoToReport, options, linkingOptions);
  
  //***This section is for Best Business Information ***//	
  addReportData              := DueDiligence.reportBestBusInfo(addRegisteredAgents);   	
																													
													 
	// ********************
	//   DEBUGGING OUTPUTS
	// *********************

	// *********************

	  IF(DebugMode,      OUTPUT(UpdateBusnExecCriminalWithReport,           NAMED('UpdateBusnExecCriminalWithReport')));								 
   	IF(DebugMode,      OUTPUT(CHOOSEN(addEstablishDate, 100),             NAMED('AddOperatingLocToReport')));		
   	IF(DebugMode,      OUTPUT(CHOOSEN(AddOperatingLocToReport, 100),     NAMED('AddOperatingLocToReportout')));		
   	IF(DebugMode,      OUTPUT(CHOOSEN(AddOperatingInfoToReport, 100),     NAMED('AddOperatingInfoToReport')));		
   	IF(DebugMode,      OUTPUT(CHOOSEN(addReportData, 100),                NAMED('addReportData')));		
    
    
  // OUTPUT(addEstablishDate, NAMED('addEstablishDate'));  


	RETURN addReportData;
END;
