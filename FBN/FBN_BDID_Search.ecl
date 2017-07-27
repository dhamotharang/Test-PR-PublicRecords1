/*--SOAP--
<message name = 'FBNBDIDSearch'>
	<part name = 'BDID' type = 'xsd:unsignedInt'/>
</message>
*/
/*--INFO-- This Service Searches the FBN Dataset by BDID */

export FBN_BDID_Search() := macro

unsigned6	bd := 0 : stored('BDID');

typeof(fbn.key_fbn_bdid) get_by_bdid(fbn.key_fbn_bdid L) := transform
	self := L;
end;

outf := project(fbn.key_fbn_bdid(bdid = bd),get_by_bdid(LEFT));

output(choosen(outf,all),named('RESULTS'));

endmacro;