IMPORT IESP, Gateway, DeferredTask;

EXPORT Soapcall_DTEGetRequestInfo(DATASET(IESP.DTE_GetRequestInfo.t_DTEGetRequestInfoRequest) recs_in,
															  Gateway.Layouts.Config pGWCfg,
                                                              pWaitTime = 3, 
                                                              pRetries = 0,
                                                              BOOLEAN pMakeGatewayCall = FALSE) := FUNCTION
                                
gateway_URL :=  pGWCfg.url;

IESP.DTE_GetRequestInfo.t_DTEGetRequestInfoResponseEx onError(IESP.DTE_GetRequestInfo.t_DTEGetRequestInfoRequest le) := transform
    self.response._Header.message := FAILMESSAGE;
    self.response._header.status := FAILCODE;
    self := [];
end;

d_recs_out := IF(pMakeGatewayCall, SOAPCALL(recs_in,
gateway_URL,
'DTEGetRequestInfo', 
{recs_in},
dataset(IESP.DTE_GetRequestInfo.t_DTEGetRequestInfoResponseEx),
XPATH('DTEGetRequestInfoResponse'),
ONFAIL(onError(left)), timeout(pWaitTime), retry(pRetries)));

ParsedJson := DeferredTask.Functions.ParseGetRequestInfo(d_recs_out);

RETURN ParsedJSON;	
            
END;