import ut, Business_Header, DNB, DCA, Corp, UCC, Busreg, Bankrupt, InfoUSA;

c2btest_data := dataset('~thor_data400::TMTEST::abn_amro_c2btest_data_append', Equifax.Layout_ABN_AMRO_C2BTest_Base, flat, __compressed__);

//c2btest_data := Equifax.abn_amro_c2btest_data_append;

layout_c2btest_bdid_list := record
c2btest_data.bdid;
end;

c2btest_bdid_list := dedup(table(c2btest_data(bdid <> 0), layout_c2btest_bdid_list),all);

layout_stats := record
unsigned6 bdid;
unsigned6 group_id := 0;
unsigned4 dt_last_seen := 0;
unsigned3 base_record_count := 0;
// Source Data Record Counts
unsigned3 corp_record_cnt := 0;
unsigned3 ucc_record_cnt := 0;
unsigned3 busreg_record_cnt := 0;
unsigned3 bk_record_cnt := 0;
unsigned3 lj_record_cnt := 0;
unsigned3 gb_record_cnt := 0;
unsigned3 irs5500_record_cnt := 0;
unsigned3 dnb_record_cnt := 0;
unsigned3 yp_record_cnt := 0;
// Corp info
string60 corp_org_type := '';
// D&B Info
unsigned3 dnb_number_employees := 0;
unsigned6 dnb_revenues := 0;
// DCA Info
unsigned3 dca_number_employees := 0;
unsigned6 dca_revenues := 0;
// Infousa Info
unsigned3 infousa_number_employees := 0;
unsigned6 infousa_revenues := 0;
// Lien/Judgment Info
unsigned4 lj_dt_last_seen := 0;
unsigned6 judgment_amount := 0;
// Business Owner information
unsigned3 bo_cnt := 0;
// Bankruptcy Info
unsigned4 bk_dt_last_seen := 0;
end;

bhb := join(Business_Header.File_Business_Header_Best(zip <> 0, prim_name <> ''),
            c2btest_bdid_list,
		  left.bdid = right.bdid,
		  transform(Business_Header.Layout_BH_Best, self := left),
		  hash);

// Initialize stats from best file
layout_stats InitStats(bhb l) := transform
self := l;
end;

stats_init := project(bhb, InitStats(left));
stats_init_dist := distribute(stats_init, hash(bdid));

bh_group := Business_Header.File_Super_Group;
bh_group_dist := distribute(bh_group, hash(bdid));

stats_init_group_append := join(stats_init_dist,
                                bh_group_dist,
					       left.bdid = right.bdid,
						  transform(layout_stats, self.group_id := right.group_id, self := left));

// Determine most recent date last seen for these BDIDs
bhbase := Business_Header.File_Business_Header_Base;

layout_bdid_stats := record
bhbase.bdid;
unsigned4 dt_last_seen := max(group, bhbase.dt_last_seen);
unsigned4 bk_dt_last_seen := max(group, if(bhbase.source = 'B', bhbase.dt_last_seen, 0));
unsigned4 lj_dt_last_seen := max(group, if(bhbase.source = 'LJ', bhbase.dt_last_seen, 0));
end;

bdid_stats := table(bhbase, layout_bdid_stats, bdid);
bdid_stats_dist := distribute(bdid_stats, hash(bdid));

layout_stats AppendStats(layout_stats l, layout_bdid_stats r) := transform
self.dt_last_seen := r.dt_last_seen;
self.bk_dt_last_seen := r.bk_dt_last_seen;
self := l;
end;

stats_dls := join(stats_init_group_append,
                  bdid_stats_dist,
			   left.bdid = right.bdid,
			   AppendStats(left, right),
			   local);
			
// Extract list of selected BDIDs
layout_bdid_list := record
stats_dls.bdid;
end;

stats_bdid_list := table(stats_dls, layout_bdid_list);

// Get source stat
layout_bdid_source := record
bhbase.bdid;
bhbase.source;
end;

