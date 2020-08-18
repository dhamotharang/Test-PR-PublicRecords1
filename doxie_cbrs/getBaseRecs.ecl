IMPORT Census_data, doxie, business_header, Business_Header_SS,drivers,ut;
doxie_cbrs.mac_Selection_Declare()

ut.mac_slim_back(bdid_dataset,doxie_cbrs.layout_references,wla);

EXPORT getBaseRecs := fn_getBaseRecs(wla,FALSE);
