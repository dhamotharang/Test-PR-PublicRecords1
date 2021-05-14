import ut,Std;

in_md := marriage_divorce_v2.file_mar_div_base(filing_type in ['3','7']);

in_md_mar := in_md(filing_type='3');
in_md_div := in_md(filing_type='7');

r1 := record
 string2  state_origin;
 string5  vendor;
 string8  process_date;
 string8  event_date;
 string4  event_date_yyyy;
 string22 date_type;
end;

r1 t_norm_mar(in_md_mar le) := transform
 self.event_date      := if(le.marriage_dt<>'',le.marriage_dt,le.marriage_filing_dt);
 self.event_date_yyyy := if(le.marriage_dt<>'',le.marriage_dt[1..4],le.marriage_filing_dt[1..4]);
 self.date_type       := 'MARRIAGE';
 self                 := le;
end;

r1 t_norm_div(in_md_div le) := transform
 self.event_date      := if(le.divorce_dt<>'',le.divorce_dt,le.divorce_filing_dt);
 self.event_date_yyyy := if(le.divorce_dt<>'',le.divorce_dt[1..4],le.divorce_filing_dt[1..4]);
 self.date_type       := 'DIVORCE';
 self                 := le;
end;

norm_mar := project(in_md_mar,t_norm_mar(left))(event_date<>'');
norm_div := project(in_md_div,t_norm_div(left))(event_date<>'');

concat0 := norm_mar+norm_div;

string fgooddate(string8 pDate) := if(length(trim(pDate)) in [4,6,8] 
                                     and pDate[1..4] between '1850' 
									 and (string)((integer)((string8)Std.Date.Today())[1..4]),
									pDate,'');
									
r1 t_cleanup(concat0 le) := transform

 self.event_date      := fgooddate(le.event_date);
 self.event_date_yyyy := if(self.event_date<>'',le.event_date_yyyy,'');
 self                 := le;

end;

concat := project(concat0,t_cleanup(left));
 
rec4 := record
 concat.state_origin;
 concat.vendor;
 concat.event_date_yyyy;
 concat.date_type;
 count_ := count(group);
end;

coverage_candidates0 := sort(table(concat,rec4,state_origin,vendor,event_date_yyyy,date_type,few),state_origin,vendor,date_type,event_date_yyyy);
//CIV37 handled separately because so few records are coming in from that source
coverage_candidates  := coverage_candidates0((event_date_yyyy<>'' and count_>100) or (vendor='CIV37' and count_>25) or (vendor='OFR17' and count_>25 and trim(date_type)='DIVORCE'));
output(coverage_candidates0,all,named('mar_div_v2_coverage_int0'));
output(coverage_candidates,all,named('mar_div_v2_coverage_int1'));

rollup_rec := record
 coverage_candidates.state_origin;
 coverage_candidates.vendor;
 coverage_candidates.event_date_yyyy;
 coverage_candidates.date_type;
 string8 min_date :='';
 string8 max_date :='';
end;

rollup_rec t_rollup_prep(coverage_candidates le) := transform
 self.min_date := le.event_date_yyyy;
 self.max_date := le.event_date_yyyy;
 self := le;
end;

candidates_prep := project(coverage_candidates,t_rollup_prep(left));

rollup_rec roll_em(candidates_prep le, candidates_prep ri) := transform
 self.min_date := if(le.min_date<ri.min_date,le.min_date,ri.min_date);
 self.max_date := if(le.max_date>ri.max_date,le.max_date,ri.max_date);
 self          := le;
end;

candidates_rolled := rollup(candidates_prep,left.state_origin=right.state_origin and left.vendor=right.vendor and left.date_type=right.date_type,roll_em(left,right));

r_slim := record
 candidates_rolled.state_origin;
 candidates_rolled.vendor;
 candidates_rolled.date_type;
 candidates_rolled.min_date;
 candidates_rolled.max_date;
end;

candidates_slim := table(candidates_rolled,r_slim);

