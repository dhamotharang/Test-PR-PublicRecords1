IMPORT doxie_cbrs;

doxie_cbrs.mac_Selection_Declare()

EXPORT Internet_Domains_records_trimmed(DATASET(doxie_cbrs.layout_references) bdids) :=
MODULE



int_records := doxie_cbrs.Internet_Domains_records(bdids)(Include_InternetDomains_val);

doxie_cbrs.layouts.internet_domains_slim_record int_recs_slimmed(int_records l) := TRANSFORM
  SELF := l;
END;

SHARED dedup_domains := DEDUP(SORT(PROJECT(int_records,int_recs_slimmed(LEFT)),domain_name),ALL);

EXPORT records := CHOOSEN(dedup_domains, Max_InternetDomains_val);
EXPORT records_count := COUNT(dedup_domains);
END;
