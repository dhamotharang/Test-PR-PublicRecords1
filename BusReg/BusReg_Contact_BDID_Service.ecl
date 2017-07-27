/*--SOAP--
<message name = "BusRegContactService">
	<part name = "BDID" type = "xsd:unsignedInt"/>
</message>
*/
/*--INFO-- This Service Searches the BusReg Contacts File by BDID */


export BusReg_Contact_BDID_Service() := macro

unsigned6	bd := 0 : stored('BDID');

typeof(busreg.key_busreg_contact_bdid) get_by_bdid(busreg.key_busreg_contact_bdid L) := transform
	self := l;
end;

outf := project(busreg.key_busreg_contact_bdid(bdid = bd), get_by_bdid(LEFT));

output(choosen(outf,all),named('RESULTS'));

endmacro;
