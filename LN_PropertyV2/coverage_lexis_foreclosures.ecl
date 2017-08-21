
import ut;


ds := ln_propertyv2.File_Deed(vendor_source_flag in ['D','O'] and trim(document_type_code) in ['DL','FC','SD','TD'] and state<>'' and county_name<>'');

r1 := record
 ds.state;
 ds.county_name;
 string25 coverage_type;
 string8  date;
end;

r1 t_recording(ds le) := transform
 
 self.date          := if(le.recording_date[1..6] between '197000' and ut.GetDate[1..6],le.recording_date,'');
 self.coverage_type := 'RECORDING DATE';
 self               := le;
end;

p_recording := project(ds,t_recording(left));

p1 := p_recording;

p1_filt := p1(date<>'');

stat_rec := record
 p1.state;
 p1.county_name;
 p1.coverage_type;
 st_co_count := count(group);
end;

stat_rec2 := record
 p1_filt.state;
 p1_filt.county_name;
 p1_filt.coverage_type;
 min_date     := min(group,p1_filt.date);
 max_date     := max(group,p1_filt.date);
end;

out1 := sort(table(p1,     stat_rec, state,county_name,coverage_type,few),state,county_name,coverage_type);
out2 := sort(table(p1_filt,stat_rec2,state,county_name,coverage_type,few),state,county_name,coverage_type);

stat := record
 out1.state;
 out1.county_name;
 out1.coverage_type;
 out2.min_date;
 out2.max_date;
 out1.st_co_count;
end;

stat t_join(out1 l, out2 r) := transform
 self := l;
 self := r;
end;

j1 := join(out1,out2,(left.state=right.state and left.county_name=right.county_name and left.coverage_type=right.coverage_type),t_join(left,right));

display1 := output(sort(j1(st_co_count>50),state,county_name),all,named('Lexis_Foreclosure_Coverage'));

export coverage_lexis_foreclosures := display1;