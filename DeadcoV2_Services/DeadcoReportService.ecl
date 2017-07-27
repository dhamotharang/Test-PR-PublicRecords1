/*--SOAP--
<message name="DeadcoReportService">
  <part name="ABI"  type="xsd:string"/>
  <part name="BDID"  type="xsd:string"/>
</message>
*/
/*--INFO-- DEADCO companies (InfoUSA) report*/

EXPORT DeadcoReportService := MACRO

  res := DeadcoV2_Services.deadco_report_records ();

  // TODO: sorting?
  output (SORT (res, bdid, COMPANY_NAME), named('Results'));

ENDMACRO;
