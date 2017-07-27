/*--SOAP--
<message name = "IRS5500Service">
	<part name = 'BDID' type = 'xsd:unsignedInt'/>
</message>
*/
/*--INFO-- This service searches the IRS5500 files by BDID */

export irs5500_bdid_service() := macro

unsigned6	bd := 0 : stored('BDID');

typeof(irs5500.key_irs5500_BDID) get_by_bdid(irs5500.key_irs5500_BDID L) := transform
	self := L;
end;

outf := project(irs5500.key_irs5500_BDID(bdid = bd), get_by_bdid(LEFT));

output(choosen(outf,all),named('RESULTS'));

endmacro;
