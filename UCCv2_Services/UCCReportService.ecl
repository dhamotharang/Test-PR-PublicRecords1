/*--SOAP--
<message name="UCCReportService">

  <part name="DID" 					       type="xsd:string"/>
  <part name="BDID" 				       type="xsd:string"/>
  <part name="TMSID" 				       type="xsd:string"/>
  <part name="SSNMask"			       type="xsd:string"/>
	<part name="ApplicationType" type="xsd:string"/>
	<part name="ReturnMultiplePages" type="xsd:boolean"/>

</message>
*/
/*--INFO-- This service returns one UCC Record. */

export UCCReportService() := macro

#STORED('IncludeMultipleSecured', true);
#STORED('ReturnRolledDebtors', true);

#constant('getBdidsbyExecutive',FALSE);
#constant('usehigherlimit',TRUE);

BOOLEAN return_multiple_pgs := FALSE : STORED('ReturnMultiplePages');

r := UCCv2_Services.UCCReportService_records(return_multiple_pgs);

output(r, named('Results'));

endmacro;
