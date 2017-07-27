/*--SOAP--
<message name = 'FL_FBN_BDID_Service'>
	<part name = 'BDID' type = 'xsd:string'/>
</message>
*/
/*--INFO-- This service searches the FL FBN file by BDID. */

export FL_FBN_BDID_Service() := macro

string14	bd_val := '' : stored('BDID');
unsigned6	bd := (integer)bd_val;

typeof(govdata.key_fl_fbn_bdid) get_by_bdid(govdata.Key_FL_FBN_BDID L) := transform
	self := L;
end;

outf := project(govdata.Key_FL_FBN_BDID(bdid = bd), get_by_bdid(LEFT));

output(choosen(outf,all),named('RESULTS'));

endmacro;