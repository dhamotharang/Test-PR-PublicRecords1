
import iesp, _Control, OFAC_XG5;

// 
// 

EXPORT SoapCall_BridgerSSXG5 (DATASET(iesp.WsSearchCore.t_SearchRequest) searchReq, 
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

	iesp.WsSearchCore.t_SearchResponse failX(iesp.WsSearchCore.t_SearchRequest L) := TRANSFORM	
    SELF.SearchResult.ErrorMessage := FAILMESSAGE;
    SELF.SearchResult.Blockid := l.Input.Blockid;
		SELF := L;
		SELF := [];
	END;

STRING serviceName := 'Search';

gateway_URL := gateway_cfg.url;
	 
 searchReq_r := project(searchReq, 
											transform(iesp.WsSearchCore.t_SearchRequest,
																self := left));
                                
ENV := _Control.ThisEnvironment.RoxieEnv;

searchResp_PRCT := OFAC_XG5.PRCT_Function(searchReq);

	
searchResp_PROD := if( gateway_url != '', SOAPCALL(searchReq_r,
											gateway_cfg.Url,
											serviceName,
											{searchReq_r},
											DATASET(iesp.WsSearchCore.t_SearchResponse),
											XPATH('SearchResponse'),
											ONFAIL(failx(LEFT)),
											RETRY(retries),
											TIMEOUT(waittime)));                     


// searchResp := if(ENV = 'QA', searchResp_PRCT, searchResp_PROD);
// searchResp := if(ENV = 'QA', searchResp_PROD, searchResp_PRCT);
searchResp := if(ENV = 'DProd' or ENV = 'DQA', searchResp_PRCT, searchResp_PROD);


	// output(searchReq_r, named('searchReq_r'));
	// output(gateway_cfg, named('gateway_cfg'));
	// output(gateway_url, named('gateway_url'));
	// output(searchResp, named('searchResp'));

return searchResp;

END;	
