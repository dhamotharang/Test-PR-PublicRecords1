IMPORT doxie, doxie_cbrs;
doxie_cbrs.mac_Selection_Declare()
EXPORT Associated_Business_records_prs_max(DATASET(doxie_cbrs.layout_references) bdids,
                                           doxie.IDataAccess mod_access) :=
  CHOOSEN(doxie_cbrs.Associated_Business_records_prs(bdids,mod_access)(Return_AssociatedBusinesses_val), max_AssociatedBusinesses_val);
