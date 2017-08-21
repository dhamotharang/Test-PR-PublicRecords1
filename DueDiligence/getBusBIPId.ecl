IMPORT Address, BIPV2, Business_Risk, Business_Risk_BIP, Gateway, Risk_Indicators, RiskWise, ut;

EXPORT getBusBIPId(DATASET(DueDiligence.Layouts.CleanedData) indata,
										Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
										BIPV2.mod_sources.iParams linkingOptions,
										BOOLEAN includeReport) := FUNCTION

	
	cleanedInput := DueDiligence.Common.GetCleanBIPShell(indata);
	
	//Grab just the clean input to pass to the BIP Linking Process
	prepBIPAppend := PROJECT(cleanedInput, TRANSFORM(Business_Risk_BIP.Layouts.Input, SELF := LEFT.Clean_Input));
	
	bipAppend := Business_Risk_BIP.BIP_LinkID_Append(prepBIPAppend);
	
	
	withBIP := JOIN(cleanedInput, bipAppend, 
										LEFT.Seq = RIGHT.Seq, 
										TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																SELF.BIP_IDs := RIGHT;
																SELF.Verification.InputIDMatchPowID		:= (STRING)RIGHT.PowID.LinkID;
																SELF.Verification.InputIDMatchProxID	:= (STRING)RIGHT.ProxID.LinkID;
																SELF.Verification.InputIDMatchSeleID	:= (STRING)RIGHT.SeleID.LinkID;
																SELF.Verification.InputIDMatchOrgID		:= (STRING)RIGHT.OrgID.LinkID;
																SELF.Verification.InputIDMatchUltID		:= (STRING)RIGHT.UltID.LinkID;
																SELF := LEFT),
										LEFT OUTER, KEEP(1), ATMOST(100), FEW);


	// Don't bother running a bunch of searches on Seq's that didn't find any ID's, just add them back at the end
	noLinkIDsFound := withBIP(BIP_IDs.PowID.LinkID = 0 AND BIP_IDs.ProxID.LinkID = 0 AND BIP_IDs.SeleID.LinkID = 0 AND BIP_IDs.OrgID.LinkID = 0 AND BIP_IDs.UltID.LinkID = 0);
	// Only run the searches with Seq's that found BIP Link ID's that we can search with
	linkIDsFoundTemp := withBIP(BIP_IDs.PowID.LinkID <> 0 OR BIP_IDs.ProxID.LinkID <> 0 OR BIP_IDs.SeleID.LinkID <> 0 OR BIP_IDs.OrgID.LinkID <> 0 OR BIP_IDs.UltID.LinkID <> 0);
	
	//creating a new options to pass into the BIP_Best_Append to overwite the BIPBestAppend passed in
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
		EXPORT UNSIGNED1	BIPBestAppend	 			:= Business_Risk_BIP.Constants.BIPBestAppend.AllBlankFields;  //Fill in any fields from the best BIP data that are currently blank, keep populated fields
	END;
	
	allowedSourcesSet := SET(DATASET([], Business_Risk_BIP.Layout_AllowedSources), Source); //as of 5/26/17 not used in BIP_Best_Append
	
	// Append "Best" Company information if only BIP ID's were passed in and it was requested in the Options that we perform the BIPBestAppend process, otherwise this function just returns what was sent to it
	linkIDsFound := Business_Risk_BIP.BIP_Best_Append(linkIDsFoundTemp, tempOptions, linkingOptions, allowedSourcesSet);
	
	//Return all businesses
	allIDs := noLinkIDsFound + linkIDsFound;

	final := PROJECT(allIDs, TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																			SELF.busn_info.BIP_IDs := LEFT.BIP_IDs;
																			SELF.busn_info.lexID := (STRING)LEFT.BIP_IDs.SeleID.LinkID;
																			SELF.historyDate := LEFT.Clean_Input.HistoryDate;
																			SELF.relatedDegree := DueDiligence.Constants.INQUIRED_BUSINESS_DEGREE;
																			
																			SELF.busn_info.companyName := LEFT.clean_input.companyName;
																			SELF.busn_info.altCompanyName := LEFT.clean_input.altCompanyName;
																			SELF.busn_info.fein := LEFT.clean_input.fein;
																			SELF.busn_info.phone := LEFT.clean_input.phone10;
																			SELF.busn_info.accountNumber := LEFT.clean_input.acctNo;
																			
																			SELF.busn_info.address := LEFT.clean_input;
																			SELF.busn_info.address.geo_lat := LEFT.clean_input.lat;
																			SELF.busn_info.address.geo_long := LEFT.clean_input.long;
																			SELF.busn_info.address.rec_type := LEFT.clean_input.addr_type;
																			SELF.busn_info.address.err_stat := LEFT.clean_input.addr_status;
																			SELF.busn_info.address.geo_blk := LEFT.clean_input.geo_block;

																			SELF := LEFT.clean_input;
																			
																			SELF.businessReport.businessInformation.lexID := IF(includeReport, (STRING)LEFT.BIP_IDs.SeleID.LinkID, '');
																			SELF := [];	));
	
	// OUTPUT(indata, NAMED('indata'));
	// OUTPUT(cleanedInput, NAMED('cleanedInput'));
	// OUTPUT(prepBIPAppend, NAMED('prepBIPAppend'));
	// OUTPUT(bipAppend, NAMED('bipAppend'));
	// OUTPUT(withBIP, NAMED('withBIP'));
	// OUTPUT(noLinkIDsFound, NAMED('noLinkIDsFound'));
	// OUTPUT(linkIDsFoundTemp, NAMED('linkIDsFoundTemp'));
	// OUTPUT(linkIDsFound, NAMED('linkIDsFound'));
	// OUTPUT(allIDs, NAMED('allIDs'));
	// OUTPUT(final, NAMED('final'));
	
	return final;

END;