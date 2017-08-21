import dnb;

input_ds_bus := dnb.File_DNB_Base(mail_st='FL' or mail_st='CA' or st='FL' or st='CA');
my_ds_peo := dnb.File_DNB_Contacts_Base(company_st='FL' or company_st='CA');

my_i_layout := record
unsigned6 i_annual_sales_volume;
unsigned6 i_employees_here;
unsigned6 i_employees_total;
dnb.Layout_DNB_Base;
end;
my_i_layout in_to_my_i(input_ds_bus l) := transform
self.i_annual_sales_volume := (integer) (l.annual_sales_volume);
self.i_employees_here := (integer) l.employees_here;
self.i_employees_total := (integer) l.employees_total;
self := l;
end;
my_i_ds := project(input_ds_bus,in_to_my_i(left));

my_c_layout := record
string1	my_annual_sales_volume_cd; 
unsigned6 i_annual_sales_volume;
string1	my_employees_here_cd; 
unsigned6 i_employees_here;
string1	my_employees_total_cd;
unsigned6 i_employees_total;
dnb.Layout_DNB_Base;
end;
my_c_layout my_i_to_my_c(my_i_ds l) := transform
self.my_annual_sales_volume_cd := 	
		map(l.i_annual_sales_volume<>0 and l.i_annual_sales_volume<500000 => 'A',
		    l.i_annual_sales_volume >=500000   and l.i_annual_sales_volume<1000000 => 'B',
		    l.i_annual_sales_volume >=1000000 and l.i_annual_sales_volume<2500000 => 'C',
		    l.i_annual_sales_volume >=2500000 and l.i_annual_sales_volume<5000000 => 'D',
	        l.i_annual_sales_volume >=5000000 and l.i_annual_sales_volume<10000000 => 'E',
		    l.i_annual_sales_volume >=10000000 and l.i_annual_sales_volume<20000000 => 'F',
		    l.i_annual_sales_volume >=20000000 and l.i_annual_sales_volume<50000000 => 'G',
		    l.i_annual_sales_volume >=50000000 and l.i_annual_sales_volume<100000000 => 'H',
		    l.i_annual_sales_volume >=100000000 and l.i_annual_sales_volume<500000000 => 'I',
		    l.i_annual_sales_volume >=500000000 and l.i_annual_sales_volume<1000000000 => 'J',
		    l.i_annual_sales_volume >=1000000000 => 'K',
			l.i_annual_sales_volume =0 => ' ','X');
self.my_employees_here_cd := 
		map(l.i_employees_here>0 and l.i_employees_here<=4 => 'A',
		    l.i_employees_here>=5 and l.i_employees_here<=9 => 'B',
		    l.i_employees_here>=10 and l.i_employees_here<=19 => 'C',
		    l.i_employees_here>=20 and l.i_employees_here<=49 => 'D',
		    l.i_employees_here>=50 and l.i_employees_here<=99 => 'E',
		    l.i_employees_here>=100 and l.i_employees_here<=249 => 'F',
		    l.i_employees_here>=250 and l.i_employees_here<=499 => 'G',
		    l.i_employees_here>=500 and l.i_employees_here<=999 => 'H',
		    l.i_employees_here>=1000 and l.i_employees_here<=4999 => 'I',
		    l.i_employees_here>=5000 and l.i_employees_here<=9999 => 'J',
		    l.i_employees_here>=10000 => 'K',
		    l.i_employees_here=0 => ' ','X');
self.my_employees_total_cd := 
		map(l.i_employees_total>0 and l.i_employees_total<=4 => 'A',
		    l.i_employees_total>=5 and l.i_employees_total<=9 => 'B',
		    l.i_employees_total>=10 and l.i_employees_total<=19 => 'C',
		    l.i_employees_total>=20 and l.i_employees_total<=49 => 'D',
		    l.i_employees_total>=50 and l.i_employees_total<=99 => 'E',
		    l.i_employees_total>=100 and l.i_employees_total<=249 => 'F',
		    l.i_employees_total>=250 and l.i_employees_total<=499 => 'G',
		    l.i_employees_total>=500 and l.i_employees_total<=999 => 'H',
		    l.i_employees_total>=1000 and l.i_employees_total<=4999 => 'I',
		    l.i_employees_total>=5000 and l.i_employees_total<=9999 => 'J',
		    l.i_employees_total>=10000 => 'K',
		    l.i_employees_total=0 => ' ','X');
self := l;
end;
my_c_ds := project(my_i_ds,my_i_to_my_c(left));

