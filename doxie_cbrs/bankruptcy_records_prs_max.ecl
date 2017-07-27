import doxie, business_header;
doxie_cbrs.mac_Selection_Declare()
export bankruptcy_records_prs_max(dataset(doxie_cbrs.layout_references) bdids) := 
	choosen(doxie_cbrs.bankruptcy_records_prs(bdids)(Return_Bankruptcies_val), Max_Bankruptcies_val);