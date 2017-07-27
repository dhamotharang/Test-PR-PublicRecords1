/*--SOAP--
<message name = 'DEA_BDIDService'>
	<part name = 'BDID' type = 'xsd:string'/>
</message>
*/
/*--INFO-- This service searches the DEA file by BDID. */

export DEA_BDID_Service() := macro

string14	bd_val := '' : stored('BDID');
unsigned6	bdid := (integer)bd_val;

typeof(dea.Key_DEA_Bdid) get_by_bdid(dea.Key_DEA_Bdid L) := transform
	self := L;
end;

outf := project(dea.Key_DEA_Bdid(bd = bdid), get_by_bdid(LEFT));

output(choosen(outf,all),named('RESULTS'));

endmacro;
