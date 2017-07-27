import doxie,business_header;

doxie_cbrs.MAC_Selection_Declare()

export UCC_v2_Records_prs_max(dataset(doxie_cbrs.layout_references) bdids) := 
	choosen( doxie_cbrs.UCC_v2_Records(bdids)(Return_UCCFilings_val),	Max_UCCFilings_val );
