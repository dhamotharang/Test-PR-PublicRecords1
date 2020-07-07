/*--SOAP--
<message name="VotersReportService">
  <part name="DID" type="xsd:string"/>
  <part name="VTID" type="xsd:string"/>
  <part name="SSNMask" type="xsd:string"/>
  <part name="ApplicationType" type="xsd:string"/>
</message>
*/
/*--INFO-- This service returns voter's records.*/

EXPORT VotersReportService := MACRO

IMPORT votersV2_services, doxie;
  doxie.MAC_Header_Field_Declare();

  // Get voter's ID by DID, if given
  did := (UNSIGNED6) did_value;
  dids := DATASET ([{did}], doxie.layout_references);
  by_did := votersV2_services.raw.Get_vtids_from_dids (dids);

  // Get voter's ID
  STRING14 vtid_value := '' : STORED('VTID');

  // combine and fetch voter's data
  all_vtids := IF (vtid_value != '', DATASET ([{vtid_value}], VotersV2_Services.Layout_vtid)) +
               IF (did > 0, by_did);
  
  res := votersV2_services.raw.SOURCE_VIEW.by_vtid (all_vtids, ssn_mask_value,,application_type_value);

  // TODO: sorting?
  OUTPUT (SORT (res, -LastDateVote), NAMED('Results'));

ENDMACRO;
