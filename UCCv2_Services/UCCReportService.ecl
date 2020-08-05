/*--SOAP--
<message name="UCCReportService">

  <part name="DID" type="xsd:string"/>
  <part name="BDID" type="xsd:string"/>
  <part name="TMSID" type="xsd:string"/>
  <part name="SSNMask" type="xsd:string"/>
  <part name="ApplicationType" type="xsd:string"/>
  <part name="ReturnMultiplePages" type="xsd:boolean"/>

</message>
*/
/*--INFO-- This service returns one UCC Record. */

EXPORT UCCReportService() := MACRO

#STORED('IncludeMultipleSecured', TRUE);
#STORED('ReturnRolledDebtors', TRUE);

#CONSTANT('getBdidsbyExecutive',FALSE);
#CONSTANT('usehigherlimit',TRUE);

BOOLEAN return_multiple_pgs := FALSE : STORED('ReturnMultiplePages');

res := UCCv2_Services.UCCReportService_records(return_multiple_pgs);

OUTPUT(res, NAMED('Results'));

ENDMACRO;
