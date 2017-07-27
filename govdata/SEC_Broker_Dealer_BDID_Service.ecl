/*--SOAP--
<message name = "SECBrokerDealerService">
	<part name = 'BDID' type = 'xsd:unsignedInt'/>
</message>
*/
/*--INFO-- This service searches the SEC Broker/Dealer file by BDID. */

export SEC_Broker_Dealer_BDID_Service() := macro

unsigned6	bd := 0 : stored('BDID');

typeof(govdata.key_sec_broker_dealer_bdid) get_by_bdid(govdata.key_sec_broker_dealer_BDID L) := transform
	self := L;
end;

outf := project(govdata.key_sec_broker_dealer_bdid(bdid = bd), get_by_bdid(LEFT));

output(choosen(outf,all),named('RESULTS'));

endmacro;
