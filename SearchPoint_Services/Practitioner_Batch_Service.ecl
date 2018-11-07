	/*--SOAP--
<message name="Practitioner_Batch_Service">
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/> 
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>	
	<part name="ApplicationType"     	type="xsd:string"/>
	<part name="max_results_per_acct" type="xsd:unsignedInt"/>	
</message>
*/

EXPORT Practitioner_Batch_Service(useCannedRecs = 'false') := 
	MACRO	 	 
	 #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
		results := SearchPoint_Services.Practitioner_Batch_Service_Records(useCannedRecs);		
    OUTPUT( results, NAMED('Results'));				
	ENDMACRO;	