/*--SOAP--
<message name="CensusBureau_Phone_Service">
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/> 
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>
</message>
*/
export CensusBureau_Phone_Service := macro

	// Layout of input data
	in_layout := CensusBureau.CensusBureau_Phone_Service_Layouts.Batch_In;
	
	// Grab input data from SOAP variable
	dataset(in_layout) indata := dataset([],in_layout) : stored('batch_in');
	
	// Retrieve and output records
	output(CensusBureau.CensusBureau_Phone_Service_Records(indata),named('Results'));

endmacro;
