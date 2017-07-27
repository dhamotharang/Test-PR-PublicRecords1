/*--SOAP--
<message name = "EdgarContactsService">
	<part name = "BDID" type = "xsd:unsignedInt"/>
</message>
*/
/*--INFO-- This service searches the edgar contacts file by bdid */

export edgar_contacts_bdid_service() := macro

unsigned6	bd := 0 : stored('BDID');

typeof(edgar.key_edgar_contacts_bdid) get_by_bdid(edgar.key_edgar_contacts_bdid L) := transform
	self := L;
end;

outf := project(edgar.key_edgar_contacts_bdid(bdid = bd),get_by_bdid(LEFT));

output(choosen(outf,all),named('RESULTS'));

endmacro;
