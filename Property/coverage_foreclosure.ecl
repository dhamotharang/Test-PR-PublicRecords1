import ut, Std;

string_rec := record
	property.Layout_Fares_Foreclosure;
    unsigned integer8 __filepos { virtual(fileposition)};
end;

// ds := DATASET(/*ut.foreign_prod+*/'~thor_data400::base::foreclosure', string_rec, thor);

ds := property.file_foreclosure_building;

r1 := record
 ds.state;
 ds.county;
 string25 coverage_type;
 string8  date;
 integer  has_court_case_nbr;
end;

r1 t_recording(ds le) := transform
 
 self.date          := if(le.recording_date[1..6] between '197000' and ((STRING8)Std.Date.Today())[1..6],le.recording_date,'');
 self.coverage_type := 'RECORDING DATE';
 self.has_court_case_nbr := if(le.court_case_nbr<>'',1,0);
 self               := le;
end;

/*Filing date is blank for all records*/
r1 t_filing(ds le) := transform
 
 self.date          := if(le.filing_date[1..6] between '197000' and ((STRING8)Std.Date.Today())[1..6],le.filing_date,'');
 self.coverage_type := 'FILING DATE';
 self.has_court_case_nbr := if(le.court_case_nbr<>'',1,0);
 self               := le;
end;

p_recording := project(ds,t_recording(left));
p_filing    := project(ds,t_filing(left));

p1 := p_recording;//+p_filing;

p1_filt := p1(date<>'');

stat_rec := record
 p1.state;
 p1.county;
 p1.coverage_type;
 integer sum_court_case := count(group,p1.has_court_case_nbr=1);
 st_co_count := count(group);
end;

stat_rec2 := record
 p1_filt.state;
 p1_filt.county;
 p1_filt.coverage_type;
 min_date     := min(group,p1_filt.date);
 max_date     := max(group,p1_filt.date);
end;

out1 := sort(table(p1,     stat_rec, state,county,coverage_type,few),state,county,coverage_type);
out2 := sort(table(p1_filt,stat_rec2,state,county,coverage_type,few),state,county,coverage_type);

stat := record
 out1.state;
 out1.county;
 out1.coverage_type;
 out1.sum_court_case;
 out2.min_date;
 out2.max_date;
 out1.st_co_count;
end;

stat t_join(out1 l, out2 r) := transform
 self := l;
 self := r;
end;

j1 := join(out1,out2,(left.state=right.state and left.county=right.county and left.coverage_type=right.coverage_type),t_join(left,right));


fips_rec := record
string2  state_alpha;
string2  state_code;
string3  county_code;
string40 county_alpha;
string2  class;
string1  crlf;
end;

fips_data := dataset(/*ut.foreign_prod+*/'~thor_data400::in::fips_code_lookup',fips_rec,flat);

r2 := record
 string2  state_alpha;
 string40 county_alpha;
 j1;
end;

r2 t_translate(j1 le, fips_data ri) := transform
 self := le;
 self := ri;
end;

j20 := join(j1,fips_data,
            left.state=right.state_code and left.county=right.county_code,
						t_translate(left,right),keep(1)
					 );

r_slim := record
 j20.state_alpha;
 j20.county_alpha;
 j20.coverage_type;
 j20.min_date;
 j20.max_date;
 j20.st_co_count;
 j20.sum_court_case;
 string3 has_court_case_data;
end;

r_slim t_slim(j20 le) := transform
 self.has_court_case_data := if(le.sum_court_case/le.st_co_count>.10,'D','N/A');
 self := le;
end;

j2 := project(j20,t_slim(left));

display1 := output(sort(j2,state_alpha,county_alpha),all,named('Foreclosure_Coverage'));

export coverage_foreclosure := display1;