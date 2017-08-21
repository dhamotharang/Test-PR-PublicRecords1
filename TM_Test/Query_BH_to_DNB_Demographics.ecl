layout_bdid_list := record
unsigned6 bdid;
unsigned6 group_id := 0;
end;

// List of Business Header BDIDs not in D&B
bh_list_nondnb := dataset('~thor_data400::TMTEST::Demographic_BDID_List_NonDNB', layout_bdid_list, flat);				   

// List of D&B BDIDS
db_list := dataset('~thor_data400::TMTEST::Demographic_BDID_List_DNB', layout_bdid_list, flat);	

// Revenue and Employee Count Tables
layout_bdid_revenue := record
unsigned6 bdid;
unsigned6 group_id;
unsigned6 revenues;
string2 source;
end;

revenue_table := dataset('~thor_data400::TMTEST::Demographic_Revenue_Table', layout_bdid_revenue, flat);
revenue_table_dist := distribute(revenue_table, hash(bdid));

layout_bdid_number_employees := record
unsigned6 bdid;
unsigned6 group_id;
unsigned3 number_employees;
string2 source;
end;

number_employees_table := dataset('~thor_data400::TMTEST::Demographic_Number_Employees_Table', layout_bdid_number_employees, flat);
number_employees_table_dist := distribute(number_employees_table, hash(bdid));

// Find BDID overlap and non-overlap
bh_bdid_only := join(bh_list_nondnb,
                     db_list,
				 left.bdid = right.bdid,
				 transform(layout_bdid_list, self := left),
				 left only,
				 hash);
				 
db_bdid_only := join(bh_list_nondnb,
                     db_list,
				 left.bdid = right.bdid,
				 transform(layout_bdid_list, self := right),
				 right only,
				 hash);
				 
bh_db_bdid_overlap := join(bh_list_nondnb,
                      db_list,
				  left.bdid = right.bdid,
				  transform(layout_bdid_list, self := left),
				  hash);

// Keep highest revenue amounts
bh_revenue_table_sort := sort(revenue_table_dist(source <> 'D'), bdid, -revenues, local);
bh_revenue_table_dedup := dedup(bh_revenue_table_sort, bdid, local);

dnb_revenue_table_sort := sort(revenue_table_dist(source = 'D'), bdid, -revenues, local);
dnb_revenue_table_dedup := dedup(dnb_revenue_table_sort, bdid, local);

all_revenue_table_sort := sort(revenue_table_dist, bdid, -revenues, local);
all_revenue_table_dedup := dedup(all_revenue_table_sort, bdid, local);

// Keep highest employee count
bh_number_employees_table_sort := sort(number_employees_table_dist(source <> 'D'), bdid, -number_employees, local);
bh_number_employees_table_dedup := dedup(bh_number_employees_table_sort, bdid, local);

dnb_number_employees_table_sort := sort(number_employees_table_dist(source = 'D'), bdid, -number_employees, local);
dnb_number_employees_table_dedup := dedup(dnb_number_employees_table_sort, bdid, local);

all_number_employees_table_sort := sort(number_employees_table_dist, bdid, -number_employees, local);
all_number_employees_table_dedup := dedup(all_number_employees_table_sort, bdid, local);


// Append Revenue and Employee Counts to common file
layout_demographic_bdid := record
unsigned6 bdid;
unsigned6 group_id;
string2 overlap;
unsigned6 revenues := 0;
unsigned3  number_employees := 0;
end;

dmg_bh_bdid_only_init := project(bh_bdid_only,
                                 transform(layout_demographic_bdid,
					        self.overlap := 'BO',
					        self := left));
						   
dmg_bh_bdid_only_dist := distribute(dmg_bh_bdid_only_init, hash(bdid));
					  
dmg_db_bdid_only_init := project(db_bdid_only,
                                 transform(layout_demographic_bdid,
					        self.overlap := 'DO',
					        self := left));

dmg_db_bdid_only_dist := distribute(dmg_db_bdid_only_init, hash(bdid));

dmg_bh_db_bdid_overlap_init := project(bh_db_bdid_overlap,
                                       transform(layout_demographic_bdid,
					              self.overlap := 'OV',
					              self := left));

dmg_bh_db_bdid_overlap_dist := distribute(dmg_bh_db_bdid_overlap_init, hash(bdid));

layout_demographic_bdid AppendRevenues(layout_demographic_bdid l, layout_bdid_revenue r) := transform
self.revenues := r.revenues;
self := l;
end;

