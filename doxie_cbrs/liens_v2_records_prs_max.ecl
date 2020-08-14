IMPORT doxie,business_header;
doxie_cbrs.MAC_Selection_Declare()
EXPORT liens_v2_records_prs_max(DATASET(doxie_cbrs.layout_references) bdids) :=
  CHOOSEN(doxie_cbrs.liens_v2_records(bdids)(Return_Liens_val), Max_Liens_val);
