import Business_Header, ut;

// For records with a BDID but no best phone, get best_phone from group
dn_group_init := directorynet_prep(did <> 0 and bdid = 0);
dn_other := directorynet_prep(not(did <> 0 and bdid = 0));

// Use the dids to find associated business contact records
layout_did_bdid := record
dn_group_init.did;
string30 company_name_in := dn_group_init.Company_Name;
unsigned6 bdid := 0;
qstring120 company_name := '';
end;

dn_did_list := table(dn_group_init, layout_did_bdid);
dn_did_list_dedup := dedup(dn_did_list, all);

// Select associated business contact records
dn_did_bdid_list := join(Business_Header.File_Business_Contact_Stats_MktApp(did <> 0),
//dn_did_bdid_list := join(Business_Header.File_Business_Contacts_Stats(did <> 0),
                         dn_did_list_dedup,
					left.did = right.did,
					transform(layout_did_bdid,
					          self.company_name_in := right. company_name_in,
							self := left),
					hash);
					
// Compare company_names on contact records with company_names from original records
dn_did_bdid_list_filtered := dn_did_bdid_list(bdid <> 0, ut.CompanySimilar100(company_name_in, company_name) <= 35);
dn_did_bdid_list_filtered_dist := distribute(dn_did_bdid_list_filtered, hash(did));
dn_did_bdid_list_filtered_sort := sort(dn_did_bdid_list_filtered_dist, did, company_name_in, ut.CompanySimilar100(company_name_in, company_name), local);
dn_did_bdid_list_filtered_dedup := dedup(dn_did_bdid_list_filtered_sort, did, company_name_in, local);

// Append BDIDs to original input

Layout_DirectoryNet_Base AppendBDIDs(Layout_DirectoryNet_Base l, layout_did_bdid r) := transform
self.bdid := r.bdid;
self := l;
end;

dn_bdid_append := join(dn_group_init,
                        dn_did_bdid_list_filtered_dedup,
				    left.did = right.did and
				      left.Company_Name = right.company_name_in,
				    AppendBDIDs(left, right),
				    left outer,
				    hash);

// Append Best Information
bhb := Business_Header.BestAll_MktApp;
//bhb := Business_Header.File_Business_Header_Best;

os(STRING s) := IF(s = '', '', TRIM(s) + ' ');

Layout_DirectoryNet_Base AppendBest(Layout_DirectoryNet_Base l, bhb r) := transform
self.bus_best_CompanyName := r.company_name;

self.bus_best_addr1 := 
			os(r.prim_range) + 
			os(r.predir) + 
			os(r.prim_name) +
			os(r.addr_suffix) +
			os(r.postdir) +
				if(ut.tails(r.prim_name, os(r.unit_desig) + os(r.sec_range)),
					'',
					os(r.unit_desig) + os(r.sec_range));
self.bus_best_city := r.city;
self.bus_best_state := r.state;
self.bus_best_zip := if(r.zip = 0, '', intformat(r.zip, 5, 1));
self.bus_best_zip4 := if(r.zip4 <> 0, intformat(r.zip4, 4, 1), '');

self.bus_best_phone := if(r.phone <> 0, intformat(r.phone, 10, 1), '');
self.bus_best_fein := if(r.fein <> 0, intformat(r.fein, 9, 1), '');
self := l;
end;

dn_best_append := join(dn_bdid_append,
                             bhb,
					    left.bdid = right.bdid,
					    AppendBest(left, right),
					    left outer,
					    hash);
					    
// Append group ids
bhg := Business_Header.File_Super_Group;

dn_append_gid := join(dn_best_append,
                             bhg,
					    left.bdid = right.bdid,
					    transform(Layout_DirectoryNet_Base, self.group_id := right.group_id, self := left),
					    left outer,
					    hash) : persist('TMTEST::directorynet_did_bdid_append');


export directnet_did_to_business := dn_append_gid + dn_other : persist('TMTEST::directorynet_did_to_business');