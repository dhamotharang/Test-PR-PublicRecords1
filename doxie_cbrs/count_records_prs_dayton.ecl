IMPORT doxie, doxie_cbrs;
doxie_cbrs.mac_Selection_Declare()

EXPORT count_records_prs_dayton(DATASET(doxie_cbrs.layout_references) bdids,
                                doxie.IDataAccess mod_access
                                ) := FUNCTION

	RETURN doxie_cbrs.all_base_records_source(bdids, mod_access)[1].SOURCE_COUNTS;
	
END;