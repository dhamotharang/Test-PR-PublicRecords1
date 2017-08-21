hdr          := distribute(header.file_headers,hash(did));
//ut.mac_flipnames(hdr0,fname,mname,lname,hdr);
hdr_data_fam := jtrost_stuff.fn_append_data_families();
hdr_seg      := header.fn_adlsegmentation(hdr).core_check_pst;
hdr_rec_cnts := dedup(sort(distribute(header.counts_per_did(hdr),hash(did)),did,local),did,local);

r_ssn_s9 := record
 string9 ssn2;
 hdr;
end;

r_ssn_s9 x_ssn_s9(hdr le) := transform
 self.ssn2 := le.ssn;
 self      := le;
end;

hdr_ssn_s9 := project(hdr,x_ssn_s9(left));

hdr_has_ssn   := dedup(sort(distribute(hdr_ssn_s9(ssn2<>''),hash(ssn2)),ssn2,local),ssn2,local);

r_ssn := record
 string9 ssn := hdr_has_ssn.ssn2;
end;

ta_ssn := table(hdr_has_ssn,r_ssn);

//hdr_no_ssn    := hdr(ssn ='');

hdr_ssn_flags := header.fn_append_ssn_flags(ta_ssn);
ins_name_tbl  := idl_header.name_count_ds(fname_cnt>50 and length(trim(name))>1);//filter initials

r1a := record
 hdr_ssn_s9;
 string10 ind:='';
 integer  did_ct:=0;
 boolean  in_bureau;
 boolean  in_utility;
 boolean  in_assets;
 boolean  in_deaths;
 boolean  in_derogatory;
 boolean  in_dl;
 boolean  in_other_licensing;
 boolean  in_other;
 boolean  not_captured;
 boolean  ssn_is_invalid   :=false;
 string10 ssn_flags        :='';
 string1  did_only_has_invalid_ssns:='';
 string1  did_has_valid_ssn_g   :='';
 decimal6_3 ins_pct_fname:=0;
end;

r1a x1(hdr_ssn_s9 le, hdr_data_fam ri) := transform
 self.did_has_valid_ssn_g := if(le.valid_ssn='G','Y',if(le.valid_ssn<>'' and le.valid_ssn<>'G','N',''));
 self := le;
 self := ri;
end;

j1 := join(hdr_ssn_s9,hdr_data_fam,left.did=right.did,x1(left,right),local);

r1a x2(r1a le, hdr_seg ri) := transform
 self.ind := ri.ind;
 self     := le;
end;

j2 := join(j1,hdr_seg,left.did=right.did,x2(left,right),local);

//r1a x3(r1a le, hdr_rec_cnts ri) := transform
r1a x3(r1a le) := transform
 //self.did_ct := ri.did_ct;
 self.did_ct := 1;
 self        := le;
end;

//j3      := join(j2,hdr_rec_cnts,left.did=right.did,x3(left,right),keep(1),local);
j3      := project(j2,x3(left));
j3_dist := distribute(j3,hash(rid));
output(j3_dist(did=60279),named('j3_dist'));

r1a x6(r1a le, hdr_ssn_flags ri) := transform
 self.ssn_flags         := ri.ssn_flags;
 self.ssn_is_invalid    := ri.ssn_is_invalid;
 self.did_only_has_invalid_ssns := if(le.ssn<>'' and self.ssn_is_invalid=false,'N',
                                   if(le.ssn<>'' and self.ssn_is_invalid=true,'Y',
								   ''));
 self                           := le;
end;

j4 := join(distribute(j3_dist(ssn2<>''),hash(ssn2)),distribute(hdr_ssn_flags,hash(ssn)),left.ssn2=right.ssn,x6(left,right),left outer,local) + j3_dist(ssn='') : persist('persist::jtrost_hdr_appends');
//j4 := dataset('~thor400_92::persist::jtrost_hdr_appends',r1a,flat);
output(j4(did=60279),named('j4'));

r1 := record
 j4;
 integer did_ssn_ct;
end;

