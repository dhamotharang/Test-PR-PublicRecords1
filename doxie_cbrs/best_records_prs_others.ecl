export best_records_prs_others(dataset(doxie_cbrs.layout_references) bdids) := 
	doxie_cbrs.best_records_prs(bdids)(bdid <> doxie_cbrs.subject_BDID);