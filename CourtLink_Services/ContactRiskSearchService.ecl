EXPORT ContactRiskSearchService := MACRO

  IMPORT CourtLink_Services, doxie, iesp;

  rec_in := iesp.contactrisksearch.t_ContactRiskSearchRequest;
  ds_in := DATASET([], rec_in) : STORED('ContactRiskSearchRequest', few);
  first_row := ds_in[1] : INDEPENDENT;

  iesp.ECL2ESP.SetInputBaseRequest(first_row);

  search_by := GLOBAL(first_row.SearchBy);
  search_options := GLOBAL(first_row.Options);

  isNamePresent := search_by.Name.First <> '' OR search_by.Name.Middle <> '' OR search_by.Name.Last <> '';
  isLexIdPresent := search_by.UniqueId <> '';
  isInvalidInput := isNamePresent AND isLexIdPresent;

  search_params := CourtLink_Services.IParams.GetContactRiskSearchParams(search_options);
  results := CourtLink_Services.ContactRiskSearchRecords(search_by, search_params);

  IF(isInvalidInput, FAIL(303, doxie.ErrorCodes(303)), OUTPUT(results, NAMED('Results')));

ENDMACRO;
