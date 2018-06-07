/*--SOAP--
<message name="SearchServiceFCRA">

  <!-- COMPLIANCE SETTINGS -->
  <part name="GLBPurpose"          type="xsd:byte" default="1"/>
  <part name="DPPAPurpose"         type="xsd:byte" default="1"/>
  <part name="FCRAPurpose"         type="xsd:string"/>
  <part name="SSNMask"               type="xsd:string"/>
  <part name="MaxWaitSeconds"      type="xsd:integer"/>
  <part name="ApplicationType"     type="xsd:string"/>
  
  <!-- SEARCH FIELDS -->
  <part name="SSN"                  type="xsd:string"/>
  <part name="DOB"                 type="xsd:string"/>
  
  <part name="UnParsedFullName"    type="xsd:string"/>
  <part name="FirstName"           type="xsd:string"/>
  <part name="MiddleName"          type="xsd:string"/>
  <part name="LastName"            type="xsd:string"/>
  <part name="NameSuffix"           type="xsd:string"/>
  
  <part name="prim_range"          type="xsd:string"/>
  <part name="predir"              type="xsd:string"/>
  <part name="prim_name"           type="xsd:string"/>
  <part name="suffix"              type="xsd:string"/>
  <part name="postdir"             type="xsd:string"/>
  <part name="sec_range"           type="xsd:string"/>
  <part name="Addr"                type="xsd:string"/>
  <part name="City"                type="xsd:string"/>
  <part name="State"               type="xsd:string"/>
  <part name="Zip"                 type="xsd:string"/>

  <!-- Roxie search service related options -->
  <part name="AllowNickNames"      type="xsd:boolean"/>
  <part name="PhoneticMatch"       type="xsd:boolean"/>
  <part name="DeepDive"            type="xsd:boolean"/>
  <part name="StrictMatch"         type="xsd:boolean"/>
  <part name="DID"                 type="xsd:string"/>

  <!-- Search request options -->
  <part name="ReturnCount"                  type="xsd:unsignedInt"/>
  <part name="StartingRecord"                type="xsd:unsignedInt"/>
  <part name="IncludeRegisteredAddresses"   type="xsd:boolean"/>
  <part name="IncludeUnRegisteredAddresses" type="xsd:boolean"/>
  <part name="IncludeHistoricalAddresses"   type="xsd:boolean"/>
  <part name="IncludeAssociatedAddresses"   type="xsd:boolean"/>
  <part name="IncludeOffenses"               type="xsd:boolean"/>
  <part name="IncludeBestAddress"           type="xsd:boolean"/>
  <part name="IncludeWeAlsoFound"           type="xsd:boolean"/>
  <part name="SearchAroundAddress"           type="xsd:boolean"/>
  
  <!-- Alert related options -->
  <part name="ReturnHashes" type="xsd:boolean"/>
  <part name="srch_hashvals" type="tns:XmlDataSet" cols="70" rows="3"/>    

  <!-- XML input search request -->
  <part name="FcraSexOffenderSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />

  <!-- Gateway for picklist -->
  <part name="gateways" type="tns:XmlDataSet" cols="70" rows="4"/>
</message>
*/
/*--INFO-- Search and return Sexual Offender information.*/

import AutoStandardI, iesp, ut, Address, FFD;

