import watercraft, ut, STD;

ds0        := watercraft.File_Base_Main_Dev;
ds_search0 := watercraft.File_Base_Search_Dev;

recordof(ds0) t_patch1(recordof(ds0) le) := transform
 self.state_origin := if(le.source_code='CG','CG',le.state_origin);
 self              := le;
end;

recordof(ds_search0) t_patch2(recordof(ds_search0) le) := transform
 self.state_origin := if(le.source_code='CG','CG',le.state_origin);
 self              := le;
end;

ds        := project(ds0,t_patch1(left));
ds_search := project(ds_search0,t_patch2(left));

r_max_process_date := record
 ds_search.state_origin;
 ds_search.source_code;
 string8 max_process_date := max(group,ds_search.date_vendor_last_reported);
end;

t_max_process_date := sort(table(ds_search,r_max_process_date,state_origin,source_code,few),state_origin,source_code);

display1 := output(t_max_process_date,named('Watercraft_Latest_Process_Date'),all);

registration_expiration_states := ['KS','MS','NC'];
no_coverage_states             := ['UT','FV'];
other_coverage_states          := ['WI'];
//wisconsin also provides a last_transaction_date that can be used when the registration_date field they provide is empty

rec := record
 ds.state_origin;
 ds.source_code;
 string25 coverage_type;
 string8  date;
end;

CurrentDate := (string8)STD.Date.Today();
rec t1(ds l) := transform

 string8 v_registration_date            := if(l.registration_date[1..6]            between '197000' and CurrentDate[1..6],l.registration_date,'');
 string8 v_registration_expiration_date := if(l.registration_expiration_date[1..6] between '197000' and CurrentDate[1..6],l.registration_expiration_date,'');
 string8 v_other_date                   := if(l.sequence_key[1..6]                 between '197000' and CurrentDate[1..6],l.sequence_key,'');
 //string8 v_permit                       := if(l.date_last_seen[1..6]               between '197000' and ut.GetDate[1..6],l.date_last_seen,'');
 
 self.coverage_type := if(l.state_origin in registration_expiration_states,'REGISTRATION EXPIRATION',
                       if(l.state_origin in no_coverage_states,'NO COVERAGE AVAILABLE',
					   if(l.state_origin in other_coverage_states,'LAST TRANSACTION DATE',
					   //if(l.state_origin='FV','FISHING LICENSE/PERMIT',
					   'REGISTRATION')));
 self.date          := if(l.state_origin in registration_expiration_states,v_registration_expiration_date,
                       if(l.state_origin in no_coverage_states,'N/A',
					   if(l.state_origin in other_coverage_states,v_other_date,
					   //if(l.state_origin='FV',v_permit,
					   v_registration_date)));
 self               := l;
end;

p1      := project(ds,t1(left));
p1_filt := p1(date<>'');

stat_rec := record
 p1.state_origin;
 p1.source_code;
 p1.coverage_type;
 st_src_count := count(group);
end;

stat_rec2 := record
 p1_filt.state_origin;
 p1_filt.source_code;
 p1_filt.coverage_type;
 min_date     := min(group,p1_filt.date);
 max_date     := max(group,p1_filt.date);
end;

out1 := sort(table(p1,     stat_rec, state_origin,source_code,coverage_type,few),state_origin,source_code,coverage_type);
out2 := sort(table(p1_filt,stat_rec2,state_origin,source_code,coverage_type,few),state_origin,source_code,coverage_type);

stat := record
 out1.state_origin;
 out1.source_code;
 out1.coverage_type;
 out1.st_src_count;
 out2.min_date;
 out2.max_date;
end;

stat t_join(out1 l, out2 r) := transform
 self := l;
 self := r;
end;

j1 := join(out1,out2,(left.state_origin=right.state_origin and left.source_code=right.source_code and left.coverage_type=right.coverage_type),t_join(left,right));

display2 := output(j1,all,named('Watercraft_Coverage'));

export coverage := parallel(display1,display2);