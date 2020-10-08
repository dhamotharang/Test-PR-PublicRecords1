IMPORT UCCv2_Services, doxie_cbrs_raw;
doxie_cbrs.MAC_Selection_Declare()

EXPORT UCC_v2_Records(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

  needUCC := Include_UCCFilings_val AND UccVersion IN [0,2];
  nn := Max_UCCFilings_val;

  RETURN doxie_cbrs_raw.UCC_v2(bdids,needUCC, nn, ssn_mask_value).records;
END;
