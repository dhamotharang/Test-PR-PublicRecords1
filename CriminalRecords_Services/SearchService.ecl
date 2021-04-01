// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
IMPORT iesp, AutoStandardI, std;

EXPORT SearchService := MACRO

 #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
 #ONWARNING (4207, ignore);
  rec_in := iesp.criminal.t_CrimSearchRequest;
  ds_in := DATASET([], rec_in) : STORED('CrimSearchRequest', few);
  first_row := ds_in[1] : INDEPENDENT;

  iesp.ECL2ESP.SetInputBaseRequest(first_row);
  iesp.ECL2ESP.Marshall.Mac_Set(first_row.options);

  //set main search criteria:
  search_by := GLOBAL(first_row.SearchBy);
  iesp.ECL2ESP.SetInputSearchOptions(first_row.options);
  iesp.ECL2ESP.SetInputReportBy(ROW(first_row.searchby,TRANSFORM(iesp.bpsreport.t_BpsReportBy,SELF:=LEFT,SELF:=[])));

  #STORED('County', search_by.FilingJurisdiction); // currently web is passing same value to this
                                                   // as Search_by.County which is set in
                                                   // SetInputAddress(search_by.Address) above

  #STORED('DOCNumber', search_by.DOCNumber);
  #STORED('FilingJurisdictionState', search_by.FilingJurisdictionState);
  #STORED('CaseNumber', search_by.CaseNumber);

  input_params := AutoStandardI.GlobalModule();
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(input_params);
  tempmod := MODULE(PROJECT(input_params,CriminalRecords_Services.IParam.search,OPT))
    doxie.compliance.MAC_CopyModAccessValues(mod_access);
    EXPORT STRING25 doc_number := '' : STORED('DOCNumber');
    EXPORT STRING35 case_number := '' : STORED('CaseNumber');
    EXPORT STRING60 offender_key := '' : STORED('OffenderKey');
    EXPORT STRING30 county_in := '' : STORED('County');
    EXPORT STRING30 County := '';
    EXPORT STRING2 FilingJurisdictionState := '' :STORED('FilingJurisdictionState');
    EXPORT UNSIGNED2 penalty_threshold := AutoStandardI.InterfaceTranslator.penalt_threshold_value.val(PROJECT (input_params, AutoStandardI.InterfaceTranslator.penalt_threshold_value.params));
    EXPORT STRING8 CaseFilingStartDate := iesp.ECL2ESP.t_DateToString8(search_by.CaseFilingDateRange.StartDate);
    EXPORT STRING8 CaseFilingEndDate := iesp.ECL2ESP.t_DateToString8(search_by.CaseFilingDateRange.EndDate);
    EXPORT UNSIGNED OffenseCategories := CriminalRecords_Services.IParam.getOffenseCategories(first_row.options);
    EXPORT STRING OffenseType := first_row.options.OffenseType;
    EXPORT BOOLEAN ConvictionsOnly := first_row.options.ConvictionsOnly;
  END;

  is_valid_dateinput := (tempmod.CaseFilingStartDate = '' OR STD.DATE.IsValidDate((UNSIGNED4)tempmod.CaseFilingStartDate))
                          AND (tempmod.CaseFilingEndDate = '' OR STD.DATE.IsValidDate((UNSIGNED4)tempmod.CaseFilingEndDate));

  IF(~is_valid_dateinput, FAIL('An ERROR occurred while running CriminalRecords_Services.SearchService: invalid input dates.') );

  tmp := CriminalRecords_Services.SearchService_Records.val(tempmod);

  tmp_max := CHOOSEN(tmp,iesp.constants.CRIM.MaxSearchRecords);

  iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tmp_max, results, iesp.criminal.t_CrimSearchResponse);
  OUTPUT(results, NAMED('Results'),ALL);


ENDMACRO;
