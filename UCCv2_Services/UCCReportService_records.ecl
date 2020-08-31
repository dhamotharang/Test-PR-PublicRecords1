IMPORT doxie, business_header, doxie_cbrs;

doxie.MAC_Header_Field_Declare()

EXPORT UCCReportService_records(BOOLEAN return_multiple_pages) := FUNCTION
  did := (UNSIGNED6)did_value;
  dids := DATASET([{did}], doxie.layout_references);
  bydid := UCCv2_Services.UCCRaw.get_tmsids_from_dids(dids,Party_Type);

  bdid := business_header.stored_bdid_value;
  bdids := DATASET([{bdid}], doxie_cbrs.layout_references);
  bybdid := UCCv2_Services.UCCRaw.get_tmsids_from_bdids(bdids,,Party_Type);

  tmsids :=
    IF(tmsid_value <> '', DATASET([{tmsid_value}],UCCv2_Services.layout_tmsid)) +
    IF(did > 0, bydid) +
    IF(bdid > 0, bybdid);

  r := UCCv2_Services.UCCRaw.source_view.by_tmsid(tmsids,ssn_mask_value, return_multiple_pages,application_type_value);

  results := PROJECT(r, TRANSFORM(RECORDOF(r), SELF.penalt:=(LEFT.penalt/uccPenalty.scale), SELF:=LEFT));
  
  RETURN results;

END;
