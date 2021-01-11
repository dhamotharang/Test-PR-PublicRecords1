// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO-- Returns concealed weapon Search records.*/
IMPORT CCW_services, iesp, AutoStandardI;

EXPORT SearchService := MACRO

  #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);

  rec_in := iesp.concealedWeapon.t_WeaponSearchRequest;
  ds_in := DATASET ([], rec_in) : STORED ('WeaponSearchRequest', FEW);
  first_row := ds_in[1] : INDEPENDENT;
  //set options

  iesp.ECL2ESP.SetInputBaseRequest (first_row);
  iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);

  //set main search criteria:
  search_by := GLOBAL (first_row.SearchBy);
  iesp.ECL2ESP.SetInputSearchOptions (first_row.options);
  iesp.ECL2ESP.SetInputReportBy(ROW(first_row.searchby,TRANSFORM(iesp.bpsreport.t_BpsReportBy,SELF:=LEFT,SELF:=[])));

  input_params := AutoStandardI.GlobalModule();
  tempmod := MODULE(PROJECT(input_params,CCW_services.SearchService_Records.params,OPT))
    EXPORT STRING32 ApplicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(PROJECT(input_params,AutoStandardI.InterfaceTranslator.application_type_val.params));
    EXPORT STRING5 IndustryClass := AutoStandardI.InterfaceTranslator.industry_class_value.val (PROJECT(input_params,AutoStandardI.InterfaceTranslator.industry_class_value.params));
  END;

  tmpresults := CCW_services.SearchService_Records.search(tempmod);
  iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tmpresults.Records, results, iesp.concealedweapon.t_WeaponSearchResponse);
  OUTPUT(results, NAMED('Results'));

ENDMACRO;
