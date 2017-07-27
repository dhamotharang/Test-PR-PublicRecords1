/*--SOAP--
<message name = 'ORWorkersCompService'>
	<part name = "BDID" type = "xsd:unsignedInt"/>
</message>
*/
/*--INFO-- This service searches the OR Workers Comp File by BDID. */

export OR_workers_comp_BDID_Service() := macro

unsigned6 bd := 0 : stored ('BDID');

typeof(govdata.key_OR_workers_comp_BDID) get_by_bdid(govdata.key_OR_workers_comp_BDID L) := transform
	self := l;
end;

outf := project(govdata.key_OR_workers_comp_bdid(bdid = bd), get_by_bdid(LEFT));

output(choosen(outf,all),named('RESULTS'));

endmacro;