/*--SOAP--
<message name="DNBSearch" wuTimeout="300000">
	<part name="DunsNumber" type="xsd:string"/>
	<part name="BDID" type = 'xsd:string'/>
</message>
*/
/*--INFO-- This service searches the DnB datafiles.*/


export DNB_Report_Service() := macro

dns := dnb.DNB_Search_Get_DunsNum : global;

output(choosen(dnb.dnb_records(dns),all),named('BaseRecords'));
output(choosen(dnb.dnb_contacts_records(dns),all),named('Contacts'));

endmacro;

