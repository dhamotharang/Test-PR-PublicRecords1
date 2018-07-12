IMPORT doxie, business_header;
doxie_cbrs.mac_Selection_Declare()

EXPORT count_records_prs_dayton(DATASET(doxie_cbrs.layout_references) bdids, STRING6 SSNMask = 'NONE') := FUNCTION

	RETURN doxie_cbrs.all_base_records_source(bdids, SSNMask)[1].SOURCE_COUNTS;
	
END;