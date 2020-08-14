IMPORT doxie, business_header;
doxie_cbrs.mac_Selection_Declare()
EXPORT bankruptcy_records_prs_max(DATASET(doxie_cbrs.layout_references) bdids) :=
  CHOOSEN(doxie_cbrs.bankruptcy_records_prs(bdids)(Return_Bankruptcies_val), Max_Bankruptcies_val);
