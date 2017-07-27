/*--SOAP--
<message name = 'Vickers_InsiderFiling_Service'>
	<part name = 'BDID' type = 'xsd:string'/>
</message>
*/
/*--INFO-- This service searches the Vickers Insider Filing file by BDID. */

export Vickers_InsiderFiling_BDID_Service() := macro

string14	bd_val := '' : stored('BDID');
unsigned6	bd := (integer)bd_val;

typeof(vickers.Key_Insider_Filing_BDID) get_by_bdid(vickers.Key_Insider_Filing_BDID L) := transform
	self := L;
end;

outf := project(vickers.Key_Insider_Filing_BDID(bdid = bd), get_by_bdid(LEFT));

output(choosen(outf,all),named('RESULTS'));

endmacro;
