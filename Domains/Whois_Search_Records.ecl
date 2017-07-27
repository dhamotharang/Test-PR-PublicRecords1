import doxie, business_header;

business_header.doxie_MAC_Field_Declare();

string45	domain := '' : stored('DomainName');

dids := if ((lname_value != '' or did_value != '' or search_by_idl_value),doxie.get_dids());
bdids := if (comp_name_value != '',business_header.doxie_get_bdids()) +
		if (bdid_val != '', bdid_dataset);

domain_val := stringlib.stringtouppercase(domain);

layout_whois_base get_by_did(dids L, domains.Key_Whois_Did R) := transform
	self := R;
end;

layout_whois_base get_by_bdid(bdids L, domains.key_whois_bdid R) := transform
	self := R;
end;

layout_whois_base get_by_domain(domains.Key_Whois_Domain L) := transform
	self := L;
end;

bydid := join(dids,domains.Key_Whois_Did, left.did = right.d,get_by_did(LEFT,RIGHT));
bybdid := join(bdids,domains.Key_Whois_Bdid, left.bdid = right.bdid,get_by_bdid(LEFT,RIGHT));
bydomain := project(domains.Key_Whois_Domain(dn = domain_val),get_by_domain(LEFT));

alltogether := (bydid + bybdid + bydomain)
    (dateVal = 0 OR (unsigned3)(date_first_seen[1..6]) <= dateVal);

export Whois_Search_Records := dedup(alltogether,whole record,all);