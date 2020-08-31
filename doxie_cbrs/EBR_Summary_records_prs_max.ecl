doxie_cbrs.mac_Selection_Declare()

EXPORT EBR_Summary_records_prs_max(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

r := doxie_cbrs.EBR_Summary_records_prs(bdids)(Return_EBRSummary_val);

s := SORT(r, level, bdid, -file_number);

RETURN CHOOSEN(s, max_ebrSummary_val);
END;
