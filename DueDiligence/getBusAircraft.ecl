IMPORT BIPV2, Business_Risk_BIP, FAA, MDR, Risk_Indicators, STD, UT, Watercraft;

/*
	Following Keys being used:
			FAA.Key_Aircraft_LinkIDs.kFetch2
*/
EXPORT getBusAircraft(DATASET(DueDiligence.layouts.Busn_Internal) inData, 
											Business_Risk_BIP.LIB_Business_Shell_LIBIN Options) := FUNCTION
	
  
  
  //FAA - Aircraft Records
	aircraftRaw := FAA.Key_Aircraft_LinkIDs.kFetch2(DueDiligence.CommonBusiness.GetLinkIDs(inData),
																						 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses);
																							
	
	//Add our sequence number to the avaiation records found for this Business
	aircraftRawWithSeq := DueDiligence.CommonBusiness.AppendSeq(aircraftRaw, inData, TRUE);
  
  
  aircraftDetails := PROJECT(aircraftRawWithSeq, TRANSFORM(DueDiligence.LayoutsInternal.AircraftSlimLayout,
                                                            SELF.seq := LEFT.seq;
                                                            SELF.ultID := LEFT.ultID;
                                                            SELF.orgID := LEFT.orgID;
                                                            SELF.seleID := LEFT.seleID;
                                                            
                                                            SELF.historyDate := LEFT.historyDate;
                                                            
                                                            SELF.year := LEFT.year_mfr;
                                                            SELF.make := LEFT.aircraft_mfr_name;
                                                            SELF.model := LEFT.model_name;
                                                            SELF.vin := LEFT.serial_number;
                                                            
                                                            SELF.tailNumber := LEFT.n_number;
                                                            SELF.registrationDate := LEFT.cert_issue_date;
                                                            SELF.manufactureModelCode := LEFT.mfr_mdl_code;
                                                            
                                                            SELF.dateFirstSeen := (UNSIGNED)LEFT.date_first_seen;
                                                            SELF.dateLastSeen := (UNSIGNED)LEFT.date_last_seen;
                                                            
                                                            SELF.statusFlag := LEFT.current_flag;
                                                            
                                                            SELF := [];));
                                                            
                                                            
  sharedData := DueDiligence.getSharedAircraft(aircraftDetails); 
  
  
  addAircraft := JOIN(inData, sharedData,
                      #EXPAND(DueDiligence.Constants.mac_JOINLinkids_BusInternal()),												
                      TRANSFORM(DueDiligence.Layouts.Busn_Internal, 
                                SELF.AircraftCount := COUNT(RIGHT.aircraft);
                                SELF.busAircraft := RIGHT.aircraft;
                                SELF := LEFT;),
                      LEFT OUTER);

							
 
 
	// ********************
	//   DEBUGGING OUTPUTS
	// *********************
  // OUTPUT(aircraftRaw, NAMED('aircraftRaw'));
  // OUTPUT(aircraftRawWithSeq, NAMED('aircraftRawWithSeq'));
  // OUTPUT(aircraftDetails, NAMED('aircraftDetails'));
  // OUTPUT(sharedData, NAMED('sharedData'));
  // OUTPUT(addAircraft, NAMED('addAircraft'));
	
	
	RETURN addAircraft;
END;