my_d_layout := record
string1	my_annual_sales_volume_cd;
string30 annual_sales_volume_desc; 
unsigned6 i_annual_sales_volume;
string1	my_employees_here_cd; 
string30 employees_here_desc; 
unsigned6 i_employees_here;
string1	my_employees_total_cd;
string30 employees_total_desc; 
unsigned6 i_employees_total;
dnb.Layout_DNB_Base;
end;
my_d_layout my_c_to_my_d(my_c_ds l) := transform
self.annual_sales_volume_desc :=
				          map(l.my_annual_sales_volume_cd='A' => '<500,000',
							  l.my_annual_sales_volume_cd='B' => '500,000-1M',
							  l.my_annual_sales_volume_cd='C' => '1M-2.5M',
							  l.my_annual_sales_volume_cd='D' => '2.5M-5M',
							  l.my_annual_sales_volume_cd='E' => '5M-10M',
							  l.my_annual_sales_volume_cd='F' => '10M-20M',
							  l.my_annual_sales_volume_cd='G' => '20M-50M',
							  l.my_annual_sales_volume_cd='H' => '50M-100M',
							  l.my_annual_sales_volume_cd='I' => '100M-500M',
							  l.my_annual_sales_volume_cd='J' => '500M-1B',
							  l.my_annual_sales_volume_cd='K' => '1B+',
							  l.my_annual_sales_volume_cd<>'' => 'Bad Value','');
self.employees_here_desc :=							  
                          map(l.my_employees_here_cd='A' => '1-4',
							  l.my_employees_here_cd='B' => '5-9',
							  l.my_employees_here_cd='C' => '10-19',
							  l.my_employees_here_cd='D' => '20-49',
							  l.my_employees_here_cd='E' => '50-99',
							  l.my_employees_here_cd='F' => '100-249',
							  l.my_employees_here_cd='G' => '250-499',
							  l.my_employees_here_cd='H' => '500-999',
							  l.my_employees_here_cd='I' => '1,000-4,999',
							  l.my_employees_here_cd='J' => '5,000-9,999',
							  l.my_employees_here_cd='K' => '10,000+',
							  l.my_employees_here_cd<>'' => 'Bad Value','');
self.employees_total_desc := 
                          map(l.my_employees_total_cd='A' => '1-4',
							  l.my_employees_total_cd='B' => '5-9',
							  l.my_employees_total_cd='C' => '10-19',
							  l.my_employees_total_cd='D' => '20-49',
							  l.my_employees_total_cd='E' => '50-99',
							  l.my_employees_total_cd='F' => '100-249',
							  l.my_employees_total_cd='G' => '250-499',
							  l.my_employees_total_cd='H' => '500-999',
							  l.my_employees_total_cd='I' => '1,000-4,999',
							  l.my_employees_total_cd='J' => '5,000-9,999',
							  l.my_employees_total_cd='K' => '10,000+',
							  l.my_employees_total_cd<>'' => 'Bad Value','');
self := l;
end;
my_d_ds := project(my_c_ds,my_c_to_my_d(left));


export bus_dnb_dmi_query1 := my_d_ds : persist('~thor_data400::misc::bus_dnb_dmi_query1_20060814');

/*
output(my_d_ds);
output(my_ds_peo);


s_stat_layout := record
string1	my_annual_sales_volume_cd		:= my_d_ds.my_annual_sales_volume_cd;
string30 annual_sales_volume_desc		:= my_d_ds.annual_sales_volume_desc;
integer4 		b_total					:= count(group);
end;
s_stat := table(my_d_ds, s_stat_layout,my_annual_sales_volume_cd,annual_sales_volume_desc, few);
srt_s_stat := sort(s_stat,my_annual_sales_volume_cd);
output(srt_s_stat);


e_stat_layout := record
string1	my_employees_here_cd	:=my_d_ds.my_employees_here_cd;
string30 employees_here_desc	:=my_d_ds.employees_here_desc;
integer4 		b_total					:= count(group);
end;
e_stat := table(my_d_ds, e_stat_layout, my_employees_here_cd,employees_here_desc , few);
srt_e_stat := sort(e_stat,my_employees_here_cd);
output(srt_e_stat);

e2_stat_layout := record
string1	my_employees_total_cd	:=my_d_ds.my_employees_total_cd;
string30 employees_total_desc	:=my_d_ds.employees_total_desc;
integer4 		b_total					:= count(group);
end;
e2_stat := table(my_d_ds, e2_stat_layout, my_employees_total_cd,employees_total_desc , few);
srt_e2_stat := sort(e2_stat,my_employees_total_cd);
output(srt_e2_stat);



bdid_count := count(dedup(sort(distribute(my_d_ds,hash(bdid)),bdid,local),bdid,local));
output(bdid_count);

did_count := count(dedup(sort(distribute(my_ds_peo,hash(did)),did,local),did,local));
output(did_count);


*/
