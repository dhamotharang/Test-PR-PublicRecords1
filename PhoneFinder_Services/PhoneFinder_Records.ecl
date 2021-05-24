IMPORT Autokey_Batch, BatchShare, Doxie, Gateway, iesp, MDR, Phones, Royalty, Suppress, STD;

EXPORT PhoneFinder_Records( DATASET(Autokey_batch.Layouts.rec_inBatchMaster) dIn,
                            PhoneFinder_Services.iParam.SearchParams         inMod,
                            DATASET(Gateway.Layouts.Config)                  dGateways,
                            iesp.phonefinder.t_PhoneFinderSearchBy           pSearchBy,
                            iesp.phonefinder.t_PhoneFinderSearchBy           InputEcho
                          ) :=
MODULE

  SHARED first_row := dIn[1];

  SHARED BOOLEAN vPhoneBlank := (UNSIGNED)first_row.homephone = 0;
  SHARED BOOLEAN vIsPhone10  := LENGTH(TRIM(first_row.homephone)) = 10;
  SHARED BOOLEAN vDIDBlank   := (UNSIGNED)first_row.did = 0;
  BOOLEAN vSSNBlank          := (UNSIGNED)first_row.ssn = 0;
  SHARED BOOLEAN vPIISearch  := (first_row.name_first != '' and first_row.name_last != '')  or ~vSSNBlank or ~vDIDBlank;

  BatchShare.MAC_CapitalizeInput(dIn, SHARED dProcessInput);

  // Modify IsPrimarySearchPII depending on input if value not provided
  SHARED tmpMod := MODULE(PROJECT(inMod, PhoneFinder_Services.iParam.SearchParams))
      EXPORT BOOLEAN IsPrimarySearchPII := inMod.IsPrimarySearchPII OR vPhoneBlank;
  END;

  SHARED IsPhoneRiskAssessment  := tmpMod.TransactionType = PhoneFinder_Services.Constants.TransType.PhoneRiskAssessment;
  SHARED IsValidTransactionType := tmpMod.TransactionType = PhoneFinder_Services.Constants.TransType.Blank;

  // Phone verification is a "phone only" search, even if the phone is blank.  If the phone is blank, the
  // verification will fail and the appropriate status will be returned.
  SHARED INTEGER verifyRequest := IF(tmpMod.VerifyPhoneIsActive, 1, 0) + IF(tmpMod.VerifyPhoneName, 1, 0) + IF(tmpMod.VerifyPhoneNameAddress, 1, 0) + IF(tmpMod.VerifyPhoneLastName, 1, 0);
  SHARED BOOLEAN verifyInputDID := (verifyRequest > 0) OR ~tmpMod.IsPrimarySearchPII;

  SHARED dGetDIDs := IF(~IsPhoneRiskAssessment AND vDIDBlank, PhoneFinder_Services.GetDIDs(dProcessInput));

  PhoneFinder_Services.Layouts.BatchInAppendDID tDIDs(Autokey_batch.Layouts.rec_inBatchMaster le,
                                                      PhoneFinder_Services.Layouts.BatchInAppendDID ri) :=
  TRANSFORM
    SELF.orig_did := le.did;
    SELF.did      := IF(ri.did != 0, ri.did, le.did);
    SELF          := le;
  END;

  SHARED dInDIDs := JOIN( dProcessInput,
                          dGetDIDs(did_count = 1), //Filter out records which got multiple DIDs
                          LEFT.acctno = RIGHT.acctno,
                          tDIDs(LEFT, RIGHT),
                          LEFT OUTER,
                          LIMIT(0), KEEP(1));

  SHARED dAppendDIDs := IF(vDIDBlank,
                            dInDIDs,
                            PROJECT(dProcessInput,
                                    TRANSFORM(PhoneFinder_Services.Layouts.BatchInAppendDID, SELF.orig_did := LEFT.did, SELF := LEFT)));

  // Split the input DATASET into two depending on the input criteria
  SHARED dInPhone   := dAppendDIDs(homephone != '');
  SHARED dPIISearch := dAppendDIDs(homephone = '' and did != 0 and ~IsPhoneRiskAssessment);

  // Best information
  SHARED dInNoPhoneBestInfo := PhoneFinder_Services.Functions.GetBestInfo(dPIISearch, PROJECT (inMod, doxie.IDataAccess));

  SHARED dInBest := IF(verifyInputDID, dInDIDs, dInNoPhoneBestInfo);

  // Primary identity
  Suppress.MAC_Suppress(dInBest, SHARED dInBestInfo, tmpMod.application_type, Suppress.Constants.LinkTypes.DID, did, '', '', FALSE, '', TRUE);

  // Search inhouse phone sources and gateways when phone number is provided
  dPhoneSearchResults := IF(EXISTS(dInPhone), PhoneFinder_Services.PhoneSearch(dInPhone, tmpMod, dGateways));

  // Waterfall process when only PII is provided
  dWaterfallResults := IF(EXISTS(dPIISearch), PhoneFinder_Services.DIDSearch(dPIISearch, tmpMod, dGateways, dInNoPhoneBestInfo));


  SHARED dSearchRecs_pre := IF(vPhoneBlank, dWaterfallResults, dPhoneSearchResults);

  dSearchRecs_pre_a := dSearchRecs_pre(((did <> 0 AND fname <> ''AND lname <> '') OR typeflag = Phones.Constants.TypeFlag.DataSource_PV) OR listed_name <> '');

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

  // zumigo call
  SHARED dZum_gw_recs := PhoneFinder_Services.GetZumigoIdentity_Records(dSearchRecs, dInBestInfo, tmpMod, dGateways);
  dZumigo_recs := dZum_gw_recs.Zumigo_GLI; // zumigo records

  SHARED dZum_final := IF(tmpMod.UseZumigoIdentity, dZumigo_recs, dSearchRecs);

  // Accudata OCN
  dAccuIn  := dZum_final(isPrimaryPhone);
  dDupAccuIn := PROJECT(DEDUP(SORT(dAccuIn, acctno), acctno), PhoneFinder_Services.Layouts.PhoneFinder.Accudata_in);

  AccuDataGateway := IF(tmpMod.UseAccuData_ocn, dGateways(Gateway.Configuration.IsAccuDataOCN(servicename)));

  SHARED dAccu_porting := PhoneFinder_Services.GetAccuDataPhones.GetAccuData_Ocn_PortingData(dDupAccuIn, AccuDataGateway[1]);

  SHARED dAccu_inport := PROJECT(dAccu_porting, PhoneFinder_Services.Layouts.PortedMetadata);

  // get ported info
  SHARED dSubjectInfo := PhoneFinder_Services.Functions.GetSubjectInfo(dZum_final, tmpMod);

  SHARED dPorted_Phones := IF(tmpMod.IsGetPortedData,
                              PhoneFinder_Services.GetPhonesPortedMetadata(dZum_final, tmpMod, dGateways, dSubjectInfo, dAccu_inport(port_end_dt <> 0)),
                              dZum_final);

  // get remaining phone metadata
  SHARED dPhoneMetadataResults := IF(tmpMod.IsGetMetaData,
                                      PhoneFinder_Services.GetPhonesMetadata(dPorted_Phones, tmpMod, dGateways, if(tmpMod.IsPrimarySearchPII, dInBestInfo), dSubjectInfo),
                                      dPorted_Phones);

  // Phone verfication, calculate PRIs
  SHARED dFinalResults_PRI := PhoneFinder_Services.GetPRIs(dPhoneMetadataResults, dInBestInfo, tmpMod, dGateways, dProcessInput);

  SHARED dFinalResults := $.GetSourceInformation(dFinalResults_PRI);

  inputOptionCheck := tmpMod.IncludeInhousePhones OR tmpMod.IncludeTargus OR tmpMod.IncludeAccudataOCN OR
                      tmpMod.IncludeEquifax OR tmpMod.IncludeTransUnionIQ411 OR tmpMod.IncludeTransUnionPVS OR
                      tmpMod.UseInHousePhoneMetadata OR tmpMod.IncludeOTP OR tmpMod.IncludePorting OR 
                      tmpMod.IncludeSpoofing OR tmpMod.InputZumigoOptions OR tmpMod.IncludePortingDetails;

  #IF(PhoneFinder_Services.Constants.Debug.Main)
    OUTPUT(dInPhone, NAMED('dInPhone'));
    OUTPUT(dPIISearch, NAMED('dPIISearch'));
    OUTPUT(dInBest, NAMED('dInBest'));
    OUTPUT(dSearchRecs, NAMED('dSearchRecs'));
    OUTPUT(dZum_final, NAMED('dZum_final'));
    OUTPUT(dSubjectInfo, NAMED('dSubjectInfo'));
    OUTPUT(dPorted_Phones, NAMED('dPorted_Phones'));
    OUTPUT(dPhoneMetadataResults, NAMED('dPhoneMetadataResults'));
    OUTPUT(dFinalResults_PRI, NAMED('dFinalResults_PRI'));
    OUTPUT(dFinalResults, NAMED('dFinalResults'));
  #END

  // Fail the service if multiple DIDs are returned for the search criteria OR if the phone number is not 10 digits OR if no records are returned
  MAP(inMod.IsPrimarySearchPII and verifyRequest > 0 => FAIL(303, doxie.ErrorCodes(303)),
     ~vPhoneBlank and ~vIsPhone10 => FAIL(301, doxie.ErrorCodes(301)),
      // FAIL the service if multiple subjects found
      vPhoneBlank and vDIDBlank and EXISTS(dGetDIDs(did_count > 1)) => FAIL(203, doxie.ErrorCodes(203)),
      // If phoneFinder were to run as a verification tool, only one type of verification should be selected.
      // If more than one type of verification is selected, fail the service.
      // Verification request requires a complete phone number.
      verifyRequest > 1                         => FAIL(100, PhoneFinder_Services.Constants.ErrorCodes(100)),
      ((BOOLEAN)verifyRequest AND ~vIsPhone10)  => FAIL(101, PhoneFinder_Services.Constants.ErrorCodes(101)),
      //If no trasaction type selected and no data source option selected
      IsValidTransactionType AND ~inputOptionCheck  => FAIL(102, PhoneFinder_Services.Constants.ErrorCodes(102)),
      vPhoneBlank and ~vPIISearch => FAIL(301, doxie.ErrorCodes(301)));

  // Format to iesp layout
  EXPORT dFormat2IESP := PhoneFinder_Services.Functions.FormatResults2IESP(dFinalResults, tmpMod);
  // EXPORT dFormat2IESP := dataset([], iesp.phonefinder.t_PhoneFinderSearchRecord);

  //Deltabase Logging Dataset
  EXPORT	ReportingDataset := 	PhoneFinder_Services.GetReportingRecords(dFormat2IESP, tmpMod, InputEcho);

  // Royalties
  // filtering out inhouse phonmetadata records
  dFilteringInHousePhoneData_typeflag := 	IF(tmpMod.UseInHousePhoneMetadataOnly,
                                              PROJECT(dSearchRecs_pre,
                                                      TRANSFORM(PhoneFinder_Services.Layouts.PhoneFinder.Final,
                                                                SELF.typeflag :=  IF(LEFT.typeflag = Phones.Constants.TypeFlag.DataSource_PV, '', LEFT.typeflag),
                                                                SELF.phone_source :=  IF(LEFT.phone_source = PhoneFinder_Services.Constants.PhoneSource.QSentGateway, 0, LEFT.phone_source),
                                                                SELF := LEFT)),
                                              dSearchRecs_pre);

  // Counting royalties before filtering recs - RQ 13804
  dSearchResultsFilter := dFilteringInHousePhoneData_typeflag(typeflag != Phones.Constants.TypeFlag.DataSource_PV);

  // Sort and dedup data
  dResultsDIDDedup   := DEDUP(SORT(dSearchResultsFilter(did != 0), acctno, did, phone, -dt_last_seen, RECORD), acctno, did, phone);
  dResultsNoDIDDedup := DEDUP(SORT(dSearchResultsFilter(did = 0),
                                    acctno, fname, mname, lname, name_suffix, listed_name,
                                    prim_range, predir, prim_name, suffix, postdir, unit_desig, sec_range,
                                    city_name, st, zip, zip4, county_code, county_name, phone, -dt_last_seen, RECORD),
                              acctno, fname, mname, lname, name_suffix, listed_name,
                              prim_range, predir, prim_name, suffix, postdir, unit_desig, sec_range,
                              city_name, st, zip, zip4, county_code, county_name, phone);

  dResultsDedup := dResultsDIDDedup + dResultsNoDIDDedup;

  dResultsDedupQSent := dResultsDedup + dFilteringInHousePhoneData_typeflag(typeflag = Phones.Constants.TypeFlag.DataSource_PV);

  Royalty.MAC_RoyaltyLastResort(dResultsDedup, dRoyaltyLR);
  Royalty.RoyaltyEFXDataMart.MAC_GetWebRoyalties(dResultsDedup, dRoyaltyEquifax, subj_phone_type_new, MDR.sourceTools.src_EQUIFAX);
  Royalty.MAC_RoyaltyQSENT(dResultsDedupQSent, dRoyaltyQSent, TRUE, TRUE);
  dRoyaltyTargus := Royalty.RoyaltyTargus.GetOnlineRoyalties(dResultsDedup, , , TRUE, FALSE, FALSE, FALSE);
  dRoyaltyAccOCN := Royalty.RoyaltyAccudata.GetOnlineRoyalties(dAccu_porting);
  dRoyaltyZumGetIden := Royalty.RoyaltyZumigoGetLineIdentity.GetOnlineRoyalties(DEDUP(SORT(dZum_final, phone, -rec_source), phone), rec_source);
  dRoyaltiesAccudata_CNAM  := Royalty.RoyaltyAccudata_CNAM.GetOnlineRoyalties(dFilteringInHousePhoneData_typeflag, subj_phone_type_new);

  EXPORT dRoyalties := IF(tmpMod.UseLastResort, dRoyaltyLR) +
                      IF(tmpMod.UseInHouseQSent OR inMod.UseQSent, dRoyaltyQSent) +
                      IF(tmpMod.UseTargus, dRoyaltyTargus) +
                      IF(tmpMod.UseEquifax, dRoyaltyEquifax) +
                      IF(tmpMod.UseAccuData_ocn, dRoyaltyAccOCN)+
                      IF(tmpMod.UseZumigoIdentity, dRoyaltyZumGetIden)+
                      IF(tmpMod.UseAccuData_CNAM, dRoyaltiesAccudata_CNAM);

  Zumigo_log_records := DATASET([{dZum_gw_recs.Zumigo_Hist}], Phones.Layouts.ZumigoIdentity.zDeltabaseLog);

  EXPORT Zumigo_History_Recs := IF(inMod.UseZumigoIdentity, Zumigo_log_records , DATASET([], Phones.Layouts.ZumigoIdentity.zDeltabaseLog));

END;
