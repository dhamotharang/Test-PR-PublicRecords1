IMPORT Gateway, iesp;


EXPORT SoapCall_BridgerAPI(DATASET(iesp.gateway_bridgerAPI.t_SearchRequest) searchReq, 
                           Gateway.Layouts.Config gatewayConfig,
                           INTEGER waittime = Gateway.Constants.Defaults.DEFAULT_TIMEOUT,   // 0 is wait forever, default if ommitted is 300 (s)
                           INTEGER retries = Gateway.Constants.Defaults.RETRIES) := FUNCTION     // 0 DEFAULT



    STRING serviceName := 'Search';
    STRING apiResponse := 'SearchResponse';
    STRING apiNameSpace := 'https://bridgerinsight.lexisnexis.com/BridgerInsight.Web.Services.Interfaces.11.3';
    STRING apiSoapAction := TRIM(apiNameSpace) + '/ISearch/Search';
    
    gatewayURL := gatewayConfig.url;
  
  
    iesp.gateway_bridgerAPI.t_SearchResponse failAPI(iesp.gateway_bridgerAPI.t_SearchRequest inSearchReq) := TRANSFORM	
      SELF.SearchResult.Blockid := inSearchReq.Input.BlockID;
      SELF := inSearchReq;
      SELF := [];
    END;


    requestInput := PROJECT(searchReq, TRANSFORM(iesp.gateway_bridgerAPI.t_SearchRequest, SELF := LEFT));
                         
                          
    searchResp := IF(gatewayURL != '', 
                     SOAPCALL(requestInput,
                              gatewayURL,
                              serviceName,
                              {requestInput},
                              DATASET(iesp.gateway_bridgerAPI.t_SearchResponse),
                              XPATH(apiResponse),
                              ONFAIL(failAPI(LEFT)),
                              RETRY(retries),
                              TIMEOUT(waittime),
                              LITERAL,  //service is not necessarily implemented in ESP - so will use serviceName as is vs appending 'Request' to it
                              SOAPACTION(apiSoapAction),
                              NAMESPACE(apiNameSpace)));                     




    // output(searchReq, named('searchReq'), OVERWRITE);
    // output(gatewayURL, named('gatewayURL'));
    // output(searchResp, named('searchResp'), OVERWRITE);
    

    RETURN searchResp;
END;	
