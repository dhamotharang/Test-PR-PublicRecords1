/*--SOAP--
<message name="LinkId_Update_Batch_Service">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="TrackSplit" type="xsd:boolean" required="0"/>
</message>
*/

export LinkId_Update_Batch_Service() := macro

	input_layout := DidVille.LinkId_Update_Batch_Service_Layouts.input_layout;
	
	input_records := dataset([],input_layout) : stored('batch_in',few);
	
	output_records := DidVille.LinkId_Update_Batch_Service_Records(input_records);
	
	output(output_records,named('Results'));

endmacro;
