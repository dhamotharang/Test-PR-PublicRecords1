doxie_cbrs.mac_Selection_Declare()

export UCC_Records_prs_max(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

s := sort(doxie_cbrs.UCC_Records_prs(bdids), level, debtor_name, secured_name, -filing_date, bdid, ucc_key);

return choosen(s, Max_UCCFilings_val);
END;