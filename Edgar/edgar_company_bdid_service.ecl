/*--SOAP--
<message name = "EdgarCompanyService">
	<part name = "BDID" type = "xsd:unsignedInt"/>
</message>
*/
/*--INFO-- This service searches the edgar company file by bdid */

export edgar_company_bdid_service() := macro

unsigned6	bd := 0 : stored('BDID');

typeof(edgar.key_edgar_company_bdid) get_by_bdid(edgar.key_edgar_company_bdid L) := transform
	self := L;
end;

outf := project(edgar.key_edgar_company_bdid(bdid = bd),get_by_bdid(LEFT));

output(choosen(outf,all),named('RESULTS'));

endmacro;
