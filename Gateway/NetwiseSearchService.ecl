﻿/*
  Stand-alone gateway 'wrapper' service to hit the NetWise Data gateway, 
  which will be used for the Accurint Virtual Identity Report V2 online product.
*/

EXPORT NetwiseSearchService() := MACRO

  #WEBSERVICE(FIELDS(	
  /*---- Compliance Fields ----*/ // not needed for phase1, but may be needed for phase 2 CCPA changes???
  //'DataPermissionMask',
  //'DataRestrictionMask',
  //'DPPAPurpose',
  //'GLBPurpose',

  /*---- Other Fields ----*/
  'NetwiseQueryRequest',
  'gateways'
  ));

  IMPORT Gateway, iesp, Royalty, ut;

  // Input request
  ds_request_in := 
     DATASET([], iesp.net_wise.t_NetWiseQueryRequest) : STORED('NetWiseQueryRequest', FEW);

  first_row := ds_request_in[1] : INDEPENDENT;
	iesp.ECL2ESP.SetInputUser(first_row.user);

  // mod_Params is not really needed for phase 1, since we don't use any standard input 
  // params (like DPPA, GLB) at all.
  // However using it for consistency & for any future phase 2 CCPA changes use.
  mod_Params := Gateway.NetWiseSearch.IParams.GetParams();

  // Check for an empty 'gateways' input ds here and fail if it is
  IF(NOT EXISTS(mod_params.gateways),
     FAIL(ut.constants_MessageCodes.GATEWAY_URL_MISSING, //errorcode=the closest one I could find 
          Gateway.NetwiseSearch.Constants.GATEWAYS_EMPTY_MESSAGE));

  // Get the gateway response records
  ds_gw_recs_out := Gateway.NetwiseSearch.Records(ds_request_in, 
                                                  mod_Params);

  // Count Royalties
  ds_royalties := Royalty.RoyaltyNetWise.GetRoyalties(ds_gw_recs_out);

  OUTPUT(ds_gw_recs_out, named('Results'));
  OUTPUT(ds_royalties,   named('RoyaltySet'));

ENDMACRO;
