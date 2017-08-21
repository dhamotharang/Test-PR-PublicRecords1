import ut, Business_Header;

// Append associated companies by Group ID
abn_amro_init := abn_amro_c2btest_addr_gid_append;

layout_gid_list := record
abn_amro_init.group_id;
end;

// Select records with confidence_level 3 generated from address BDID matching
abn_amro_gid_list := table(abn_amro_init(group_id <> 0, confidence_level = 4), layout_gid_list);
abn_amro_gid_list_dedup := dedup(abn_amro_gid_list, all);

// Get corresponding Group IDs for associated companies
bhg := Business_Header.File_Super_Group;

abn_amro_gid_bdid_list := join(bhg,
                               abn_amro_gid_list_dedup,
						 left.group_id = right.group_id,
						 transform(Business_Header.Layout_BH_Super_Group, self := left),
						 hash);
						 
// Match contact names from associated group businesses						 
bc := Business_Header.File_Business_Contacts;

layout_bc_slim := record
unsigned6 group_id := 0;
bc.bdid;
bc.company_title;   // Title of Contact at Company if available
bc.fname;
bc.mname;
bc.lname;
bc.name_suffix;
end;

bc_slim := table(bc(bdid <> 0, did = 0, from_hdr = 'N'), layout_bc_slim);
bc_slim_dedup := dedup(bc_slim, all);

// Select contacts using bdids of associated companies
bc_select := join(bc_slim,
                  abn_amro_gid_bdid_list,
			   left.bdid = right.bdid,
			   transform(layout_bc_slim, self.group_id := right.group_id, self := left),
			   hash);

bc_select_dist := distribute(bc_select, hash(group_id, bdid));
bc_select_sort := sort(bc_select_dist, group_id, bdid, lname, mname, fname, name_suffix, ut.TitleRank(company_title), local);
bc_select_dedup := dedup(bc_select_sort, group_id, bdid, lname, mname, fname, name_suffix, local);

// Append BDID of associated companies with matching contact names to original records
Layout_ABN_AMRO_C2BTest_Base AppendBDID(abn_amro_init l, layout_bc_slim r) := transform
self.bdid := r.bdid;
self.confidence_level := if(r.bdid <> 0, 6, l.confidence_level);
self.contact_title := r.company_title;
self.contact_fname := r.fname;
self.contact_mname := r.mname;
self.contact_lname := r.lname;
self.contact_name_suffix := r.name_suffix;
self := l;
end;

abn_amro_bdid_append := join(abn_amro_init(group_id <> 0),
                             bc_select_dedup,
					    left.group_id = right.group_id and
					      ut.NameMatch(left.fname, left.mname, left.lname, right.fname, right.mname, right.lname) < 3 and
						 ut.NNEQ(left.name_suffix, right.name_suffix),
					    AppendBDID(left, right),
					    left outer,
					    hash);
					    
abn_amro_bdid_append_dist := distribute(abn_amro_bdid_append, hash(seq, group_id, bdid));
abn_amro_bdid_append_sort := sort(abn_amro_bdid_append_dist, seq, group_id, bdid, ut.TitleRank(contact_title), local);
abn_amro_bdid_append_dedup := dedup(abn_amro_bdid_append_sort, seq, group_id, bdid, local);

// Append Best Information
bhb := Business_Header.File_Business_Header_Best;

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
					    
// Combine with Previous Records
abn_amro_combined := abn_amro_init + abn_amro_best_append;
abn_amro_combined_dist := distribute(abn_amro_combined, hash(seq));
abn_amro_combined_sort := sort(abn_amro_combined_dist, seq, -bdid, confidence_level, local);
abn_amro_combined_dedup := dedup(abn_amro_combined_sort,
                                 left.seq = right.seq and
						   (left.bdid = right.bdid or
						     right.bdid = 0),
						   local);

abn_amro_combine_gid_sort := sort(abn_amro_combined_dedup, seq, confidence_level, group_id, bdid)  : persist('TMTEST::abn_amro_c2btest_phone_gid_append');

export abn_amro_c2btest_phone_gid_append := abn_amro_combine_gid_sort;
