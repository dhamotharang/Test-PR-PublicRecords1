
import iesp;

// the news search requires a valid security token, which comes from a call to
// gateway_newsauthenticate.

EXPORT SoapCall_NewsSearch (DATASET(iesp.gateway_news.t_NewsSearchRequest) searchReq, 
												 Layouts.Config gateway_cfg,
												 integer waittime = Constants.Defaults.DEFAULT_TIMEOUT, 
												 integer retries	= Constants.Defaults.RETRIES) := FUNCTION


  extended_response := record (iesp.gateway_news.t_NewsSearchResponseEx)
    string soap_message {maxlength (8000)} := '';
		boolean queryFailed := false;
  end;

	extended_response failX(iesp.gateway_news.t_NewsSearchRequest L) := TRANSFORM	
    SELF.soap_message := FAILMESSAGE('soapresponse');
		SELF.response._header.queryID := L.user.queryid;
		SELF.queryFailed := true;
		SELF := L;
		SELF := [];
	END;

	iesp.gateway_news.t_NewsSearchResponseEx FormatFail(extended_response L) := TRANSFORM
		rec := RECORD  
			STRING  Source   := XMLTEXT('Source');
			INTEGER Code     := (INTEGER) XMLTEXT('faultcode');
			STRING  Location := XMLTEXT('Location');
			STRING  Message  := XMLTEXT('faultstring');
		END;
		
		ds := DATASET([L.soap_message],{STRING line});
		parsedSoapResponse := PARSE(ds,line,rec,XML('soap:Envelope/soap:Body/soap:Fault'));
		ds_e := PROJECT(parsedSoapResponse,iesp.share.t_WsException);

		SELF.response._header.Exceptions := choosen (ds_e, iesp.Constants.MaxResponseExceptions);
		INTEGER errorC := ds_e[1].code;
		SELF.response._header.status := if(errorC=0 and L.queryFailed, -2, errorC); 
		SELF.response._header.Message := ds_e[1].Message;
		SELF := L;
	END;

	searchReq_r := project(searchReq, 
											transform(iesp.gateway_news.t_NewsSearchRequest,
																self.User.ReferenceCode := if(left.User.ReferenceCode<>'', left.User.ReferenceCode, gateway_cfg.TransactionId),
																self.options.Blind := Gateway.Configuration.GetBlindOption(gateway_cfg),
																self := left));

	STRING serviceName := 'NewsSearch';

	gateway_url := gateway_cfg.Url;
	
	searchResp := if( gateway_url != '', SOAPCALL(searchReq_r,
											gateway_cfg.Url,
											serviceName,
											{searchReq_r},
											DATASET(extended_response),
											XPATH('NewsSearchResponseEx'),
											ONFAIL(failx(LEFT)),
											RETRY(retries),
											TIMEOUT(waittime),
											TRIM,
											LOG));
	
	searchResp_f := PROJECT(searchResp,FormatFail(LEFT));
	
  RETURN searchResp_f;

END;	
