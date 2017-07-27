/*--SOAP--
<message name="FBNReportService">
  <part name="TMSID" 							type="xsd:string"/>
  <part name="RMSID" 							type="xsd:string"/>
  <part name="BDID" 				type="xsd:string"/>
  <part name="DID" 				type="xsd:string"/>
</message>
*/
/*--INFO-- This service returns one FBN record.*/

export FBNReportService := Macro

#constant('isSearch',FALSE)

output(FBNV2_services.FBNReport, named('Results'));

endmacro;