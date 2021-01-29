// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
IMPORT AutoStandardI, iesp, ut, Address, FFD, STD;

EXPORT SearchServiceFCRA := MACRO

  #ONWARNING(4207, ignore);
  BOOLEAN isFCRA := TRUE;
  #CONSTANT('NoDeepDive', TRUE);
  #CONSTANT('DidOnly', TRUE); // for picklist

  // Get XML input
  rec_in := iesp.sexualoffender_fcra.t_FcraSexOffenderSearchRequest;
  ds_in := DATASET ([], rec_in) : STORED ('FcraSexOffenderSearchRequest', FEW);
  first_row := ds_in[1] : INDEPENDENT;
  search_by := GLOBAL (first_row.SearchBy);

  // This will set Name, Address, SSN, DID and DOB
  // NOTE: Even though the ECL2ESP function used below is named SetInputReportBy,
  // it can also be used to set certain search_by fields.
  report_by := ROW (search_by, TRANSFORM (iesp.bpsreport.t_BpsReportBy, SELF := LEFT; SELF := []));
  iesp.ECL2ESP.SetInputReportBy (report_by);

  // set options
  iesp.ECL2ESP.SetInputBaseRequest (first_row);
  iesp.ECL2ESP.Marshall.Mac_Set (first_row.Options);

  // set main search criteria:
  iesp.ECL2ESP.SetInputSearchOptions (PROJECT(first_row.options,TRANSFORM(iesp.share.t_BaseSearchOptionEx,SELF := LEFT)));

  // store search options not handled by iesp.ECL2ESP
  search_options := GLOBAL (first_row.Options);
  #STORED ('IncludeOffenses', search_options.IncludeOffenses);
  // NOTE: Input options fields for ReturnHashes and srch_hashvals only come in as SOAP
  // fields, not as part of the OffenderSearchRequest XML input dataset.
  // This is because that is how things are currently handled for other products with Alerts
  // and in discussions with Tony Fishbeck & Yanrui Ma on 05/04/09 it was decided to leave
  // them as SOAP input fields only.
  // Those SOAP fields are handled in Alerts.inputs

  //soap call for remote DIDs
  //------------------------------------------------------------------------------------
  // the only purpose of this macro is to produce a single DID, so in case DID is provided in the input
  // -- either in #stored or in ESDL -- this MACRO will necessarily bounced this DID back.
  FCRA.MAC_GetPickListRecords (ds_in, res_esdl);
  //------------------------------------------------------------------------------------

  rdid := res_esdl[1].Records[1].UniqueId;

  input_params := AutoStandardI.GlobalModule(isFCRA);
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(input_params);

  tempmod := MODULE(PROJECT(input_params,SexOffender_Services.IParam.search,OPT));
    doxie.compliance.MAC_CopyModAccessValues(mod_access);
    // Store soap/xml input fields unique to SexOffender SearchService into unique
    // attribute names to be passed into SexOffender_Services.Search_Records, etc.
    EXPORT BOOLEAN include_regaddrs := FALSE : STORED('IncludeRegisteredAddresses');
    EXPORT BOOLEAN include_unregaddrs := FALSE : STORED('IncludeUnregisteredAddresses');
    EXPORT BOOLEAN include_histaddrs := FALSE : STORED('IncludeHistoricalAddresses');
    EXPORT BOOLEAN include_assocaddrs := FALSE : STORED('IncludeAssociatedAddresses');
    EXPORT BOOLEAN include_offenses := FALSE : STORED('IncludeOffenses');
    EXPORT BOOLEAN include_bestaddress := FALSE : STORED('IncludeBestAddress');
    EXPORT BOOLEAN include_wealsofound := FALSE : STORED('IncludeWeAlsoFound');
    EXPORT STRING offenseCategory := '' : STORED('OffenseCategory');
    STRING smt := '' : STORED('ScarsMarksTattoos');
    EXPORT STRING SmtWords := STD.Str.ToUpperCase(smt);
    EXPORT STRING14 did := rdid;
    EXPORT BOOLEAN zip_only_search := FALSE;
    EXPORT INTEGER8 FFDOptionsMask := FFD.FFDMask.Get(first_row.options.FFDOptionsMask);
    EXPORT INTEGER FCRAPurpose := FCRA.FCRAPurpose.Get(first_row.options.FCRAPurpose);
  END;
  tempresults := SexOffender_Services.Search_Records.fcra_val(tempmod);

  input_consumer := FFD.MAC.PrepareConsumerRecord(rdid, TRUE, search_by);

  // Determine center point of a radius search (when applicable)
  lv := AutoStandardI.InterfaceTranslator.location_value.val(PROJECT(tempmod,AutoStandardI.InterfaceTranslator.location_value.params));
  sv := AutoStandardI.InterfaceTranslator.SearchAroundAddress_value.val(PROJECT(tempmod,AutoStandardI.InterfaceTranslator.SearchAroundAddress_value.params));
  dsSearchAround := IF(
    sv,
    DATASET([{lv.latitude, lv.longitude, lv.geo_match, Address.geo_desc(lv.geo_match)}], iesp.share.t_GeoLocationMatch),
    DATASET([], iesp.share.t_GeoLocationMatch)
  );

  // Convert to output layout, with pagination
  iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tempresults.records, results, iesp.sexualoffender_fcra.t_FcraSexOffenderSearchResponse,
                                             Records, FALSE, RecordCount, SearchAroundInput, dsSearchAround);

  FFD.MAC.AppendConsumerAlertsAndStatements(results, out_results, tempresults.Statements, tempresults.ConsumerAlerts, input_consumer, iesp.sexualoffender_fcra.t_FcraSexOffenderSearchResponse);

  OUTPUT(out_results,NAMED('Results'));

ENDMACRO;
