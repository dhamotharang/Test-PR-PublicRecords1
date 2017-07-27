#workunit('name', 'LiensV2 Coverage Report')

main := LiensV2.file_liens_main;
party := LiensV2.file_liens_party;

comb_layout := record, maxlength(4096)
string50 tmsid;
string50 rmsid;
string8 process_date;
string record_code;
string date_vendor_removed;
string filing_jurisdiction;
string filing_state;
string20 orig_filing_number;
string orig_filing_type;
string8 orig_filing_date;
string orig_filing_time;
string case_number  ;
string20 filing_number;
string filing_type_desc;
string8 filing_date;
string filing_time;
string8 coverage_date;
string50 state;
string100 orig_county;
string100 county;
string2 source_file;
end;

comb_layout reformat(main m) := transform
	self.coverage_date := min(if(m.orig_filing_date = '', '99999999', m.orig_filing_date), if(m.filing_date = '', '99999999', m.filing_date));
	self.state := if(m.agency_state <> '', m.agency_state, if(length(trim(m.filing_jurisdiction, all)) = 2, m.filing_jurisdiction, m.filing_state) );
	self.orig_county := if(m.agency_county <> '' and length(trim(m.filing_jurisdiction, all)) < 3, m.agency_county, if(length(trim(m.filing_jurisdiction, all)) = 2, '', m.filing_jurisdiction));
    self.county := trim(regexreplace(',.*', regexreplace('COUNTY.*', stringlib.stringtouppercase(self.orig_county), ''), ''), all);
	self.source_file := m.tmsid[1..2];
	self := m;
end;

nfile := project(main,reformat(left))
: persist('persist::coverage::liens_combined');
output(nfile);

layout_counts := record
nfile.source_file;
nfile.state;
nfile.county;
nfile.orig_county;
PROCdate := MAX(group,if(nfile.process_date<>'',nfile.process_date,'99999999'));
MINdate  := MIN(group,if(nfile.coverage_date<>'',nfile.coverage_date,'99999999'));
MAXdate  := MAX(group,map((nfile.coverage_date<>''and nfile.coverage_date<nfile.process_date)  or nfile.coverage_date = '99999999' => nfile.coverage_date,'00000000'));
end;

counts := sort(table(nfile,layout_counts,source_file, state, county, few),source_file, state, county);
output(choosen(counts, 500)) : persist('persist::coverage::civil::liens::counts');

layout_slim := record
string8 process_date;
string20 source_file;
string2 state;
string60 county;
string60 orig_county;
string6 coverage_date;
string60 supplemental;
end;

layout_slim t_recs(nfile input) := Transform
self.source_file  := input.source_file;
self.coverage_date := regexreplace('(999999)', input.coverage_date[1..6], '');
self.county := trim(if(stringlib.stringfind(input.county, '-', 1) > 0 , input.county[1..stringlib.stringfind(input.county, '-', 1)-1], input.county), left, right);
self.supplemental := input.county;
self := input;
end;

p_d := project(nfile,t_recs(left));

///////////////////////////////////////////////////////////////////////////////////////////
layout_stat :=  record
p_d.source_file;
p_d.state;
p_d.county;
p_d.orig_county;
p_d.coverage_date;
p_d.supplemental;

ctDate := count(group);
end;

stat := sort(table(p_d,layout_stat,source_file,state,county,supplemental, coverage_date,few),source_file,state,county,supplemental, coverage_date)(coverage_date!='' and state <> '');
output(choosen(stat, 500)) : persist('persist::coverage::civil::liens::stat');
///////////////////////////////////////////////////////////////////////////////////////////
layout_stdev := record
stat.source_file;
stat.state;
stat.county;
stat.orig_county;
stat.supplemental;
aveCt := ave(group,stat.ctDate);

end;

p_stat := sort(table(stat,layout_stdev,source_file,state,county,supplemental, few),source_file,state,county,supplemental);

output(choosen(p_stat, 500)) : persist('persist::coverage::civil::liens::p_stat');
///////////////////////////////////////////////////////////////////////////////////////////
layout_ctRec :=  record
stat.source_file;
stat.state;
stat.county;
stat.orig_county;
stat.supplemental;
ctRec := count(group);
end;

ctRecstat := sort(table(stat,layout_ctRec,source_file,state,county,supplemental,few),source_file,state,county,supplemental);
output(choosen(ctRecstat, 500)) : persist('persist::coverage::civil::liens::ctRecStat');

temp_layout := record
stat.source_file;
stat.state;
stat.county;
stat.orig_county;
stat.supplemental;
stat.coverage_date;
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
					left.source_file = right.source_file and left.state = right.state and left.county = right.county,
					t_recs2(left,right),lookup);
					
temp_layout t_recs3(statout L ,ctRecstat R) := transform
self.ctRec:= R.ctrec;
self.squared:= power(L.ctDate - L.aveCt,2);
self := L;
self := R;
end;

statOut2	:= join(statout,ctRecstat,
					left.source_file = right.source_file and left.state = right.state and left.county = right.county,
					t_recs3(left,right),lookup);
					
output(choosen(statOut2, 500)) : persist('persist::coverage::civil::liens::statOut2');

layout_sumSquared :=  record
statOut2.source_file;
statOut2.state;
statout2.supplemental;
statOut2.county;
statOut2.orig_county;
sumSquared := sum(group,statout2.squared);


end;

sumSquared := sort(table(statOut2,layout_sumSquared,source_file,state,county,supplemental,few),source_file,state,county,supplemental);
output(choosen(sumSquared, 500)) : persist('persist::coverage::civil::liens::SumSquared');

temp_layout t_recs4(statout2 L, sumSquared R) := transform
self.stdev:= sqrt(R.sumSquared/L.ctRec-1);
self := L;
self := R;
end;

statOut3	:= join(statout2,sumSquared,
					left.source_file = right.source_file and left.state = right.state and left.county = right.county and right.supplemental = left.supplemental,
					t_recs4(left,right),lookup);
					
output(choosen(statout3, 500)) : persist('persist::coverage::civil::liens::statOut3');
f_statout3 := statout3(statOut3.ctDate > statOut3.stdev);
layout_startDate :=  record
f_statout3.source_file;
f_statout3.state;
f_statout3.supplemental;
f_statout3.county;
f_statout3.orig_county;
startDate := MIN(group,f_statout3.coverage_date);


end;

stdev := sort(table(f_statout3,layout_startDate,source_file,state,county,supplemental,few),source_file,state,county,supplemental);
output(stdev, ,'coverage::liens::stDev', expire(1), overwrite);						