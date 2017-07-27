/*--SOAP--
<message name = 'FLAccidentBDIDService'>
	<part name = 'BDID' type = 'xsd:string'/>
</message>
*/
/*--INFO-- This service searches the Florida Accidents files by BDID. */

import doxie;

export FL_Accidents_BDID_Service() := macro

string14 bd_val := '' : stored('BDID');
unsigned6	bd := (integer)bd_val;

typeof(doxie.Key_Flcrash_Bdid) get_accident_nbrs(doxie.key_flcrash_bdid L) := transform
	self := L;
end;

mid1 := project(doxie.Key_Flcrash_Bdid(l_bdid = bd), get_accident_nbrs(LEFT));

typeof(doxie.Key_Flcrash_AccNbr) get_by_accnum(mid1 L, doxie.Key_Flcrash_AccNbr R) := transform
	self := R;
end;

outf := join(mid1, doxie.Key_Flcrash_AccNbr, (integer)left.accident_nbr = right.l_accnbr,
		get_by_accnum(LEFT,RIGHT));

output(choosen(outf,all),named('RESULTS'));

endmacro;
