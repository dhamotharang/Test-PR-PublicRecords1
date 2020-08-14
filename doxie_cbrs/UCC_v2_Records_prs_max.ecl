IMPORT doxie,business_header;

doxie_cbrs.MAC_Selection_Declare()

EXPORT UCC_v2_Records_prs_max(DATASET(doxie_cbrs.layout_references) bdids) :=
  CHOOSEN( doxie_cbrs.UCC_v2_Records(bdids)(Return_UCCFilings_val), Max_UCCFilings_val );
