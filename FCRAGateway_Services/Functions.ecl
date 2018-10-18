IMPORT iesp, Gateway, FCRAGateway_Services;

EXPORT Functions := MODULE
  EXPORT GetValidationCode(UNSIGNED6 inDid, UNSIGNED6 outDid) := FUNCTION
    RETURN MAP(
        inDid = 0 => FCRAGateway_Services.Constants.ValidationCode.INPUT_DID_NOTFOUND,
        outDid = 0 => FCRAGateway_Services.Constants.ValidationCode.OUTPUT_DID_NOTFOUND,
        inDid <> outDid => FCRAGateway_Services.Constants.ValidationCode.DID_MISMATCH,
        inDid = outDid => FCRAGateway_Services.Constants.ValidationCode.DID_MATCH, 0);
  END;

  EXPORT IsValidationOk(INTEGER code) := FUNCTION
    RETURN code IN
      [FCRAGateway_Services.Constants.ValidationCode.DID_MATCH,
      FCRAGateway_Services.Constants.ValidationCode.REMOTE_LINKING_MATCH];
  END;

  //TuFraudAlert specific functions
  EXPORT TuFraudAlert := MODULE

  //Calls remote linking via SOAPCALL and returns true if remote linking considers it a match.
    EXPORT Get_RL_Match(iesp.tu_fraud_alert.t_TuFraudAlertRequest request,
      iesp.tu_fraud_alert.t_TuFraudAlertResponse response, DATASET(Gateway.layouts.config) gateways) := FUNCTION

        rl_request := DATASET([FCRAGateway_Services.TuFraudAlert_Transforms.input_output_to_remote_linking(request, response)]);

        rl_result := Gateway.SoapCall_RemoteLinking_Batch(rl_request, gateways);

        RETURN rl_result[1];
    END;

  END;

END;