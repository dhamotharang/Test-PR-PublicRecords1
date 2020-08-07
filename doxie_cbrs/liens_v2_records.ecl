IMPORT LiensV2_Services,doxie_cbrs_raw;
doxie_cbrs.MAC_Selection_Declare()

EXPORT liens_v2_records(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

  needlj := (Include_LiensJudgments_val OR Include_Liens_val OR Include_Judgments_val OR Include_LiensJudgmentsUCC_val) AND
    JudgmentLienVersion IN [0,2];
  nn := max_Liens_val;

  RETURN doxie_cbrs_raw.Liens_v2(bdids,needlj, nn, ssn_mask_value, application_type_value).records;
END;
