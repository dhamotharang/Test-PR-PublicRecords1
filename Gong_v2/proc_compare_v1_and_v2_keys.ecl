import gong,DayBatchEda,eda_via_xml;

v1_did_key := pull(gong.key_did);
v2_did_key := pull(gong_v2.key_did);

v1_bdid_key := pull(gong.key_bdid);
v2_bdid_key := pull(gong_v2.key_bdid);

// v1_addr_key := pull(gong.Key_Address); // attribute has been deleted
v2_addr_key := pull(gong_v2.key_address);

v1_hhid_key := pull(gong.Key_HHID);
v2_hhid_key := pull(gong_v2.Key_HHID);

v1_phone_key := pull(DayBatchEda.Key_gong_phone);
v2_phone_key := pull(DayBatchEda.Key_gongv2_phone);

v1_cszsslf_key := pull(DayBatchEda.key_gong_batch_czsslf);
v2_cszsslf_key := pull(DayBatchEda.key_gongv2_batch_czsslf);

v1_lczf_key := pull(DayBatchEda.key_gong_batch_lczf);
v2_lczf_key := pull(DayBatchEda.key_gongv2_batch_lczf);

v1_npa_nxx_key := pull(EDA_VIA_XML.Key_npa_nxx_line);
v2_npa_nxx_key := pull(EDA_VIA_XML.Key_npa_nxx_linev2);

v1_st_lname_city_key := pull(EDA_VIA_XML.Key_st_lname_city);
v2_st_lname_city_key := pull(EDA_VIA_XML.Key_st_lname_cityv2);

v1_st_lname_fname_city_key := pull(EDA_VIA_XML.Key_st_lname_fname_city);
v2_st_lname_fname_city_key := pull(EDA_VIA_XML.Key_st_lname_fname_cityv2);

v1_st_bizword_city_key := pull(EDA_VIA_XML.Key_st_bizword_city);
v2_st_bizword_city_key := pull(EDA_VIA_XML.Key_st_bizword_cityv2);

v1_st_city_prim_name_prim_range_key := pull(EDA_VIA_XML.Key_st_city_prim_name_prim_range);
v2_st_city_prim_name_prim_range_key := pull(EDA_VIA_XML.Key_st_city_prim_name_prim_rangev2);

//DID compare
v1_did_key_dist := distribute(v1_did_key,hash(did));
v2_did_key_dist := distribute(v2_did_key,hash(did));

v1_did_key_sort := sort(v1_did_key_dist,did,local);
v2_did_key_sort := sort(v2_did_key_dist,did,local);

v1_did_key_dupd := dedup(v1_did_key_sort,did,local);
v2_did_key_dupd := dedup(v2_did_key_sort,did,local);

out1 := output(count(v1_did_key),named('v1_did_key_ct'));
out2 := output(count(v2_did_key),named('v2_did_key_ct'));
out3 := output(count(v1_did_key_dupd),named('v1_did_key_dupd_ct'));
out4 := output(count(v2_did_key_dupd),named('v2_did_key_dupd_ct'));

r1 := record
 unsigned6 did;
end;

r1 t1(v1_did_key_dupd le, v2_did_key_dupd ri) := transform
 self := le;
end;

r1 t2(v2_did_key_dupd le, v1_did_key_dupd ri) := transform
 self := le;
end;

j1 := join(v1_did_key_dupd,v2_did_key_dupd,left.did=right.did,t1(left,right),left only,local);
j2 := join(v2_did_key_dupd,v1_did_key_dupd,left.did=right.did,t2(left,right),left only,local);

out5 := output(count(j1),named('DIDs_only_in_v1_key'));
out6 := output(count(j2),named('DIDs_only_in_v2_key'));
out7 := output(j1,named('DIDs_only_in_v1_key_sample'));
out8 := output(j2,named('DIDs_only_in_v2_key_sample'));

//BDID compare
v1_bdid_key_dist := distribute(v1_bdid_key,hash(bdid));
v2_bdid_key_dist := distribute(v2_bdid_key,hash(bdid));

v1_bdid_key_sort := sort(v1_bdid_key_dist,bdid,local);
v2_bdid_key_sort := sort(v2_bdid_key_dist,bdid,local);

