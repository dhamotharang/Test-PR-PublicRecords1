main_file     := reunion.files.f_main;
cust_file     := reunion.files.f_customer_database;
lssi_file     := reunion.files.f_lssi;
rel_file      := reunion.files.f_relatives;
old_addr_file := reunion.files.f_old_addresses;
deeds_file    := reunion.files.f_deeds;
tax_file      := reunion.files.f_tax;

output(count(main_file),named('main_file_ct'));
output(count(cust_file),named('customer_db_file_ct'));
output(count(lssi_file),named('lssi_file_ct'));
output(count(rel_file),named('relatives_file_ct'));
output(count(old_addr_file),named('old_addresses_file_ct'));
output(count(deeds_file),named('deeds_file_ct'));
output(count(tax_file),named('tax_file_ct'));

main_dist := distribute(main_file,hash(adl));
main_sort := sort(main_dist,adl,local);
main_dupd := dedup(main_sort,adl,all,local);

output(count(main_dupd),named('unique_did_ct_in_main'));//should equal main_file_ct

r1 := record
 integer has_dob      := count(group,main_file.best_dob<>'');
 integer has_phone    := count(group,main_file.phone<>'');
 integer has_dod      := count(group,main_file.date_of_death<>'');
 integer has_job_desc := count(group,main_file.prof_lic_job_desc<>'');
 file_ct := count(group);
end;

ta1 := table(main_file,r1,few);
output(ta1,named('main_field_populations'));

r2 := record
 main_file.adl;
 main_file.best_dob;
 boolean has_no_dob;
 boolean has_full_dob;
 boolean has_year_only;
 boolean has_year_month_only;
end;

r2 t1(main_file le) := transform
 
 string8 v_dob := le.best_dob;
 string4 v_yy  := v_dob[1..4];
 string2 v_mm  := v_dob[5..6];
 string2 v_dd  := v_dob[7..8];
 
 boolean has_yy := trim(v_yy) not in ['0000',''];
 boolean has_mm := trim(v_mm) not in ['00',''];
 boolean has_dd := trim(v_dd) not in ['00',''];
 
 self.has_no_dob          := trim(v_dob)='';
 self.has_full_dob        := self.has_no_dob=false and has_yy=true and has_mm=true  and has_dd=true;
 self.has_year_only       := self.has_no_dob=false and has_yy=true and has_mm=false;// and has_dd=false;
 self.has_year_month_only := self.has_no_dob=false and has_yy=true and has_mm=true  and has_dd=false;
 self                     := le;
end;

p1 := project(main_file,t1(left));

output(p1(has_no_dob=false and has_full_dob=false and has_year_only=false and has_year_month_only=false));
output(p1(has_year_only=true));
output(p1(has_year_month_only=true));

r3 := record
 p1.has_no_dob;
 p1.has_full_dob;
 p1.has_year_only;
 p1.has_year_month_only;
 file_ct := count(group);
end;

ta2 := sort(table(p1,r3,has_no_dob,has_full_dob,has_year_only,has_year_month_only,few),has_full_dob,has_year_only,has_year_month_only,has_no_dob);
output(ta2,named('main_dob_stats'));

rel_dist := distribute(rel_file,hash(relative_adl));
rel_sort := sort(rel_dist,relative_adl,local);
rel_dupd := dedup(rel_sort,relative_adl,all,local);

r4 := record
 integer has_dob      := count(group,rel_dupd.relative_dob<>'');
 integer has_phone    := count(group,rel_dupd.relative_phone<>'');
 integer has_dod      := count(group,rel_dupd.relative_date_of_death<>'');
 file_ct := count(group);
end;

ta3 := table(rel_dupd,r4,few);
output(ta3,named('relative_field_populations'));

r5 := record
 rel_dupd.relative_adl;
 rel_dupd.relative_dob;
 boolean has_no_dob;
 boolean has_full_dob;
 boolean has_year_only;
 boolean has_year_month_only;
end;

r5 t2(rel_dupd le) := transform
 
 string8 v_dob := le.relative_dob;
 string4 v_yy  := v_dob[1..4];
 string2 v_mm  := v_dob[5..6];
 string2 v_dd  := v_dob[7..8];
 
 boolean has_yy := trim(v_yy) not in ['0000',''];
 boolean has_mm := trim(v_mm) not in ['00',''];
 boolean has_dd := trim(v_dd) not in ['00',''];
 
 self.has_no_dob          := trim(v_dob)='';
 self.has_full_dob        := self.has_no_dob=false and has_yy=true and has_mm=true  and has_dd=true;
 self.has_year_only       := self.has_no_dob=false and has_yy=true and has_mm=false;// and has_dd=false;
 self.has_year_month_only := self.has_no_dob=false and has_yy=true and has_mm=true  and has_dd=false;
 self                     := le;
end;

p2 := project(rel_dupd,t2(left));

output(p2(has_year_only=true));
output(p2(has_year_month_only=true));

r6 := record
 p2.has_no_dob;
 p2.has_full_dob;
 p2.has_year_only;
 p2.has_year_month_only;
 file_ct := count(group);
end;

ta4 := sort(table(p2,r6,has_no_dob,has_full_dob,has_year_only,has_year_month_only,few),has_full_dob,has_year_only,has_year_month_only,has_no_dob);
output(ta4,named('relative_dob_stats'));

r7 := record
 rel_dupd.relative_adl;
end;

r7 t3(rel_dupd le, main_dupd ri) := transform
 self := le;
end;

j1 := join(rel_dupd,main_dupd,left.relative_adl=right.adl,t3(left,right),left only,local);
output(count(j1),named('relatives_not_in_main'));
output(j1);

r8 := record
 string12 main_adl;
end;

r8 t4(cust_file le) := transform
 self := le;
end;

r8 t5(lssi_file le) := transform
 self := le;
end;

p3 := project(cust_file((integer)main_adl>0),t4(left));
p4 := project(lssi_file((integer)main_adl>0),t5(left));

unique_reunions := dedup(sort(distribute(p3+p4,hash(main_adl)),main_adl,local),main_adl,local);

recordof(main_dupd) t6(main_dupd le, unique_reunions ri) := transform
 self := le;
end;

j2 := join(main_dupd,unique_reunions,left.adl=right.main_adl,t6(left,right),left only,local);

output(count(j2),named('people_in_the_main_file_that_reunion_didnt_give_us'));