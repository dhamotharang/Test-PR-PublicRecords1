EXPORT Internet_Domains_records_trimmed(DATASET(doxie_cbrs.layout_references) bdids) :=
MODULE

doxie_cbrs.mac_Selection_Declare()

int_records := doxie_cbrs.Internet_Domains_records(bdids)(Include_InternetDomains_val);

int_rec := RECORD
  int_records.bdid;
  int_records.domain_name;
END;

int_rec int_recs_slimmed(int_records l) := TRANSFORM
  SELF := l;
END;

SHARED dedup_domains := DEDUP(SORT(PROJECT(int_records,int_recs_slimmed(LEFT)),domain_name),ALL);

doxie_cbrs.mac_Selection_Declare()
EXPORT records := CHOOSEN(dedup_domains,Max_InternetDomains_val);
EXPORT records_count := COUNT(dedup_domains);
END;
