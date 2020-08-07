doxie_cbrs.mac_Selection_Declare()
EXPORT Associated_Business_byContact_records_max(DATASET(doxie_cbrs.layout_references) bdids) :=
  CHOOSEN(doxie_cbrs.Associated_Business_byContact_records(bdids)(Return_AssociatedBusinesses_val), max_AssociatedBusinesses_val);
