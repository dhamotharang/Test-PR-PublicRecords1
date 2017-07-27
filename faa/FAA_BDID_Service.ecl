/*--SOAP--
<message name = 'FAABDIDService'>
	<part name = 'BDID' type = 'xsd:string'/>
</message>
*/
/*--INFO-- This Service searches the FAA file by BDID. */

export FAA_BDID_Service() := macro

string14 bd_val := '' : stored('BDID');
unsigned6	the_bdid := (integer)bd_val;

typeof(faa.Key_Aircraft_Reg_BDID) get_by_bdid(faa.Key_Aircraft_Reg_BDID L) := transform
	self := L;
end;

nnums := dedup(sort(project(faa.Key_Aircraft_Reg_BDID(bd = the_bdid), get_by_bdid(LEFT)),n_number),n_number);

typeof(faa.Key_Aircraft_Reg_NNum) get_from_nnums(nnums L, faa.Key_Aircraft_Reg_NNum R) := transform
	self := R;
end;

outf := join(nnums,faa.Key_Aircraft_Reg_NNum, keyed(left.n_number = right.n_number),
			get_from_nnums(LEFT,RIGHT));
			

output(choosen(outf((integer)bdid_out = the_bdid),all),named('RESULTS'));

endmacro;
