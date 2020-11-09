// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO--
    Search and Return Accident Information.<br/>
    Use EnableNationalAccidents [x] else Florida Accidents Only.
*/
IMPORT AutoStandardI,iesp, Accident_services, WSInput;

EXPORT SearchService := MACRO

 #CONSTANT ('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
 //The following macro defines the field sequence on WsECL page of query.
  WSInput.MAC_Accident_Services_SearchService();

  #CONSTANT ('PenaltThreshold',10);

  // Get XML input
  rec_in := iesp.accident.t_AccidentSearchRequest;
  ds_in := DATASET([],rec_in) : STORED('AccidentSearchRequest',FEW);
  first_row := ds_in[1] : INDEPENDENT;

  //set options
  iesp.ECL2ESP.SetInputBaseRequest(first_row);
  iesp.ECL2ESP.Marshall.Mac_Set(first_row.options);
  user := GLOBAL(first_row.User);

  //set main search criteria:
  search_by := GLOBAL(first_row.SearchBy);
  iesp.ECL2ESP.SetInputName (search_by.Name);
  #STORED('CompanyName',search_by.CompanyName);
  iesp.ECL2ESP.SetInputAddress (search_by.Address);
  //Store fields unique to Accidents into soap names to be used below
  #STORED('DID',search_by.UniqueId);
  #STORED('VIN',search_by.VIN);
  #STORED('AccidentNumber',search_by.AccidentNumber);
  #STORED('AccidentState',search_by.AccidentState);
  #STORED('AccidentDate',(UNSIGNED4)iesp.ECL2ESP.t_DateToString8(search_by.AccidentDate));
  #STORED('DriverLicenseNumber',search_by.DriverLicenseNumber);
  #STORED('TagNumber',search_by.TagNumber);

  options := GLOBAL(first_row.options);
  iesp.ECL2ESP.SetInputSearchOptions (options);
  #STORED('EnableNationalAccidents',options.EnableNationalAccidents);
  #STORED('EnableExtraAccidents',options.EnableExtraAccidents);

  #STORED('deepDive',options.IncludeAlsoFound);
  BOOLEAN deepDive := FALSE : STORED('deepDive');

  input_params := AutoStandardI.GlobalModule();
  tempmod := MODULE(PROJECT(input_params,Accident_Services.IParam.searchRecords,opt));
    EXPORT STRING40 Accident_Number := '' : STORED('AccidentNumber');
    EXPORT STRING2 Accident_State := '' : STORED('AccidentState');
    EXPORT UNSIGNED4 AccidentDate := 0 : STORED('AccidentDate');
    EXPORT STRING30 Vin := '' : STORED('VIN');
    EXPORT STRING24 DriverLicenseNumber := '' : STORED('DriverLicenseNumber');
    EXPORT STRING8 Tag_Number := '' : STORED('TagNumber');
    EXPORT BOOLEAN EnableNationalAccidents := FALSE : STORED('EnableNationalAccidents');
    EXPORT BOOLEAN EnableExtraAccidents := FALSE : STORED('EnableExtraAccidents');
    EXPORT BOOLEAN isDeepDive := deepDive : STORED('IncludeAlsoFound');
    Export string32 applicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(input_params,AutoStandardI.InterfaceTranslator.application_type_val.params));
  end;

  tempresults := Accident_services.Search_Records(tempmod);

  iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tempresults,Results,
    iesp.accident.t_AccidentSearchResponse,Records,FALSE);

  OUTPUT(Results,NAMED('Results'));

ENDMACRO;
