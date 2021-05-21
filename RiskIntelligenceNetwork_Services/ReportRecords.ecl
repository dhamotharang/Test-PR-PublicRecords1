IMPORT Autokey_batch, BatchServices, DidVille, FraudShared, FraudShared_Services, IDLExternalLinking, iesp, RiskIntelligenceNetwork_Analytics, 
RiskIntelligenceNetwork_Services;

EXPORT ReportRecords (DATASET(FraudShared_Services.Layouts.BatchInExtended_rec) ds_in,
                      RiskIntelligenceNetwork_Services.IParam.Params in_params) := FUNCTION

 _Layout := RiskIntelligenceNetwork_Services.Layouts;
 _Constant := RiskIntelligenceNetwork_Services.Constants;
 hasValue := RiskIntelligenceNetwork_Services.Functions.hasValue;
 
 hasLastName  := hasValue(ds_in[1].name_last);
 hasFirstName := hasValue(ds_in[1].name_first);
 hasSSN       := hasValue(ds_in[1].ssn);
 hasAddress   := hasValue(ds_in[1].Addr) OR hasValue(ds_in[1].prim_range) OR hasValue(ds_in[1].prim_name);
 hasCityState := hasValue(ds_in[1].p_city_name) AND hasValue(ds_in[1].st);
 hasZip       := hasValue(ds_in[1].z5);
 hasDOB       := hasValue(ds_in[1].dob);
 hasEmail     := hasValue(ds_in[1].email_address);
 hasIPAddress := hasValue(ds_in[1].ip_address);
 hasDeviceID  := hasValue(ds_in[1].device_id);
 hasRoutingNo := hasValue(ds_in[1].bank_routing_number);
 hasBankAccNo := hasValue(ds_in[1].bank_account_number);
 hasDLNo      := hasValue(ds_in[1].dl_number);
 hasDLState   := hasValue(ds_in[1].dl_state);

 hasMinimunInputForRINID := hasLastName AND hasFirstName AND hasDOB AND (hasSSN OR (hasAddress AND (hasCityState OR hasZip)));

 // Validate Input DID by checking if it exists in Public Records.
 InputDidFoundInPR := ds_in[1].did != 0 AND EXISTS(IDLExternalLinking.did_getAllRecs(ds_in[1].did)(s_did > 0));
                      
 // Validate if Input DID is found in Contributed Records.
 InputDidFoundInCR := ds_in[1].did != 0 AND EXISTS(FraudShared.Key_Did(in_params.FraudPlatform)(KEYED(did = ds_in[1].did)));

 ds_in_without_did := ds_in(did = 0);                             

 // FIND Public Records DID for Input PII that does not already have a did
 ds_input_pii := PROJECT(ds_in_without_did,
                   TRANSFORM(Autokey_batch.Layouts.rec_inBatchMaster,
                     SELF.homephone := LEFT.phoneno,
                     SELF := LEFT,
                     SELF := []));
                 
 ds_pr_did := BatchServices.Functions.fn_find_dids_and_append_to_acctno(ds_input_pii);

 ds_pr_did_final := JOIN(ds_in, ds_pr_did,
                      LEFT.acctno = RIGHT.acctno,
                      TRANSFORM(_Layout.dids_recs,
                       SELF.Seq := (UNSIGNED)LEFT.acctno,
                       SELF.did := RIGHT.did,
                       SELF.RecordSource := _Constant.RECORD_SOURCE.REALTIME,
                       SELF := []));
 
 // FIND Contributed Records DID or (RINID) for Input PII that does not already have a did
 ds_in_orig := PROJECT(ds_in_without_did, FraudShared_Services.Layouts.BatchIn_rec);

 ds_auto_out := RiskIntelligenceNetwork_Services.fn_postautokey_joins(ds_in_orig, in_params.FraudPlatform);

 ds_payload_recs := RiskIntelligenceNetwork_Services.fn_GetPayloadRecords(ds_auto_out, in_params, fraud_platform := in_params.FraudPlatform);
 ds_payload_recs_filtered := ds_payload_recs((~hasLastName OR (trim(cleaned_name.lname, left, right) = trim(ds_in[1].name_last, left, right))) AND
                                             (~hasFirstName OR (trim(cleaned_name.fname, left, right)[1..length(trim(ds_in[1].name_first, left, right))] = trim(ds_in[1].name_first))) AND
                                             (~hasSSN OR ssn = ds_in[1].ssn OR
                                              (~hasAddress OR  
                                               (clean_address.prim_range = ds_in[1].prim_range AND clean_address.prim_name = ds_in[1].prim_name AND
                                               ((clean_address.p_city_name = ds_in[1].p_city_name and clean_address.st = ds_in[1].st) OR clean_address.zip = ds_in[1].z5)))) AND
                                             (~hasDOB OR dob = ds_in[1].dob) AND
                                             (~hasEmail OR email_address = ds_in[1].email_address) AND
                                             (~hasIPAddress OR ip_address = ds_in[1].ip_address) AND
                                             (~hasDeviceID OR device_id = ds_in[1].device_id) AND
                                             (~hasRoutingNo OR bank_routing_number_1 = ds_in[1].bank_routing_number OR bank_routing_number_2 = ds_in[1].bank_routing_number) AND	
                                             (~hasBankAccNo OR bank_account_number_1 = ds_in[1].bank_account_number OR bank_account_number_2 = ds_in[1].bank_account_number) AND
                                             (~hasDLNo OR Drivers_License = ds_in[1].dl_number) AND
                                             (~hasDLState OR Drivers_License_State = ds_in[1].dl_state));

 ds_PayloadRecs_w_did := ds_payload_recs_filtered(did > 0);
 ds_contributory_dids := PROJECT(ds_PayloadRecs_w_did,
                          TRANSFORM(_Layout.dids_recs,
                            SELF.Seq := (UNSIGNED)LEFT.acctno,
                            SELF.RecordSource := _Constant.RECORD_SOURCE.CONTRIBUTED,
                            SELF.did := LEFT.did,
                            SELF := []));

 /* Since contributed did hold higher priority. So if did is found in both Contributed records and public records ...
  ... then we want to keep record source as contributed.*/
 ds_dids_combined := SORT(ds_contributory_dids + ds_pr_did_final, Seq, did, RecordSource);
 ds_dids_combined_dedup := DEDUP(ds_dids_combined, Seq, did);

 multiple_did_resolved := COUNT(ds_dids_combined_dedup) > 1;
 
 ds_in_w_did := JOIN(ds_in, ds_dids_combined_dedup,
                      LEFT.acctno = (STRING) RIGHT.Seq, 
                      TRANSFORM(FraudShared_Services.Layouts.BatchInExtended_rec,
                        SELF.seq := RIGHT.Seq,
                        SELF.did := MAP(LEFT.did != 0 => LEFT.did,
                                        LEFT.did = 0 AND ~multiple_did_resolved => RIGHT.did,
                                        0);
                        SELF := LEFT),
                        LEFT OUTER);                                
                                      
 // Call appends for identities found in order to get risk scores from KEL analytics.
 ds_best_in := PROJECT(ds_in_w_did, TRANSFORM(DidVille.Layout_Did_OutBatch,
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

 ds_pr_appends := RiskIntelligenceNetwork_Services.Functions.getPublicRecordsAppends(ds_in_w_did, ds_pr_best_ungrp, in_params);
 ds_API_Assessment := RiskIntelligenceNetwork_Analytics.Functions.GetAPILiveAssessment(ds_pr_appends, in_params);
 // ds_API_Assessment := dataset([], RiskIntelligenceNetwork_analytics.Layouts.LiveAssessmentScores);
  
 //Build Final Result:
 IdentityResolved := MAP(// Input identity found in contributory data
                         ~multiple_did_resolved AND (InputDidFoundInCR OR ds_dids_combined_dedup[1].RecordSource = _Constant.RECORD_SOURCE.CONTRIBUTED) => _Constant.IDENTITY_FLAGS.IDENTITY_IN_CONTRIB, 
                         // Input identity not found in contributory data or public records data
                         ~multiple_did_resolved AND ~InputDidFoundInPR AND ~InputDidFoundInCR AND ~EXISTS(ds_dids_combined_dedup) AND hasMinimunInputForRINID => _Constant.IDENTITY_FLAGS.IDENTITY_NOT_FOUND,
                         // Input identity not found in contributory data but found in public records through real-time search
                         ~multiple_did_resolved AND ~InputDidFoundInCR AND (InputDidFoundInPR OR ds_dids_combined_dedup[1].RecordSource = _Constant.RECORD_SOURCE.REALTIME) => _Constant.IDENTITY_FLAGS.REALTIME_IDENTITY,
                         // Input identity not found in contributory data or public records and does not contain enough information to produce an identity, Unscorable
                         ~multiple_did_resolved AND (~InputDidFoundInCR OR ~InputDidFoundInPR OR ~EXISTS(ds_dids_combined_dedup)) AND ~hasMinimunInputForRINID => _Constant.IDENTITY_FLAGS.UNSCORABLE_IDENTITY,
                         //Multiple LexIDs found in contributory or PR.
                         multiple_did_resolved => _Constant.IDENTITY_FLAGS.MULTIPLE_IDENTITY,
                         '');
 
 ds_RiskAttributes_sorted := SORT(ds_API_Assessment.entitystats, -risklevel, -(indicatortype = 'ID'), indicatortype, record);
 ds_KnownRisks_sorted := SORT(ds_API_Assessment.KrAttributes, -risklevel, entitytype, record);
 
 iesp.identityriskreport.t_RINIdentityRiskReportRecord trans_API_Assessment(RiskIntelligenceNetwork_analytics.Layouts.LiveAssessmentScores L) := TRANSFORM

  SELF.RiskLevel := RiskIntelligenceNetwork_Services.Functions.GetRiskLevel(L.p1_idriskindx),
  SELF.IdentityResolved := IdentityResolved,
  SELF.UniqueId := (STRING)ds_in_w_did[1].did,                                                               
  SELF.MostRecentActivityDate := iesp.ECL2ESP.toDate(L.mostrecentactivitydate);
  SELF.TotalNumberIdentityActivities := L.totalnumberofidactivities;
  SELF.RiskAttributeCount := COUNT(L.entitystats);
  SELF.RiskAttributes := CHOOSEN(PROJECT(ds_RiskAttributes_sorted, 
                                  TRANSFORM(iesp.identityriskreport.t_RINApiRiskAttribute, 
                                    SELF.RiskAttributeCode := LEFT.indicatortype,
                                    SELF.RiskAttributeReason := LEFT.label)),
                                iesp.Constants.RIN.MAX_RISK_ATTRIBUTE);
  SELF.KnownRiskCount := COUNT(L.KrAttributes);
  SELF.KnownRisks := CHOOSEN(PROJECT(ds_KnownRisks_sorted, 
                              TRANSFORM(iesp.identityriskreport.t_RINKnownRisk, 
                                SELF.ElementType := RiskIntelligenceNetwork_Services.Functions.GetElementType(LEFT.entitytype),
                                SELF.KnownRiskCode := LEFT.indicatortype,
                                SELF.KnownRiskReason := LEFT.Label,
                                SELF.KnownRiskAgency := LEFT.agencydescription)),
                            iesp.Constants.RIN.MAX_COUNT_INDICATOR_ATTRIBUTE);
 END;
 
 result := PROJECT(ds_API_Assessment, trans_API_Assessment(LEFT));

 // output LOG_Deltabase_Layout_Record
 deltabase_log := RiskIntelligenceNetwork_Services.Functions.GetDeltabaseLogDataSet(ds_in_w_did, in_params);
 OUTPUT(deltabase_log, NAMED('log_delta__fraudgov_delta__identity'));
 
//  Debug Outputs
 // OUTPUT(ds_in, named('ds_in'));
 // OUTPUT(hasMinimunInputForRINID, named('hasMinimunInputForRINID'));
 // OUTPUT(InputDidFoundInPR, named('InputDidFoundInPR'));
 // OUTPUT(InputDidFoundInCR, named('InputDidFoundInCR'));
 // OUTPUT(ds_in_without_did, named('ds_in_without_did'));
 // OUTPUT(ds_input_pii, named('ds_input_pii'));
 // OUTPUT(ds_pr_did, named('ds_pr_did'));
 // OUTPUT(ds_pr_did_final, named('ds_pr_did_final'));
 // OUTPUT(ds_auto_out, named('ds_auto_out'));
 // OUTPUT(ds_payload_recs, named('ds_payload_recs'));
 // OUTPUT(ds_payload_recs_filtered, named('ds_payload_recs_filtered'));
 // OUTPUT(ds_contributory_dids, named('ds_contributory_dids'));
 // OUTPUT(ds_dids_combined, named('ds_dids_combined'));
 // OUTPUT(ds_dids_combined_dedup, named('ds_dids_combined_dedup'));
 // OUTPUT(multiple_did_resolved, named('multiple_did_resolved'));
 // OUTPUT(ds_in_w_did, named('ds_in_w_did'));
 // OUTPUT(ds_pr_best_ungrp, named('ds_pr_best_ungrp'));
 // OUTPUT(ds_pr_appends, named('ds_pr_appends'));
 // OUTPUT(ds_API_Assessment, named('ds_API_Assessment')); 
//  OUTPUT(ds_RiskAttributes_sorted, named('ds_RiskAttributes_sorted')); 
//  OUTPUT(ds_KnownRisks_sorted, named('ds_KnownRisks_sorted')); 
 // OUTPUT(IdentityResolved, named('IdentityResolved'));
//  OUTPUT(result, named('result'));
 
 RETURN result;
 
END;                      