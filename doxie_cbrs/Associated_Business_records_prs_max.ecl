import doxie, business_header;
doxie_cbrs.mac_Selection_Declare()
export Associated_Business_records_prs_max(dataset(doxie_cbrs.layout_references) bdids) := 
	choosen(doxie_cbrs.Associated_Business_records_prs(bdids)(Return_AssociatedBusinesses_val), max_AssociatedBusinesses_val);