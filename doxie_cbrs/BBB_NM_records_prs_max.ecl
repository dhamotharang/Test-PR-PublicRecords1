doxie_cbrs.mac_Selection_Declare()
EXPORT BBB_NM_records_prs_max(DATASET(doxie_cbrs.layout_references) bdids) :=
  CHOOSEN(doxie_cbrs.BBB_NM_records_prs(bdids), max_bbb_Val);
