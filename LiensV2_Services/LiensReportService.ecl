// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================

/*--INFO-- This service returns one lien.*/


EXPORT LiensReportService() := MACRO
  #CONSTANT('getBdidsbyExecutive',FALSE);
  #CONSTANT('usehigherlimit',TRUE);

  BOOLEAN return_multiple_pgs := FALSE : STORED('ReturnMultiplePages');
  BOOLEAN include_criminalIndicators := FALSE : STORED('IncludeCriminalIndicators');
  doxie.MAC_Header_Field_Declare();

  did := (UNSIGNED6)did_value;
  dids := DATASET([{did}], doxie.layout_references);
  bydid := liensv2_services.liens_raw.get_tmsids_from_dids(dids);

  bdid := business_header.stored_bdid_value;
  bdids := DATASET([{bdid}], doxie_cbrs.layout_references);
  bybdid := liensv2_services.liens_raw.get_tmsids_from_bdids(bdids);

  tmsids_input_all :=
    IF(tmsid_value <> '', DATASET([{tmsid_value}],liensv2_services.layout_tmsid)) +
    IF(did > 0, bydid) +
    IF(bdid > 0, bybdid);

  isCSMR := ut.IndustryClass.is_Knowx;
  tmsids := tmsids_input_all(~LiensV2_Services.Functions.isRestricted(isCSMR, tmsid));

  res := liensv2_services.liens_raw.report_view.by_tmsid( in_tmsids := tmsids,
                                                        in_ssn_mask_type := ssn_mask_value,
                                                        return_multiple_pages := return_multiple_pgs,
                                                        appType:=application_type_value,
                                                        includeCriminalIndicators := include_criminalIndicators);

  OUTPUT(res, NAMED('Results'));

ENDMACRO;




