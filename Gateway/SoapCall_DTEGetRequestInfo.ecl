IMPORT IESP, Gateway, DeferredTask;

EXPORT Soapcall_DTEGetRequestInfo(DATASET(IESP.DTE_GetRequestInfo.t_DTEGetRequestInfoRequest) recs_in,
															  Gateway.Layouts.Config pGWCfg,
                                                              pWaitTime = 10,
                                                              pRetries = 0,
                                                              BOOLEAN pMakeGatewayCall = FALSE) := FUNCTION

    gateway_URL :=  pGWCfg.url;

    DTEGetRequestInfoResponseWithErrorHandling := RECORD
    STRING ErrorMessage := '';
    INTEGER ErrorCode := 0;
    IESP.DTE_GetRequestInfo.t_DTEGetRequestInfoResponseEx;
    END;

    DTEGetRequestInfoResponseWithErrorHandling onError(IESP.DTE_GetRequestInfo.t_DTEGetRequestInfoRequest le) := transform
        SELF.ErrorMessage := FAILMESSAGE;
        SELF.ErrorCode := FAILCODE;
        self := [];
    end;

    d_recs_out := IF(pMakeGatewayCall, SOAPCALL(recs_in,
    gateway_URL,
    'DTEGetRequestInfo',
    {recs_in},
    dataset(DTEGetRequestInfoResponseWithErrorHandling),
    XPATH('DTEGetRequestInfoResponseEx'),
    ONFAIL(onError(left)), timeout(pWaitTime), retry(pRetries)));

    ParsedJson := DeferredTask.Functions.ParseGetRequestInfo(d_recs_out);
    
    rec := RECORD
    STRING50 RMSID{xpath('RMSID')};
    STRING50 TMSID{xpath('TMSID')};
    STRING10 Orig_RMSID{xpath('Orig_RMSID')};
    END;

    GetRequestTMSIDandRMSID := PROJECT(ParsedJson, TRANSFORM({RECORDOF(LEFT), 
    STRING50 RMSID{xpath('RMSID')}, 
    STRING50 TMSID{xpath('TMSID')},
    STRING10 Orig_RMSID{xpath('Orig_RMSID')}},
    out := FROMXML(rec,LEFT.RequestOpaqueContent);
    SELF.RMSID := out.RMSID;
    SELF.TMSID := out.TMSID;
    SELF.Orig_RMSID := out.Orig_RMSID;
    SELF := LEFT;));

    RETURN GetRequestTMSIDandRMSID;

END;