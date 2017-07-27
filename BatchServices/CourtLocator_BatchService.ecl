
/*--SOAP--
<message name="CourtLocator_BatchService">
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>	
	<part name="Max_Results_Per_Acct" type="xsd:unsignedInt"/>
</message>
*/
/*--INFO--
<pre>
This service will return a set of court jurisdictions associated with either 
an input address or fips code. 
</pre>
*/
 /*--HELP-- 
 <pre>
 &lt;batch_in&gt;
  &lt;Row&gt;
    &lt;acctno&gt;&lt;/acctno&gt;
    &lt;fips_code&gt;&lt;/fips_code&gt;
    &lt;prim_range&gt;&lt;/prim_range&gt;
    &lt;predir&gt;&lt;/predir&gt;
    &lt;prim_name&gt;&lt;/prim_name&gt;
    &lt;addr_suffix&gt;&lt;/addr_suffix&gt;
    &lt;postdir&gt;&lt;/postdir&gt;
    &lt;sec_range&gt;&lt;/sec_range&gt;
    &lt;p_city_name&gt;&lt;/p_city_name&gt;
    &lt;st&gt;&lt;/st&gt;
    &lt;z5&gt;&lt;/z5&gt;
  &lt;/Row&gt;
 &lt;/batch_in&gt;
 </pre>
*/
import Autokey_batch;

EXPORT CourtLocator_BatchService(useCannedRecs = 'false') := 
	MACRO
	
		INTEGER max_results_per_acct    := BatchServices.Constants.CourtLocator.MAX_RESULTS_PER_ACCT : STORED('Max_Results_Per_Acct');

		ds_xml_in      := DATASET([], BatchServices.Layouts.CourtLocator.layout_batch_in) : STORED('batch_in', FEW);

		//use dummy input requests if asked useCannedRecs = true.
		BatchServices.Layouts.CourtLocator.layout_batch_in fillCanned(Autokey_batch.Layouts.rec_inBatchMaster l) := transform
			 self.fips_code := '';
		   self := l;
		end;
		ds_canned := project(BatchServices._Sample_inBatchMaster('CourtLocator'), fillCanned(LEFT));
		
		ds_batch_in    := IF( NOT useCannedRecs, 
		                      ds_xml_in , 
		                      ds_canned 
                         );		
    
		dd_batch_in := dedup(sort(ds_batch_in, acctno), acctno);
		ds_recs := BatchServices.CourtLocator_BatchService_Records(dd_batch_in);

		ds_recs_s := sort(ds_recs.records, acctno, courtname, physicalcity, physicalstate, physicalzip, record);
		ds_recs_dup := dedup(ds_recs_s, acctno, keep(max_results_per_acct));
		OUTPUT(ds_recs_dup, NAMED('Results'));			

	ENDMACRO;	
 
