IMPORT doxie, doxie_cbrs;

doxie_cbrs.mac_Selection_Declare()
EXPORT best_records_prs_others_max(DATASET(doxie_cbrs.layout_references) bdids,
                                   doxie.IDataAccess mod_access) := 
	CHOOSEN(doxie_cbrs.best_records_prs_others(bdids,mod_access), max_AssociatedBusinesses_val);