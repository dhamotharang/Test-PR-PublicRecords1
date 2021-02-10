// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
IMPORT Alerts, AutoStandardI, iesp, ut;

EXPORT SearchService := MACRO
  #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
  // Get XML input
  rec_in := iesp.sexualoffender.t_OffenderSearchRequest;
  ds_in := DATASET ([], rec_in) : STORED ('OffenderSearchRequest', FEW);
  first_row := ds_in[1] : INDEPENDENT;
  // set main search criteria:
  search_by := GLOBAL (first_row.SearchBy);

  // This will set Name, Address, SSN, DID and DOB
  // NOTE: Even though the ECL2ESP function used below is named SetInputReportBy,
  // it can also be used to set certain search_by fields.
  report_by := ROW (search_by, TRANSFORM (iesp.bpsreport.t_BpsReportBy, SELF := LEFT; SELF := []));
  iesp.ECL2ESP.SetInputReportBy (report_by);

  // store search_by field not handled by iesp.ECL2ESP
  #STORED ('ZipRadius', search_by.Radius);
  #STORED ('Latitude', search_by.Location.Latitude);
  #STORED ('Longitude', search_by.Location.Longitude);
  #STORED ('OffenseCategory', search_by.OffenseCategory);
  #STORED ('ScarsMarksTattoos', search_by.ScarsMarksTattoos);
  #STORED ('AgeLow', search_by.AgeRange.low);
  #STORED ('AgeHigh', search_by.AgeRange.high);
  // NOTE: AgeRange is in the iesp.sexualoffender t_OffenderSearchBy record structure and
  // was on the old moxie wsonline search form, but even though it was on the moxie search
  // form, it did not appear to work. Also it is not on the Accurint.com Sex Offender
  // search form, so it was not included here.

  // set User, Base and generic search options
  iesp.ECL2ESP.SetInputBaseRequest (first_row);
  iesp.ECL2ESP.Marshall.Mac_Set (first_row.Options);
  iesp.ECL2ESP.SetInputSearchOptions (PROJECT(first_row.options,TRANSFORM(iesp.share.t_BaseSearchOptionEx,SELF := LEFT)));


  // store search options not handled by iesp.ECL2ESP
  search_options := GLOBAL (first_row.Options);
  #STORED ('IncludeRegisteredAddresses', search_options.IncludeRegisteredAddresses);
  #STORED ('IncludeUnregisteredAddresses', search_options.IncludeUnregisteredAddresses);
  #STORED ('IncludeHistoricalAddresses', search_options.IncludeHistoricalAddresses);
  #STORED ('IncludeAssociatedAddresses', search_options.IncludeAssociatedAddresses);
  #STORED ('IncludeOffenses', search_options.IncludeOffenses);
  #STORED ('IncludeBestAddress', search_options.IncludeBestAddress);
  #STORED ('IncludeWeAlsoFound', search_options.IncludeWeAlsoFound);
  #STORED ('SearchAroundAddress', search_options.SearchAroundAddress);
  #STORED ('FilterRecsByAltAddresses', search_options.FilterRecsByAltAddresses);

  // NOTE: Input options fields for ReturnHashes and srch_hashvals only come in as SOAP
  // fields, not as part of the OffenderSearchRequest XML input dataset.
  // This is because that is how things are currently handled for other products with Alerts
  // and in discussions with Tony Fishbeck & Yanrui Ma on 05/04/09 it was decided to leave
  // them as SOAP input fields only.
  // Those SOAP fields are handled in Alerts.inputs

  input_params := AutoStandardI.GlobalModule();
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(input_params);
  tempmod := MODULE(PROJECT(input_params,SexOffender_Services.IParam.search,OPT))
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
    EXPORT BOOLEAN zip_only_search := SexOffender_Services.Functions.is_zip_only_search ();
    EXPORT BOOLEAN filterRecsByAltAddr := FALSE : STORED('FilterRecsByAltAddresses');
  END;

  tempresults := SexOffender_Services.Search_Records.val(tempmod);

  // Determine center point of a radius search (when applicable)
  lv := AutoStandardI.InterfaceTranslator.location_value.val(PROJECT(tempmod,AutoStandardI.InterfaceTranslator.location_value.params));
  sv := AutoStandardI.InterfaceTranslator.SearchAroundAddress_value.val(PROJECT(tempmod,AutoStandardI.InterfaceTranslator.SearchAroundAddress_value.params));
  dsSearchAround := IF(
    sv,
    DATASET([{lv.latitude, lv.longitude, lv.geo_match, ut.geo_desc(lv.geo_match)}], iesp.share.t_GeoLocationMatch),
    DATASET([], iesp.share.t_GeoLocationMatch)
  );

  // Convert to output layout, with pagination
  iesp.ECL2ESP.Marshall.MAC_Marshall_Results(
    tempresults, results, iesp.sexualoffender.t_OffenderSearchResponse,
    Records, FALSE, RecordCount, SearchAroundInput, dsSearchAround
  );

  // This one is not for debugging.
  OUTPUT(results,NAMED('Results'));

ENDMACRO;
