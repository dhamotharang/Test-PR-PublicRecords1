IMPORT doxie, FCRA, suppress, FFD, iesp, Gateway;

EXPORT WatercraftSearch(WatercraftV2_services.Interfaces.Search_Params in_params,
                        BOOLEAN isFCRA = FALSE) := FUNCTION

  ids := DEDUP(SORT(Watercraftv2_services.WatercraftSearchService_ids(in_params, isFCRA),
                       watercraft_key,state_origin,sequence_key,IF(isDeepDive,1,0)),
                  watercraft_key,state_origin,sequence_key);
  
  // corrections on FCRA side require using overrides flag file. If isFCRA, then we have a DID in incoming in_params
  did_rec := IF(isFCRA, PROJECT(DATASET([{in_params.did}], doxie.layout_references), doxie.layout_best));
  
  //FCRA FFD
  BOOLEAN ShowConsumerStatements := FFD.FFDMask.isShowConsumerStatements(in_params.FFDOptionsMask);
  gateways := Gateway.Configuration.Get();
                                       
  dsDIDs := DATASET([{FFD.Constants.SingleSearchAcctno,in_params.did}],FFD.Layouts.DidBatch);

  pc_recs := IF(isFCRA, FFD.FetchPersonContext(dsDIDs, gateways, FFD.Constants.DataGroupSet.Watercraft, in_params.FFDOptionsMask));
  
  slim_pc_recs := FFD.SlimPersonContext(pc_recs);
  
  ds_flags := IF(isFCRA, FFD.GetFlagFile(did_rec, pc_recs), FCRA.compliance.blank_flagfile);

  watercraft_r := watercraftV2_services.get_watercraft(ids, in_params.ssn_mask, isFCRA, ds_flags,
                                                        in_params.include_non_regulated_sources,
                                                        slim_pc_recs, in_params.FFDOptionsMask).search();
                                                        
  alert_indicators := FFD.ConsumerFlag.getAlertIndicators(pc_recs, in_params.FCRAPurpose, in_params.FFDOptionsMask)[1];
  suppress_results_due_alerts := isFCRA AND alert_indicators.suppress_records;

  consumer_statements := IF(IsFCRA AND ShowConsumerStatements, FFD.prepareConsumerStatements(pc_recs), FFD.Constants.BlankConsumerStatements);
  consumer_alerts := IF(isFCRA, FFD.ConsumerFlag.prepareAlertMessages(pc_recs, alert_indicators, in_params.FFDOptionsMask), FFD.Constants.BlankConsumerAlerts);
                  
  //Handle non-subject found records
  WatercraftV2_Services.Layouts.search_out xformNonSubject(WatercraftV2_Services.Layouts.search_out L) := TRANSFORM
    owners_supp := PROJECT(L.owners((INTEGER)did = (INTEGER)in_params.did OR (bdid <> '' OR company_name <> '')),
                                  TRANSFORM(WatercraftV2_Services.Layouts.owner_search_rec,
                                            SELF.orig_name := '',
                                            SELF := LEFT));
    owners_restricted := PROJECT(L.owners(~((INTEGER)did = (INTEGER)in_params.did OR (bdid <> '' OR company_name <> ''))),
                                               TRANSFORM(WatercraftV2_Services.Layouts.owner_search_rec,
                                                         SELF.lname := FCRA.Constants.FCRA_Restricted, SELF := []));
    owners_returnNameOnly := PROJECT(L.owners(~((INTEGER)did = (INTEGER)in_params.did OR (bdid <> '' OR company_name <> ''))),
                                               TRANSFORM(WatercraftV2_Services.Layouts.owner_search_rec,
                                                         SELF.fname := LEFT.fname,
                                                         SELF.mname := LEFT.mname,
                                                         SELF.lname := LEFT.lname,
                                                         SELF.name_suffix := LEFT.name_suffix,
                                                         SELF := []));
    SELF.owners := MAP(in_params.non_subject_suppression = Suppress.Constants.NonSubjectSuppression.returnRestrictedDescription => owners_supp+ owners_restricted,
                       in_params.non_subject_suppression = Suppress.Constants.NonSubjectSuppression.returnNameOnly => owners_supp + owners_returnNameOnly,
                       in_params.non_subject_suppression = Suppress.Constants.NonSubjectSuppression.returnBlank => owners_supp,
                       L.owners);
    SELF := L;
  END;
  
  filter := PROJECT(watercraft_r, xformNonSubject(LEFT));
  rsrt := IF(in_params.non_subject_suppression <> Suppress.Constants.NonSubjectSuppression.doNothing, filter, watercraft_r);

  sort_rec := RECORD
    WatercraftV2_Services.Layouts.search_out;
    BOOLEAN sort_sequence;
  END;

  // the new input options MinVesselLength and MaxVesselLength will work as input option for new sorting functionality. When none of them is provided service returns the results in same order as before.
  final_presort := PROJECT(filter,
                    TRANSFORM(sort_rec,
                      SELF := LEFT,
                      SELF.sort_sequence:= MAP( in_params.min_vesl_len <> 0 AND in_params.max_vesl_len <> 0 AND LEFT.watercraft_length BETWEEN in_params.min_vesl_len AND in_params.max_vesl_len => TRUE,
                                                in_params.min_vesl_len <> 0 AND in_params.max_vesl_len = 0 AND LEFT.watercraft_length >= in_params.min_vesl_len => TRUE,
                                                in_params.min_vesl_len = 0 AND in_params.max_vesl_len <> 0 AND LEFT.watercraft_length <= in_params.max_vesl_len => TRUE,
                                                FALSE)));
  //Final Result
  final_rsrt := SORT(final_presort(isDeepDive OR penalt <= in_params.pt),-sort_sequence, penalt, -registration_date, -date_last_seen, -watercraft_key, -sequence_key, RECORD);

 recs := IF(suppress_results_due_alerts, DATASET([], sort_rec), final_rsrt);

  FFD.MAC.PrepareResultRecord(recs, final_rec, consumer_statements, consumer_alerts, sort_rec);
                             
  RETURN final_rec;

END;