bdid_source_init := table(bhbase, layout_bdid_source);
bdid_source_dist := distribute(bdid_source_init, hash(bdid));

// Limit to selected BDIDs
layout_bdid_source SelectBDIDs(layout_bdid_source l, layout_bdid_list r) := transform
self := l;
end;

bdid_source_list := join(bdid_source_dist,
                         stats_bdid_list,
				     left.bdid = right.bdid,
					SelectBDIDs(left, right),
				     local);
						 
// Sum counts to a single record by BDID
layout_record_counts := record
bdid_source_list.bdid;
unsigned3 corp_record_cnt := sum(group, if(bdid_source_list.source = 'C', 1, 0));
unsigned3 ucc_record_cnt := sum(group, if(bdid_source_list.source = 'U', 1, 0));
unsigned3 busreg_record_cnt := sum(group, if(bdid_source_list.source = 'BR', 1, 0));
unsigned3 bk_record_cnt := sum(group, if(bdid_source_list.source = 'B', 1, 0));
unsigned3 lj_record_cnt := sum(group, if(bdid_source_list.source = 'LJ', 1, 0));
unsigned3 gb_record_cnt := sum(group, if(bdid_source_list.source = 'GB', 1, 0));
unsigned3 irs5500_record_cnt := sum(group, if(bdid_source_list.source = 'I', 1, 0));
unsigned3 dnb_record_cnt := sum(group, if(bdid_source_list.source = 'D', 1, 0));
unsigned3 yp_record_cnt := sum(group, if(bdid_source_list.source = 'Y', 1, 0));
end;

bdid_record_count := table(bdid_source_list, layout_record_counts, bdid, local);
								   
// Append stats to sample records
layout_stats AppendRecordCounts(layout_stats l, layout_record_counts r) := transform
self.corp_record_cnt := r.corp_record_cnt;
self.ucc_record_cnt := r.ucc_record_cnt;
self.busreg_record_cnt := r.busreg_record_cnt;
self.bk_record_cnt := r.bk_record_cnt;
self.lj_record_cnt := r.lj_record_cnt;
self.gb_record_cnt := r.gb_record_cnt;
self.irs5500_record_cnt := r.irs5500_record_cnt;
self.dnb_record_cnt := r.dnb_record_cnt;
self.yp_record_cnt := r.yp_record_cnt;
self := l;
end;

