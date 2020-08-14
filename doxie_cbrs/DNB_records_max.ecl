 IMPORT doxie, doxie_cbrs;
doxie_cbrs.mac_Selection_Declare()
EXPORT DNB_records_max(DATASET(doxie_cbrs.layout_references) bdids, doxie.IDataAccess mod_access) := 
	doxie_cbrs.DNB_records(bdids, mod_access)(Return_DunBradstreetRecords_val);