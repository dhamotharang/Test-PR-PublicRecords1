import ut, Address, Header, Header_Slimsort, didville, DID_Add;

Layout_Whois_Temp := record
string73 clean_name;
Layout_Whois_Base;
end;

// DID the Whois File
Layout_Whois_Temp InitDomains(Layout_Whois_Base l) := transform
self.clean_name := addrcleanlib.cleanPerson73(L.registrant_name);
self := l;
end;

domains_init := project(whois_bdid, InitDomains(left));

Layout_Whois_Name := record
unsigned6 uid := 0;
unsigned1 did_score := 0;
Layout_Whois_Base;
end;

Layout_Whois_Name InitNames(Layout_Whois_Temp l) := transform
self.title := l.clean_name[1..5];
self.fname := l.clean_name[6..25];
self.mname := l.clean_name[26..45];
self.lname := l.clean_name[46..65];
self.name_suffix := l.clean_name[66..70];
self.name_score := l.clean_name[71..73];
self := l;
end;

domains_names := project(domains_init, InitNames(left));

ut.MAC_Sequence_Records(domains_names, uid, domains_names_seq)

domains_names_seq_namezip := domains_names_seq((integer)zip <> 0 and lname <> '' and (integer)name_score > 85);
domains_names_seq_nonamezip := domains_names_seq(not((integer)zip <> 0 and lname <> '' and (integer)name_score > 85));


Name_Matchset := ['A'];

DID_Add.MAC_Match_Flex(domains_names_seq_namezip, Name_Matchset,
	 ssn_field, dob_field, fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip, state, phone_field,
	 did,
	 Layout_Whois_Name, 
	 TRUE, did_score,
	 75,
	 domains_did_init)
	 
domains_did_combined := domains_did_init + domains_names_seq_nonamezip;

// dedup, keep highest score	 
domains_did_dist := distribute(domains_did_combined, hash(uid));
domains_did_sort := sort(domains_did_dist, uid, if(did <> 0, 0, 1), -did_score, local);
domains_did_dedup := dedup(domains_did_sort, uid, local);

Layout_Whois_Base FormatDIDBase(Layout_Whois_Name l) := transform
self := l;
end;

domains_did_base := project(domains_did_dedup, FormatDIDBase(left));

export whois_did := domains_did_base : persist('TEMP::whois_did');