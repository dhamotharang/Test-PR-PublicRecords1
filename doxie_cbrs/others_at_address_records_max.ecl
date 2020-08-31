doxie_cbrs.mac_Selection_Declare()
EXPORT others_at_address_records_max(DATASET(doxie_cbrs.layout_references) bdids) :=
  CHOOSEN(doxie_cbrs.others_at_address_records(bdids)(Return_BusinessesAtAddress_val), max_BusinessesAtAddress_val);
