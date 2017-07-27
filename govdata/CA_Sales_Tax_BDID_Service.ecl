/*--SOAP--
<message name = 'CASalesTaxService'>
	<part name = 'BDID' type = 'xsd:unsignedInt'/>
</message>
*/
/*--INFO-- This service searches the CA Sales Tax file by BDID. */

export CA_Sales_Tax_BDID_Service() := macro

	unsigned6	bd := 0 : stored('BDID');
	
	typeof(govdata.key_ca_sales_tax_bdid) get_by_bdid(govdata.key_ca_sales_tax_bdid L) := transform
		self := l;
	end;
	
	outf := project(govdata.key_ca_sales_tax_bdid(bdid = bd),get_by_bdid(LEFT));
	
	output(choosen(outf,all),named('RESULTS'));
	
	endmacro;
	