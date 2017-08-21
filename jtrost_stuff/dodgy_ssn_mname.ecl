hdr := header.file_headers;

r1 := record
 unsigned6 did;
 string20  fname;
 string20  mname;
 string9   ssn;
 string1   init_fname;
 string1   init_mname;
 string20  p_fname;
 boolean   intersect;
end;

r1 t1(hdr le) := transform
 self.init_fname := le.fname[1];
 self.init_mname := le.mname[1];
 self.p_fname    := datalib.preferredfirst(le.fname);
 self.intersect  := false;
 self            := le;
end;

p1      := project(hdr,t1(left));
p1_filt := p1(ut.full_ssn(ssn)=true and init_mname<>'');

r2 := record
 p1_filt.did;
 p1_filt.fname;
 p1_filt.mname;
 p1_filt.ssn;
 p1_filt.init_fname;
 p1_filt.init_mname;
 p1_filt.p_fname;
 p1_filt.intersect;
 count_ := count(group);
end;

ta1       := table(p1_filt,r2,did,fname,mname,ssn,init_fname,init_mname,p_fname,intersect);
ta1_filt0 := ta1(count_>1) : persist('persist::jtrost_dodgy');

r2 t_prop_pref_fname(r2 le, r2 ri) := transform
 //self.p_fname := if(le.did=ri.did and le.init_mname=ri.init_mname and le.ssn=ri.ssn and le.p_fname=ri.p_fname[1],ri.p_fname,le.p_fname);
 self.p_fname := if(length(trim(le.p_fname))>length(trim(ri.p_fname)),le.p_fname,ri.p_fname);
 self         := le;
end;

ta1_filt00 := join(ta1_filt0,ta1_filt0,
                 left.did=right.did and
				 left.init_mname=right.init_mname and
				 left.ssn=right.ssn and
				 left.init_fname=right.init_fname,// and
				 //left.p_fname>right.p_fname,
				 t_prop_pref_fname(left,right)
				 //left outer,keep(1)
				 ) : persist('persist::jtrost_dodgy1');
				

ta1_filt := dedup(ta1_filt00(length(trim(p_fname))>1),record,all);

r3 := record
 ta1_filt.did;
 //ta1_filt.ssn;
 integer did_ssn_cnt := count(group);
end;

//ta20 := table(dedup(ta1_filt,did,ssn,all),r3,did,ssn);
ta20 := table(dedup(ta1_filt,did,ssn,all),r3,did);
ta2  := ta20(did_ssn_cnt>1) : persist('persist::jtrost_dodgy2');

r4 := record
 ta1_filt.did;
 //ta1_filt.init_mname;
 integer did_mname_cnt := count(group);
end;

//ta30 := table(ta1_filt,r4,did,init_mname);
ta30 := table(dedup(ta1_filt,did,init_mname,all),r4,did);
ta3  := ta30(did_mname_cnt>1) : persist('persist::jtrost_dodgy3');

r5 := record
 ta1_filt.did;
 //ta1_filt.p_fname;
 integer did_fname_cnt := count(group);
end;

//ta40 := table(ta1_filt,r5,did,p_fname);
ta40 := table(dedup(ta1_filt,did,p_fname,all),r5,did);
ta4  := ta40(did_fname_cnt=1) : persist('persist::jtrost_dodgy4');

r2 t2(r2 le, r3 ri) := transform
 self := le;
end;

j1 := join(ta1_filt,ta2,left.did=right.did,t2(left,right),keep(1));

r2 t3(r2 le, r4 ri) := transform
 self := le;
end;

j2 := join(j1,ta3,left.did=right.did,t3(left,right),keep(1));

r2 t4(r2 le, r5 ri) := transform
 self := le;
end;

j3 := join(j2,ta4,left.did=right.did,t4(left,right),keep(1)) : persist('persist::jtrost_dodgy5');

r6 := record
 unsigned6 l_did;
 unsigned6 r_did;
 string20 l_fname;
 string20 r_fname;
 string20 l_mname;
 string20 r_mname;
 string9  l_ssn;
 string9  r_ssn;
 string1  l_init_fname;
 string1  r_init_fname;
 string1  l_init_mname;
 string1  r_init_mname;
 string20 l_p_fname;
 string20 r_p_fname;
 boolean  l_intersect;
 boolean  r_intersect;
 integer  l_count_;
 integer  r_count_;
end;

