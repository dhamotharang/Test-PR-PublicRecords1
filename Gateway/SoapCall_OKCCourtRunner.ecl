IMPORT Gateway, IESP;

EXPORT SoapCall_OKCCourtRunner(DATASET(iesp.okc_courtrunner_request.t_OkcCourtRunnerRequest) recs_in,
											Gateway.Layouts.Config dGateway,
											pWaitTime = 10,
											pRetries = 0) := FUNCTION

   iesp.okc_courtrunner_request.t_OkcCourtRunnerRequest getRequest(iesp.okc_courtrunner_request.t_OkcCourtRunnerRequest l) := TRANSFORM
        SELF.SearchBy.ProceedingTypeId := l.SearchBy.ProceedingTypeId;
        SELF.SearchBy.RMSId            := l.SearchBy.RMSId;
        SELF.User.ReferenceCode        := l.User.ReferenceCode;
        SELF := [];
   END;

   gateway_URL := dGateway.url;

   iesp.okc_courtrunner_request.t_OkcCourtRunnerResponseEx onError(iesp.okc_courtrunner_request.t_OkcCourtRunnerRequest le) := TRANSFORM
         SELF.response._Header.message := FAILMESSAGE;
         SELF.response._header.status := FAILCODE;
         SELF := [];
   END;

   d_recs_out := SOAPCALL(recs_in,
                          gateway_URL,
                          'OkcCourtRunner',
                          iesp.okc_courtrunner_request.t_OkcCourtRunnerRequest,
                          getRequest(LEFT),
                          dataset(iesp.okc_courtrunner_request.t_OkcCourtRunnerResponseEx),
                          XPATH('OkcCourtRunnerResponseEx'),
                          ONFAIL(onError(left)), timeout(pWaitTime), retry(pRetries), TRIM, LOG);

	RETURN d_recs_out;
END;