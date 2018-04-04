IMPORT BIPV2, Business_Risk, Business_Risk_BIP, DueDiligence, iesp;

EXPORT getBusBestData(DATASET(DueDiligence.Layouts.CleanedData) indata,
											DATASET(DueDiligence.Layouts.Busn_Internal) busInfo,
											Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
											BIPV2.mod_sources.iParams linkingOptions,
											BOOLEAN includeReport) := FUNCTION


	cleanedShell := IF(EXISTS(indata), DueDiligence.Common.GetCleanBIPShell(indata), DueDiligence.Common.GetBusInternalBIPShell(busInfo));
	
	withBIP := JOIN(cleanedShell, busInfo, 
										LEFT.Seq = RIGHT.Seq AND
										LEFT.Clean_Input.AcctNo = RIGHT.Busn_info.accountNumber, 
										TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																SELF.seq := LEFT.seq;
																SELF.BIP_IDs := RIGHT.Busn_info.BIP_IDs;
																SELF.Clean_Input.PowID := RIGHT.Busn_info.BIP_IDs.PowID.LinkID;
																SELF.Clean_Input.ProxID := RIGHT.Busn_info.BIP_IDs.ProxID.LinkID;
																SELF.Clean_Input.SeleID := RIGHT.Busn_info.BIP_IDs.SeleID.LinkID;
																SELF.Clean_Input.OrgID := RIGHT.Busn_info.BIP_IDs.OrgID.LinkID;
																SELF.Clean_Input.UltID := RIGHT.Busn_info.BIP_IDs.UltID.LinkID;
																SELF := LEFT;),
										RIGHT OUTER);
	
	allowedSourcesSet := SET(DATASET([], Business_Risk_BIP.Layout_AllowedSources), Source); //as of 5/26/17 not used in BIP_Best_Append
	
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
		
	// Append "Best" Company information if only BIP ID's were passed in and it was requested in the Options that we perform the BIPBestAppend process, otherwise this function just returns what was sent to it
	linkIDsFound := Business_Risk_BIP.BIP_Best_Append(withBIP, tempOptions, linkingOptions, allowedSourcesSet);
	
	
	bestData := JOIN(busInfo, linkIDsFound, 
										LEFT.seq = RIGHT.seq AND
										LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.Clean_Input.UltID AND
										LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.Clean_Input.OrgID AND
										LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.Clean_Input.SeleID,		
										TRANSFORM(DueDiligence.Layouts.Busn_Internal,
															bestBus := RIGHT.clean_input;																			
															cleanBus := LEFT.Busn_info;
																
															SELF.busn_info.companyName := IF(cleanBus.companyName = DueDiligence.Constants.EMPTY, bestBus.companyName, cleanBus.companyName); 
															SELF.busn_info.altCompanyName := IF(cleanBus.altCompanyName = DueDiligence.Constants.EMPTY, RIGHT.clean_input.altCompanyName, cleanBus.altCompanyName);
															SELF.busn_info.fein := IF(cleanBus.fein = DueDiligence.Constants.EMPTY, RIGHT.clean_input.fein, cleanBus.fein);
															SELF.busn_info.phone := IF(cleanBus.phone = DueDiligence.Constants.EMPTY, RIGHT.clean_input.phone10, cleanBus.phone);
																
															SELF.busn_info.address.streetAddress1 := IF(LEFT.fullinputaddressprovided, cleanBus.address.streetAddress1, bestBus.streetAddress1);
															SELF.busn_info.address.streetAddress2 := IF(LEFT.fullinputaddressprovided, cleanBus.address.streetAddress2, bestBus.streetAddress2);
															SELF.busn_info.address.prim_range := IF(LEFT.fullinputaddressprovided, cleanBus.address.prim_range, bestBus.prim_range);
															SELF.busn_info.address.predir := IF(LEFT.fullinputaddressprovided, cleanBus.address.predir, bestBus.predir);
															SELF.busn_info.address.prim_name := IF(LEFT.fullinputaddressprovided, cleanBus.address.prim_name, bestBus.prim_name);
															SELF.busn_info.address.addr_suffix := IF(LEFT.fullinputaddressprovided, cleanBus.address.addr_suffix, bestBus.addr_suffix);
															SELF.busn_info.address.postdir := IF(LEFT.fullinputaddressprovided, cleanBus.address.postdir, bestBus.postdir);
															SELF.busn_info.address.unit_desig := IF(LEFT.fullinputaddressprovided, cleanBus.address.unit_desig, bestBus.unit_desig);
															SELF.busn_info.address.sec_range := IF(LEFT.fullinputaddressprovided, cleanBus.address.sec_range, bestBus.sec_range);
															SELF.busn_info.address.city := IF(LEFT.fullinputaddressprovided, cleanBus.address.city, bestBus.city);
															SELF.busn_info.address.state := IF(LEFT.fullinputaddressprovided, cleanBus.address.state, bestBus.state);
															SELF.busn_info.address.zip5 := IF(LEFT.fullinputaddressprovided, cleanBus.address.zip5, bestBus.zip5);
															SELF.busn_info.address.zip4 := IF(LEFT.fullinputaddressprovided, cleanBus.address.zip4, bestBus.zip4);
															
															SELF.busn_info.address.cart := IF(LEFT.fullinputaddressprovided, cleanBus.address.cart, DueDiligence.Constants.EMPTY);
															SELF.busn_info.address.cr_sort_sz := IF(LEFT.fullinputaddressprovided, cleanBus.address.cr_sort_sz, DueDiligence.Constants.EMPTY);
															SELF.busn_info.address.lot := IF(LEFT.fullinputaddressprovided, cleanBus.address.lot, DueDiligence.Constants.EMPTY);
															SELF.busn_info.address.lot_order := IF(LEFT.fullinputaddressprovided, cleanBus.address.lot_order, DueDiligence.Constants.EMPTY);
															SELF.busn_info.address.dbpc := IF(LEFT.fullinputaddressprovided, cleanBus.address.dbpc, DueDiligence.Constants.EMPTY);
															SELF.busn_info.address.chk_digit := IF(LEFT.fullinputaddressprovided, cleanBus.address.chk_digit, DueDiligence.Constants.EMPTY);
															SELF.busn_info.address.msa := IF(LEFT.fullinputaddressprovided, cleanBus.address.msa, DueDiligence.Constants.EMPTY);
															SELF.busn_info.address.geo_match := IF(LEFT.fullinputaddressprovided, cleanBus.address.geo_match, DueDiligence.Constants.EMPTY);
															
															SELF.busn_info.address.county := IF(LEFT.fullinputaddressprovided, cleanBus.address.county, bestBus.county);
															SELF.busn_info.address.geo_lat := IF(LEFT.fullinputaddressprovided, cleanBus.address.geo_lat, bestBus.lat);
															SELF.busn_info.address.geo_long := IF(LEFT.fullinputaddressprovided, cleanBus.address.geo_long, bestBus.long);
															SELF.busn_info.address.rec_type := IF(LEFT.fullinputaddressprovided, cleanBus.address.rec_type, bestBus.addr_type);
															SELF.busn_info.address.err_stat := IF(LEFT.fullinputaddressprovided, cleanBus.address.err_stat, bestBus.addr_status);
															SELF.busn_info.address.geo_blk := IF(LEFT.fullinputaddressprovided, cleanBus.address.geo_blk, bestBus.geo_block);
															
															SELF.bestCompanyName := bestBus.CompanyName;
															SELF.bestAddr := bestBus.streetAddress1;
															SELF.bestCity := bestBus.city;
															SELF.bestState := bestBus.state;
															SELF.bestZip := bestBus.zip5;
															SELF.bestZip4 := bestBus.zip4;
															SELF.bestFEIN := bestBus.fein;
															SELF.bestPhone := bestBus.phone10;
															SELF.businessReport.businessInformation.bestFEIN := IF(includeReport, bestBus.fein, DueDiligence.Constants.EMPTY);
															SELF.businessReport.businessInformation.bestAddress := IF(includeReport, DATASET([TRANSFORM(iesp.share.t_Address,
																																																								SELF.StreetAddress1 := bestBus.streetAddress1;
																																																								SELF.StreetAddress2 := bestBus.streetAddress2;
																																																								// SELF.StreetNumber := bestBus.prim_range;
																																																								// SELF.StreetPreDirection := bestBus.predir;
																																																								// SELF.StreetName := bestBus.prim_name;
																																																								// SELF.StreetSuffix := bestBus.addr_suffix;
																																																								// SELF.StreetPostDirection := bestBus.postdir;
																																																								// SELF.UnitDesignation := bestBus.unit_desig;
																																																								// SELF.UnitNumber := bestBus.sec_range;
																																																								SELF.City := bestBus.city;
																																																								SELF.State := bestBus.state;
																																																								SELF.Zip5 := bestBus.zip5;
																																																								SELF.Zip4 := bestBus.zip4;
																																																								SELF := [];)]),
																																																			 DATASET([], iesp.share.t_Address))[1];
															SELF  := LEFT;),
										LEFT OUTER);
	

	// OUTPUT(busInfo, NAMED('busInfo'));
	// OUTPUT(cleanedShell, NAMED('cleanedShell'));
	// OUTPUT(withBIP, NAMED('withBIP'));
	// OUTPUT(linkIDsFound, NAMED('linkIDsFound'));
	// OUTPUT(bestData, NAMED('bestData'));
	

	RETURN bestData;
	
END;