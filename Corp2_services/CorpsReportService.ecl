/*--SOAP--
<message name="CorpsReportService">
	<part name="CharterNumber" type='xsd:string'/>
	<part name="State" type='xsd:string'/>
  <part name="BDID"  type="xsd:string"/>
	<part name="CorpKey" type="xsd:string"/>
	<part name="LatestForMAs" type="xsd:boolean"/>
	<part name="ReturnMultiplePages" type="xsd:boolean"/>
	<part name="ApplicationType"     	type="xsd:string"/>
    
</message>
*/
/*--INFO-- This service returns one corp Record.*/

import doxie_cbrs;

export CorpsReportService := macro

BOOLEAN return_multiple_pages := FALSE : STORED('ReturnMultiplePages');
output(Corp2_services.CorpReport(return_multiple_pages), named('Results'));

endmacro;