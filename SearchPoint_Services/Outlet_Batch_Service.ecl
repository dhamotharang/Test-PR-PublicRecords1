	/*--SOAP--
<message name="Outlet_Batch_Service">
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/> 
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>	
	<part name="ApplicationType"     	type="xsd:string"/>
	<part name="max_results_per_acct" type="xsd:unsignedInt"/>	
</message>
*/

EXPORT Outlet_Batch_Service(useCannedRecs = 'false') := 
	MACRO	 	 				 
		results := SearchPoint_Services.Outlet_Batch_Service_Records(useCannedRecs);		
    OUTPUT( results, NAMED('Results'));				
	ENDMACRO;	