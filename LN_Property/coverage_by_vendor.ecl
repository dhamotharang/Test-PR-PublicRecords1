import ut,ln_propertyv2;

ds_assr0 := ln_propertyv2.File_Assessment(state_code in ln_property.valid_states or fips_code in ln_property.valid_fips);
ds_deed0 := ln_propertyv2.File_Deed(state in ln_property.valid_states or fips_code in ln_property.valid_fips);

ln_property.mac_patch_county(ds_assr0,state_code,ds_assr);
ln_property.mac_patch_county(ds_deed0,state,ds_deed);

r1 := record
 string5  vendor;
 string5  fips;
 string2  st;
 string40 county;
 string4  type_;
 string15 coverage_type;
 string8  date;
end;

r1 t_assr(ds_assr le) := transform
 self.vendor        := if(le.vendor_source_flag in ['F','S'],'FARES','LEXIS');
 self.fips          := le.fips_code;
 self.st            := le.state_code;
 self.county        := le.county_name;
 self.type_         := 'ASSR';
 self.coverage_type := 'ASSESSED YEAR';
 self.date          := if(le.vendor_source_flag[1]='F',le.tax_year,le.assessed_value_year);
 //self.date          := if(le.tax_year between '1970' and ut.GetDate[1..4],le.tax_year,'');
end;

r1 t_deed(ds_deed le) := transform

 string8 v_rec_dt := le.recording_date;

 self.vendor        := if(le.vendor_source_flag in ['F','S'],'FARES','LEXIS'); 
 self.fips          := le.fips_code;
 self.st            := le.state;
 self.county        := le.county_name;
 self.type_         := if(le.from_file='D','DEED',if(le.from_file='M','MORT','DorM'));
 //self.type_         := if(le.from_file in ['D','M'],le.from_file,'DorM');
 self.coverage_type := 'RECORDING DATE';
 self.date          := if(v_rec_dt between '19700000' and ut.GetDate,v_rec_dt,'');
end;

assr_slim := project(ds_assr,t_assr(left));
deed_slim := project(ds_deed,t_deed(left));

concat := assr_slim+deed_slim;

fips_rec := record
string2  state_alpha;
string2  state_code;
string3  county_code;
string40 county_alpha;
string2  class;
string1  crlf;
end;

fips_lookup := dedup(dataset('~thor_data400::in::fips_code_lookup',fips_rec,flat),state_code,county_code,record);

r1 t_translate(r1 le, fips_lookup ri) := transform
 self.st     := if(trim(le.st)='',ri.state_alpha,le.st);
 self.county := if(trim(le.county)='',ri.county_alpha,le.county);
 self        := le;
end;

j1 := join(concat,fips_lookup,
           left.fips[1..2]=right.state_code and left.fips[3..5]=right.county_code,
		   t_translate(left,right),lookup,
	       left outer
		  );

j1_filt := j1(date<>'');

r2 := record
 j1.vendor;
 j1.st;
 j1.county;
 j1.type_;
 j1.coverage_type;
 st_co_count := count(group);
end;

r3 := record
 j1_filt.vendor;
 j1_filt.st;
 j1_filt.county;
 j1_filt.type_;
 min_date     := min(group,j1_filt.date);
 max_date     := max(group,j1_filt.date);
end;

out3 := sort(table(j1,     r2,vendor,st,county,type_,coverage_type,few),vendor,st,county,type_);
out4 := sort(table(j1_filt,r3,vendor,st,county,type_,few),              vendor,st,county,type_);

r4 := record
 out3.vendor;
 out3.st;
 out3.county;
 out3.type_;
 out3.coverage_type;
 out3.st_co_count;
 out4.min_date;
 out4.max_date;
end;

r4 t_j1(out3 l, out4 r) := transform
 self := l;
 self := r;
end;

final_out := sort(join(out3,out4,(left.vendor=right.vendor and left.st=right.st and left.county=right.county and left.type_=right.type_),t_j1(left,right),left outer),type_,st,county)(st_co_count>10);
		  
export coverage_by_vendor := output(final_out(st<>'' and st in ln_property.valid_states and county<>''),all,named('Property_Coverage'));