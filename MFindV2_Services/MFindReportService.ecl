/*--SOAP--
<message name="MFinReportService">
	<part name="VID" type='xsd:string'/>
	<part name="DID" type='xsd:string'/>
	<part name="MilitaryBranch" type='xsd:string'/>
</message>
*/
/*--INFO-- This service returns one MFind Record.*/

export MFindReportService := macro


output(MFindV2_Services.MFindReport, named('Results'));

endmacro;