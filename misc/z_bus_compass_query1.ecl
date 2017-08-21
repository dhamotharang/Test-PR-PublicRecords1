import tm_test;

input_ds := dataset('~thor_data400::TMTEST::compass_bdid_did_prep', TM_Test.Layout_Compass_Test_Base, flat);

my_layout := record
string30 SALES_VOLUME_DESC;
string30 EMPLOYEE_SIZE_DESC;
TM_Test.Layout_Compass_Test_Base;
end;

my_layout in_to_my(input_ds l) := transform
self.employee_size_desc :=map(l.employee_size='A' => '1-4',
							  l.employee_size='B' => '5-9',
							  l.employee_size='C' => '10-19',
							  l.employee_size='D' => '20-49',
							  l.employee_size='E' => '50-99',
							  l.employee_size='F' => '100-249',
							  l.employee_size='G' => '250-499',
							  l.employee_size='H' => '500-999',
							  l.employee_size='I' => '1,000-4,999',
							  l.employee_size='J' => '5,000+',
							  l.employee_size='U' => 'Unknown',
							  l.employee_size<>'' => 'Bad Value','');
self.sales_volume_desc  :=map(l.sales_volume='A' => '<500,000',
							  l.sales_volume='B' => '500,000-1M',
							  l.sales_volume='C' => '1M-2M',
							  l.sales_volume='D' => '2M-5M',
							  l.sales_volume='E' => '5M-10M',
							  l.sales_volume='F' => '10M-20M',
							  l.sales_volume='G' => '20M-50M',
							  l.sales_volume='H' => '50M-100M',
							  l.sales_volume='I' => '100M+',
							  l.sales_volume='U' => 'Unknown',
							  l.sales_volume<>'' => 'Bad Value','');
self := l;
end;

my_ds := project(input_ds,in_to_my(left));

export bus_compass_query1 := my_ds : persist('~thor_data400::misc::bus_compass_query1_20060814');
/*

output(my_ds);

s_stat_layout := record
string30		sales_volume_desc		:= my_ds.sales_volume_desc;
string 			Sales_Volume			:= my_ds.Sales_Volume;
integer4 		b_total					:= count(group);
end;
s_stat := table(my_ds, s_stat_layout, sales_volume_desc,Sales_Volume, few);
srt_s_stat := sort(s_stat,Sales_Volume);
output(srt_s_stat);

e_stat_layout := record
string30		employee_size_desc		:= my_ds.employee_size_desc;
string 			Employee_Size			:= my_ds.Employee_Size;
integer4 		b_total					:= count(group);
end;
e_stat := table(my_ds, e_stat_layout, Employee_size_desc,Employee_Size, few);
srt_e_stat := sort(e_stat,Employee_Size);
output(srt_e_stat);

bdid_count := count(dedup(sort(distribute(my_ds,hash(bdid)),bdid,local),bdid,local));
output(bdid_count);

did_count := count(dedup(sort(distribute(my_ds,hash(did)),did,local),did,local));
output(did_count);
*/
