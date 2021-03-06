IMPORT iesp, FCRA, FCRAGateway_Services;

EXPORT GetTufaLexIDVerification(DATASET(iesp.tu_fraud_alert.t_TuFraudAlertResponseEx) ds_tufa_soap_response,
  iesp.share.t_User user) := FUNCTION

    soap_response := ds_tufa_soap_response[1].response;
    is_soap_call_ok := soap_response._header.status = FCRAGateway_Services.Constants.GatewayStatus.SUCCESS;

    //If we have a valid gateway response call picklist to retrieve a DID.
    tufa_dville_req := IF(is_soap_call_ok, PROJECT(DATASET(soap_response),
      FCRAGateway_Services.TuFraudAlert_Transforms.output_to_lexId_resolution(LEFT, user)));

    tufa_dville_resp := FCRA.getDidVilleRecords(tufa_dville_req[1]);

    //didville will return a header status of 0 on success
    is_dville_ok := tufa_dville_resp[1]._header.status = 0;

    //If we have a soapcall or didville error make the lexID zero.
    dville_lexID := IF(is_soap_call_ok AND is_dville_ok, (unsigned6)tufa_dville_resp[1].Records[1].UniqueId, 0);

    ds_tufa_with_didville_response := PROJECT(ds_tufa_soap_response, TRANSFORM(FCRAGateway_Services.Layouts.tu_fraud_alert.gateway_out,
      SELF.lexID := dville_lexID,
      SELF.response := LEFT.response));

    #IF(FCRAGateway_Services.Constants.Debug.TuDidvilleVerification)
      output(tufa_dville_req, NAMED('tufa_dville_req'));
      output(tufa_dville_resp, NAMED('tufa_dville_resp'));
      output(ds_tufa_with_didville_response, NAMED('ds_tufa_with_didville_response'));
    #END

    RETURN ds_tufa_with_didville_response;
END;