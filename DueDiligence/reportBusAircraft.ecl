IMPORT BIPv2, codes, DueDiligence, faa, iesp, STD;


/*
	Following Keys being used:
			faa.key_aircraft_info()
*/
EXPORT reportBusAircraft(DATASET(DueDiligence.layouts.Busn_Internal) inData) := FUNCTION


    //pull aircraft data from the inquired  
    sharedAir := NORMALIZE(inData, LEFT.busAircraft, TRANSFORM(DueDiligence.LayoutsInternalReport.SharedAircraftLayout,
                                                                SELF.seq := LEFT.seq;
                                                                SELF.ultID := LEFT.Busn_info.BIP_IDS.UltID.LinkID;
                                                                SELF.orgID := LEFT.Busn_info.BIP_IDS.OrgID.LinkID;
                                                                SELF.seleID := LEFT.Busn_info.BIP_IDS.SeleID.LinkID;
                                                                
                                                                SELF.yearMakeModel.year := RIGHT.year;
                                                                SELF.yearMakeModel.make := RIGHT.make;
                                                                SELF.yearMakeModel.model := RIGHT.model;
                                                                
                                                                SELF.manufactureModelCode := RIGHT.manufactureModelCode;
                                                                
                                                                SELF.tailNumber := RIGHT.tailNumber;
                                                                SELF.aircraft.vin := RIGHT.vin;
                                                                    
                                                                SELF.registrationDate := iesp.ECL2ESP.toDatestring8(RIGHT.registrationDate);
                                                                
                                                                SELF := [];));
                                                                

    sharedDetails := DueDiligence.reportSharedAircraft(sharedAir);
    
    busAir := PROJECT(sharedDetails, TRANSFORM({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, iesp.duediligencebusinessreport.t_DDRBusinessAircraftOwnership},
                                                SELF.Aircrafts := DATASET([TRANSFORM(iesp.duediligenceshared.t_DDRAircraft, SELF := LEFT;)]);
                                                SELF := LEFT;
                                                SELF := [];));
                                                
    
    //roll up aircraft per business
    sortAir := SORT(busAir, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));
    rollAir := ROLLUP(sortAir,
                      #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()),
                      TRANSFORM(RECORDOF(LEFT),
                                SELF.Aircrafts := LEFT.Aircrafts + RIGHT.Aircrafts;
                                SELF := LEFT;));


    addAircraftToReport := JOIN(inData, rollAir,
                                #EXPAND(DueDiligence.Constants.mac_JOINLinkids_BusInternal()),
                                TRANSFORM(DueDiligence.layouts.Busn_Internal,
                                          SELF.BusinessReport.BusinessAttributeDetails.Economic.Aircraft.AircraftCount := COUNT(RIGHT.Aircrafts);
                                          SELF.BusinessReport.BusinessAttributeDetails.Economic.Aircraft.Aircrafts := RIGHT.Aircrafts;
                                          SELF := LEFT;),
                                LEFT OUTER,
                                ATMOST(1));
												





	// OUTPUT(sharedAir, NAMED('sharedAir'));
	// OUTPUT(sharedDetails, NAMED('sharedDetails'));
	// OUTPUT(rollAir, NAMED('rollAir'));
	// OUTPUT(addAircraftToReport, NAMED('addAircraftToReport'));
	
	
	RETURN addAircraftToReport;

END;   