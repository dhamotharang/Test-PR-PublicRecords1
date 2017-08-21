import ln_propertyv2;
//Lexis Deeds & Mortgages
//Result 1 with county & zip codes
//Result 2 just state & county
//Run on thor_dell400_2
//by Jason Trost
//Result 3 Prop DM by County DMFlag by John J. Bulten 20070417
//W20071019-141343, 20080205-111206

states_to_include := [
'AK','AL','AR','AZ','CA','CO','CT','DC','DE','FL',
'GA','HI','IA','ID','IL','IN','KS','KY','LA','MA',
'MD','ME','MI','MN','MO','MS','MT','NC','ND','NE',
'NH','NJ','NM','NV','NY','OH','OK','OR','PA','RI',
'SC','SD','TN','TX','UT','VA','VI','VT','WA','WI',
'WV','WY'
];

ds_deed := ln_propertyv2.File_Deed(state in states_to_include and vendor_source_flag in ['D','O']);

ds_search := ln_propertyv2.File_Search_DID(vendor_source_flag in ['D','O'] and ln_fares_id[2] in ['D','M'] and source_code[2]='P');

r_search_zip := record
 string12 ln_fares_id;
 //string1  owner_or_prop_addr;
 string5  zip;
 //string5  county;
end;

r_search_zip t_search_zip(ds_search l) := transform
 self := l;
end;

p_search_zip := distribute(dedup(project(ds_search,t_search_zip(left)),all),hash(ln_fares_id));

r_slimit := record
 string12   ln_fares_id;
 string5    fips_code;
 string2    state;
 string18   county_name;
end;

r_slimit t_slimit(ds_deed l) := transform
 self.state                  := trim(stringlib.stringtouppercase(l.state),all);
 self.county_name            := trim(stringlib.stringtouppercase(l.county_name),all);
 self                        := l;
end;

p_slimit := project(ds_deed,t_slimit(left));

r_lookup := record
 string2  st;
 string5  fips;
 string40 county;
 string3  not_relevant;
end;

fips_lookup := dataset('~thor_data400::in::fips_code_lookup',r_lookup,flat);

r_translate := record
 string2  state_alpha;
 string40 county_alpha;
 p_slimit;
end;

r_translate t_translate(p_slimit l, fips_lookup r) := transform

 //boolean v_found   := r.fips<>'';
 
 self.state_alpha  := if(trim(l.fips_code)='',l.state,trim(r.st,all));
 self.county_alpha := if(trim(l.fips_code)='',l.county_name,trim(r.county,all));
 self              := l;
end;

j_translate_ := join(p_slimit,fips_lookup,
                    left.fips_code=right.fips,
					t_translate(left,right),
					left outer, lookup
				   );

j_translate := distribute(j_translate_,hash(ln_fares_id));

r_combine := record
 j_translate.ln_fares_id;
 j_translate.fips_code;
 j_translate.state;
 j_translate.county_name;
 p_search_zip.zip;
 //p_search_zip.county;
end;

r_combine t_j1(j_translate le, p_search_zip ri) := transform
 self.county_name := if(trim(le.county_name)='','<UNK>',le.county_name);
 self.zip         := if(trim(ri.zip)='','<UNK>',ri.zip);
 self             := le;
 self             := ri;
end;

j1 := join(j_translate,p_search_zip,
           left.ln_fares_id=right.ln_fares_id,
		   t_j1(left,right),
		   left outer,local
		  );

r_trim1 := record
 j1.state;
 j1.county_name;
 j1.zip;
end;

r_trim2 := record
 j1.state;
 j1.county_name;
 //j1.zip;
end;

r_trim1 t_trim1(j1 le) := transform
 self := le;
end;

r_trim2 t_trim2(j1 le) := transform
 self := le;
end;

p_trim1 := project(j1,t_trim1(left));
p_trim2 := project(j1,t_trim2(left));

r_s1 := record
 p_trim1;
 count_ := count(group);
end;

r_s2 := record
 p_trim2;
 count_ := count(group);
end;

t_s1 := sort(table(p_trim1,r_s1,state,county_name,zip),state,county_name,zip);
t_s2 := sort(table(p_trim2,r_s2,state,county_name),state,county_name);

output(t_s1,all);
output(t_s2,all);

//r_trim3, t_trim3, p_trim3, r_s3, t_s3, output by John J. Bulten 20070417
r_trim3 := record
 j1.state;
 j1.county_name;
 ln_fares_id2 := j1.ln_fares_id[2];
end;
r_trim3 t_trim3(j1 le) := transform
 self.ln_fares_id2 := le.ln_fares_id[2];
 self := le;
end;
p_trim3 := project(j1,t_trim3(left));
r_s3 := record
 p_trim3;
 count_ := count(group);
end;
t_s3 := sort(table(p_trim3,r_s3,state,county_name,ln_fares_id2),state,county_name,ln_fares_id2);
output(t_s3,all);