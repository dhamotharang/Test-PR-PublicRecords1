IMPORT ut;

EXPORT Internet_Domains_records_prs(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

dr := doxie_cbrs.Internet_Domains_records(bdids);

rec := RECORD
  dr.level;
  dr.bdid;
  dr.domain_name;
  dr.create_date_decode
END;

ut.MAC_Slim_Back(dr, rec, drs)
  
s := SORT(drs, level, domain_name, -(INTEGER)create_date_decode, bdid);
d := DEDUP(s, level, domain_name, create_date_decode, bdid);
  
RETURN d;
END;
