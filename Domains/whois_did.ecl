import ut, Address, Header, Header_Slimsort, didville, DID_Add;

Layout_Whois_Name :=
record

	unsigned6 uid := 0;
	unsigned1 did_score := 0;
	Layout_Whois_Base_BIP; 
	string5  clean_admin_name_title				;
	string20 clean_admin_name_fname				;
	string20 clean_admin_name_mname				;
	string20 clean_admin_name_lname				;
	string5  clean_admin_name_name_suffix	;
	string3  clean_admin_name_name_score	;
	string1		name_type := 'R';	//should be 'A' or 'R'
  
end;
whois_bdid1 := project(whois_bdid,transform(Layout_Whois_Name,self:=left ;self:=[];));
// DID the Whois File
Layout_Whois_Name InitDomains1(Layout_Whois_Name l) :=transform

	//clean_registrant_name			:= Address.Clean_n_Validate_Name(L.registrant_name, 'L').CleanNameRecord;
	clean_admin_name					:= Address.Clean_n_Validate_Name(L.admin_name, 'L').CleanNameRecord;

	//self.uid													:= cnt;
	//self															:= clean_registrant_name;
	self.clean_admin_name_title				:= clean_admin_name.title			;
	self.clean_admin_name_fname				:= clean_admin_name.fname			;
	self.clean_admin_name_mname				:= clean_admin_name.mname			;
	self.clean_admin_name_lname				:= clean_admin_name.lname			;
	self.clean_admin_name_name_suffix	:= clean_admin_name.name_suffix;
	self.clean_admin_name_name_score	:= clean_admin_name.name_score	;
	self 															:= l;              
end;
Layout_Whois_Name InitDomains2(Layout_Whois_Name l, unsigned5 cnt) :=transform

	clean_registrant_name							:= Address.Clean_n_Validate_Name(L.registrant_name, 'L').CleanNameRecord;
	self.uid													:= cnt;
	self															:= clean_registrant_name;
	self 															:= l;              
end;

domains_init1 := nofold(project(nofold(whois_bdid1), InitDomains1(left)));

domains_init := nofold(project(nofold(domains_init1), InitDomains2(left,counter)));


domains_names_seq_namezip 	:= domains_init((integer)zip <> 0 and lname <> '' and (integer)name_score > 85);
domains_names_seq_nonamezip := domains_init(not((integer)zip <> 0 and lname <> '' and (integer)name_score > 85));

domains_names_seq_namezip_admin 	:= project(domains_init((integer)zip <> 0 			and clean_admin_name_lname <> '' and (integer)clean_admin_name_name_score > 85), transform(Layout_Whois_Name,self.name_type := 'A';self := left;));
domains_names_seq_nonamezip_admin := project(domains_init(not((integer)zip <> 0 and clean_admin_name_lname <> '' and (integer)clean_admin_name_name_score > 85)), transform(Layout_Whois_Name,self.name_type := 'A';self := left;));


Name_Matchset := ['A'];

DID_Add.MAC_Match_Flex(domains_names_seq_namezip, Name_Matchset,
	 ssn_field, dob_field, fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip, state, phone_field,
	 did,
	 Layout_Whois_Name, 
	 TRUE, did_score,
	 75,
	 domains_did_init_registrant)
	 
DID_Add.MAC_Match_Flex(domains_names_seq_namezip_admin, Name_Matchset,
	 ssn_field, dob_field, clean_admin_name_fname, clean_admin_name_mname, clean_admin_name_lname, clean_admin_name_name_suffix, 
	 prim_range, prim_name, sec_range, zip, state, phone_field,
	 did,
	 Layout_Whois_Name, 
	 TRUE, did_score,
	 75,
	 domains_did_init_admin)

domains_did_combined := domains_did_init_registrant + domains_names_seq_nonamezip + domains_did_init_admin + domains_names_seq_nonamezip_admin;

// dedup, keep highest score	 
domains_did_dist := distribute(domains_did_combined, hash(uid));
domains_did_sort := sort(domains_did_dist, uid, if(did <> 0, 0, 1), -did_score, local);
domains_did_dedup := dedup(domains_did_sort, uid, local);

Layout_Whois_Base_BIP FormatDIDBase(Layout_Whois_Name l) := transform

self.title 				:= if(l.name_type = 'R', l.title 			, l.clean_admin_name_title 			);
self.fname 				:= if(l.name_type = 'R', l.fname 			, l.clean_admin_name_fname 			);
self.mname 				:= if(l.name_type = 'R', l.mname 			, l.clean_admin_name_mname 			);
self.lname 				:= if(l.name_type = 'R', l.lname 			, l.clean_admin_name_lname 			);
self.name_suffix 	:= if(l.name_type = 'R', l.name_suffix	, l.clean_admin_name_name_suffix);
self.name_score 	:= if(l.name_type = 'R', l.name_score 	, l.clean_admin_name_name_score );
//Added for CCPA-357
self.global_sid   := l.global_sid;
self.record_sid   := l.record_sid;
                                                                                
self := l;

end;

domains_did_base := project(domains_did_dedup, FormatDIDBase(left));

export whois_did := domains_did_base : persist('TEMP::whois_did');
