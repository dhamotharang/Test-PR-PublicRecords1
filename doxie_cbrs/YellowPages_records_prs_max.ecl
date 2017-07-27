doxie_cbrs.mac_Selection_Declare()
export YellowPages_records_prs_max(dataset(doxie_cbrs.layout_references) bdids) := 
	choosen(doxie_cbrs.YellowPages_records_prs(bdids), Max_YellowPages_val);