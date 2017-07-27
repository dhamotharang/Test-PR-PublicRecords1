// Extract sample businessess for Riskwise test
layout_sample_stats := record
unsigned6 bdid;
unsigned4 dt_last_seen := 0;
unsigned3 base_record_count := 0;
// Source Data Record Counts
unsigned3 corp_record_cnt := 0;
unsigned3 ucc_record_cnt := 0;
unsigned3 fbn_record_cnt := 0;
unsigned3 busreg_record_cnt := 0;
unsigned3 bk_record_cnt := 0;
unsigned3 lj_record_cnt := 0;
unsigned3 gb_record_cnt := 0;
unsigned3 irs5500_record_cnt := 0;
unsigned3 dnb_record_cnt := 0;
// D&B Info
unsigned3 dnb_number_employees := 0;
unsigned6 dnb_revenues := 0;
// Business Owner information
unsigned3 bo_cnt := 0;
end;

bhb := Business_Header.File_Business_Header_Best(zip <> 0, prim_name <> '', prim_name[1..6] <> 'PO BOX');

// Initialize stats from best file
layout_sample_stats InitStats(bhb l) := transform
self := l;
end;

ss_init := project(bhb, InitStats(left));
ss_init_dist := distribute(ss_init, hash(bdid));

// Determine most recent date last seen for these BDIDs
bhbase := Business_Header.File_Business_Header_Base;

layout_bdid_last_seen := record
bhbase.bdid;
bhbase.dt_last_seen;
end;

bdid_last_seen := table(bhbase, layout_bdid_last_seen);
bdid_last_seen_dist := distribute(bdid_last_seen, hash(bdid));
bdid_last_seen_sort := sort(bdid_last_seen_dist, bdid, -dt_last_seen, local);
bdid_last_seen_dedup := dedup(bdid_last_seen_sort, bdid, local);

layout_sample_stats AppendDate(layout_sample_stats l, layout_bdid_last_seen r) := transform
self.dt_last_seen := r.dt_last_seen;
self := l;
end;

ss_dls := join(ss_init_dist,
               bdid_last_seen_dedup,
			left.bdid = right.bdid,
			AppendDate(left, right),
			local);
			
// Extract list of selected BDIDs
layout_bdid_list := record
ss_dls.bdid;
end;

ss_bdid_list := table(ss_dls, layout_bdid_list);

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

// Get Gong BDIDs
layout_source_bdid_list GetGongBDIDs(bhbase l) := transform
self.source := 'GB';
self := l;
end;

gb_bdid_init := project(bhbase(source = 'GB'), GetGongBDIDs(left));

// Get IRS5500 BDIDs
layout_source_bdid_list GetIRS5500BDIDs(bhbase l) := transform
self.source := 'I';
self := l;
end;

irs5500_bdid_init := project(bhbase(source = 'I'), GetIRS5500BDIDs(left));

// Get D&B BDIDs
layout_source_bdid_list GetDNBBDIDs(bhbase l) := transform
self.source := 'D';
self := l;
end;

dnb_bdid_init := project(bhbase(source = 'D'), GetDNBBDIDs(left));

// Combine BDID records
bdid_combined := corp_bdid_init +
                 ucc_bdid_init +
			  fbn_bdid_init +
			  busreg_bdid_init +
			  bk_bdid_init +
			  lj_bdid_init +
			  gb_bdid_init +
			  dnb_bdid_init +
			  irs5500_bdid_init;
			  
bdid_combined_dist := distribute(bdid_combined, hash(bdid));

// Limit to selected BDIDs
layout_source_bdid_list SelectBDIDs(layout_source_bdid_list l, layout_bdid_list r) := transform
self := l;
end;

bdid_source_list := join(bdid_combined_dist,
                         ss_bdid_list,
				     left.bdid = right.bdid,
					SelectBDIDs(left, right),
				     local);
						 
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
unsigned3 gb_record_cnt;
unsigned3 irs5500_record_cnt;
unsigned3 dnb_record_cnt;
end;

