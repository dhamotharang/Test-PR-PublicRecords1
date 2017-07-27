IMPORT doxie_cbrs;

//ids = abi_number for DEADCO (unique)
EXPORT layouts.SourceOutput deadco_report_records () := FUNCTION

  // Get DEADCO business by abi and/or bdid

  string bdid_val := '' : stored('BDID');
  unsigned6 bdid := (unsigned6) bdid_val;
  bdids := dataset([{bdid}], doxie_cbrs.layout_references);

  ids_by_bdid := DeadcoV2_Services.Raw.get_ids_from_bdids (bdids);

  string9 abi_val := '' : stored('ABI');

  all_ids := IF (abi_val != '', DATASET ([{abi_val}], DeadcoV2_Services.layouts.id)) +
             IF (bdid != 0, ids_by_bdid);

  res := raw.SOURCE_VIEW.by_id (all_ids);
  
  // additional processing here.
  return res;
END;

