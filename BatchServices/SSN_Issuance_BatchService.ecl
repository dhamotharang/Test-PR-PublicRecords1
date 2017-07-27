/*--SOAP--
<message name="SSN_Issuance_BatchService">
  <part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
</message>
*/

/*--INFO-- This service supplies SSN issuance data for the input SSNs.
<pre>
&lt;batch_in&gt;
&lt;row&gt;
  &lt;acctno&gt;&lt;/acctno&gt;
  &lt;SSN&gt;&lt;/SSN&gt;
&lt;/row&gt;  
&lt;/batch_in&gt;
</pre>
*/

import BatchServices;

export SSN_Issuance_BatchService := MACRO
  rec_in := BatchServices.Layouts.SsnIssuance.batch_in;
  
  ds_batch_in := dataset([], rec_in) : stored ('batch_in');
  // ds_batch_in := dataset ([{'590710883'}, {'766927631'}], in_layout);
  
  Results := BatchServices.SSN_Issuance_BatchService_Records (ds_batch_in);
  
  output (Results, named('Results'));
ENDMACRO;

/*
<batch_in>
<row>
  <acctno></acctno>
  <SSN></SSN>
</row>  
<row>
  <acctno></acctno>
  <SSN></SSN>
</row>  
</batch_in>
*/