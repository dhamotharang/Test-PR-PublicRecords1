import ut, Business_Header, Corp, UCC, FBN, Busreg, Bankrupt;

// Extract list of BDIDs from Equifax Businesses
busprep := business_prep(bdid <> 0);

layout_bdid_list := record
unsigned6 bdid;
end;

layout_bdid_list GetEquifaxBDIDs(Layout_Business_Clean l) := transform
self := l;
end;

bdid_list_init := project(busprep, GetEquifaxBDIDs(left));
bdid_list_dedup := dedup(bdid_list_init, all);

// Get Corporate BDIDs
fcorp := Corp.File_Corp_Base(bdid <> 0);

layout_source_bdid_list := record
string2 source;
unsigned6 bdid;
end;

layout_source_bdid_list GetCorpBDIDs(fcorp l) := transform
self.source := 'C';
self := l;
end;

corp_bdid_init := project(fcorp, GetCorpBDIDs(left));

// Get UCC BDIDs
fucc := UCC.File_UCC_Debtor_Master(bdid <> 0) + UCC.File_UCC_Secured_Master(bdid <> 0);

layout_source_bdid_list GetUCCBDIDs(fucc l) := transform
self.source := 'U';
self := l;
end;

ucc_bdid_init := project(fucc, GetUCCBDIDs(left));

// Get FBN BDIDs
ffbn := FBN.File_FBN(bdid <> 0);

layout_source_bdid_list GetFBNBDIDs(ffbn l) := transform
self.source := 'F';
self := l;
end;

fbn_bdid_init := project(ffbn, GetFBNBDIDs(left));

// Get Business Registration BDIDs
fbusreg := BusReg.File_BusReg_Company(bdid <> 0);

layout_source_bdid_list GetBusRegBDIDs(fbusreg l) := transform
self.source := 'BR';
self := l;
end;

busreg_bdid_init := project(fbusreg, GetBusRegBDIDs(left));

// Get Bankruptcy BDIDs
fbk := Bankrupt.File_BK_Search(bdid <> '');

layout_source_bdid_list GetBKBDIDs(fbk l) := transform
self.source := 'B';
self.bdid := (unsigned6)l.bdid;
end;

bk_bdid_init := project(fbk, GetBKBDIDs(left));

// Get Liens/Judgment BDIDs
flj := dataset('~thor_data400::in::liens_20041221',bankrupt.Layout_Liens,flat)(bdid <> '');

layout_source_bdid_list GetLJBDIDs(flj l) := transform
self.source := 'LJ';
self.bdid := (unsigned6)l.bdid;
end;

lj_bdid_init := project(flj, GetLJBDIDs(left));

// Combine BDID records
bdid_combined := corp_bdid_init + ucc_bdid_init + fbn_bdid_init + busreg_bdid_init + bk_bdid_init + lj_bdid_init;

// Select only BDIDs for Equifax
layout_source_bdid_list SelectBDIDs(layout_source_bdid_list l, layout_bdid_list r) := transform
self := l;
end;

bdid_source_list := join(bdid_combined,
                         bdid_list_dedup,
						 left.bdid = right.bdid,
						 lookup);
						 
// Stat to count BDIDs by source type
layout_source_bdid_stat := record
bdid_source_list.source;
bdid_source_list.bdid;
unsigned3 bdid_cnt := count(group);
end;

bdid_source_stat := table(bdid_source_list, layout_source_bdid_stat, source, bdid);

// Rollup counts to a single record by BDID
layout_record_counts := record
unsigned6 bdid;
unsigned3 corp_record_cnt;
unsigned3 ucc_record_cnt;
unsigned3 fbn_record_cnt;
unsigned3 busreg_record_cnt;
unsigned3 bk_record_cnt;
unsigned3 lj_record_cnt;
end;

