/*--SOAP--
<message name = 'MSWorkersCompService'>
	<part name = "BDID" type = "xsd:unsignedInt"/>
</message>
*/
/*--INFO-- This service searches the MS Workers Comp File by BDID. */

export ms_workers_comp_BDID_Service() := macro

unsigned6 bd := 0 : stored ('BDID');

typeof(govdata.key_ms_workers_comp_BDID) get_by_bdid(govdata.key_ms_workers_comp_BDID L) := transform
	self := l;
end;

outf := project(govdata.key_ms_workers_comp_bdid(bdid = bd), get_by_bdid(LEFT));

output(choosen(outf,all),named('RESULTS'));

endmacro;