/*--SOAP--
<message name = "GovPhonesService">
	<part name = 'BDID' type = 'xsd:unsignedInt'/>
</message>
*/
/*--INFO-- This Service Searches the Gov Phones file by BDID */

export Gov_Phones_BDID_Service() := macro

unsigned6	bd := 0 : stored('BDID');

typeof(govdata.key_gov_phones_bdid) get_by_bdid(govdata.key_gov_phones_bdid L) := transform
	self := l;
end;

outf := project(govdata.key_gov_phones_bdid(bdid = bd),get_by_bdid(LEFT));

output(choosen(outf,all),named('RESULTS'));

endmacro;