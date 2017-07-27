doxie_cbrs.mac_Selection_Declare()
r := doxie_cbrs.EBR_Header_records_prs;

s := sort(r, level, company_name, -file_number);

export EBR_Header_records_prs_max := 
	choosen(s, max_ebrheader_val);