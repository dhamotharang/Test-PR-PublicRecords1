/*--SOAP--
<message name="MFinReportService">
	<part name="VID" type='xsd:string'/>
	<part name="DID" type='xsd:string'/>
	<part name="MilitaryBranch" type='xsd:string'/>
</message>
*/
/*--INFO-- This service returns one MFind Record.*/

export MFindReportService := macro


output(MFind_services.MFindReport, named('Results'));

endmacro;