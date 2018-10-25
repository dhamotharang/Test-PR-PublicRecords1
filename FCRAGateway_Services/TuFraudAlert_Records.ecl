IMPORT iesp, Gateway, FCRA, FCRAGateway_Services, FFD, Royalty;

EXPORT TuFraudAlert_Records(dataset(iesp.tu_fraud_alert.t_TuFraudAlertRequest) in_req,
  FCRAGateway_Services.IParam.common_params in_mod) :=  FUNCTION

  transforms := FCRAGateway_Services.TuFraudAlert_Transforms;
  constants := FCRAGateway_Services.Constants;
  return_matched_lexIDs_only := in_mod.ReturnMatchedUniqueIDsOnly;
  user := ROW(transforms.in_mod_to_user(in_mod));
  is_reseller := TRUE;

  //Used to only call when we could resolve a lexID. Now with remote linking we always call.
  //This is because we can identify a match without lexIDs using remote linking.
  ds_tufa_soap_response := Gateway.SoapCall_TuFraudAlert(in_req, in_mod.gateways, true);
  is_soap_response_success := ds_tufa_soap_response[1].response._header.status = FCRAGateway_Services.Constants.GatewayStatus.SUCCESS;

  //Verify response resolves to lexID with picklist.
  ds_tufa_with_didville_recs := FCRAGateway_Services.GetTufaLexIDVerification(ds_tufa_soap_response, user);

  //Get royalties from ds_tufa_with_didville_recs.This occurs before lexID validation since the vendor charges us regardless.
  ds_royalties := Royalty.RoyaltyTuFraudAlert.GetRoyalties(ds_tufa_with_didville_recs);

  //Store output lexID.
  output_lexID := ds_tufa_with_didville_recs[1].lexID;

  //Get lexID from input. Didville uses picklist layout for the request.
  ds_plist_req := PROJECT(in_req, transforms.input_to_picklist(LEFT, user));
  dville_resp := FCRA.getDidVilleRecords(ds_plist_req[1]);
  err_code := dville_resp[1]._Header.Status;
  input_lexID := IF(err_code = 0, (UNSIGNED6)dville_resp[1].Records[1].UniqueId, 0);

  //Check if they match, if they do not we send it to remote linking.
  is_lexID_match := output_lexID <> 0 AND output_lexID = input_lexID;
  remote_linking_result := IF(~is_lexID_match AND is_soap_response_success,
    FCRAGateway_Services.Functions.TuFraudAlert.Get_RL_Match(in_req[1], ds_tufa_soap_response[1].response, in_mod.gateways));

  //Set the inquiry log lexID to input if we have a match or remote linking didn't match.
  //This is because if we identify a person on input we need inquiry log and FFD data.
  //regardless of the vendor gateway response.
  inquiry_log_lexID := IF(is_lexID_match OR ~remote_linking_result.match OR remote_linking_result.best_lexID = 0,
    input_lexID, remote_linking_result.best_lexID);

  //Prepare inquiry log. If it is a 0, set to a blank string per ESP team request.
  consumer := FFD.Mac.PrepareConsumerRecord(IF(inquiry_log_lexID = 0, '', (STRING)inquiry_log_lexID),
    TRUE, ds_plist_req[1].searchby, '', TRUE);

  //Set validation code and message.
  //Previously NOCALL would be set if we didn't have a lexID, or if we had FFD suppression.
  //Due to remote linking we call FFD after results, and always call gateway regardless of lexID resolution.
  //NOCALL is no longer relevant to this service.
  validation_code := MAP(remote_linking_result.match => constants.ValidationCode.DID_MATCH,
    ds_tufa_soap_response[1].response._header.status = constants.GatewayStatus.ERROR => constants.ValidationCode.INVALID_RESPONSE,
    FCRAGateway_Services.Functions.GetValidationCode(input_lexID, output_lexID));

  validation_ok := FCRAGateway_Services.Functions.IsValidationOk(validation_code);
  validation_code_desc := constants.GetValidationCodeDesc(validation_code);

  //Retrieve FFD info from person context if inquiry lexID is > 0.
  cia_data := IF(inquiry_log_lexID > 0, FFD.ConsumerInitiatedActivities.Get(inquiry_log_lexID, in_mod.FFDOptionsMask,
    in_mod.FCRAPurpose, in_mod.gateways, FFD.Constants.DataGroupSet.Person, is_reseller))[1];

  //Return results if there's no suppression and lexID validation passed, or if we bypass validation.
  return_results := (~return_matched_lexIDs_only OR validation_ok) AND ~cia_data.suppress_records;

  //Creates a final output and populates the credit information based on suppression.
  FCRAGateway_Services.Layouts.tu_fraud_alert.records_out xtOut() := TRANSFORM
    //Always return the header, royalties, gateway status, errors, and DID validation.
    SELF.response._header := ds_tufa_soap_response[1].response._header;
    SELF.response.UniqueIdValidation := DATASET([{validation_code, validation_code_desc}], iesp.share.t_CodeMap)[1];
    SELF.response.ErrorCodes := ds_tufa_soap_response[1].response.ErrorCodes;
    SELF.response.ErrorTexts := ds_tufa_soap_response[1].response.ErrorTexts;
    SELF.Royalties := ds_royalties;

    //If we were able to retreive consumer data it means we were able to resolve a lexID.
    //Return what we have regardless of the vendor response.
    SELF.response.Consumer :=  consumer;
    SELF.response.ConsumerStatements := cia_data.ConsumerStatements;
    SELF.response.ConsumerAlerts := cia_data.ConsumerAlerts;

    //Only return the rest of the data if we have lexID validation and we are not suppressed by PersonContext.
    SELF := IF(return_results, ds_tufa_with_didville_recs[1]);
    SELF := [];
  END;

  ds_tufa_recs := DATASET([xtOut()]);

  #IF(constants.Debug.TuFraudAlertRecords)
    OUTPUT(ds_tufa_soap_response, NAMED('ds_tufa_soap_response'));
    OUTPUT(ds_tufa_with_didville_recs, NAMED('ds_tufa_with_didville_recs'));
    OUTPUT(ds_plist_req, NAMED('ds_plist_req'));
    OUTPUT(dville_resp, NAMED('dville_resp'));
    OUTPUT(output_lexID, NAMED('output_lexID'));
    OUTPUT(input_lexID, NAMED('input_lexID'));
    OUTPUT(is_lexID_match, NAMED('is_lexID_match'));
    OUTPUT(remote_linking_result, NAMED('remote_linking_result'));
    OUTPUT(inquiry_log_lexID, NAMED('inquiry_log_lexID'));
    OUTPUT(consumer, NAMED('consumer'));
    OUTPUT(cia_data, NAMED('cia_data'));
    OUTPUT(return_results, NAMED('return_results'));
  #END

  RETURN ds_tufa_recs;
END;