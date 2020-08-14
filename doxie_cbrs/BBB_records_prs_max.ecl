doxie_cbrs.mac_Selection_Declare()
EXPORT BBB_records_prs_max(DATASET(doxie_cbrs.layout_references) bdids) :=
  CHOOSEN(doxie_cbrs.BBB_records_prs(bdids)(return_BBB_val), max_BBB_val);
