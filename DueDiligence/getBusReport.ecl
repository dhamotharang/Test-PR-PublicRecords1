IMPORT iesp, DueDiligence;

EXPORT getBusReport(DATASET(DueDiligence.layouts.Busn_Internal) BusnData, 
											   //Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
													 //BOOLEAN includeReportData,
													 boolean DebugMode = FALSE
											     ) := FUNCTION
													 
													 
		
 //***This section is for Operating Locations  ***//
	AddOperatingLocToReport   :=  DueDiligence.reportBusOperLocations(BusnData);
	
	//***This section is for Operating Information  ***//
	AddOperatingInfoToReport   :=  DueDiligence.reportBusOperatingInformation(AddOperatingLocToReport, DebugMode);

																													
													 
	// ********************
	//   DEBUGGING OUTPUTS
	// *********************

	    //IF(DebugMode,      OUTPUT(ListOfOperatingLocations,                NAMED('ListOfOperatingLocations')));								 
   	// IF(DebugMode,      OUTPUT(CHOOSEN(BusnDataWithOperLocGeoRisk, 100),     NAMED('BusnDataWithOperLocGeoRisk')));												 

	RETURN AddOperatingInfoToReport;
END;