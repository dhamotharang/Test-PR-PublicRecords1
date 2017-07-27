import doxie_cbrs_Raw;
doxie_cbrs.mac_Selection_Declare()

raw := doxie_cbrs_Raw.EBR_Header(Include_EBRHeader_val, Max_EBRHeader_val).records;

export EBR_Header_records_prs := raw;