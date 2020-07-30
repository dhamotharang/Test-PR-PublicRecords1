IMPORT gateway;

/*
  ** A generic functionmacro to soapcall a target roxie query.
  ** 
  ** @param service_url       target cluster url; REQUIRED, see Gateway._shortcuts for reference.
  ** @param query_name        target query; REQUIRED.
  ** @param in_recs           dataset of testcases; REQUIRED. 
  ** @param output_layout     query output layout; REQUIRED.
  ** @param alias_suffix      target query name suffix (alias); OPTIONAL.
  ** @param xpath_results     path used to access results in query response; OPTIONAL. 
  **
  ** @returns                 a dataset containing query results.
  ** 
*/
EXPORT SOAPCallRoxieQuery(
  service_url, 
  query_name,
  in_recs, 
  output_layout,
  alias_suffix = '\'\'',
  xpath_results = '\'\''
  ) := FUNCTIONMACRO
  
  IMPORT dev_regression, gateway, risk_indicators;

  LOCAL gateways := Gateway.Configuration.Get();
  LOCAL input_layout := RECORDOF(in_recs);

  // wrap request so that we create the root xml tag. Gateway URLs sent as part of soap request.
  LOCAL soap_request_rec	:= RECORD
    input_layout;
    DATASET(risk_indicators.Layout_Gateways_In)	gateways;
  END;

  LOCAL soap_response_rec := RECORD
    RECORDOF(output_layout);
    dev_regression.layouts.soap_common.soap_status;
    dev_regression.layouts.soap_common.soap_message;
  END;

  LOCAL soap_response_rec xt_fail() := TRANSFORM
    SELF.soap_status := FAILCODE;
    SELF.soap_message := FAILMESSAGE('soapresponse');
    SELF :=	[];
  END;

  LOCAL soap_request_rec wrap_request(input_layout le) := TRANSFORM
    SELF.gateways := PROJECT(gateways, risk_indicators.Layout_Gateways_In);
    SELF := le;
  END;

  LOCAL _query_name := query_name + IF(alias_suffix <> '', TRIM(alias_suffix, LEFT, RIGHT), '');
  LOCAL _xpath := _query_name + IF(xpath_results <> '', xpath_results, 'Response/Results/Result/Dataset[@name=\'Results\']/Row');
  
  LOCAL soap_response_rec make_soap_call(input_layout in_request) := FUNCTION
    soap_recs_in := DATASET([wrap_request(in_request)]);
    soap_recs_out := SOAPCALL(soap_recs_in, service_url,
      _query_name, {soap_recs_in}, DATASET(soap_response_rec),
      // PARALLEL(30),
      XPATH(_xpath),
      ONFAIL(xt_fail())
    );
    RETURN soap_recs_out;
  END;

  LOCAL out_resp_rec := RECORD
    dev_regression.layouts.soap_common.soap_seq;
    dev_regression.layouts.soap_common.soap_status;
    dev_regression.layouts.soap_common.soap_message;
    dataset(soap_response_rec) results;
  END;

  LOCAL out_recs := PROJECT(in_recs, TRANSFORM(out_resp_rec,
    soap_resp := make_soap_call(left);
    SELF.soap_seq := COUNTER;
    SELF.soap_status := soap_resp[1].soap_status;
    SELF.soap_message := soap_resp[1].soap_message;
    SELF.results := soap_resp;
  ));

  RETURN out_recs;

ENDMACRO;
