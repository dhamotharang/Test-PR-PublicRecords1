import doxie,business_header;
doxie_cbrs.MAC_Selection_Declare()
export liens_v2_records_prs_max(dataset(doxie_cbrs.layout_references) bdids) := 
	choosen(doxie_cbrs.liens_v2_records(bdids)(Return_Liens_val), Max_Liens_val);