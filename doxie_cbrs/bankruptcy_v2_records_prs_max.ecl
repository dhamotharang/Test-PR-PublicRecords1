doxie_cbrs.MAC_Selection_Declare()
export bankruptcy_v2_records_prs_max(dataset(doxie_cbrs.layout_references) bdids) := 
	choosen(doxie_cbrs.bankruptcy_v2_records(bdids)(Return_Bankruptcies_val), Max_Bankruptcies_val);