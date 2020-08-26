IMPORT doxie, business_header;
doxie_cbrs.mac_Selection_Declare()

EXPORT property_records_prs_byAddress_max(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

pr := doxie_cbrs.property_records_prs_byAddress(bdids);
RETURN CHOOSEN(pr(Return_Properties_val), Max_Properties_val);
END;
