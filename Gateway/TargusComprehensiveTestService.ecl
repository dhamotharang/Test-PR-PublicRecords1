/*
  Stand-alone test service for Targus Comprehensive gateway.
  *** deploy to dev environment only ***
*/
EXPORT TargusComprehensiveTestService() := MACRO

  #WEBSERVICE(FIELDS(	
  /*---- Compliance Fields ----*/
  'DataPermissionMask',
  'DataRestrictionMask',
  'DPPAPurpose',
  'GLBPurpose',
  /*---- Other Fields ----*/
  'TargusSearchRequest',
  'gateways'
  ));

  import iesp, gateway, gateway, royalty;
  ds_req := dataset([], iesp.gateway_targus.t_TargusSearchRequest) : STORED ('TargusSearchRequest', FEW);
	first_row := ds_req[1] : INDEPENDENT;
	iesp.ECL2ESP.SetInputUser(first_row.user);

  in_mod := Gateway.TargusComprehensive.IParams.getParams();
  targus_recs := Gateway.TargusComprehensive.Records(ds_req, in_mod);
  royalties := DATASET([], Royalty.Layouts.Royalty); // TBD

  output(royalties, named('RoyaltySet'));
  output(targus_recs, named('Results'));
  

ENDMACRO;