layout_record_counts InitRecordCounts(layout_source_bdid_stat l) := transform
self.corp_record_cnt := if(l.source = 'C', l.bdid_cnt, 0);
self.ucc_record_cnt := if(l.source = 'U', l.bdid_cnt, 0);
self.fbn_record_cnt := if(l.source = 'F', l.bdid_cnt, 0);
self.busreg_record_cnt := if(l.source = 'BR', l.bdid_cnt, 0);
self.bk_record_cnt := if(l.source = 'B', l.bdid_cnt, 0);
self.lj_record_cnt := if(l.source = 'LJ', l.bdid_cnt, 0);
self := l;
end;

bdid_record_count_init := project(bdid_source_stat, InitRecordCounts(left));
bdid_record_count_dist := distribute(bdid_record_count_init, hash(bdid));
bdid_record_count_sort := sort(bdid_record_count_dist, bdid, local);

layout_record_counts RollupRecordCounts(layout_record_counts l, layout_record_counts r) := transform
self.corp_record_cnt := l.corp_record_cnt + r.corp_record_cnt;
self.ucc_record_cnt := l.ucc_record_cnt + r.ucc_record_cnt;
self.fbn_record_cnt := l.fbn_record_cnt + r.fbn_record_cnt;
self.busreg_record_cnt := l.busreg_record_cnt + r.busreg_record_cnt;
self.bk_record_cnt := l.bk_record_cnt + r.bk_record_cnt;
self.lj_record_cnt := l.lj_record_cnt + r.lj_record_cnt;
self := l;
end;

bdid_record_count_rollup := rollup(bdid_record_count_sort,
                                   left.bdid = right.bdid,
								   RollupRecordCounts(left, right),
								   local) : persist('TEMP::equifax_record_count_rollup');
								   
// Append stats to business records
Layout_Business_Append InitBusinessAppend(Layout_Business_Clean l) := transform
self := l;
end;

busappnd_init := project(busprep, InitBusinessAppend(left));
busappnd_dedup := dedup(busappnd_init, all);

// Combine with record counts
Layout_Business_Append AppendRecordCounts(Layout_Business_Append l, layout_record_counts r) := transform
self.corp_record_cnt := r.corp_record_cnt;
self.ucc_record_cnt := r.ucc_record_cnt;
self.fbn_record_cnt := r.fbn_record_cnt;
self.busreg_record_cnt := r.busreg_record_cnt;
self.bk_record_cnt := r.bk_record_cnt;
self.lj_record_cnt := r.lj_record_cnt;
self := l;
end;

busappnd_counts := join(busappnd_dedup,
                        bdid_record_count_rollup,
						left.bdid = right.bdid,
						AppendRecordCounts(left, right),
						left outer,
						hash);
						
// Combine with Business Header best information
bhbest := Business_Header.File_Business_Header_Best;

Business_Header.Layout_BH_Best SelectBest(Business_Header.Layout_BH_Best l, layout_bdid_list r) := transform
self := l;
end;

bhbest_init := join(bhbest,
                    bdid_list_dedup,
					left.bdid = right.bdid,
					SelectBest(left, right),
					lookup);

Layout_Business_Append AppendBHBest(busappnd_counts l, bhbest_init r) := transform
self.best_company_name := r.company_name;
self.best_prim_range := r.prim_range;
self.best_predir := r.predir;
self.best_prim_name := r.prim_name;
self.best_addr_suffix := r.addr_suffix;
self.best_postdir := r.postdir;
self.best_unit_desig := r.unit_desig;
self.best_sec_range := r.sec_range;
self.best_city := r.city;
self.best_state := r.state;
self.best_zip := r.zip;
self.best_zip4 := r.zip4;
self.best_phone := r.phone;
self.best_fein := r.fein;
self := l;
end;

busappend_best := join(busappnd_counts,
                       bhbest_init,
					   left.bdid = right.bdid,
					   AppendBHBest(left, right),
					   left outer,
					   hash);
					   
export business_append := busappend_best : persist('TEMP::equifax_business_append');