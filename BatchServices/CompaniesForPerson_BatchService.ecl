/*--SOAP--
<message name="CompanyByPerson_BatchService">
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/> 
	<part name="DataRestrictionMask"	type="xsd:string"/>
	<part name="MaxResults"           type="xsd:unsignedInt"/>
	<part name="max_results_per_acct" type="xsd:unsignedInt"/>
	<part name="ApplicationType"     	type="xsd:string"/>
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>
</message>
*/

IMPORT BatchServices;

EXPORT CompaniesForPerson_BatchService(useCannedRecs = 'false') := MACRO
  #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
    Pre_result := BatchServices.CompaniesForPerson_BatchService_Records(useCannedRecs);
		ut.mac_TrimFields(Pre_result, 'Pre_result', result);
		OUTPUT(result, NAMED('Results'));	
		
ENDMACRO;
