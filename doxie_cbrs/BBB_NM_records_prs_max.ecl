doxie_cbrs.mac_Selection_Declare()
export BBB_NM_records_prs_max(dataset(doxie_cbrs.layout_references) bdids) := 
	choosen(doxie_cbrs.BBB_NM_records_prs(bdids), max_bbb_Val);