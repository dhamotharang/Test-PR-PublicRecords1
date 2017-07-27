/*--SOAP--
<message name="Property_DZLD_BatchServices">
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/> 
	<part name="max_results_per_acct" type="xsd:unsignedInt"/>
	<part name="DataRestrictionMask" 	type="xsd:string"/>
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>
</message>
*/
/*--INFO-- This service searches Property Deed Zip Loan Date key and returns the property record.*/

export Property_DZLD_BatchServices := macro

	// Layout of input data
	in_layout := BatchServices.Layouts_Property_DZLD.Batch_In;
	
	// Read input
	dataset(in_layout) indata 		:= dataset([],in_layout) : stored('batch_in',few);
	INTEGER max_results_per_acct 	:= BatchServices.Constants.PROPERTY_MAX_RESULTS_PER_ACCT : STORED('Max_Results_Per_Acct');
	
	// Retrieve and output records
	ds_outrecs := BatchServices.Property_DZLD_Records(indata);
	
	// Apply max resutls per acct filter.
	results := TOPN(GROUP(sort(ds_outrecs,acctno),acctno), max_results_per_acct, acctno);
	
	output(results,named('Results'));

endmacro;
//Property_DZLD_BatchServices()
/* Sample test cases
<dataset>
<row>
<acctno>1001</acctno>
<zip>33486</zip>
<loan_amount>99990</loan_amount>
<loan_date>20000727</loan_date>
</row>
<row>
<acctno>1003</acctno>
<zip>00132</zip>
<loan_amount>15000</loan_amount>
<loan_date>20071106</loan_date>
</row>
<row>
<acctno>1002</acctno>
<zip>33486</zip>
<loan_amount>247400</loan_amount>
<loan_date></loan_date>
</row>
</dataset>
*/