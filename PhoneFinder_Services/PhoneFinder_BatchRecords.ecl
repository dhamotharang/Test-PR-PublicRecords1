IMPORT Autokey_Batch,BatchShare,Gateway,MDR,Phones,PhoneFinder_Services,Royalty,Suppress, Ut;

EXPORT PhoneFinder_BatchRecords(DATASET(PhoneFinder_Services.Layouts.BatchIn) dIn,
																PhoneFinder_Services.iParam.ReportParams      inMod,
																DATASET(Gateway.Layouts.Config)               dGateways
																) :=
MODULE

	BatchShare.MAC_ProcessInput(dIn,SHARED dProcessInput);
	
	// Format to common batch input layout
	Autokey_batch.Layouts.rec_inBatchMaster tFormat2BatchCommonInput(dProcessInput pInput) :=
	TRANSFORM
		SELF.seq       := (UNSIGNED)pInput.orig_acctno;
		SELF.homephone := pInput.phone;
		SELF.zip4      := pInput.z4;
		SELF           := pInput;
		SELF           := [];
	END;
	
	dFormat2BatchCommonInput := PROJECT(dProcessInput,tFormat2BatchCommonInput(LEFT));
	// DIDs
	dGetDIDs := IF(inMod.TransactionType = PhoneFinder_Services.Constants.TransType.PhoneRiskAssessment,
																								DATASET([],PhoneFinder_Services.Layouts.BatchInAppendDID),
																								PhoneFinder_Services.Functions.GetDIDsBatch(dFormat2BatchCommonInput(did = 0)));				
	PhoneFinder_Services.Layouts.BatchInAppendAcctno tDIDs(Autokey_batch.Layouts.rec_inBatchMaster le,
																													PhoneFinder_Services.Layouts.BatchInAppendDID ri) :=
	TRANSFORM
		SELF.orig_acctno := (STRING)le.seq;
		SELF.orig_did    := le.did;
		SELF.did         := IF(le.did != 0,le.did,IF(ri.did_count = 1,ri.did,0));
		SELF.err_search  := MAP(le.homephone != '' and LENGTH(TRIM(le.homephone)) != 10 => 301,
														le.homephone = '' and ri.did_count > 1                  => 203,
														0);
		SELF.phone       := le.homephone;
		SELF.z4          := le.zip4;
		SELF             := le;
	END;
	
	dAppendDIDs_ := JOIN(dFormat2BatchCommonInput,
															dGetDIDs,
															LEFT.acctno = RIGHT.acctno,
															tDIDs(LEFT,RIGHT),
															LEFT OUTER,
															LIMIT(PhoneFinder_Services.Constants.MaxDIDs,SKIP));
	
	// Need to keep records where we uniquely identified a DID
	SHARED dAppendDIDs := DEDUP(SORT(dAppendDIDs_,acctno),acctno);
	
	// Split the input dataset into two depending on the input criteria
	SHARED dAppendDIDsFormat := PROJECT(dAppendDIDs(err_search = 0),
																			TRANSFORM(PhoneFinder_Services.Layouts.BatchInAppendDID,
																								SELF.homephone := LEFT.phone,
																								SELF.zip4      := LEFT.z4,
																								SELF           := LEFT));
	SHARED dInPhone   := dAppendDIDsFormat(homephone != '');
	SHARED dInNoPhone := dAppendDIDsFormat(did != 0 and homephone = '' and inMod.TransactionType != PhoneFinder_Services.Constants.TransType.PhoneRiskAssessment);
	
	// Append best info
	SHARED dInNoPhoneBestInfo := PhoneFinder_Services.Functions.GetBestInfo(dInNoPhone);
	Suppress.MAC_Suppress(dInNoPhoneBestInfo,SHARED dinBestInfo,inMod.ApplicationType,Suppress.Constants.LinkTypes.DID,did,'','',FALSE,'',TRUE);
	// Search inhouse phone sources and gateways when phone number is provided
	dPhoneSearchResults := PhoneFinder_Services.PhoneSearch(dInPhone,inMod,dGateways);	
	
	// Waterfall process when only PII is provided
	dWaterfallResults := PhoneFinder_Services.DIDSearch(dInNoPhone,inMod,dGateways,dInNoPhoneBestInfo);

	//combine results to get phone metadata
 	SHARED dSearchRecs_pre		:= UNGROUP(dPhoneSearchResults + dWaterfallResults);
	
  SHARED dSearchRecs		 := dSearchRecs_pre(((did <> 0 AND fname <> ''AND lname <> '') OR typeflag = Phones.Constants.TypeFlag.DataSource_PV) OR listed_name <> '');
	
  SHARED dSubjectInfo := PhoneFinder_Services.Functions.GetSubjectInfo(dInPhone, dSearchRecs, inMod);
														
  ds_in_accu := IF(inMod.TransactionType = PhoneFinder_Services.Constants.TransType.PhoneRiskAssessment,
	                 project(dedup(sort(dInPhone, acctno), acctno),
									 transform(PhoneFinder_Services.Layouts.PhoneFinder.Accudata_in, self.acctno := left.acctno, self.phone := left.homephone)),
									 project(dSearchRecs(typeflag = Phones.Constants.TypeFlag.DataSource_PV), PhoneFinder_Services.Layouts.PhoneFinder.Accudata_in));
									 
 	AccuDataGateway := if(inMod.UseAccuData_ocn, dGateways(Gateway.Configuration.IsAccuDataOCN(servicename)));
  SHARED accu_porting := PhoneFinder_Services.GetAccuDataPhones.GetAccuData_Ocn_PortingData(ds_in_accu,
	                                                                                          AccuDataGateway[1]);	
	 accu_inport := PROJECT(accu_porting, PhoneFinder_Services.Layouts.PortedMetadata);	
	
	 SHARED ported_phones := IF(inMod.IncludePhoneMetadata, 
		                           PhoneFinder_Services.GetPhonesPortedMetadata(dSearchRecs,inMod,dGateways,dSubjectInfo,accu_inport(port_end_dt <> 0)),
															              dSearchRecs);																	 
   
	SHARED Zum_gw_recs := PhoneFinder_Services.GetZumigoIdentity_Records(ported_phones, dinBestInfo, inMod, dGateways);
	SHARED Zumigo_recs:= Zum_gw_recs.Zumigo_GLI;

	SHARED Zum_final := if(inMod.UseZumigoIdentity, Zumigo_recs, ported_phones);

	dSearchResultsUnfiltered := IF((inMod.IncludePhoneMetadata AND EXISTS(dSearchRecs))
																					OR (inMod.TransactionType = PhoneFinder_Services.Constants.TransType.PhoneRiskAssessment AND EXISTS(dInPhone))
																																	,PhoneFinder_Services.GetPhonesMetadata(Zum_final,inMod,dGateways,dinBestInfo,dInPhone,dSubjectInfo)
																																	,Zum_final);
    // restriction added here if plugin from batch is set to true ....
		//  if not then don't do any restrictions.																																	
   dSearchResultsUnfilteredFinal := IF (inMod.DirectMarketingSourcesOnly, 
	                                  dSearchResultsUnfiltered(src NOT IN (PhoneFinder_Services.Constants.BatchRestrictedDirectMarketingSourcesSet)), 
								                           dSearchResultsUnfiltered);																																	
  // output(dSearchResultsUnfiltered, named('dSearchResultsUnfiltered'));
	// output(dSearchResultsUnfilteredFinal, named('dSearchResultsUnfilteredFinal'));
	
	PhoneSearchResults:=UNGROUP(dSearchResultsUnfilteredFinal(acctno IN SET(dInPhone,acctno)));
	DidSearchResults	:=UNGROUP(dSearchResultsUnfilteredFinal(acctno NOT IN SET(dInPhone,acctno)));
	// Format to batch out layout
	SHARED dFormat2Batch := IF( EXISTS(dInPhone),
															PhoneFinder_Services.Functions.FormatResults2Batch( dAppendDIDs(phone != '' and err_search = 0),inMod,
																																									DATASET([],PhoneFinder_Services.Layouts.BatchInAppendDID),
																																									PhoneSearchResults,TRUE)) +
													IF( EXISTS(dInNoPhone),
															PhoneFinder_Services.Functions.FormatResults2Batch( dAppendDIDs(phone = '' and err_search = 0),inMod,
																																									dinBestInfo,DidSearchResults,FALSE));
 	
 // Royalties	
 dSearchResultsFilter := dSearchRecs_pre(typeflag != Phones.Constants.TypeFlag.DataSource_PV);
   	
 // Sort and dedup data
 dResultsDIDDedup   := DEDUP(SORT(dSearchResultsFilter(did != 0),acctno,did,phone,-dt_last_seen,RECORD),acctno,did,phone);
 dResultsNoDIDDedup := DEDUP(SORT(dSearchResultsFilter(did = 0),
   																		acctno,fname,mname,lname,name_suffix,listed_name,
   																		prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,
   																		city_name,st,zip,zip4,county_code,county_name,phone,-dt_last_seen,RECORD),
   															acctno,fname,mname,lname,name_suffix,listed_name,
   															prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,
   															city_name,st,zip,zip4,county_code,county_name,phone);
   	
 SHARED dResultsDedup := dResultsDIDDedup + dResultsNoDIDDedup;
   	
 accu_royalty := project(accu_porting, transform(PhoneFinder_Services.Layouts.PhoneFinder.Final, self.acctno := left.acctno, self.typeflag := left.typeflag, 
   																				self.phone := left.phone, self := [])); // accudata_ocn royalty
																					
 SHARED dResultsDedup_More := dResultsDedup + accu_royalty + Zum_final;	
   	
 SHARED dResultsDedupQSent := dResultsDedup_More + dSearchRecs_pre(typeflag = Phones.Constants.TypeFlag.DataSource_PV);
 
 PhoneFinder_Services.Layouts.PhoneFinder.BatchOut tPopulateRoyalty(PhoneFinder_Services.Layouts.PhoneFinder.BatchOut le,PhoneFinder_Services.Layouts.PhoneFinder.Final ri) :=
 TRANSFORM
   		BOOLEAN vLastResortExists := ri.vendor_id = MDR.sourceTools.src_wired_Assets_Royalty;
   		BOOLEAN vMetronetExists   := ri.subj_phone_type_new = MDR.sourceTools.src_Metronet_Gateway;
   		BOOLEAN vQSentExists      := ri.vendor_id = MDR.sourceTools.src_Inhouse_QSent;
   		BOOLEAN vQSentIQ411Exists := ri.typeflag = Phones.Constants.TypeFlag.DataSource_iQ411;
   		BOOLEAN vQSentPVSExists   := ri.typeflag = Phones.Constants.TypeFlag.DataSource_PV;
   		BOOLEAN vTargusExists     := ri.vendor_id = MDR.sourceTools.src_Targus_Gateway;
   		BOOLEAN vEquifaxExists    := ri.subj_phone_type_new = MDR.sourceTools.src_EQUIFAX;
   		BOOLEAN vAccudata_ocnExists    := ri.typeflag = Phones.Constants.TypeFlag.AccuData_OCN; // accudata_ocn royalty
   		BOOLEAN vZumigoExists    := ri.rec_source = Phones.Constants.GatewayValues.ZumigoIdentity; // accudata_ocn royalty
   		
   		SELF.royalty_type_1 := IF(vLastResortExists,MDR.sourceTools.src_wired_Assets_Royalty,le.royalty_type_1);
   		SELF.royalty_src_1  := IF(vLastResortExists,MDR.sourceTools.src_wired_Assets_Royalty,le.royalty_src_1);
   		SELF.royalty_type_2 := IF(vMetronetExists,Royalty.Constants.RoyaltyType.METRONET,le.royalty_type_2);
   		SELF.royalty_src_2  := IF(vMetronetExists,MDR.sourceTools.src_Metronet_Gateway,le.royalty_src_2);
   		SELF.royalty_type_3 := IF(vQSentExists,Royalty.Constants.RoyaltyType.QSENT,le.royalty_type_3);
   		SELF.royalty_src_3  := IF(vQSentExists,MDR.sourceTools.src_Inhouse_QSent,le.royalty_src_3);
   		SELF.royalty_type_4 := IF(vQSentIQ411Exists,Royalty.Constants.RoyaltyType.QSENT_IQ411,le.royalty_type_4);
   		SELF.royalty_src_4  := IF(vQSentIQ411Exists,MDR.sourceTools.src_QSent_Gateway,le.royalty_src_4);
   		SELF.royalty_type_5 := IF(vQSentPVSExists,Royalty.Constants.RoyaltyType.QSENT_PVS,le.royalty_type_5);
   		SELF.royalty_src_5  := IF(vQSentPVSExists,MDR.sourceTools.src_QSent_Gateway,le.royalty_src_5);
   		SELF.royalty_type_6 := IF(vTargusExists,Royalty.Constants.RoyaltyType.TARGUS,le.royalty_type_6);
   		SELF.royalty_src_6  := IF(vTargusExists,MDR.sourceTools.src_Targus_Gateway,le.royalty_src_6);
   		SELF.royalty_type_7 := IF(vEquifaxExists,Royalty.Constants.RoyaltyType.EFX_DATA_MART,le.royalty_type_7);
   		SELF.royalty_src_7  := IF(vEquifaxExists,MDR.sourceTools.src_EQUIFAX,le.royalty_type_7);
   		SELF.royalty_type_8 := IF(vAccudata_ocnExists,Royalty.Constants.RoyaltyType.ACCUDATA_OCN_LNP,le.royalty_type_8); // accudata_ocn royalty
   		SELF.royalty_src_8  := IF(vAccudata_ocnExists,MDR.sourceTools.src_Phones_Accudata_OCN_LNP,le.royalty_src_8); // accudata_ocn royalty
			SELF.royalty_type_9 := IF(vZumigoExists,Royalty.Constants.RoyaltyType.ZUMIGO_IDENTITY,le.royalty_type_9); 
			SELF.royalty_src_9  := IF(vZumigoExists,MDR.sourceTools.src_Zumigo_GetLineId,le.royalty_src_9);
   		SELF                := le;
 END;
   	
 dResultsWithRoyalty := DENORMALIZE( dFormat2Batch,   																			
																				    dResultsDedupQsent,
   																			  LEFT.acctno = RIGHT.acctno,
   																			  tPopulateRoyalty(LEFT,RIGHT));
  																					
  //output(dFormat2Batch, named('dFormat2Batch'));																					
																	
   	
 BatchShare.MAC_RestoreAcctno(dAppendDIDs,dResultsWithRoyalty,EXPORT dBatchOut);
   	
 // Calculate royalties by acctno
 dRoyaltiesLastResort 	:= Royalty.RoyaltyLastResort.GetBatchRoyaltiesByAcctno(dAppendDIDs, dResultsDedup, vendor_id, phone);
 dResultsDedupMNR			:= dedup(sort(dResultsDedup, acctno, subj_phone_type_new), acctno, subj_phone_type_new); // to match the counters calculated in the denormalize step above
 dRoyaltiesMetronet 		:= Royalty.RoyaltyMetronet.GetBatchRoyaltiesByAcctno(dAppendDIDs, dResultsDedupMNR, subj_phone_type_new);
 dResultsDedupQSentR		:= dedup(sort(dResultsDedupQSent, acctno, vendor_id, typeflag), acctno, vendor_id, typeflag); // to match the counters calculated in the denormalize step above
 dRoyaltiesQSent 			:= Royalty.RoyaltyQSent.GetBatchRoyaltiesByAcctno(dAppendDIDs, dResultsDedupQSentR, vendor_id, typeflag);
 dRoyaltiesTargus 			:= Royalty.RoyaltyTargus.GetBatchRoyaltiesByAcctno(dAppendDIDs, dResultsDedup, vendor_id, targustype);
 dRoyaltiesEquifax			:= Royalty.RoyaltyEFXDataMart.GetBatchRoyaltiesByAcctno(dAppendDIDs, dResultsDedup, subj_phone_type_new);
 Accu_OCN_ddp          := dedup(sort(dResultsDedup_More,acctno, typeflag), acctno, typeflag);
 dRoyaltiesAccudata_ocn:= Royalty.RoyaltyAccudata.GetBatchRoyaltiesByAcctno(dAppendDIDs,Accu_OCN_ddp ,typeflag); // accudata_ocn royalty
 dRoyaltyZumGetIden := Royalty.RoyaltyZumigoGetLineIdentity.GetBatchRoyaltiesByAcctno(sort(Zum_final, acctno, phone,-rec_source), rec_source, phone, acctno);
   
 dRoyaltiesByAcctno := 
   		if(inMod.UseLastResort, dRoyaltiesLastResort) + 
   		if(inMod.UseInHouseQSent or inMod.UseQSent, dRoyaltiesQSent) + 
   		if(inMod.UseMetronet, dRoyaltiesMetronet) + 
   		if(inMod.UseTargus, dRoyaltiesTargus) +	
   		if(inMod.UseEquifax, dRoyaltiesEquifax) +	
   		if(inMod.UseAccudata_OCN, dRoyaltiesAccudata_ocn) +	 //accudata_ocn
   		if(inMod.UseZumigoIdentity, dRoyaltyZumGetIden) +	 //accudata_ocn
   		dataset([], Royalty.Layouts.RoyaltyForBatch);
   
  // Create RoyaltySet to be returned
 EXPORT dRoyalties := Royalty.GetBatchRoyalties(dRoyaltiesByAcctno, inMod.DetailedRoyalties);

 EXPORT Zumigo_History_Recs := IF(inMod.UseZumigoIdentity, Zum_gw_recs.Zumigo_Hist, DATASET([],Phones.Layouts.ZumigoIdentity.zOut));
END;