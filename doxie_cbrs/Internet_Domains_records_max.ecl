doxie_cbrs.mac_Selection_Declare()
EXPORT Internet_Domains_records_max(DATASET(doxie_cbrs.layout_references) bdids) :=
  CHOOSEN(doxie_cbrs.Internet_Domains_records_prs(bdids)(Return_InternetDomains_val), Max_InternetDomains_val);
