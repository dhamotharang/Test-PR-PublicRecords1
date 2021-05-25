// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO-- Search for Property Records via simple keys and autokeys. It also searches
  the Forclosures file and/or the Notice of Default file. (ESP-compliant output)
*/
import AutoheaderV2, iesp, LN_PropertyV2_Services, doxie, Alerts, Text_Search, AutoStandardI, Foreclosure_Services;

export SearchService() := macro
 #CONSTANT ('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
   INTEGER Max_Results := iesp.constants.MAX_COUNT_SEARCH_RESPONSE_RECORDS;
  #STORED('ReturnCount',Max_Results); // For iesp.ECL2ESP.Marshall

  // 1. Property Search

  // compute results
  #CONSTANT('usePropMarshall', true);
  #CONSTANT('DisplayMatchedParty', true);

  //This boolean is used in Property Report and Search Services to show Deeds, Assessments and A&R data when LooupType is blank
  boolean includeBlackKnight :=  Ln_PropertyV2_Services.consts.LOOKUP_TYPE.IsIncludeAllDeedTypes(Ln_PropertyV2_Services.input.lookupVal);
                                

  raw := project(LN_PropertyV2_Services.SearchService_records(,,,,includeBlackKnight).Records,
                   LN_PropertyV2_Services.layouts.combined.narrow);

  // standard record counts & limits
  doxie.MAC_Header_Field_Declare()

  Alerts.mac_ProcessAlerts(raw,LN_PropertyV2_services.alert,raw_final);

  // create External Key field
  Text_Search.MAC_Append_ExternalKey(raw_final, raw_final2, l.ln_fares_id);

  // doxie.MAC_Marshall_Results(raw_final2,cooked)
  LN_PropertyV2_Services.Marshall.MAC_Marshall_Results(raw_final2, cooked);


  // 2. Foreclosure and/or Notice of Default search
  input_params := AutoStandardI.GlobalModule();
  tempmod := module(project(input_params,Foreclosure_Services.Records.params,opt))
    export string70 foreclosure_id  := '';
  end;
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(input_params);

  // Unlike in Foreclosure_Services.SearchService, including Forclosures must be set to FALSE by default.
  boolean IncludeForeclosures      := false : STORED ('IncludeForeclosures');
  boolean IncludeNoticesOfDefault  := false : STORED ('IncludeNoticesOfDefault');
   boolean IncludeVendorSourceB  := false : STORED ('IncludeVendorSourceB');
  // Foreclosure_Services.Records will return either Foeclosures or Notices of Default, but not both.
  // So, two calls to the same function, each with a different parameter value.
  for := if( IncludeForeclosures, Foreclosure_Services.Records.val(tempmod, mod_access, false, IncludeVendorSourceB));
  nod := if( IncludeNoticesOfDefault, Foreclosure_Services.Records.val(tempmod, mod_access, true, IncludeVendorSourceB));
  tmp := sort( for + nod , if(AlsoFound,1,0), _penalty, -recordingdate, record );

  iesp.ECL2ESP.Marshall.MAC_Marshall_Results (tmp, foreclosureResults, iesp.foreclosure.t_ForeclosureSearchResponse);

  // display Property results
  output(cooked, named('Results'));


  // display Foreclosure / Notice of Default results
  if( IncludeForeclosures OR IncludeNoticesOfDefault, output(foreclosureResults, named('ForeclosureResults')));

endmacro;
