doxie_cbrs.mac_Selection_Declare()
export BBB_records_prs_max(dataset(doxie_cbrs.layout_references) bdids) := 
	choosen(doxie_cbrs.BBB_records_prs(bdids)(return_BBB_val), max_BBB_val);