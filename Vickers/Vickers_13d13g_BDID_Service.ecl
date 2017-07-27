/*--SOAP--
<message name = 'Vickers_13d13g_Service'>
	<part name = 'BDID' type = 'xsd:string'/>
</message>
*/
/*--INFO-- This service searches the Vickers 13d/13g file by BDID. */

export Vickers_13d13g_BDID_Service() := macro

string14	bd_val := '' : stored('BDID');
unsigned6	bd := (integer)bd_val;

typeof(vickers.Key_13d13g_BDID) get_by_bdid(vickers.Key_13d13g_BDID L) := transform
	self := L;
end;

outf := project(vickers.Key_13d13g_BDID(bdid = bd), get_by_bdid(LEFT));

output(choosen(outf,all),named('RESULTS'));

endmacro;
