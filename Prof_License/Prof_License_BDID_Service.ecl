/*--SOAP--
<message name = 'ProfLicenseBDIDService'>
	<part name = 'BDID' type = 'xsd:string'/>
</message>
*/
/*--INFO-- This Service searches the Professional Licenses File by BDID. */

export Prof_License_BDID_Service() := macro

string14	bd_val := '' : stored('BDID');
unsigned6	bdid_val := (integer)bd_val;

typeof(prof_license.key_proflic_bdid) get_by_bdid(prof_license.key_proflic_bdid L) := transform
	self := l;
end;

outf := project(prof_license.key_proflic_bdid(bd = bdid_val), get_by_bdid(LEFT));

output(choosen(outf,all),named('RESULTS'));

endmacro;
