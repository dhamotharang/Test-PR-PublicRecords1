doxie_cbrs.mac_Selection_Declare()
export proflic_records_prs_max(dataset(doxie_cbrs.layout_references) bdids) := 
	choosen(doxie_cbrs.proflic_records_prs(bdids)(Return_ProfessionalLicenses_val), Max_ProfessionalLicenses_val);
	//renamed