v1_bdid_key_dupd := dedup(v1_bdid_key_sort,bdid,local);
v2_bdid_key_dupd := dedup(v2_bdid_key_sort,bdid,local);

out9  := output(count(v1_bdid_key),named('v1_bdid_key_ct'));
out10 := output(count(v2_bdid_key),named('v2_bdid_key_ct'));
out11 := output(count(v1_bdid_key_dupd),named('v1_bdid_key_dupd_ct'));
out12 := output(count(v2_bdid_key_dupd),named('v2_bdid_key_dupd_ct'));

r2 := record
 unsigned6 bdid;
end;

r2 t3(v1_bdid_key_dupd le, v2_bdid_key_dupd ri) := transform
 self := le;
end;

r2 t4(v2_bdid_key_dupd le, v1_bdid_key_dupd ri) := transform
 self := le;
end;

j3 := join(v1_bdid_key_dupd,v2_bdid_key_dupd,left.bdid=right.bdid,t3(left,right),left only,local);
j4 := join(v2_bdid_key_dupd,v1_bdid_key_dupd,left.bdid=right.bdid,t4(left,right),left only,local);

out13 := output(count(j3),named('BDIDs_only_in_v1_key'));
out14 := output(count(j4),named('BDIDs_only_in_v2_key'));
out15 := output(j3,named('BDIDs_only_in_v1_key_sample'));
out16 := output(j4,named('BDIDs_only_in_v2_key_sample'));

//ADDR compare
v1_addr_key_dist := distribute(v1_addr_key,hash(prim_name,z5,prim_range,sec_range));
v2_addr_key_dist := distribute(v2_addr_key,hash(prim_name,z5,prim_range,sec_range));

v1_addr_key_sort := sort(v1_addr_key_dist,prim_name,z5,prim_range,sec_range,local);
v2_addr_key_sort := sort(v2_addr_key_dist,prim_name,z5,prim_range,sec_range,local);

v1_addr_key_dupd := dedup(v1_addr_key_sort,prim_name,z5,prim_range,sec_range,local);
v2_addr_key_dupd := dedup(v2_addr_key_sort,prim_name,z5,prim_range,sec_range,local);

out17 := output(count(v1_addr_key),named('v1_addr_key_ct'));
out18 := output(count(v2_addr_key),named('v2_addr_key_ct'));
out19 := output(count(v1_addr_key_dupd),named('v1_addr_key_dupd_ct'));
out20 := output(count(v2_addr_key_dupd),named('v2_addr_key_dupd_ct'));

r3 := record
 string28 prim_name;
 string5  z5;
 string10 prim_range;
 string8  sec_range;
end;

r3 t5(v1_addr_key_dupd le, v2_addr_key_dupd ri) := transform
 self := le;
end;

r3 t6(v2_addr_key_dupd le, v1_addr_key_dupd ri) := transform
 self := le;
end;

j5 := join(v1_addr_key_dupd,v2_addr_key_dupd,left.prim_name=right.prim_name and left.z5=right.z5 and left.prim_range=right.prim_range and left.sec_range=right.sec_range,t5(left,right),left only,local);
j6 := join(v2_addr_key_dupd,v1_addr_key_dupd,left.prim_name=right.prim_name and left.z5=right.z5 and left.prim_range=right.prim_range and left.sec_range=right.sec_range,t6(left,right),left only,local);

out21 := output(count(j5),named('addrs_only_in_v1_key'));
out22 := output(count(j6),named('addrs_only_in_v2_key'));
out23 := output(j5,named('addr_only_in_v1_key_sample'));
out24 := output(j6,named('addr_only_in_v2_key_sample'));

//HHID compare
v1_hhid_key_dist := distribute(v1_hhid_key,hash(hhid));
v2_hhid_key_dist := distribute(v2_hhid_key,hash(hhid));

v1_hhid_key_sort := sort(v1_hhid_key_dist,hhid,local);
v2_hhid_key_sort := sort(v2_hhid_key_dist,hhid,local);

v1_hhid_key_dupd := dedup(v1_hhid_key_sort,hhid,local);
v2_hhid_key_dupd := dedup(v2_hhid_key_sort,hhid,local);

