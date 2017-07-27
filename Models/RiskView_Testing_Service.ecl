/*--SOAP--
<message name="RiskView_Testing_Service">
	<part name="DID" type="xsd:unsigned"/>
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
	<part name="IndustryClass" type="xsd:string"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="Attributes" type="xsd:boolean"/>
	<part name="IntendedPurpose" type="xsd:string"/>
	<part name="TestDataEnabled" type="xsd:boolean"/>
	<part name="TestDataTableName" type="xsd:string"/>
	<part name="scores" type="tns:XmlDataSet" cols="70" rows="10"/>
	<part name="RequestedAttributeGroups" type="tns:XmlDataSet" cols="70" rows="10"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="10"/>
	<part name="InPersonApplication" type="xsd:boolean"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
  <part name="OutcomeTrackingOptOut" type="xsd:boolean"/>
  <part name="AddressAppend" type="xsd:boolean"/>
	<part name="FFDOptionsMask"	type="xsd:string"/>	
 </message>
*/
/*--INFO-- Contains RiskView Scores AirWaves, Auto, Bankcard, Retail and Money and Attributes */

export RiskView_Testing_Service := MACRO

/* Force layout of WsECL page */
#WEBSERVICE(FIELDS(
	'DID',
	'AccountNumber',
	'UnParsedFullName',
	'FirstName',
	'MiddleName',
	'LastName',
	'NameSuffix',
	'StreetAddress',
	'City',
	'State',
	'Zip',
	'Country',
	'SSN',
	'DateOfBirth',
	'Age',
	'DLNumber',
	'DLState',
	'Email',
	'IPAddress',
	'HomePhone',
	'WorkPhone',
	'EmployerName',
	'FormerName',
	'IndustryClass',
	'HistoryDateYYYYMM',
	'Attributes',
	'IntendedPurpose',
	'TestDataEnabled',
	'TestDataTableName',
	'scores',
	'RequestedAttributeGroups',
	'gateways',
	'InPersonApplication',
	'DataRestrictionMask',
	'DataPermissionMask',
	'OutcomeTrackingOptOut',
	'AddressAppend',
	'FFDOptionsMask'));

#stored('TestingService', TRUE);

riskview_xml := Models.RiskView_Records;

output( riskview_xml, named( 'Results' ) );

ENDMACRO;
// Models.RiskView_Testing_Service();