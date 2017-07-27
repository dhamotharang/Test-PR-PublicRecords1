/*--SOAP--
<message name = "BusRegCompanyService">
	<part name = "BDID" type = "xsd:unsignedInt"/>
</message>
*/
/*--INFO-- This Service Searches the BusReg Company File by BDID */


export BusReg_Company_BDID_Service() := macro

unsigned6	bd := 0 : stored('BDID');

typeof(busreg.key_busreg_company_bdid) get_by_bdid(busreg.key_busreg_company_bdid L) := transform
	self := l;
end;

outf := project(busreg.key_busreg_company_bdid(bdid = bd), get_by_bdid(LEFT));

output(choosen(outf,all),named('RESULTS'));

endmacro;
