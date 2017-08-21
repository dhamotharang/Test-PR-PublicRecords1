//W20090618-091734

//export linking_females_on_name_ssn := 'todo';
hdr := header.file_headers;

r1 := record
 integer did_cnt;
 integer is_female_cnt;
 integer is_male_cnt;
 //string1 gender;
 unsigned6 other_did;
 hdr;
end;

r1 t1(hdr le) := transform
 self.did_cnt := 1;
 self.is_female_cnt := if(datalib.gender(le.fname)='F',1,0);
 self.is_male_cnt   := if(datalib.gender(le.fname)='M',1,0);
 //self.gender := datalib.gender(le.fname);
 self.other_did := 0;
 self := le;
end;

p1 := project(hdr,t1(left));

p1_dist := distribute(p1,hash(did));
p1_sort := sort(p1_dist,did,local);

r1 t2(r1 le, r1 ri) := transform
 self.did_cnt := le.did_cnt+1;
 self := le;
end;

p2 := rollup(p1_sort,left.did=right.did,t2(left,right),local);

females := sort(distribute(p1(is_female_cnt=1),hash(did)),did,local);
males   := sort(distribute(p1(is_male_cnt  =1),hash(did)),did,local);



r1 t3(r1 le, r1 ri) := transform
 self.is_female_cnt := le.is_female_cnt+1;
 self := le;
end;

p3 := rollup(females,left.did=right.did,t3(left,right),local);
 

r1 t4(r1 le, r1 ri) := transform
 self := le;
end;

j1 := join(p2,p3,left.did=right.did and left.did_cnt=right.is_female_cnt,t4(left,right),local);

j2 := join(p1_dist,j1,left.did=right.did,t4(left,right),local);

has_ssn := distribute(j2(ut.full_ssn(ssn)),hash(ssn,prim_name,fname));

r1 t5(r1 le, r1 ri) := transform
 self.other_did := ri.did;
 self := le;
end;

j3 := join(has_ssn,has_ssn,left.ssn=right.ssn and left.fname=right.fname and left.lname=right.lname and left.did<right.did,t5(left,right),local);

j3_dupd := dedup(j3,record,all);

//count(j3);
//output(j3);
//output(j3(did=785532438 or other_did=785532438));

r2 := record
 unsigned6 did;
 string9   ssn;
 string20  fname;
 string20  lname;
end;

r2 t6(r1 le, integer c) := transform
 self.did := choose(c,le.did,le.other_did);
 self     := le;
end;

p4 := dedup(normalize(j3_dupd,2,t6(left,counter)),record,all);

output(p4(ssn='054761849'));

count(p4);
count(dedup(p4,ssn,fname,lname,record,all));
count(dedup(p4,did,all));

output(choosen(sort(p4,ssn,fname,lname,did),1000));