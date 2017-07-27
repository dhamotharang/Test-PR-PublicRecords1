/*--SOAP--
<message name="SmartGrid_Batch_Service">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="20"/>
</message>
*/
/*--INFO-- SmartGrid Batch Service*/
/*--HELP--
<pre>
&lt;dataset&gt;
	&lt;row&gt;
		&lt;acctno&gt;&lt;/acctno&gt;
		&lt;street_address&gt;&lt;/street_address&gt;
		&lt;apt&gt;&lt;/apt&gt;
		&lt;city&gt;&lt;/city&gt;
		&lt;state&gt;&lt;/state&gt;
		&lt;Zip&gt;&lt;/Zip&gt;
		&lt;Zip4&gt;&lt;/Zip4&gt;
	&lt;/row&gt;
&lt;/dataset&gt;
</pre>
*/


export SmartGrid_BatchService := MACRO

	//Get input
	ds_xml_in := dataset([],Address_Attributes.Layouts.SmartGrid_in) 			: stored('batch_in',few);

	//Get data
	response := Address_Attributes.get_SmartGrid_Data(ds_xml_in);

	//Return output
	output(response, named('Results'));

ENDMACRO;

// SmartGrid_BatchService();