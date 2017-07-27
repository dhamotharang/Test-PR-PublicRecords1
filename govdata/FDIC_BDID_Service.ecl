/*--SOAP--
<message name = "FDICBDIDService">
	<part name = "BDID" type = 'xsd:unsignedInt'/>
</message>
*/
/*--INFO-- This service searches the FDIC file by BDID */

export FDIC_BDID_Service() := macro

unsigned6	bd := 0 : stored('BDID');

typeof(govdata.key_fdic_bdid) get_by_bdid(govdata.key_fdic_bdid L) := transform
	self := l;
end;

outf := project(govdata.key_fdic_bdid(bdid = bd), get_by_bdid(LEFT));

output(choosen(outf,all),named('RESULTS'));

endmacro;
