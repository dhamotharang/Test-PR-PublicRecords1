IMPORT doxie_cbrs;

//ids = abi_number for USABIZ (unique)
EXPORT layouts.SourceOutput usabiz_report_records () := FUNCTION

  // Get DEADCO business by abi and/or bdid

  string bdid_val := '' : stored('BDID');
  unsigned6 bdid := (unsigned6) bdid_val;
  bdids := dataset([{bdid}], doxie_cbrs.layout_references);

  ids_by_bdid := USAbizV2_Services.raw.get_ids_from_bdids (bdids);

  string9 abi_val := '' : stored('ABI');

  all_ids := IF (abi_val != '', DATASET ([{abi_val}], USAbizV2_Services.layouts.id)) +
             IF (bdid != 0, ids_by_bdid);

  res := USAbizV2_Services.raw.SOURCE_VIEW.by_id (all_ids);
  
  // additional processing here.
  return res;
END;

