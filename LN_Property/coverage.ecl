states_to_include := [
'AK','AL','AR','AZ','CA','CO','CT','DC','DE','FL',
'GA','HI','IA','ID','IL','IN','KS','KY','LA','MA',
'MD','ME','MI','MN','MO','MS','MT','NC','ND','NE',
'NH','NJ','NM','NV','NY','OH','OK','OR','PA','RI',
'SC','SD','TN','TX','UT','VA','VI','VT','WA','WI',
'WV','WY'
];


import ln_property, ln_deed, ln_mortgage, ut;

/*Begin Assessment Stats*/

ds := ln_property.File_Assessment(state_code in states_to_include);

rec := record
 string2  st;
 string30 county;
 string20 vendor;
 string10 coverage_type;
 string4  date;
end;

rec t1(ds l) := transform

 string4 v_tax_year := if(l.tax_year between '1960' and ut.GetDate[1..4]+1,l.tax_year,'');
 
 self.st            := l.state_code;
 self.vendor        := if(l.vendor_source_flag='OKCTY','LEXIS',
                       if(l.vendor_source_flag='DAYTN','LEXIS-HISTORICAL',
					   'FARES'));
 self.county        := if(self.vendor[1..5]='LEXIS',stringlib.stringtouppercase(l.county_name),
                       if(length(trim(stringlib.stringfilter(l.fips_code,'0123456789')))=5,'FIPS COUNTY '+l.fips_code[3..5],
					   ''));
 self.coverage_type := 'TAX_YEAR';
 self.date          := v_tax_year;
end;

p1      := project(ds,t1(left));
p1_filt := p1(date<>'');

stat_rec := record
 p1.st;
 p1.county;
 p1.vendor;
 p1.coverage_type;
 st_src_count := count(group);
end;

stat_rec2 := record
 p1_filt.st;
 p1_filt.county;
 p1_filt.vendor;
 p1_filt.coverage_type;
 min_date     := min(group,p1_filt.date);
 max_date     := max(group,p1_filt.date);
end;

out1 := sort(table(p1,     stat_rec, st,county,vendor,coverage_type,few),st,county,vendor,coverage_type);
out2 := sort(table(p1_filt,stat_rec2,st,county,vendor,coverage_type,few),st,county,vendor,coverage_type);

stat := record
 out1.st;
 out1.county;
 out1.vendor;
 out1.coverage_type;
 out1.st_src_count;
 out2.min_date;
 out2.max_date;
end;

stat t_join(out1 l, out2 r) := transform
 self := l;
 self := r;
end;

property_assessment_coverages := sort(join(out1,out2,(left.st=right.st and left.county=right.county and left.vendor=right.vendor and left.coverage_type=right.coverage_type),t_join(left,right),left outer),st,vendor,county)(st_src_count>10);

display1 := output(property_assessment_coverages(vendor[1..5]='LEXIS'),all,named('LEXIS_Assessment_Coverage'));
display2 := output(property_assessment_coverages(vendor[1..5]='FARES'),all,named('FARES_Assessment_Coverage'));

/*Begin Deed & Mortgage Stats*/

ds_deed := ln_property.File_Deed(state in states_to_include);

rec2 := record
 string2  st;
 string30 county;
 string20 vendor;
 string5  type_;
 string10 coverage_type;
 string6  date;
end;

rec2 t2(ds_deed l) := transform

 string6 v_recording_date := if(l.recording_date[1..6] between '190000' and ut.GetDate[1..6],l.recording_date,'');
 string6 v_contract_date  := if(l.contract_date[1..6]  between '190000' and ut.GetDate[1..6],l.contract_date,'');
 
 self.st            := l.state;
 self.vendor        := if(l.vendor_source_flag='OKCTY','LEXIS',
                       if(l.vendor_source_flag='DAYTN','LEXIS-HISTORICAL',
					   'FARES'));
 self.county        := if(self.vendor[1..5]='LEXIS',stringlib.stringtouppercase(l.county_name),
                       if(length(trim(stringlib.stringfilter(l.fips_code,'0123456789')))=5,'FIPS COUNTY '+l.fips_code[3..5],
					   ''));
 self.coverage_type := if(v_recording_date<>'','RECORDING',
                       if(v_contract_date<>'','CONTRACT',
					   ''));
 self.date          := if(self.coverage_type='RECORDING',v_recording_date,
                       if(self.coverage_type='CONTRACT',v_contract_date,
					   ''));
 self.type_         := if(l.from_file='D','DEED',
                       if(l.from_file='M','MORT',
					   if(l.vendor_source_flag[1..3]='FAR','FARES',
					   '')));
end;

p2      := project(ds_deed,t2(left));

p2_filt := p2(date<>'');

stat_rec3 := record
 p2.st;
 p2.county;
 p2.vendor;
 p2.coverage_type;
 p2.type_;
 st_src_count := count(group);
end;

stat_rec4 := record
 p2_filt.st;
 p2_filt.county;
 p2_filt.vendor;
 p2_filt.coverage_type;
 p2_filt.type_;
 min_date     := min(group,p2_filt.date);
 max_date     := max(group,p2_filt.date);
end;

out3 := sort(table(p2,     stat_rec3,st,county,vendor,coverage_type,type_,few),st,county,vendor,coverage_type,type_);
out4 := sort(table(p2_filt,stat_rec4,st,county,vendor,coverage_type,type_,few),st,county,vendor,coverage_type,type_);

stat2 := record
 out3.st;
 out3.county;
 out3.vendor;
 out3.coverage_type;
 out3.type_;
 out3.st_src_count;
 out4.min_date;
 out4.max_date;
end;

stat2 t_join2(out3 l, out4 r) := transform
 self := l;
 self := r;
end;

property_deed_mortgage_coverages := sort(join(out3,out4,(left.st=right.st and left.county=right.county and left.vendor=right.vendor and left.coverage_type=right.coverage_type and left.type_=right.type_),t_join2(left,right),left outer),st,county,vendor,coverage_type,type_)(st_src_count>10);

display3 := output(property_deed_mortgage_coverages(type_='DEED'),all,named('LEXIS_Deed_Coverage'));
display4 := output(property_deed_mortgage_coverages(type_='MORT'),all,named('LEXIS_Mortgage_Coverage'));
display5 := output(property_deed_mortgage_coverages(type_='FARES'),all,named('FARES_Deed_Mortgage_Coverage'));

export coverage := parallel(display1,display2,display3,display4,display5);