j_rec := record
 concat.state_origin;
 concat.vendor;
 concat.process_date;
 concat.event_date;
 concat.date_type;
 candidates_slim.min_date;
 candidates_slim.max_date;
end;

j_rec t_j1(concat le, candidates_slim ri) := transform
 self := le;
 self.min_date := ri.min_date;
 self.max_date := ri.max_date;
end;

j1 := join(concat,candidates_slim,
           left.state_origin=right.state_origin and left.vendor=right.vendor and left.date_type=right.date_type,
		   t_j1(left,right)
		  );

j1_filt := j1(trim(event_date)='' or event_date[1..4] between min_date and max_date);

j1_filt_a := j1_filt(trim(event_date)<>'');
j1_filt_b := j1_filt;

final_stat := record
 j1_filt_a.state_origin;
 j1_filt_a.vendor;
 j1_filt_a.date_type;
 max_process_date := max(group,j1_filt_a.process_date);
 min_cov_date     := min(group,j1_filt_a.event_date);
 max_cov_date     := max(group,j1_filt_a.event_date);
 count_           := count(group);
end;

final_stat2 := record
 j1_filt_b.state_origin;
 j1_filt_b.vendor;
 j1_filt_b.date_type;
 count_ := count(group);
end;

d1 := sort(table(distribute(j1_filt_a,hash(state_origin,vendor,date_type)),final_stat, state_origin,vendor,date_type,local),state_origin,vendor,date_type,local);
d2 := sort(table(distribute(j1_filt_b,hash(state_origin,vendor,date_type)),final_stat2,state_origin,vendor,date_type,local),state_origin,vendor,date_type,local);

final_rec := record
 string2 st;
 d1.vendor;
 d1.date_type;
 string8 min_date;
 string8 max_date;
 d1.max_process_date;
 integer st_vendor_ct;
end;

final_rec t_final(d1 le, d2 ri) := transform
 self.st           := le.state_origin;
 self.min_date     := le.min_cov_date;
 self.max_date     := le.max_cov_date;
 self.st_vendor_ct := ri.count_;
 self              := le;
 self              := ri;
end;

j_final := join(d1,d2,
                left.state_origin=right.state_origin and left.vendor=right.vendor and left.date_type=right.date_type,
				t_final(left,right),local
			   );



// Need to show stats for showing new sources only.
// compare current base file with father file.

diff_rec := record
 string st;
 string vendor;
 string min_date;
 string max_date;
 string max_process_date;
 integer st_vendor_ct;
end;



//previous good file
prev_build_ds1 := dataset('~thor_data400::base::mar_div::intermediate_father',layout_mar_div_intermediate,flat);
prev_build_ds  := project(prev_build_ds1
													,transform(marriage_divorce_v2.layout_mar_div_base
													,self := left));

//current file
final_build_ds:= j_final;



distrib1 := distribute(prev_build_ds,hash(state_origin,vendor));
deduped1 := dedup(distrib1,state_origin,vendor,local);

RightRec := record
 deduped1.state_origin;
 deduped1.vendor;

 count_ := count(group);
end;

RHS := sort(table(deduped1,RightRec,state_origin,vendor,few,local),state_origin,vendor,local);
distrib2 := distribute(final_build_ds,hash(st,vendor));


LeftRec := record
 distrib2.st;
 distrib2.vendor;
 count_ := count(group);
end;

LHS := sort(table(distrib2,LeftRec,st,vendor,few,local),st,vendor,local);



diff_rec t_diff(distrib2 le, deduped1 ri) := transform
 self.st           := le.st;
 self.vendor			 := le.vendor;	
 self.min_date     := le.min_date;
 self.max_date     := le.max_date;
 self.st_vendor_ct := le.st_vendor_ct;
 self              := le;
 self              := ri;
end;

j_diff := join(distrib2,deduped1,
                left.st=right.state_origin and left.vendor=right.vendor,
				t_diff(left,right),left only,local);


export coverage := parallel(output(j_final,named('entire_mar_div_v2_coverage')),output(j_diff,named('new_sources')));
