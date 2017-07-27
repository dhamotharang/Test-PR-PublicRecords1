IMPORT Autokey_Batch,BatchShare,Doxie,Gateway,iesp,MDR,Phones,PhonesInfo,Royalty,Suppress,ut;

EXPORT PhoneFinder_Records( DATASET(Autokey_batch.Layouts.rec_inBatchMaster) dIn,
														PhoneFinder_Services.iParam.ReportParams         inMod,
														DATASET(Gateway.Layouts.Config)                  dGateways,
														iesp.phonefinder.t_PhoneFinderSearchBy           pSearchBy
													) :=
MODULE

	SHARED first_row := dIn[1];
	
	SHARED BOOLEAN vPhoneBlank := (UNSIGNED)first_row.homephone = 0;
	SHARED BOOLEAN vIsPhone10  := LENGTH(TRIM(first_row.homephone)) = 10;
	SHARED BOOLEAN vDIDBlank   := (UNSIGNED)first_row.did = 0;
	BatchShare.MAC_CapitalizeInput(dIn, SHARED dProcessInput);
	SHARED dGetDIDs := IF(inMod.TransactionType = PhoneFinder_Services.Constants.TransType.PhoneRiskAssessment,
																								DATASET([],PhoneFinder_Services.Layouts.BatchInAppendDID),
																								PhoneFinder_Services.Functions.GetDIDsBatch(dProcessInput));																						
	PhoneFinder_Services.Layouts.BatchInAppendDID tDIDs(Autokey_batch.Layouts.rec_inBatchMaster le,
																											PhoneFinder_Services.Layouts.BatchInAppendDID ri) :=
	TRANSFORM
		SELF.orig_did := le.did;
		SELF.did      := ri.did;
		SELF          := le;
	END;
	
	SHARED dInDIDs := JOIN(dProcessInput,
													dGetDIDs(did_count = 1), //Filter out records which got multiple DIDs
													LEFT.acctno = RIGHT.acctno,
													tDIDs(LEFT,RIGHT),
													LEFT OUTER,
													LIMIT(PhoneFinder_Services.Constants.MaxDIDs,SKIP));
	
	SHARED dAppendDIDs := IF(vDIDBlank,
														dInDIDs,
														PROJECT(dProcessInput,
																		TRANSFORM(PhoneFinder_Services.Layouts.BatchInAppendDID,SELF.orig_did := LEFT.did,SELF := LEFT)));
	
	// Split the input DATASET into two depending on the input criteria
	SHARED dInPhone   := dAppendDIDs(homephone != '');
	SHARED dInNoPhone := dAppendDIDs(homephone = '' and did != 0 and inMod.TransactionType != PhoneFinder_Services.Constants.TransType.PhoneRiskAssessment);

	// Best information
	SHARED dInNoPhoneBestInfo := PhoneFinder_Services.Functions.GetBestInfo(dInNoPhone);
	// Primary identity		
	Suppress.MAC_Suppress(dInNoPhoneBestInfo, SHARED dinBestInfo,
													inMod.ApplicationType,Suppress.Constants.LinkTypes.DID,did,'','',FALSE,'',TRUE);
												
	// Search inhouse phone sources and gateways when phone number is provided
	dPhoneSearchResults := IF(EXISTS(dInPhone),PhoneFinder_Services.PhoneSearch(dInPhone,inMod,dGateways));

	// Waterfall process when only PII is provided
	dWaterfallResults := IF(EXISTS(dInNoPhone),PhoneFinder_Services.DIDSearch(dInNoPhone,inMod,dGateways,dInNoPhoneBestInfo));

	SHARED dSearchRecs		 := IF(vPhoneBlank,dWaterfallResults,dPhoneSearchResults);

	ds_in_accu := IF(inMod.TransactionType = PhoneFinder_Services.Constants.TransType.PhoneRiskAssessment,
	                 project(dedup(sort(dInPhone, acctno), acctno),
									 transform(PhoneFinder_Services.Layouts.PhoneFinder.Accudata_in, self.acctno := left.acctno, self.phone := left.homephone)),
									 project(dSearchRecs(typeflag = Phones.Constants.TypeFlag.DataSource_PV), PhoneFinder_Services.Layouts.PhoneFinder.Accudata_in));
									 
	AccuDataGateway := if(inMod.UseAccuData_ocn, dGateways(Gateway.Configuration.IsAccuDataOCN(servicename)));
  SHARED accu_porting := PhoneFinder_Services.GetAccuDataPhones.GetAccuData_Ocn_PortingData(ds_in_accu,
	                                                                                          AccuDataGateway[1]);		
	accu_inport := PROJECT(accu_porting, PhoneFinder_Services.Layouts.PortedMetadata);																																													
	SHARED dSearchResultsUnfiltered := IF((inMod.IncludePhoneMetadata AND EXISTS(dSearchRecs))
																					OR (inMod.TransactionType = PhoneFinder_Services.Constants.TransType.PhoneRiskAssessment AND EXISTS(dInPhone))
																												,PhoneFinder_Services.GetPhonesMetadata(dSearchRecs,inMod,dGateways,dinBestInfo,dInPhone,accu_inport(port_end_dt <> 0))
																												,dSearchRecs);	

	verifyRequest := (INTEGER)inMod.VerifyPhoneIsActive + (INTEGER)inMod.VerifyPhoneName + (INTEGER)inMod.VerifyPhoneNameAddress;
	
	// Fail the service if multiple DIDs are returned for the search criteria OR if the phone number is not 10 digits OR if no records are returned
	MAP(~vPhoneBlank and ~vIsPhone10                    => FAIL(301,doxie.ErrorCodes(301)),
			vPhoneBlank and EXISTS(dGetDIDs(did_count > 1)) => FAIL(203,doxie.ErrorCodes(203)), //FAIL the service if no records exists
  // If phoneFinder were to run as a verification tool, only one type of verification should be selected.
	// If more than one type of verification is selected, fail the service.			
	// Verification request requires a complete phone number.			
			verifyRequest > 1																=> FAIL(100,PhoneFinder_Services.Constants.ErrorCodes(100)),
			((BOOLEAN)verifyRequest AND ~vIsPhone10)				=> FAIL(101,PhoneFinder_Services.Constants.ErrorCodes(101))); 

  /*Phone verification is a "phone only" search, even if the phone is blank.  If the phone is blank, the 
  verification will fail and the appropriate status will be returned. */
	verifyInputDID := inMod.VerifyPhoneName OR inMod.VerifyPhoneNameAddress;
	dinBestDID := 	if(verifyInputDID, dInDIDs,DATASET([],PhoneFinder_Services.Layouts.BatchInAppendDID));// for lexid verification
	EXPORT dFormat2IESP := IF(~vPhoneBlank OR inMod.VerifyPhoneIsActive OR inMod.VerifyPhoneName OR inMod.VerifyPhoneNameAddress,
														PhoneFinder_Services.Functions.FormatResults2IESP(pSearchBy,inMod,
																																						  dinBestDID, 
																																							dSearchResultsUnfiltered,TRUE),
														PhoneFinder_Services.Functions.FormatResults2IESP(pSearchBy,inMod,dinBestInfo,dSearchResultsUnfiltered,FALSE));
	 
	// Royalties
	dSearchResultsFilter := dSearchRecs(typeflag != Phones.Constants.TypeFlag.DataSource_PV);
	
	// Sort and dedup data
	dResultsDIDDedup   := DEDUP(SORT(dSearchResultsFilter(did != 0),acctno,did,phone,-dt_last_seen,RECORD),acctno,did,phone);
	dResultsNoDIDDedup := DEDUP(SORT(dSearchResultsFilter(did = 0),
																		acctno,fname,mname,lname,name_suffix,listed_name,
																		prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,
																		city_name,st,zip,zip4,county_code,county_name,phone,-dt_last_seen,RECORD),
															acctno,fname,mname,lname,name_suffix,listed_name,
															prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,
															city_name,st,zip,zip4,county_code,county_name,phone);
	
	dResultsDedup := dResultsDIDDedup + dResultsNoDIDDedup;
	
	dResultsDedupQSent := dResultsDedup + dSearchRecs(typeflag = Phones.Constants.TypeFlag.DataSource_PV);
	
	Royalty.MAC_RoyaltyLastResort(dResultsDedup,dRoyaltyLR);
	Royalty.MAC_RoyaltyMetronet(dResultsDedup,dRoyaltyMetronet,subj_phone_type_new,MDR.sourceTools.src_Metronet_Gateway);
	Royalty.RoyaltyEFXDataMart.MAC_GetWebRoyalties(dResultsDedup,dRoyaltyEquifax,subj_phone_type_new,MDR.sourceTools.src_EQUIFAX);
	Royalty.MAC_RoyaltyQSENT(dResultsDedupQSent,dRoyaltyQSent,TRUE,TRUE); 
	dRoyaltyTargus := Royalty.RoyaltyTargus.GetOnlineRoyalties(dResultsDedup,,,TRUE, FALSE, FALSE, FALSE);
  dRoyaltyAccOCN := Royalty.RoyaltyAccudata.GetOnlineRoyalties(accu_porting);
	
	EXPORT dRoyalties := 
		if(inMod.UseLastResort, dRoyaltyLR) + 
		if(inMod.UseInHouseQSent or inMod.UseQSent, dRoyaltyQSent) + 
		if(inMod.UseMetronet, dRoyaltyMetronet) + 
		if(inMod.UseTargus, dRoyaltyTargus) + 
		if(inMod.UseEquifax, dRoyaltyEquifax) + 
		if(inMod.UseAccuData_ocn, dRoyaltyAccOCN);

END;