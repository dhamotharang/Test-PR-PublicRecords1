/*--SOAP--
<message name="HRI_Address_Service">
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/> 
	<part name="max_results_per_acct" type="xsd:unsignedInt"/>
	<part name="DataRestrictionMask" 	type="xsd:string"/>
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>
</message>
*/
/*--INFO-- This service searches High Risk Address index by address and returns SIC Description.*/
import autokey_batch;
export HRI_Address_Service := macro

	// Read input
	dataset(Autokey_batch.Layouts.rec_inBatchMaster) batch_in 		:= dataset([],Autokey_batch.Layouts.rec_inBatchMaster) : stored('batch_in',few);
	indata 		:= project(batch_in,BatchServices.Transforms.xfm_capitalize_input(left));
	INTEGER max_results_per_acct 	:= BatchServices.Constants.HRIADDR_MAX_RESULTS_PER_ACCT : STORED('Max_Results_Per_Acct');
	
	// Retrieve and output records
	ds_outrecs := BatchServices.HRI_Address_Records(indata);
	
	// Apply max resutls per acct filter.
	results := TOPN(GROUP(sort(ds_outrecs,acctno),acctno), max_results_per_acct, acctno);
	
	output(results,named('Results'));

endmacro;
//HRI_Address_Service()
/* Sample test cases
<dataset>
<row>
	<acctno>01-HRIHIT</acctno>
	<prim_range>244</prim_range>
	<predir></predir>
	<prim_name>5TH</prim_name>
	<addr_suffix>AVE</addr_suffix>
	<postdir></postdir>
	<unit_desig></unit_desig>
	<sec_range></sec_range>
	<p_city_name></p_city_name>
	<st></st>
	<z5>10001</z5>
	<zip4></zip4>
</row>
<row>
	<acctno>02-HRIHIT</acctno>
	<prim_range>349</prim_range>
	<predir></predir>
	<prim_name>COOPER</prim_name>
	<addr_suffix>st</addr_suffix>
	<postdir></postdir>
	<unit_desig></unit_desig>
	<sec_range></sec_range>
	<p_city_name></p_city_name>
	<st></st>
	<z5>01001</z5>
	<zip4></zip4>
</row>
<row>
	<acctno>1HRIHIT</acctno>
	<prim_range>1</prim_range>
	<predir></predir>
	<prim_name>CALLE LOS ANGELES </prim_name>
	<addr_suffix></addr_suffix>
	<postdir></postdir>
	<unit_desig></unit_desig>
	<sec_range></sec_range>
	<p_city_name></p_city_name>
	<st></st>
	<z5>00603</z5>
	<zip4></zip4>
</row>
<row>
	<acctno>2HRIHIT</acctno>
	<prim_range>601</prim_range>
	<predir></predir>
	<prim_name>AVE MIRAMAR</prim_name>
	<addr_suffix></addr_suffix>
	<postdir></postdir>
	<unit_desig></unit_desig>
	<sec_range></sec_range>
	<p_city_name></p_city_name>
	<st></st>
	<z5>00612</z5>
	<zip4></zip4>
</row>
<row>
	<acctno>3NOhit</acctno>
	<prim_range>212</prim_range>
	<predir>E</predir>
	<prim_name>10th</prim_name>
	<addr_suffix>st</addr_suffix>
	<postdir>W</postdir>
	<unit_desig>W</unit_desig>
	<sec_range>W</sec_range>
	<p_city_name>new york</p_city_name>
	<st>ny</st>
	<z5>10003</z5>
	<zip4>10003</zip4>
</row>
<row>
	<acctno>4fraud_flagHit</acctno>
	<prim_range>98</prim_range>
	<predir></predir>
	<prim_name>exchange</prim_name>
	<addr_suffix>st</addr_suffix>
	<postdir></postdir>
	<unit_desig></unit_desig>
	<sec_range></sec_range>
	<p_city_name></p_city_name>
	<st></st>
	<z5>01013</z5>
	<zip4></zip4>
</row>
<row>
	<acctno>5fraud_flagHit</acctno>
	<prim_range>233</prim_range>
	<predir></predir>
	<prim_name>quincy</prim_name>
	<addr_suffix>st</addr_suffix>
	<postdir></postdir>
	<unit_desig></unit_desig>
	<sec_range></sec_range>
	<p_city_name></p_city_name>
	<st></st>
	<z5>01109</z5>
	<zip4></zip4>
</row>
</dataset>
*/