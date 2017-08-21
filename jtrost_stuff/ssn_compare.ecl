import mdr;

gathered := distribute(jtrost_stuff.ssn_gather,hash(ssn));

f1 := gathered(src ='--');
f2 := gathered(src!='--');

r0 := record
 f2;
 string9 ssn2;
end;

r0 t1(f2 le, f1 ri) := transform
 self      := le;
 self.ssn2 := ri.ssn;
end;

j1 := join(f2,f1,left.ssn=right.ssn,t1(left,right),left outer,local);

r1 := record
 j1.src;
 src_ct := count(group);
end;

r2 := record
 j1.src;
 integer ssn_in_eq := count(group,j1.ssn2<>'');
 //count_ := count(group);
end;

r3 := record
 j1.src;
 integer bad_ssn_ct := count(group,j1.bad_ssn=1);
 //count_ := count(group);
end;

r4 := record
 j1.src;
 integer minor_ct := count(group,j1.belongs_to_minor=1);
 //count_ := count(group);
end;

r5 := record
 j1.src;
 integer ssn4_ct := count(group,j1.ssn4=1);
end;

ta0 := table(j1,r1,src,few);
ta1 := table(j1,r2,src,few);
ta2 := table(j1,r3,src,few);
ta3 := table(j1,r4,src,few);
ta4 := table(j1,r5,src,few);

r6 := record
 ta0;
 ta1.ssn_in_eq;
end;

r6 t_j2(ta0 le, ta1 ri) := transform
 self := le;
 self := ri;
end;

j2 := join(ta0,ta1,left.src=right.src,t_j2(left,right),local);

r7 := record
 j2;
 ta2.bad_ssn_ct;
end;

r7 t_j3(j2 le, ta2 ri) := transform
 self := le;
 self := ri;
end;

j3 := join(j2,ta2,left.src=right.src,t_j3(left,right),local);

r8 := record
 j3;
 ta3.minor_ct;
end;

r8 t_j4(j3 le, ta3 ri) := transform
 self := le;
 self := ri;
end;

j4 := join(j3,ta3,left.src=right.src,t_j4(left,right),local);

r9 := record
 j4;
 ta4.ssn4_ct;
end;

r9 t_j5(j4 le, ta4 ri) := transform
 self := le;
 self := ri;
end;

j5 := join(j4,ta4,left.src=right.src,t_j5(left,right),local);

r10 := record
 string30 src_desc;
 integer diff_;
 j5;
end;

r10 t8(j5 le) := transform
 self.src_desc := stringlib.stringtouppercase(mdr.sourceTools.translatesource(le.src));
 self.diff_ := le.src_ct-le.ssn_in_eq;
 self := le;
end;

p8 := project(j5,t8(left));

export ssn_compare := output(sort(p8,-diff_,src_desc),all);