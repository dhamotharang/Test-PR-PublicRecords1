doxie_cbrs.mac_Selection_Declare()
export DNB_records_max(dataset(doxie_cbrs.layout_references) bdids) := 
	doxie_cbrs.DNB_records(bdids)(Return_DunBradstreetRecords_val);