// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================

EXPORT SearchService := MACRO

  IMPORT Doxie, EmailV2_Services, iesp;

  #WEBSERVICE(FIELDS(
    'EmailSearchV2Request',
    'gateways'
  ));

  // Input request
  in_req := DATASET([], iesp.emailsearchv2.t_EmailSearchV2Request) : STORED('EmailSearchV2Request');

  first_row := in_req[1] : INDEPENDENT;
  search_by := GLOBAL(first_row.SearchBy);
  search_options := GLOBAL(first_row.Options);

  iesp.ECL2ESP.SetInputBaseRequest(first_row);
  iesp.ECL2ESP.SetInputReportBy(ROW(search_by, TRANSFORM(iesp.bpsreport.t_BpsReportBy, SELF := LEFT, SELF := [])));
  iesp.ECL2ESP.SetInputSearchOptions (search_options);

  in_mod := EmailV2_Services.IParams.getSearchParams(search_options);

  isValidSearchType := EmailV2_Services.Constants.SearchType.isValidSearchType(in_mod.SearchType);
  isAllowedValidation := EmailV2_Services.Constants.isAllowedValidation(search_options.SearchTier, search_options.EmailValidationType);
  isEmailageRestricted := EmailV2_Services.Constants.isEmailageValidation(search_options.EmailValidationType) AND in_mod.isDirectMarketing();

  IF(isEmailageRestricted OR ~isValidSearchType OR (in_mod.CheckEmailDeliverable AND ~isAllowedValidation), FAIL(303, doxie.ErrorCodes(303)));

  rpt := EmailV2_Services.Search_Records(search_by, in_mod);

  OUTPUT(rpt.Response, named('Results'));
  OUTPUT(rpt.Royalties, named('RoyaltySet'));

ENDMACRO;