r1 x8(r1a le, ins_name_tbl ri) := transform
 self.did_ssn_ct    := if(le.ssn<>'',1,0);
 self.ins_pct_fname := ri.pct_fname;
 self               := le;
end;

j5 := join(j4,ins_name_tbl,left.fname=right.name,x8(left,right),left outer,lookup);
output(j5(did=60279),named('j5'));

f1 := j5(did_only_has_invalid_ssns<>'');
output(f1(did=60279),named('f1'));
f1_dist := distribute(f1,hash(did));
f1_sort := sort(f1_dist,did,did_only_has_invalid_ssns,local);
f1_dupd := dedup(f1_sort,did,did_only_has_invalid_ssns,local);

r1 x9(r1 le, r1 ri) := transform
 self.did_only_has_invalid_ssns := if(le.did_only_has_invalid_ssns='N',le.did_only_has_invalid_ssns,ri.did_only_has_invalid_ssns);
 self := le;
end;

p1 := rollup(f1_dupd,left.did=right.did,x9(left,right),local);
output(p1(did=60279),named('p1'));
f2 := p1(did_only_has_invalid_ssns='Y');
//output(count(f2),named('count_of_dids_with_only_invalid_ssns'));
//output(f2,named('sample_of_dids_with_only_invalid_ssns'));

r1 x10(r1 le, r1 ri) := transform
 self.did_only_has_invalid_ssns := ri.did_only_has_invalid_ssns;
 self                           := le;
end;

j6 := join(distribute(j5,hash(did)),distribute(p1,hash(did)),left.did=right.did,x10(left,right),local);
output(j6(did=60279),named('j6'));
f3_yes := sort(j6(did_only_has_invalid_ssns='Y' and ind='CORE'),did);
f3_no  := sort(j6(did_only_has_invalid_ssns='N' and ind='CORE'),did);
output(count(dedup(f3_yes,did,all)),named('count_of_dids_with_only_invalid_ssns2'));
output(choosen(f3_yes,1000),named('sample_of_dids_with_only_invalid_ssns2'));

//output(count(f3_no),named('count_of_dids_with_only_invalid_ssns3'));
//output(choosen(f3_no,1000),named('sample_of_dids_with_only_invalid_ssns3'));

//output(count(j6),named('j6_count'));

f4 := j6(did_has_valid_ssn_g<>'');
f4_dist := distribute(f4,hash(did));
f4_sort := sort(f4_dist,did,did_has_valid_ssn_g,local);
f4_dupd := dedup(f4_sort,did,did_has_valid_ssn_g,local);

r1 x11(r1 le, r1 ri) := transform
 self.did_has_valid_ssn_g := if(le.did_has_valid_ssn_g='Y',le.did_has_valid_ssn_g,ri.did_has_valid_ssn_g);
 self                     := le;
end;

p2 := rollup(f4_dupd,left.did=right.did,x11(left,right),local);


r1 x12(r1 le, r1 ri) := transform
 self.did_has_valid_ssn_g := ri.did_has_valid_ssn_g;
 self                     := le;
end;

j7 := join(j6,p2,left.did=right.did,x12(left,right),local);
f5 := sort(j7(did_has_valid_ssn_g='N' and ind='CORE'),did);
output(count(dedup(f5,did,all)),named('count_of_core_dids_with_no_valid_ssn_g'));
output(choosen(f5,1000),named('sample_of_core_dids_with_no_valid_ssn_g'));
















/*
f1 := j4(
      (ssn<>'' and invalid_ssn_flags[1]='N' and stringlib.stringfind(invalid_ssn_flags,'I',1)=0 and stringlib.stringfind(invalid_ssn_flags,'P',1)=0)
	  or
	  (invalid_ssn_flags[1]='Y' and stringlib.stringfind(invalid_ssn_flags,'5',1)>0)
	  );
*/

//f4 := j6(ut.full_ssn(ssn));

//f4_dist := distribute(f4,hash(did));
//f4_sort := sort(f4_dist,did,local);

ta1_dist := distribute(f4,hash(ssn));
ta1_sort := sort(ta1_dist,ssn,did,local);
ta1_dupd := dedup(ta1_sort,ssn,did,local);

