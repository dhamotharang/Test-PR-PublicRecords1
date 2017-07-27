/*--SOAP--
<message name="SSNExpansionService">	
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/> 
	
	<part name="TransactionNumber" type="string"/>
	<part name="CCN" type="string"/>
	<part name="ContactID" type="string"/>
	<part name="ChannelIdentifier" type="string"/>
	
	<part name="Title" type="string"/>
	<part name="NameFirst" type="string"/>
	<part name="NameMiddle" type="string"/>
	<part name="NameLast" type="string"/>
	
	<part name="NameSuffix" type="string"/>
	<part name="SSNLast4" type="string"/>
	<part name="DOB_YYYYMMDD" type="string"/>
	
	<part name="GIIDAddressLine1" type="string"/>
	<part name="GIIDAddressLine2" type="string"/>
	<part name="GIIDCity" type="string"/>
	<part name="GIIDState" type="string"/>
	<part name="GIIDZipCode" type="string"/>
	
	<part name="CurrentAddressLine1" type="string"/>
	<part name="CurrentAddressLine2" type="string"/>
	<part name="CurrentCity" type="string"/>
	<part name="CurrentState" type="string"/>
	<part name="CurrentZipCode" type="string"/>
  <part name="IncludeNameDobZipMatch"     type="xsd:boolean"/>
	
	<part name="SSNExpansionRequest" type="tns:XmlDataSet" cols="80" rows="10" />
					
</message>
*/

/*--INFO-- Service performs SSN Expansion on the input subject 
	Expected minimum input fields present:  			
			- GLB Value (defaults to 0 if not provided)
			- DPPA Value (defaults to 0 if not provided)
			- Last Name
			- First Name
			- SSN4 
			- Address line 1 (GIID)
			- City  (GIID)
			- State (GIID)
			- Zip Code (GIID)
*/

import iesp;

export SSNExpansionService := MACRO

	#constant('IncludeMinors',true);
	#constant('DataRestrictionMask','1    0');
	
	
	ds_in := DATASET ([], iesp.ageverification.t_SSNExpansionRequest) : STORED ('SSNExpansionRequest', FEW);
	first_raw := ds_in[1] : INDEPENDENT;
	search_by:=first_raw.searchby;
	options := first_raw.options;
	#stored('IncludeNameDobZipMatch',options.IncludeNameDobZipMatch);
	iesp_input := PROJECT(ds_in, PhilipMorris.Transforms.xfm_standardize_input_for_iesp_ssn4(LEFT));
		
	iesp.ECL2ESP.SetInputBaseRequest (first_raw); 	

	inputData := if (exists(iesp_input), iesp_input, PhilipMorris.Functions.fn_getNonXMLInputDataSSN4());	
	
	BOOLEAN include_NameDobZipMatch    := false : STORED('IncludeNameDobZipMatch');
	// these are set in iesp.ECL2ESP.SetInputBaseRequest
	UNSIGNED1 DPPA_Purpose := 0 :STORED('DPPAPurpose');
	UNSIGNED1 GLB_Purpose  := 0 :STORED('GLBPurpose');		
	outputDataNonIesp := PhilipMorris.fn_PMExpandSSN(inputData, DPPA_Purpose, GLB_Purpose,include_NameDobZipMatch);
	outputDataIesp := PROJECT(outputDataNonIesp, PhilipMorris.Transforms.xfm_xlate_output_for_iesp_SSN4(LEFT));
	OUTPUT(outputDataIesp, named('Results'));

ENDMACRO;
//SSNExpansionService()
/* iesp layout
<SSNExpansionRequest>
<row>
<User>
  <GLBPurpose>1</GLBPurpose>
  <DLPurpose>1</DLPurpose>
  <EndUser/>
</User>
<Options></Options>
<SearchBy>
	<UniqueId></UniqueId>
	<TransactionNumber></TransactionNumber>
	<CCN></CCN>
	<ContactID></ContactID>
	<ChannelIdentifier></ChannelIdentifier>	
  <Name>
		<Prefix></Prefix>
    <First></First>
    <Middle></Middle>
    <Last></Last>
		<Suffix></Suffix>
  </Name>
	<DOB>
    <Year></Year>
    <Month></Month>
    <Day></Day>
  </DOB>
	<SSNLast4></SSNLast4>
  <GIIDAddress>
    <StreetAddress1></StreetAddress1>
    <StreetAddress2></StreetAddress2>
    <State></State>
    <City></City>
    <Zip5></Zip5>
  </GIIDAddress>
  <CurrentAddress>
    <StreetAddress1></StreetAddress1>
    <StreetAddress2></StreetAddress2>
    <State></State>
    <City></City>
    <Zip5></Zip5>
  </CurrentAddress>	
</SearchBy>
</row>
</SSNExpansionRequest>
*/
