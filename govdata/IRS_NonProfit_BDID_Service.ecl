/*--SOAP--
<message name = "IRSNonProfitService">
	<part name = 'BDID' type = 'xsd:unsignedInt'/>
</message>
*/
/*--INFO-- This Service Searches the IRS NonProfit file by BDID */

export IRS_NonProfit_BDID_Service() := macro

unsigned6	bd := 0 : stored('BDID');

typeof(govdata.key_irs_nonprofit_bdid) get_by_bdid(govdata.key_irs_nonprofit_bdid L) := transform
	self := l;
end;

outf := project(govdata.key_irs_nonprofit_bdid(bdid = bd),get_by_bdid(LEFT));

output(choosen(outf,all),named('RESULTS'));

endmacro;