out25 := output(count(v1_hhid_key),named('v1_hhid_key_ct'));
out26 := output(count(v2_hhid_key),named('v2_hhid_key_ct'));
out27 := output(count(v1_hhid_key_dupd),named('v1_hhid_key_dupd_ct'));
out28 := output(count(v2_hhid_key_dupd),named('v2_hhid_key_dupd_ct'));

r4 := record
 unsigned6 hhid;
end;

r4 t7(v1_hhid_key_dupd le, v2_hhid_key_dupd ri) := transform
 self := le;
end;

r4 t8(v2_hhid_key_dupd le, v1_hhid_key_dupd ri) := transform
 self := le;
end;

j7 := join(v1_hhid_key_dupd,v2_hhid_key_dupd,left.hhid=right.hhid,t7(left,right),left only,local);
j8 := join(v2_hhid_key_dupd,v1_hhid_key_dupd,left.hhid=right.hhid,t8(left,right),left only,local);

out29 := output(count(j7),named('HHIDs_only_in_v1_key'));
out30 := output(count(j8),named('HHIDs_only_in_v2_key'));
out31 := output(j7,named('HHIDs_only_in_v1_key_sample'));
out32 := output(j8,named('HHIDs_only_in_v2_key_sample'));

//Phone compare
v1_phone_key_dist := distribute(v1_phone_key,hash(phone7,area_code));
v2_phone_key_dist := distribute(v2_phone_key,hash(phone7,area_code));

v1_phone_key_sort := sort(v1_phone_key_dist,phone7,area_code,local);
v2_phone_key_sort := sort(v2_phone_key_dist,phone7,area_code,local);

v1_phone_key_dupd := dedup(v1_phone_key_sort,phone7,area_code,local);
v2_phone_key_dupd := dedup(v2_phone_key_sort,phone7,area_code,local);

out33 := output(count(v1_phone_key),named('v1_phone_key_ct'));
out34 := output(count(v2_phone_key),named('v2_phone_key_ct'));
out35 := output(count(v1_phone_key_dupd),named('v1_phone_key_dupd_ct'));
out36 := output(count(v2_phone_key_dupd),named('v2_phone_key_dupd_ct'));

r5 := record
 string7 phone7;
 string3 area_code;
end;

r5 t9(v1_phone_key_dupd le, v2_phone_key_dupd ri) := transform
 self := le;
end;

r1 t10(v2_phone_key_dupd le, v1_phone_key_dupd ri) := transform
 self := le;
end;

j9  := join(v1_phone_key_dupd,v2_phone_key_dupd,left.phone7=right.phone7 and left.area_code=right.area_code, t9(left,right),left only,local);
j10 := join(v2_phone_key_dupd,v1_phone_key_dupd,left.phone7=right.phone7 and left.area_code=right.area_code,t10(left,right),left only,local);

out37 := output(count(j9),named('Phones_only_in_v1_key'));
out38 := output(count(j10),named('Phones_only_in_v2_key'));
out39 := output(j9,named('Phones_only_in_v1_key_sample'));
out40 := output(j10,named('Phones_only_in_v2_key_sample'));

//cszsslf compare
v1_cszsslf_key_dist := distribute(v1_cszsslf_key,hash(p_city_name,z5,prim_name,prim_range,name_last,name_first));
v2_cszsslf_key_dist := distribute(v2_cszsslf_key,hash(p_city_name,z5,prim_name,prim_range,name_last,name_first));

v1_cszsslf_key_sort := sort(v1_cszsslf_key_dist,p_city_name,z5,prim_name,prim_range,name_last,name_first,local);
v2_cszsslf_key_sort := sort(v2_cszsslf_key_dist,p_city_name,z5,prim_name,prim_range,name_last,name_first,local);

v1_cszsslf_key_dupd := dedup(v1_cszsslf_key_sort,p_city_name,z5,prim_name,prim_range,name_last,name_first,local);
v2_cszsslf_key_dupd := dedup(v2_cszsslf_key_sort,p_city_name,z5,prim_name,prim_range,name_last,name_first,local);

out41 := output(count(v1_cszsslf_key),named('v1_cszsslf_key_ct'));
out42 := output(count(v2_cszsslf_key),named('v2_cszsslf_key_ct'));
out43 := output(count(v1_cszsslf_key_dupd),named('v1_cszsslf_key_dupd_ct'));
out44 := output(count(v2_cszsslf_key_dupd),named('v2_cszsslf_key_dupd_ct'));

