IMPORT Gateway, IESP;

EXPORT SoapCall_OKCStatusRefreshRecommended(DATASET(iesp.okc_statusrefreshrecommended_request.t_OkcStatusRefreshRecommendedRequest ) recs_in,
											Gateway.Layouts.Config pGWCfg, 
											pWaitTime = 6, 
											pRetries = 0, 
											BOOLEAN pMakeGatewayCall = FALSE) := FUNCTION
			
		gateway_URL := pGWCfg.url;
			
		iesp.okc_statusrefreshrecommended_request.t_OkcStatusRefreshRecommendedResponseEx onError(iesp.okc_statusrefreshrecommended_request.t_OkcStatusRefreshRecommendedRequest le) := transform
					self.response._Header.message := FAILMESSAGE;
				    self.response._header.status := FAILCODE;
					self := [];
			end;

			d_recs_out := IF(pMakeGatewayCall, SOAPCALL(recs_in,
			gateway_URL,
			'OkcStatusRefreshRecommended', 
			{recs_in},
			dataset(iesp.okc_statusrefreshrecommended_request.t_OkcStatusRefreshRecommendedResponseEx),
			XPATH('OkcStatusRefreshRecommendedResponseEx'),
			ONFAIL(onError(left)), timeout(pWaitTime), retry(pRetries)));
				
			RETURN d_recs_out;
END;