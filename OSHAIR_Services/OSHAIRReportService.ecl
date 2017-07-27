/*--SOAP--
<message name="USABIZReportService">
  <part name="ActivityNumber"  type="xsd:unsignedInt"/>
  <part name="BDID"  type="xsd:string"/>
</message>
*/
/*--INFO-- Returns OSHAIR source/doc (full report) records.*/

EXPORT OSHAIRReportService := MACRO

  import doxie_cbrs;
//  res := OSHAIR_Services.oshair_report_records ();


  string bdid_val := '' : stored('BDID');
  unsigned6 bdid := (unsigned6) bdid_val;
  bdids := dataset([{bdid}], doxie_cbrs.layout_references);

  ids_by_bdid := OSHAIR_Services.raw.get_ids_from_bdids (bdids);

  // internally, activity_number is an integer, it is a (zero padded) string10 in a client view only
  unsigned activity_val := 0 : stored('ActivityNumber');

  all_ids := IF (activity_val != 0, DATASET ([{activity_val}], OSHAIR_Services.layouts.id)) +
             IF (bdid != 0, ids_by_bdid);
  
  res := OSHAIR_Services.raw.SOURCE_VIEW.by_id (all_ids);
  // TODO: sorting?
  output (SORT (res, cname), named('Results'));

ENDMACRO;
