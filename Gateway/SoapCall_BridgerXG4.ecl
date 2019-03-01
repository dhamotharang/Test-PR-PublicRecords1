
import iesp;

// 

EXPORT SoapCall_BridgerXG4 (DATASET(iesp.gateway_bridgerxg5.t_SearchCoreRequest) searchReq, 
												 Gateway.Layouts.Config gateway_cfg,
												 integer waittime = Constants.Defaults.DEFAULT_TIMEOUT,   // 0 is wait forever, default if ommitted is 300 (s)
												 integer retries	= Constants.Defaults.RETRIES) := FUNCTION     // 0 DEFAULT

/*
export t_SearchResults := record
	integer BlockID {xpath('BlockID')};
	string ErrorMessage {xpath('ErrorMessage')};
	string WarningMessage {xpath('WarningMessage')};
	string SearchTime {xpath('SearchTime')};
	string WriteTime {xpath('WriteTime')};
	dataset(t_ResultEntityRecord) EntityRecords {xpath('EntityRecords/EntityRecord'), MAXCOUNT(1)};
	dataset(t_ResultTextRecord) TextRecords {xpath('TextRecords/TextRecord'), MAXCOUNT(1)};
	dataset(t_ResultUnstructuredEFTRecord) UnstructuredEFTRecords {xpath('UnstructuredEFTRecords/UnstructuredEFTRecord'), MAXCOUNT(1)};
end;
*/

	iesp.gateway_bridgerxg5.t_SearchCoreResponseEx failX(iesp.gateway_bridgerxg5.t_SearchCoreRequest L) := TRANSFORM	
    SELF.response.ErrorMessage := FAILMESSAGE;
    SELF.response.Blockid := l.Input.Blockid;
		SELF := L;
		SELF := [];
	END;

	iesp.gateway_bridgerxg5.t_SearchCoreResponseEx FormatFail(iesp.gateway_bridgerxg5.t_SearchCoreResponseEx le) := transform
			rec:=record  
				string Source :=XMLTEXT('Source');
				integer Code := (integer) XMLTEXT('faultcode');
				string Location := XMLTEXT('Location');
				string Message := XMLTEXT('faultstring');
			end;
		
			ds := dataset([le.response._header.Message],{string line});
			parsedSoapResponse := parse (ds,line, rec, xml('soap:Envelope/soap:Body/soap:Fault'));
			ds_e:=project(parsedSoapResponse,iesp.share.t_WsException);

			self.response._header.Exceptions:=ds_e;
			integer errorC := ds_e[1].code;
			self.response._header.Message := ds_e[1].Message;
			self:=le;
	end;


	searchReq_r := project(searchReq, 
											transform(iesp.gateway_bridgerxg5.t_SearchCoreRequest,
																self := left));

	STRING serviceName := 'searchcore';

	gateway_URL := gateway_cfg.url;
	
	searchResp := if( gateway_url != '', SOAPCALL(searchReq_r,
											gateway_cfg.Url,
											serviceName,
											{searchReq_r},
											DATASET(iesp.gateway_bridgerxg5.t_SearchCoreResponseEx),
											XPATH('SearchCoreResponseEx'),
											ONFAIL(failx(LEFT)),
											RETRY(retries),
											TRIM,
											TIMEOUT(waittime)));
											
											

	
	final := project (searchResp, FormatFail (Left));

	// output(searchReq_r, named('searchReq_r'));
	// output(gateway_cfg, named('gateway_cfg'));
	// output(gateway_url, named('gateway_url'));
	// output(searchResp, named('searchResp'));
	// output(final, named('final'));
	
	
  RETURN final;

END;	
