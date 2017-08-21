import ln_mortgage,ln_propertyv2;

fips_rec := record
 string2  st;
 string5  fips;
 string40 county;
 string3  not_relevant;
end;

fips_lookup := dedup(sort(dataset('~thor_data400::in::fips_code_lookup',fips_rec,flat),fips),fips);

ds_assr := ln_propertyv2.File_Assessment;
ds_deed := ln_propertyv2.File_Deed;

r1 := record
 string1  vendor;
 string2  st;
 string40 county;
 string5  fips_code;
 string1  type_;
 boolean  is_current;//:=false;
 integer  st_co_count;
 integer  is_current_count;
end;

fn_fix_county(string in_co, string in_st) := function

 string cleanup_ := trim(stringlib.stringcleanspaces(stringlib.stringfilterout(stringlib.stringtouppercase(in_co),'.')),left,right);
 string rename_  := if(stringlib.stringfind(cleanup_,'FAIRBANK',1)!=0 and in_st='AK','FAIRBANKS NORTH STAR',
                    if(stringlib.stringfind(cleanup_,'BOROUGH',1)!=0,cleanup_[1..stringlib.stringfind(cleanup_,'BOROUGH',1)-1],
					if(in_st='FL' and trim(cleanup_)='MIAMI-DADE','DADE',
					stringlib.stringfindreplace(cleanup_,'\'',''))));

 return rename_;
 
end;

curr_set_assr := ['2008'];
curr_set_deed := ['2008'];

r1 t1(ln_propertyv2.Layout_Property_Common_Model_BASE le) := transform
						   
 self.vendor      := if(le.vendor_source_flag in ['F','S'],'F','L');
 self.st          := le.state_code;
 self.county      := fn_fix_county(le.county_name,self.st);
 self.fips_code   := le.fips_code;
 self.type_       := 'A';
 //self.is_current  := le.assessed_value_year in ['2007','2008'] or le.tax_year in ['2007','2008'] or le.process_date[1..4] in ['2008'];
 self.is_current  := le.assessed_value_year in curr_set_assr or le.tax_year in curr_set_assr;// or le.process_date[1..4] in curr_set_assr;
 self.is_current_count  := if(self.is_current=true,1,0);
 self.st_co_count := 1;
end;

r1 t2(ln_propertyv2.Layout_Deed_Mortgage_Common_Model_Base le) := transform

 self.vendor      := if(le.vendor_source_flag in ['F','S'],'F','L');
 self.st          := le.state;
 self.county      := fn_fix_county(le.county_name,self.st);
 self.fips_code   := le.fips_code;
 self.type_       := 'D';
 self.is_current  := le.recording_date[1..4] in curr_set_deed or le.contract_date[1..4] in curr_set_deed or le.process_date[1..4] in curr_set_deed;
 //self.is_current_count  := if(le.recording_date[1..4] in ['2008'] or le.contract_date[1..4] in ['2008'] or le.process_date[1..4] in ['2008'],1,0);
 self.is_current_count  := if(self.is_current=true,1,0);
 self.st_co_count := 1;
end;

ds_assr_slim := project(ds_assr,t1(left));
ds_deed_slim := project(ds_deed,t2(left));

//exclude ontario provinces
concat0 := (ds_assr_slim+ds_deed_slim)(st<>'ON');

r2 := record
 concat0;
 string2  st_lookup    :='';
 string40 county_lookup:='';
end;

concat := project(concat0,r2);

concat_has_fips := concat(fips_code<>'');
concat_no_fips  := concat(trim(fips_code)='');

r2 t_get_fips(concat le, fips_lookup ri) := transform
 self.st_lookup     := ri.st;
 self.county_lookup := ri.county;
 self               := le;
end;

j_get_fips0 := join(concat_has_fips,fips_lookup,
                   left.fips_code=right.fips,
				   t_get_fips(left,right),
				   lookup, left outer
				  );

j_get_fips := j_get_fips0+concat_no_fips;

r1 t_override(j_get_fips le) := transform
 self.st     := if(trim(le.st)='' or (le.st<>'' and le.st_lookup<>'' and le.st<>le.st_lookup),le.st_lookup,le.st);
 self.county := if(trim(le.county)='' or (le.county<>'' and le.county_lookup<>'' and le.county<>le.county_lookup),le.county_lookup,le.county);
 self        := le;