r6 := record
 string25 p_city_name;
 string5  z5;
 string28 prim_name;
 string10 prim_range;
 string20 name_last;
 string20 name_first;
end;

r6 t11(v1_cszsslf_key_dupd le, v2_cszsslf_key_dupd ri) := transform
 self := le;
end;

r6 t12(v2_cszsslf_key_dupd le, v1_cszsslf_key_dupd ri) := transform
 self := le;
end;

j11 := join(v1_cszsslf_key_dupd,v2_cszsslf_key_dupd,left.p_city_name=right.p_city_name and left.z5=right.z5 and left.prim_name=right.prim_name and left.prim_range=right.prim_range and left.name_last=right.name_last and left.name_first=right.name_first,t11(left,right),left only,local);
j12 := join(v2_cszsslf_key_dupd,v1_cszsslf_key_dupd,left.p_city_name=right.p_city_name and left.z5=right.z5 and left.prim_name=right.prim_name and left.prim_range=right.prim_range and left.name_last=right.name_last and left.name_first=right.name_first,t12(left,right),left only,local);

out45 := output(count(j11),named('cszsslfs_only_in_v1_key'));
out46 := output(count(j12),named('cszsslfs_only_in_v2_key'));
out47 := output(j11,named('cszsslfs_only_in_v1_key_sample'));
out48 := output(j12,named('cszsslfs_only_in_v2_key_sample'));

//lczf compare					
v1_lczf_key_dist := distribute(v1_lczf_key,hash(name_last,p_city_name,z5,name_first));
v2_lczf_key_dist := distribute(v2_lczf_key,hash(name_last,p_city_name,z5,name_first));

v1_lczf_key_sort := sort(v1_lczf_key_dist,name_last,p_city_name,z5,name_first,local);
v2_lczf_key_sort := sort(v2_lczf_key_dist,name_last,p_city_name,z5,name_first,local);

v1_lczf_key_dupd := dedup(v1_lczf_key_sort,name_last,p_city_name,z5,name_first,local);
v2_lczf_key_dupd := dedup(v2_lczf_key_sort,name_last,p_city_name,z5,name_first,local);

out49 := output(count(v1_lczf_key),named('v1_lczf_key_ct'));
out50 := output(count(v2_lczf_key),named('v2_lczf_key_ct'));
out51 := output(count(v1_lczf_key_dupd),named('v1_lczf_key_dupd_ct'));
out52 := output(count(v2_lczf_key_dupd),named('v2_lczf_key_dupd_ct'));

r7 := record
 string20 name_last;
 string25 p_city_name;
 string5  z5;
 string20 name_first;
end;

r7 t13(v1_lczf_key_dupd le, v2_lczf_key_dupd ri) := transform
 self := le;
end;

r7 t14(v2_lczf_key_dupd le, v1_lczf_key_dupd ri) := transform
 self := le;
end;

j13 := join(v1_lczf_key_dupd,v2_lczf_key_dupd,left.name_last=right.name_last and left.p_city_name=right.p_city_name and left.z5=right.z5 and left.name_first=right.name_first,t13(left,right),left only,local);
j14 := join(v2_lczf_key_dupd,v1_lczf_key_dupd,left.name_last=right.name_last and left.p_city_name=right.p_city_name and left.z5=right.z5 and left.name_first=right.name_first,t14(left,right),left only,local);

out53 := output(count(j13),named('lczfs_only_in_v1_key'));
out54 := output(count(j14),named('lczfs_only_in_v2_key'));
out55 := output(j13,named('lczfs_only_in_v1_key_sample'));
out56 := output(j14,named('lczfs_only_in_v2_key_sample'));

//npa_nxx compare					
v1_npa_nxx_key_dist := distribute(v1_npa_nxx_key,hash(npa,nxx,line));
v2_npa_nxx_key_dist := distribute(v2_npa_nxx_key,hash(npa,nxx,line));

v1_npa_nxx_key_sort := sort(v1_npa_nxx_key_dist,npa,nxx,line,local);
v2_npa_nxx_key_sort := sort(v2_npa_nxx_key_dist,npa,nxx,line,local);

