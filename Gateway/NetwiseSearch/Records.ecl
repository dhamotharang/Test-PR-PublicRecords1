IMPORT Doxie, Gateway, iesp, ut;

EXPORT Records(DATASET(iesp.net_wise.t_NetWiseQueryRequest) ds_request_in,
               Gateway.NetWiseSearch.IParams.SearchParams in_mod
              ) := FUNCTION

  // Check the input 'gateways' ds for the correct servicename and grab the record.
  ds_gateways_rec := in_mod.gateways(Gateway.Configuration.IsNetWise(servicename))[1];

  // Use a project just to strip off the 'gateways" dataset
  mod_access := PROJECT(in_mod, Doxie.IDataAccess);

  makeGatewayCall := TRUE; // always make the gw call since only gw data(no in-house data)

  // Call the attrribute that does the actual SoapCall
  ds_gw_scnw_out := Gateway.SoapCall_NetWise(ds_request_in, 
                                             ds_gateways_rec, 
                                             Gateway.NetwiseSearch.Constants.GW_TIMEOUT, 
                                             Gateway.NetWiseSearch.Constants.GW_RETRIES, 
                                             makeGatewayCall, 
                                             mod_access //, 
                                             //TRUE); // for CCPA opt out/future use???
                                            );

  // Outputs for debugging.  Un-comment them as needed!
  //OUTPUT(ds_request_in,    named('ds_request_in'));
  //OUTPUT(in_mod.gateways,  named('ds_gateways'));
  //OUTPUT(ds_gw_scnw_out,   named('ds_gw_scnw_out'));
  
  RETURN ds_gw_scnw_out;

END;
