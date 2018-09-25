IMPORT Autokey_Batch,BatchShare,Doxie,Gateway,iesp,MDR,Phones,Royalty,Suppress;

EXPORT PhoneFinder_Records( DATASET(Autokey_batch.Layouts.rec_inBatchMaster) dIn,
														PhoneFinder_Services.iParam.ReportParams         inMod,
														DATASET(Gateway.Layouts.Config)                  dGateways,
														iesp.phonefinder.t_PhoneFinderSearchBy           pSearchBy,
														iesp.phonefinder.t_PhoneFinderSearchBy           InputEcho
													) :=
MODULE

	SHARED first_row := dIn[1];
	
	SHARED BOOLEAN vPhoneBlank := (UNSIGNED)first_row.homephone = 0;
	SHARED BOOLEAN vIsPhone10  := LENGTH(TRIM(first_row.homephone)) = 10;
	SHARED BOOLEAN vDIDBlank   := (UNSIGNED)first_row.did = 0;
	BatchShare.MAC_CapitalizeInput(dIn, SHARED dProcessInput);

  SHARED IsPhoneRiskAssessment	:= inMod.TransactionType = PhoneFinder_Services.Constants.TransType.PhoneRiskAssessment;
  SHARED IsValidTransactionType	:= inMod.TransactionType = PhoneFinder_Services.Constants.TransType.Blank;
  
  dEmpty_dids := DATASET([],PhoneFinder_Services.Layouts.BatchInAppendDID);
	
	 useADL := vPhoneBlank OR (vIsPhone10 AND (inMod.VerifyPhoneNameAddress OR inMod.VerifyPhoneName));	
	
	 SHARED dGetDIDs := IF(IsPhoneRiskAssessment, dEmpty_dids,
	                    PhoneFinder_Services.GetDIDs(dProcessInput, useADL));						
	
																					
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
	SHARED dInNoPhone := dAppendDIDs(homephone = '' and did != 0 and ~IsPhoneRiskAssessment);

	// Best information
	SHARED dInNoPhoneBestInfo := PhoneFinder_Services.Functions.GetBestInfo(dInNoPhone);

	// Primary identity		
	Suppress.MAC_Suppress(dInNoPhoneBestInfo, SHARED dinBestInfo,
													inMod.ApplicationType,Suppress.Constants.LinkTypes.DID,did,'','',FALSE,'',TRUE);
												
	// Search inhouse phone sources and gateways when phone number is provided
	dPhoneSearchResults := IF(EXISTS(dInPhone),PhoneFinder_Services.PhoneSearch(dInPhone,inMod,dGateways));

	// Waterfall process when only PII is provided
	dWaterfallResults := IF(EXISTS(dInNoPhone),PhoneFinder_Services.DIDSearch(dInNoPhone,inMod,dGateways,dInNoPhoneBestInfo));
	

	SHARED dSearchRecs_pre		     := IF(vPhoneBlank,dWaterfallResults,dPhoneSearchResults);
	
	dSearchRecs_pre_a		 := dSearchRecs_pre(((did <> 0 AND fname <> ''AND lname <> '') OR typeflag = Phones.Constants.TypeFlag.DataSource_PV) OR listed_name <> '');
	
 PhoneFinder_Services.Layouts.PhoneFinder.Final withInputphone(PhoneFinder_Services.Layouts.BatchInAppendDID L) := TRANSFORM
  SELF.acctno               := L.acctno;
	 SELF.seq                  := L.seq;
	 SELF.phone                := L.homephone;
	 SELF.batch_in.homephone   := L.homephone;
	 SELF.phonestatus          := PhoneFinder_Services.Constants.PhoneStatus.NotAvailable;
		SELF                      := [];
 END;

 SHARED dSearchRecs := IF(IsPhoneRiskAssessment,
                     PROJECT(dInPhone, withInputphone(LEFT)), dSearchRecs_pre_a);
 
 SHARED dSubjectInfo := PhoneFinder_Services.Functions.GetSubjectInfo(dSearchRecs, inMod);

 dAccuIn  := dSearchRecs(isprimaryphone OR batch_in.homephone<>'');
                   
 dDupAccuIn := PROJECT(DEDUP(SORT(dAccuIn, acctno), acctno), PhoneFinder_Services.Layouts.PhoneFinder.Accudata_in);
									 
 AccuDataGateway := IF(inMod.UseAccuData_ocn, dGateways(Gateway.Configuration.IsAccuDataOCN(servicename)));
 SHARED dAccu_porting := PhoneFinder_Services.GetAccuDataPhones.GetAccuData_Ocn_PortingData(dDupAccuIn,
   	                                                                                       AccuDataGateway[1]);		   
 dAccu_inport := PROJECT(dAccu_porting, PhoneFinder_Services.Layouts.PortedMetadata);
	
	// get ported info
	SHARED dPorted_Phones := IF(inMod.IsGetPortedData, 
		                           PhoneFinder_Services.GetPhonesPortedMetadata(dSearchRecs,inMod,dGateways,dSubjectInfo,dAccu_inport(port_end_dt <> 0)),
															              dSearchRecs);
	 
	// zumigo call														 
	SHARED dZum_gw_recs := PhoneFinder_Services.GetZumigoIdentity_Records(dPorted_Phones, dinBestInfo, inMod, dGateways);
	SHARED dZumigo_recs:= dZum_gw_recs.Zumigo_GLI; // zumigo records
	
	SHARED dZum_final := IF(inMod.UseZumigoIdentity, dZumigo_recs, dPorted_Phones);

  // get remaining phone metadata
 SHARED dSearchResultsUnfiltered := IF(inMod.IsGetMetaData
      																												,PhoneFinder_Services.GetPhonesMetadata(dZum_final,inMod,dGateways,dinBestInfo,dSubjectInfo)
      																												,dZum_final);	

 inputOptionCheck := inMod.IncludeInhousePhones OR inMod.IncludeTargus OR inMod.IncludeAccudataOCN OR 
                     inMod.IncludeEquifax OR inMod.IncludeTransUnionIQ411 OR inMod.IncludeTransUnionPVS OR 
                     inMod.UseInHousePhoneMetadata OR inMod.IncludeOTP OR inMod.IncludePorting OR inMod.IncludeSpoofing OR inMod.InputZumigoOptions;
                  
  verifyRequest := (INTEGER)inMod.VerifyPhoneIsActive + (INTEGER)inMod.VerifyPhoneName + (INTEGER)inMod.VerifyPhoneNameAddress;
         	
  // Fail the service if multiple DIDs are returned for the search criteria OR if the phone number is not 10 digits OR if no records are returned
  MAP(~vPhoneBlank and ~vIsPhone10                    => FAIL(301,doxie.ErrorCodes(301)),
      vPhoneBlank and EXISTS(dGetDIDs(did_count > 1)) => FAIL(203,doxie.ErrorCodes(203)), //FAIL the service if no records exists
        // If phoneFinder were to run as a verification tool, only one type of verification should be selected.
       // If more than one type of verification is selected, fail the service.			
        // Verification request requires a complete phone number.			
      verifyRequest > 1																=> FAIL(100,PhoneFinder_Services.Constants.ErrorCodes(100)),
      ((BOOLEAN)verifyRequest AND ~vIsPhone10)				=> FAIL(101,PhoneFinder_Services.Constants.ErrorCodes(101)),
      //If no trasaction type selected and no data source option selected
     IsValidTransactionType AND ~inputOptionCheck  => FAIL(102,PhoneFinder_Services.Constants.ErrorCodes(102))); 
         
      /*Phone verification is a "phone only" search, even if the phone is blank.  If the phone is blank, the 
      verification will fail and the appropriate status will be returned. */
  verifyInputDID := inMod.VerifyPhoneName OR inMod.VerifyPhoneNameAddress;
  dinBestDID := 	if(verifyInputDID, dInDIDs,DATASET([],PhoneFinder_Services.Layouts.BatchInAppendDID));// for lexid verification
  EXPORT dFormat2IESP := IF(~vPhoneBlank OR inMod.VerifyPhoneIsActive OR inMod.VerifyPhoneName OR inMod.VerifyPhoneNameAddress,
            														PhoneFinder_Services.Functions.FormatResults2IESP(pSearchBy, inMod, dinBestDID, dSearchResultsUnfiltered,TRUE),
            														PhoneFinder_Services.Functions.FormatResults2IESP(pSearchBy, inMod,dinBestInfo,dSearchResultsUnfiltered,FALSE));
																				
   																				
 //Deltabase Logging Dataset
 EXPORT	ReportingDataset := 	PhoneFinder_Services.Get_Reporting_Records(dFormat2IESP, inMod, InputEcho);																		
         	 
 // Royalties
 // filtering out inhouse phonmetadata records 
 dFilteringInHousePhoneData_typeflag := 	IF(inMod.UseInHousePhoneMetadata, PROJECT(dSearchRecs_pre, TRANSFORM(PhoneFinder_Services.Layouts.PhoneFinder.Final, 
   		                                                            SELF.typeflag :=  IF(LEFT.typeflag = 'P', '', LEFT.typeflag),
   																																                              SELF.phone_source :=  IF(LEFT.phone_source = PhoneFinder_Services.Constants.PhoneSource.QSentGateway, 
   																																                                                       0, LEFT.phone_source),
   																																
   																																    SELf := LEFT)),dSearchRecs_pre);
   
 // Counting royalties before filtering recs - RQ 13804
 dSearchResultsFilter := dFilteringInHousePhoneData_typeflag(typeflag != Phones.Constants.TypeFlag.DataSource_PV);
            	
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
            	
 dResultsDedupQSent := dResultsDedup + dFilteringInHousePhoneData_typeflag(typeflag = Phones.Constants.TypeFlag.DataSource_PV);
     	
 Royalty.MAC_RoyaltyLastResort(dResultsDedup,dRoyaltyLR);
 Royalty.RoyaltyEFXDataMart.MAC_GetWebRoyalties(dResultsDedup,dRoyaltyEquifax,subj_phone_type_new,MDR.sourceTools.src_EQUIFAX);
 Royalty.MAC_RoyaltyQSENT(dResultsDedupQSent,dRoyaltyQSent,TRUE,TRUE); 
 dRoyaltyTargus := Royalty.RoyaltyTargus.GetOnlineRoyalties(dResultsDedup,,,TRUE, FALSE, FALSE, FALSE);
 dRoyaltyAccOCN := Royalty.RoyaltyAccudata.GetOnlineRoyalties(dAccu_porting);
 dRoyaltyZumGetIden := Royalty.RoyaltyZumigoGetLineIdentity.GetOnlineRoyalties(dedup(sort(dZum_final,phone,-rec_source), phone), rec_source);
 dRoyalty_ATT_LIDB := Royalty.RoyaltyATT.GetOnlineRoyalties(dFilteringInHousePhoneData_typeflag, src);		
 dRoyaltiesAccudata_CNAM  := Royalty.RoyaltyAccudata_CNAM.GetOnlineRoyalties(dFilteringInHousePhoneData_typeflag,subj_phone_type_new);
            	
 EXPORT dRoyalties := if(inMod.UseLastResort, dRoyaltyLR) + 
               		if(inMod.UseInHouseQSent or inMod.UseQSent, dRoyaltyQSent) + 
               		if(inMod.UseTargus, dRoyaltyTargus) + 
               		if(inMod.UseEquifax, dRoyaltyEquifax) + 
               		if(inMod.UseAccuData_ocn, dRoyaltyAccOCN)+
               		if(inMod.UseZumigoIdentity, dRoyaltyZumGetIden)+
                if(inMod.UseInHousePhoneMetadata, dRoyalty_ATT_LIDB)+
                 if(inMod.UseAccuData_CNAM, dRoyaltiesAccudata_CNAM);
      
 Zumigo_log_records := DATASET([{dZum_gw_recs.Zumigo_Hist}], Phones.Layouts.ZumigoIdentity.zDeltabaseLog);
      								 
 EXPORT Zumigo_History_Recs := IF(inMod.UseZumigoIdentity, Zumigo_log_records , DATASET([],Phones.Layouts.ZumigoIdentity.zDeltabaseLog));

END;