dmg_bh_bdid_only_revenue_append := join(dmg_bh_bdid_only_dist,
                                        bh_revenue_table_dedup,
					               left.bdid = right.bdid,
					               AppendRevenues(left, right),
					               left outer,
					               local);

dmg_db_bdid_only_revenue_append := join(dmg_db_bdid_only_dist,
                                        dnb_revenue_table_dedup,
					               left.bdid = right.bdid,
					               AppendRevenues(left, right),
					               left outer,
					               local);

dmg_bh_db_bdid_overlap_revenue_append := join(dmg_bh_db_bdid_overlap_dist,
                                              all_revenue_table_dedup,
					                     left.bdid = right.bdid,
					                     AppendRevenues(left, right),
					                     left outer,
					                     local);

				  
layout_demographic_bdid AppendNumberEmployees(layout_demographic_bdid l, layout_bdid_number_employees r) := transform
self.number_employees := r.number_employees;
self := l;
end;

dmg_bh_bdid_only_number_employees_append := join(dmg_bh_bdid_only_revenue_append,
                                                 bh_number_employees_table_dedup,
					                        left.bdid = right.bdid,
					                        AppendNumberEmployees(left, right),
					                        left outer,
					                        local);

dmg_db_bdid_only_number_employees_append := join(dmg_db_bdid_only_revenue_append,
                                                 dnb_number_employees_table_dedup,
					                        left.bdid = right.bdid,
					                        AppendNumberEmployees(left, right),
					                        left outer,
					                        local);

dmg_bh_db_bdid_overlap_number_employees_append := join(dmg_bh_db_bdid_overlap_revenue_append,
                                                       all_number_employees_table_dedup,
					                              left.bdid = right.bdid,
					                              AppendNumberEmployees(left, right),
					                              left outer,
					                              local);

dmg_all := dmg_bh_bdid_only_number_employees_append +
           dmg_db_bdid_only_number_employees_append +
		 dmg_bh_db_bdid_overlap_number_employees_append : persist('TMTEST::Demographics_Append_All');
		 
layout_dmg_stat := record
dmg_all.overlap;
total_records := count(group);
number_employees_not_available := count(group, dmg_all.number_employees = 0);
number_employees_1_to_10 := count(group, dmg_all.number_employees >= 1 and dmg_all.number_employees <= 10);
number_employees_11_to_25 := count(group, dmg_all.number_employees >= 11 and dmg_all.number_employees <= 25);
number_employees_26_to_50 := count(group, dmg_all.number_employees >= 26 and dmg_all.number_employees <= 50);
number_employees_51_to_100 := count(group, dmg_all.number_employees >= 51 and dmg_all.number_employees <= 100);
number_employees_101_to_300 := count(group, dmg_all.number_employees >= 101 and dmg_all.number_employees <= 300);
number_employees_301_plus := count(group, dmg_all.number_employees >= 301);
revenues_not_available := count(group, dmg_all.revenues = 0);
revenues_1_to_499999 := count(group, dmg_all.revenues >= 1 and dmg_all.revenues <= 499999);
revenues_500000_to_999999 := count(group, dmg_all.revenues >= 500000 and dmg_all.revenues <= 999999);
revenues_1000000_to_2499999 := count(group, dmg_all.revenues >= 1000000 and dmg_all.revenues <= 2499999);
revenues_2500000_to_4999999 := count(group, dmg_all.revenues >= 2500000 and dmg_all.revenues <= 4999999);
revenues_5000000_to_9999999 := count(group, dmg_all.revenues >= 5000000 and dmg_all.revenues <= 9999999);
revenues_10000000_to_19999999 := count(group, dmg_all.revenues >= 10000000 and dmg_all.revenues <= 19999999);
revenues_20000000_to_49999999 := count(group, dmg_all.revenues >= 20000000 and dmg_all.revenues <= 49999999);
revenues_50000000_to_99999999 := count(group, dmg_all.revenues >= 50000000 and dmg_all.revenues <= 99999999);
revenues_100000000_to_499999999 := count(group, dmg_all.revenues >= 100000000 and dmg_all.revenues <= 499999999);
revenues_500000000_to_999999999 := count(group, dmg_all.revenues >= 500000000 and dmg_all.revenues <= 999999999);
revenues_1000000000_plus := count(group, dmg_all.revenues >= 1000000000);
end;

dmg_stat := table(dmg_all, layout_dmg_stat, overlap, few);

output(dmg_stat, all);
