// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
IMPORT iesp, AutoStandardI, ut;

EXPORT SearchService := MACRO

  //read ESP input values into ECL "standard" names

  rec_in := iesp.civilCourt.t_CivilCourtSearchRequest;
  ds_in := DATASET ([], rec_in) : STORED ('CivilCourtSearchRequest', FEW);
  first_row := ds_in[1] : INDEPENDENT;

  //set options
  iesp.ECL2ESP.SetInputBaseRequest (first_row);
  iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);

  //set main search criteria:
  search_by := GLOBAL (first_row.SearchBy);

  iesp.ECL2ESP.SetInputName (search_by.Name);
  #STORED ('CompanyName', search_by.CompanyName);

  // to make it available from both SOAP and ESP requests (abbreviate state, if needed)
  STRING state_tmp := TRIM(search_by.State, LEFT, RIGHT);
  esp_in_state := IF (LENGTH(state_tmp) > 2,
    ut.st2Abbrev (STD.STR.ToUpperCase (state_tmp)), state_tmp);
  #STORED ('State', esp_in_state);

  STRING25 City := search_by.City;
  #STORED ('City', City);

  #STORED ('SearchByJurisdiction', search_by.Jurisdiction);

  iesp.ECL2ESP.SetInputSearchOptions (first_row.options);

  input_params := AutoStandardI.GlobalModule();
  tempmod := MODULE(PROJECT(input_params,CivilCourt_services.SearchService_Records.params,OPT))
    EXPORT STRING2 State_in := '' : STORED('State');
    STRING25 City_tmp_in := '' : STORED('City');
    EXPORT STRING25 City_in := STD.STR.ToUpperCase(City_tmp_in);
    EXPORT STRING60 jurisdiction_mixedCase := '' : STORED('SearchByJurisdiction');
    EXPORT STRING60 jurisdiction_in := STD.STR.ToUpperCase(jurisdiction_mixedCase);
  END;

  tmpresults := CivilCourt_services.SearchService_Records.val(tempmod);
  iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tmpresults, results, iesp.civilCourt.t_CivilCourtSearchResponse);
  OUTPUT(results, NAMED('Results'));
ENDMACRO;
