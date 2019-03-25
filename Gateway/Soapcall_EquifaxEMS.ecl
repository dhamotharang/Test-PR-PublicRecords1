IMPORT _Control, iesp, FCRAGateway_Services, Gateway, Royalty;

EXPORT SoapCall_EquifaxEms(
  DATASET(iesp.equifax_ems.t_EquifaxEmsRequest) ds_ems_req,
  DATASET(Gateway.Layouts.Config) gateways,
  BOOLEAN makeGatewayCall=FALSE,
  //Vendor QA gateway is slow. Set to 35 seconds if on QA env.
  INTEGER waittime= IF(_Control.ThisEnvironment.Name = 'QA', 35, 10),
  INTEGER retries=Gateway.Constants.Defaults.RETRIES) := FUNCTION

  //Get the URL for the EMS credit gateway
  ems_gw := gateways(Gateway.Configuration.IsEquifaxEmsReport(servicename))[1];

  //Set the gateway parameters, including royalty codes.
  iesp.equifax_ems.t_EquifaxEmsRequest setGatewayParams(iesp.equifax_ems.t_EquifaxEmsRequest L) := TRANSFORM
    SELF.GatewayParams.TxnTransactionId := Gateway.Configuration.GetTransactionIdX(ems_gw);
    SELF.GatewayParams.BatchJobId       := Gateway.Configuration.GetBatchJobId(ems_gw);
    SELF.GatewayParams.ProcessSpecId    := Gateway.Configuration.GetBatchspecId(ems_gw);
    SELF.GatewayParams.QueryName        := Gateway.Configuration.GetRoxieQueryName(ems_gw);
    SELF.GatewayParams.RoyaltyCode      := Royalty.Constants.RoyaltyCode.EFX_EMS;
    SELF.GatewayParams.RoyaltyType      := Royalty.Constants.RoyaltyType.EFX_EMS;
    SELF.GatewayParams.CheckVendorGatewayCall := TRUE;
    SELF.GatewayParams.MakeVendorGatewayCall  := makeGatewayCall;
    SELF.Options.Blind := Gateway.Configuration.GetBlindOption(ems_gw);
    SELF:=L;
  END;

  //Add the gateway parameters to the request.
  soapReq := PROJECT(ds_ems_req, setGatewayParams(LEFT));

  extended_response := RECORD (iesp.equifax_ems.t_EquifaxEmsResponseEx)
    STRING soap_message {MAXLENGTH(8000)} := '';
  END;

  //This executes when we get a response with status <> 200
  extended_response failX(iesp.equifax_ems.t_EquifaxEmsRequest L) := TRANSFORM
    SELF.soap_message := FAILMESSAGE('soapresponse');
    SELF := [];
  END;

  extended_response doSoapCall(iesp.equifax_ems.t_EquifaxEmsRequest L) := TRANSFORM
    ds_soapReq:= DATASET([L],iesp.equifax_ems.t_EquifaxEmsRequest);

    ds_soapResp:= SOAPCALL(ds_soapReq, ems_gw.URL, 'EquifaxEms', iesp.equifax_ems.t_EquifaxEmsRequest,
      TRANSFORM(iesp.equifax_ems.t_EquifaxEmsRequest, SELF := LEFT, SELF := []),
      DATASET(extended_response),XPATH('EquifaxEmsResponseEx'),
      ONFAIL(failx(LEFT)),RETRY(retries),TIMEOUT(waittime),TRIM,LOG);

    //Save the query ID since it's not returned by SOAPCALL
    SELF.response._header.QueryId := L.User.QueryId;

    //Save the response and exceptions. This gateway is designed differently, normally
    //exceptions are caught by ONFAIL but this gateway can also return exceptions with status 200.
    SELF.exceptions := ds_soapResp[1].exceptions;
    SELF.response := ds_soapResp[1].response;
    SELF.soap_message := ds_soapResp[1].soap_message;
  END;

  //Make the SOAP call, or just return an empty dataset if we shouldn't make the call.
  soapResp := IF(makeGatewayCall, PROJECT(soapReq, doSoapCall(LEFT)),
    DATASET([],extended_response));

  //This transform converts the soap response to a dataset and catches all exceptions.
  iesp.equifax_ems.t_EquifaxEmsResponseEx pickupSoapMessage(extended_response L) := TRANSFORM
    //soapFault exceptions occur when the ESP response status <> 200
    soapMsg := DATASET([L.soap_message],{STRING line});
    parsedSoapResponse := PARSE(soapMsg,line,FCRAGateway_Services.Layouts.fault_rec,XML('soap:Envelope/soap:Body/soap:Fault'));
    soapFault := PROJECT(parsedSoapResponse,iesp.share.t_WsException);

    //espFault are from the ESP layer, and not from the external gateway, and have a response status of 200.
    espFault := PROJECT(L.exceptions, TRANSFORM(iesp.share.t_WsException,
      SELF := LEFT,
      SELF := []
    ));

    //For royalty tracking we count status of 200 as a charge.
    //We are charged any time we get a response from the external gateway that
    //has a pdfReport or an error message present.
    //If espFault or soapFault is present we do not contact the external gateway so there is no charge.
    isResponseInvalid := EXISTS(espFault) OR EXISTS(soapFault) OR
      (L.response.emsResponse.pdfReport = '' AND L.response.emsResponse.errorInfo.errorMessage = '');

    SELF.response._header.Message := soapFault[1].Message;
    SELF.response._header.status := MAP(
      makeGatewayCall = FALSE => FCRAGateway_Services.Constants.GatewayStatus.NOCALL,
      isResponseInvalid => FCRAGateway_Services.Constants.GatewayStatus.ERROR,
      FCRAGateway_Services.Constants.GatewayStatus.SUCCESS
    );

    SELF.response._header.Exceptions := CHOOSEN(soapFault + espFault, iesp.Constants.MaxResponseExceptions);
    SELF := L;
  END;

  #IF(FCRAGateway_Services.Constants.Debug.EquifaxEmsSoapcall)
    OUTPUT(makeGatewayCall, NAMED('makeGatewayCall'));
    OUTPUT(ds_ems_req, NAMED('ds_ems_req'));
    OUTPUT(soapReq, NAMED('ems_soapReq'));
    OUTPUT(soapResp, NAMED('ems_soapResp'));
  #END

  RETURN PROJECT(soapResp, pickupSoapMessage(LEFT));

END;