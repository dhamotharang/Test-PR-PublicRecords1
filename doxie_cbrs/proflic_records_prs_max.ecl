IMPORT doxie,doxie_cbrs;
doxie_cbrs.mac_Selection_Declare()
EXPORT proflic_records_prs_max(DATASET(doxie_cbrs.layout_references) bdids,
                               doxie.IDataAccess mod_access) :=
  CHOOSEN(doxie_cbrs.proflic_records_prs(bdids,mod_access)(Return_ProfessionalLicenses_val), Max_ProfessionalLicenses_val);
  //renamed
