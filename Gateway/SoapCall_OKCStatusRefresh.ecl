IMPORT Gateway, IESP;

EXPORT SoapCall_OKCStatusRefresh(DATASET(iesp.okc_statusrefresh_request.t_OkcStatusRefreshRequest ) recs_in,
											Gateway.Layouts.Config pGWCfg, 
											pWaitTime = 5, 
											pRetries = 0, 
											BOOLEAN pMakeGatewayCall = FALSE) := FUNCTION
			
			gateway_URL := pGWCfg.url;
			
			iesp.okc_statusrefresh_request.t_OkcStatusRefreshResponseEx onError(iesp.okc_statusrefresh_request.t_OkcStatusRefreshRequest le) := transform
					self.response._Header.message := FAILMESSAGE;
				    self.response._header.status := FAILCODE;
					self := [];
			end;
			
			d_recs_out := IF(pMakeGatewayCall, SOAPCALL(recs_in,
			gateway_URL,
			'OkcStatusRefresh', 
			{recs_in},
			dataset(iesp.okc_statusrefresh_request.t_OkcStatusRefreshResponseEx),
			XPATH('OkcStatusRefreshResponseEx'),
			ONFAIL(onError(left)), timeout(pWaitTime), retry(pRetries)));

			RETURN d_recs_out;
END;