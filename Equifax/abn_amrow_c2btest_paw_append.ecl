import ut, Business_Header;

// Append associated companies from PAW using DID and Name-Address
abn_amro_init := abn_amro_c2btest_prep;
/*
layout_did_addr := record
abn_amro_init.seq;
abn_amro_init.did;
abn_amro_init.zip;
abn_amro_init.prim_name;
abn_amro_init.prim_range;
abn_amro_init.fname;
abn_amro_init.mname;
abn_amro_init.lname;
abn_amro_init.name_suffix;
end;

abn_amro_did_addr := table(abn_amro_init, layout_did_addr);
abn_amro_did_addr_dedup := dedup(abn_amro_did_addr, all);
*/

// Use People at Work not from direct business records
paw_init := Business_Header.File_Business_Contacts_Stats(combined_score > 6, from_hdr <> 'N', company_name <> '');

layout_paw_slim := record
paw_init.did;
paw_init.bdid;
string10 contact_prim_range := paw_init.prim_range;
string28 contact_prim_name := paw_init.prim_name;
string5  contact_zip := if(paw_init.zip <> 0, intformat(paw_init.zip, 5, 1), '');
string4  contact_addr_suffix := paw_init.addr_suffix;
string8  contact_sec_range := paw_init.sec_range;
string35 company_title := paw_init.company_title;   // Title of Contact at Company if available
string20 contact_fname := paw_init.fname;
string20 contact_mname := paw_init.mname;
string20 contact_lname := paw_init.lname;
string5  contact_name_suffix := paw_init.name_suffix;
string120 company_name := paw_init.company_name;
string10 prim_range := paw_init.company_prim_range;
string2   predir := paw_init.company_predir;
string28 prim_name := paw_init.company_prim_name;
string4  addr_suffix := paw_init.company_addr_suffix;
string2   postdir := paw_init.company_postdir;
string5  unit_desig := paw_init.company_unit_desig;
string8  sec_range := paw_init.company_sec_range;
string25 city := paw_init.company_city;
string2   state := paw_init.company_state;
string5 zip := if(paw_init.company_zip <> 0, intformat(paw_init.company_zip, 5, 1), '');
string4 zip4 := if(paw_init.company_zip4 <> 0, intformat(paw_init.company_zip4, 4, 1), '');
string10 phone := if(paw_init.company_phone <> 0 and paw_init.company_phone < 10000000000, intformat(paw_init.company_phone, 10, 1), '');
string9 fein := if(paw_init.company_fein <> 0, intformat(paw_init.company_fein, 9, 1), '');
end;

paw_slim := table(paw_init, layout_paw_slim);

// Append associated companies with matching contact names to original records
os(STRING s) := IF(s = '', '', TRIM(s) + ' ');

Layout_ABN_AMRO_C2BTest_Base AppendPAW(paw_slim l, abn_amro_init r) := transform
self.bdid := l.bdid;
self.confidence_level := 7;
self.contact_title := l.company_title;
self.contact_fname := l.contact_fname;
self.contact_mname := l.contact_mname;
self.contact_lname := l.contact_lname;
self.contact_name_suffix := l.contact_name_suffix;
self.best_CompanyName := l.company_name;
self.best_addr1 := 
			os(l.prim_range) + 
			os(l.predir) + 
			os(l.prim_name) +
			os(l.addr_suffix) +
			os(l.postdir) +
				if(ut.tails(l.prim_name, os(l.unit_desig) + os(l.sec_range)),
					'',
					os(l.unit_desig) + os(l.sec_range));
self.best_city := l.city;
self.best_state := l.state;
self.best_zip := l.zip;
self.best_zip4 := l.zip4;
self.best_phone := l.phone;
self.best_fein := l.fein;
self := r;
end;

// Append PAW by DID
paw_did_append := join(paw_slim(did <> 0),
                       abn_amro_init(did <> 0),
				   left.did = right.did,
				   AppendPAW(left, right),
				   hash);
				   
// Append PAW by Name-Address
paw_name_addr_append := join(paw_slim(contact_zip <> '', contact_prim_name <> ''),
                             abn_amro_init(zip <> '', prim_name <> ''),
					    left.contact_zip = right.zip and
					      left.contact_prim_name = right.prim_name and
						 left.contact_prim_range = right.prim_range and
					      left.contact_sec_range = right.sec_range and
						 ut.NNEQ(left.contact_addr_suffix, right.addr_suffix) and
					      ut.NameMatch(left.contact_fname, left.contact_mname, left.contact_lname, right.fname, right.mname, right.lname) < 3 and
						 ut.NNEQ(left.contact_name_suffix, right.name_suffix),
				         AppendPAW(left, right),
				         hash);

paw_append := paw_did_append + paw_name_addr_append;
paw_append_dedup := dedup(paw_append, all);

// Append Best Information for BDID
bhb := Business_Header.File_Business_Header_Best;

Layout_ABN_AMRO_C2BTest_Base AppendBest(Layout_ABN_AMRO_C2BTest_Base l, bhb r) := transform
self.best_CompanyName := r.company_name;

self.best_addr1 := 
			os(r.prim_range) + 
			os(r.predir) + 
			os(r.prim_name) +
			os(r.addr_suffix) +
			os(r.postdir) +
				if(ut.tails(r.prim_name, os(r.unit_desig) + os(r.sec_range)),
					'',
					os(r.unit_desig) + os(r.sec_range));
self.best_city := r.city;
self.best_state := r.state;
self.best_zip := if(r.zip = 0, '', intformat(r.zip, 5, 1));
self.best_zip4 := if(r.zip4 <> 0, intformat(r.zip4, 4, 1), '');

self.best_phone := if(r.phone <> 0, intformat(r.phone, 10, 1), '');
self.best_fein := if(r.fein <> 0, intformat(r.fein, 9, 1), '');
self := l;
end;

abn_amro_best_append := join(paw_append_dedup(bdid <> 0),
                             bhb,
					    left.bdid = right.bdid,
					    AppendBest(left, right),
					    left outer,
					    hash);
					    
// Append group ids
bhg := Business_Header.File_Super_Group;

abn_amro_append_gid := join(paw_append_dedup(bdid = 0) + abn_amro_best_append,
                             bhg,
					    left.bdid = right.bdid,
					    transform(Layout_ABN_AMRO_C2BTest_Base, self.group_id := right.group_id, self := left),
					    left outer,
					    hash);

// Combine with Previous Records
abn_amro_combined := abn_amro_c2btest_phone_gid_append + abn_amro_append_gid;
abn_amro_combined_dist := distribute(abn_amro_combined, hash(seq));
abn_amro_combined_sort := sort(abn_amro_combined_dist, seq, -bdid, if(confidence_level <> 0, 0, 1), confidence_level, best_CompanyName, local);
abn_amro_combined_dedup := dedup(abn_amro_combined_sort,
                                 left.seq = right.seq and
						   (left.bdid = right.bdid or
						     (right.bdid = 0 and right.confidence_level = 0) or
							(right.bdid = 0 and right.confidence_level = 7 and left.best_CompanyName = right.best_CompanyName)),
						   local);

abn_amro_combine_gid_sort := sort(abn_amro_combined_dedup, seq, confidence_level, group_id, bdid)  : persist('TMTEST::abn_amro_c2btest_paw_append');


export abn_amrow_c2btest_paw_append := abn_amro_combine_gid_sort;