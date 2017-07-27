/*--SOAP--
<message name="BocaInstantID">
	<part name="AccountNumber" type="xsd:string"/>
	<part name="UnParsedFullName" type="xsd:string"/>
	<part name="FirstName" type="xsd:string"/>
	<part name="MiddleName" type="xsd:string"/>
	<part name="LastName" type="xsd:string"/>
	<part name="NameSuffix" type="xsd:string"/>
	<part name="StreetAddress" type="xsd:string"/>
	<part name="City" type="xsd:string"/>
	<part name="State" type="xsd:string"/>
	<part name="Zip" type="xsd:string"/>
	<part name="Country" type="xsd:string"/>
	<part name="SSN" type="xsd:string"/>
	<part name="DateOfBirth" type="xsd:string"/>
	<part name="Age" type="xsd:unsignedInt"/>
	<part name="DLNumber" type="xsd:string"/>
	<part name="DLState" type="xsd:string"/>
	<part name="Email" type="xsd:string"/>
	<part name="IPAddress" type="xsd:string"/>
	<part name="HomePhone" type="xsd:string"/>
	<part name="WorkPhone" type="xsd:string"/>
	<part name="EmployerName" type="xsd:string"/>
	<part name="FormerName" type="xsd:string"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/> 
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="IndustryClass" type="xsd:string"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="PoBoxCompliance" type="xsd:boolean"/>
	<part name="OfacOnly" type="xsd:boolean"/>
	<part name="ExcludeWatchLists" type="xsd:boolean"/>
	<part name="OFACversion" type="xsd:unsignedInt"/>
	<part name="IncludeOfac" type="xsd:boolean"/>
	<part name="GlobalWatchlistThreshold" type="xsd:real"/>  
	<part name="IncludeAdditionalWatchLists" type="xsd:boolean"/>
	<part name="UseDOBFilter" type="xsd:boolean"/>
	<part name="DOBRadius" type="xsd:unsignedInt"/>	
	<part name="TestDataEnabled" type="xsd:boolean"/>
	<part name="TestDataTableName" type="xsd:string"/>
	<part name="FromIIDModel" type="xsd:boolean"/>
	<part name="RedFlag_version" type="xsd:unsignedInt"/>
	<part name="SSNMask" type="xsd:string"/>
	<part name="DLMask"	type="xsd:string"/>
  <part name="DOBMask" type="xsd:string"/>
	<part name="IncludeMSoverride" type="xsd:boolean"/>
	<part name="IncludeCLoverride" type="xsd:boolean"/>
	<part name="IncludeDLVerification" type="xsd:boolean"/>
	<part name="PassportUpperLine" type="xsd:string"/>
	<part name="PassportLowerLine" type="xsd:string"/>
	<part name="Gender" type="xsd:string"/>
	<part name="DOBMatchOptions" type="tns:XmlDataSet" cols="110" rows="10"/>
	<part name="scores" type="tns:XmlDataSet" cols="70" rows="10"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="10"/>
 </message>
*/

export InstantIDService := MACRO

#constant('IncludeMinors',true);
 
output( bs_services.InstantID_records, named( 'Results' ) );

ENDMACRO;