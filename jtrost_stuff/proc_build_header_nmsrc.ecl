import header,mdr,ut;

hdr := header.file_headers(trim(jflag2)='' and fname<>'' and lname<>'' and (((prim_range<>'' or prim_name<>'') and zip<>'') or (mdr.sourceTools.sourceisdeath(src) and ssn<>'')));

r1 := record
 string2   src;
 unsigned6 did;
 string20  fname;
 string20  lname;
 string10  prim_range;
 string28  prim_name;
 string5   zip;
 string1   mname;
 string8   sec_range;
 string5   name_suffix;
 string4   ssn;
 integer   dob;
end;

r1 t1(hdr le) := transform
 self.mname       := le.mname[1];
 self.ssn         := le.ssn[6..9];
 self.dob         := (integer)(string)le.dob[1..4];
 self.name_suffix := if(le.name_suffix[1..2]='UN','',le.name_suffix);
 self             := le;
end;

p0      := project   (hdr,t1(left));
p0_dist := distribute(p0,hash(did,fname,lname,prim_range,prim_name,zip,mname,sec_range,name_suffix,ssn,dob,src));
p0_sort := sort      (p0_dist,did,fname,lname,prim_range,prim_name,zip,mname,sec_range,name_suffix,ssn,dob,src,local);
p1      := dedup     (p0_sort,did,fname,lname,prim_range,prim_name,zip,mname,sec_range,name_suffix,ssn,dob,src,local);

p1_dist := distribute(p1,hash(fname,lname,prim_range,prim_name,zip,src));

r2 := record
 string2   src;
 unsigned6 did;
 string20  fname;
 string20  lname;
 string10  prim_range;
 string28  prim_name;
 string5   zip;
 integer   dids_with_this_nm_addr:=1;
end;

r2 t2(p1 le) := transform
 self := le;
end;

p2       := project   (p1,t2(left));
p2_dist  := distribute(p2,hash(fname,lname,prim_range,prim_name,zip,src));
p2_sort  := sort      (p2_dist,fname,lname,prim_range,prim_name,zip,did,src,local);
p2_dupd  := dedup     (p2_sort,fname,lname,prim_range,prim_name,zip,did,src,local);

//p2_dist2 := distribute(p2_dupd,hash(fname,lname,prim_range,prim_name,zip,src));
//sort should be preserved
p2_sort2 := sort      (p2_dupd,    fname,lname,prim_range,prim_name,zip,src,local);

r2 t3(r2 le, r2 ri) := transform
 self.dids_with_this_nm_addr := le.dids_with_this_nm_addr+1;
 self                        := le;
end;

//if there's only 1 DID w/ this name+addr combination we shouldn't have to look further
p3 := rollup(p2_sort2,left.fname=right.fname and left.lname=right.lname and left.prim_range=right.prim_range and left.prim_name=right.prim_name and left.zip=right.zip and left.src=right.src,t3(left,right),local);

r3 := record
 string2   src;
 string20  fname;
 string20  lname;
 string10  prim_range;
 string28  prim_name;
 string5   zip;
 string5   name_suffix;
 integer   suffix_cnt_with_this_nm_addr:=1;
end;

r3 t4(p1 le) := transform
 self := le;
end;

p4       := project   (p1(name_suffix<>''),t4(left));
p4_dist  := distribute(p4,hash(fname,lname,prim_range,prim_name,zip,name_suffix,src));
p4_sort  := sort      (p4_dist,fname,lname,prim_range,prim_name,zip,name_suffix,src,local);
p4_dupd  := dedup     (p4_sort,fname,lname,prim_range,prim_name,zip,name_suffix,src,local);

p4_dist2 := distribute(p4_dupd,hash(fname,lname,prim_range,prim_name,zip,src));
p4_sort2 := sort      (p4_dist2,    fname,lname,prim_range,prim_name,zip,src,local);

r3 t5(r3 le, r3 ri) := transform
 self.suffix_cnt_with_this_nm_addr := le.suffix_cnt_with_this_nm_addr+1;
 self                              := le;
end;

