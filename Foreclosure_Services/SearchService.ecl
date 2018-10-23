/*--SOAP--
<message name="SearchService">
  <part name="ExcludeForeclosures"     type="xsd:boolean"/>
  <part name="IncludeNoticeOfDefaults" type="xsd:boolean"/>
  <separator/>

  <part name="ForeclosureId" type="xsd:string" description=" debug only; not exposed in ESP"/>
  <part name="DID" type="xsd:string" />
  <part name="BDID" type="xsd:string" />
  <separator/>

  <!-- SEARCH FIELDS --> 
  <part name="CompanyName" type = "xsd:string"/>
  <part name="SSN" type="xsd:string"/>
  <part name="FirstName" type="xsd:string"/>
  <part name="LastName" type="xsd:string"/>
  <part name="MiddleName" type="xsd:string"/>
  <part name="Addr" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
  <part name="State" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>

  <separator/>
  <part name="UnparsedFullName" type="xsd:string"/>  
  <part name="AllowNickNames" type="xsd:boolean"/>
  <part name="PhoneticMatch" type="xsd:boolean"/>

  <separator/>
  <part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
  <part name="DPPAPurpose" type="xsd:byte" default="1"/>
  <part name="GLBPurpose" type="xsd:byte" default="1"/> 
	<part name="DataRestrictionMask" type="xsd:string" default="0"/> 
	<part name="ApplicationType"     type="xsd:string"/>
  <part name="NoDeepDive" type="xsd:boolean" default="1"/> 
  <part name="PenaltThreshold" type="xsd:unsignedInt" default="100"/>
  <part name="StrictMatch" type="xsd:boolean"/>


  <part name="ForeclosureSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/
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
/*--USES-- ut.input_xslt */

IMPORT iesp, AutoStandardI, doxie;

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

  input_params := AutoStandardI.GlobalModule();
	tempmod := module(project(input_params,Foreclosure_Services.Records.params,opt))  
    export string70 foreclosure_id := '' : stored ('ForeclosureId');
		Export string32 applicationType	:= AutoStandardI.InterfaceTranslator.application_type_val.val(project(input_params,AutoStandardI.InterfaceTranslator.application_type_val.params));
  end;

  boolean ExcludeForeclosures := false : STORED ('ExcludeForeclosures');
  boolean IncludeNoticeOfDefaults := false : STORED ('IncludeNoticeOfDefaults');
  for := if(~ExcludeForeclosures,Foreclosure_Services.Records.val(tempmod,false));
  nod := if(IncludeNoticeOfDefaults,Foreclosure_Services.Records.val(tempmod,true));
  tmp := sort(for+nod,if(AlsoFound,1,0),_penalty,-recordingdate,record);

  iesp.ECL2ESP.Marshall.MAC_Marshall_Results (tmp, results, iesp.foreclosure.t_ForeclosureSearchResponse);
  output (results, named('Results'));
ENDMACRO;
// SearchService ();

/*
<!-- ForeclosureSearchRequest -->
<dataset>
  <row>
    <remotelocations>
      <value></value>
    </remotelocations>
    <servicelocations>
      <locationid></locationid>
      <servicename></servicename>
      <parameters>
        <name></name>
        <value></value>
      </parameters>
    </servicelocations>
    <user>
      <referencecode></referencecode>
      <billingcode></billingcode>
      <queryid></queryid>
      <companyid></companyid>
      <glbpurpose></glbpurpose>
      <dlpurpose></dlpurpose>
      <loginhistoryid></loginhistoryid>
      <debitunits></debitunits>
      <ip></ip>
      <industryclass></industryclass>
      <resultformat></resultformat>
      <logasfunction></logasfunction>
      <ssnmask></ssnmask>
      <dobmask></dobmask>
      <dlmask></dlmask>
      <datarestrictionmask></datarestrictionmask>
      <datapermissionmask></datapermissionmask>
      <ssnmaskingon></ssnmaskingon>
      <dlmaskingon></dlmaskingon>
      <enduser>
        <companyname></companyname>
        <streetaddress1></streetaddress1>
        <city></city>
        <state></state>
        <zip5></zip5>
      </enduser>
      <maxwaitseconds></maxwaitseconds>
      <relatedtransactionid></relatedtransactionid>
      <accountnumber></accountnumber>
    </user>
    <searchby>
      <name>
        <full></full>
        <first></first>
        <middle></middle>
        <last></last>
        <suffix></suffix>
        <prefix></prefix>
      </name>
      <address>
        <streetname></streetname>
        <streetnumber></streetnumber>
        <streetpredirection></streetpredirection>
        <streetpostdirection></streetpostdirection>
        <streetsuffix></streetsuffix>
        <unitdesignation></unitdesignation>
        <unitnumber></unitnumber>
        <streetaddress1></streetaddress1>
        <streetaddress2></streetaddress2>
        <state></state>
        <city></city>
        <zip5></zip5>
        <zip4></zip4>
        <county></county>
        <postalcode></postalcode>
        <statecityzip></statecityzip>
      </address>
      <ssn></ssn>
      <companyname></companyname>
    </searchby>
    <options>
      <blind></blind>
      <encrypt></encrypt>
      <strictmatch></strictmatch>
      <maxresults></maxresults>
      <usenicknames></usenicknames>
      <includealsofound></includealsofound>
      <usephonetics></usephonetics>
      <penaltythreshold></penaltythreshold>
      <returncount></returncount>
      <startingrecord></startingrecord>
      <ExcludeForeclosures></ExcludeForeclosures>
      <IncludeNoticeOfDefaults></IncludeNoticeOfDefaults>
    </options>
  </row>
</dataset>
*/
