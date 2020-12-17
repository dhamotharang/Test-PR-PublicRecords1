IMPORT doxie, iesp, Alerts, AutoStandardI, Gateway, fcra, suppress, FFD, ut;

EXPORT LiensSearchService_records(LiensV2_Services.IParam.search_params in_params,
                                  BOOLEAN isFCRA=FALSE) := FUNCTION

  BOOLEAN isCollections := in_params.applicationType IN AutoStandardI.Constants.COLLECTION_TYPES;
  BOOLEAN returnByDidOnly := (in_params.subject_only OR isCollections) AND isFCRA;
   //12/1/2010 - ids might contain 2 records, if FCRA allows DeepDive in the future these 2 records need to be considered when
   //creating rsrt2. rsrt1 code currently handles the possiblity of 2 records in ids.
  ids_pre := liensv2_services.LiensSearchService_ids(in_params, , isFCRA);

  // D2C filter
  isCSMR := ut.IndustryClass.is_Knowx;
  ids := ids_pre(~LiensV2_Services.Functions.isRestricted(isCSMR, tmsid));

  tmsids := DEDUP(PROJECT(ids, liensv2_services.layout_TMSID), ALL);

  //FCRA FFD
  gateways := Gateway.Configuration.Get();
  BOOLEAN ShowConsumerStatements := FFD.FFDMask.isShowConsumerStatements(in_params.FFDOptionsMask);

  // 1) Get the DID

  dsDIDs := DATASET([{FFD.Constants.SingleSearchAcctno,
    (UNSIGNED)in_params.DID}],FFD.Layouts.DidBatch);
  // 2) Call the person context
  pc_recs := IF(isFCRA, FFD.FetchPersonContext(dsDIDs, gateways, FFD.Constants.DataGroupSet.Liens, in_params.FFDOptionsMask));

  // 3)Slim down the PersonContext

  slim_pc_recs := FFD.SlimPersonContext(pc_recs);

  rpen := liensv2_services.liens_raw.report_view.by_tmsid(tmsids,in_params.ssnmask,IsFCRA,in_params.FilingJurisdiction,
                                                          in_params.person_filter_id,,in_params.applicationType,
                                                          in_params.includeCriminalIndicators,slim_pc_recs,
                                                          in_params.FFDOptionsMask,in_params.FCRAPurpose);
  //don't dedup when same tmsid is found via DeepDive and non-DeepDive just yet.
  //let them get filtered first
  rdd := JOIN(rpen, DEDUP(SORT(ids,tmsid,isDeepDive), tmsid,isDeepDive),
    LEFT.tmsid = RIGHT.tmsid,
    TRANSFORM(liensv2_services.layout_lien_rollup
              , SELF.isDeepDive := RIGHT.isDeepDive
              , SELF.matched_party := IF(NOT RIGHT.isDeepDive,LEFT.matched_party)
              , SELF := LEFT),
    LEFT OUTER);

  //don't throw away any records found via DeepDive reqardless of penalty
  rsrt_valid := rdd(penalt <= in_params.pt OR isDeepDive);
  // now keep the non-deepDive over the DeepDive if same tmsid.
  rsrt1 := DEDUP(SORT(rsrt_valid,tmsid,IF(isDeepDive, 1, 0)), tmsid);

  // ============ OVERRIDES (FCRA-version only) ===============
  // Moved into its own function instead of having same code in multiple places
  // Platform bug 62430 work around implemented in bug 60435.
  ds_best_first_party_lexid := PROJECT(rpen,
    TRANSFORM(doxie.layout_best,
      first_party := NORMALIZE(LEFT.debtors, LEFT.parsed_parties, TRANSFORM(RIGHT))[1];
      SELF.ssn := first_party.ssn,
      SELF.fname := first_party.fname,
      SELF.lname := first_party.lname,
      SELF.did := (UNSIGNED)first_party.did,
      SELF :=[]));

  ds_best_input_lexid := PROJECT(rpen,
    TRANSFORM(doxie.layout_best,
      SELF.did := (UNSIGNED6)in_params.did,
      SELF := []));

  ds_best := IF(returnByDidOnly, ds_best_input_lexid, ds_best_input_lexid + ds_best_first_party_lexid);

  //get flag records based on input_lexID, and if present, first_party lexID.
  ds_flags := FFD.GetFlagFile (DEDUP(ds_best, ALL), pc_recs);

  //output(ut.PrintLayout(rpen),named('rpen'),EXTEND);

  // !!! applying overrides after processing of Data Under Dispute and Consumer statements - seems incorrect approach - may cause lost DUD/CS
  // to be addressed: we need to process overrides before DUD/CS
  rsrt2 := LiensV2_Services.fn_applyFcraOverrides(rpen, ds_flags, in_params.ssnmask, in_params.includeCriminalIndicators ,
                                                  slim_pc_recs,in_params.FFDOptionsMask);

  rsrt_choose := IF(isFCRA, rsrt2, rsrt1);

  subject_recs := PROJECT(rpen,
                          TRANSFORM(LiensV2_Services.layout_ids,
                                    first_party := IF(~returnByDidOnly, NORMALIZE(LEFT.debtors, LEFT.parsed_parties,
                                                                                TRANSFORM(RIGHT))[1]);
                                    SELF.did := IF(returnByDidOnly, (UNSIGNED)in_params.did,(UNSIGNED)first_party.did),
                                    SELF.tmsid := LEFT.tmsid,
                                    SELF.acctno := LEFT.acctno) );
  rsrt_nss := IF(in_params.non_subject_suppression <> Suppress.Constants.NonSubjectSuppression.doNothing,
                  LiensV2_Services.fn_applyNonSubjectSuppression(rsrt_choose, subject_recs, in_params.non_subject_suppression),
                  rsrt_choose);

  rsrt := SORT(rsrt_nss(penalt <= in_params.pt OR isDeepDive), IF(isDeepDive, 1, 0), penalt, -orig_filing_date, -release_Date, filing_jurisdiction, orig_filing_number, RECORD);

  alert_indicators := FFD.ConsumerFlag.getAlertIndicators(pc_recs, in_params.FCRAPurpose, in_params.FFDOptionsMask)[1];
  suppress_results_due_alerts := isFCRA AND alert_indicators.suppress_records;

  // 5 Get all the statementids
  consumer_statements := IF(IsFCRA AND ShowConsumerStatements, FFD.prepareConsumerStatements(PC_Recs),
                            FFD.Constants.BlankConsumerStatements);

  consumer_alerts := IF(isFCRA, FFD.ConsumerFlag.prepareAlertMessages(pc_recs, alert_indicators, in_params.FFDOptionsMask), FFD.Constants.BlankConsumerAlerts);

  MaxResults_val := in_params.maxResults;
  Alerts.mac_ProcessAlerts(rsrt,liensv2_Services.alert,rsrt_withalert);

  rsrt_final := IF (suppress_results_due_alerts, DATASET([],LiensV2_Services.layout_lien_rollup), rsrt_withalert);

  FFD.MAC.PrepareResultRecord(rsrt_final, results_combined, consumer_statements, consumer_alerts, LiensV2_Services.layout_lien_rollup);


 // ============ START DEBUG =====================
    // output(ids_pre, named('ids_pre'));
    // output(ids, named('ids'));
    // output(tmsids, named('tmsids'));
    // output(dsDIDs,named('dsDIDs'));
    // output(PC_Recs, named('PC_Recs'));
    // output(slim_pc_recs, named('slim_pc_recs'));
    // output(rpen,named('rpen'));
     // output(rdd,named('rdd'));
    // output(rsrt1,named('rsrt1'));
    // output(ds_best,named('ds_best'));
    // output(ds_flags,named('ds_flags'));
     // output(rsrt_choose,named('rsrt_choose'));
    // output(subject_recs,named('subject_recs'));
    // output(rsrt_nss,named('rsrt_nss'));
     // output(rsrt,named('rsrt'));
    // output(consumer_statements,named('consumer_statements'));
    // output(rsrt_final,named('rsrt_final'));
    // ============ END DEBUG =====================


  RETURN results_combined;
END;