p5 := rollup(p4_sort2,left.fname=right.fname and left.lname=right.lname and left.prim_range=right.prim_range and left.prim_name=right.prim_name and left.zip=right.zip and left.src=right.src,t5(left,right),local);

r4 := record
 string2   src;
 string20  fname;
 string20  lname;
 string10  prim_range;
 string28  prim_name;
 string5   zip;
 string8   sec_range;
 integer   sec_range_cnt_with_this_nm_addr:=1;
end;

r4 t6(p1 le) := transform
 self := le;
end;

p6       := project(p1(sec_range<>''),t6(left));
p6_dist  := distribute(p6,hash(fname,lname,prim_range,prim_name,zip,sec_range,src));
p6_sort  := sort(p6_dist,fname,lname,prim_range,prim_name,zip,sec_range,src,local);
p6_dupd  := dedup(p6_sort,fname,lname,prim_range,prim_name,zip,sec_range,src,local);

p6_dist2 := distribute(p6_dupd,hash(fname,lname,prim_range,prim_name,zip,src));
p6_sort2 := sort(p6_dist2,fname,lname,prim_range,prim_name,zip,src,local);

r4 t7(r4 le, r4 ri) := transform
 self.sec_range_cnt_with_this_nm_addr := le.sec_range_cnt_with_this_nm_addr+1;
 self                                 := le;
end;

p7 := rollup(p6_sort2,left.fname=right.fname and left.lname=right.lname and left.prim_range=right.prim_range and left.prim_name=right.prim_name and left.zip=right.zip and left.src=right.src,t7(left,right),local);

r5 := record
 string2   src;
 string20  fname;
 string20  lname;
 string10  prim_range;
 string28  prim_name;
 string5   zip;
 string4   ssn;
 integer   ssn_cnt_with_this_nm_addr:=1;
end;

r5 t8(p1 le) := transform
 self := le;
end;

p8       := project   (p1(ssn<>''),t8(left));
p8_dist  := distribute(p8,hash(fname,lname,prim_range,prim_name,zip,ssn,src));
p8_sort  := sort      (p8_dist,fname,lname,prim_range,prim_name,zip,ssn,src,local);
p8_dupd  := dedup     (p8_sort,fname,lname,prim_range,prim_name,zip,ssn,src,local);

p8_dist2 := distribute(p8_dupd,hash(fname,lname,prim_range,prim_name,zip,src));
p8_sort2 := sort      (p8_dist2,    fname,lname,prim_range,prim_name,zip,src,local);

r5 t9(r5 le, r5 ri) := transform
 self.ssn_cnt_with_this_nm_addr := le.ssn_cnt_with_this_nm_addr+1;
 self                           := le;
end;

p9 := rollup(p8_sort2,left.fname=right.fname and left.lname=right.lname and left.prim_range=right.prim_range and left.prim_name=right.prim_name and left.zip=right.zip and left.src=right.src,t9(left,right),local);

r6 := record
 string2   src;
 string20  fname;
 string20  lname;
 string10  prim_range;
 string28  prim_name;
 string5   zip;
 integer   dob;
 integer   dob_cnt_with_this_nm_addr:=1;
end;

r6 t10(p1 le) := transform
 self := le;
end;

p10       := project   (p1(dob>0),t10(left));
p10_dist  := distribute(p10,hash(fname,lname,prim_range,prim_name,zip,dob,src));
p10_sort  := sort      (p10_dist,fname,lname,prim_range,prim_name,zip,dob,src,local);
p10_dupd  := dedup     (p10_sort,fname,lname,prim_range,prim_name,zip,dob,src,local);

p10_dist2 := distribute(p10_dupd,hash(fname,lname,prim_range,prim_name,zip,src));
p10_sort2 := sort      (p10_dist2,    fname,lname,prim_range,prim_name,zip,src,local);

r6 t11(r6 le, r6 ri) := transform
 self.dob_cnt_with_this_nm_addr := le.dob_cnt_with_this_nm_addr+1;
 self                           := le;
end;

p11 := rollup(p10_sort2,left.fname=right.fname and left.lname=right.lname and left.prim_range=right.prim_range and left.prim_name=right.prim_name and left.zip=right.zip and left.src=right.src,t11(left,right),local);

