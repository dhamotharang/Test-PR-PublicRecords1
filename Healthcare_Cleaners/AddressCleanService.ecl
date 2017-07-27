/*--SOAP--
<message name="AddressCleanService">
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>	
	<part name="IncludeHRI" 					type="xsd:boolean"/> 		
	<part name="IncludeFlags"					type="xsd:boolean"/> 		
</message>
*/
/*--INFO--
<pre>
This service will return a set of cleaned records.

</pre>
*/

EXPORT AddressCleanService := MACRO
	batch_in_layout := Healthcare_Cleaners.Layouts.rawAddressInput;
	boolean HRI := false : STORED('IncludeHRI');
	boolean Flags := false : STORED('IncludeFlags');
	ds_batch_in_stored := DATASET([], batch_in_layout) : STORED('batch_in', FEW);
	results := project(ds_batch_in_stored,Transform(Healthcare_Cleaners.Layouts.cleanAddressOutput,
																					cln:=Healthcare_Cleaners.Functions.doAddressClean(left,HRI,Flags);
																					self := cln[1];));
	ut.mac_TrimFields(results, 'results', fmtResults);
	output(fmtResults, named('Results'));
ENDMACRO;