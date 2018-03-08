IMPORT iesp, DueDiligence;

EXPORT getBusReport(DATASET(DueDiligence.layouts.Busn_Internal) BusnData, 
											   //Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
													 //BOOLEAN includeReportData,
													 boolean DebugMode = FALSE
											     ) := FUNCTION
													 

  //***add logic to populate the Established Date to the Business Information Section of the report
	//***Report established date logic : IF(sosIncorporationDate > 0, sosIncorporationDate, dateVendorFirstReported)
 
	//UpdateBusnExecsCriminalSection    := DueDiligence.reportBusExecutiveOfficers(BusnData, DebugMode);
	UpdateBusnExecCriminalWithReport  := DueDiligence.reportBusExecCriminal(BusnData, DebugMode);
																				   																			  

 //***This section is for Operating Locations  ***//
	AddOperatingLocToReport   :=  DueDiligence.reportBusOperLocations(UpdateBusnExecCriminalWithReport, DebugMode);
	
	//***This section is for Operating Information  ***//
	AddOperatingInfoToReport   :=  DueDiligence.reportBusOperatingInformation(AddOperatingLocToReport, DebugMode);
	
  //AddOperatingInfoToReport  := AddOperatingLocToReport; 
																													
													 
	// ********************
	//   DEBUGGING OUTPUTS
	// *********************

	    //IF(DebugMode,      OUTPUT(ListOfOperatingLocations,                NAMED('ListOfOperatingLocations')));								 
   	IF(DebugMode,      OUTPUT(CHOOSEN(AddOperatingInfoToReport, 100),     NAMED('AddOperatingInfoToReport')));												 

	RETURN AddOperatingInfoToReport;
END;
