doxie_cbrs.mac_Selection_Declare()
export Internet_Domains_records_max(dataset(doxie_cbrs.layout_references) bdids) := 
	choosen(doxie_cbrs.Internet_Domains_records_prs(bdids)(Return_InternetDomains_val), Max_InternetDomains_val);