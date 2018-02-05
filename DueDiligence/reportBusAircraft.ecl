IMPORT BIPv2, codes, DueDiligence, faa, iesp, STD;


/*
	Following Keys being used:
			faa.key_aircraft_info()
*/
EXPORT reportBusAircraft(DATASET(DueDiligence.layouts.Busn_Internal) inData, 
											   DATASET(DueDiligence.LayoutsInternalReport.BusAircraftSlimLayout) aircraftSlim) := FUNCTION


	//grab number of engines and manufacture info
	withEngineCount := JOIN(aircraftSlim, faa.key_aircraft_info(),
									LEFT.manufactureModelCode = RIGHT.code,
									TRANSFORM(DueDiligence.LayoutsInternalReport.BusAircraftSlimLayout,
														SELF.numberOfEngines := (INTEGER)RIGHT.number_of_engines;
														SELF.detailType := RIGHT.type_aircraft;
														SELF := LEFT),
									LEFT OUTER);
									
	//group slimmed dataset by seq and linkIDs so counter can count per grouping
	groupSlim := GROUP(withEngineCount, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));
	
	
	//Transform to limit the number of data in our dataset
	DueDiligence.LayoutsInternalReport.BusAircraftReportChildren getReportChildren(DueDiligence.LayoutsInternalReport.BusAircraftSlimLayout asl, INTEGER c) := TRANSFORM, SKIP(c > iesp.Constants.DDRAttributesConst.MaxAircraft)
		SELF.air := PROJECT(asl, TRANSFORM(iesp.duediligencereport.t_DDRAircraft,
																				SELF.sequence := c;
																				SELF.aircraft := DATASET([TRANSFORM(iesp.duediligencereport.t_DDRYearMakeModel,
																																						SELF.year := LEFT.year;
																																						SELF.make := LEFT.make;
																																						SELF.model := LEFT.model;
																																						SELF := [];)])[1];
																				SELF.numberOfEngines := LEFT.numberOfEngines;
																				SELF.tailNumber := LEFT.tailNumber;
																				SELF._type := DATASET([TRANSFORM(iesp.duediligencereport.t_DDRAdditionalDetails,
																																					SELF.detailType := STD.Str.ToUpperCase(codes.FAA_AIRCRAFT_REF.TYPE_AIRCRAFT(LEFT.detailType));
																																					SELF := [];)])[1];
																				SELF.vin := DATASET([TRANSFORM(iesp.duediligencereport.t_DDRVINNumber,
																																				SELF.vin := LEFT.vin;
																																				SELF := [];)])[1];
																				SELF.registrationDate := DATASET([TRANSFORM(iesp.share.t_Date,
																																																																SELF.year := (UNSIGNED)LEFT.registrationDate[1..4];
																																																																SELF.month := (UNSIGNED)LEFT.registrationDate[5..6];
																																																																SELF.day := (UNSIGNED)LEFT.registrationDate[7..8];
																																																																SELF := [];)])[1];
																				SELF := LEFT;
																				SELF := [];));
		SELF := asl;
	END;
														
	//convert to iesp layout
	aircraftChild := PROJECT(groupSlim, getReportChildren(LEFT, COUNTER));
																									
	
	addAircraftToReport := DENORMALIZE(inData, aircraftChild,
																			LEFT.seq = RIGHT.seq AND
																			LEFT.busn_info.BIP_IDs.UltID.LinkID = RIGHT.ultID AND
																			LEFT.busn_info.BIP_IDs.OrgID.LinkID = RIGHT.orgID AND
																			LEFT.busn_info.BIP_IDs.SeleID.LinkID = RIGHT.SeleID,
																			TRANSFORM(DueDiligence.layouts.Busn_Internal,
																								SELF.BusinessReport.BusinessAttributeDetails.EconomicAttributeDataDetails.AircraftOwnerShip.AircraftCount  := LEFT.aircraftCount,
																								SELF.BusinessReport.BusinessAttributeDetails.EconomicAttributeDataDetails.AircraftOwnerShip.Aircrafts := LEFT.BusinessReport.BusinessAttributeDetails.EconomicAttributeDataDetails.AircraftOwnerShip.Aircrafts + RIGHT.air;
																								SELF := LEFT;));
												





	// OUTPUT(withEngineCount, NAMED('withEngineCount'));
	// OUTPUT(aircraftChild, NAMED('aircraftChild'));
	// OUTPUT(addAircraftToReport, NAMED('addAircraftToReport'));
	
	
	RETURN addAircraftToReport;

END;   