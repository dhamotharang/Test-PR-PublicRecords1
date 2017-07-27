/*--SOAP--
<message name="AgeVerificationService">	

	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/> 
	<part name="RunInBatchMode"     type="xsd:boolean"/>
	<part name="SkipRestrictionsCall"     type="xsd:boolean"/>
	<part name="AllowProbationSources"     type="xsd:boolean"/>
		
	<part name="TransactionNumber" type="string"/>
	<part name="CCN" type="string"/>
	<part name="ContactID" type="string"/>
	<part name="ChannelIdentifier" type="string"/>
	
	<part name="Title" type="string"/>
	<part name="NameFirst" type="string"/>
	<part name="NameMiddle" type="string"/>
	<part name="NameLast" type="string"/>
	
	<part name="NameSuffix" type="string"/>
	<part name="SSN" type="string"/>
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
	
	<part name="PreviousAddressLine1" type="string"/>
	<part name="PreviousAddressLine2" type="string"/>
	<part name="PreviousCity" type="string"/>
	<part name="PreviousState" type="string"/>
	<part name="PreviousZipCode" type="string"/>

	<part name="AgeVerificationRequest" type="tns:XmlDataSet" cols="80" rows="10" />
					
</message>
*/

/*--INFO-- Service performs age verification on the input subject using 'online' logic
	Expected minimum input fields present:  
			- Transaction ID
			- GLB Value (defaults to 0 if not provided)
			- DPPA Value (defaults to 0 if not provided)
			- Last Name
			- First Name
			- DOB (in YYYYMMDD format)
			- Address line 1 (GIID)
			- City  (GIID)
			- State (GIID)
			- Zip Code (GIID)
*/


import iesp;

export AgeVerificationService := MACRO

	#constant('IncludeMinors',true);
	#constant('DataRestrictionMask','1    0');
	
	ds_in := DATASET ([], iesp.ageverification.t_AgeVerificationRequest) : STORED ('AgeVerificationRequest', FEW);
	iesp_input := PROJECT(ds_in, PhilipMorris.Transforms.xfm_standardize_input_for_iesp(LEFT));
	
	first_raw := ds_in[1] : INDEPENDENT;
	iesp.ECL2ESP.SetInputBaseRequest (first_raw);
	inputData := if (exists(iesp_input), iesp_input, PhilipMorris.Functions.fn_getNonXMLInputData());	
	
	BOOLEAN noniespRunInBatchMode  := false :STORED('RunInBatchMode');
	BOOLEAN noniespSkipRestrictionsCall  := false :STORED('SkipRestrictionsCall');
	BOOLEAN noniespAllowProbationSources  := false :STORED('AllowProbationSources');
	runBatchMode := if(exists(iesp_input), first_raw.Options.RunBatchLogic, noniespRunInBatchMode);
	SkipRestrictionsCall := if(exists(iesp_input), first_raw.Options.SkipRestrictionsCall, noniespSkipRestrictionsCall);
	AllowProbationSources := if(exists(iesp_input), first_raw.Options.AllowProbationSources, noniespAllowProbationSources);
  	
	// these are set either in SOAP or sent via XML
	UNSIGNED1 DPPA_Purpose := 0 :STORED('DPPAPurpose');
	UNSIGNED1 GLB_Purpose  := 0 :STORED('GLBPurpose');
	
	outputDataNonIesp := PhilipMorris.fn_PmAgeVerify(inputData, runBatchMode, DPPA_Purpose, GLB_Purpose, SkipRestrictionsCall, AllowProbationSources, false);
	outputDataIesp := PROJECT(outputDataNonIesp, PhilipMorris.Transforms.xfm_xlate_output_for_iesp(LEFT));
		
	OUTPUT(outputDataIesp, named('Results'));

ENDMACRO;
/* iesp layout
<AgeVerificationRequest>
<row>
<User>
  <GLBPurpose>1</GLBPurpose>
  <DLPurpose>3</DLPurpose>
  <EndUser/>
</User>
<Options>
	<RunInBatchMode></RunInBatchMode>
	<SkipRestrictionsCall></SkipRestrictionsCall>
	<AllowProbationSources></AllowProbationSources>
</Options>
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
	<SSN></SSN>
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
	<PreviousAddress>
    <StreetAddress1></StreetAddress1>
    <StreetAddress2></StreetAddress2>
    <State></State>
    <City></City>
    <Zip5></Zip5>
  </PreviousAddress>
</SearchBy>
</row>
</AgeVerificationRequest>
*/
