import ut, Business_Header;

// Append associated companies by address
abn_amro_init := equifax.abn_amro_c2btest_addr_append;

// Extract list of phones from test file
layout_phone := record
abn_amro_init.phone10;
end;

phone_list := table(abn_amro_init((integer)phone10 <> 0), layout_phone);
phone_list_dedup := dedup(phone_list, all);

// Try direct match of phone to business contacts to get BDIDs
bc := Business_Header.File_Business_Contacts;

layout_bc_phone := record
unsigned6 bdid;
string10 phone10;
end;

layout_bc_phone GetBCPhone(bc l) := transform
self.phone10 := intformat(l.phone, 10, 1);
self := l;
end;

bc_phone_init := project(bc(bdid <> 0, from_hdr = 'N', phone <> 0 and phone < 10000000000), GetBCPhone(left));
bc_phone_init_dedup := dedup(bc_phone_init, all);

// Use contact phone
bc_phone_list := join(bc_phone_init_dedup,
                      phone_list_dedup,
				  left.phone10 = right.phone10,
				  transform(layout_bc_phone, self := left),
				  hash);

layout_bc_phone GetBCCompanyPhone(bc l) := transform
self.phone10 := intformat(l.company_phone, 10, 1);
self := l;
end;

bc_company_phone_init := project(bc(bdid <> 0, from_hdr = 'N', company_phone <> 0 and company_phone < 10000000000), GetBCCompanyPhone(left));
bc_company_phone_init_dedup := dedup(bc_company_phone_init, all);

// Use company phone
bc_company_phone_list := join(bc_company_phone_init_dedup,
                              phone_list_dedup,
				          left.phone10 = right.phone10,
				          transform(layout_bc_phone, self := left),
				          hash);
						
bc_phone_list_combined := bc_phone_list + bc_company_phone_list;
bc_phone_list_dedup := dedup(bc_phone_list_combined, all);

// Try matching phones to business header to get target BDIDs
bh := Business_Header.File_Business_Header;

layout_bc_phone GetBHPhone(bh l) := transform
self.phone10 := intformat(l.phone, 10, 1);
self := l;
end;

bh_phone_init := project(bh(phone <> 0 and phone < 10000000000), GetBHPhone(left));
bh_phone_init_dedup := dedup(bh_phone_init, all);

company_phone_bdid_list := join(bh_phone_init_dedup,
                                phone_list_dedup,
				            left.phone10[1..7] = right.phone10[1..7],
				            transform(layout_bc_phone, self := left),
				            hash);
				   
company_phone_bdid_list_dedup := dedup(company_phone_bdid_list, all);

// Combine bdids from contacts direct and business header
company_phone_bdid_list_combined := bc_phone_list_dedup + company_phone_bdid_list_dedup;
company_phone_bdid_list_combined_dedup := dedup(company_phone_bdid_list_combined, all);
				   
// Match contact names from associated businesses	and business phone				 
layout_bc_slim_company_phone := record
bc.bdid;
bc.company_title;   // Title of Contact at Company if available
string7 phone7 := '';
bc.fname;
bc.mname;
bc.lname;
bc.name_suffix;
end;

bc_company_phone_slim := table(bc(bdid <> 0, from_hdr = 'N'), layout_bc_slim_company_phone);
bc_company_phone_slim_dedup := dedup(bc_company_phone_slim, all);

// Select contacts using bdids of associated companies
bc_company_phone_select := join(bc_company_phone_slim_dedup,
                                company_phone_bdid_list_combined_dedup,
			                 left.bdid = right.bdid,
			                 transform(layout_bc_slim_company_phone, self.phone7 := (right.phone10)[1..7], self := left),
			                 hash);
						  
bc_company_phone_select_dedup := dedup(bc_company_phone_select((integer)phone7 <> 0), all);
bc_company_phone_select_dedup_dist := distribute(bc_company_phone_select_dedup, hash(phone7));

// Append BDID of associated companies with matching contact names to original records
Layout_ABN_AMRO_C2BTest_Base AppendBDID(abn_amro_init l, layout_bc_slim_company_phone r) := transform
self.bdid := r.bdid;
self.confidence_level := if(r.bdid <> 0, 4, l.confidence_level);
self.contact_fname := r.fname;
self.contact_mname := r.mname;
self.contact_lname := r.lname;
self.contact_name_suffix := r.name_suffix;
self := l;
end;

abn_amro_init_dist := distribute(abn_amro_init(phone10 <> ''), hash((string7)phone10[1..7]));

abn_amro_bdid_append := join(abn_amro_init_dist,
                             bc_company_phone_select_dedup_dist,
					    (string7)(left.phone10)[1..7] = right.phone7 and
					      ut.NameMatch(left.fname, left.mname, left.lname, right.fname, right.mname, right.lname) < 3 and
						 ut.NNEQ(left.name_suffix, right.name_suffix),
					    AppendBDID(left, right),
					    left outer,
					    local);
					    
abn_amro_bdid_append_dist := distribute(abn_amro_bdid_append, hash(seq, bdid));
abn_amro_bdid_append_sort := sort(abn_amro_bdid_append_dist, seq, bdid, ut.TitleRank(contact_title), local);
abn_amro_bdid_append_dedup := dedup(abn_amro_bdid_append_sort, seq, bdid, local);

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

abn_amro_combine_gid_sort := sort(abn_amro_combined_dedup, seq, confidence_level, group_id, bdid)  : persist('TMTEST::abn_amro_c2btest_phone_append');



export abn_amro_c2btest_phone_append := abn_amro_combine_gid_sort;
