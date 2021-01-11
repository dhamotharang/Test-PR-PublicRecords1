// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
import iesp, AutoStandardI, std;

export SearchService := MACRO

 #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
 #ONWARNING (4207, ignore);
  rec_in    := iesp.criminal.t_CrimSearchRequest;
  ds_in     := dataset([], rec_in) : STORED('CrimSearchRequest', few);
  first_row := ds_in[1] : INDEPENDENT;

  iesp.ECL2ESP.SetInputBaseRequest(first_row);
  iesp.ECL2ESP.Marshall.Mac_Set(first_row.options);

  //set main search criteria:
  search_by := global(first_row.SearchBy);
  iesp.ECL2ESP.SetInputSearchOptions(first_row.options);
  iesp.ECL2ESP.SetInputReportBy(row(first_row.searchby,transform(iesp.bpsreport.t_BpsReportBy,self:=left,self:=[])));

  #stored('County', search_by.FilingJurisdiction); // currently web is passing same value to this
                                                   // as Search_by.County which is set in
                                                   // SetInputAddress(search_by.Address) above

  #stored('DOCNumber', search_by.DOCNumber);
  #stored('FilingJurisdictionState', search_by.FilingJurisdictionState);
  #stored('CaseNumber', search_by.CaseNumber);

  input_params := AutoStandardI.GlobalModule();
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(input_params);
  tempmod := module(project(input_params,CriminalRecords_Services.IParam.search,opt))
    doxie.compliance.MAC_CopyModAccessValues(mod_access);
    export string25   doc_number   := '' : STORED('DOCNumber');
    export string35   case_number  := '' : STORED('CaseNumber');
    export string60   offender_key := '' : STORED('OffenderKey');
    export string30   county_in    := '' : STORED('County');
    export string30   County       := '';
    export string2    FilingJurisdictionState       := '' :STORED('FilingJurisdictionState');
    export unsigned2  penalty_threshold := AutoStandardI.InterfaceTranslator.penalt_threshold_value.val(project (input_params, AutoStandardI.InterfaceTranslator.penalt_threshold_value.params));
    export string8    CaseFilingStartDate  := iesp.ECL2ESP.t_DateToString8(search_by.CaseFilingDateRange.StartDate);
    export string8    CaseFilingEndDate    := iesp.ECL2ESP.t_DateToString8(search_by.CaseFilingDateRange.EndDate);
    export unsigned   OffenseCategories := CriminalRecords_Services.IParam.getOffenseCategories(first_row.options);
    export string     OffenseType := first_row.options.OffenseType;
    export boolean    ConvictionsOnly := first_row.options.ConvictionsOnly;
  end;

  is_valid_dateinput := (tempmod.CaseFilingStartDate = '' or STD.DATE.IsValidDate((UNSIGNED4)tempmod.CaseFilingStartDate))
                          and (tempmod.CaseFilingEndDate = '' or STD.DATE.IsValidDate((UNSIGNED4)tempmod.CaseFilingEndDate));

  IF(~is_valid_dateinput, FAIL('An error occurred while running CriminalRecords_Services.SearchService: invalid input dates.') );

  tmp := CriminalRecords_Services.SearchService_Records.val(tempmod);

  tmp_max := choosen(tmp,iesp.constants.CRIM.MaxSearchRecords);

  iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tmp_max, results, iesp.criminal.t_CrimSearchResponse);
  output(results, named('Results'),all);


endmacro;
