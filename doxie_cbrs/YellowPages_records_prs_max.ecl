doxie_cbrs.mac_Selection_Declare()
EXPORT YellowPages_records_prs_max(DATASET(doxie_cbrs.layout_references) bdids) :=
  CHOOSEN(doxie_cbrs.YellowPages_records_prs(bdids), Max_YellowPages_val);
