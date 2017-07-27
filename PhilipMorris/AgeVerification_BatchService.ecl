/*--SOAP--
<message name="AgeVerification_BatchService">	
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/>
	<part name="SkipRestrictionsCall" type="xsd:boolean"/>
	<part name="AllowProbationSources"     type="xsd:boolean"/>
	<part name="RunFailureReport"     type="xsd:boolean"/>
		
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>					
</message>
*/

export AgeVerification_BatchService() := MACRO

	#constant('IncludeMinors',true);
	#constant('DataRestrictionMask','1    0');
	OUTPUT( PhilipMorris.AgeVerification_BatchService_Records(), NAMED('Results') );		
	
ENDMACRO;
/* Expected XML Format
	<dataset>
		<row>
			<AcctNo></AcctNo>
			<ChannelIdentifier></ChannelIdentifier>
			<CCN></CCN>
			<ContactID></ContactID>
			<Title></Title>
			<NameFirst></NameFirst>
			<NameMiddle></NameMiddle>
			<NameLast></NameLast>			
			<NameSuffix></NameSuffix>
			
			<SSN></SSN>
			<DOB_YYYYMMDD></DOB_YYYYMMDD>
			
			<GIID_AddressLine1></GIID_AddressLine1>
			<GIID_AddressLine2></GIID_AddressLine2>
			<GIID_City></GIID_City>
			<GIID_State></GIID_State>
			<GIID_ZipCode></GIID_ZipCode>
			
			<Current_AddressLine1></Current_AddressLine1>
			<Current_AddressLine2></Current_AddressLine2>
			<Current_City></Current_City>
			<Current_State></Current_State>
			<Current_ZipCode></Current_ZipCode>
			
			<Previous_AddressLine1></Previous_AddressLine1>
			<Previous_AddressLine2></Previous_AddressLine2>
			<Previous_City></PreviousCity>
			<Previous_State></Previous_State>
			<Previous_ZipCode></Previous_ZipCode>
		</row>
	</dataset>
*/