/*--SOAP--
<message name="CalbusReportService">
  <part name="AccountNumber"  type="xsd:string"/>
  <part name="BDID"  type="xsd:string"/>
</message>
*/
/*--INFO-- Californian businesses tax permit report*/

EXPORT CalbusReportService := MACRO

  // ids by bdid
  string bdid_val := '' : stored('BDID');
  unsigned6 bdid := (unsigned6) bdid_val;
  bdids := dataset([{bdid}], doxie_cbrs.layout_references);

  ids_by_bdid := CALBUS_Services.raw.get_ids_from_bdids (bdids);

  // ids from input
  string account_number := '' : stored('AccountNumber');

  all_ids := IF (account_number != '', DATASET ([{account_number}], CALBUS_Services.layouts.id)) +
             IF (bdid != 0, ids_by_bdid);
  
  res := CALBUS_Services.raw.SOURCE_VIEW.by_id (all_ids);

  // TODO: sorting?
  output (SORT (res, OWNER_NAME), named('Results'));

ENDMACRO;
