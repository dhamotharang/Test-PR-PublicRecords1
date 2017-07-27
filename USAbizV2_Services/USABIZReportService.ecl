/*--SOAP--
<message name="USABIZReportService">
  <part name="ABI"  type="xsd:string"/>
  <part name="BDID"  type="xsd:string"/>
</message>
*/
/*--INFO-- Returns USABIZ (InfoUSA) records.*/

EXPORT USABIZReportService := MACRO

  res := USAbizV2_Services.usabiz_report_records ();

  // TODO: sorting?
  output (SORT (res, bdid, COMPANY_NAME), named('Results'));

ENDMACRO;
