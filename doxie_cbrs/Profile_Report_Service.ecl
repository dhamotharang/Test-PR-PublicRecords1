// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================

IMPORT AutoheaderV2, AutoStandardI, doxie, Gateway, Royalty, Risk_Indicators, WSInput;

EXPORT Profile_Report_Service := MACRO
  #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
  #CONSTANT('TwoPartySearch', FALSE);

  //The following macro defines the field sequence on WsECL page of query.
  WSInput.MAC_Profile_Report_Service();

  #OPTION('spotThroughAggregate', 0);
  #CONSTANT('useSupergroup',TRUE);
  #STORED('useSupergroupPropertyAddress',FALSE);
  #CONSTANT('AlwaysCompute',TRUE);
  #CONSTANT('useLevels',TRUE);

  UNSIGNED1 ofac_version := 1 : STORED('OFACVersion');
  include_ofac := IF(ofac_version = 1, FALSE, TRUE);
  global_watchlist_threshold := IF(ofac_version IN [1, 2, 3], 0.8, 0.85);

  gateways_in := Gateway.Configuration.Get();
  mod_access := Doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());

  Gateway.Layouts.Config gw_switch(gateways_in le) := TRANSFORM
    SELF.servicename := IF(ofac_version = 4 AND le.servicename = 'bridgerwlc',le.servicename, '');
    SELF.url := IF(ofac_version = 4 AND le.servicename = 'bridgerwlc', le.url, '');
    SELF := le;
  END;
  gateways := PROJECT(gateways_in, gw_switch(LEFT));

  IF( ofac_version = 4 AND NOT EXISTS(gateways(servicename = 'bridgerwlc')) , FAIL(Risk_Indicators.iid_constants.OFAC4_NoGateway));

  all_recs_prs := doxie_cbrs.all_records_prs(doxie_cbrs.ds_subject_BDIDs, mod_access, ofac_version, include_ofac, global_watchlist_threshold);

  doxie_crs.layout_property_ln property_child(doxie_cbrs.layout_profile_property l):= TRANSFORM
    SELF := l;
    SELF :=[];
  END;

  property_table := NORMALIZE(all_recs_prs, LEFT.property_children,property_child(RIGHT));
  property_total :=DEDUP(SORT(property_table,ln_fares_id),ln_fares_id);
  Royalty.RoyaltyFares.MAC_SetB(property_total, property_royalties);

  dnb_table := NORMALIZE(all_recs_prs, LEFT.dnb_children, TRANSFORM(RIGHT));
  dnb_royalties := Royalty.RoyaltyDNB.GetOnlineRoyalties(dnb_table);

  royalties := property_royalties + dnb_royalties;
  DO_ALL := SEQUENTIAL(OUTPUT(all_recs_prs, NAMED('PRS_Result')), OUTPUT(royalties,NAMED('RoyaltySet')));
  IF(doxie_cbrs.subject_BDID > 0, DO_ALL, OUTPUT('No BDID Provided.'));
ENDMACRO;
