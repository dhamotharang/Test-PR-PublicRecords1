doxie_cbrs.MAC_Selection_Declare()
EXPORT bankruptcy_v2_records_prs_max(DATASET(doxie_cbrs.layout_references) bdids) :=
  CHOOSEN(doxie_cbrs.bankruptcy_v2_records(bdids)(Return_Bankruptcies_val), Max_Bankruptcies_val);
