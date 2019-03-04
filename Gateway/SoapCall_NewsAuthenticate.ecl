
import iesp;

// the authenticate reqest is only used to get a security token that is required to make the 
// NewsSearch request.  The input should just be a single record, and can probably just
// be blank -- let this code populate the reference code.

/*
EXAMPLE:
gates := dataset([{'News','http://khillqa:[PASSWORD_REDACTED]@espdev.br.seisint.com:5005/WsGateway'}], Risk_Indicators.Layout_Gateways_In);

#stored('_TransactionId', '111r000');
#stored('Gateways',gates);

gateway_cfg  := Gateway.Configuration.get()(Gateway.Configuration.IsNews(servicename))[1];	

auth := Gateway.SoapCall_NewsAuthenticate(dataset([TRANSFORM(iesp.gateway_news.t_NewsAuthenticateRequest, self.user.BillingCode := 'AMLRISK', self.user.QueryID := 'auth', self:=[])]), gateway_cfg);

*/


EXPORT SoapCall_NewsAuthenticate (DATASET(iesp.gateway_news.t_NewsAuthenticateRequest) authReq, 
												 Layouts.Config gateway_cfg,
												 integer waittime = Constants.Defaults.DEFAULT_TIMEOUT, 
												 integer retries	= Constants.Defaults.RETRIES) := FUNCTION


  extended_response := record (iesp.gateway_news.t_NewsAuthenticateResponseEx)
    string soap_message {maxlength (8000)} := '';
  end;

	extended_response failX(iesp.gateway_news.t_NewsAuthenticateRequest L) := TRANSFORM	
    SELF.soap_message := FAILMESSAGE('soapresponse');
		SELF.response._header.queryID := L.user.queryid;
		SELF := L;
		SELF := [];
	END;

	iesp.gateway_news.t_NewsAuthenticateResponseEx FormatFail(extended_response L) := TRANSFORM
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
		SELF.response._header.status := errorC; 
		SELF.response._header.Message := ds_e[1].Message;
		SELF := L;
	END;

	authReq_r := project(authReq, 
											transform(iesp.gateway_news.t_NewsAuthenticateRequest,
																self.User.ReferenceCode := if(left.User.ReferenceCode<>'', left.User.ReferenceCode, gateway_cfg.TransactionId),
																self.options.Blind := Gateway.Configuration.GetBlindOption(gateway_cfg),
																self := left));

	STRING serviceName := 'NewsAuthenticate';

	gateway_url := gateway_cfg.Url;
	
	authResp := if( gateway_url != '', SOAPCALL(authReq_r,
											gateway_cfg.Url,
											serviceName,
											{authReq_r},
											DATASET(extended_response),
											XPATH('NewsAuthenticateResponseEx'),
											ONFAIL(failx(LEFT)),
											RETRY(retries),
											TIMEOUT(waittime),
											TRIM,
											LOG));
	
	authResp_f := PROJECT(authResp,FormatFail(LEFT));
	
  RETURN authResp_f;

END;	
