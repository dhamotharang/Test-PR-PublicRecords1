IMPORT doxie, business_header;
doxie_cbrs.mac_Selection_Declare()

EXPORT Corporation_Filings_records_prs_max(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION
  r := doxie_cbrs.Corporation_Filings_records_prs(bdids);

  RETURN CHOOSEN(r, Max_CorporationFilings_val);
END;
