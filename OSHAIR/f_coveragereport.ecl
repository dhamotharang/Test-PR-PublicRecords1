#workunit('name', 'oshair by state dates with persists')

export f_coveragereport(dataset(OSHAIR.layout_OSHAIR_inspection_clean) d) := function 

// d:= oshair.file_out_inspection_cleaned;

layout_counts := record
source_file := d.inspected_site_state;
// PROCdate := MAX(group,if(d.process_date<>'',d.process_date,'99999999'));
MINdate  := MIN(group,if((string8)d.inspection_opening_date <>'' and d.inspection_opening_date > 0,(string8)d.inspection_opening_date,'99999999'));
MAXdate  := MAX(group,if((string8)d.inspection_close_date <>'' and d.inspection_close_date > 0, (string8)d.inspection_close_date,'00000000'));
end;

counts := sort(table(d,layout_counts,inspected_site_state,few),record);

layout_slim := record
// string8 process_date;
// string20 source_file;
string2 state_origin;
// string60 court;
string6 filing_date;
end;

layout_slim t_recs(d input) := Transform
self.state_origin  := input.inspected_site_state;
self.filing_date := input.inspection_opening_date[1..6];

self := input;
end;

p_d := project(d,t_recs(left));

///////////////////////////////////////////////////////////////////////////////////////////////
layout_stat :=  record
// p_d.source_file;
p_d.state_origin;
// p_d.court;
p_d.filing_date;

ctDate := count(group);
end;

stat := sort(table(p_d,layout_stat,state_origin,filing_date,few),state_origin,filing_date)(filing_date!='' and state_origin <> '');
///////////////////////////////////////////////////////////////////////////////////////////////
layout_stdev := record
// stat.source_file;
stat.state_origin;
// stat.court;
aveCt := ave(group,stat.ctDate);

end;

p_stat := sort(table(stat,layout_stdev,state_origin,few),state_origin);

///////////////////////////////////////////////////////////////////////////////////////////////
layout_ctRec :=  record
// stat.source_file;
stat.state_origin;
// stat.court;
ctRec := count(group);
end;

ctRecstat := sort(table(stat,layout_ctRec,state_origin,few),state_origin);

temp_layout := record
// stat.source_file;
stat.state_origin;
// stat.court;
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
					left.state_origin = right.state_origin,
					t_recs2(left,right),lookup);
					
temp_layout t_recs3(statout L ,ctRecstat R) := transform
self.ctRec:= R.ctrec;
self.squared:= power(L.ctDate - L.aveCt,2);
self := L;
self := R;
end;

statOut2	:= join(statout,ctRecstat,
					left.state_origin = right.state_origin,
					t_recs3(left,right),lookup);
					

layout_sumSquared :=  record
// statOut2.source_file;
statOut2.state_origin;
// statOut2.court;
sumSquared := sum(group,statout2.squared);


end;

sumSquared := sort(table(statOut2,layout_sumSquared,state_origin,few),state_origin);

temp_layout t_recs4(statout2 L, sumSquared R) := transform
self.stdev:= sqrt(R.sumSquared/L.ctRec-1);
self := L;
self := R;
end;

statOut3	:= join(statout2,sumSquared,
					left.state_origin = right.state_origin,
					t_recs4(left,right),lookup);
					
f_statout3 := statout3(statOut3.ctDate > statOut3.stdev);
layout_startDate :=  record
// f_statout3.source_file;
f_statout3.state_origin;
// f_statout3.court;
startDate := MIN(group,f_statout3.filing_date);


end;

stdev := sort(table(f_statout3,layout_startDate,state_origin,few),state_origin) : persist('persist::coverage::oshair::stDev');

sequential(
output(choosen(counts, 500)),
output(choosen(stat, 500)),
output(choosen(p_stat, 500)),
output(choosen(ctRecstat, 500)),
output(choosen(statOut2, 500)),
output(choosen(sumSquared, 500)),
output(choosen(statout3, 500)),
output(choosen(stdev, 500))
);


return stdev;

end;				