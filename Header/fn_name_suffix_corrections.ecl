import ut;

//apply after linking rules but before last_rollup
//how can we account for this in basic_match (we fixed in the header but all these bad records will get re-introduced)
//so that we can apply this to the data?
//how can we also apply to transunion?

export fn_name_suffix_corrections(dataset(recordof(header.layout_header)) in_hdr) := function

//i don't want to apply anything to brand new entities
prod_max_rid := max(dataset('~thor_data400::base::header_prod',header.layout_header_v2,flat),rid);

candidates := in_hdr(did<=prod_max_rid or src in ['LT','TU']);
skip_these := in_hdr(did> prod_max_rid);

candidates_dist := distribute(candidates,hash(did));

candidates_counts_per_did := header.counts_per_did(candidates_dist);

r1 := record
 candidates_counts_per_did;
 string20 lname2;
 boolean  has_suffix;
 boolean  lname_ends_in_suffix;
 string2  suffix_in_lname;
 string1  is_female    :='';
 integer  is_female_cnt:=0;
end;

r1 t1(candidates_counts_per_did le) := transform
 
 integer v_lname_length    := length(trim(le.lname));
 string  v_suffix_in_lname := le.lname[length(trim(le.lname))-1..length(trim(le.lname))];

 //cases like 'MD' in the name_suffix creates a false positive
 self.has_suffix           := trim(le.name_suffix) in ['JR','SR','II','III'];
 //self.has_suffix           := le.name_suffix<>'' and ut.is_unk(le.name_suffix)=false;
 self.suffix_in_lname      := if(v_suffix_in_lname in ['JR','SR'],v_suffix_in_lname,'');
 self.lname_ends_in_suffix := self.suffix_in_lname<>'';
 self.lname2               := if(self.lname_ends_in_suffix=true,le.lname[1..v_lname_length-2],le.lname);
 self                      := le;
end;

p1 := project(candidates_counts_per_did,t1(left));

r2 := record
 p1.did;
 p1.has_suffix;
end;

p2      := table(p1,r2);
p2_sort := sort(p2,did,has_suffix,local);
p2_dupd := dedup(p2_sort,did,has_suffix,local);

r2 t2(r2 le, r2 ri) := transform
 self.has_suffix := if(le.has_suffix=true,le.has_suffix,ri.has_suffix);
 self            := le;
end;

p3 := rollup(p2_dupd,left.did=right.did,t2(left,right),local);

r1 t3(r1 le, r2 ri) := transform
 self.has_suffix := ri.has_suffix;
 self            := le;
 self            := ri;
end;

j1 := join(p1,p3,left.did=right.did,t3(left,right),local);

r1 t4(j1 le) := transform
 self.is_female_cnt := if(datalib.gender(le.fname)='F',1,0);
 self               := le;
end;

p4 := project(j1,t4(left));

females := sort(distribute(p4(is_female_cnt=1),hash(did)),did,local);

r1 t5(r1 le, r1 ri) := transform
 self.is_female_cnt := le.is_female_cnt+1;
 self               := le;
end;

p6 := rollup(females,left.did=right.did,t5(left,right),local);
 
r1 t6(r1 le, r1 ri) := transform
 self.is_female_cnt := ri.is_female_cnt;
 self               := le;
end;

j3 := join(j1,p6,left.did=right.did and left.did_ct=right.is_female_cnt,t6(left,right),local);

r1 t7(r1 le, r1 ri) := transform
 self.is_female     := if(le.did=ri.did,'Y','');
 self.is_female_cnt := ri.is_female_cnt;
 self               := le;
end;

j4 := join(j1,j3,left.did=right.did,t7(left,right),left outer,keep(1),local);

r4 := record
 j4;
 string20 lname_new;
 string5  name_suffix_new;
 boolean  case1;
 boolean  case2;
 boolean  case3;
 boolean  case4;
 integer  case_cnt;
end;

r4 t8(r1 le) := transform
 
 boolean v_case1 := le.is_female='Y'             and le.has_suffix=true and le.name_suffix<>'';
 boolean v_case2 := le.is_female='Y'             and le.lname_ends_in_suffix=true;
 boolean v_case3 := le.lname_ends_in_suffix=true and le.has_suffix=true;
 boolean v_case4 := le.lname_ends_in_suffix=true and le.did_ct=1;
 
 self.lname_new := if(v_case2 or v_case3 or v_case4,le.lname2,le.lname);
 self.name_suffix_new := if(v_case1 or v_case2,'',
                         if(v_case3 or v_case4,le.suffix_in_lname,
						 le.name_suffix));

 self.case1 := v_case1;
 self.case2 := v_case2;
 self.case3 := v_case3;
 self.case4 := v_case4;
 
 self.case_cnt := sum(if(self.case1=true,1,0)
                     +if(self.case2=true,1,0)
				     +if(self.case3=true,1,0)
				     +if(self.case4=true,1,0)
				     );
				 
 self := le;
end;

p_final := project(j4,t8(left));

concat := project(p_final,transform({header.layout_header},self.lname:=left.lname_new,self.name_suffix:=left.name_suffix_new,self:=left))+skip_these;

return concat;

end;