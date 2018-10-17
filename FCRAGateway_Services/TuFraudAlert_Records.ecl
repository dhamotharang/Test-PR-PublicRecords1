IMPORT iesp, Gateway, FCRAGateway_Services, Royalty;

EXPORT TuFraudAlert_Records(dataset(iesp.tu_fraud_alert.t_TuFraudAlertRequest) in_req, FCRAGateway_Services.IParam.common_params in_mod) :=  FUNCTION

  transforms := FCRAGateway_Services.TuFraudAlert_Transforms;
  constants := FCRAGateway_Services.Constants;
  return_matched_lexIDs_only := in_mod.ReturnMatchedUniqueIDsOnly;
  //Create picklist request from input PII.
  user := ROW(transforms.in_mod_to_user(in_mod));
  ds_plist_req := PROJECT(in_req, transforms.input_to_picklist(LEFT, user));
  //Retrieve credit alerts, consumer statements, freeze information, and ensure we can resolve to a did.
  ds_compliance_data := FCRAGateway_Services.GetComplianceData(ds_plist_req, in_mod);
  input_lexID := (UNSIGNED6)ds_compliance_data[1].consumer.lexID;
  is_suppressed_by_alert := ds_compliance_data[1].is_suppressed_by_alert;
  consumer_alerts := ds_compliance_data[1].ConsumerAlerts;
  consumer_statements := ds_compliance_data[1].ConsumerStatements;

  //Prepare the consumer records. Use the lexid found from picklist on input PII, and use the picklist PII
  //for the rest since it's the same format the function macro requires.
  consumer:= ds_compliance_data[1].Consumer;

  //Call the credit gateway if have no suppression and (a valid lexID or we bypass lexID validation).
  make_gateway_call :=  (~return_matched_lexIDs_only OR input_lexID > 0) AND ~is_suppressed_by_alert;

  ds_tufa_soap_response := IF(make_gateway_call, Gateway.SoapCall_TuFraudAlert(in_req, in_mod.gateways, make_gateway_call));

  //Verify response resolve to lexID with picklist.
  ds_tufa_with_picklist_recs := IF(make_gateway_call, FCRAGateway_Services.GetTufaPicklistVerification(ds_tufa_soap_response, user));

  //Get royalties from ds_tufa_with_picklist_recs.
  ds_royalties := Royalty.RoyaltyTuFraudAlert.GetRoyalties(ds_tufa_with_picklist_recs);

  //Validate the DID from the gateway's response PII matches our input DID.
  output_lexID := ds_tufa_with_picklist_recs[1].lexID;

  //Set the unique ID validation code. Remote Linking will override this code if it's a match.
  pre_validation_code := MAP(
    is_suppressed_by_alert => constants.ValidationCode.NO_CALL,
    ds_tufa_soap_response[1].response._header.status = constants.GatewayStatus.ERROR => constants.ValidationCode.INVALID_RESPONSE,
    FCRAGateway_Services.Functions.GetValidationCode(input_lexID, output_lexID));

  validation_ok := FCRAGateway_Services.Functions.IsValidationOk(pre_validation_code);

  //If the result is not validated send input and output to remote linking to test for a match.
  remote_linking_is_match := FCRAGateway_Services.Functions.TuFraudAlert.Get_RL_Match(in_req[1],
    ds_tufa_soap_response[1].response, in_mod.gateways);

  //If remote linking was a match, update validation code, otherwise keep it the same.
  validation_code := IF(remote_linking_is_match, constants.ValidationCode.REMOTE_LINKING_MATCH,
    pre_validation_code);

  validation_code_desc := constants.GetValidationCodeDesc(validation_code);

  //Only return report information if we bypass validation, our lexIDs math, or remote linking was a match.
  //The report will be empty if suppressed due to person context.
  return_results := ~return_matched_lexIDs_only OR validation_ok OR remote_linking_is_match;

  //Only return consumer data if it causes suppression, or if we can return vendor response.
  return_consumer_data := return_results OR is_suppressed_by_alert;

  //Creates a final output and populates the credit information based on suppression.
  FCRAGateway_Services.Layouts.tu_fraud_alert.records_out xtOut() := TRANSFORM
    //Always return the header, royalties, gateway status, errors, and DID validation.
    SELF.response._header := ds_tufa_soap_response[1].response._header;
    SELF.response.UniqueIdValidation := DATASET([{validation_code, validation_code_desc}], iesp.share.t_CodeMap)[1];
    SELF.response.ErrorCodes := ds_tufa_soap_response[1].response.ErrorCodes;
    SELF.response.ErrorTexts := ds_tufa_soap_response[1].response.ErrorTexts;
    SELF.Royalties := ds_royalties;

    //Return consumer data if we don't call gateway or if we do and get a matching lexID.
    SELF.response.Consumer :=  IF(return_consumer_data, consumer);
    SELF.response.ConsumerStatements := IF(return_consumer_data, consumer_statements);
    SELF.response.ConsumerAlerts := IF(return_consumer_data, consumer_alerts);

    //Only return the rest of the data if we have lexID validation and we are not suppressed by PersonContext.
    SELF := IF(return_results, ds_tufa_with_picklist_recs[1]);
    SELF := [];
  END;

  ds_tufa_recs := DATASET([xtOut()]);

  #IF(constants.Debug.TuFraudAlertRecords)
    OUTPUT(ds_compliance_data, NAMED('ds_compliance_data'));
    OUTPUT(ds_tufa_soap_response, NAMED('ds_tufa_soap_response'));
    OUTPUT(ds_tufa_recs, NAMED('ds_tufa_recs'));
  #END

  RETURN ds_tufa_recs;
END;