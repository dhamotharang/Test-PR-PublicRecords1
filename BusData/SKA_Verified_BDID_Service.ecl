/*--SOAP--
<message name = 'SKAVerifiedBDIDService'>
	<part name = "BDID" type = 'xsd:string'/>
</message>
*/
/*--INFO-- This service searches the SKA Verified file by bdid. */

export SKA_Verified_BDID_Service() := macro

string14	bd_val := '' : stored('BDID');
unsigned6	bd := (integer)bd_val;

typeof(busdata.Key_SKA_Verified_BDID) get_by_bdid(busdata.Key_SKA_Verified_BDID L) := transform
	self := l;
end;

outf := project(busdata.Key_SKA_Verified_BDID(bdid = bd), get_by_bdid(LEFT));

output(choosen(outf,all),named('RESULTS'));

endmacro;