r6 t5(r2 le, r2 ri) := transform
 self.l_did := le.did;
 self.r_did := ri.did;
 self.l_fname := le.fname;
 self.r_fname := ri.fname;
 self.l_mname := le.mname;
 self.r_mname := ri.mname;
 self.l_ssn := le.ssn;
 self.r_ssn := ri.ssn;
 self.l_init_fname := le.init_fname;
 self.r_init_fname := ri.init_fname;
 self.l_init_mname := le.init_mname;
 self.r_init_mname := ri.init_mname;
 self.l_p_fname := le.p_fname;
 self.r_p_fname := ri.p_fname;
 self.l_intersect := le.intersect;
 self.r_intersect := ri.intersect;
 self.l_count_ := le.count_;
 self.r_count_ := ri.count_;
end;

j4 := join(j3,j3,left.did=right.did and (left.init_mname<>right.init_mname or left.ssn<>right.ssn),t5(left,right));

ut.mac_ssn_diffs(j4,l_ssn,r_ssn,j4_out);

//249846001
//5
did_set := [249846001];
/*
output(ta1_filt0(did in did_set));
output(ta1_filt(did in did_set));
output(ta20(did in did_set));
output(ta2(did in did_set));
output(ta30(did in did_set));
output(ta3(did in did_set));
output(ta40(did in did_set));
output(ta4(did in did_set));

output(j1(did in did_set));
output(j2(did in did_set));
*/
output(j3(did in did_set));
output(j4(l_did in did_set));
output(j4_out(l_did in did_set));

//output(ta1_filt);
//output(ta1_filt(did=249846001));

//r2 t2(ta1_filt le, ta1_filt ri) := transform 
// self.intersect := if(((le.init_mname =ri.init_mname and le.ssn<>ri.ssn) or (le.init_mname<>ri.init_mname and le.ssn =ri.ssn))=false,false,true);
// self := le;
//end;

//p2 := rollup(ta1_filt(did=249846001),left.did=right.did/* and left.init_mname>right.init_mname and left.ssn<>right.ssn*/,t2(left,right));
//output(p2);





























/*
did_set := [
1316,
368316,
249846001
];
*/
//did 10904 is a good bad example
//did 36829
//did 43916

did_set := [9864,10904,36829,43916];

hdr  := distribute(header.file_headers,hash(did));
wdog := distribute(watchdog.file_best,hash(did));

r1 := record
 hdr.did;
 hdr.fname;
 fname_count_ := count(group);
end;

r2 := record
 hdr.did;
 hdr.lname;
 lname_count_ := count(group);
end;

r3 := record
 hdr.did;
 hdr.ssn;
 string1 mname := hdr.mname[1];
 mname_count_  := count(group);
end;

ta1 := table(hdr/*(did in did_set)*/,r1,did,fname) : persist('persist::jtrost_did_fname');
ta2 := table(hdr/*(did in did_set)*/,r2,did,lname) : persist('persist::jtrost_did_lname');
ta3 := dedup(sort(table(hdr(/*did in did_set and*/ mname<>'' and ssn<>''),r3,did,ssn,mname[1])(mname_count_>2),did,mname,ssn/*,-mname_count_*/),did,mname,ssn)  : persist('persist::jtrost_did_mname');

output(ta1(did in did_set));
output(ta2(did in did_set));
output(ta3(did in did_set));

r00 := record
 unsigned6 did;
 string1   left_mname;
 string1   right_mname;
 string9   left_ssn;
 string9   right_ssn;
 integer   left_mname_count_;
 integer   right_mname_count_;
 boolean   ssn_overlaps;
end;

r00 t00(ta3 le, ta3 ri) := transform
 self.did                := le.did;
 self.left_mname         := le.mname;
 self.right_mname        := ri.mname;
 self.left_ssn           := le.ssn;
 self.right_ssn          := ri.ssn;
 self.left_mname_count_  := le.mname_count_;
 self.right_mname_count_ := ri.mname_count_;
 
 self.ssn_overlaps := if(self.left_ssn=self.right_ssn,true,false);
end;

j000 := join(ta3,ta3,left.did=right.did and /*left.ssn<>right.ssn and*/ left.mname>right.mname,t00(left,right),local) : persist('persist::jtrost_hdr_mname_test');
//j000 := join(ta3,ta3,left.did=right.did,t00(left,right),local) : persist('persist::jtrost_hdr_mname_test2');
//j00 := iterate(ta3,t00(left,right));
j00 := j000(did in did_set);
output(j00,named('j00'));

ut.mac_ssn_diffs(j00,left_ssn,right_ssn,j00_out);

