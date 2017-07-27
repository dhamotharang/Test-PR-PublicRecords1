/*--SOAP--
<message name = "IASalesTaxService">
	<part name = 'BDID' type = 'xsd:unsignedInt'/>
</message>
*/
/*--INFO-- This service searches the IA Sales Tax file by BDID. */

export IA_SalesTax_BDID_Service() := macro

unsigned6	bd := 0 : stored('BDID');

typeof(govdata.Key_IA_SalesTax_BDID) get_by_bdid(govdata.Key_IA_SalesTax_BDID L) := transform
	self := L;
end;

outf := project(govdata.Key_IA_SalesTax_BDID(bdid = bd),get_by_bdid(LEFT));

output(choosen(outf,all),named('RESULTS'));

endmacro;
