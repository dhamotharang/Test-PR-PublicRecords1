/*--SOAP--
<message name="BatchService">
  <part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/> 
</message>
*/
/*--INFO-- This service searches whether a debtor is associated with a Debt Settlement Company and returns
						the phone number for that company. 
						The search requires a phone number and/or an address.

<pre>
&lt;batch_in&gt;
&lt;row&gt;
  &lt;acctno&gt;&lt;/acctno&gt;
  &lt;phoneno&gt;&lt;/phoneno&gt;
  &lt;addr&gt;&lt;/addr&gt;
  &lt;prim_range&gt;&lt;/prim_range&gt;
  &lt;predir&gt;&lt;/predir&gt;
  &lt;prim_name&gt;&lt;/prim_name&gt;
  &lt;addr_suffix&gt;&lt;/addr_suffix&gt;
  &lt;postdir&gt;&lt;/postdir&gt;
  &lt;unit_design&gt;&lt;/unit_design&gt;
  &lt;sec_range&gt;&lt;/sec_range&gt;
  &lt;city&gt;&lt;/city&gt;
  &lt;st&gt;&lt;/st&gt;
  &lt;z5&gt;&lt;/z5&gt;
&lt;/row&gt;  
&lt;/batch_in&gt;
</pre>

<pre>
&lt;batch_in&gt;
&lt;row&gt;
  &lt;phoneno&gt;5613475050&lt;/phoneno&gt;
  &lt;addr&gt;7100 CAMINO REAL&lt;/addr&gt;
  &lt;city&gt;BOCA RATON&lt;/city&gt;
  &lt;st&gt;FL&lt;/st&gt;
  &lt;z5&gt;33433&lt;/z5&gt;
&lt;/row&gt;  
&lt;/batch_in&gt;
</pre>
*/

import BatchServices;

export PAC_Indicator_BatchService := MACRO
	in_layout := BatchServices.PAC_Indicator_BatchService_Layouts.rec_batch_input;
	
	DS_Batch_In := dataset([], in_layout) : stored('batch_in');
	// DS_Batch_In := dataset([{'', '2108297183', '111 W OLMOS DR', '', 'SAN ANTONIO', 'TX', '78212'}, {'', '5613475050', '7100 CAMINO REAL', '', 'BOCA RATON', 'FL', '33433'}], IN_LAYOUT);
	
	Results := BatchServices.PAC_Indicator_BatchService_Records(DS_Batch_In);
	
	OUTPUT(Results,NAMED('Results'));
ENDMACRO;

// BatchServices.PAC_Indicator_BatchService();

/*
<batch_in>
<row>
  <phoneno>5613475050</phoneno>
  <addr>7100 CAMINO REAL</addr>
  <city>BOCA RATON</city>
  <st>FL</st>
  <z5>33433</z5>
</row>  
<row>
  <phoneno>2108297183</phoneno>
  <addr>111 W OLMOS DR</addr>
  <city>SAN ANTONIO</city>
  <st>TX</st>
  <z5>78212</z5>
</row>  
</batch_in>
*/