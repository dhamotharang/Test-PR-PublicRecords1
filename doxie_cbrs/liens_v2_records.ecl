import LiensV2_Services,doxie_cbrs_raw;
doxie_cbrs.MAC_Selection_Declare()

export liens_v2_records(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

needlj := (Include_LiensJudgments_val or Include_Liens_val or Include_Judgments_val or Include_LiensJudgmentsUCC_val) and
	JudgmentLienVersion in [0,2];
nn := max_Liens_val;

return doxie_cbrs_raw.Liens_v2(bdids,needlj, nn, ssn_mask_value, application_type_value).records;
END;
