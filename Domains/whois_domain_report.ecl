/*--SOAP--
<message name="DomainReport" wuTimeout="300000">
	<part name="BDID" type='xsd:string'/>
	<part name="MaxResults" type = 'xsd:unsignedInt'/>
	<part name="MaxResultsThisTime" type='xsd:unsignedInt'/>
	<part name="SkipRecords" type='xsd:unsignedInt'/>
</message>
*/
/*--INFO-- This service searches The WHOIS datafiles.*/
import doxie;

export whois_domain_report() := macro

doxie.MAC_Header_Field_Declare();

df := domains.Whois_Search_Records;

justname := record
	df.domain_name;
end;

df2 := table(df,justname);

doxie.MAC_Marshall_Results(df2,outf);

output(outf,named('Results'));

endmacro;

