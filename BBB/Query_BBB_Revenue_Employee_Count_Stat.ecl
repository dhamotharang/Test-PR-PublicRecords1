f := BBB.bbb_clean_bdid;

layout_bbb_bdid_stat := record
bbb_total := count(group);
bbb_nonzero_bdid := count(group, f.bdid <> 0);
bbb_zero_bdid := count(group, f.bdid = 0);
end;

bbb_bdid_stat := table(f, layout_bbb_bdid_stat);
output(bbb_bdid_stat);

layout_bdid_revenue := record
unsigned6 bdid;
unsigned6 revenues;
string2 source;
end;

layout_bdid_number_employees := record
unsigned6 bdid;
unsigned3 number_employees;
string2 source;
end;

revenue_table := dataset('~thor_data400::TMTEST::BBB_Revenue_Table', layout_bdid_revenue, flat);
number_employees_table := dataset('~thor_data400::TMTEST::BBB_Number_Employees_Table', layout_bdid_number_employees, flat);

// Keep highest revenue amount by source
revenue_table_dist := distribute(revenue_table, hash(bdid));
revenue_table_sort := sort(revenue_table_dist, bdid, source, -revenues, local);
revenue_table_dedup := dedup(revenue_table_sort, bdid, source, local);

// Keep highest employee count by source
number_employees_table_dist := distribute(number_employees_table, hash(bdid));
number_employees_table_sort := sort(number_employees_table_dist, bdid, source, -number_employees, local);
number_employees_table_dedup := dedup(number_employees_table_sort, bdid, source, local);

layout_revenue_stat := record
dnb_bdid_count := count(group, revenue_table_dedup.source = 'D');
dca_bdid_count := count(group, revenue_table_dedup.source = 'DC');
iusa_bdid_count := count(group, revenue_table_dedup.source = 'IA');
ebr_bdid_count := count(group, revenue_table_dedup.source = 'EB');
end;

revenue_table_stat := table(revenue_table_dedup, layout_revenue_stat);
output(revenue_table_stat);

layout_number_employees_stat := record
dnb_bdid_count := count(group, number_employees_table_dedup.source = 'D');
dca_bdid_count := count(group, number_employees_table_dedup.source = 'DC');
iusa_bdid_count := count(group, number_employees_table_dedup.source = 'IA');
ebr_bdid_count := count(group, number_employees_table_dedup.source = 'EB');
end;

number_employees_table_stat := table(number_employees_table_dedup, layout_number_employees_stat);
output(number_employees_table_stat);

count(dedup(revenue_table_dedup, bdid, local));
count(dedup(number_employees_table_dedup, bdid, local));




