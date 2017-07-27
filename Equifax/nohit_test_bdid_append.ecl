import ut, Business_Header, Corp, UCC, FBN, Busreg, Bankrupt;

// Extract list of BDIDs from Equifax Businesses
busprep := nohit_test_bdid_by_contact(bdid <> 0);

layout_bdid_list := record
unsigned6 bdid;
end;

layout_bdid_list GetEquifaxBDIDs(Layout_NoHit_Test_Base l) := transform
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
//fbusreg := BusReg.File_BusReg_Company(bdid <> 0);
fbusreg := dataset('~thor_data400::base::busreg_company_20050209', Busreg.Layout_BusReg_Company,flat)(bdid <> 0);

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
flj := Bankrupt.File_Liens(bdid <> '');

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
								   local) : persist('TMTEST::equifax_nohit_record_count_rollup');
								   
// Append stats to business records
Layout_Nohit_Test_Append InitBusinessAppend(Layout_NoHit_Test_Base l) := transform
self := l;
end;

busappnd_init := project(busprep, InitBusinessAppend(left));
busappnd_dedup := dedup(busappnd_init, all);

// Combine with record counts
Layout_Nohit_Test_Append AppendRecordCounts(Layout_Nohit_Test_Append l, layout_record_counts r) := transform
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
						
// Format records with no bdid
Layout_Nohit_Test_Append FormatAppend(Layout_NoHit_Test_Base l) := transform
self := l;
end;

busappnd_nobdid := project(nohit_test_bdid_by_contact(bdid = 0), FormatAppend(left));
						
export nohit_test_bdid_append := busappnd_nobdid + busappnd_counts : persist('TMTEST::equifax_nohit_bdid_append');