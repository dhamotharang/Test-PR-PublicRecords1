doxie_cbrs.mac_Selection_Declare()

export EBR_Summary_records_prs_max(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

r := doxie_cbrs.EBR_Summary_records_prs(bdids)(Return_EBRSummary_val);

s := sort(r, level, bdid, -file_number);

return choosen(s, max_ebrSummary_val);
END;