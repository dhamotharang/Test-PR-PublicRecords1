import doxie,business_header;
doxie_cbrs.MAC_Selection_Declare()
export judgement_records_prs_max(dataset(doxie_cbrs.layout_references) bdids) := 
	choosen(doxie_cbrs.judgement_records_prs(bdids)(Return_Judgments_val), Max_Judgments_val);