v1_npa_nxx_key_dupd := dedup(v1_npa_nxx_key_sort,npa,nxx,line,local);
v2_npa_nxx_key_dupd := dedup(v2_npa_nxx_key_sort,npa,nxx,line,local);

out57 := output(count(v1_npa_nxx_key),named('v1_npa_nxx_key_ct'));
out58 := output(count(v2_npa_nxx_key),named('v2_npa_nxx_key_ct'));
out59 := output(count(v1_npa_nxx_key_dupd),named('v1_npa_nxx_key_dupd_ct'));
out60 := output(count(v2_npa_nxx_key_dupd),named('v2_npa_nxx_key_dupd_ct'));

r8 := record
 string3 npa;
 string3 nxx;
 string4 line;
end;

r8 t15(v1_npa_nxx_key_dupd le, v2_npa_nxx_key_dupd ri) := transform
 self := le;
end;

r8 t16(v2_npa_nxx_key_dupd le, v1_npa_nxx_key_dupd ri) := transform
 self := le;
end;

j15 := join(v1_npa_nxx_key_dupd,v2_npa_nxx_key_dupd,left.npa=right.npa and left.nxx=right.nxx and left.line=right.line,t15(left,right),left only,local);
j16 := join(v2_npa_nxx_key_dupd,v1_npa_nxx_key_dupd,left.npa=right.npa and left.nxx=right.nxx and left.line=right.line,t16(left,right),left only,local);

out61 := output(count(j15),named('npa_nxxs_only_in_v1_key'));
out62 := output(count(j16),named('npa_nxxs_only_in_v2_key'));
out63 := output(j15,named('npa_nxxs_only_in_v1_key_sample'));
out64 := output(j16,named('npa_nxxs_only_in_v2_key_sample'));

//st_lname_city compare					
v1_st_lname_city_key_dist := distribute(v1_st_lname_city_key,hash(st,lname,city));
v2_st_lname_city_key_dist := distribute(v2_st_lname_city_key,hash(st,lname,city));

v1_st_lname_city_key_sort := sort(v1_st_lname_city_key_dist,st,lname,city,local);
v2_st_lname_city_key_sort := sort(v2_st_lname_city_key_dist,st,lname,city,local);

v1_st_lname_city_key_dupd := dedup(v1_st_lname_city_key_sort,st,lname,city,local);
v2_st_lname_city_key_dupd := dedup(v2_st_lname_city_key_sort,st,lname,city,local);

out65 := output(count(v1_st_lname_city_key),named('v1_st_lname_city_key_ct'));
out66 := output(count(v2_st_lname_city_key),named('v2_st_lname_city_key_ct'));
out67 := output(count(v1_st_lname_city_key_dupd),named('v1_st_lname_city_key_dupd_ct'));
out68 := output(count(v2_st_lname_city_key_dupd),named('v2_st_lname_city_key_dupd_ct'));

r9 := record
 string2  st;
 string20 lname;
 string25 city;
end;

r9 t17(v1_st_lname_city_key_dupd le, v2_st_lname_city_key_dupd ri) := transform
 self := le;
end;

r9 t18(v2_st_lname_city_key_dupd le, v1_st_lname_city_key_dupd ri) := transform
 self := le;
end;

j17 := join(v1_st_lname_city_key_dupd,v2_st_lname_city_key_dupd,left.st=right.st and left.lname=right.lname and left.city=right.city,t17(left,right),left only,local);
j18 := join(v2_st_lname_city_key_dupd,v1_st_lname_city_key_dupd,left.st=right.st and left.lname=right.lname and left.city=right.city,t18(left,right),left only,local);

out69 := output(count(j17),named('st_lname_citys_only_in_v1_key'));
out70 := output(count(j18),named('st_lname_citys_only_in_v2_key'));
out71 := output(j17,named('st_lname_citys_only_in_v1_key_sample'));
out72 := output(j18,named('st_lname_citys_only_in_v2_key_sample'));

//st_lname_fname_city compare					
v1_st_lname_fname_city_key_dist := distribute(v1_st_lname_fname_city_key,hash(st,lname,fname,city));
v2_st_lname_fname_city_key_dist := distribute(v2_st_lname_fname_city_key,hash(st,lname,fname,city));

