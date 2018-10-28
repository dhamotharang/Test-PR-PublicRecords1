	/*--SOAP--
<message name="DEA_BatchService">
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/> 
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>	
	<part name="SSNMask" 							type="xsd:string"/>
	<part name="ApplicationType"     	type="xsd:string"/>
	<part name="max_results_per_acct" type="xsd:unsignedInt"/>	
	<part name="Run_Deep_Dive"        type="xsd:boolean" default="false"/>
	<part name="PenaltThreshold"      type="xsd:unsignedInt"/>
</message>
*/
IMPORT BatchServices;

EXPORT DEA_BatchService(useCannedRecs = 'false') := 
	MACRO
	 #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);	 				 
		results := BatchServices.DEA_BatchService_Records(useCannedRecs);		
		ut.mac_TrimFields(results, 'results', result);
		OUTPUT(result, NAMED('Results'));
	ENDMACRO;	