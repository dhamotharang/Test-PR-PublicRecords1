IMPORT codes, DueDiligence, faa, iesp, BIPv2;

EXPORT reportBusWatercraft(DATASET(DueDiligence.layouts.Busn_Internal) inData, 
														DATASET(DueDiligence.LayoutsInternalReport.BusWatercraftSlimLayout) watercraftSlim) := FUNCTION


	//group slimmed dataset by seq and linkIDs so counter can count per group
	groupSlim := GROUP(watercraftSlim, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));

	
	//Transform to limit the number of data in our dataset
	DueDiligence.LayoutsInternalReport.BusWatercraftReportChildren getReportChildren(DueDiligence.LayoutsInternalReport.BusWatercraftSlimLayout wsl, INTEGER c) := TRANSFORM, SKIP(c > iesp.Constants.DDRAttributesConst.MaxAssets)
		SELF.water := PROJECT(wsl, TRANSFORM(iesp.duediligencereport.t_DDRWatercraft,
																				SELF.sequence := c;
																				SELF.watercraft := DATASET([TRANSFORM(iesp.duediligencereport.t_DDRYearMakeModel,
																																										SELF.year := LEFT.year;
																																										SELF.make := LEFT.make;
																																										SELF.model := LEFT.model;
																																										SELF := [];)])[1];
																				SELF.vesselType := DATASET([TRANSFORM(iesp.duediligencereport.t_DDRAdditionalDetails,
																																										SELF.detailType := LEFT.vesselType;
																																										SELF := [];)])[1];
																				SELF.vesselLength := LEFT.vesselTotalLength;
																				// SELF.vesselLengthFeet := LEFT.vesselLengthFeet;
																				// SELF.vesselLengthInches := LEFT.vesselLengthInches;
																				SELF.title := DATASET([TRANSFORM(iesp.duediligencereport.t_DDRTitleInfo,
																																								SELF.state := LEFT.titleState;
																																								SELF.date := DATASET([TRANSFORM(iesp.share.t_Date,
																																																								SELF.year := (INTEGER)LEFT.titleDate[1..4];
																																																								SELF.month := (INTEGER)LEFT.titleDate[5..6];
																																																								SELF.day := (INTEGER)LEFT.titleDate[7..8];
																																																								SELF := [];)])[1];)])[1];
																				SELF.registration := DATASET([TRANSFORM(iesp.duediligencereport.t_DDRRegistration,
																																											SELF.state := LEFT.registrationState;
																																											SELF.date := DATASET([TRANSFORM(iesp.share.t_Date,
																																																											SELF.year := (INTEGER)LEFT.registrationDate[1..4];
																																																											SELF.month := (INTEGER)LEFT.registrationDate[5..6];
																																																											SELF.day := (INTEGER)LEFT.registrationDate[7..8];
																																																											SELF := [];)])[1];)])[1];
																																																											
																				// SELF.vin := DATASET([TRANSFORM(iesp.duediligencereport.t_DDRVINNumber,
																																							// SELF.vin := LEFT.vin;
																																							// SELF := [];)])[1];
																				SELF := LEFT;
																				SELF := [];));
		SELF := wsl;
	END;
	

	//convert to iesp layout
	watercraftChild := PROJECT(groupSlim, getReportChildren(LEFT, COUNTER));	

	addWatercraftToReport := DENORMALIZE(inData, watercraftChild,
																				LEFT.seq = RIGHT.seq AND
																				LEFT.busn_info.BIP_IDs.UltID.LinkID = RIGHT.ultID AND
																				LEFT.busn_info.BIP_IDs.OrgID.LinkID = RIGHT.orgID AND
																				LEFT.busn_info.BIP_IDs.SeleID.LinkID = RIGHT.SeleID,
																				TRANSFORM(DueDiligence.layouts.Busn_Internal,
																									SELF.BusinessReport.BusinessAttributeDetails.EconomicAttributeDataDetails.WatercraftOwnership.WatercraftCount  := LEFT.watercraftCount,
																									SELF.BusinessReport.BusinessAttributeDetails.EconomicAttributeDataDetails.WatercraftOwnership.Watercrafts := LEFT.BusinessReport.BusinessAttributeDetails.EconomicAttributeDataDetails.WatercraftOwnership.Watercrafts + RIGHT.water;
																									SELF := LEFT;));
												



	// OUTPUT(groupSlim, NAMED('groupSlim'));
	// OUTPUT(watercraftChild, NAMED('watercraftChild'));
	// OUTPUT(addWatercraftToReport, NAMED('addWatercraftToReport'));
	
	
	RETURN addWatercraftToReport;

END;   
	
	