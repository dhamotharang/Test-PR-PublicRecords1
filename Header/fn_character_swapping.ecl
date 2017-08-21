import idl_header;

/*
while initially this attempt to just swap O's and zeroes (and remove some other high-level junk)
the function should not just be limited to this type of character swapping
...maybe 1's and I's are another opportunity
*/

export fn_character_swapping(dataset(recordof(header.Layout_New_Records)) in_hdr) := function

candidate_recs := in_hdr(stringlib.stringfind(fname,'0',1)>0 or stringlib.stringfind(mname,'0',1)>0 or stringlib.stringfind(lname,'0',1)>0);
skip_these     := in_hdr(~(stringlib.stringfind(fname,'0',1)>0 or stringlib.stringfind(mname,'0',1)>0 or stringlib.stringfind(lname,'0',1)>0));
ins_name_tbl   := idl_header.name_count_ds(placement_cnt>100 and length(trim(name))>1);

r1 := record
 string20 orig_name;
 string1  orig_name_type;
end;

r1 x1(candidate_recs le, integer c) := transform
 self.orig_name      := choose(c,le.fname,le.mname,le.lname);
 self.orig_name_type := choose(c,'F','M','L');
end;

p1 := normalize(candidate_recs,3,x1(left,counter));
f1 := p1(stringlib.stringfind(orig_name,'0',1)>0);

r2 := record
 f1;
 string20 new_name1;
 string20 new_name2;
end;

//create 2 alternatives
//the 1st replaces zeroes with O's (ex JAS0N => JASON)
//the 2nd removes zeroes completely (ex 0JASON => JASON)
//there is then an evaluation to determine which is the better option
r2 x2(f1 le) := transform
 self.new_name1     := stringlib.stringfindreplace(le.orig_name,'0','O');
 self.new_name2     := stringlib.stringfilterout(le.orig_name,'0');
 self               := le;
end;

p2 := project(f1,x2(left));

r3 := record
 p2;
 integer    placement_cnt1;
 integer    placement_cnt2  :=0;
 string1    better_option   :='';
 string20   better_name     :='';
 boolean    bad_candidate   :=false;
end;

r3 x3(p2 le, idl_header.name_count_ds ri) := transform
 self.placement_cnt1   := ri.placement_cnt;
 self                  := le;
end;

j1 := join(p2,ins_name_tbl,left.new_name1=right.name,x3(left,right),left outer,lookup);

r3 x4(j1 le, idl_header.name_count_ds ri) := transform
 self.placement_cnt2   := ri.placement_cnt;
 self                  := le;
end;

j2 := join(j1,ins_name_tbl,left.new_name2=right.name,x4(left,right),left outer,lookup);

r3 x5(r3 le) := transform
 self.bad_candidate := regexfind('[1-9]',le.orig_name)=true or le.orig_name='0';
 self.better_option := if(le.placement_cnt1>100,'1','2');
 self.better_name   := if(self.better_option='1',le.new_name1,le.new_name2);
 self               := le;
end;

p3 := project(j2,x5(left));

r_stat := record
 p3.orig_name;
 p3.better_name;
 p3.bad_candidate;
 count_ := count(group);
end;

ta1 := sort(table(p3,r_stat,orig_name,better_name,bad_candidate,few),-count_);
//output(choosen(ta1,1000),named('o_and_zero_corrections_distribution'));

r4 := record
 candidate_recs;
 string20 new_fname;
 string20 new_mname:='';
 string20 new_lname:='';
 boolean  fname_bad_candidate;
 boolean  mname_bad_candidate:=false;
 boolean  lname_bad_candidate:=false;
end;

r4 x6(recordof(in_hdr) le, p3 ri) := transform
 self.new_fname           := ri.better_name;
 self.fname_bad_candidate := ri.bad_candidate;
 self                     := le;
end;

j3 := join(candidate_recs,p3,left.fname=right.orig_name,x6(left,right),left outer,lookup);

r4 x7(r4 le, r3 ri) := transform
 self.new_mname           := ri.better_name;
 self.mname_bad_candidate := ri.bad_candidate;
 self                     := le;
end;

j4 := join(j3,p3,left.mname=right.orig_name,x7(left,right),left outer,lookup);


r4 x8(r4 le, r3 ri) := transform
 self.new_lname           := ri.better_name;
 self.lname_bad_candidate := ri.bad_candidate;
 self                     := le;
end;

j5 := join(j4,p3,left.lname=right.orig_name,x8(left,right),left outer,lookup);
//output(choosen(j5,1000),named('o_and_zero_corrections_header_sample'));

recordof(in_hdr) x9(j5 le) := transform
 self.fname := if(le.fname_bad_candidate=true,'',if(le.new_fname<>'',le.new_fname,le.fname));
 self.mname := if(le.mname_bad_candidate=true,'',if(le.new_mname<>'',le.new_mname,le.mname));
 self.lname := if(le.lname_bad_candidate=true,'',if(le.new_lname<>'',le.new_lname,le.lname));
 self       := le;
end;

p4 := project(j5,x9(left));
//output(choosen(p4,1000),named('o_and_zero_corrections_header_sample2'));

concat := p4+skip_these;

return concat;

end;