stats_counts := join(stats_dls,
                     bdid_record_count,
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

layout_stats AppendOwnersCount(layout_stats l, layout_bdid_owners_stat r) := transform
self.bo_cnt := r.cnt;
self := l;
end;

stats_owners := join(stats_counts,
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

layout_stats AppendDNBInfo(layout_stats l, layout_db_info r) := transform
self.dnb_revenues := r.dnb_revenues;
self.dnb_number_employees := r.dnb_number_employees;
self := l;
end;

stats_dnb := join(stats_owners,
               db_info_dedup,
			left.bdid = right.bdid,
			AppendDNBInfo(left, right),
			left outer,
			local);

// Append DCA Info
dcaf := DCA.File_DCA_Base(bdid <> 0);

layout_dca_info := record
dcaf.bdid;
unsigned3 dca_number_employees := (unsigned3)dcaf.EMP_NUM;
unsigned6 dca_revenues := (unsigned6)dcaf.Sales;
end;

dca_info := table(dcaf, layout_dca_info);
dca_info_dist := distribute(dca_info, hash(bdid));
dca_info_sort := sort(dca_info_dist, bdid, -dca_revenues, -dca_number_employees, local);
dca_info_dedup := dedup(dca_info_sort, bdid, local);

layout_stats AppendDCAInfo(layout_stats l, layout_dca_info r) := transform
self.dca_revenues := r.dca_revenues;
self.dca_number_employees := r.dca_number_employees;
self := l;
end;

stats_dca := join(stats_dnb,
               dca_info_dedup,
			left.bdid = right.bdid,
			AppendDCAInfo(left, right),
			left outer,
			local);

// Append InfoUSA Info
iusa := InfoUSA.File_ABIUS_Company_Base(bdid <> 0);

layout_iusa_info := record
unsigned6 bdid;
unsigned3 infousa_number_employees;
unsigned6 infousa_revenues;
end;

layout_iusa_info GetIUSAInfo(iusa l) := transform
self.infousa_number_employees := map((unsigned3)l.TOTAL_EMPLOYEES_ACTUAL <> 0 => (unsigned3)l.TOTAL_EMPLOYEES_ACTUAL,
                                          (unsigned3)l.NUM_EMPLOYEES_ACTUAL <> 0 => (unsigned3)l.NUM_EMPLOYEES_ACTUAL,
								  l.EMPLOYEE_SIZE_CD <> '' => case(l.EMPLOYEE_SIZE_CD,
								    'A' => 4,
								    'B' => 9,
								    'C' => 19,
								    'D' => 49,
								    'E' => 99,
								    'F' => 249,
								    'G' => 499,
								    'H' => 999,
								    'I' => 4999,
								    'J' => 9999,
								    'K' => 10000,
								     0),
								  0);
self.infousa_revenues := case(l.SALES_VOLUME_CD,
                                    'A' => 250000,
                                    'B' => 750000,
                                    'C' => 1750000,
                                    'D' => 3750000,
                                    'E' => 7500000,
                                    'F' => 15000000,
                                    'G' => 35000000,
                                    'H' => 75000000,
                                    'I' => 300000000,
                                    'J' => 750000000,
                                    'K' => 1000000000,
							 0);
self := l;
end;

iusa_info := project(iusa, GetIUSAInfo(left));
iusa_info_dist := distribute(iusa_info, hash(bdid));
iusa_info_sort := sort(iusa_info_dist, bdid, -infousa_revenues, -infousa_number_employees, local);
iusa_info_dedup := dedup(iusa_info_sort, bdid, local);

layout_stats AppendIUSAInfo(layout_stats l, layout_iusa_info r) := transform
self.infousa_revenues := r.infousa_revenues;
self.infousa_number_employees := r.infousa_number_employees;
self := l;
end;

stats_iusa := join(stats_dca,
               iusa_info_dedup,
			left.bdid = right.bdid,
			AppendIUSAInfo(left, right),
			left outer,
			local);

setJtypes := [
'AC',
'AJ',
'AP',
'AS',
'BN',
'CJ',
'CP',
'CS',
'DD',
'DJ',
'FC',
'FD',
'FF',
'FJ',
'FN',
'FO',
'JF',
'JP',
'SC',
'CD',
'DF',
'DS',
'FK',
'FL',
'FP',
'FV',
'RC',
'RD',
'RL',
'RM',
'RS',
'VJ'

];
			
// Append maximum judgment amount
lj := Bankrupt.File_Liens((unsigned6)bdid <> 0, filetypeid in setJtypes, (unsigned6)amount > 0);

layout_lj_info := record
unsigned6 bdid := (unsigned6)lj.bdid;
unsigned6 amount := (unsigned6)lj.amount;
end;

lj_info := table(lj, layout_lj_info);
lj_info_dist := distribute(lj_info, hash(bdid));
lj_info_sort := sort(lj_info_dist, bdid, -amount, local);
lj_info_dedup := dedup(lj_info_sort, bdid, local);

layout_stats AppendLJInfo(layout_stats l, layout_lj_info r) := transform
self.judgment_amount := r.amount;
self := l;
end;

stats_lj := join(stats_iusa,
               lj_info_dedup,
			left.bdid = right.bdid,
			AppendLJInfo(left, right),
			left outer,
			local);
			
// Determine Organizational Type from Corporate Data
layout_corp_type_append := record
stats_bdid_list.bdid;
string60 corp_org_type := '';
end;

corp_type_init := table(stats_bdid_list, layout_corp_type_append);
corp_type_init_dist := distribute(corp_type_init, hash(bdid));

// Join to corp base to determine business type
corp_base := Corp.File_Corp_Base(record_type =  'C', bdid <> 0);

layout_corp_type := record
corp_base.bdid;
corp_base.corp_orig_org_structure_desc;
end;

corp_base_types := table(corp_base(corp_orig_org_structure_desc <> ''), layout_corp_type);
corp_base_types_dedup := dedup(corp_base_types, all);
corp_base_types_dist := distribute(corp_base_types_dedup, hash(bdid));

corp_business_type := join(corp_type_init_dist,
                           corp_base_types_dist,
					  left.bdid = right.bdid,
					  transform(layout_corp_type_append, self.corp_org_type := right.corp_orig_org_structure_desc, self := left),
					  left outer,
					  keep(1),
					  local);
					  
// Append corp org type
layout_stats AppendCorpInfo(layout_stats l, layout_corp_type_append r) := transform
self.corp_org_type := r.corp_org_type;
self := l;
end;

stats_corp := join(stats_lj,
                   corp_business_type,
			    left.bdid = right.bdid,
			    AppendCorpInfo(left, right),
			    left outer,
			    local);

			
// Append base record count
bhstats := Business_Header.File_Business_Header_Stats;

layout_base_count := record
bhstats.bdid;
bhstats.base_record_count;
end;

bh_base_count := table(bhstats, layout_base_count);

layout_stats AppendBaseCount(layout_stats l, layout_base_count r) := transform
self.base_record_count := r.base_record_count;
self := l;
end;

stats_base := join(stats_corp,
                   bh_base_count,
			    left.bdid = right.bdid,
			    AppendBaseCount(left, right),
			    left outer,
			    local) : persist('TMTEMP::ABN_AMRO_Business_Demographic_Stats_Base');

// Check Revenues for small business max
boolean ChkRevenues(unsigned6 dnb_revenues,
                    unsigned6 dca_revenues,
			     unsigned6 infousa_revenues,
				unsigned6 revenue_max) :=
			   
			   (dnb_revenues + dca_revenues + infousa_revenues) > 0 and
			      not (dnb_revenues > revenue_max or dca_revenues > revenue_max or infousa_revenues > revenue_max);

unsigned6 MaxRevenue(unsigned6 rev1, unsigned6 rev2, unsigned6 rev3) := 
                     map(rev1 <> 0 and rev1 >= rev2 and rev1 >= rev3 => rev1,
				     rev2 <> 0 and rev2 >= rev1 and rev2 >= rev3 => rev2,
					rev3 <> 0 and rev3 >= rev1 and rev3 >= rev2 => rev3,
					0);


// Stat to breakout revenue into ranges
layout_revenue_slim := record
unsigned6 revenue := MaxRevenue(stats_base.dnb_revenues, stats_base.infousa_revenues, stats_base.dca_revenues);
end;

revenue_slim := table(stats_base, layout_revenue_slim);

layout_revenue_stat := record
total_business_cnt := count(group);
rev_0 := count(group, revenue_slim.revenue = 0);
rev_0_to_250K := count(group, revenue_slim.revenue > 0 and revenue_slim.revenue <= 250000);
rev_250K_to_500K := count(group, revenue_slim.revenue > 250000 and revenue_slim.revenue <= 500000);
rev_500K_to_1M := count(group, revenue_slim.revenue > 500000 and revenue_slim.revenue <= 1000000);
rev_1M_to_5M := count(group, revenue_slim.revenue > 1000000 and revenue_slim.revenue <= 5000000);
rev_5M_to_10M := count(group, revenue_slim.revenue > 5000000 and revenue_slim.revenue <= 10000000);
rev_10M_to_25M := count(group, revenue_slim.revenue > 10000000 and revenue_slim.revenue <= 250000000);
rev_GT_25M := count(group, revenue_slim.revenue > 250000000);
end;

revenue_stat := table(revenue_slim, layout_revenue_stat);

output(revenue_stat, named('Business_Revenue_Range_Stat'));






