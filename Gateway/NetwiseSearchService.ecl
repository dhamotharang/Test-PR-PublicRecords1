/*
  Stand-alone gateway 'wrapper' service to hit the NetWise Data Email gateway, 
  which will be used for the Accurint Virtual Identity Report V2 online product.
*/

EXPORT NetwiseSearchService() := MACRO

  #WEBSERVICE(FIELDS(	
  'NetwiseEmailSearchRequest',
  'gateways'
  ));

  IMPORT Gateway, iesp, Royalty, ut;

  // Input request
  // NOTE: ESP>Roxie/query request input layout is in the iesp.net_wise_search attribute
  // whereas the query > gateway input request  is in the iesp.net_wise attribute; which is used in Gateway.SoapCall_NetWise
  ds_request_in := DATASET([], iesp.net_wise_search.t_NetWiseEmailSearchRequest) : STORED('NetWiseEmailSearchRequest', FEW);

  first_row := ds_request_in[1] : INDEPENDENT;
	iesp.ECL2ESP.SetInputUser(first_row.user);

  mod_Params := Gateway.NetWiseSearch.IParams.GetParams();

  // Get the gateway response records
  ds_gw_recs_out := Gateway.NetwiseSearch.Records(ds_request_in, 
                                                  mod_Params);

  // Count Royalties
  ds_royalties := Royalty.RoyaltyNetWise.GetRoyalties(ds_gw_recs_out);

  OUTPUT(ds_gw_recs_out, named('Results'));
  OUTPUT(ds_royalties,   named('RoyaltySet'));

ENDMACRO;
