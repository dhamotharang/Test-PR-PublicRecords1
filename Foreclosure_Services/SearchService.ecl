// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO-- This Service searches the Forclosures File. (ESP-compliant output)<br/>
  Optionally searches the Notice of Defaults File:
<table border="1">
<tr><th>ExcludeForeclosures</th><th>IncludeNoticeOfDefaults</th><th>Record Types</th></tr>
<tr><td>false</td><td>false</td><td>Foreclosures Only</td></tr>
<tr><td>false</td><td>true</td><td>Foreclosures and Notice of Defaults</td></tr>
<tr><td>true</td><td>true</td><td>Notice of Defaults Only</td></tr>
<tr><td>true</td><td>false</td><td>zip, zilch, zero, zippo, zot, ...</td></tr>
</table>
*/
IMPORT iesp, AutoStandardI;

EXPORT SearchService := MACRO
  #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
  ds_in := DATASET ([], iesp.foreclosure.t_ForeclosureSearchRequest) : STORED ('ForeclosureSearchRequest', FEW);
  first_row := ds_in[1] : independent;

  //set options
  iesp.ECL2ESP.SetInputBaseRequest (first_row);
  iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);

  //set main search criteria:
  search_by := global (first_row.SearchBy);
  iesp.ECL2ESP.SetInputReportBy (project (search_by, transform (iesp.bpsreport.t_BpsReportBy, Self := Left, Self := [])));
  iesp.ECL2ESP.SetInputSearchOptions (first_row.options);


  //process input specific for this service:
  #stored ('CompanyName', search_by.CompanyName);
  #stored ('ExcludeForeclosures',first_row.options.ExcludeForeclosures);
  #stored ('IncludeNoticeOfDefaults',first_row.options.IncludeNoticeOfDefaults);
	 #stored ('ParcelNumber',search_by.ParcelNumber);

  input_params := AutoStandardI.GlobalModule();
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(input_params);
	tempmod := module(project(input_params,Foreclosure_Services.Records.params,opt))
    export string70 foreclosure_id := '' : stored ('ForeclosureId');
		  export string45 parcel_num := '' : stored ('ParcelNumber');
  end;

  boolean ExcludeForeclosures := false : STORED ('ExcludeForeclosures');
  boolean IncludeNoticeOfDefaults := false : STORED ('IncludeNoticeOfDefaults');
	 boolean includeVendorSourceB := first_row.options.IncludeVendorSourceB;

	 for := if(~ExcludeForeclosures,Foreclosure_Services.Records.val(tempmod,mod_access,false, includeVendorSourceB));
  nod := if(IncludeNoticeOfDefaults,Foreclosure_Services.Records.val(tempmod,mod_access,true, includeVendorSourceB));
  tmp := sort(for+nod,if(AlsoFound,1,0),_penalty,-recordingdate,record);

  iesp.ECL2ESP.Marshall.MAC_Marshall_Results (tmp, results, iesp.foreclosure.t_ForeclosureSearchResponse);
  output (results, named('Results'));
ENDMACRO;
