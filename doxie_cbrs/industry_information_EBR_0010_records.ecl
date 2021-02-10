IMPORT doxie_cbrs, dx_ebr;

EXPORT industry_information_EBR_0010_records(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION
  // Max number of records per bdid is ~250 according to testing.
  key_recs := dx_EBR.Get.Header_0010_By_Bdid(bdids, atmost_number := 500);
  RETURN key_recs(record_type='C');
END;
