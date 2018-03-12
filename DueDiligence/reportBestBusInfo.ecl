IMPORT Census_Data, codes, DueDiligence, iesp;

EXPORT reportBestBusInfo(DATASET(DueDiligence.layouts.Busn_Internal) inData) := FUNCTION

		projectESPBusInfo := PROJECT(inData, TRANSFORM({DueDiligence.LayoutsInternal.InternalBIPIDsLayout, iesp.duediligencebusinessreport.t_DDRBusinessInformation, STRING bestFipsCode, STRING bestCounty, STRING2 bestState},
																										SELF.seq := LEFT.seq;
																										SELF.ultID := LEFT.busn_info.BIP_IDs.UltID.LinkID;
																										SELF.orgID := LEFT.busn_info.BIP_IDs.OrgID.LinkID;
																										SELF.seleID := LEFT.busn_info.BIP_IDS.SeleID.LinkID;
																										SELF.phone := LEFT.busn_info.phone;
																										SELF.lexID := (STRING)LEFT.busn_info.BIP_IDS.SeleID.LinkID;
																										SELF.inputFEIN := LEFT.busn_input.fein;
																										SELF.bestFein := LEFT.busn_info.fein;
																										SELF.name := LEFT.busn_info.companyName;
																										SELF.inputAddress := PROJECT(LEFT.busn_input.address, TRANSFORM(iesp.share.t_Address,
                                                                                                                    SELF.StreetAddress1 := LEFT.streetAddress1;
                                                                                                                    SELF.StreetAddress2 := LEFT.streetAddress2;
                                                                                                                    SELF.StreetNumber := LEFT.prim_range;
                                                                                                                    SELF.StreetPreDirection := LEFT.predir;
                                                                                                                    SELF.StreetName := LEFT.prim_name;
                                                                                                                    SELF.StreetSuffix := LEFT.addr_suffix;
                                                                                                                    SELF.StreetPostDirection := LEFT.postdir;
                                                                                                                    SELF.UnitDesignation := LEFT.unit_desig;
                                                                                                                    SELF.UnitNumber := LEFT.sec_range;
                                                                                                                    SELF.City := LEFT.city;
                                                                                                                    SELF.State := LEFT.state;
                                                                                                                    SELF.Zip5 := LEFT.zip5;
                                                                                                                    SELF.Zip4 := LEFT.zip4;
                                                                                                                    SELF := [];));
                                                                                                                    
																										SELF.bestAddress := PROJECT(LEFT.busn_info.address, TRANSFORM(iesp.share.t_Address,
                                                                                                                  SELF.StreetAddress1 := LEFT.streetAddress1;
                                                                                                                  SELF.StreetAddress2 := LEFT.streetAddress2;
                                                                                                                  SELF.StreetNumber := LEFT.prim_range;
                                                                                                                  SELF.StreetPreDirection := LEFT.predir;
                                                                                                                  SELF.StreetName := LEFT.prim_name;
                                                                                                                  SELF.StreetSuffix := LEFT.addr_suffix;
                                                                                                                  SELF.StreetPostDirection := LEFT.postdir;
                                                                                                                  SELF.UnitDesignation := LEFT.unit_desig;
                                                                                                                  SELF.UnitNumber := LEFT.sec_range;
                                                                                                                  SELF.City := LEFT.city;
                                                                                                                  SELF.State := LEFT.state;
                                                                                                                  SELF.Zip5 := LEFT.zip5;
                                                                                                                  SELF.Zip4 := LEFT.zip4;
                                                                                                                  SELF.PostalCode := LEFT.zip5 + LEFT.zip4;
                                                                                                                  SELF.StateCityZip := LEFT.state + TRIM(LEFT.city) + LEFT.zip5;
                                                                                                                  SELF := [];));
                                                                                                                  
                                                    SELF.bestFipsCode := codes.st2FipsCode(StringLib.StringToUpperCase(LEFT.busn_info.address.state)) + LEFT.busn_info.address.county;
                                                    SELF.bestState := LEFT.busn_info.address.state;
																										SELF := [];));
																																																	
		
    
    Census_Data.MAC_Fips2County_Keyed(projectESPBusInfo, bestState, bestFipsCode, bestCounty, bestWithCounty);
    
    
		addBusInfo := 	JOIN(inData, bestWithCounty,
                          LEFT.seq = RIGHT.seq AND
                          LEFT.busn_info.BIP_IDs.UltID.LinkID = RIGHT.ultID AND
                          LEFT.busn_info.BIP_IDs.OrgID.LinkID = RIGHT.orgID AND
                          LEFT.busn_info.BIP_IDs.SeleID.LinkID = RIGHT.seleID,
                          TRANSFORM(DueDiligence.layouts.Busn_Internal,
                                    SELF.businessReport.businessInformation.bestAddress.county := RIGHT.bestCounty;
                                    SELF.businessReport.businessInformation := RIGHT;                                   
                                    SELF := LEFT;));



		// OUTPUT(projectESPBusInfo, NAMED('projectESPBusInfo'));
		// OUTPUT(bestWithCounty, NAMED('bestWithCounty'));
		// OUTPUT(addBusInfo, NAMED('addBusInfo'));

		RETURN addBusInfo;
END;