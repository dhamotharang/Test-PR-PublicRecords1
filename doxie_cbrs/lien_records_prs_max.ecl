IMPORT doxie,business_header;
doxie_cbrs.MAC_Selection_Declare()
EXPORT lien_records_prs_max(DATASET(doxie_cbrs.layout_references) bdids) :=
  CHOOSEN(doxie_cbrs.lien_records_prs(bdids)(Return_Liens_val), Max_Liens_val);
