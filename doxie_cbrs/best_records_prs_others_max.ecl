doxie_cbrs.mac_Selection_Declare()
export best_records_prs_others_max(dataset(doxie_cbrs.layout_references) bdids) := 
	choosen(doxie_cbrs.best_records_prs_others(bdids), max_AssociatedBusinesses_val);