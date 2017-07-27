import doxie, business_header;
doxie_cbrs.mac_Selection_Declare()

export property_records_prs_byAddress_max(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

pr := doxie_cbrs.property_records_prs_byAddress(bdids); 
return choosen(pr(Return_Properties_val), Max_Properties_val);
END;
