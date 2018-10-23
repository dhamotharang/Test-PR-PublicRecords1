import doxie, iesp, Alerts, AutoStandardI, Gateway, fcra, suppress, FFD, ut;
 
export LiensSearchService_records(LiensV2_Services.IParam.search_params in_params,
                                  boolean isFCRA=false) := function

  boolean isCollections := in_params.applicationType IN AutoStandardI.Constants.COLLECTION_TYPES;
  boolean returnByDidOnly := (in_params.subject_only or isCollections) and isFCRA;
   //12/1/2010 - ids might contain 2 records, if FCRA allows DeepDive in the future these 2 records need to be considered when
   //creating rsrt2.    rsrt1 code currently handles the possiblity of 2 records in ids.
  ids_pre := liensv2_services.LiensSearchService_ids(in_params, , isFCRA);
  
  // D2C filter
  isCSMR := ut.IndustryClass.is_Knowx;
  ids := ids_pre(~LiensV2_Services.Functions.isRestricted(isCSMR, tmsid));
  
  tmsids := dedup(project(ids, liensv2_services.layout_TMSID), all);

  //FCRA FFD 
  gateways := Gateway.Configuration.Get();
  boolean ShowConsumerStatements := FFD.FFDMask.isShowConsumerStatements(in_params.FFDOptionsMask);

  // 1) Get the DID
  
  dsDIDs := dataset([{FFD.Constants.SingleSearchAcctno,
                        (unsigned)in_params.DID}],FFD.Layouts.DidBatch);
  // 2) Call the person context
  pc_recs := if(isFCRA, FFD.FetchPersonContext(dsDIDs, gateways, FFD.Constants.DataGroupSet.Liens, in_params.FFDOptionsMask));
   
  // 3)Slim down the PersonContext
  
  slim_pc_recs    := FFD.SlimPersonContext(pc_recs);
  
  rpen := liensv2_services.liens_raw.report_view.by_tmsid(tmsids,in_params.ssnmask,IsFCRA,in_params.FilingJurisdiction, 
                                                          in_params.person_filter_id,,in_params.applicationType,
                                                          in_params.includeCriminalIndicators,slim_pc_recs,
                                                          in_params.FFDOptionsMask,in_params.FCRAPurpose);  
  //don't dedup when same tmsid is found via DeepDive and non-DeepDive just yet.
  //let them get filtered first 
  rdd := join(rpen, dedup(sort(ids,tmsid,isDeepDive), tmsid,isDeepDive), 
        left.tmsid = right.tmsid,
        transform(liensv2_services.layout_lien_rollup
                  , self.isDeepDive := right.isDeepDive
                  , self.matched_party := IF(not right.isDeepDive,left.matched_party)
                  ,self := left),
        left outer);

  //don't throw away any records found via DeepDive reqardless of penalty
  rsrt_valid := rdd(penalt <= in_params.pt or isDeepDive);
  // now keep the non-deepDive over the DeepDive if same tmsid.
  rsrt1 := dedup(sort(rsrt_valid,tmsid,if(isDeepDive, 1, 0)), tmsid);            

  // ============ OVERRIDES (FCRA-version only) ===============
  // Moved into its own function instead of having same code in multiple places
  // Platform bug 62430 work around implemented in bug 60435.
  ds_best := project(rpen, 
                    transform(doxie.layout_best, 
                              first_party := if(~returnByDidOnly, normalize(left.debtors, left.parsed_parties,
                                                                          transform(right))[1]);
                              self.ssn := first_party.ssn,                            
                              self.fname := first_party.fname,
                              self.lname := first_party.lname,
                              self.did := if(returnByDidOnly, (unsigned)in_params.did,(unsigned)first_party.did), 
                              self :=[]) );
  //get flag records
  // !!! pc_recs is based on input LexId only, while ds_best is based on 1st debtor record data - not sure if there is functionality to push input subject as 1st debtor - need to be addressed
  
  ds_flags := FFD.GetFlagFile (dedup(ds_best, all), pc_recs);
  
  //output(ut.PrintLayout(rpen),named('rpen'),EXTEND);  
  
  // !!! applying overrides after processing of Data Under Dispute and Consumer statements - seems incorrect approach - may cause lost DUD/CS
  // to be addressed: we need to process overrides before DUD/CS 
  rsrt2 := LiensV2_Services.fn_applyFcraOverrides(rpen, ds_flags, in_params.ssnmask, in_params.includeCriminalIndicators ,
                                                  slim_pc_recs,in_params.FFDOptionsMask);

  rsrt_choose := if(isFCRA, rsrt2, rsrt1);
      
  subject_recs := project(rpen, 
                          transform(LiensV2_Services.layout_ids, 
                                    first_party := if(~returnByDidOnly, normalize(left.debtors, left.parsed_parties,
                                                                                transform(right))[1]);
                                    self.did := if(returnByDidOnly, (unsigned)in_params.did,(unsigned)first_party.did), 
                                    self.tmsid := left.tmsid,
                                    self.acctno := left.acctno) );
  rsrt_nss := if(in_params.non_subject_suppression <> Suppress.Constants.NonSubjectSuppression.doNothing, 
                  LiensV2_Services.fn_applyNonSubjectSuppression(rsrt_choose, subject_recs, in_params.non_subject_suppression),
                  rsrt_choose);
   
  rsrt := sort(rsrt_nss(penalt <= in_params.pt or isDeepDive), if(isDeepDive, 1, 0), penalt, -orig_filing_date, -release_Date, filing_jurisdiction, orig_filing_number, record);
  
  alert_indicators := FFD.ConsumerFlag.getAlertIndicators(pc_recs, in_params.FCRAPurpose, in_params.FFDOptionsMask)[1];
  suppress_results_due_alerts := isFCRA and alert_indicators.suppress_records;
  
  // 5 Get all the statementids 
  consumer_statements := if(IsFCRA and ShowConsumerStatements, FFD.prepareConsumerStatements(PC_Recs), 
                            FFD.Constants.BlankConsumerStatements);
    
  consumer_alerts := if(isFCRA, FFD.ConsumerFlag.prepareAlertMessages(pc_recs, alert_indicators, in_params.FFDOptionsMask), FFD.Constants.BlankConsumerAlerts);
                                       
  MaxResults_val := in_params.maxResults;
  Alerts.mac_ProcessAlerts(rsrt,liensv2_Services.alert,rsrt_withalert);
  
  rsrt_final := if (suppress_results_due_alerts, dataset([],LiensV2_Services.layout_lien_rollup), rsrt_withalert);
  
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

  
  return  results_combined;
end;

