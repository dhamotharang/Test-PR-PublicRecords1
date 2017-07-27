doxie_cbrs.mac_Selection_Declare()
export Associated_Business_byContact_records_max(dataset(doxie_cbrs.layout_references) bdids) := 
	choosen(doxie_cbrs.Associated_Business_byContact_records(bdids)(Return_AssociatedBusinesses_val), max_AssociatedBusinesses_val);