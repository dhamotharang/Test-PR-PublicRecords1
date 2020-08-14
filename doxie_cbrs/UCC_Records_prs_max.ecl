doxie_cbrs.mac_Selection_Declare()

EXPORT UCC_Records_prs_max(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

  s := SORT(doxie_cbrs.UCC_Records_prs(bdids), level, debtor_name, secured_name, -filing_date, bdid, ucc_key);

  RETURN CHOOSEN(s, Max_UCCFilings_val);
END;
