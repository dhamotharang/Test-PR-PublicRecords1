// Query to determine breakout of D&B companies by employee count
f := DNB.File_DNB_Base(record_type='C');

// employee count fields are:
// employees_here, employees_total, base_employment_total


layout_slim := record
unsigned4 employees_here := (unsigned4)f.employees_here;
unsigned4 employees_total := (unsigned4)f.employees_total;
unsigned4 base_employment_total := (unsigned4)f.base_employment_total;
end;

fslim := table(f, layout_slim);

layout_stat := record
cnt_total_records := count(group);
// employees_here
cnt_emphere_zero := count(group, fslim.employees_here = 0);
cnt_emphere_1_10 := count(group, fslim.employees_here between 1 and 10);
cnt_emphere_11_20 := count(group, fslim.employees_here between 11 and 20);
cnt_emphere_21_30 := count(group, fslim.employees_here between 21 and 30);
cnt_emphere_31_40 := count(group, fslim.employees_here between 31 and 40);
cnt_emphere_41_50 := count(group, fslim.employees_here between 41 and 50);
cnt_emphere_51_100 := count(group, fslim.employees_here between 51 and 100);
cnt_emphere_101_250 := count(group, fslim.employees_here between 101 and 250);
cnt_emphere_251_500 := count(group, fslim.employees_here between 251 and 500);
cnt_emphere_501_1000 := count(group, fslim.employees_here between 501 and 1000);
cnt_emphere_1001_2000 := count(group, fslim.employees_here between 1001 and 2000);
cnt_emphere_2001_3000 := count(group, fslim.employees_here between 2001 and 3000);
cnt_emphere_3001_4000 := count(group, fslim.employees_here between 3001 and 4000);
cnt_emphere_4001_5000 := count(group, fslim.employees_here between 4001 and 5000);
cnt_emphere_gt_5000:= count(group, fslim.employees_here > 5000);
// employees_total
cnt_emptotal_zero := count(group, fslim.employees_total = 0);
cnt_emptotal_1_10 := count(group, fslim.employees_total between 1 and 10);
cnt_emptotal_11_20 := count(group, fslim.employees_total between 11 and 20);
cnt_emptotal_21_30 := count(group, fslim.employees_total between 21 and 30);
cnt_emptotal_31_40 := count(group, fslim.employees_total between 31 and 40);
cnt_emptotal_41_50 := count(group, fslim.employees_total between 41 and 50);
cnt_emptotal_51_100 := count(group, fslim.employees_total between 51 and 100);
cnt_emptotal_101_250 := count(group, fslim.employees_total between 101 and 250);
cnt_emptotal_251_500 := count(group, fslim.employees_total between 251 and 500);
cnt_emptotal_501_1000 := count(group, fslim.employees_total between 501 and 1000);
cnt_emptotal_1001_2000 := count(group, fslim.employees_total between 1001 and 2000);
cnt_emptotal_2001_3000 := count(group, fslim.employees_total between 2001 and 3000);
cnt_emptotal_3001_4000 := count(group, fslim.employees_total between 3001 and 4000);
cnt_emptotal_4001_5000 := count(group, fslim.employees_total between 4001 and 5000);
cnt_emptotal_gt_5000:= count(group, fslim.employees_total > 5000);
// base_employment_total
cnt_empbase_zero := count(group, fslim.base_employment_total = 0);
cnt_empbase_1_10 := count(group, fslim.base_employment_total between 1 and 10);
cnt_empbase_11_20 := count(group, fslim.base_employment_total between 11 and 20);
cnt_empbase_21_30 := count(group, fslim.base_employment_total between 21 and 30);
cnt_empbase_31_40 := count(group, fslim.base_employment_total between 31 and 40);
cnt_empbase_41_50 := count(group, fslim.base_employment_total between 41 and 50);
cnt_empbase_51_100 := count(group, fslim.base_employment_total between 51 and 100);
cnt_empbase_101_250 := count(group, fslim.base_employment_total between 101 and 250);
cnt_empbase_251_500 := count(group, fslim.base_employment_total between 251 and 500);
cnt_empbase_501_1000 := count(group, fslim.base_employment_total between 501 and 1000);
cnt_empbase_1001_2000 := count(group, fslim.base_employment_total between 1001 and 2000);
cnt_empbase_2001_3000 := count(group, fslim.base_employment_total between 2001 and 3000);
cnt_empbase_3001_4000 := count(group, fslim.base_employment_total between 3001 and 4000);
cnt_empbase_4001_5000 := count(group, fslim.base_employment_total between 4001 and 5000);
cnt_empbase_gt_5000:= count(group, fslim.base_employment_total > 5000);
end;

fstat := table(fslim, layout_stat);

output(fstat);