v1_st_lname_fname_city_key_sort := sort(v1_st_lname_fname_city_key_dist,st,lname,fname,city,local);
v2_st_lname_fname_city_key_sort := sort(v2_st_lname_fname_city_key_dist,st,lname,fname,city,local);

v1_st_lname_fname_city_key_dupd := dedup(v1_st_lname_fname_city_key_sort,st,lname,fname,city,local);
v2_st_lname_fname_city_key_dupd := dedup(v2_st_lname_fname_city_key_sort,st,lname,fname,city,local);

out73 := output(count(v1_st_lname_fname_city_key),named('v1_st_lname_fname_city_key_ct'));
out74 := output(count(v2_st_lname_fname_city_key),named('v2_st_lname_fname_city_key_ct'));
out75 := output(count(v1_st_lname_fname_city_key_dupd),named('v1_st_lname_fname_city_key_dupd_ct'));
out76 := output(count(v2_st_lname_fname_city_key_dupd),named('v2_st_lname_fname_city_key_dupd_ct'));

r10 := record
 string2  st;
 string20 lname;
 string20 fname;
 string25 city;
end;

r10 t19(v1_st_lname_fname_city_key_dupd le, v2_st_lname_fname_city_key_dupd ri) := transform
 self := le;
end;

r10 t20(v2_st_lname_fname_city_key_dupd le, v1_st_lname_fname_city_key_dupd ri) := transform
 self := le;
end;

j19 := join(v1_st_lname_fname_city_key_dupd,v2_st_lname_fname_city_key_dupd,left.st=right.st and left.lname=right.lname and left.fname=right.fname and left.city=right.city,t19(left,right),left only,local);
j20 := join(v2_st_lname_fname_city_key_dupd,v1_st_lname_fname_city_key_dupd,left.st=right.st and left.lname=right.lname and left.fname=right.fname and left.city=right.city,t20(left,right),left only,local);

out77 := output(count(j19),named('st_lname_fname_citys_only_in_v1_key'));
out78 := output(count(j20),named('st_lname_fname_citys_only_in_v2_key'));
out79 := output(j19,named('st_lname_fname_citys_only_in_v1_key_sample'));
out80 := output(j20,named('st_lname_fname_citys_only_in_v2_key_sample'));

//st_bizword_city compare					
v1_st_bizword_city_key_dist := distribute(v1_st_bizword_city_key,hash(st,word,city));
v2_st_bizword_city_key_dist := distribute(v2_st_bizword_city_key,hash(st,word,city));

v1_st_bizword_city_key_sort := sort(v1_st_bizword_city_key_dist,st,word,city,local);
v2_st_bizword_city_key_sort := sort(v2_st_bizword_city_key_dist,st,word,city,local);

v1_st_bizword_city_key_dupd := dedup(v1_st_bizword_city_key_sort,st,word,city,local);
v2_st_bizword_city_key_dupd := dedup(v2_st_bizword_city_key_sort,st,word,city,local);

out81 := output(count(v1_st_bizword_city_key),named('v1_st_bizword_city_key_ct'));
out82 := output(count(v2_st_bizword_city_key),named('v2_st_bizword_city_key_ct'));
out83 := output(count(v1_st_bizword_city_key_dupd),named('v1_st_bizword_city_key_dupd_ct'));
out84 := output(count(v2_st_bizword_city_key_dupd),named('v2_st_bizword_city_key_dupd_ct'));

r11 := record
 string2  st;
 string30 word;
 string25 city;
end;

r11 t21(v1_st_bizword_city_key_dupd le, v2_st_bizword_city_key_dupd ri) := transform
 self := le;
end;

r11 t22(v2_st_bizword_city_key_dupd le, v1_st_bizword_city_key_dupd ri) := transform
 self := le;
end;

j21 := join(v1_st_bizword_city_key_dupd,v2_st_bizword_city_key_dupd,left.st=right.st and left.word=right.word and left.city=right.city,t21(left,right),left only,local);
j22 := join(v2_st_bizword_city_key_dupd,v1_st_bizword_city_key_dupd,left.st=right.st and left.word=right.word and left.city=right.city,t22(left,right),left only,local);

