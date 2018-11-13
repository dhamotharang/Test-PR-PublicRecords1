IMPORT iesp, Gateway, FCRA, FCRAGateway_Services;

EXPORT GetEquifaxLexIDVerification(DATASET(iesp.equifax_ems.t_EquifaxEmsResponseEx) ds_ems_soap_response) := FUNCTION

  soap_response := ds_ems_soap_response[1].response;
  is_soap_call_ok := ~EXISTS(soap_response._header.Exceptions);

  //Transform to convert gateway response PII into a didville request. Didville uses picklist request layout.
  iesp.person_picklist.t_PersonPickListRequest toDidville(iesp.equifax_ems.t_EquifaxEmsResponse resp) := TRANSFORM
    SELF.SearchBy := resp.EmsResponse.borrower;
    SELF := [];
  END;

  //If we have a valid gateway response call didville to retrieve a DID.
  ems_dville_req := IF(is_soap_call_ok, DATASET([toDidville(soap_response)]));
  ems_dville_resp := FCRA.getDidVilleRecords(ems_dville_req[1]);

  //didville will return a header status of 0 on success
  is_dville_ok := ems_dville_resp[1]._header.status = 0;

  //If we have a didville or soapcall error make the lexID zero.
  dville_lexID := IF(is_dville_ok AND is_soap_call_ok, (unsigned6)ems_dville_resp[1].Records[1].UniqueId, 0);

  ds_ems_with_didville_response := PROJECT(ds_ems_soap_response, TRANSFORM(FCRAGateway_Services.Layouts.equifax_ems.gateway_out,
    SELF.lexID := dville_lexID;
    SELF.response := LEFT.response;
    ));

  #IF(FCRAGateway_Services.Constants.Debug.EquifaxEmsGateway)
    OUTPUT(ems_dville_req, NAMED('ems_dville_req'));
    OUTPUT(ems_dville_resp, NAMED('ems_dville_resp'));
    OUTPUT(ds_ems_with_didville_response, NAMED('ds_ems_with_didville_response'));
  #END

  RETURN ds_ems_with_didville_response;
END;