r1 x4(r1 le, r1 ri) := transform
 self.did_ssn_ct := le.did_ssn_ct+1;
 self            := le;
end;

//p2 := rollup(ta1_dupd,left.ssn=right.ssn,x4(left,right),local) : persist('persist::jtrost_did_ssn_ct');

//f5 := p2(did_ssn_ct=2);
//count(f5);
//output(sort(f5,-did_ssn_ct));

//f1_dist := distribute(f1,hash(ssn));

r1 x5(r1 le, r1 ri) := transform
 self.did_ssn_ct := ri.did_ssn_ct;
 self := le;
end;

//j7 := join(distribute(f4,hash(ssn)),p2,left.ssn=right.ssn,x5(left,right),local);

//concat := j7+

r2 := record
 string9   ssn;
 unsigned6 did1;
 unsigned6 did2;
 string1   valid_ssn1;
 string1   valid_ssn2;
 
 string10 ind1;
 integer  did_ct1;
 boolean  in_bureau1;
 boolean  in_utility1;
 boolean  in_assets1;
 boolean  in_dl1;
 boolean  in_deaths1;
 boolean  in_derogatory1;
 boolean  in_other_licensing1;
 boolean  in_other1;
 
 string10 ind2;
 integer  did_ct2;
 boolean  in_bureau2;
 boolean  in_utility2;
 boolean  in_assets2;
 boolean  in_dl2;
 boolean  in_deaths2;
 boolean  in_derogatory2;
 boolean  in_other_licensing2;
 boolean  in_other2;
end;

r2 x7(r1 le, r1 ri) := transform
 self.ssn := le.ssn;
 
 self.did1 := le.did;
 self.did2 := ri.did;
 
 self.valid_ssn1 := le.valid_ssn;
 self.valid_ssn2 := ri.valid_ssn;
 
 self.ind1           := le.ind;
 self.did_ct1        := le.did_ct;
 self.in_bureau1     := le.in_bureau;
 self.in_utility1    := le.in_utility;
 self.in_assets1     := le.in_assets;
 self.in_dl1         := le.in_dl;
 self.in_deaths1     := le.in_deaths;
 self.in_derogatory1 := le.in_derogatory;
 self.in_other_licensing1  := le.in_other_licensing;
 self.in_other1      := le.in_other;

 self.ind2           := ri.ind;
 self.did_ct2        := ri.did_ct;
 self.in_bureau2     := ri.in_bureau;
 self.in_utility2    := ri.in_utility;
 self.in_assets2     := ri.in_assets;
 self.in_dl2         := ri.in_dl;
 self.in_deaths2     := ri.in_deaths;
 self.in_derogatory2 := ri.in_derogatory;
 self.in_other_licensing2  := ri.in_other_licensing;
 self.in_other2      := ri.in_other;
end;

j8      := join(j7,j7,left.ssn=right.ssn and left.did>right.did,x7(left,right),local);
j8_dupd := dedup(j8,record,all);
//output(j8_dupd);

r3 := record
 j8_dupd.ind1;
 j8_dupd.in_bureau1;
 j8_dupd.in_utility1;
 j8_dupd.in_assets1;
 j8_dupd.in_deaths1;
 j8_dupd.in_derogatory1;
 j8_dupd.in_other_licensing1;
 j8_dupd.in_other1;
 
 j8_dupd.ind2;
 j8_dupd.in_bureau2;
 j8_dupd.in_utility2;
 j8_dupd.in_assets2;
 j8_dupd.in_deaths2;
 j8_dupd.in_derogatory2;
 j8_dupd.in_other_licensing2;
 j8_dupd.in_other2;
 
 count_ := count(group);
end;

ta2 := table(j8_dupd,r3,ind1,in_bureau1,in_utility1,in_assets1,in_deaths1,in_derogatory1,in_dl1,in_other_licensing1,in_other1,
                        ind2,in_bureau2,in_utility2,in_assets2,in_deaths2,in_derogatory2,in_dl2,in_other_licensing2,in_other2,
						few);

//output(ta2);