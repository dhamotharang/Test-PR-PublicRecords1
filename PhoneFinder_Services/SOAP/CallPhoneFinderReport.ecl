/***************************************************************************
 *
 * NOTE: All code below is for testing purposes only. 
 *
 ***************************************************************************/
import gateway, iesp, risk_indicators;

EXPORT CallPhoneFinderReport(DATASET(iesp.phonefinder.t_PhoneFinderSearchRequest) in_recs, STRING service_url) 
:= FUNCTION 
  
  gateways := Gateway.Configuration.Get();

  // wrap request so that we create the root xml tag. Gateway URLs must be sent as part of soap request.
  layout_request_wrap	:= RECORD
    DATASET(iesp.phonefinder.t_PhoneFinderSearchRequest) PhoneFinderSearchRequest;
    DATASET(risk_indicators.Layout_Gateways_In)	gateways;
  END;

  soap_req_wrap	:= project(in_recs, TRANSFORM(layout_request_wrap,
    SELF.PhoneFinderSearchRequest := LEFT;
    SELF.gateways := PROJECT(gateways, risk_indicators.Layout_Gateways_In);
  ));

  iesp.phonefinder.t_PhoneFinderSearchResponse xtFail(soap_req_wrap l) := TRANSFORM
    SELF._Header.Status := FAILCODE;
    SELF._Header.Message := if (FAILCODE=0, 'SUCCESS', FAILMESSAGE);
    SELF :=	[];
  END;

  soap_resp_recs :=	SOAPCALL(soap_req_wrap, service_url,
    'phonefinder_services.phonefinderreportservice',
    {soap_req_wrap},
    DATASET(iesp.phonefinder.t_PhoneFinderSearchResponse),
    // PARALLEL(30),
    XPATH('phonefinder_services.phonefinderreportserviceResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
    ONFAIL(xtFail(LEFT))
  );

  RETURN soap_resp_recs;

END;
