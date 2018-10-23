IMPORT iesp, FFD, FCRA, FCRAGateway_Services;

//Follows Dempsey compliance for FCRA reports. Resolve a LexID from PII, if none found stop.
//If a lexid is found retrieve consumer statements and alerts from Person Context repository.
EXPORT GetComplianceData(DATASET(iesp.person_picklist.t_PersonPickListRequest) plist_req,
  FCRAGateway_Services.IParam.common_params params) := FUNCTION

  //Use picklist to find a did. If we don't receive one we stop the report.
  FCRA.MAC_GetPickListRecords(plist_req, plist_resp, true);
  err_code := plist_resp[1]._Header.Status;
  plist_did := IF(err_code = 0, (unsigned6)plist_resp[1].Records[1].UniqueId, 0);

  consumer:= FFD.MAC.PrepareConsumerRecord((string)plist_did, TRUE, plist_req[1].searchby);
  isReseller := TRUE;
  CIA_data := FFD.ConsumerInitiatedActivities.Get(plist_did, params.FFDOptionsMask, params.FCRAPurpose, params.gateways, 
                                                  FFD.Constants.DataGroupSet.Person, isReseller);
  
  //Bundle the results so we can return them in a dataset.
  ds_compliance_out := PROJECT(CIA_data,TRANSFORM(FCRAGateway_Services.Layouts.compliance_out,
                               SELF.is_suppressed_by_alert := LEFT.suppress_records,
                               SELF.Consumer := consumer,
                               SELF := LEFT));
                               
  #IF(FCRAGateway_Services.Constants.Debug.ComplianceData)
    OUTPUT(plist_req,NAMED('compliance_plist_req'));
    OUTPUT(plist_resp,NAMED('compliance_plist_resp'));
    OUTPUT(ds_compliance_out,NAMED('ds_compliance_out'));
  #END

  RETURN ds_compliance_out;
END;