IMPORT BIPV2, Business_Risk_BIP, iesp, DueDiligence;

EXPORT getBusReport(DATASET(DueDiligence.layouts.Busn_Internal) BusnData, 
                            Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
                            BIPV2.mod_sources.iParams linkingOptions,
                            string6 DD_SSNMask,
													  boolean DebugMode = FALSE
											      ) := FUNCTION
													 

	UpdateBusnExecCriminalWithReport  := DueDiligence.reportBusExecCriminal(BusnData, DD_SSNMask, DebugMode);

		
  //***This section is for Operating Locations  ***//
	AddOperatingLocToReport    :=  DueDiligence.reportBusOperLocations(UpdateBusnExecCriminalWithReport, DebugMode);

	//***This section is for Operating Information  ***//
	AddOperatingInfoToReport   :=  DueDiligence.reportBusOperatingInformation(AddOperatingLocToReport, DebugMode);
	
  //***This section is for Registered Agents  ***//	
  addRegisteredAgents        := DueDiligence.reportBusRegisteredAgents(AddOperatingInfoToReport, options, linkingOptions);
  
  //***This section is for Best Business Information ***//	
  addBestData                := DueDiligence.reportBusBestInfo(addRegisteredAgents);   	
  
  //***This section is for Business Executives ***//
  addExecutives              := DueDiligence.reportBusExecs(addBestData, options, linkingOptions);
  
  //***This section is for Shell Shelf Information ***//
  addShellShelf              := DueDiligence.reportBusShellShelf(addExecutives);
  
  //***This section is for Property ***//
  addProperty              := DueDiligence.reportBusProperty(addShellShelf);
 
																													
													 
	// ********************
	//   DEBUGGING OUTPUTS
	// *********************

	// *********************

	  // IF(DebugMode,      OUTPUT(CHOOSEN(UpdateBusnExecCriminalWithReport, 50),   NAMED('UpdateBusnExecCriminalWithReport')));		
   	// IF(DebugMode,      OUTPUT(CHOOSEN(AddOperatingLocToReport, 50),     NAMED('AddOperatingLocToReportout')));		
   	// IF(DebugMode,      OUTPUT(CHOOSEN(AddOperatingInfoToReport, 50),     NAMED('AddOperatingInfoToReport')));		
   	// IF(DebugMode,      OUTPUT(CHOOSEN(addBestData, 50),                NAMED('addBestData')));		
   	// IF(DebugMode,      OUTPUT(CHOOSEN(addShellShelf, 50),                NAMED('addShellShelf')));		
    
    
  // OUTPUT(addBestData, NAMED('addBestData'));  
  // OUTPUT(addExecutives, NAMED('addExecutives'));  


	RETURN addProperty;
END;
