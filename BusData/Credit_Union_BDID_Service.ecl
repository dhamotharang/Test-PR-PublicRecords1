/*--SOAP--
<message name = 'CreditUnionBDIDService'>
	<part name = 'BDID' type = 'xsd:string'/>
</message>
*/
/*--INFO-- This service searches the Credit Unions File by BDID. */

export Credit_Union_BDID_Service() := macro

string14	bd_val := '' : stored('BDID');
unsigned6	bd := (integer)bd_val;

typeof(busdata.key_credit_union_bdid) get_by_bdid(busdata.key_credit_union_bdid L) := transform
	self := L;
end;

outf := project(busdata.key_credit_union_bdid(bdid = bd), get_by_bdid(LEFT));

output(choosen(outf,all),named('RESULTS'));

endmacro;
