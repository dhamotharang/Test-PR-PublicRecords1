IMPORT doxie, FCRA, Suppress, FFD, iesp, Gateway;

EXPORT WatercraftReport(WatercraftV2_services.Interfaces.report_Params in_params,
                        BOOLEAN isFCRA = FALSE) := FUNCTION
  
  ids := Watercraftv2_services.WatercraftReportService_ids(in_params, isFCRA);
  
  // corrections on FCRA side require using overrides flag file. If isFCRA, then we have a DID in incoming in_params
  did_rec := IF(isFCRA, PROJECT(DATASET([{in_params.did}], doxie.layout_references), TRANSFORM(doxie.layout_best, SELF:=LEFT,SELF:=[])));
  //FFD
  BOOLEAN ShowConsumerStatements := FFD.FFDMask.isShowConsumerStatements(in_params.FFDOptionsMask);
  gateways := Gateway.Configuration.Get();
                                       
  dsDIDs := DATASET([{FFD.Constants.SingleSearchAcctno,in_params.did}],
                        FFD.Layouts.DidBatch);
                        
  pc_recs := IF(isFCRA, FFD.FetchPersonContext(dsDIDs, gateways, FFD.Constants.DataGroupSet.Watercraft, in_params.FFDOptionsMask));

  slim_pc_recs := FFD.SlimPersonContext(pc_recs);

  ds_flags := IF (IsFCRA, FFD.GetFlagFile(did_rec, pc_recs), FCRA.compliance.blank_flagfile);

  prepr := WatercraftV2_services.WatercraftV2_raw.report_view.by_Watercraftkey(ids, in_params.ssn_mask,TRUE, isFCRA, ds_flags,
                                                                                in_params.include_non_regulated_sources,slim_pc_recs,
                                                                                in_params.FFDOptionsMask);

  alert_indicators := FFD.ConsumerFlag.getAlertIndicators(pc_recs, in_params.FCRAPurpose, in_params.FFDOptionsMask)[1];
  suppress_results_due_alerts := isFCRA AND alert_indicators.suppress_records;
    
  consumer_statements := IF(IsFCRA AND ShowConsumerStatements, FFD.prepareConsumerStatements(pc_recs), FFD.Constants.BlankConsumerStatements);
  consumer_alerts := IF(isFCRA, FFD.ConsumerFlag.prepareAlertMessages(pc_recs, alert_indicators, in_params.FFDOptionsMask), FFD.Constants.BlankConsumerAlerts);

  //use sort from prepr to determine the desired record to output
  summarized_prepr := DEDUP(prepr, watercraft_key);
  
  final_prepr := IF(in_params.summarize, summarized_prepr, prepr);
  
  //Handle non-subject found records
  WatercraftV2_Services.Layouts.report_out xformNonSubject(watercraftV2_Services.layouts.report_out L) := TRANSFORM
    owners_supp := PROJECT(L.owners((INTEGER)did = (INTEGER)in_params.did OR (bdid <> '' OR company_name <> '')),
                           TRANSFORM(WatercraftV2_Services.Layouts.owner_report_rec,
                                     SELF.orig_name := '',
                                     SELF := LEFT));
    owners_restricted := PROJECT(L.owners(~((INTEGER)did = (INTEGER)in_params.did OR (bdid <> '' OR company_name <> ''))),
                                               TRANSFORM(WatercraftV2_Services.Layouts.owner_report_rec,
                                                         SELF.lname := FCRA.Constants.FCRA_Restricted, SELF := []));
    owners_returnNameOnly := PROJECT(L.owners(~((INTEGER)did = (INTEGER)in_params.did OR (bdid <> '' OR company_name <> ''))),
                                               TRANSFORM(WatercraftV2_Services.Layouts.owner_report_rec,
                                                         SELF.fname := LEFT.fname,
                                                         SELF.mname := LEFT.mname,
                                                         SELF.lname := LEFT.lname,
                                                         SELF.name_suffix := LEFT.name_suffix,
                                                         SELF := []));
    SELF.owners := MAP(in_params.non_subject_suppression = Suppress.Constants.NonSubjectSuppression.returnRestrictedDescription => owners_supp + owners_restricted,
                       in_params.non_subject_suppression = Suppress.Constants.NonSubjectSuppression.returnNameOnly => owners_supp + owners_returnNameOnly,
                       in_params.non_subject_suppression = Suppress.Constants.NonSubjectSuppression.returnBlank => owners_supp,
                       L.owners);
    SELF := L;
  END;
  
  filter := PROJECT(final_prepr, xformNonSubject(LEFT));
  
  rsrt := IF(in_params.non_subject_suppression <> Suppress.Constants.NonSubjectSuppression.doNothing, filter, final_prepr);
  
  r :=rsrt(state_origin= in_params.st OR in_params.st='');
  
  final_rsrt := SORT(r, -registration_date, -date_last_seen, -watercraft_key, -sequence_key);
               
 recs := IF(suppress_results_due_alerts, DATASET([], WatercraftV2_Services.Layouts.report_out), final_rsrt);

  FFD.MAC.PrepareResultRecord(recs, final_rec, consumer_statements, consumer_alerts, WatercraftV2_Services.Layouts.report_out);
                             
  RETURN final_rec;

END;
