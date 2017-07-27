/*--SOAP--
<message name = 'WHOISBDIDService'>
	<part name = 'BDID' type = 'xsd:string'/>
</message>
*/
/*--INFO-- This service searches the whois file by BDID. */

export WHOIS_BDID_Service() := macro

string14	bd_val := '' : stored('BDID');
unsigned6	bd := (integer)bd_val;

typeof(domains.Key_Whois_Bdid) get_by_bdid(domains.Key_Whois_Bdid L) := transform
	self := L;
end;

outf := project(domains.Key_Whois_Bdid(bdid = bd), get_by_bdid(LEFT));

output(choosen(outf,all),named('RESULTS'));

endmacro;