export SearchServiceFCRA := macro

  #onwarning(4207, ignore);
  boolean isFCRA := true;
  #constant('NoDeepDive', true);
  #constant('DidOnly', true); // for picklist
  
  // Get XML input 
  rec_in := iesp.sexualoffender_fcra.t_FcraSexOffenderSearchRequest;
  ds_in := DATASET ([], rec_in) : STORED ('FcraSexOffenderSearchRequest', FEW);
  first_row := ds_in[1] : independent;
  search_by := global (first_row.SearchBy);
  
  // This will set Name, Address, SSN, DID and DOB
  // NOTE: Even though the ECL2ESP function used below is named SetInputReportBy, 
  // it can also be used to set certain search_by fields.
  report_by := ROW (search_by, transform (iesp.bpsreport.t_BpsReportBy, Self := Left; Self := []));
  iesp.ECL2ESP.SetInputReportBy (report_by);

  // set options
  iesp.ECL2ESP.SetInputBaseRequest (first_row);
  iesp.ECL2ESP.Marshall.Mac_Set (first_row.Options);
  
  // set main search criteria:
  iesp.ECL2ESP.SetInputSearchOptions (Project(first_row.options,TRANSFORM(iesp.share.t_BaseSearchOptionEx,SELF := LEFT)));

  // store search options not handled by iesp.ECL2ESP
  search_options := global (first_row.Options);
  #stored ('IncludeOffenses', search_options.IncludeOffenses);
  // NOTE: Input options fields for ReturnHashes and srch_hashvals only come in as SOAP
  // fields, not as part of the OffenderSearchRequest XML input dataset.
  // This is because that is how things are currently handled for other products with Alerts
  // and in discussions with Tony Fishbeck & Yanrui Ma on 05/04/09 it was decided to leave
  // them as SOAP input fields only.
  // Those SOAP fields are handled in Alerts.inputs
  
  //soap call for remote DIDs
  //------------------------------------------------------------------------------------
  // the only purpose of this macro is to produce a single DID, so in case DID is provided in the input
  // -- either in #stored or in ESDL -- this MACRO will necessarily bounced this DID back.
  FCRA.MAC_GetPickListRecords (ds_in, res_esdl);
  //------------------------------------------------------------------------------------
  
  rdid := res_esdl[1].Records[1].UniqueId;
  
  input_params := AutoStandardI.GlobalModule(isFCRA);
  tempmod := module(project(input_params,SexOffender_Services.IParam.search,opt));
     // Store soap/xml input fields unique to SexOffender SearchService into unique 
     // attribute names to be passed into SexOffender_Services.Search_Records, etc.
     export boolean include_regaddrs     := false : stored('IncludeRegisteredAddresses');
     export boolean include_unregaddrs   := false : stored('IncludeUnregisteredAddresses');
     export boolean include_histaddrs    := false : stored('IncludeHistoricalAddresses');
     export boolean include_assocaddrs   := false : stored('IncludeAssociatedAddresses');
     export boolean include_offenses     := false : stored('IncludeOffenses');
     export boolean include_bestaddress := false : stored('IncludeBestAddress');
     export boolean include_wealsofound := false : stored('IncludeWeAlsoFound');
     export STRING  offenseCategory     := '' : stored('OffenseCategory');
     string smt                          := '' : stored('ScarsMarksTattoos');
     export STRING  SmtWords             := stringlib.stringtouppercase(smt);
     EXPORT string14 did                 := rdid;
     export string32 ApplicationType     := AutoStandardI.InterfaceTranslator.application_type_val.val(project(input_params,AutoStandardI.InterfaceTranslator.application_type_val.params));
     export boolean zip_only_search := false;   
     export integer8 FFDOptionsMask := FFD.FFDMask.Get(first_row.options.FFDOptionsMask);
     export integer FCRAPurpose := FCRA.FCRAPurpose.Get(first_row.options.FCRAPurpose);
  end;
  tempresults := SexOffender_Services.Search_Records.fcra_val(tempmod);

	input_consumer := FFD.MAC.PrepareConsumerRecord(rdid, true, search_by);

  // Determine center point of a radius search (when applicable)
  lv := AutoStandardI.InterfaceTranslator.location_value.val(project(tempmod,AutoStandardI.InterfaceTranslator.location_value.params));
  sv := AutoStandardI.InterfaceTranslator.SearchAroundAddress_value.val(project(tempmod,AutoStandardI.InterfaceTranslator.SearchAroundAddress_value.params));
  dsSearchAround := if(
    sv,
    dataset([{lv.latitude, lv.longitude, lv.geo_match, Address.geo_desc(lv.geo_match)}], iesp.share.t_GeoLocationMatch),
    dataset([], iesp.share.t_GeoLocationMatch)
  );
  
  // Convert to output layout, with pagination
  iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tempresults.records, results, iesp.sexualoffender_fcra.t_FcraSexOffenderSearchResponse,
                                             Records, false, RecordCount, SearchAroundInput, dsSearchAround);
  
  FFD.MAC.AppendConsumerAlertsAndStatements(results, out_results, tempresults.Statements, tempresults.ConsumerAlerts, input_consumer, iesp.sexualoffender_fcra.t_FcraSexOffenderSearchResponse);
                                             
  output(out_results,named('Results'));

endmacro;