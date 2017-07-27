/*--SOAP--
<message name="DNBSearch" wuTimeout="300000">
	<part name="DunsNumber" type="xsd:string"/>
	<part name="ContactFirstName" type='xsd:string'/>
	<part name="ContactMiddleName" type='xsd:string'/>
	<part name="ContactLastName" type='xsd:string'/>
	<part name="Nicknames" type='xsd:boolean' />
	<part name="PhoneticMatches" type='xsd:boolean' />
	<part name="CompanyName" type='xsd:string'/>
	<part name="Addr" type='xsd:string'/>
	<part name="City" type="xsd:string" />
	<part name="State" type='xsd:string'/>
	<part name="ZipCode" type = 'xsd:string'/>
	<part name = 'BDID'			type = 'xsd:string'/>
	<part name = 'DID'			type = 'xsd:string'/>
	<part name = 'GLBPurpose'	type = 'xsd:byte'/>
	<part name = 'DPPAPurpose'	type = 'xsd:byte'/>
</message>
*/
/*--INFO-- This service searches the DnB datafiles.*/


export DNB_Search_Service := macro

dns := dnb.DNB_Search_Get_DunsNum : global;

base := dnb.dnb_records(dns);
cont := dnb.dnb_contacts_records(dns);

string20	lname := '' : stored('ContactLastName');

PrettyLayout := record
	base.duns_number;
	base.bdid;
	base.business_name;
	base.v_city_name;
	base.st;
	base.zip;
	base.record_type;
	base.active_duns_number;
	cont.exec_title;
	cont.exec_first_name;
	cont.exec_last_name;
end;

PrettyLayout into_out(base L, cont R) := transform
	self := L;
	self := R;
end;

PrettyLayout into_out2(base L) := transform
	self := L;
	self.exec_title := '';
	self.exec_first_name := '';
	self.exec_last_name := '';
end;

outf := dedup(if (lname = '', project(base,into_out2(LEFT)),
				join(base,cont,left.duns_number = right.duns_number,
				into_out(LEFT,RIGHT))),whole record,all);

output(choosen(outf,all),named('Results'));

endmacro;
