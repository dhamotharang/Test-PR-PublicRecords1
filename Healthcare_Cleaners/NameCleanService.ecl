/*--SOAP--
<message name="NameCleanService">
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>	
</message>
*/
/*--INFO--
<pre>
This service will return a set of cleaned records.

</pre>
*/

EXPORT NameCleanService := MACRO
	batch_in_layout := Healthcare_Cleaners.Layouts.rawNameInput;
	ds_batch_in_stored := DATASET([], batch_in_layout) : STORED('batch_in', FEW);
	results := project(ds_batch_in_stored,Transform(Healthcare_Cleaners.Layouts.cleanNameOutput,
																					cln:=Healthcare_Cleaners.Functions.doNameClean(left);
																					self := cln[1];));
	ut.mac_TrimFields(results, 'results', fmtResults);
	output(fmtResults, named('Results'));
ENDMACRO;
