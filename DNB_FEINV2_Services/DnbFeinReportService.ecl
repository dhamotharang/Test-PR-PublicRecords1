/*--SOAP--
<message name="DnbFeinReportService">
  <part name="BDID" 				type="xsd:string"/>
  <part name="TMSID" 				type="xsd:string"/>
</message>
*/
/*--INFO-- This service returns one DNB FEIN Record. */

export DnbFeinReportService(
	) :=
		macro

		output(
			DNB_FEINv2_Services.raw.source_view(),
			named('Results'));
		endmacro;
		