out85 := output(count(j21),named('st_bizword_citys_only_in_v1_key'));
out86 := output(count(j22),named('st_bizword_citys_only_in_v2_key'));
out87 := output(j21,named('st_bizword_citys_only_in_v1_key_sample'));
out88 := output(j22,named('st_bizword_citys_only_in_v2_key_sample'));

//st_city_prim_name_prim_range compare					
v1_st_city_prim_name_prim_range_key_dist := distribute(v1_st_city_prim_name_prim_range_key,hash(st,city,prim_name,prim_range));
v2_st_city_prim_name_prim_range_key_dist := distribute(v2_st_city_prim_name_prim_range_key,hash(st,city,prim_name,prim_range));

v1_st_city_prim_name_prim_range_key_sort := sort(v1_st_city_prim_name_prim_range_key_dist,st,city,prim_name,prim_range,local);
v2_st_city_prim_name_prim_range_key_sort := sort(v2_st_city_prim_name_prim_range_key_dist,st,city,prim_name,prim_range,local);

v1_st_city_prim_name_prim_range_key_dupd := dedup(v1_st_city_prim_name_prim_range_key_sort,st,city,prim_name,prim_range,local);
v2_st_city_prim_name_prim_range_key_dupd := dedup(v2_st_city_prim_name_prim_range_key_sort,st,city,prim_name,prim_range,local);

out89 := output(count(v1_st_city_prim_name_prim_range_key),named('v1_st_city_prim_name_prim_range_key_ct'));
out90 := output(count(v2_st_city_prim_name_prim_range_key),named('v2_st_city_prim_name_prim_range_key_ct'));
out91 := output(count(v1_st_city_prim_name_prim_range_key_dupd),named('v1_st_city_prim_name_prim_range_key_dupd_ct'));
out92 := output(count(v2_st_city_prim_name_prim_range_key_dupd),named('v2_st_city_prim_name_prim_range_key_dupd_ct'));

r12 := record
 string2  st;
 string25 city;
 string28 prim_name;
 string10 prim_range;
end;

r12 t23(v1_st_city_prim_name_prim_range_key_dupd le, v2_st_city_prim_name_prim_range_key_dupd ri) := transform
 self := le;
end;

r12 t24(v2_st_city_prim_name_prim_range_key_dupd le, v1_st_city_prim_name_prim_range_key_dupd ri) := transform
 self := le;
end;

j23 := join(v1_st_city_prim_name_prim_range_key_dupd,v2_st_city_prim_name_prim_range_key_dupd,left.st=right.st and left.city=right.city and left.prim_name=right.prim_name and left.prim_range=right.prim_range,t23(left,right),left only,local);
j24 := join(v2_st_city_prim_name_prim_range_key_dupd,v1_st_city_prim_name_prim_range_key_dupd,left.st=right.st and left.city=right.city and left.prim_name=right.prim_name and left.prim_range=right.prim_range,t24(left,right),left only,local);

out93 := output(count(j23),named('st_city_prim_name_prim_ranges_only_in_v1_key'));
out94 := output(count(j24),named('st_city_prim_name_prim_ranges_only_in_v2_key'));
out95 := output(j23,named('st_city_prim_name_prim_ranges_only_in_v1_key_sample'));
out96 := output(j24,named('st_city_prim_name_prim_ranges_only_in_v2_key_sample'));

export proc_compare_v1_and_v2_keys := parallel(out1,out2,out3,out4,out5,out6,out7,out8
                                               ,out9,out10,out11,out12,out13,out14,out15,out16
											   ,out17,out18,out19,out20,out21,out22,out23,out24
											   ,out25,out26,out27,out28,out29,out30,out31,out32
											   ,out33,out34,out35,out36,out37,out38,out39,out40
											   ,out41,out42,out43,out44,out45,out46,out47,out48
											   ,out49,out50,out51,out52,out53,out54,out55,out56
											   ,out57,out58,out59,out60,out61,out62,out63,out64
											   ,out65,out66,out67,out68,out69,out70,out71,out72
											   ,out73,out74,out75,out76,out77,out78,out79,out80
											   ,out81,out82,out83,out84,out85,out86,out87,out88
											   ,out89,out90,out91,out92,out93,out94,out95,out96
											   );