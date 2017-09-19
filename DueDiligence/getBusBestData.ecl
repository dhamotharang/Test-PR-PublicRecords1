IMPORT BIPV2, Business_Risk, Business_Risk_BIP, DueDiligence, iesp;

EXPORT getBusBestData(DATASET(DueDiligence.Layouts.CleanedData) indata,
											DATASET(DueDiligence.Layouts.Busn_Internal) busInfo,
											Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
											BIPV2.mod_sources.iParams linkingOptions,
											BOOLEAN includeReport) := FUNCTION

//** creating a new options to pass into the BIP_Best_Append to overwite the BIPBestAppend passed in
	tempOptions := MODULE(Business_Risk_BIP.LIB_Business_Shell_LIBIN)
		EXPORT UNSIGNED1	DPPA_Purpose 				:= options.DPPA_Purpose;
		EXPORT UNSIGNED1	GLBA_Purpose 				:= options.GLBA_Purpose;
		EXPORT STRING50		DataRestrictionMask	:= options.DataRestrictionMask;
		EXPORT STRING50		DataPermissionMask	:= options.DataPermissionMask;
		EXPORT STRING10		IndustryClass				:= options.IndustryClass;
		EXPORT UNSIGNED1	LinkSearchLevel			:= options.LinkSearchLevel;
		EXPORT UNSIGNED1	BusShellVersion			:= options.BusShellVersion;
		EXPORT UNSIGNED1	MarketingMode				:= options.MarketingMode;
		EXPORT STRING50		AllowedSources			:= options.AllowedSources;
		EXPORT UNSIGNED1	BIPBestAppend	 			:= Business_Risk_BIP.Constants.BIPBestAppend.OverwriteWithBest;  //Get whatever we think is the best data
	END;
	
	cleanedInput := DueDiligence.Common.GetCleanBIPShell(indata);
	
	withBIP := JOIN(cleanedInput, busInfo, 
										LEFT.Seq = RIGHT.Seq, 
										TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																SELF.BIP_IDs := RIGHT.Busn_info.BIP_IDs;
																SELF.Verification.InputIDMatchPowID		:= (STRING)RIGHT.Busn_info.BIP_IDs.PowID.LinkID;
																SELF.Verification.InputIDMatchProxID	:= (STRING)RIGHT.Busn_info.BIP_IDs.ProxID.LinkID;
																SELF.Verification.InputIDMatchSeleID	:= (STRING)RIGHT.Busn_info.BIP_IDs.SeleID.LinkID;
																SELF.Verification.InputIDMatchOrgID		:= (STRING)RIGHT.Busn_info.BIP_IDs.OrgID.LinkID;
																SELF.Verification.InputIDMatchUltID		:= (STRING)RIGHT.Busn_info.BIP_IDs.UltID.LinkID;
																SELF := LEFT),
										LEFT OUTER, KEEP(1), ATMOST(100), FEW);
	
	allowedSourcesSet := SET(DATASET([], Business_Risk_BIP.Layout_AllowedSources), Source); //as of 5/26/17 not used in BIP_Best_Append
	
	// Append "Best" Company information if only BIP ID's were passed in and it was requested in the Options that we perform the BIPBestAppend process, otherwise this function just returns what was sent to it
	linkIDsFound := Business_Risk_BIP.BIP_Best_Append(withBIP, tempOptions, linkingOptions, allowedSourcesSet);
	
	bestData := JOIN(busInfo, linkIDsFound, 
										LEFT.seq = RIGHT.seq AND
										LEFT.Busn_info.BIP_IDS.UltID.LinkID = (UNSIGNED)RIGHT.Verification.InputIDMatchUltID AND
										LEFT.Busn_info.BIP_IDS.OrgID.LinkID = (UNSIGNED)RIGHT.Verification.InputIDMatchOrgID AND
										LEFT.Busn_info.BIP_IDS.SeleID.LinkID = (UNSIGNED)RIGHT.Verification.InputIDMatchSeleID,		
										TRANSFORM(DueDiligence.Layouts.Busn_Internal,
															SELF.bestCompanyName := RIGHT.Input_Echo.CompanyName;
															SELF.bestAddr := RIGHT.Input_Echo.streetAddress1;
															SELF.bestCity := RIGHT.Input_Echo.city;
															SELF.bestState := RIGHT.Input_Echo.state;
															SELF.bestZip := RIGHT.Input_Echo.zip5;
															SELF.bestZip4 := RIGHT.Input_Echo.zip4;
															SELF.bestFEIN := RIGHT.Input_Echo.fein;
															SELF.bestPhone := RIGHT.Input_Echo.phone10;
															SELF.businessReport.businessInformation.bestFEIN := IF(includeReport, RIGHT.Input_Echo.fein, '');
															SELF.businessReport.businessInformation.bestAddress := IF(includeReport, DATASET([TRANSFORM(iesp.share.t_Address,
																																																								SELF.StreetAddress1 := RIGHT.Input_Echo.streetAddress1;
																																																								SELF.StreetAddress2 := RIGHT.Input_Echo.streetAddress2;
																																																								// SELF.StreetNumber := RIGHT.Input_Echo.prim_range;
																																																								// SELF.StreetPreDirection := RIGHT.Input_Echo.predir;
																																																								// SELF.StreetName := RIGHT.Input_Echo.prim_name;
																																																								// SELF.StreetSuffix := RIGHT.Input_Echo.addr_suffix;
																																																								// SELF.StreetPostDirection := RIGHT.Input_Echo.postdir;
																																																								// SELF.UnitDesignation := RIGHT.Input_Echo.unit_desig;
																																																								// SELF.UnitNumber := RIGHT.Input_Echo.sec_range;
																																																								SELF.City := RIGHT.Input_Echo.city;
																																																								SELF.State := RIGHT.Input_Echo.state;
																																																								SELF.Zip5 := RIGHT.Input_Echo.zip5;
																																																								SELF.Zip4 := RIGHT.Input_Echo.zip4;
																																																								SELF := [];)]),
																																																			 DATASET([], iesp.share.t_Address))[1];
															SELF  := LEFT;),
										LEFT OUTER);
	

	// OUTPUT(withBIP, NAMED('withBIP'));
	// OUTPUT(linkIDsFound, NAMED('linkIDsFound'));
	// OUTPUT(bestData, NAMED('bestData'));
	

	RETURN bestData;
	
END;