IMPORT BIPV2, Business_Risk_BIP, iesp, DueDiligence;

EXPORT getBusReport(DATASET(DueDiligence.layouts.Busn_Internal) BusnData, 
                    Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
                    BIPV2.mod_sources.iParams linkingOptions,
                    string6 DD_SSNMask) := FUNCTION
													 

	
  //This section is for criminal data on BEOs (Business Executive Officers)
  AddCriminalBEOs  := DueDiligence.reportBusExecCriminal(BusnData, DD_SSNMask);
		
  //This section is for Operating Locations
	AddOperatingLocToReport := DueDiligence.reportBusOperLocations(AddCriminalBEOs);

	//This section is for Operating Information
	AddOperatingInfoToReport := DueDiligence.reportBusOperatingInformation(AddOperatingLocToReport);
	
  //This section is for Registered Agents	
  addRegisteredAgents := DueDiligence.reportBusRegisteredAgents(AddOperatingInfoToReport, options, linkingOptions);
  
  //This section is for Best Business Information 	
  addBestData := DueDiligence.reportBusBestInfo(addRegisteredAgents);   	
  
  //This section is for Business Executives 
  addExecutives := DueDiligence.reportBusExecs(addBestData, options, linkingOptions);
  
  //This section will add Business Executives that were not included in Attribute logic due to the DID not being populated in contacts key 
  addDIDLessExecutives := DueDiligence.reportBusDIDLessExecs(addExecutives);  
  
  //This section is for Shell Shelf Information 
  addShellShelf := DueDiligence.reportBusShellShelf(addDIDLessExecutives);
  
  //This section is for Property 
  addProperty := DueDiligence.reportBusProperty(addShellShelf);
  
  //This section is for Watercraft 
  addWatercraft := DueDiligence.reportBusWatercraft(addProperty);
  
  //This section is for Aircraft 
  addAircraft := DueDiligence.reportBusAircraft(addWatercraft);
  
  //This section is for Vehicle
  addVehicle := DueDiligence.reportBusVehicle(addAircraft);
 
																													
													 
	//DEBUGGING OUTPUTS
    
  // OUTPUT(AddCriminalBEOs, NAMED('AddCriminalBEOs'));  
  // OUTPUT(AddOperatingLocToReport, NAMED('AddOperatingLocToReport'));  
  // OUTPUT(AddOperatingInfoToReport, NAMED('AddOperatingInfoToReport'));  
  // OUTPUT(addRegisteredAgents, NAMED('addRegisteredAgents'));  
  // OUTPUT(addBestData, NAMED('addBestData'));  
  // OUTPUT(addExecutives, NAMED('addExecutives'));  
  // OUTPUT(addShellShelf, NAMED('addShellShelf'));  
  // OUTPUT(addProperty, NAMED('addProperty'));  
  // OUTPUT(addWatercraft, NAMED('addWatercraft'));  
  // OUTPUT(addAircraft, NAMED('addAircraft'));  
  // OUTPUT(addVehicle, NAMED('addVehicle'));  


	RETURN addVehicle;
END;
