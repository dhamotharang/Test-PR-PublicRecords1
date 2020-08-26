EXPORT property_records_prs_byBDID(DATASET(doxie_cbrs.layout_references) bdids) :=
  doxie_cbrs.property_records_prs(bdids)(byBDID);
