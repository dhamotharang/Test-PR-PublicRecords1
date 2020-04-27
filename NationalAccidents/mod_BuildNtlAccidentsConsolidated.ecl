EXPORT mod_BuildNtlAccidentsConsolidated := MODULE
	
  EXPORT AllCruOrders := iAllCruOrders + Files_NAccidentsInquiry.DS_BASE_ALL_CRU_ORDERS;
	
  EXPORT AllResult := iResult + Files_NAccidentsInquiry.DS_BASE_RESULT;
																					
  EXPORT AllVehicleIncident := iVehicleIncident + Files_NAccidentsInquiry.DS_BASE_VEHICLE_INCIDENT;
																						
  EXPORT AllVehicle := iVehicle + Files_NAccidentsInquiry.DS_BASE_VEHICLE;																		
	
  EXPORT AllVehicleInscr := iVehicleInscr + Files_NAccidentsInquiry.DS_BASE_VEHICLE_INSCR;
	
  EXPORT AllVehicleParty := iVehicleParty + Files_NAccidentsInquiry.DS_BASE_VEHICLE_PARTY;
	
  EXPORT AllClient := iClient + Files_NAccidentsInquiry.DS_BASE_CLIENT;	
	
  //###########################################################################
  // Module to Consolidate NTL Accidents Inquiry Data
  //###########################################################################													 
  SHARED modMapNtlAccidentsInquiryBase := mod_MapNtlAccidentsInquiryBase(AllCruOrders, AllResult, AllVehicleIncident, AllClient);

  //###########################################################################
  //Consolidate input files to one common layout and build Ntl Accidents Base.
  //###########################################################################
  EXPORT NtlAccidentsBase := modMapNtlAccidentsInquiryBase.fn_NtlAccidents(AllVehicle, AllVehicleParty, AllVehicleInscr);

  //############################################################################	
  //Consolidate input files to one common layout and build Ntl CRU Inquiry Base.
  //############################################################################
  EXPORT NtlCruInquiryBase := modMapNtlAccidentsInquiryBase.fn_CruInquiry();
	
END;