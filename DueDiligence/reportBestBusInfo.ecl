IMPORT DueDiligence, iesp;

EXPORT reportBestBusInfo(DATASET(DueDiligence.layouts.Busn_Internal) inData) := FUNCTION

		projectESPBusInfo := PROJECT(inData, TRANSFORM({DueDiligence.LayoutsInternal.InternalBIPIDsLayout, iesp.duediligencebusinessreport.t_DDRBusinessInformation},
																										SELF.seq := LEFT.seq;
																										SELF.ultID := LEFT.busn_info.BIP_IDs.UltID.LinkID;
																										SELF.orgID := LEFT.busn_info.BIP_IDs.OrgID.LinkID;
																										SELF.seleID := LEFT.busn_info.BIP_IDS.SeleID.LinkID;
																										SELF.phone := LEFT.busn_info.phone;
																										SELF.lexID := (STRING)LEFT.busn_info.BIP_IDS.SeleID.LinkID;
																										SELF.inputFEIN := LEFT.busn_input.fein;
																										SELF.bestFein := LEFT.busn_info.fein;
																										SELF.name := LEFT.busn_info.companyName;
																										// SELF.inputAddress :=  DATASET([TRANSFORM(iesp.share.t_Address,
																																															// SELF.StreetAddress1 := LEFT.busn_input.address.streetAddress1;
																																															// SELF.StreetAddress2 := LEFT.busn_input.address.streetAddress2;
																																															// SELF.StreetNumber := LEFT.busn_input.address.prim_range;
																																															// SELF.StreetPreDirection := LEFT.busn_input.address.predir;
																																															// SELF.StreetName := LEFT.busn_input.address.prim_name;
																																															// SELF.StreetSuffix := LEFT.busn_input.address.addr_suffix;
																																															// SELF.StreetPostDirection := LEFT.busn_input.address.postdir;
																																															// SELF.UnitDesignation := LEFT.busn_input.address.unit_desig;
																																															// SELF.UnitNumber := LEFT.busn_input.address.sec_range;
																																															// SELF.City := LEFT.busn_input.address.city;
																																															// SELF.State := LEFT.busn_input.address.state;
																																															// SELF.Zip5 := LEFT.busn_input.address.zip5;
																																															// SELF.Zip4 := LEFT.busn_input.address.zip4;
																																															// SELF := [];)])[1];
																										// SELF.bestAddress :=  DATASET([TRANSFORM(iesp.share.t_Address,
																																														// SELF.StreetAddress1 := LEFT.busn_info.address.streetAddress1;
																																														// SELF.StreetAddress2 := LEFT.busn_info.address.streetAddress2;
																																														// SELF.StreetNumber := LEFT.busn_info.address.prim_range;
																																														// SELF.StreetPreDirection := LEFT.busn_info.address.predir;
																																														// SELF.StreetName := LEFT.busn_info.address.prim_name;
																																														// SELF.StreetSuffix := LEFT.busn_info.address.addr_suffix;
																																														// SELF.StreetPostDirection := LEFT.busn_info.address.postdir;
																																														// SELF.UnitDesignation := LEFT.busn_info.address.unit_desig;
																																														// SELF.UnitNumber := LEFT.busn_info.address.sec_range;
																																														// SELF.City := LEFT.busn_info.address.city;
																																														// SELF.State := LEFT.busn_info.address.state;
																																														// SELF.Zip5 := LEFT.busn_info.address.zip5;
																																														// SELF.Zip4 := LEFT.busn_info.address.zip4;
																																														// SELF := [];)])[1];
																										SELF := [];));
																																																	
																																																	
		addBusInfo := 	JOIN(inData, projectESPBusInfo,
                          LEFT.seq = RIGHT.seq AND
                          LEFT.busn_info.BIP_IDs.UltID.LinkID = RIGHT.ultID AND
                          LEFT.busn_info.BIP_IDs.OrgID.LinkID = RIGHT.orgID AND
                          LEFT.busn_info.BIP_IDs.SeleID.LinkID = RIGHT.seleID,
                          TRANSFORM(DueDiligence.layouts.Busn_Internal,
                                    SELF.businessReport.businessInformation := RIGHT;
                                    SELF := LEFT;));



		// OUTPUT(projectESPBusInfo, NAMED('projectESPBusInfo'));
		// OUTPUT(addBusInfo, NAMED('addBusInfo'));

		RETURN addBusInfo;
END;