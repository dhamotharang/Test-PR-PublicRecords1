doxie_cbrs.mac_Selection_Declare()
export DNB_records_max(dataset(doxie_cbrs.layout_references) bdids, doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := 
	doxie_cbrs.DNB_records(bdids, mod_access)(Return_DunBradstreetRecords_val);