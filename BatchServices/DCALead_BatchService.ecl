/*--SOAP--
<message name="DCALead_BatchService">
	<part name="batch_in"    type="tns:XmlDataSet" cols="70" rows="25"/>
</message>
*/
export DCALead_BatchService := macro

	ak_input := DATASET([], Autokey_batch.Layouts.rec_inBatchMaster) : STORED('batch_in', FEW);
	
	results := BatchServices.DCALead_BatchService_Records(ak_input);
	
	output(results,named('Results'));

endmacro;
