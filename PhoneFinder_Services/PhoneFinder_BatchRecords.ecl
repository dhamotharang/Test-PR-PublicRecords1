IMPORT Autokey_Batch, BatchShare, Gateway, MDR, Phones, PhoneFinder_Services, Royalty, Suppress, doxie;

  EXPORT PhoneFinder_BatchRecords(DATASET(PhoneFinder_Services.Layouts.BatchIn) dIn,
                                PhoneFinder_Services.iParam.SearchParams      inMod,
                                DATASET(Gateway.Layouts.Config)               dGateways
                                ) :=
  MODULE

  BatchShare.MAC_ProcessInput(dIn,SHARED dProcessInput);

  SHARED IsPhoneRiskAssessment	:= inMod.TransactionType = PhoneFinder_Services.Constants.TransType.PhoneRiskAssessment;

  SHARED doVerify := inMod.VerifyPhoneNameAddress OR inMod.VerifyPhoneName;

  // Format to common batch input layout
  Autokey_batch.Layouts.rec_inBatchMaster tFormat2BatchCommonInput(dProcessInput pInput) :=
  TRANSFORM
    SELF.seq       := (UNSIGNED)pInput.orig_acctno;
    SELF.homephone := pInput.phone;
    SELF.zip4      := pInput.z4;
    SELF           := pInput;
    SELF           := [];
  END;

  SHARED dFormat2BatchCommonInput := PROJECT(dProcessInput,tFormat2BatchCommonInput(LEFT));

  // DIDs
  dGetDIDs := IF(~IsPhoneRiskAssessment,
                  PhoneFinder_Services.GetDIDs(dFormat2BatchCommonInput(did = 0 and (homephone = '' or (homephone != '' and doVerify))), FALSE) +
                  PhoneFinder_Services.GetDIDs(dFormat2BatchCommonInput(did = 0 and homephone != ''), FALSE));

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
                      dGetDIDs(did_count = 1), //Filter out records which got multiple DIDs
                      LEFT.acctno = RIGHT.acctno,
                      tDIDs(LEFT,RIGHT),
                      LEFT OUTER,
                      LIMIT(PhoneFinder_Services.Constants.MaxDIDs, SKIP));

  // Need to keep records where we uniquely identified a DID
  SHARED dAppendDIDs := DEDUP(SORT(dAppendDIDs_,acctno),acctno);

  // Split the input dataset into two depending on the input criteria
  SHARED dAppendDIDsFormat := PROJECT(dAppendDIDs(err_search = 0),
                                      TRANSFORM(PhoneFinder_Services.Layouts.BatchInAppendDID,
                                                SELF.homephone := LEFT.phone,
                                                SELF.zip4      := LEFT.z4,
                                                SELF           := LEFT));

  SHARED IsValidTransactionType := inMod.TransactionType != PhoneFinder_Services.Constants.TransType.Blank;

  SHARED dInPhone   := dAppendDIDsFormat(homephone != '' AND isValidTransactionType);
  SHARED dInNoPhone := dAppendDIDsFormat(did != 0 and homephone = '' and ~IsPhoneRiskAssessment and IsValidTransactionType);

  // Append best info
  SHARED dInNoPhoneBestInfo := PhoneFinder_Services.Functions.GetBestInfo(dInNoPhone, PROJECT(inMod, doxie.IDataAccess));

  Suppress.MAC_Suppress(dInNoPhoneBestInfo,SHARED dInBestInfo,inMod.application_type,Suppress.Constants.LinkTypes.DID,did,'','',FALSE,'',TRUE);

  // Search inhouse phone sources and gateways when phone number is provided
  SHARED phoneMod := MODULE(PROJECT(inMod, $.iParam.SearchParams))
    EXPORT isPrimarySearchPII := FALSE;
  END;

  SHARED dPhoneSearchResults := PhoneFinder_Services.PhoneSearch(dInPhone,phoneMod,dGateways);

  // Waterfall process when only PII is provided
  SHARED piiMod := MODULE(PROJECT(inMod, $.iParam.SearchParams))
    EXPORT isPrimarySearchPII := TRUE;
  END;

  SHARED dWaterfallResults := PhoneFinder_Services.DIDSearch(dInNoPhone,piiMod,dGateways,dInNoPhoneBestInfo);

  // combine results to get phone metadata
  SHARED dSearchRecs_pre		:= UNGROUP(dPhoneSearchResults + dWaterfallResults);
  dSearchRecs_pre_a		 := dSearchRecs_pre(((did <> 0 AND fname <> ''AND lname <> '') OR typeflag = Phones.Constants.TypeFlag.DataSource_PV) OR listed_name <> '');

  dInputPhone := PROJECT(dInPhone,
                          TRANSFORM(PhoneFinder_Services.Layouts.PhoneFinder.Final,
                                    SELF.dob            := (INTEGER)LEFT.dob,
                                    SELF.dod            := (INTEGER)LEFT.dod,
                                    SELF.fname          := LEFT.name_first,
                                    SELF.mname          := LEFT.name_middle,
                                    SELF.lname          := LEFT.name_last,
                                    SELF.phone          := LEFT.homephone,
                                    SELF.suffix         := LEFT.addr_suffix,
                                    SELF.city_name      := LEFT.p_city_name,
                                    SELF.zip            := LEFT.z5,
                                    SELF.isPrimaryPhone := TRUE,
                                    SELF := LEFT, SELF := []));

  PhoneFinder_Services.Layouts.PhoneFinder.Final withInputphone(PhoneFinder_Services.Layouts.PhoneFinder.Final L) := TRANSFORM
    SELF.acctno               := L.acctno;
    SELF.seq                  := L.seq;
    SELF.phone                := L.phone;
    SELF.phonestatus          := L.phonestatus;
    BOOLEAN UsePVS            := L.typeflag = Phones.Constants.TypeFlag.DataSource_PV;
    SELF.coc_description      := L.coc_description;
    SELF.carrier_name         := L.carrier_name;
    SELF.phone_region_city    := L.phone_region_city;
    SELF.phone_region_st      := L.phone_region_st;
    SELF.RealTimePhone_Ext    := L.RealTimePhone_Ext;
    SELF.typeflag             := IF(UsePVS, L.typeflag, '');
    SELF                      := [];
  END;

  SHARED dSearchRecs := IF(IsPhoneRiskAssessment,
                            PROJECT(IF(EXISTS(dSearchRecs_pre), dSearchRecs_pre, dInputPhone), withInputphone(LEFT)),
                            dSearchRecs_pre_a);

  SHARED dSubjectInfo := PhoneFinder_Services.Functions.GetSubjectInfo(dSearchRecs, inMod);

  dAccuIn  := dSearchRecs(isPrimaryPhone);

  dDupAccuIn := PROJECT(DEDUP(SORT(dAccuIn, acctno), acctno), PhoneFinder_Services.Layouts.PhoneFinder.Accudata_in);

  AccuDataGateway := if(inMod.UseAccuData_ocn, dGateways(Gateway.Configuration.IsAccuDataOCN(servicename)));
  SHARED dAccu_porting := PhoneFinder_Services.GetAccuDataPhones.GetAccuData_Ocn_PortingData(dDupAccuIn, AccuDataGateway[1]);
  accu_inport := PROJECT(dAccu_porting, PhoneFinder_Services.Layouts.PortedMetadata);

  SHARED dPorted_phones := IF(inMod.IsGetPortedData,
                                PhoneFinder_Services.GetPhonesPortedMetadata(dSearchRecs,inMod,dGateways,dSubjectInfo,accu_inport(port_end_dt <> 0)),
                                dSearchRecs);

  SHARED dZum_gw_recs := PhoneFinder_Services.GetZumigoIdentity_Records(dPorted_phones, dInBestInfo, inMod, dGateways);
  SHARED dZumigo_recs:= dZum_gw_recs.Zumigo_GLI;

  SHARED dZum_final := if(inMod.UseZumigoIdentity, dZumigo_recs, dPorted_phones);

  dSearchResultsUnfiltered := IF(inMod.IsGetMetaData,
                                  PhoneFinder_Services.GetPhonesMetadata(dZum_final, inMod, dGateways, dInBestInfo, dSubjectInfo),
                                  dZum_final);

  // restriction added here if plugin from batch is set to true ....
  // if not then don't do any restrictions.
  SHARED dSearchResultsUnfilteredFinal := IF (inMod.DirectMarketingSourcesOnly,
                                              dSearchResultsUnfiltered(src NOT IN (PhoneFinder_Services.Constants.BatchRestrictedDirectMarketingSourcesSet)),
                                              dSearchResultsUnfiltered);

  SHARED PhoneSearchResults:=UNGROUP(dSearchResultsUnfilteredFinal(acctno IN SET(dInPhone,acctno)));
  SHARED DidSearchResults	:=UNGROUP(dSearchResultsUnfilteredFinal(acctno NOT IN SET(dInPhone,acctno)));

  SHARED dInBestDID := if(doVerify, dAppendDIDsFormat); // for lexid verification

  // Phone verfication, calculate PRIs
  SHARED dPhoneFinalResults := IF(EXISTS(dInPhone) OR doVerify, PhoneFinder_Services.GetPRIs(PhoneSearchResults, dInBestDID, phoneMod, dGateways, dInPhone));
  SHARED dDIDFinalResults   := IF(EXISTS(dInNoPhone), PhoneFinder_Services.GetPRIs(DidSearchResults, dInBestInfo, piiMod, dGateways, dInNoPhone));

  // OUTPUT(PhoneSearchResults, NAMED('PhoneSearchResults'));
  // OUTPUT(dPhoneFinalResults, NAMED('dPhoneFinalResults'));
  // OUTPUT(DidSearchResults, NAMED('DidSearchResults'));
  // OUTPUT(dDIDFinalResults, NAMED('dDIDFinalResults'));

  // Format to batch out layout
  SHARED dFormat2Batch := IF(EXISTS(dInPhone) OR doVerify,
                              PhoneFinder_Services.Functions.FormatResults2Batch(dPhoneFinalResults, dInPhone, phoneMod, TRUE)) +
                              IF(EXISTS(dInNoPhone), PhoneFinder_Services.Functions.FormatResults2Batch(dDIDFinalResults, dInNoPhone, piiMod, FALSE));

  // OUTPUT(dFormat2Batch, NAMED('dFormat2Batch'));

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

  accu_royalty := project(dAccu_porting, transform(PhoneFinder_Services.Layouts.PhoneFinder.Final, self.acctno := left.acctno, self.typeflag := left.typeflag,
                                          self.phone := left.phone, self := [])); // accudata_ocn royalty

  SHARED dResultsDedup_More := dResultsDedup + accu_royalty + dZum_final;

  SHARED dResultsDedupRecs := dResultsDedup_More + dSearchRecs_pre(typeflag = Phones.Constants.TypeFlag.DataSource_PV);

  // filtering out inhouse phonmetadata records
  SHARED dFilteringInHousePhoneData_typeflag := IF(inMod.UseInHousePhoneMetadataOnly,
                                                    PROJECT(dResultsDedupRecs,
                                                            TRANSFORM(PhoneFinder_Services.Layouts.PhoneFinder.Final,
                                                                      SELF.typeflag     :=  IF(LEFT.typeflag = 'P', '', LEFT.typeflag),
                                                                      SELF.phone_source :=  IF(LEFT.phone_source = PhoneFinder_Services.Constants.PhoneSource.QSentGateway, 0, LEFT.phone_source),
                                                                      SELF := LEFT)),
                                                    dResultsDedupRecs);

  PhoneFinder_Services.Layouts.PhoneFinder.BatchOut tPopulateRoyalty(PhoneFinder_Services.Layouts.PhoneFinder.BatchOut le,PhoneFinder_Services.Layouts.PhoneFinder.Final ri) :=
  TRANSFORM
      BOOLEAN vLastResortExists := ri.vendor_id = MDR.sourceTools.src_wired_Assets_Royalty;
      BOOLEAN vQSentExists      := ri.vendor_id = MDR.sourceTools.src_Inhouse_QSent;
      BOOLEAN vQSentIQ411Exists := ri.typeflag = Phones.Constants.TypeFlag.DataSource_iQ411;
      BOOLEAN vQSentPVSExists   := ri.typeflag = Phones.Constants.TypeFlag.DataSource_PV;
      BOOLEAN vTargusExists     := ri.vendor_id = MDR.sourceTools.src_Targus_Gateway;
      BOOLEAN vEquifaxExists    := ri.subj_phone_type_new = MDR.sourceTools.src_EQUIFAX;
      BOOLEAN vAccudata_ocnExists  := ri.typeflag = Phones.Constants.TypeFlag.AccuData_OCN; // accudata_ocn royalty
      BOOLEAN vZumigoExists        := ri.rec_source = Phones.Constants.GatewayValues.ZumigoIdentity; // Zumigo royalty
      BOOLEAN vAccudata_cnamExists := ri.subj_phone_type_new = MDR.sourceTools.src_Phones_Accudata_CNAM_CNM2; // accudata_cnam royalty

      SELF.royalty_type_1 := IF(vLastResortExists,MDR.sourceTools.src_wired_Assets_Royalty,le.royalty_type_1);
      SELF.royalty_src_1  := IF(vLastResortExists,MDR.sourceTools.src_wired_Assets_Royalty,le.royalty_src_1);
      // royalty_src_2 is Metronet, removed it as a part of Experian Removal Project
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
      SELF.royalty_type_10 := '';
      SELF.royalty_src_10  := '';
      SELF.royalty_type_11 := IF(vAccudata_cnamExists, Royalty.Constants.RoyaltyType.ACCUDATA_CNAM_CNM2, le.royalty_type_11);
      SELF.royalty_src_11  := IF(vAccudata_cnamExists, MDR.sourceTools.src_Phones_Accudata_CNAM_CNM2, le.royalty_src_11);
      SELF                 := le;
  END;

  dResultsWithRoyalty := DENORMALIZE(dFormat2Batch, dFilteringInHousePhoneData_typeflag,
                                      LEFT.acctno = RIGHT.acctno,
                                      tPopulateRoyalty(LEFT,RIGHT));

  BatchShare.MAC_RestoreAcctno(dAppendDIDs,dResultsWithRoyalty,EXPORT dBatchOut);

  // Calculate royalties by acctno
  dRoyaltiesLastResort 	    := Royalty.RoyaltyLastResort.GetBatchRoyaltiesByAcctno(dAppendDIDs, dResultsDedup, vendor_id, phone);
  dResultsDedupMNR			:= dedup(sort(dResultsDedup, acctno, subj_phone_type_new), acctno, subj_phone_type_new); // to match the counters calculated in the denormalize step above
  dResultsDedupQSentR		:= dedup(sort(dFilteringInHousePhoneData_typeflag, acctno, vendor_id, typeflag), acctno, vendor_id, typeflag); // to match the counters calculated in the denormalize step above
  dRoyaltiesQSent 			:= Royalty.RoyaltyQSent.GetBatchRoyaltiesByAcctno(dAppendDIDs, dResultsDedupQSentR, vendor_id, typeflag);
  dRoyaltiesTargus 			:= Royalty.RoyaltyTargus.GetBatchRoyaltiesByAcctno(dAppendDIDs, dResultsDedup, vendor_id, targustype);
  dRoyaltiesEquifax			:= Royalty.RoyaltyEFXDataMart.GetBatchRoyaltiesByAcctno(dAppendDIDs, dResultsDedup, subj_phone_type_new,,,MDR.sourceTools.src_EQUIFAX);
  Accu_OCN_ddp               := dedup(sort(dResultsDedup_More,acctno, typeflag), acctno, typeflag);
  dRoyaltiesAccudata_ocn     := Royalty.RoyaltyAccudata.GetBatchRoyaltiesByAcctno(dAppendDIDs,Accu_OCN_ddp ,typeflag); // accudata_ocn royalty
  dRoyaltyZumGetIden         := Royalty.RoyaltyZumigoGetLineIdentity.GetBatchRoyaltiesByAcctno(sort(dZum_final, acctno, phone,-rec_source), rec_source, phone, acctno);
  dRoyaltiesAccudata_CNAM    := Royalty.RoyaltyAccudata_CNAM.GetBatchRoyaltiesByAcctno(dFilteringInHousePhoneData_typeflag, subj_phone_type_new);

  dRoyaltiesByAcctno :=
      if(inMod.UseLastResort, dRoyaltiesLastResort) +
      if(inMod.UseInHouseQSent or inMod.UseQSent, dRoyaltiesQSent) +
      if(inMod.UseTargus, dRoyaltiesTargus) +
      if(inMod.UseEquifax, dRoyaltiesEquifax) +
      if(inMod.UseAccudata_OCN, dRoyaltiesAccudata_ocn) +	 //accudata_ocn
      if(inMod.UseZumigoIdentity, dRoyaltyZumGetIden) +	 //zumigo
    if(inMod.UseAccuData_CNAM, dRoyaltiesAccudata_CNAM) +
      dataset([], Royalty.Layouts.RoyaltyForBatch);

  // Create RoyaltySet to be returned
  EXPORT dRoyalties := Royalty.GetBatchRoyalties(dRoyaltiesByAcctno, inMod.DetailedRoyalties);

  Zumigo_log_records := DATASET([{dZum_gw_recs.Zumigo_Hist}], Phones.Layouts.ZumigoIdentity.zDeltabaseLog);

  EXPORT Zumigo_History_Recs := IF(inMod.UseZumigoIdentity, Zumigo_log_records, DATASET([],Phones.Layouts.ZumigoIdentity.zDeltabaseLog));
  END;
