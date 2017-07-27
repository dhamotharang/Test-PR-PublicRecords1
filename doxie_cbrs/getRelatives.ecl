export getRelatives(unsigned6 thebdid) := 
	doxie_cbrs.getRelatives_ds(dataset([{thebdid}], doxie_cbrs.layout_references));