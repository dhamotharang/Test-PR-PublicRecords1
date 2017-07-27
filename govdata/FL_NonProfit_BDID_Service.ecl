/*--SOAP--
<message name = "FLNonProfitService">
	<part name = 'BDID' type = "xsd:unsignedInt"/>
</message>
*/
/*--INFO-- This service searches the FL NonProfit Corp file by BDID. */

export FL_NonProfit_BDID_Service() := macro

unsigned6	bd := 0 : stored('BDID');

typeof(govdata.key_FL_NonProfit_BDID) get_by_bdid(govdata.key_FL_NonProfit_BDID L) := transform
	self := L;
end;

outf := project(govdata.key_FL_NonProfit_BDID(bdid = bd), get_by_bdid(LEFT));

output(choosen(outf,all),named('RESULTS'));

endmacro;