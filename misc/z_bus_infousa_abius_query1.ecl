import infousa;

input_ds := infousa.File_ABIUS_Company_Base(st='FL' or st2='FL' or st='CA' or st2='CA');

my_layout := record
string30 POPULATION_DESC;
string30 EMPLOYEE_SIZE_DESC;
string30 OFFICE_SIZE_DESC;
string30 TOTAL_EMPLOYEE_SIZE_DESC;
string6 relo_NUM_EMPLOYEES_ACTUAL;
string6 relo_TOTAL_EMPLOYEES_ACTUAL;
string30 SALES_VOLUME_DESC;
string30 TOTAL_OUTPUT_SALES_DESC;
InfoUSA.Layout_ABIUS_Company_Base;
end;

my_layout in_to_my(input_ds l) := transform
self.relo_num_employees_actual := l.num_employees_actual;
self.relo_total_employees_actual := l.total_employees_actual;
self.population_desc := map(l.population_cd='1' => '1-24,999',
							l.population_cd='5' => '25,000-49,999',
							l.population_cd='6' => '50,000-99,999',
							l.population_cd='7' => '100,000-249,999',
							l.population_cd='8' => '250,000-499,999',
							l.population_cd='9' => '500,000+',
							l.population_cd<>'' => 'Bad Value', '');
self.office_size_desc :=map(l.office_size_cd='A' => '1 Professional',
							l.office_size_cd='B' => '2 Professionals',
							l.office_size_cd='C' => '3 Professionals',
							l.office_size_cd='D' => '4 Professionals',
							l.office_size_cd='E' => '5-9 Professionals',
							l.office_size_cd='F' => '10+ Professionals',
							l.office_size_cd<>'' => 'Bad Value','');
self.employee_size_desc :=map(l.employee_size_cd='A' => '1-4',
							  l.employee_size_cd='B' => '5-9',
							  l.employee_size_cd='C' => '10-19',
							  l.employee_size_cd='D' => '20-49',
							  l.employee_size_cd='E' => '50-99',
							  l.employee_size_cd='F' => '100-249',
							  l.employee_size_cd='G' => '250-499',
							  l.employee_size_cd='H' => '500-999',
							  l.employee_size_cd='I' => '1,000-4,999',
							  l.employee_size_cd='J' => '5,000-9,999',
							  l.employee_size_cd='K' => '10,000+',
							  l.employee_size_cd<>'' => 'Bad Value','');
self.total_employee_size_desc :=map(l.total_employee_size_cd='A' => '1-4',
							  l.total_employee_size_cd='B' => '5-9',
							  l.total_employee_size_cd='C' => '10-19',
							  l.total_employee_size_cd='D' => '20-49',
							  l.total_employee_size_cd='E' => '50-99',
							  l.total_employee_size_cd='F' => '100-249',
							  l.total_employee_size_cd='G' => '250-499',
							  l.total_employee_size_cd='H' => '500-999',
							  l.total_employee_size_cd='I' => '1,000-4,999',
							  l.total_employee_size_cd='J' => '5,000-9,999',
							  l.total_employee_size_cd='K' => '10,000+',
							  l.total_employee_size_cd<>'' => 'Bad Value','');
self.sales_volume_desc  :=map(l.sales_volume_cd='A' => '<500,000',
							  l.sales_volume_cd='B' => '500,000-1M',
							  l.sales_volume_cd='C' => '1M-2.5M',
							  l.sales_volume_cd='D' => '2.5M-5M',
							  l.sales_volume_cd='E' => '5M-10M',
							  l.sales_volume_cd='F' => '10M-20M',
							  l.sales_volume_cd='G' => '20M-50M',
							  l.sales_volume_cd='H' => '50M-100M',
							  l.sales_volume_cd='I' => '100M-500M',
							  l.sales_volume_cd='J' => '500M-1B',
							  l.sales_volume_cd='K' => '1B+',
							  l.sales_volume_cd<>'' => 'Bad Value','');