r7 := record
 string2   src;
 string20  fname;
 string20  lname;
 string10  prim_range;
 string28  prim_name;
 string5   zip;
 string20  mname;
 integer   mname_cnt_with_this_nm_addr:=1;
end;

r7 t12(p1 le) := transform
 self := le;
end;

p12       := project   (p1(mname<>''),t12(left));
p12_dist  := distribute(p12,hash(fname,lname,prim_range,prim_name,zip,mname,src));
p12_sort  := sort      (p12_dist,fname,lname,prim_range,prim_name,zip,mname,src,local);
p12_dupd  := dedup     (p12_sort,fname,lname,prim_range,prim_name,zip,mname,src,local);

p12_dist2 := distribute(p12_dupd,hash(fname,lname,prim_range,prim_name,zip,src));
p12_sort2 := sort      (p12_dist2,    fname,lname,prim_range,prim_name,zip,src,local);

r7 t13(r7 le, r7 ri) := transform
 self.mname_cnt_with_this_nm_addr := le.mname_cnt_with_this_nm_addr+1;
 self                             := le;
end;

p13 := rollup(p12_sort2,left.fname=right.fname and left.lname=right.lname and left.prim_range=right.prim_range and left.prim_name=right.prim_name and left.zip=right.zip and left.src=right.src,t13(left,right),local);

r8 := record
 p1_dist;
 p3.dids_with_this_nm_addr;
end;

r8 t14(p1_dist le, p3 ri) := transform
 self := le;
 self := ri;
end;

j1 := join(p1_dist,p3,left.fname=right.fname and left.lname=right.lname and left.prim_range=right.prim_range and left.prim_name=right.prim_name and left.zip=right.zip and left.src=right.src,t14(left,right),local);

r9 := record
 j1;
 p5.suffix_cnt_with_this_nm_addr;
end;

r9 t15(j1 le, p5 ri) := transform
 self := le;
 self := ri;
end;

j2 := join(j1,p5,left.fname=right.fname and left.lname=right.lname and left.prim_range=right.prim_range and left.prim_name=right.prim_name and left.zip=right.zip and left.src=right.src,t15(left,right),left outer,local);

r10 := record
 j2;
 p7.sec_range_cnt_with_this_nm_addr;
end;

r10 t16(j2 le, p7 ri) := transform
 self := le;
 self := ri;
end;

j3 := join(j2,p7,left.fname=right.fname and left.lname=right.lname and left.prim_range=right.prim_range and left.prim_name=right.prim_name and left.zip=right.zip and left.src=right.src,t16(left,right),left outer,local);

r11 := record
 j3;
 p9.ssn_cnt_with_this_nm_addr;
end;

r11 t17(j3 le, p9 ri) := transform
 self := le;
 self := ri;
end;

j4 := join(j3,p9,left.fname=right.fname and left.lname=right.lname and left.prim_range=right.prim_range and left.prim_name=right.prim_name and left.zip=right.zip and left.src=right.src,t17(left,right),left outer,local);

r12 := record
 j4;
 p11.dob_cnt_with_this_nm_addr;
end;

r12 t18(j4 le, p11 ri) := transform
 self := le;
 self := ri;
end;

j5 := join(j4,p11,left.fname=right.fname and left.lname=right.lname and left.prim_range=right.prim_range and left.prim_name=right.prim_name and left.zip=right.zip and left.src=right.src,t18(left,right),left outer,local);

r13 := record
 j5;
 p13.mname_cnt_with_this_nm_addr;
end;

r13 t19(j5 le, p13 ri) := transform
 self := le;
 self := ri;
end;

j6 := join(j5,p13,left.fname=right.fname and left.lname=right.lname and left.prim_range=right.prim_range and left.prim_name=right.prim_name and left.zip=right.zip and left.src=right.src,t19(left,right),left outer,local);

ut.mac_sf_buildprocess(j6,'~thor_data400::base::header_nmsrc',build_nmsrc,2,,true);

export proc_build_header_nmsrc := build_nmsrc;