IMPORT iesp, FFD, FCRA, FCRAGateway_Services;

//Follows Dempsey compliance for FCRA reports. Resolve a DID from PII, if none found stop.
//If a did is found retrieve consumer statements and credit alerts as well as the DID.
EXPORT GetComplianceData(DATASET(iesp.person_picklist.t_PersonPickListRequest) plist_req,
	FCRAGateway_Services.IParam.common_params params) := FUNCTION

	//Use picklist to find a did. If we don't receive one we stop the report.
	FCRA.MAC_GetPickListRecords(plist_req, plist_resp, true);
	err_code := plist_resp[1]._Header.Status;
	plist_did := IF(err_code = 0, (unsigned6)plist_resp[1].Records[1].UniqueId, 0);

	//Get PersonContext records which contain all credit alerts and consumer statements if we have a valid did.
	//Suppression is handled by FFDOptionsMask.
	ds_dids := dataset([{FFD.Constants.SingleSearchAcctno, plist_did}], FFD.Layouts.DidBatch);
	ds_person_context := IF(plist_did > 0,
		FFD.FetchPersonContext(ds_dids, gateways, FFD.Constants.DataGroupSet.Person, params.FFDOptionsMask));
	boolean showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(params.FFDOptionsMask);
	ds_consumer_statements := if(ShowConsumerStatements, FFD.prepareConsumerStatements(ds_person_context),FFD.Constants.BlankConsumerStatements);

	//Check if we need to suppress the report due to credit alerts.
	alert_indicators := FFD.ConsumerFlag.getAlertIndicators(ds_person_context, params.FCRAPurpose, params.FFDOptionsMask)[1];
  is_suppressed_by_alert := alert_indicators.suppress_records;
	ds_consumer_alerts := FFD.ConsumerFlag.prepareAlertMessages(ds_person_context, alert_indicators, params.FFDOptionsMask);
	consumer:= FFD.MAC.PrepareConsumerRecord((string)plist_did, TRUE, plist_req[1].searchby);

	//Bundle the results so we can return them in a dataset.
	ds_compliance_out := DATASET([{is_suppressed_by_alert, ds_consumer_alerts, ds_consumer_statements, consumer}],
		FCRAGateway_Services.Layouts.compliance_out);

	#IF(FCRAGateway_Services.Constants.Debug.ComplianceData)
		OUTPUT(plist_req,NAMED('compliance_plist_req'));
		OUTPUT(plist_resp,NAMED('compliance_plist_resp'));
		OUTPUT(ds_person_context,NAMED('ds_person_context'));
		OUTPUT(ds_consumer_statements,NAMED('ds_consumer_statements'));
		OUTPUT(ds_consumer_alerts,NAMED('ds_consumer_alerts'));
		OUTPUT(ds_compliance_out,NAMED('ds_compliance_out'));
	#END

	RETURN ds_compliance_out;
END;