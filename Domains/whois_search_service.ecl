/*--SOAP--
<message name="DomainSearch" wuTimeout="300000">
	<part name="CompanyName" type='xsd:string'/>
	<part name="UnParsedFullName" type="xsd:string"/>
	<part name="FirstName" type='xsd:string'/>
	<part name="MiddleName" type='xsd:string'/>
	<part name="LastName" type = 'xsd:string'/>
	<part name="AllowNicknames" type = 'xsd:boolean'/>
	<part name="PhoneticMatches" type = 'xsd:boolean'/>
	<part name="DomainName" type = 'xsd:string'/>
	<part name="Addr" type='xsd:string'/>
	<part name="City" type="xsd:string" />
	<part name="State" type='xsd:string'/>
	<part name="ZipCode" type = 'xsd:string'/>
	<part name = 'BDID'			type = 'xsd:string'/>
	<part name = 'DID'			type = 'xsd:string'/>
	<part name = 'GLBPurpose'	type = 'xsd:byte'/>
	<part name = 'DPPAPurpose'	type = 'xsd:byte'/>
	<part name="MaxResults" type = 'xsd:unsignedInt'/>
	<part name="MaxResultsThisTime" type='xsd:unsignedInt'/>
	<part name="SkipRecords" type='xsd:unsignedInt'/>
</message>
*/
/*--INFO-- This service searches The WHOIS datafiles.*/
import doxie;

export whois_search_service() := macro

doxie.MAC_Header_Field_Declare();

foo := domains.Whois_Search_Records;

doxie.MAC_Marshall_Results(foo,outf);

output(outf,named('Results'));

endmacro;
