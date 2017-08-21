ds := header.File_Headers(trim(jflag2)='');

r1 := record
 ds.did;
 unsigned8 did_ct := 1;
 integer   provided_dob_format;
end;

r1 t1(ds l) := transform

 string8 v_dob := (string8)l.dob;
 
 string8 v_dob2 := if(v_dob[5..8] ='0000',v_dob[1..4], v_dob);
 string8 v_dob3 := if(v_dob2[7..8]='00',  v_dob2[1..6],v_dob2);
 
 integer v_dob3_length := if(length(trim(v_dob3)) in [4,6,8],length(trim(v_dob3)),0);

 self.provided_dob_format := v_dob3_length;
 self                     := l;
end;

p1      := project   (ds,t1(left));
p1_dist := distribute(p1,hash(did));
p1_sort := sort      (p1_dist,did,local);

r1 t2(p1_sort l, p1_sort r) := transform
 self.did_ct              := l.did_ct+1;
 self.provided_dob_format := ut.max2(l.provided_dob_format,r.provided_dob_format);                            
 self                     := l;
end;

p2 := rollup(p1_sort,left.did=right.did,t2(left,right));

count(p2);
count(p2(provided_dob_format=8));
count(p2(provided_dob_format=6));
count(p2(provided_dob_format=4));