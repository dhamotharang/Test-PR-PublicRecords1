IMPORT codes, DueDiligence, faa, iesp, BIPv2;

EXPORT reportBusWatercraft(DATASET(DueDiligence.layouts.Busn_Internal) inData, 
													 DATASET(DueDiligence.LayoutsInternalReport.BusWatercraftSlimLayout) watercraftSlim) := FUNCTION


	//group slimmed dataset by seq and linkIDs so counter can count per group
	groupSlim := GROUP(watercraftSlim, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));

	
	//Transform to limit the number of data in our dataset
	DueDiligence.LayoutsInternalReport.BusWatercraftReportChildren getReportChildren(DueDiligence.LayoutsInternalReport.BusWatercraftSlimLayout wsl, INTEGER c) := TRANSFORM, SKIP(c > iesp.Constants.DDRAttributesConst.MaxWatercraft)
		SELF.water := PROJECT(wsl, TRANSFORM(iesp.duediligenceshared.t_DDRWatercraft,
																				SELF.yearMakeModel.year := LEFT.year;
																				SELF.yearMakeModel.make := LEFT.make;
																				SELF.yearMakeModel.model := LEFT.model;
                                        
																				SELF.vesselType.detailType := LEFT.vesselType;
                                        
																				SELF.lengthFeet := LEFT.vesselLengthFeet;
																				SELF.lengthInches := LEFT.vesselLengthInches;
																				SELF.title.state := LEFT.titleState;
																				SELF.title.date.year := (INTEGER)LEFT.titleDate[1..4];
                                        SELF.title.date.month := (INTEGER)LEFT.titleDate[5..6];
                                        SELF.title.date.day := (INTEGER)LEFT.titleDate[7..8];
																				
                                        SELF.registration.state := LEFT.registrationState;
                                        SELF.registration.date.year := (INTEGER)LEFT.registrationDate[1..4];
                                        SELF.registration.date.month := (INTEGER)LEFT.registrationDate[5..6];
                                        SELF.registration.date.day := (INTEGER)LEFT.registrationDate[7..8];
																																																											
																				SELF.VINNumber.vin := LEFT.vin;

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
																									SELF.BusinessReport.BusinessAttributeDetails.Economic.Watercraft.WatercraftCount  := LEFT.watercraftCount,
																									SELF.BusinessReport.BusinessAttributeDetails.Economic.Watercraft.Watercrafts := LEFT.BusinessReport.BusinessAttributeDetails.Economic.Watercraft.Watercrafts + RIGHT.water;
																									SELF := LEFT;));
												



	// OUTPUT(groupSlim, NAMED('groupSlim'));
	// OUTPUT(watercraftChild, NAMED('watercraftChild'));
	// OUTPUT(addWatercraftToReport, NAMED('addWatercraftToReport'));
	
	
	RETURN addWatercraftToReport;

END;   
	
	