self.TOTAL_OUTPUT_SALES_DESC  :=map(l.TOTAL_OUTPUT_SALES_cd='A' => '<500,000',
							  l.TOTAL_OUTPUT_SALES_cd='B' => '500,000-1M',
							  l.TOTAL_OUTPUT_SALES_cd='C' => '1M-2.5M',
							  l.TOTAL_OUTPUT_SALES_cd='D' => '2.5M-5M',
							  l.TOTAL_OUTPUT_SALES_cd='E' => '5M-10M',
							  l.TOTAL_OUTPUT_SALES_cd='F' => '10M-20M',
							  l.TOTAL_OUTPUT_SALES_cd='G' => '20M-50M',
							  l.TOTAL_OUTPUT_SALES_cd='H' => '50M-100M',
							  l.TOTAL_OUTPUT_SALES_cd='I' => '100M-500M',
							  l.TOTAL_OUTPUT_SALES_cd='J' => '500M-1B',
							  l.TOTAL_OUTPUT_SALES_cd='K' => '1B+',
							  l.TOTAL_OUTPUT_SALES_cd<>'' => 'Bad Value','');

self := l;
end;

my_ds := project(input_ds,in_to_my(left));

export bus_infousa_abius_query1 := my_ds : persist('~thor_data400::misc::bus_infousa_abius_query1_20060814');


/*
did_count := count(dedup(sort(distribute(my_ds,hash(did)),did,local),did,local));
output(did_count);
*/
//x  string6 NUM_EMPLOYEES_ACTUAL;
//x  string6 TOTAL_EMPLOYEES_ACTUAL;
//output(my_ds);

/*
s_stat_layout := record
string			sales_volume_cd				:= my_ds.sales_volume_cd;
string30		Sales_Volume_desc			:= my_ds.Sales_Volume_desc;
integer4 		b_total					:= count(group);
end;
s_stat := table(my_ds, s_stat_layout, sales_volume_cd,Sales_Volume_desc, few);
srt_s_stat := sort(s_stat,Sales_Volume_cd);
output(srt_s_stat);

s2_stat_layout := record
string			total_output_sales_cd	:= my_ds.total_output_sales_cd;
string30		TOTAL_OUTPUT_SALES_desc	:= my_ds.TOTAL_OUTPUT_SALES_desc;
integer4 		b_total					:= count(group);
end;
s2_stat := table(my_ds, s2_stat_layout, total_output_sales_cd,TOTAL_OUTPUT_SALES_desc, few);
srt_s2_stat := sort(s2_stat,TOTAL_OUTPUT_SALES_cd);
output(srt_s2_stat);

e_stat_layout := record
string			employee_size_cd		:= my_ds.employee_size_cd;
string30		Employee_Size_desc		:= my_ds.Employee_Size_desc;
integer4 		b_total					:= count(group);
end;
e_stat := table(my_ds, e_stat_layout, employee_size_cd,Employee_Size_desc, few);
srt_e_stat := sort(e_stat,Employee_Size_cd);
output(srt_e_stat);

e2_stat_layout := record
string			total_employee_size_cd			:= my_ds.total_employee_size_cd;
string30 			TOTAL_EMPLOYEE_SIZE_desc	:= my_ds.TOTAL_EMPLOYEE_SIZE_desc;
integer4 		b_total					:= count(group);
end;
e2_stat := table(my_ds, e2_stat_layout, total_employee_size_cd,TOTAL_EMPLOYEE_SIZE_desc, few);
srt_e2_stat := sort(e2_stat,TOTAL_EMPLOYEE_SIZE_cd);
output(srt_e2_stat);

e3_stat_layout := record
string				population_cd		:= my_ds.population_cd;
string30 			POPULATION_desc		:= my_ds.POPULATION_desc;
integer4 		b_total					:= count(group);
end;
e3_stat := table(my_ds, e3_stat_layout, population_cd,POPULATION_desc, few);
srt_e3_stat := sort(e3_stat,POPULATION_cd);
output(srt_e3_stat);


e4_stat_layout := record
string			office_size_cd			:= my_ds.office_size_cd;
string30		OFFICE_SIZE_desc		:= my_ds.OFFICE_SIZE_desc;
integer4 		b_total					:= count(group);
end;
e4_stat := table(my_ds, e4_stat_layout, office_size_cd,OFFICE_SIZE_desc, few);
srt_e4_stat := sort(e4_stat,OFFICE_SIZE_cd);
output(srt_e4_stat);

bdid_count := count(dedup(sort(distribute(my_ds,hash(bdid)),bdid,local),bdid,local));
output(bdid_count);
*/
