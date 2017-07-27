/*--SOAP--
<message name="HeaderFileFAPMultiService">
	<part name="FullNames" type="tns:XmlDataSet" cols="75" rows="25"/>
	<part name="FullAddrs" type="tns:XmlDataSet" cols="75" rows="25"/>
  <part name="phones" type="tns:EspStringArray"/>
	<part name="SSNS" type="tns:EspStringArray"/>
	<part name="DOBS" type="tns:EspIntArray"/>
	<part name="MaxResults" type="xsd:unsignedInt"/>
	<part name="ScoreThreshold" type="xsd:unsignedInt"/>
	<part name="ZipRadius" type="xsd:unsignedInt"/>
	<part name="PhoneticMatch" type="xsd:boolean"/>
	<part name="AllowNickNames" type="xsd:boolean"/>
	<part name="DPPAPurpose" type="xsd:unsignedInt"/>
	<part name="GLBPurpose" type="xsd:unsignedInt"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="ProbationOverride" type="xsd:boolean"/>
	<part name="LNBranded" type="xsd:boolean"/>
</message>
*/
/*--INFO-- This service does a batch like search of the header file. */
export HeaderFileFAPMultiService := MACRO
	// #option('countindex',1);
	// #option('resourceChildGraphs',1);
	MatchingRecs := Header_Services.Fetch_Header_File_FAPMulti;
	OUTPUT(COUNT(MatchingRecs), NAMED('RecordsAvailable')); 
  OUTPUT(MatchingRecs, NAMED('MatchingRecs'));

ENDMACRO;