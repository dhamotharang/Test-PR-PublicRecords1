/*--SOAP--
<message name="FCCReportService">
  <part name="FCCID" type="xsd:unsignedInt"/>
  <part name="DID"   type="xsd:string"/>
  <part name="BDID"  type="xsd:string"/>
	<part name="ApplicationType"     	type="xsd:string"/>
</message>
*/
/*--INFO-- Returns FCC source/doc (full report) records.*/

EXPORT FCCReportService := MACRO

  import doxie, doxie_cbrs,AutoStandardI;

  // by did
  string did_val := '' : stored('DID');
  unsigned6 did := (unsigned6) did_val;
  dids := dataset([{did}], doxie.layout_references);

  ids_by_did := FCC_Services.raw.get_ids_from_dids (dids);

  // by bdid
  string bdid_val := '' : stored('BDID');
  unsigned6 bdid := (unsigned6) bdid_val;
  bdids := dataset([{bdid}], doxie_cbrs.layout_references);

  ids_by_bdid := FCC_Services.raw.get_ids_from_bdids (bdids);

  // by sequence number
  unsigned6 fcc_seq := 0 : stored ('FCCID');
	appType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));

  // get all together
  all_ids := IF (fcc_seq != 0, DATASET ([{fcc_seq}], FCC_Services.layouts.id)) +
             IF (did != 0, ids_by_did) + 
             IF (bdid != 0, ids_by_bdid);
  
  res := FCC_Services.raw.SOURCE_VIEW.by_id (all_ids, appType);
  // TODO: sorting?
  output (SORT (res, fcc_seq), named('Results'));

ENDMACRO;
