import ut, Business_Header;

// Append associated companies by address
abn_amro_init := abn_amro_c2btest_gid_append;

// Extract list of addresses from test file
layout_addr := record
abn_amro_init.zip;
abn_amro_init.prim_name;
abn_amro_init.prim_range;
end;

addr_list := table(abn_amro_init(zip <> '', prim_name <> ''), layout_addr);
addr_list_dedup := dedup(addr_list, all);

// Try direct match of address to business contacts to get BDIDs
bc := Business_Header.File_Business_Contacts;

layout_bc_addr := record
unsigned6 bdid;
string5 zip;
string28 prim_name;
string10 prim_range;
end;

layout_bc_addr GetBCAddr(bc l) := transform
self.zip := intformat(l.zip, 5, 1);
self := l;
end;

bc_addr_init := project(bc(bdid <> 0, from_hdr = 'N', zip <> 0, prim_name <> ''), GetBCAddr(left));

bc_addr_list := join(bc_addr_init,
                     addr_list_dedup,
				 left.zip = right.zip and
				   left.prim_name = right.prim_name and
				   left.prim_range = right.prim_range,
				   transform(layout_bc_addr, self := left),
				   hash);

// Try direct match of address to business header best to get BDIDs
bhb := Business_Header.File_Business_Header_Best;

layout_bc_addr GetBHBAddr(bhb l) := transform
self.zip := intformat(l.zip, 5, 1);
self := l;
end;

bhb_addr_init := project(bhb(zip <> 0, prim_name <> ''), GetBHBAddr(left));

bhb_addr_list := join(bhb_addr_init,
                      addr_list_dedup,
				  left.zip = right.zip and
				    left.prim_name = right.prim_name and
				    left.prim_range = right.prim_range,
				  transform(layout_bc_addr, self := left),
				  hash);

addr_bdid_list := bc_addr_list + bhb_addr_list;
addr_bdid_list_dedup := dedup(addr_bdid_list, all);
				   
// Match contact names from associated businesses					 
layout_bc_slim := record
bc.bdid;
string5 zip := '';
string28 prim_name := '';
string10 prim_range := '';
bc.company_title;   // Title of Contact at Company if available
bc.fname;
bc.mname;
bc.lname;
bc.name_suffix;
end;

bc_slim := table(bc(bdid <> 0, from_hdr = 'N'), layout_bc_slim);
bc_slim_dedup := dedup(bc_slim, all);

// Select contacts using bdids of associated companies
bc_select := join(bc_slim,
                  addr_bdid_list_dedup,
			   left.bdid = right.bdid,
			   transform(layout_bc_slim, self.zip := right.zip, self.prim_name := right.prim_name,
			                             self.prim_range := right.prim_range, self := left),
			   hash);

// Append BDID of associated companies with matching contact names to original records
Layout_ABN_AMRO_C2BTest_Base AppendBDID(abn_amro_init l, layout_bc_slim r) := transform
self.bdid := r.bdid;
self.confidence_level := 3;
self.contact_title := r.company_title;
self.contact_fname := r.fname;
self.contact_mname := r.mname;
self.contact_lname := r.lname;
self.contact_name_suffix := r.name_suffix;
self := l;
end;

abn_amro_bdid_append := join(abn_amro_init(zip <> '', prim_name <> ''),
                             bc_select,
					    left.zip = right.zip and
					      left.prim_name = right.prim_name and
						 left.prim_range = right.prim_range and
					      ut.NameMatch(left.fname, left.mname, left.lname, right.fname, right.mname, right.lname) < 3 and
						 ut.NNEQ(left.name_suffix, right.name_suffix),
					    AppendBDID(left, right),
					    left outer,
					    hash);

abn_amro_bdid_append_dist := distribute(abn_amro_bdid_append, hash(seq, bdid));
abn_amro_bdid_append_sort := sort(abn_amro_bdid_append_dist, seq, bdid, ut.TitleRank(contact_title), local);
abn_amro_bdid_append_dedup := dedup(abn_amro_bdid_append_sort, seq, bdid, local);

// Append Best Information
os(STRING s) := IF(s = '', '', TRIM(s) + ' ');

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

abn_amro_best_append := join(abn_amro_bdid_append_dedup,
                             bhb,
					    left.bdid = right.bdid,
					    AppendBest(left, right),
					    left outer,
					    hash);
					    
// Append group ids
bhg := Business_Header.File_Super_Group;

abn_amro_append_gid := join(abn_amro_best_append,
                             bhg,
					    left.bdid = right.bdid,
					    transform(Layout_ABN_AMRO_C2BTest_Base, self.group_id := right.group_id, self := left),
					    left outer,
					    hash);
					    
// Combine with Previous Records
abn_amro_combined := abn_amro_init + abn_amro_append_gid;
abn_amro_combined_dist := distribute(abn_amro_combined, hash(seq));
abn_amro_combined_sort := sort(abn_amro_combined_dist, seq, -bdid, confidence_level, local);
abn_amro_combined_dedup := dedup(abn_amro_combined_sort,
                                 left.seq = right.seq and
						   (left.bdid = right.bdid or
						     right.bdid = 0),
						   local);

abn_amro_combine_gid_sort := sort(abn_amro_combined_dedup, seq, confidence_level, group_id, bdid)  : persist('TMTEST::abn_amro_c2btest_addr_append');



export abn_amro_c2btest_addr_append := abn_amro_combine_gid_sort;