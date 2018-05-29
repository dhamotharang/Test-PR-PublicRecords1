IMPORT iesp, Gateway, FCRAGateway_Services, Royalty;

EXPORT TuFraudAlert_Records(dataset(iesp.tu_fraud_alert.t_TuFraudAlertRequest) in_req, FCRAGateway_Services.IParam.common_params in_mod) :=  FUNCTION

	transforms := FCRAGateway_Services.TuFraudAlert_Transforms;
	constants := FCRAGateway_Services.Constants;

	//Create picklist request from input PII.
	ds_plist_req := project(in_req, transforms.input_to_picklist(LEFT));

	//Retrieve credit alerts, consumer statements, freeze information, and ensure we can resolve to a did.
	ds_compliance_data := FCRAGateway_Services.GetComplianceData(ds_plist_req, in_mod);
	input_lexID := (unsigned6)ds_compliance_data[1].consumer.lexID;
	is_suppressed_by_alert := ds_compliance_data[1].is_suppressed_by_alert;
	consumer_alerts := ds_compliance_data[1].ConsumerAlerts;
	consumer_statements := ds_compliance_data[1].ConsumerStatements;

	//Prepare the consumer records. Use the lexid found from picklist on input PII, and use the picklist PII
	//for the rest since it's the same format the function macro requires.
	consumer:= ds_compliance_data[1].Consumer;

	//Call the credit gateway if we are allowed. (Have valid DID and not suppressed by credit alerts)
	make_gateway_call := input_lexID > 0 AND NOT is_suppressed_by_alert;
	ds_tufa_soap_response := IF(make_gateway_call, Gateway.SoapCall_TuFraudAlert(in_req, in_mod.gateways, make_gateway_call));

	//Verify response resolve to lexID with picklist.
	ds_tufa_with_picklist_recs := IF(make_gateway_call, FCRAGateway_Services.GetTufaPicklistVerification(ds_tufa_soap_response));

	//Get royalties from ds_tufa_with_picklist_recs.
	ds_royalties := Royalty.RoyaltyTuFraudAlert.GetRoyalties(ds_tufa_with_picklist_recs);

	//Validate the DID from the gateway's response PII matches our input DID.
	output_lexID := ds_tufa_with_picklist_recs[1].lexID;

	//Set the unique ID validation code.
	validation_code := MAP(
		is_suppressed_by_alert => constants.ValidationCode.NO_CALL,
		ds_tufa_soap_response[1].response._header.status = constants.GatewayStatus.ERROR => constants.ValidationCode.INVALID_RESPONSE,
		FCRAGateway_Services.Functions.GetValidationCode(input_lexID, output_lexID));

	validation_code_desc := constants.GetValidationCodeDesc(validation_code);
	validation_ok := FCRAGateway_Services.Functions.IsValidationOk(validation_code);

	//Only return report information if our lexIDs match, and we have no suppression from credit alerts.
	return_results := validation_ok AND ~is_suppressed_by_alert;
	//Only return consumer data if we are suppressed by it, or we have a valid lexID match.
	return_consumer_data := is_suppressed_by_alert OR validation_ok;

	//Creates a final output and populates the credit information based on suppression.
	FCRAGateway_Services.Layouts.tu_fraud_alert.records_out xtOut() := TRANSFORM
		//Always return the header, royalties, gateway status, errors, and DID validation.
		self.response._header := ds_tufa_soap_response[1].response._header;
		self.response.UniqueIdValidation := dataset([{validation_code, validation_code_desc}], iesp.share.t_CodeMap)[1];
		self.response.ErrorCodes := ds_tufa_soap_response[1].response.ErrorCodes;
		self.response.ErrorTexts := ds_tufa_soap_response[1].response.ErrorTexts;
		self.Royalties := ds_royalties;

		//Return consumer data if we don't call gateway or if we do and get a matching lexID.
		self.response.Consumer :=  IF(return_consumer_data, consumer);
		self.response.ConsumerStatements := IF(return_consumer_data, consumer_statements);
		self.response.ConsumerAlerts := IF(return_consumer_data, consumer_alerts);

		//Only return the rest of the data if we have lexID validation and we are not suppressed by PersonContext.
		self := IF(return_results, ds_tufa_with_picklist_recs[1]);
		self := [];
	END;

	ds_tufa_recs := DATASET([xtOut()]);

	#IF(constants.Debug.TuFraudAlertRecords)
		OUTPUT(ds_compliance_data, NAMED('ds_compliance_data'));
		OUTPUT(ds_gateway_request, NAMED('ds_gateway_request'));
		OUTPUT(ds_tufa_soap_response, NAMED('ds_tufa_soap_response'));
		OUTPUT(ds_tufa_recs, NAMED('ds_tufa_recs'));
	#END

	return ds_tufa_recs;
END;