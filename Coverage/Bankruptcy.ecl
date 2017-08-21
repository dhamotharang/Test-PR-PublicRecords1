/* W20080205-123429 all
W20080205-160651 source L
W20080205-160718 source S
W20080205-160701 source H
Bankruptcy v. 2
*/

#workunit('name', 'bankruptcy orbit reports')

//Select one (all, L, S, H):
  main_file := table(BankruptcyV2.file_bankruptcy_main, {state_origin := court_code[1..2], source_file := regexreplace('FED C', regexreplace('\\-.*', court_name, ''), 'FEDERAL C'), BankruptcyV2.file_bankruptcy_main});
//main_file := table(BankruptcyV2.file_bankruptcy_main, {state_origin := court_code[1..2], source_file := regexreplace('FED C', regexreplace('\\-.*', court_name, ''), 'FEDERAL C'), BankruptcyV2.file_bankruptcy_main})(source = 'L');
//main_file := table(BankruptcyV2.file_bankruptcy_main, {state_origin := court_code[1..2], source_file := regexreplace('FED C', regexreplace('\\-.*', court_name, ''), 'FEDERAL C'), BankruptcyV2.file_bankruptcy_main})(source = 'S');
//main_file := table(BankruptcyV2.file_bankruptcy_main, {state_origin := court_code[1..2], source_file := regexreplace('FED C', regexreplace('\\-.*', court_name, ''), 'FEDERAL C'), BankruptcyV2.file_bankruptcy_main})(source = 'H');

d:= main_file;

layout_counts := record
d.source_file;
PROCdate := MAX(group,if(d.process_date<>'',d.process_date,'99999999'));
MINdate  := MIN(group,if(d.date_filed<>'',d.date_filed,'99999999'));
MAXdate  := MAX(group,map(d.date_filed<>''and d.date_filed<d.process_date => d.date_filed,'00000000'));
end;

counts := sort(table(d,layout_counts,source_file,few),source_file);
/////////// OUTPUT 1
output(choosen(counts, 500)) : persist('persist::coverage::bankruptcy::counts');

layout_slim := record
string8 process_date;
string20 source_file;
string2 state_origin;
string60 court;
string6 date_filed;
end;

layout_slim t_recs(d input) := Transform
self.source_file  := input.source_file;
self.date_filed := input.date_filed[1..6];
self.court := input.source_file;
self := input;
end;

p_d := project(d,t_recs(left));

///////////////////////////////////////////////////////////////////////////////////////////////
layout_stat :=  record
p_d.source_file;
p_d.state_origin;
p_d.court;
p_d.date_filed;

ctDate := count(group);
end;

stat := sort(table(p_d,layout_stat,source_file,state_origin,court,date_filed,few),source_file,state_origin,court,date_filed)(date_filed!='' and state_origin <> '');
/////////// OUTPUT 2
output(choosen(stat, 500)) : persist('persist::coverage::bankruptcy::stat');
///////////////////////////////////////////////////////////////////////////////////////////////
layout_stdev := record
stat.source_file;
stat.state_origin;
stat.court;
aveCt := ave(group,stat.ctDate);

end;

p_stat := sort(table(stat,layout_stdev,source_file,state_origin,court,few),source_file,state_origin,court);
/////////// OUTPUT 3
output(choosen(p_stat, 500)) : persist('persist::coverage::bankruptcy::p_stat');
///////////////////////////////////////////////////////////////////////////////////////////////
layout_ctRec :=  record
stat.source_file;
stat.state_origin;
stat.court;
ctRec := count(group);
end;

ctRecstat := sort(table(stat,layout_ctRec,source_file,state_origin,court,few),source_file,state_origin,court);
/////////// OUTPUT 4
output(choosen(ctRecstat, 500)) : persist('persist::coverage::bankruptcy::ctRecStat');

temp_layout := record
stat.source_file;
stat.state_origin;
stat.court;
stat.date_filed;
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
/////////// OUTPUT 5					
output(choosen(statOut2, 500)) : persist('persist::coverage::bankruptcy::statOut2');

layout_sumSquared :=  record
statOut2.source_file;
statOut2.state_origin;
statOut2.court;
sumSquared := sum(group,statout2.squared);


end;

sumSquared := sort(table(statOut2,layout_sumSquared,source_file,state_origin,court,few),source_file,state_origin,court);
/////////// OUTPUT 6
output(choosen(sumSquared, 500)) : persist('persist::coverage::bankruptcy::SumSquared');

temp_layout t_recs4(statout2 L, sumSquared R) := transform
self.stdev:= sqrt(R.sumSquared/L.ctRec-1);
self := L;
self := R;
end;

statOut3	:= join(statout2,sumSquared,
					left.source_file = right.source_file and left.state_origin = right.state_origin and left.court = right.court,
					t_recs4(left,right),lookup);
					
/////////// OUTPUT 7
output(choosen(statout3, 500)) : persist('persist::coverage::bankruptcy::statOut3');
f_statout3 := statout3(statOut3.ctDate > statOut3.stdev);
layout_startDate :=  record
f_statout3.source_file;
f_statout3.state_origin;
f_statout3.court;
startDate := MIN(group,f_statout3.date_filed);


end;

stdev := sort(table(f_statout3,layout_startDate,source_file,state_origin,court,few),source_file,state_origin,court);
/////////// OUTPUT 8
output(choosen(stdev, 500)) : persist('persist::coverage::bankruptcy::stDev');