layout_record_counts InitRecordCounts(layout_source_bdid_stat l) := transform
self.corp_record_cnt := if(l.source = 'C', l.bdid_cnt, 0);
self.ucc_record_cnt := if(l.source = 'U', l.bdid_cnt, 0);
self.fbn_record_cnt := if(l.source = 'F', l.bdid_cnt, 0);
self.busreg_record_cnt := if(l.source = 'BR', l.bdid_cnt, 0);
self.bk_record_cnt := if(l.source = 'B', l.bdid_cnt, 0);
self.lj_record_cnt := if(l.source = 'LJ', l.bdid_cnt, 0);
self.gb_record_cnt := if(l.source = 'GB', l.bdid_cnt, 0);
self.irs5500_record_cnt := if(l.source = 'I', l.bdid_cnt, 0);
self.dnb_record_cnt := if(l.source = 'D', l.bdid_cnt, 0);
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
self.gb_record_cnt := l.gb_record_cnt + r.gb_record_cnt;
self.irs5500_record_cnt := l.irs5500_record_cnt + r.irs5500_record_cnt;
self.dnb_record_cnt := l.dnb_record_cnt + r.dnb_record_cnt;
self := l;
end;

bdid_record_count_rollup := rollup(bdid_record_count_sort,
                                   left.bdid = right.bdid,
						     RollupRecordCounts(left, right),
						     local);
								   
// Append stats to sample records
layout_sample_stats AppendRecordCounts(layout_sample_stats l, layout_record_counts r) := transform
self.corp_record_cnt := r.corp_record_cnt;
self.ucc_record_cnt := r.ucc_record_cnt;
self.fbn_record_cnt := r.fbn_record_cnt;
self.busreg_record_cnt := r.busreg_record_cnt;
self.bk_record_cnt := r.bk_record_cnt;
self.lj_record_cnt := r.lj_record_cnt;
self.gb_record_cnt := r.gb_record_cnt;
self.irs5500_record_cnt := r.irs5500_record_cnt;
self.dnb_record_cnt := r.dnb_record_cnt;
self := l;
end;

ss_counts := join(ss_dls,
                  bdid_record_count_rollup,
			   left.bdid = right.bdid,
			   AppendRecordCounts(left, right),
			   left outer,
			   local);
						
// Append number of Business Owners
bc_owners := Business_Header.BC_Owner;

layout_did_list := record
bc_owners.did;
end;

bc_owners_list := table(bc_owners(did <> 0), layout_did_list);
bc_owners_list_dedup := dedup(bc_owners_list, did, all);

bc := Business_Header.File_Business_Contacts_Base;

layout_bdid_did_list := record
bc.bdid;
bc.did;
end;

bc_list := table(bc(did <> 0, bdid <> 0), layout_bdid_did_list);
bc_list_dedup := dedup(bc_list, bdid, did, all);

layout_bdid_did_list SelectOwnerBDIDs(layout_bdid_did_list l, layout_did_list r) := transform
self := l;
end;

bc_owners_bdid := join(bc_list_dedup,
                       bc_owners_list_dedup,
				   left.did = right.did,
				   SelectOwnerBDIDs(left, right),
				   hash);
				   
layout_bdid_owners_stat := record
bc_owners_bdid.bdid;
unsigned3 cnt := count(group);
end;

bdid_owners_stat := table(bc_owners_bdid, layout_bdid_owners_stat, bdid);
bdid_owners_stat_dist := distribute(bdid_owners_stat, hash(bdid));

layout_sample_stats AppendOwnersCount(layout_sample_stats l, layout_bdid_owners_stat r) := transform
self.bo_cnt := r.cnt;
self := l;
end;

ss_owners := join(ss_counts,
                  bdid_owners_stat_dist,
			   left.bdid = right.bdid,
			   AppendOwnersCount(left, right),
			   left outer,
			   local);
			   
// Append D&B Info
db := DNB.File_DNB_Base(bdid <> 0, record_type = 'C', active_duns_number = 'Y');

layout_db_info := record
db.bdid;
unsigned3 dnb_number_employees := (unsigned3)db.employees_total;
unsigned6 dnb_revenues := (unsigned6)db.annual_sales_volume;
end;

db_info := table(db, layout_db_info);
db_info_dist := distribute(db_info, hash(bdid));
db_info_sort := sort(db_info_dist, bdid, -dnb_revenues, -dnb_number_employees, local);
db_info_dedup := dedup(db_info_sort, bdid, local);

layout_sample_stats AppendDNBInfo(layout_sample_stats l, layout_db_info r) := transform
self.dnb_revenues := r.dnb_revenues;
self.dnb_number_employees := r.dnb_number_employees;
self := l;
end;

ss_dnb := join(ss_owners,
               db_info_dedup,
			left.bdid = right.bdid,
			AppendDNBInfo(left, right),
			left outer,
			local);
			
// Append base record count
bhstats := Business_Header.File_Business_Header_Stats;

