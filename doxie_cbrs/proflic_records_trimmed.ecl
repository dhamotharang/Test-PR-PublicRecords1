IMPORT doxie_cbrs;
doxie_cbrs.mac_Selection_Declare()

EXPORT proflic_records_trimmed(DATASET(doxie_cbrs.layout_references) bdids) :=
MODULE

  pro_lics := doxie_cbrs.proflic_records_dayton(bdids)(Include_ProfessionalLicenses_val);

  SHARED pl_slim := PROJECT(pro_lics, doxie_cbrs.layout_proflic.slim_rec);

  EXPORT records := CHOOSEN(pl_slim, Max_ProfessionalLicenses_val);
  EXPORT records_count := COUNT(pl_slim);

END;
