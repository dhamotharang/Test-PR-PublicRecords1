IMPORT doxie, doxie_cbrs;

EXPORT best_records_prs_target(DATASET(doxie_cbrs.layout_references) bdids,
                               doxie.IDataAccess mod_access) :=
  doxie_cbrs.best_records_prs(bdids,mod_access)(bdid = doxie_cbrs.subject_BDID);