layout_base_count := record
bhstats.bdid;
bhstats.base_record_count;
end;

bh_base_count := table(bhstats, layout_base_count);

layout_sample_stats AppendBaseCount(layout_sample_stats l, layout_base_count r) := transform
self.base_record_count := r.base_record_count;
self := l;
end;

ss_base := join(ss_dnb,
                bh_base_count,
			 left.bdid = right.bdid,
			 AppendBaseCount(left, right),
			 left outer,
			 local) : persist('TMTEMP::IR_Sample_Counts');

// Select sample
ss_base_limited := ss_base(base_record_count <= 10, (dt_last_seen div 10000) > 2004);

s1 := enth(ss_base_limited(gb_record_cnt > 0 and
                           not corp_record_cnt > 0 and
                           not ucc_record_cnt > 0 and
                           not fbn_record_cnt > 0 and
                           not busreg_record_cnt > 0 and
                           not bk_record_cnt > 0 and
                           not lj_record_cnt > 0 and
                           not irs5500_record_cnt > 0 and
                           not dnb_record_cnt > 0, bo_cnt >= 0),5);
					  
s2 := enth(ss_base_limited(gb_record_cnt > 0 and
                           not corp_record_cnt > 0 and
                           not ucc_record_cnt > 0 and
                           not fbn_record_cnt > 0 and
                           not busreg_record_cnt > 0 and
                           not bk_record_cnt > 0 and
                           not lj_record_cnt > 0 and
                           not irs5500_record_cnt > 0 and
                           not dnb_record_cnt > 0, bo_cnt = 0),5);
					  
s3 := enth(ss_base_limited(dnb_record_cnt > 0, dnb_revenues < 20000000), 10);

s4 := enth(ss_base_limited(irs5500_record_cnt > 0), 10);

s5 := enth(ss_base_limited(corp_record_cnt > 0 or
                           busreg_record_cnt > 0 or
					  ucc_record_cnt > 0 or
					  fbn_record_cnt >0 or
					  bk_record_cnt > 0 or
					  lj_record_cnt > 0), 30);
					  
s6 := enth(ss_base_limited(bk_record_cnt > 0),5);

s7 := enth(ss_base_limited(lj_record_cnt > 0),5);
					  
ss_sample := s1 + s2 + s3 + s4 + s5 + s6 + s7;
ss_sample_dedup := dedup(ss_sample, bdid, all);

layout_sample := record
Business_Header.Layout_BH_Best;
unsigned4 dt_last_seen := 0;
unsigned3 base_record_count := 0;
// Source Data Record Counts
unsigned3 corp_record_cnt := 0;
unsigned3 ucc_record_cnt := 0;
unsigned3 fbn_record_cnt := 0;
unsigned3 busreg_record_cnt := 0;
unsigned3 bk_record_cnt := 0;
unsigned3 lj_record_cnt := 0;
unsigned3 gb_record_cnt := 0;
unsigned3 irs5500_record_cnt := 0;
unsigned3 dnb_record_cnt := 0;
// D&B Info
unsigned3 dnb_number_employees := 0;
unsigned6 dnb_revenues := 0;
// Business Owner information
unsigned3 bo_cnt := 0;
end;

layout_sample AppendBest(Business_Header.Layout_BH_Best l, layout_sample_stats r) := transform
self := r;
self := l;
end;

ss_sample_out := join(bhb,
                      ss_sample_dedup,
				  left.bdid = right.bdid,
				  AppendBest(left, right),
				  lookup)  : persist('TMTEMP::IR_Sample');

output(ss_sample_out, all);

// Output the business owners for these businesses
layout_bdid_did_list GetSampleOwnersDID(layout_bdid_did_list l, layout_sample r) := transform
self := l;
end;

ss_sample_owners_list := join(bc_owners_bdid,
                              ss_sample_out,
			               left.bdid = right.bdid,
			               GetSampleOwnersDID(left, right),
			   			lookup);
						
Business_Header.Layout_Business_Contact_Full GetSampleOwners(Business_Header.Layout_Business_Contact_Full l, layout_bdid_did_list r) := transform
self := l;
end;

ss_sample_owners := join(bc,
                         ss_sample_owners_list,
					left.bdid = right.bdid and
					left.did = right.did,
					GetSampleOwners(left, right),
					lookup);
					
ss_sample_owners_dedup := dedup(ss_sample_owners, bdid, did, all)  : persist('TMTEMP::IR_Sample_Owners');

output(ss_sample_owners_dedup, all);



