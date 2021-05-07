// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
IMPORT iesp, AutoStandardI;

EXPORT SearchService := MACRO

  // Get XML input
  rec_in := iesp.officialrecord.t_OfficialRecSearchRequest;
  ds_in := DATASET ([], rec_in) : STORED ('OfficialRecSearchRequest', FEW);
  first_row := ds_in[1] : INDEPENDENT;

  //set User info and RecordCount & StartingRecord options
  iesp.ECL2ESP.SetInputBaseRequest (first_row);
  iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);

  //set main search criteria:
  search_by := GLOBAL (first_row.SearchBy);
  iesp.ECL2ESP.SetInputName (search_by.Name);

  #STORED ('CompanyName', search_by.CompanyName);

  //Store XML input state value into global "State" field for autokey fetches to use.
  //Normally this would be set by iesp.ECL2ESP.SetInputAddress, but state is the only
  // address field used, so it's done here.
  STRING2 State := GLOBAL (search_by.State);
  #STORED ('State', search_by.State);

  // Store XML input county value first into soap attribute name and then save soap
  // attribute in tempmod below for autokey fetches to use.
  // NOTE: Used a separate SearchByCounty attribute name instead of "county" so it did
  // not conflict with the global "county" attribute set in AutoStandardI.GlobalModule.
  #STORED ('SearchByCounty', search_by.County);

  //Store FilingDate input fields whihc are used for filtering.
  #STORED ('FilingStartDateYear', search_by.FilingDateRange.StartDate.Year);
  #STORED ('FilingStartDateMonth', search_by.FilingDateRange.StartDate.Month);
  #STORED ('FilingStartDateDay', search_by.FilingDateRange.StartDate.Day);
  #STORED ('FilingEndDateYear', search_by.FilingDateRange.EndDate.Year);
  #STORED ('FilingEndDateMonth', search_by.FilingDateRange.EndDate.Month);
  #STORED ('FilingEndDateDay', search_by.FilingDateRange.EndDate.Day);

  // set other search options
  iesp.ECL2ESP.SetInputSearchOptions (first_row.options);

  input_params := AutoStandardI.GlobalModule();
  tempmod := MODULE(PROJECT(input_params,OfficialRecords_Services.Search_Records.params,OPT));
     // Store SearchByCounty from xml or soap input into global "CITY" field for
    // autokey fetches to use.
    // NOTE: citystname autokey files were built with the county value from the data files
    // stored in the city field. So the input search county field must alos be stored as
    // "city" for autofetches to work.
    // See official_records.File_Autokey_Party & official_records.Proc_Build_Autokey for
    // more information.
    EXPORT STRING25 city := '' : STORED('SearchByCounty');

    // Store input fields unique to Official Records into attribute names
    // to be passed into OfficialRecords_Services.Search_Records
    EXPORT INTEGER2 FilingStartDateYear := 0 : STORED('FilingStartDateYear');
    EXPORT INTEGER2 FilingStartDateMonth := 0 : STORED('FilingStartDateMonth');
    EXPORT INTEGER2 FilingStartDateDay := 0 : STORED('FilingStartDateDay');
    EXPORT INTEGER2 FilingEndDateYear := 0 : STORED('FilingEndDateYear');
    EXPORT INTEGER2 FilingEndDateMonth := 0 : STORED('FilingEndDateMonth');
    EXPORT INTEGER2 FilingEndDateDay := 0 : STORED('FilingEndDateDay');
    EXPORT STRING32 ApplicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(PROJECT(input_params,AutoStandardI.InterfaceTranslator.application_type_val.params));
  END;

  tempresults := OfficialRecords_Services.Search_Records.val(tempmod);

  iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tempresults, results, iesp.officialrecord.t_OfficialRecSearchResponse, Records, FALSE);

  // Uncomment line below for debugging
  //output(tempresults,named('ss_tempresults'));
  OUTPUT(results,NAMED('Results'));

ENDMACRO;
