import doxie, business_header;
doxie_cbrs.mac_Selection_Declare()

export Corporation_Filings_records_prs_max(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION
	r := doxie_cbrs.Corporation_Filings_records_prs(bdids);

	return choosen(r, Max_CorporationFilings_val);
END;