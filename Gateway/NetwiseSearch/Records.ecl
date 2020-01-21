IMPORT Doxie, Gateway, iesp, ut;

EXPORT Records(DATASET(iesp.net_wise_search.t_NetWiseEmailSearchRequest) ds_request_in,
               Gateway.NetWiseSearch.IParams.SearchParams in_mod
              ) := FUNCTION

  // Check the input 'gateways' ds for the correct servicename and grab the record.
  ds_gateways_rec := in_mod.gateways(Gateway.Configuration.IsNetWise(servicename))[1];

  makeGatewayCall := TRUE; // always make the gw call since only gw data(no in-house data)

  //Project iesp query search input layout onto the iesp gateway layout 
  ds_gateway_req_in := PROJECT(ds_request_in, 
                               TRANSFORM(iesp.net_wise.t_NetWiseQueryRequest,
                                 SELF := left,
                                 SELF := []  // just null GatewayParams here, they will be set in Gateway.SoapCall_NetWise
                               ));

  // Call the attrribute that does the actual SoapCall
  ds_gw_scnw_out := Gateway.SoapCall_NetWise(ds_gateway_req_in, 
                                             ds_gateways_rec, 
                                             Gateway.NetwiseSearch.Constants.GW_TIMEOUT, 
                                             Gateway.NetWiseSearch.Constants.GW_RETRIES, 
                                             makeGatewayCall, 
                                             in_mod //,
                                             //TRUE // for CCPA opt out/future use???
                                            );

  //Project iesp gateway response layout onto iesp query search response layout
  ds_search_resp_out := PROJECT(ds_gw_scnw_out, iesp.net_wise_search.t_NetWiseEmailSearchResponseEx);


  // Outputs for debugging.  Un-comment them as needed!
  //OUTPUT(ds_request_in,    named('ds_request_in'));
  //OUTPUT(in_mod.gateways,  named('ds_gateways'));
  //OUTPUT(ds_gateways_rec,    named('ds_gateways_rec'));
  //OUTPUT(ds_gateway_req_in, named('ds_gateway_req_in'));
  //OUTPUT(ds_gw_scnw_out,   named('ds_gw_scnw_out'));
  
  RETURN ds_search_resp_out;

END;
