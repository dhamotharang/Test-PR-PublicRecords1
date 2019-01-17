IMPORT iesp, Gateway, FCRAGateway_Services, Royalty;

EXPORT EquifaxEms_Records(dataset(iesp.mergedcreditreport_fcra.t_FcraMergedCreditReportRequest) in_req, FCRAGateway_Services.IParam.common_params in_mod) :=  FUNCTION

	//Create lexID resoultion request from input PII.
	ds_lexID_req := project(in_req, TRANSFORM(iesp.person_picklist.t_PersonPickListRequest,
		SELF.SearchBy := LEFT.ReportBy.Consumer, SELF := LEFT, SELF := []));

	//Retrieve credit alerts, consumer statements, freeze information, and ensure we can resolve to a did.
	ds_compliance_data := FCRAGateway_Services.GetComplianceData(ds_lexID_req, in_mod);
	input_lexID := (unsigned6)ds_compliance_data[1].consumer.lexID;
	is_suppressed_by_alert := ds_compliance_data[1].is_suppressed_by_alert;
	consumer_alerts := ds_compliance_data[1].ConsumerAlerts;
	consumer_statements := ds_compliance_data[1].ConsumerStatements;
	consumer := ds_compliance_data[1].Consumer;

	//Transform the transactional ESP request to the gateway ESP format.
	//GatewayParams is filled out in the function.
	ds_gateway_request := PROJECT(in_req, TRANSFORM(iesp.equifax_ems.t_EquifaxEmsRequest,
		SELF.SearchBy := LEFT.ReportBy;
		SELF.SearchBy.Requestor := LEFT.ReportBy.VendorInfo;
		SELF.SearchBy.IncludeEquifax := LEFT.Options.IncludeEquifax;
		SELF.SearchBy.IncludeTransunion := LEFT.Options.IncludeTransunion;
		SELF.SearchBy.IncludeExperian := LEFT.Options.IncludeExperian;
		SELF := LEFT;
		SELF := [];
	));

	//Call the credit gateway if we are allowed. (Have valid DID and not suppressed by credit alerts)
	make_gateway_call := input_lexID > 0 AND NOT is_suppressed_by_alert;
	ds_ems_soap_response := IF(make_gateway_call, Gateway.SoapCall_EquifaxEms(ds_gateway_request, in_mod.gateways, make_gateway_call));
	ds_ems_with_lexID_recs := IF(make_gateway_call, FCRAGateway_Services.GetEquifaxLexIDVerification(ds_ems_soap_response));

	//Get royalties from ds_ems_with_lexID_recs.
	ds_royalties := Royalty.RoyaltyEquifaxEMS.GetRoyalties(ds_ems_with_lexID_recs);

	//Validate the DID from the gateway's response PII matches our input DID.
	output_lexID := ds_ems_with_lexID_recs[1].lexID;

	validation_code := MAP(
		is_suppressed_by_alert => FCRAGateway_Services.Constants.ValidationCode.NO_CALL,
		ds_ems_soap_response[1].response._header.status = FCRAGateway_Services.Constants.GatewayStatus.ERROR
			=> FCRAGateway_Services.Constants.ValidationCode.INVALID_RESPONSE,
		FCRAGateway_Services.Functions.GetValidationCode(input_lexID, output_lexID));

	validation_code_desc := FCRAGateway_Services.Constants.GetValidationCodeDesc(validation_code);
	validation_ok := FCRAGateway_Services.Functions.IsValidationOk(validation_code);

	//Only return report information if our DIDs match, and we have no suppression from credit alerts.
	return_results := validation_ok AND ~is_suppressed_by_alert;
	//Only return consumer data if we are suppressed by it, or we have a valid lexID match.
	return_consumer_data := is_suppressed_by_alert OR validation_ok;

	FCRAGateway_Services.Layouts.equifax_ems.records_out xtOut() := TRANSFORM
		//Always return the header, royalties, gateway status, errors, and DID validation.
		self.response._header := ds_ems_with_lexID_recs[1].response._header;
		self.response.emsResponse.errorInfo := ds_ems_with_lexID_recs[1].response.emsResponse.errorInfo;
		self.unique_validation := dataset([{validation_code, validation_code_desc}], iesp.share.t_CodeMap)[1];
		self.Royalties := ds_royalties;

		//Return consumer data if we don't call gateway  due to alerts, or if we do and get a matching lexID.
		self.Consumer :=  IF(return_consumer_data, consumer);
		self.ConsumerStatements := IF(return_consumer_data, consumer_statements);
		self.ConsumerAlerts := IF(return_consumer_data, consumer_alerts);

		//Only return results if we have no suppression from personContext and have a matching input and output lexID.
		self := IF(return_results, ds_ems_with_lexID_recs[1]);
		self := [];
	END;

	ds_ems_recs := DATASET([xtOut()]);

	#IF(FCRAGateway_Services.Constants.Debug.EquifaxEmsRecords)
		OUTPUT(ds_compliance_data, NAMED('ds_compliance_data'));
		OUTPUT(ds_gateway_request, NAMED('ds_gateway_request'));
		OUTPUT(ds_ems_soap_response, NAMED('ds_ems_soap_response'));
		OUTPUT(ds_ems_recs, NAMED('ds_ems_recs'));
	#END

	return ds_ems_recs;
END;