f_ssn_switch0 := j00_out(ssn_switch='N');
good_ssns    := j00_out(ssn_switch='');

recordof(f_ssn_switch0) t_ssn_switch0(f_ssn_switch0 le, good_ssns ri) := transform
 self := le;
end;

f_ssn_switch := join(f_ssn_switch0,good_ssns,left.did=right.did and left.left_mname=right.left_mname and left.right_mname=right.right_mname,t_ssn_switch0(left,right),left only);

count(f_ssn_switch);
count(dedup(f_ssn_switch,did,all));
output(f_ssn_switch,named('f_ssn_switch'));

output(sort(j00_out,did),named('j00_out'));

 
r4 := record
 unsigned6 did;
 ta1.fname;
 ta1.fname_count_;
 ta2.lname;
 ta2.lname_count_;
end;

r4 t1(ta1 le, ta2 ri) := transform
 self.did := le.did;
 self := le;
 self := ri;
end;

j1 := join(ta1/*(did in did_set)*/,ta2/*(did in did_set)*/,left.did=right.did,t1(left,right),local);
output(j1,named('j1'));

r5 := record
 j1;
 ta3.mname;
 ta3.ssn;
 ta3.mname_count_;
 boolean bool_mname1;
 integer dift_mname_ct:=1;
 //boolean mname_ever_same_as_f_l_init:=false;
end;

r5 t2(j1 le, ta3 ri) := transform
 self.bool_mname1 := if(ri.mname=le.fname[1] or ri.mname=le.lname[1],true,false);
 self := le;
 self := ri;
end;

j2 := join(j1,ta3/*(did in did_set)*/,left.did=right.did,t2(left,right),local);
output(j2,named('j2'));

j2_srt := sort(j2,did,mname,local);

r5 t3(j2_srt le, j2_srt ri) := transform
 self.bool_mname1 := if(le.bool_mname1=true,le.bool_mname1,ri.bool_mname1);
 self := le;
end;

p1 := rollup(j2_srt,left.did=right.did and left.mname=right.mname,t3(left,right)/*,local*/);
output(p1,named('p1'));

p1_f := p1(bool_mname1=false);

r5 t4(p1_f le, p1_f ri) := transform
 self.dift_mname_ct := le.dift_mname_ct+1;
 self := le;
end;

p2 := rollup(p1_f,left.did=right.did,t4(left,right),local);
output(p2,named('p2'));
output(p2(did in did_set),named('p2_samp'));

p2_f := p2(dift_mname_ct>=3);
count(p2_f);
output(p2_f,named('p2_f'));
output(p2_f(did in did_set),named('p2_f_2'));
output(p2_f(did=9864),named('p2_f_3'));

//f_j2 := j2(mname<>fname[1] and mname<>lname[1]);
//output(f_j2);

/*
r4 := record
 ta1;
 boolean fname_matches_best;
end;

r5 := record
 ta2;
 boolean lname_matches_best;
end;

r4 t1(ta1 le, wdog ri) := transform
 self.fname_matches_best := le.fname=ri.fname;
 self := le;
end;

r5 t2(ta2 le, wdog ri) := transform
 self.lname_matches_best := le.lname=ri.lname;
 self := le;
end;

j1 := join(ta1,wdog,left.did=right.did,t1(left,right),local);
j2 := join(ta2,wdog,left.did=right.did,t2(left,right),local);

j1_filt := j1(fname_matches_best=true);
j2_filt := j2(lname_matches_best=true);

r6 := record
 j1_filt.did;
 j1_filt.fname;
 j2_filt.lname;
end;

r6 t3(j1_filt le, j2_filt ri) := transform
 self := le;
 self := ri;
end;

j3 := join(j1_filt,j2_filt,left.did=right.did,t3(left,right),local);

output(j3);

r7 := record
 j3;
 ta3.mname;
 //ta3.ssn;
 ta3.count_;
 integer did_mname_ct:=1;
end;

r7 t4(j3 le, ta3 ri) := transform
 self := le;
 self := ri;
end;

j4 := join(j3,ta3,left.did=right.did,t4(left,right),left outer,local);
output(j4);

f_j4 := j4(mname<>fname

r7 t5(j4 le, j4 ri) := transform
 self.did_mname_ct := le.did_mname_ct+1;
 self := le;
end;

p1 := rollup(j4,left.did=right.did,t5(left,right),local);
output(p1);

f1 := p1(did_mname_ct>=3);
count(f1);
output(f1);
*/
//export dodgy_ssn_mname := 'todo';