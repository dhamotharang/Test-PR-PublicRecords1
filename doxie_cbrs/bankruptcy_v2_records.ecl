import Bankruptcyv2_Services,doxie_cbrs_raw;
doxie_cbrs.MAC_Selection_Declare()

export bankruptcy_v2_records(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

needbk := Include_Bankruptcies_val;
nn := max_Bankruptcies_val;

return doxie_cbrs_raw.bankruptcy_v2(bdids,needbk, nn, ssn_mask_value).records;
END;