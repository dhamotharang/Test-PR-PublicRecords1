IMPORT dx_ebr;

EXPORT industry_information_EBR_5600_records(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION
  // Max number of records per bdid is ~250 according to testing.
  key_recs := dx_EBR.Get.Demographic_5600_By_Bdid(bdids, atmost_number := 500);
  RETURN key_recs(record_type='C');
END;
