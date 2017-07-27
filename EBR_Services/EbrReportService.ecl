/*--SOAP--
<message name="EbrSearchService">
  
  <part name="BDID" 				type="xsd:string"/>
  <part name="FileNumber" 				type="xsd:string"/>
    
</message>
*/
/*--INFO-- This service searches the Experian Business Reports files.*/


export EbrReportService() := macro

output(EBR_Services.report, named('Results'));

ENDMACRO;




