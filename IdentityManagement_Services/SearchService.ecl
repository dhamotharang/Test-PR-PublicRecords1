/*--SOAP--
<message name="SearchService" wuTimeout="300000">
  <part name="DID"   	              type="xsd:string" required="1" />
  <part name="SSN" 				          type="xsd:string"/>
  <part name="DPPAPurpose" 					type="xsd:byte" default="1"/>
  <part name="GLBPurpose" 					type="xsd:byte" default="1"/>
	<part name="DataPermissionMask"   type="xsd:string"/>
	<part name="DataRestrictionMask"  type="xsd:string"/>
  <separator />
	<part name="ScoreThreshold"       type="xsd:unsignedInt"/>
	<part name="FuzzySecRange"        type="xsd:integer"/>
	<part name="ReturnCount"				 	type="xsd:unsignedInt"/>
	<part name="StartingRecord"			 	type="xsd:unsignedInt"/>

  <separator />
  <part name="IdentityManagementSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/
/*--INFO-- IDM Search(Identity Management) searches for perfect, precise or nice identities/DID to be used later by Quiz/IDM Report.
<pre>
&lt;IdentityManagementSearchRequest&gt;
 &lt;row&gt;
  &lt;User&gt;
   &lt;GLBPurpose&gt;&lt;/GLBPurpose&gt;
   &lt;DLPurpose&gt;&lt;/DLPurpose&gt;
   &lt;DataPermissionMask&gt;&lt;/DataPermissionMask&gt;
   &lt;DataRestrictionMask&gt;&lt;/DataRestrictionMask&gt;
   &lt;ApplicationType&gt;&lt;/ApplicationType&gt;
  &lt;/User&gt;
  &lt;Options&gt;
   &lt;UseNicknames&gt;&lt;/UseNicknames&gt;
   &lt;UsePhonetics&gt;&lt;/UsePhonetics&gt;
   &lt;AllowSSNTypos&gt;&lt;/AllowSSNTypos&gt;
   &lt;UseSALTLexIDFetch&gt;&lt;/UseSALTLexIDFetch&gt;
   &lt;ReturnCount&gt;0&lt;/ReturnCount&gt;
   &lt;StartingRecord&gt;0&lt;/StartingRecord&gt;
   &lt;ScoreThreshold&gt;15&lt;/ScoreThreshold&gt;
  &lt;/Options&gt;
  &lt;SearchBy&gt;
   &lt;Name&gt;
    &lt;Full&gt;&lt;/Full&gt;
    &lt;First&gt;&lt;/First&gt;
    &lt;Middle&gt;&lt;/Middle&gt;
    &lt;Last&gt;&lt;/Last&gt;
    &lt;Suffix&gt;&lt;/Suffix&gt;
    &lt;Prefix&gt;&lt;/Prefix&gt;
   &lt;/Name&gt;
   &lt;Address&gt;
    &lt;StreetAddress1&gt;&lt;/StreetAddress1&gt;
    &lt;StreetAddress2&gt;&lt;/StreetAddress2&gt;
    &lt;City&gt;&lt;/City&gt;
    &lt;State&gt;&lt;/State&gt;
    &lt;Zip5&gt;&lt;/Zip5&gt;
    &lt;Zip4&gt;&lt;/Zip4&gt;
   &lt;/Address&gt;
   &lt;UniqueId&gt;&lt;/UniqueId&gt;
   &lt;SSN&gt;&lt;/SSN&gt;
   &lt;DOB&gt;
    &lt;Year&gt;&lt;/Year&gt;
    &lt;Month&gt;&lt;/Month&gt;
    &lt;Day&gt;&lt;/Day&gt;
   &lt;/DOB&gt;
   &lt;Phone10&gt;&lt;/Phone10&gt;
   &lt;DLNumber&gt;&lt;/DLNumber&gt;
   &lt;DLState&gt;&lt;/DLState&gt;
  &lt;/SearchBy&gt;
 &lt;/row&gt;
&lt;/IdentityManagementSearchRequest&gt;
</pre>
*/
IMPORT iesp;

EXPORT SearchService() := MACRO

	#CONSTANT('IncludeNonDMVSources', TRUE);
	#STORED('FuzzySecRange',AutoStandardI.Constants.SECRANGE.EXACT_OR_BLANK);

  // this is to disable "isAdvanced" branch in doxie\header_records_byDID, which creates a dependency on a standard search 
  #constant ('RelativeFirstName1', '');
  #constant ('RelativeFirstName2', '');
  #constant ('OtherLastName1', '');
  #constant ('OtherState1', '');
  #constant ('OtherState2', '');
  #constant ('OtherCity1', '');

  // read input
	ds_in := DATASET([], iesp.identitymanagementsearch.t_IdentityManagementSearchRequest) : STORED('IdentityManagementSearchRequest',FEW);
	first_row := ds_in[1] : INDEPENDENT;

	//==== CASE1: IF BEST MATCHING CONDITION(DID) PROVIDED IN INPUT. IGNORE ALL OTHER INPUTS ====//
	searchBy := IF(first_row.SearchBy.UniqueId <> '',
								PROJECT(first_row.SearchBy,TRANSFORM(iesp.identitymanagementsearch.t_IDMSearchBy, 
																											SELF.UniqueId := LEFT.UniqueId, SELF := [])),
								first_row.SearchBy);

	SetLegacyInput (iesp.identitymanagementsearch.t_IDMSearchOption xml_in) := FUNCTION
		score := IF(xml_in.ScoreThreshold = 0, 15, xml_in.ScoreThreshold);
		#STORED('ScoreThreshold', score);
		RETURN iesp.ECL2ESP.EnforceRead();
  END;

	iesp.ECL2ESP.SetInputReportBy(PROJECT(searchBy, TRANSFORM(iesp.bpsreport.t_BpsReportBy, SELF := LEFT, SELF:=[]))); //Stored only for Penalty Calculation
	iesp.ECL2ESP.SetInputBaseRequest(first_row); //Stores input options
	SetLegacyInput (GLOBAL(first_row.options)); //Stores only score threshold as not supported by base request above.
	iesp.ECL2ESP.Marshall.Mac_Set(first_row.options);	
	
	uncleaned_input := IdentityManagement_Services.Functions.SetSearchBy(ds_in);

  m_search := module (IdentityManagement_Services.IParam._search)
    export boolean include_hri   := TRUE; //Always return HRI Indicators
    export boolean use_saltFetch := first_row.options.UseSALTLexIDFetch;
  end;
	header_recs := IdentityManagement_Services.search_records(uncleaned_input, m_search);
	
	idm_recs := PROJECT(header_recs,iesp.identitymanagementsearch.t_IDMSearchRecord)(UniqueId <> '');

	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(idm_recs, results, iesp.identitymanagementsearch.t_IdentityManagementSearchResponse, 
																							Records, FALSE, RecordCount);
  
	OUTPUT(results,NAMED('Results'));
	OUTPUT(header_recs(UniqueId = '' AND errorcode <> 0),NAMED('Error_Codes'));


ENDMACRO;