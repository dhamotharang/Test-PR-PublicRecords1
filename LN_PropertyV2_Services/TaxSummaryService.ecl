/*--SOAP--
<message name="Iphone">
	<part name="Zip"	type="xsd:string"/>
</message>
*/
import LN_PropertyV2;

export TaxSummaryService := macro

	string5 zip_val := '' : stored('zip');
	
	k := LN_PropertyV2.key_tax_summary;
	res := k(keyed(zip = zip_val));
	
	output(res, named('Results'));
	
endmacro;