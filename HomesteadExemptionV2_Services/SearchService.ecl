// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================

IMPORT iesp, WSInput, Royalty;

EXPORT SearchService := MACRO

  // #OPTION('optimizeLevel',2); // option is to help speed up compile times in dev roxie
  #CONSTANT('SearchLibraryVersion',AutoheaderV2.Constants.LibVersion.SALT);
  #CONSTANT('TwoPartySearch', FALSE);
  WSInput.MAC_HomesteadExemption_SearchService();

  rec_in := iesp.Homestead_Exemption_Search.t_HomesteadExemptionSearchRequest;
  ds_in := DATASET([],rec_in) : STORED ('HomesteadExemptionSearchRequest', FEW);
  first_row := ds_in[1] : INDEPENDENT;

  HomesteadExemptionV2_Services.IParams.SetInputUser(first_row.user);
  HomesteadExemptionV2_Services.IParams.SetInputOptions(first_row.options);

  in_mod:=HomesteadExemptionV2_Services.IParams.getParams();
  IF(NOT in_mod.isValidGlb(), FAIL(HomesteadExemptionV2_Services.Constants.GLB_REQUIRED_MSG));

  ds_batch_in :=HomesteadExemptionV2_Services.fn_getSearchInput(first_row.searchby);
  ds_seq_input:=HomesteadExemptionV2_Services.Functions.seqLinkInput(ds_batch_in);
  ds_work_recs:=HomesteadExemptionV2_Services.Records(ds_seq_input,in_mod);

  ds_srch_recs:=HomesteadExemptionV2_Services.fn_getSearchOutput(ds_work_recs,in_mod);
  iesp.ECL2ESP.Marshall.MAC_Marshall_Results(ds_srch_recs,ds_marshall,iesp.Homestead_Exemption_Search.t_HomesteadExemptionSearchResponse);

  // EXCEPTIONS
  ds_results:=PROJECT(ds_marshall,TRANSFORM(iesp.Homestead_Exemption_Search.t_HomesteadExemptionSearchResponse,
    SELF._Header.Exceptions:=HomesteadExemptionV2_Services.Functions.getExceptions(ds_srch_recs),
    SELF.InputEcho:=first_row.searchby,
    SELF:=LEFT));

  // ROYALTIES
  ds_property_recs:=NORMALIZE(ds_work_recs,LEFT.property_records,TRANSFORM(HomesteadExemptionV2_Services.Layouts.propertyRec,SELF:=RIGHT));
  ds_vehicle_recs:=NORMALIZE(ds_property_recs,LEFT.vehicle_records,TRANSFORM(HomesteadExemptionV2_Services.Layouts.vehRoyaltyRec,SELF:=RIGHT));
  Royalty.RoyaltyVehicles.MAC_SearchSet(ds_vehicle_recs,ds_royalties,datasource);

  OUTPUT(ds_results,NAMED('Results'));
  OUTPUT(ds_royalties,NAMED('RoyaltySet'));

ENDMACRO;
