import ut;

ds := dataset(/*ut.foreign_prod+*/'~thor_data400::Base::Death_Master_Plus',header.layout_death_master_plus,flat)(state<>'');

r1 := record
 ds.state;
 string6  filedate_ym;
 string1  is_state_death;
 string6  yyyymm_of_death;
 string15 coverage_type;
end;

r1 t_fix_dates(ds le) := transform
 self.filedate_ym   := le.filedate[1..6];
 self.is_state_death     := if(le.state_death_flag='Y','Y','');
 self.yyyymm_of_death := if(le.dod8[1..4] between '1900' and ut.GetDate[1..4],le.dod8[1..6],
                         if(le.dod8[1..2] between '01'   and '12',            le.dod8[5..8]+le.dod8[1..2],
					     ''));
 self.coverage_type := 'DATE OF DEATH';
 self               := le;
end;

p1 := project(ds,t_fix_dates(left));

p1_filt := p1(yyyymm_of_death<>'');

stat_rec := record
 p1.state; 
 p1.is_state_death;
 p1.coverage_type;
 st_count := count(group);
end;

stat_rec2_0 := record
 p1_filt.state;
 p1_filt.is_state_death;
 p1_filt.yyyymm_of_death;
 p1_filt.filedate_ym;
 //max_file_date := max(group,p1_filt.filedate);
 //min_date     := min(group,p1_filt.yyyymm_of_death);
 //max_date     := max(group,p1_filt.yyyymm_of_death);
 count_       := count(group);
end;

out2_0 := table(p1_filt,stat_rec2_0,state,is_state_death,yyyymm_of_death,filedate_ym,few)(count_>15);

stat_rec2 := record
 out2_0.state;
 out2_0.is_state_death;
 max_file_date := max(group,out2_0.filedate_ym);
 min_date      := min(group,out2_0.yyyymm_of_death);
 max_date      := max(group,out2_0.yyyymm_of_death);
 count_        := count(group);
end;

out1 := sort(table(p1,    stat_rec, state,is_state_death,coverage_type,few),state,is_state_death);
out2 := sort(table(out2_0,stat_rec2,state,is_state_death,few),state,is_state_death);

stat := record
 out1.state;
 out1.is_state_death;
 out1.coverage_type;
 out2.min_date;
 out2.max_date;
 out2.max_file_date;
 out1.st_count;
end;

stat t_join(out1 l, out2 r) := transform
 self := l;
 self := r;
end;

j1 := join(out1,out2,(left.state=right.state and left.is_state_death=right.is_state_death),t_join(left,right));

display1 := output(j1(st_count>100),all,named('coverage'));

export deaths_coverage := display1;