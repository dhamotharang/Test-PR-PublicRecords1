import ln_property, codes;

ln_property_valid_state := [
'AK','AL','AR','AS','AZ','CA','CO','CT','DC','DE',
'FL','FM','GA','GU','HI','IA','ID','IL','IN','KS',
'KY','LA','MA','MD','ME','MH','MI','MN','MO','MP',
'MS','MT','NC','ND','NE','NH','NJ','NM','NV','NY',
'OH','OK','ON','OR','PA','PR','PW','RI','SC','SD',
'TN','TX','UM','UT','VA','VI','VT','WA','WI','WV',
'WY'];

fips_rec := record
string2  state_alpha;
string2  state_code;
string3  county_code;
string40 county_alpha;
string2  class;
string1  crlf;
end;

fips_data := dataset('~thor_data400::in::fips_code_lookup',fips_rec,flat);

ds := ln_property.File_Deed(document_type_code<>'',state in ln_property_valid_state);

rec := record
 string5 vendor;
 ds.fips_code;
 string2  st;
 string18 county;
 ds.document_type_code;
end;

rec t1(ds l) := transform
 
 string30 v_county1     := stringlib.stringtouppercase(l.county_name);
 string30 v_county2     := if(l.state='AK' and stringlib.stringfind(stringlib.stringtouppercase(v_county1),'FAIRBANKS',1)!=0,'FAIRBANKS NORTH STAR',
                           if(stringlib.stringfind(v_county1,'BOROUGH',1)!=0,v_county1[1..stringlib.stringfind(v_county1,'BOROUGH',1)-1],
 						   stringlib.stringfindreplace(v_county1,'\'','')));

 self.vendor             := if(l.vendor_source_flag[1..3]='FAR','FARES','LEXIS');
 self.fips_code          := l.fips_code;
 self.st                 := stringlib.stringtouppercase(l.state); 						   
 self.county             := v_county2;						   
 self.document_type_code := l.document_type_code;
 self := l;
end;

p1 := project(ds,t1(left));						   

dLexis := p1(vendor='LEXIS');
dFares := p1(vendor='FARES');
	   
rec populate_fares_st_county(dFares l, fips_data r) := transform
 self.st     := r.state_alpha;
 self.county := r.county_alpha;
 self := l;
end;

dFares_st_county := join(dFares,fips_data,
                         left.fips_code=right.state_code+right.county_code,
				         //(left.fips_code=right.state_code+right.county_code
						 // and left.state_code=right.state_alpha),
					     populate_fares_st_county(left,right),
					     lookup,left outer,nosort
					    );

concat := dLexis+dFares_st_county;

rec2 := record
 concat.fips_code;
 concat.st;
 concat.county;
 concat.document_type_code;
 count_ := count(group);
end;

t_out := table(concat,rec2,fips_code,st,county,document_type_code);

codes_lookup := codes.File_Codes_V3_In(trim(file_name)='FARES_1080',field_name[1..3]='DOC');
//output(codes_lookup);

lookup_rec := record
 string30  field;
 string15  code;
 string330 desc;
end;

lookup_rec t_lookup(codes_lookup l) := transform
 self.field := if(trim(l.field_name)='DOCUMENT_TYPE_CODE','DOCUMENT_TYPE',l.field_name);
 self.code  := l.code;
 self.desc  := l.long_desc;
end;

document_type_lookup := dedup(project(codes_lookup,t_lookup(left)),all);

rec3 := record
 rec2.fips_code;
 rec2.st;
 rec2.county;
 rec2.document_type_code;
 string50 document_type_desc;
 rec2.count_;
end;

rec3 tjoin(t_out l, document_type_lookup r) := transform
 self                    := l;
 self.document_type_desc := r.desc;
end;

pjoin := join(t_out,document_type_lookup,
              trim(left.document_type_code)=trim(right.code),
			  tjoin(left,right),
			  left outer,lookup
			 ) : persist('property_document_types');

pjoin_filt := pjoin(document_type_desc<>'');

rec4 := record
 pjoin_filt.fips_code;
 pjoin_filt.st;
 pjoin_filt.county;
 pjoin_filt.document_type_desc;
 pjoin_filt.count_;
 integer final_count;
end;

rec4 t4(pjoin_filt l) := transform
 self.final_count := l.count_;
 self             := l;
end;

p4      := project(pjoin_filt,t4(left));
p4_sort := sort(p4,st,county,document_type_desc);

rec4 trollup(p4_sort l, p4_sort r) := transform
 self.final_count := l.final_count+r.final_count;
 self             := l;
end;

prollup := rollup(p4_sort,
            (left.fips_code=right.fips_code and left.st=right.st and left.county=right.county and left.document_type_desc=right.document_type_desc),
			trollup(left,right)
			);

rslim := record
 //prollup.fips_code;
 prollup.st;
 prollup.county;
 prollup.document_type_desc;
 prollup.final_count;
end;

rslim tslim(prollup l) := transform
 self := l;
end;

pslim := project(prollup,tslim(left));

pslim_filt := pslim(st<>'',final_count>=5);			
output(pslim_filt,all);

export property_document_type_stats := pslim_filt;