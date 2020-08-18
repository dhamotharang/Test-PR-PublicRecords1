IMPORT doxie, business_header;
doxie_cbrs.MAC_Selection_Declare()
EXPORT business_registration_records_prs_max(DATASET(doxie_cbrs.layout_references) bdids) := MODULE

SHARED all_recs :=
  doxie_cbrs.business_registration_records_prs(bdids)(Return_BusinessRegistrations_val);
EXPORT records := CHOOSEN(all_recs,Max_BusinessRegistrations_val);
EXPORT records_count := COUNT(all_recs);
END;
