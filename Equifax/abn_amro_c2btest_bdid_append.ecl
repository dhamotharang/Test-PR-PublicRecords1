import ut, Business_Header;

// Append associated companies by DID

bc := Business_Header.File_Business_Contacts;

layout_bc_slim := record
bc.bdid;
bc.did;
end;

bc_slim := table(bc(bdid <> 0, did <> 0, from_hdr = 'N'), layout_bc_slim);
bc_slim_dedup := dedup(bc_slim, all);

abn_amro_init := abn_amro_c2btest_prep;

// Append BDID of associated companies to original records
Layout_ABN_AMRO_C2BTest_Base Append_DID_BDID(abn_amro_init l, layout_bc_slim r) := transform
self.bdid := r.bdid;
self.confidence_level := 1;
self := l;
end;

abn_amro_bdid_append := join(abn_amro_init,
                             bc_slim_dedup,
					    left.did = right.did,
					    Append_DID_BDID(left, right),
					    left outer,
					    hash);
					    
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
self.best_zip4 := if(r.zip4 <> 0, '-' + intformat(r.zip4, 4, 1), '');

self.best_phone := if(r.phone <> 0, intformat(r.phone, 10, 1), '');
self.best_fein := if(r.fein <> 0, intformat(r.fein, 9, 1), '');
self := l;
end;

abn_amro_best_append := join(abn_amro_bdid_append,
                             bhb,
					    left.bdid = right.bdid,
					    AppendBest(left, right),
					    left outer,
					    hash);
					    
abn_amro_best_append_sort := sort(abn_amro_best_append, seq, bdid)  : persist('TMTEST::abn_amro_c2btest_bdid_append');

export abn_amro_c2btest_bdid_append := abn_amro_best_append_sort;