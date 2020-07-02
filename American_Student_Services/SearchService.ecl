/*--SOAP--
<message name="SearchService">
  
  <!-- COMPLIANCE SETTINGS -->
  <part name="GLBPurpose" type="xsd:byte" default="1"/>
  <part name="DPPAPurpose" type="xsd:byte" default="1"/>
  <part name="ApplicationType" type="xsd:string"/>
  
  <separator />
  <!-- Internal testing search field -->
  <part name="did" type="string" />
  <part name="DatasourceExclusion" type="unsignedint" default="0" description="[debug only, not exposed in ESP] 0-No Exclusion, 1-No Alloy, 2-No ASL"/>

  <separator />
  <part name="StudentSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />

</message>
*/

import iesp, AutoStandardI, American_Student_Services;

export SearchService := MACRO

 #CONSTANT ('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);

  WSInput.MAC_American_Student_SearchService();
  
  ds_in := DATASET ([], iesp.student.t_StudentSearchRequest) : STORED('StudentSearchRequest', FEW);
  first_row := ds_in[1] : INDEPENDENT;
  // set legacy #stored input parameters
  iesp.ECL2ESP.SetInputBaseRequest(first_row);
  iesp.ECL2ESP.SetInputReportBy (ROW (first_row.searchBy, transform (iesp.bpsreport.t_BpsReportBy, Self := Left, Self := [])));
  iesp.ECL2ESP.SetInputSearchOptions(first_row.options);
  iesp.ECL2ESP.Marshall.Mac_Set(first_row.options);
  // this option is for testing only.
  ds_exlusion := 0 : STORED('DatasourceExclusion');

  input_params := AutoStandardI.GlobalModule();
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(input_params);
  tmpMod:= MODULE(mod_access, input_params)
    EXPORT string DataPermissionMask := mod_access.DataPermissionMask; //conflicting definition;
    EXPORT string DataRestrictionMask := mod_access.DataRestrictionMask; //conflicting definition;

    EXPORT unsigned2 penalty_threshold := AutoStandardI.InterfaceTranslator.penalt_threshold_value.val(project(input_params,AutoStandardI.InterfaceTranslator.penalt_threshold_value.params)); ;
    EXPORT STRING14 didValue := AutoStandardI.InterfaceTranslator.did_value.val(project(input_params,AutoStandardI.InterfaceTranslator.did_value.params));
    EXPORT BOOLEAN isDeepDive := not AutoStandardI.InterfaceTranslator.nodeepdive.val(project(input_params, AutoStandardI.InterfaceTranslator.nodeepdive.params));
    EXPORT string11 ssn := AutoStandardI.InterfaceTranslator.ssn_value.val(project(input_params, AutoStandardI.InterfaceTranslator.ssn_value.params));
    EXPORT UNSIGNED8 dob := AutoStandardI.InterfaceTranslator.dob_val.val(project(input_params, AutoStandardI.InterfaceTranslator.dob_val.params));
    EXPORT STRING32 ApplicationType := mod_access.application_type;
  END;
  
  mod_search := PROJECT (tmpMod, American_Student_Services.IParam.searchParams, OPT);
  recs := American_Student_Services.SearchRecords(mod_search, ds_exlusion);
  
  iesp_output := American_Student_Services.Functions.xform_iesp_output(recs);
  
  iesp.ECL2ESP.Marshall.MAC_Marshall_Results(iesp_output, results, iesp.student.t_StudentSearchResponse, Records, false,,,,iesp.Constants.MaxCountASLSearch);
  output(results, named('Results'));
  
ENDMACRO;
// American_Student_Services.SearchService()