end;

p_override0 := project(j_get_fips,t_override(left))(st in ln_property.valid_states and ~regexfind('[0-9]',county) and ~regexfind('[A-Z] ',trim(county)[1..2]));

p_override  := p_override0(st<>'' and county<>'');

p_override_dist := distribute(p_override,hash(vendor,type_,st,county));
p_override_sort := sort(p_override_dist,vendor,type_,st,county,local);

r1 t_rollup(r1 le, r1 ri) := transform
 self.st_co_count := le.st_co_count+1;
 //self.is_current  := if(le.is_current=true,le.is_current,ri.is_current);
 self.is_current_count := le.is_current_count+ri.is_current_count;
 self             := le;
end;

p_rollup := rollup(p_override_sort,left.vendor=right.vendor and left.type_=right.type_ and left.st=right.st and left.county=right.county,t_rollup(left,right),local);

r_slim := record
 p_rollup.vendor;
 p_rollup.type_;
 p_rollup.st;
 p_rollup.county;
 p_rollup.st_co_count;
 p_rollup.is_current;
end;

r_slim t_slim(p_override le) := transform
 self.is_current := if(le.is_current_count>5  and le.type_='D',true,
                    if(le.is_current_count>25 and le.type_='A',true,
					false));
 self := le;
end;

p_slim := project(p_rollup(st_co_count>500),t_slim(left));

assr_fares := p_slim(vendor='F' and type_='A');
assr_lexis := p_slim(vendor='L' and type_='A');

deed_fares := p_slim(vendor='F' and type_='D');
deed_lexis := p_slim(vendor='L' and type_='D');

output(count(assr_fares),named('assr_fares'));
output(count(assr_lexis),named('assr_lexis'));
output(count(deed_fares),named('deed_fares'));
output(count(deed_lexis),named('deed_lexis'));

r3 := record
 string2  st;
 string40 county;
 integer  fares_st_co_count;
 integer  lexis_st_co_count;
 boolean  fares_is_current;
 boolean  lexis_is_current;
end;

r3 t_in_both(r_slim le, r_slim ri) := transform
 self.fares_st_co_count := le.st_co_count;
 self.lexis_st_co_count := ri.st_co_count;
 self.fares_is_current  := le.is_current;
 self.lexis_is_current  := ri.is_current;
 self                   := le;
end;

r4 := record
 string2  st;
 string40 county;
 integer  st_co_count;
 boolean  is_current;
end;

r4 t_fares_only(r_slim le, r_slim ri) := transform
 self := le;
end;

r4 t_lexis_only(r_slim le, r_slim ri) := transform
 self := ri;
end;

assr_in_both := join(assr_fares,assr_lexis,
                     left.st=right.st and left.county=right.county,
					 t_in_both(left,right)
					);

deed_in_both := join(deed_fares,deed_lexis,
                     left.st=right.st and left.county=right.county,
					 t_in_both(left,right)
					);					

assr_in_fares_only := join(assr_fares,assr_lexis,
                           left.st=right.st and left.county=right.county,
					       t_fares_only(left,right),
						   left only
					      );

assr_in_lexis_only := join(assr_fares,assr_lexis,
                           left.st=right.st and left.county=right.county,
					       t_lexis_only(left,right),
						   right only
					      );

deed_in_fares_only := join(deed_fares,deed_lexis,
                           left.st=right.st and left.county=right.county,
					       t_fares_only(left,right),
						   left only
					      );

deed_in_lexis_only := join(deed_fares,deed_lexis,
                           left.st=right.st and left.county=right.county,
					       t_lexis_only(left,right),
						   right only
					      );

display1 := output(sort(assr_in_both,st,county),all,named('assr_in_both'));
display2 := output(sort(assr_in_fares_only,st,county),all,named('assr_in_fares_only'));
display3 := output(sort(assr_in_lexis_only,st,county),all,named('assr_in_lexis_only'));
display4 := output(sort(deed_in_both,st,county),all,named('deed_in_both'));
display5 := output(sort(deed_in_fares_only,st,county),all,named('deed_in_fares_only'));
display6 := output(sort(deed_in_lexis_only,st,county),all,named('deed_in_lexis_only'));

export coverage_overlap := parallel(display1,display2,display3,display4,display5,display6);