doxie_cbrs.mac_Selection_Declare()
export others_at_address_records_max(dataset(doxie_cbrs.layout_references) bdids) := 
	choosen(doxie_cbrs.others_at_address_records(bdids)(Return_BusinessesAtAddress_val), max_BusinessesAtAddress_val);