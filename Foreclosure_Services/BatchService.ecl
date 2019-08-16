
/*--SOAP--
<message name="Foreclosure_Batch_Service">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="20"/>
</message>
*/
/*--INFO-- Foreclosure Batch Service*/
/*--HELP--
<pre>
&lt;dataset&gt;
	&lt;row&gt;
		&lt;acctno&gt;&lt;/acctno&gt;
		&lt;last_name&gt;&lt;/last_name&gt;
		&lt;middle_initial&gt;&lt;/middle_initial&gt;
		&lt;first_name&gt;&lt;/first_name&gt;
		&lt;prim_range&gt;&lt;/prim_range&gt;
		&lt;predir&gt;&lt;/predir&gt;
		&lt;prim_name&gt;&lt;/prim_name&gt;
		&lt;addr_suffix&gt;&lt;/addr_suffix&gt;
		&lt;postdir&gt;&lt;/postdir&gt;
		&lt;sec_range&gt;&lt;/sec_range&gt;
		&lt;p_city_name&gt;&lt;/p_city_name&gt;
		&lt;st&gt;&lt;/st&gt;
		&lt;z5&gt;&lt;/z5&gt;
		&lt;zip4&gt;&lt;/zip4&gt;
	&lt;/row&gt;
&lt;/dataset&gt;
</pre>
*/

import Foreclosure_Services;

export BatchService := MACRO

	ds_xml_in := dataset([],Foreclosure_Services.Layouts.layout_batch_in) : stored('batch_in',few);
	
 boolean includeVendorSourceB := false : STORED ('IncludeVendorSourceB');
	
	Pre_result := Foreclosure_Services.BatchService_Records(ds_xml_in, includeVendorSourceB);
	ut.mac_TrimFields(Pre_result, 'Pre_result', result);
	OUTPUT(result, NAMED('Results'));	
	
ENDMACRO;

// BatchService();