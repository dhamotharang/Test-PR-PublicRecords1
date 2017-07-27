export Internet_Domains_records_trimmed(dataset(doxie_cbrs.layout_references) bdids) := 
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

shared dedup_domains := dedup(sort(project(int_records,int_recs_slimmed(LEFT)),domain_name),ALL);

doxie_cbrs.mac_Selection_Declare()
export records := choosen(dedup_domains,Max_InternetDomains_val);
export records_count := count(dedup_domains);
END;