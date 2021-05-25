IMPORT Autokey_batch, BatchServices, DidVille, FraudShared, FraudShared_Services, IDLExternalLinking, RiskIntelligenceNetwork_Analytics,RiskIntelligenceNetwork_Services;

EXPORT BatchRecords(DATASET(RiskIntelligenceNetwork_Services.Layouts.BatchIn_rec) ds_batch_in,
                    RiskIntelligenceNetwork_Services.IParam.Params in_params) := FUNCTION
           
 _Layout := RiskIntelligenceNetwork_Services.Layouts;
 _Analytics_Layout := RiskIntelligenceNetwork_Analytics.Layouts;
 _Constant := RiskIntelligenceNetwork_Services.Constants;
 hasValue := RiskIntelligenceNetwork_Services.Functions.hasValue;

 ds_batch_in_with_did := ds_batch_in(did != 0);
 ds_batch_in_without_did := ds_batch_in(did = 0);

 // Validate input LexIDs
 ds_in_did_found_in_cr := JOIN(ds_batch_in_with_did, FraudShared.Key_Did(in_params.FraudPlatform),
                            KEYED(LEFT.did = RIGHT.did),
                            TRANSFORM(_Layout.dids_recs,
                             SELF.RecordSource := _Constant.RECORD_SOURCE.CONTRIBUTED,
                             SELF := LEFT,
                             SELF := []),
                            LIMIT(0), KEEP(1));
 
 ds_dids_not_in_cr := JOIN(ds_batch_in_with_did, ds_in_did_found_in_cr,
                       LEFT.did = RIGHT.did,
                       TRANSFORM(LEFT),
                       LEFT ONLY);
                        
 ds_batch_in_didValidation := IDLexternalLinking.did_getAllRecs_batch(ds_dids_not_in_cr, did, acctno);
 ds_in_did_found_in_pr := JOIN(ds_batch_in_with_did,ds_batch_in_didValidation,
                            LEFT.acctno = RIGHT.acctno AND 
                            Right.did > 0,
                            TRANSFORM(_Layout.dids_recs,
                             SELF.did := RIGHT.did,
                             SELF.RecordSource := _Constant.RECORD_SOURCE.REALTIME,
                             SELF := LEFT,
                             SELF := []),
                            LIMIT(0), KEEP(1));
              
              
 // FIND Public Records DID for Input that does not already have a did
 ds_no_did_pii := PROJECT(ds_batch_in_without_did,
                    TRANSFORM(Autokey_batch.Layouts.rec_inBatchMaster,
                      SELF.homephone := LEFT.phoneno,
                      SELF := LEFT,
                      SELF := []));
         
 ds_append_did_to_in_pii_pr := BatchServices.Functions.fn_find_dids_and_append_to_acctno(ds_no_did_pii);
 ds_appended_did_to_in_pii_pr := JOIN(ds_batch_in_without_did, ds_append_did_to_in_pii_pr,
                                  LEFT.acctno = RIGHT.acctno,
                                  TRANSFORM(_Layout.dids_recs,
                                    SELF.did := RIGHT.did,
                                    SELF.RecordSource := _Constant.RECORD_SOURCE.REALTIME,
                                    SELF := LEFT,
                                    SELF := []));
            
 // FIND Contributed Records DID or (RINID) for Input PII that does not already have a did
 
 // Below project is workaround until all the layout decoupling (from fraudshared layouts) is completed.
 ds_batch_in_without_did_proj := PROJECT(ds_batch_in_without_did, TRANSFORM(FraudShared_Services.Layouts.BatchIn_rec,
                                                                    SELF := LEFT,
                                                                    SELF := []));
  
 ds_auto_out := RiskIntelligenceNetwork_Services.fn_postautokey_joins(ds_batch_in_without_did_proj, in_params.FraudPlatform);
 ds_payload_recs := RiskIntelligenceNetwork_Services.fn_GetPayloadRecords(ds_auto_out, in_params, fraud_platform := in_params.FraudPlatform);
 
 ds_payload_recs_filtered := JOIN(ds_batch_in_without_did, ds_payload_recs,
                              LEFT.acctno = RIGHT.acctno AND
                              (~hasValue(LEFT.name_last) OR (TRIM(LEFT.name_last, left, right) = TRIM(RIGHT.cleaned_name.lname, left, right))) AND
                              (~hasValue(LEFT.name_first) OR (TRIM(LEFT.name_first) = trim(RIGHT.cleaned_name.fname, left, right)[1..length(trim(LEFT.name_first, left, right))])) AND
                              (~hasValue(LEFT.ssn) OR LEFT.ssn = RIGHT.ssn) AND
                              (~hasValue(LEFT.prim_range) OR ~hasValue(LEFT.prim_name) OR
                                (LEFT.prim_range = RIGHT.clean_address.prim_range AND LEFT.prim_name = RIGHT.clean_address.prim_name AND
                                ((LEFT.p_city_name = RIGHT.clean_address.p_city_name AND LEFT.st = RIGHT.clean_address.st) OR LEFT.z5 = RIGHT.clean_address.zip))) AND
                              (~hasValue(LEFT.dob) OR LEFT.dob = RIGHT.dob) AND
                              (~hasValue(LEFT.phoneno) OR LEFT.phoneno = RIGHT.phone_number) AND
                              (~hasValue(LEFT.email_address) OR LEFT.email_address = RIGHT.email_address) AND
                              (~hasValue(LEFT.ip_address) OR LEFT.ip_address = RIGHT.ip_address) AND
                              (~hasValue(LEFT.device_id) OR LEFT.device_id = RIGHT.device_id) AND
                              (~hasValue(LEFT.bank_routing_number) OR LEFT.bank_routing_number = RIGHT.bank_routing_number_1 OR LEFT.bank_routing_number = RIGHT.bank_routing_number_2) AND	
                              (~hasValue(LEFT.bank_account_number) OR LEFT.bank_account_number = RIGHT.bank_account_number_1 OR LEFT.bank_account_number = RIGHT.bank_account_number_2) AND
                              (~hasValue(LEFT.dl_number) OR LEFT.dl_number = RIGHT.Drivers_License) AND
                              (~hasValue(LEFT.dl_state) OR LEFT.dl_state = RIGHT.Drivers_License_State),
                              TRANSFORM(RIGHT));

 ds_PayloadRecs_w_did := ds_payload_recs_filtered(did > 0);
 ds_appended_did_to_in_pii_cr := PROJECT(ds_PayloadRecs_w_did,
                                  TRANSFORM(_Layout.dids_recs,
                                    SELF.RecordSource := _Constant.RECORD_SOURCE.CONTRIBUTED,
                                    SELF := LEFT,
                                    SELF := [])); 
                                    
 /* Since contributed did hold higher priority. So if did is found in both Contributed records and public records ...
  ... then we want to keep record source as contributed.*/              
 ds_dids_combined := SORT(ds_in_did_found_in_pr + ds_in_did_found_in_cr + ds_appended_did_to_in_pii_cr + ds_appended_did_to_in_pii_pr, acctno, did, RecordSource); 
 ds_dids_combined_dedup := DEDUP(ds_dids_combined, acctno, did);
 
 Rec_no_of_dids_per_acctno := RECORD
  ds_dids_combined_dedup.acctno;
  INTEGER NO_OF_DIDs_FOUND := COUNT(GROUP);
 end;
 
 ds_no_of_dids_per_acctno := TABLE(ds_dids_combined_dedup, Rec_no_of_dids_per_acctno, acctno);
 
 Rec_Appended_Dids_W_Source := RECORD
  FraudShared_Services.Layouts.BatchInExtended_rec;
  STRING30 RecordSource;
 END;
 
 ds_batch_in_with_appended_did := JOIN(ds_batch_in, ds_dids_combined_dedup,
                                    LEFT.acctno = RIGHT.acctno,
                                    TRANSFORM(Rec_Appended_Dids_W_Source,
                                      isMultipleDidResolved := ds_no_of_dids_per_acctno(acctno = LEFT.acctno)[1].NO_OF_DIDs_FOUND > 1;
                                      SELF.seq := (UNSIGNED)LEFT.acctno,
                                      SELF.did := MAP(LEFT.did != 0 => LEFT.did,
                                                      LEFT.did = 0 AND ~isMultipleDidResolved => RIGHT.did,
                                                      0);
                                      SELF.RecordSource := RIGHT.RecordSource,
                                      SELF := LEFT,
                                      SELF := []),
                                    LEFT OUTER);
                                            
 ds_appended_did_dedup := dedup(sort(ds_batch_in_with_appended_did, acctno), acctno);
              
 // Call appends for identities found in order to get risk scores from KEL analytics.
 ds_best_in := PROJECT(ds_batch_in_with_appended_did, 
                TRANSFORM(DidVille.Layout_Did_OutBatch,
                  SELF.seq := (UNSIGNED)LEFT.acctno,
                  SELF.fname := LEFT.name_first,
                  SELF.mname := LEFT.name_middle,
                  SELF.lname := LEFT.name_last,
                  SELF.suffix := LEFT.name_suffix,
                  SELF.phone10 := LEFT.phoneno,
                  SELF.email := LEFT.email_address,
                  SELF.dl_nbr := LEFT.dl_number,
                  SELF.dl_state := LEFT.dl_state,
                  SELF := LEFT,
                  SELF := []));
                        
 ds_pr_best := RiskIntelligenceNetwork_Services.Functions.getGovernmentBest(ds_best_in, in_params);
 ds_pr_best_ungrp := UNGROUP(ds_pr_best);

 ds_appends_in := PROJECT(ds_batch_in_with_appended_did, FraudShared_Services.Layouts.BatchInExtended_rec);
 ds_pr_appends := RiskIntelligenceNetwork_Services.Functions.getPublicRecordsAppends(ds_appends_in, ds_pr_best_ungrp, in_params);
 ds_live_assessment := RiskIntelligenceNetwork_Analytics.Functions.GetAPILiveAssessment(ds_pr_appends, in_params);
 
 //Leaving the below comment for faster deployment of roxie query when performing debugging for roxie portion.
 // ds_live_assessment := dataset([], RiskIntelligenceNetwork_analytics.Layouts.LiveAssessmentScores);
 
 ds_batch_records := JOIN(ds_appended_did_dedup, ds_live_assessment, 
                      LEFT.acctno = (STRING) RIGHT.record_id,
                      TRANSFORM(_Layout.BatchOut_rec,
                       hasMinimunInputForRINID := hasValue(LEFT.name_last) AND hasValue(LEFT.name_first) AND
                                                  (hasValue(LEFT.ssn) OR ((hasValue(LEFT.Addr) OR (hasValue(LEFT.prim_range) AND hasValue(LEFT.prim_name))) AND
                                                                         ((hasValue(LEFT.p_city_name) AND hasValue(LEFT.st)) OR hasValue(LEFT.z5)))) AND 
                                                  hasValue(LEFT.dob);
                                                  
                       isMultipleDidResolved := ds_no_of_dids_per_acctno(acctno = LEFT.acctno)[1].NO_OF_DIDs_FOUND > 1;
                       InputDidFoundInCR := LEFT.RecordSource = _Constant.RECORD_SOURCE.CONTRIBUTED;
                       InputDidFoundInPR := LEFT.RecordSource = _Constant.RECORD_SOURCE.REALTIME;
                       
                       SELF.identity_resolved := MAP(~isMultipleDidResolved AND InputDidFoundInCR => _Constant.IDENTITY_FLAGS.IDENTITY_IN_CONTRIB,
                                                     ~isMultipleDidResolved AND InputDidFoundInPR => _Constant.IDENTITY_FLAGS.REALTIME_IDENTITY,
                                                     ~isMultipleDidResolved AND ~InputDidFoundInCR AND ~InputDidFoundInPR AND ~hasMinimunInputForRINID => _Constant.IDENTITY_FLAGS.UNSCORABLE_IDENTITY,
                                                     ~isMultipleDidResolved AND ~InputDidFoundInCR AND ~InputDidFoundInPR AND hasMinimunInputForRINID => _Constant.IDENTITY_FLAGS.IDENTITY_NOT_FOUND,
                                                     isMultipleDidResolved => _Constant.IDENTITY_FLAGS.MULTIPLE_IDENTITY,
                                                     '');
                       SELF.risk_level := RiskIntelligenceNetwork_Services.Functions.GetRiskLevel(RIGHT.p1_idriskindx),
                       SELF.Most_Recent_Activity_Date := (string) RIGHT.MostRecentActivityDate,
                       SELF.Total_Number_Identity_Activities := RIGHT.totalnumberofidactivities,
                       SELF.Risk_Attribute_Count := COUNT(RIGHT.entitystats),
                       SELF.Known_Risk_Count := COUNT(RIGHT.KrAttributes),
                       SELF := LEFT,
                       SELF := []), LEFT OUTER);
             
 _Layout.BatchOut_rec trans_denorm_ra(_Layout.BatchOut_rec L, _Analytics_Layout.LayoutEntityStats R, INTEGER C) := TRANSFORM
  SELF.Risk_Attribute_Reason_1 := IF(C = 1,R.label,L.Risk_Attribute_Reason_1);
  SELF.Risk_Attribute_Reason_2 := IF(C = 2,R.label,L.Risk_Attribute_Reason_2);
  SELF.Risk_Attribute_Reason_3 := IF(C = 3,R.label,L.Risk_Attribute_Reason_3);
  SELF.Risk_Attribute_Reason_4 := IF(C = 4,R.label,L.Risk_Attribute_Reason_4);
  SELF.Risk_Attribute_Reason_5 := IF(C = 5,R.label,L.Risk_Attribute_Reason_5);
  SELF.Risk_Attribute_Reason_6 := IF(C = 6,R.label,L.Risk_Attribute_Reason_6);
  SELF.Risk_Attribute_Reason_7 := IF(C = 7,R.label,L.Risk_Attribute_Reason_7);
  SELF.Risk_Attribute_Reason_8 := IF(C = 8,R.label,L.Risk_Attribute_Reason_8);
  SELF.Risk_Attribute_Reason_9 := IF(C = 9,R.label,L.Risk_Attribute_Reason_9);
  SELF.Risk_Attribute_Reason_10 := IF(C = 10,R.label,L.Risk_Attribute_Reason_10);
  SELF.Risk_Attribute_Reason_11 := IF(C = 11,R.label,L.Risk_Attribute_Reason_11);
  SELF.Risk_Attribute_Reason_12 := IF(C = 12,R.label,L.Risk_Attribute_Reason_12);
  SELF.Risk_Attribute_Reason_13 := IF(C = 13,R.label,L.Risk_Attribute_Reason_13);
  SELF.Risk_Attribute_Reason_14 := IF(C = 14,R.label,L.Risk_Attribute_Reason_14);
  SELF.Risk_Attribute_Reason_15 := IF(C = 15,R.label,L.Risk_Attribute_Reason_15);
  SELF := L
 END;
 
 ds_riskAttributes_sorted := SORT(ds_live_assessment.EntityStats, acctno, -risklevel, -(indicatortype = 'ID'), indicatortype, record); 
 ds_batch_records_w_ra := DENORMALIZE(ds_batch_records, ds_riskAttributes_sorted, LEFT.acctno = RIGHT.acctno, trans_denorm_ra(LEFT, RIGHT, COUNTER));
              
 _Layout.BatchOut_rec trans_denorm_kr(_Layout.BatchOut_rec L, _Analytics_Layout.LayoutEntityStats R,INTEGER C) := TRANSFORM
  SELF.Known_Risk_Reason_1 := IF(C = 1,R.label,L.Known_Risk_Reason_1);
  SELF.Known_Risk_Agency_1 := IF(C = 1,R.agencydescription,L.Known_Risk_Agency_1);
  SELF.Known_Risk_Reason_2 := IF(C = 2,R.label,L.Known_Risk_Reason_2);
  SELF.Known_Risk_Agency_2 := IF(C = 2,R.agencydescription,L.Known_Risk_Agency_2);
  SELF.Known_Risk_Reason_3 := IF(C = 3,R.label,L.Known_Risk_Reason_3);
  SELF.Known_Risk_Agency_3 := IF(C = 3,R.agencydescription,L.Known_Risk_Agency_3);
  SELF.Known_Risk_Reason_4 := IF(C = 4,R.label,L.Known_Risk_Reason_4);
  SELF.Known_Risk_Agency_4 := IF(C = 4,R.agencydescription,L.Known_Risk_Agency_4);
  SELF.Known_Risk_Reason_5 := IF(C = 5,R.label,L.Known_Risk_Reason_5);
  SELF.Known_Risk_Agency_5 := IF(C = 5,R.agencydescription,L.Known_Risk_Agency_5);
  SELF.Known_Risk_Reason_6 := IF(C = 6,R.label,L.Known_Risk_Reason_6);
  SELF.Known_Risk_Agency_6 := IF(C = 6,R.agencydescription,L.Known_Risk_Agency_6);
  SELF.Known_Risk_Reason_7 := IF(C = 7,R.label,L.Known_Risk_Reason_7);
  SELF.Known_Risk_Agency_7 := IF(C = 7,R.agencydescription,L.Known_Risk_Agency_7);
  SELF.Known_Risk_Reason_8 := IF(C = 8,R.label,L.Known_Risk_Reason_8);
  SELF.Known_Risk_Agency_8 := IF(C = 8,R.agencydescription,L.Known_Risk_Agency_8);
  SELF.Known_Risk_Reason_9 := IF(C = 9,R.label,L.Known_Risk_Reason_9);
  SELF.Known_Risk_Agency_9 := IF(C = 9,R.agencydescription,L.Known_Risk_Agency_9);
  SELF.Known_Risk_Reason_10 := IF(C = 10,R.label,L.Known_Risk_Reason_10);
  SELF.Known_Risk_Agency_10 := IF(C = 10,R.agencydescription,L.Known_Risk_Agency_10);
  SELF.Known_Risk_Reason_11 := IF(C = 11,R.label,L.Known_Risk_Reason_11);
  SELF.Known_Risk_Agency_11 := IF(C = 11,R.agencydescription,L.Known_Risk_Agency_11);
  SELF.Known_Risk_Reason_12 := IF(C = 12,R.label,L.Known_Risk_Reason_12);
  SELF.Known_Risk_Agency_12 := IF(C = 12,R.agencydescription,L.Known_Risk_Agency_12);
  SELF := L
 END;              

 ds_knownRisks_sorted := SORT(ds_live_assessment.KrAttributes, acctno, -risklevel, entitytype, record);          
 ds_batch_records_w_kr := DENORMALIZE(ds_batch_records_w_ra, ds_knownRisks_sorted, LEFT.acctno = RIGHT.acctno,trans_denorm_kr(LEFT, RIGHT, COUNTER));
              
 // OUTPUT(ds_batch_in, named('ds_batch_in'));
 // OUTPUT(ds_batch_in_with_did, named('ds_batch_in_with_did'));
 // OUTPUT(ds_batch_in_without_did, named('ds_batch_in_without_did'));
 // OUTPUT(ds_in_did_found_in_cr, named('ds_in_did_found_in_cr')); 
 // OUTPUT(ds_dids_not_in_cr, named('ds_dids_not_in_cr'));
 // OUTPUT(ds_batch_in_didValidation, named('ds_batch_in_didValidation'));
 // OUTPUT(ds_in_did_found_in_pr, named('ds_in_did_found_in_pr'));
 // OUTPUT(ds_no_did_pii, named('ds_no_did_pii'));
 // OUTPUT(ds_append_did_to_in_pii_pr, named('ds_append_did_to_in_pii_pr'));
 // OUTPUT(ds_appended_did_to_in_pii_pr, named('ds_appended_did_to_in_pii_pr'));
 // OUTPUT(ds_auto_out, named('ds_auto_out'));
 // OUTPUT(ds_payload_recs, named('ds_payload_recs'));
 // OUTPUT(ds_payload_recs_filtered, named('ds_payload_recs_filtered'));
 // OUTPUT(ds_PayloadRecs_w_did, named('ds_PayloadRecs_w_did'));
 // OUTPUT(ds_appended_did_to_in_pii_cr, named('ds_appended_did_to_in_pii_cr'));
 // OUTPUT(ds_dids_combined, named('ds_dids_combined'));
 // OUTPUT(ds_dids_combined_dedup, named('ds_dids_combined_dedup'));
 // OUTPUT(ds_no_of_dids_per_acctno, named('ds_no_of_dids_per_acctno'));
 // OUTPUT(ds_batch_in_with_appended_did, named('ds_batch_in_with_appended_did'));
 // OUTPUT(ds_appended_did_dedup, named('ds_appended_did_dedup'));
 // OUTPUT(ds_best_in, named('ds_best_in'));
 // OUTPUT(ds_pr_best, named('ds_pr_best'));
 // OUTPUT(ds_pr_appends, named('ds_pr_appends'));
 // OUTPUT(ds_live_assessment, named('ds_live_assessment'));
 // OUTPUT(ds_batch_records, named('ds_batch_records'));
 // OUTPUT(ds_batch_records_w_ra, named('ds_batch_records_w_ra'));
 // OUTPUT(ds_batch_records_w_kr, named('ds_batch_records_w_kr'));
 
 RETURN ds_batch_records_w_kr;
END;