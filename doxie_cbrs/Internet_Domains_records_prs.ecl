import ut;

export Internet_Domains_records_prs(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

dr := doxie_cbrs.Internet_Domains_records(bdids);

rec := record
	dr.level;
	dr.bdid;
	dr.domain_name;
	dr.create_date_decode
end;

ut.MAC_Slim_Back(dr, rec, drs)
	
s := sort(drs, level, domain_name, -(integer)create_date_decode, bdid);
d := dedup(s, level, domain_name, create_date_decode, bdid);
	
return d;
END;