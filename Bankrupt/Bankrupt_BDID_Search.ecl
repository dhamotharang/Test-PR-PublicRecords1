/*--SOAP--
<message name = "BankruptBDIDSearch">
	<part name = "BDID" type = "xsd:unsignedInt"/>
</message>
*/
/*--INFO-- This service searches the bankruptcy files by bdid */

import doxie_files,bankrupt;

export Bankrupt_BDID_Search() := macro

unsigned6	bdid := 0 : stored('BDID');

typeof(bankrupt.key_bankrupt_bdid) get_key(bankrupt.key_bankrupt_bdid L) := transform
	self := l;
end;

df := project(bankrupt.key_bankrupt_bdid(bd = bdid), get_key(LEFT));

typeof(doxie_files.key_bkrupt_full) get_fullrecs(df L, doxie_files.key_bkrupt_full R) := transform
	self := R;
end;

outf := join(df,doxie_files.key_bkrupt_full, keyed(left.case_number = right.s_casenum) and
					keyed(left.court_code = right.s_courtcode) and
					keyed(left.seq_number = right.s_seqnumber),
					get_fullrecs(LEFT,RIGHT));

output(outf,named('RESULTS'));

endmacro;
