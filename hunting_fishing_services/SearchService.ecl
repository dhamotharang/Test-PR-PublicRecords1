/*--SOAP--
<message name="SearchService">

  <!-- COMPLIANCE SETTINGS -->
  <part name="GLBPurpose"       type="xsd:byte"/>
  <part name="DPPAPurpose"      type="xsd:byte"/>
  <part name="ApplicationType"   type="xsd:string"/>
  <part name="SSNMask"           type="xsd:string"/>
  <part name="MaxWaitSeconds"   type="xsd:integer"/>
  
  <!-- SEARCH FIELDS -->
  <part name="SSN"               type="xsd:string"/>

  <part name="UnParsedFullName" type="xsd:string"/>
  <part name="FirstName"        type="xsd:string"/>
  <part name="MiddleName"       type="xsd:string"/>
  <part name="LastName"         type="xsd:string"/>
  <part name="NameSuffix"        type="xsd:string"/>

  <part name="allownicknames"   type="xsd:boolean"/>
  <part name="PhoneticMatch"    type="xsd:boolean"/>

  <part name="prim_range"       type="xsd:string"/>
  <part name="predir"           type="xsd:string"/>
  <part name="prim_name"        type="xsd:string"/>
  <part name="suffix"           type="xsd:string"/>
  <part name="postdir"          type="xsd:string"/>
  <part name="sec_range"        type="xsd:string"/>
  <part name="Addr"             type="xsd:string"/>
  <part name="City"             type="xsd:string"/>
  <part name="State"            type="xsd:string"/>
  <part name="Zip"              type="xsd:string"/>
  
  <!-- New fields/options -->
  <part name="did"              type="xsd:string"/>
  <part name="NoDeepDive" type="xsd:boolean" default="true"/>
  <part name="PenaltThreshold"    type="xsd:unsignedInt" default="100"/>
  
  <!-- Existing options -->
  <part name="ReturnCount"      type="xsd:unsignedInt"/>
  <part name="StartingRecord"    type="xsd:unsignedInt"/>
  <part name="StrictMatch" type="xsd:boolean"/>
  
  <part name="HuntFishSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />

</message>
*/
/*--INFO-- Search and return Hunting & Fishing License information.*/

import iesp, AutoStandardI;

export SearchService := macro

  #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
    
  // Get XML input 
  rec_in := iesp.huntingfishing.t_HuntFishSearchRequest;
  ds_in := DATASET ([], rec_in) : STORED ('HuntFishSearchRequest', FEW);
  first_row := ds_in[1] : independent;
    
  //set options
  iesp.ECL2ESP.SetInputBaseRequest (first_row);
  iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);

  //set main search criteria:
  search_by := global (first_row.SearchBy);
  #stored ('SSN', search_by.SSN);
  iesp.ECL2ESP.SetInputName (search_by.Name);
  iesp.ECL2ESP.SetInputAddress (search_by.Address);
  iesp.ECL2ESP.SetInputSearchOptions (first_row.options);

  input_params := AutoStandardI.GlobalModule();
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(input_params);

  tempmod := module(project(input_params,hunting_fishing_services.Search_Records.params,opt));
    doxie.compliance.MAC_CopyModAccessValues(mod_access);   
  end;
  tempresults := hunting_fishing_services.Search_Records.val(tempmod);

  iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tempresults.Records, results, iesp.huntingfishing.t_HuntFishSearchResponse, Records, false);
                                                                     
  output(results,named('Results'));

endmacro;
// SearchService ();
