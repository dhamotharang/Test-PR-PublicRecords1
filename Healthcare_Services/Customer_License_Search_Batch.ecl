/*--SOAP--
<message name="Customer_License_Search_Batch">
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/> 		
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>	
</message>
*/
/*--INFO--
<pre>
This service will return a set of matching records for a given customers State License File.

The service requires the customer number and either a License number, or Name and Address information as input.

</pre>
*/

EXPORT Customer_License_Search_Batch := MACRO
	shared myRecords := Healthcare_Services.Customer_License_Search_Records;
	batch_in_layout := Healthcare_Services.Customer_License_Search_Layouts.autokeyInput;
	ds_batch_in_stored := DATASET([], batch_in_layout) : STORED('batch_in', FEW);
	unsigned2 PenaltThreshold := 10 :	stored ('PenaltThreshold');	
	
	verifyCompanyExists := myRecords.verify_Company(ds_batch_in_stored[1].CustomerID);
	if(not verifyCompanyExists,fail('Customer ID is not valid.'));
	results :=myRecords.recordsBatch(ds_batch_in_stored,PenaltThreshold);
	output(results, named('Results'));

ENDMACRO;