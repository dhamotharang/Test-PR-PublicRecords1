output(bankrupt.File_Evictions_Daily);

#workunit('name', 'bankrupt evictions by county dates with persists')

d:= bankrupt.File_Evictions;

layout_counts := record
source_file := d.courtid;
PROCdate := MAX(group,if(d.uploaddate not in ['', '00000000'],d.uploaddate,'99999999'));
MINdate  := MIN(group,if(d.filing_date not in ['', '00000000'],d.filing_date,'99999999'));
MAXdate  := MAX(group,map(d.filing_date not in ['', '00000000'] and d.filing_date<d.uploaddate => d.filing_date,'00000000'));
end;

counts := sort(table(d,layout_counts,courtid,few),source_file);
output(choosen(counts, 500)) : persist('persist::coverage::evictions::counts');

layout_slim := record
string8 process_date;
string20 source_file;
string2 state_origin;
string60 court;
string6 filing_date;
end;

layout_slim t_recs(d input) := Transform
self.process_date := regexreplace('^0+$', input.uploaddate, '');
self.source_file  := input.courtid[1..2];
self.filing_date := regexreplace('^0+$', input.filing_date[1..6], '');
self.state_origin  := input.courtid[1..2];
self.court  := input.courtid[1..2];
self := input;
end;

p_d := project(d,t_recs(left));

///////////////////////////////////////////////////////////////////////////////////////////////
layout_stat :=  record
p_d.source_file;
p_d.state_origin;
p_d.court;
p_d.filing_date;

ctDate := count(group);
end;

stat := sort(table(p_d,layout_stat,source_file,state_origin,court,filing_date,few),source_file,state_origin,court,filing_date)(filing_date!='' and state_origin <> '');
output(choosen(stat, 500)) : persist('persist::coverage::evictions::stat');
///////////////////////////////////////////////////////////////////////////////////////////////
layout_stdev := record
stat.source_file;
stat.state_origin;
stat.court;
aveCt := ave(group,stat.ctDate);

end;

p_stat := sort(table(stat,layout_stdev,source_file,state_origin,court,few),source_file,state_origin,court);

output(choosen(p_stat, 500)) : persist('persist::coverage::evictions::p_stat');
///////////////////////////////////////////////////////////////////////////////////////////////
layout_ctRec :=  record
stat.source_file;
stat.state_origin;
stat.court;
ctRec := count(group);
end;

ctRecstat := sort(table(stat,layout_ctRec,source_file,state_origin,court,few),source_file,state_origin,court);
output(choosen(ctRecstat, 500)) : persist('persist::coverage::evictions::ctRecStat');

temp_layout := record
stat.source_file;
stat.state_origin;
stat.court;
stat.filing_date;
integer ctDate;
integer aveCt;
integer ctRec:=0;
integer squared :=0;
integer stdev:= 0;
end;

temp_layout t_recs2(stat L, p_stat R) := transform
self.avect := R.avect;
self := L;
self := R;
end;

statOut	:= join(stat,p_stat,
					left.source_file = right.source_file and left.state_origin = right.state_origin and left.court = right.court,
					t_recs2(left,right),lookup);
					
temp_layout t_recs3(statout L ,ctRecstat R) := transform
self.ctRec:= R.ctrec;
self.squared:= power(L.ctDate - L.aveCt,2);
self := L;
self := R;
end;

statOut2	:= join(statout,ctRecstat,
					left.source_file = right.source_file and left.state_origin = right.state_origin and left.court = right.court,
					t_recs3(left,right),lookup);
					
output(choosen(statOut2, 500)) : persist('persist::coverage::evictions::statOut2');

layout_sumSquared :=  record
statOut2.source_file;
statOut2.state_origin;
statOut2.court;
sumSquared := sum(group,statout2.squared);


end;

sumSquared := sort(table(statOut2,layout_sumSquared,source_file,state_origin,court,few),source_file,state_origin,court);
output(choosen(sumSquared, 500)) : persist('persist::coverage::evictions::SumSquared');

temp_layout t_recs4(statout2 L, sumSquared R) := transform
self.stdev:= sqrt(R.sumSquared/L.ctRec-1);
self := L;
self := R;
end;

statOut3	:= join(statout2,sumSquared,
					left.source_file = right.source_file and left.state_origin = right.state_origin and left.court = right.court,
					t_recs4(left,right),lookup);
					
output(choosen(statout3, 500)) : persist('persist::coverage::evictions::statOut3');
f_statout3 := statout3(statOut3.ctDate > statOut3.stdev);
layout_startDate :=  record
f_statout3.source_file;
f_statout3.state_origin;
f_statout3.court;
startDate := MIN(group,f_statout3.filing_date);


end;

stdev := sort(table(f_statout3,layout_startDate,source_file,state_origin,court,few),source_file,state_origin,court);
output(choosen(stdev, 500)) : persist('persist::coverage::evictions::stDev');						