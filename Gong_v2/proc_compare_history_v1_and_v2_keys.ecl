#workunit('name', 'GongV1-V2 History Key Compare')

import gong,DayBatchEda,eda_via_xml;

v1_Key_FCRA_History_Address := pull(Gong.Key_FCRA_History_Address);
v2_Key_FCRA_History_Address := pull(Gong_v2.Key_FCRA_History_Address);

v1_Key_FCRA_History_BDID := pull(Gong.Key_FCRA_History_BDID);
v2_Key_FCRA_History_BDID := pull(Gong_v2.Key_FCRA_History_BDID);

// v1_addr_key := pull();
// v2_addr_key := pull(Gong_v2.Key_FCRA_History_companyname);

v1_Key_FCRA_History_did := pull(Gong.Key_FCRA_History_did);
v2_Key_FCRA_History_did := pull(Gong_v2.Key_FCRA_History_did);

v1_Key_FCRA_History_Hhid := pull(Gong.Key_FCRA_History_Hhid);
v2_Key_FCRA_History_Hhid := pull(Gong_v2.Key_FCRA_History_Hhid);

v1_key_FCRA_history_name := pull(Gong.key_FCRA_history_name);
v2_key_FCRA_history_name := pull(Gong_v2.key_FCRA_history_name);

v1_key_FCRA_history_npa_nxx_line := pull(Gong.key_FCRA_history_npa_nxx_line);
v2_key_FCRA_history_npa_nxx_line := pull(Gong_v2.key_FCRA_history_npa_nxx_line);

v1_Key_FCRA_History_Phone := pull(Gong.Key_FCRA_History_Phone);
v2_Key_FCRA_History_Phone := pull(Gong_v2.Key_FCRA_History_Phone);

v1_Key_FCRA_History_Surname := pull(Gong.Key_FCRA_History_Surname);
v2_Key_FCRA_History_Surname := pull(Gong_v2.Key_FCRA_History_Surname);

v1_key_FCRA_history_zip_name := pull(Gong.key_FCRA_history_zip_name);
v2_key_FCRA_history_zip_name := pull(Gong_v2.key_FCRA_history_zip_name);

v1_Key_History_Address := pull(Gong.Key_History_Address);
v2_Key_History_Address := pull(Gong_v2.key_history_address);

v1_Key_History_BDID := pull(Gong.Key_History_BDID);
v2_Key_History_BDID := pull(Gong_v2.key_history_bdid);

v1_key_history_companyname := pull(Gong.key_history_companyname);
v2_key_history_companyname := pull(Gong_v2.key_history_companyname);

v1_Key_History_Did := pull(Gong.Key_History_Did);
v2_Key_History_Did := pull(Gong_v2.key_history_did);

v1_Key_History_Hhid := pull(Gong.Key_History_Hhid);
v2_Key_History_Hhid := pull(Gong_v2.key_history_hhid);

v1_key_history_name := pull(Gong.key_history_name);
v2_key_history_name := pull(Gong_v2.key_history_name);

v1_key_history_npa_nxx_line := pull(Gong.key_history_npa_nxx_line);
v2_key_history_npa_nxx_line := pull(Gong_v2.key_history_npa_nxx_line);

v1_Key_History_phone := pull(Gong.Key_History_phone);
v2_Key_History_phone := pull(Gong_v2.key_history_phone);

v1_Key_History_Surname := pull(Gong.Key_History_Surname);
v2_Key_History_Surname := pull(Gong_v2.key_history_surname);

v1_key_history_zip_name := pull(Gong.key_history_zip_name);
v2_key_history_zip_name := pull(Gong_v2.key_history_zip_name);

/////////////////////////////////////////////////////////////////////////////
////////FCRA DID compare
v1_Key_FCRA_History_did_dist := distribute(v1_Key_FCRA_History_did,hash(did));
v2_Key_FCRA_History_did_dist := distribute(v2_Key_FCRA_History_did,hash(did));

v1_Key_FCRA_History_did_sort := sort(v1_Key_FCRA_History_did_dist,did,local);
v2_Key_FCRA_History_did_sort := sort(v2_Key_FCRA_History_did_dist,did,local);

v1_Key_FCRA_History_did_dupd := dedup(v1_Key_FCRA_History_did_sort,did,local);
v2_Key_FCRA_History_did_dupd := dedup(v2_Key_FCRA_History_did_sort,did,local);

out1 := output(count(v1_Key_FCRA_History_did_dist),named('HISTORY_v1_Key_FCRA_History_did_ct'));
out2 := output(count(v2_Key_FCRA_History_did_dist),named('HISTORY_v2_Key_FCRA_History_did__ct'));
out3 := output(count(v1_Key_FCRA_History_did_dupd),named('HISTORY_v1_Key_FCRA_History_did_dupd_ct'));
out4 := output(count(v2_Key_FCRA_History_did_dupd),named('HISTORY_v2_Key_FCRA_History_did_dupd_ct'));

r1 := record
 unsigned6 did;
end;

r1 t1(v1_Key_FCRA_History_did_dupd le, v2_Key_FCRA_History_did_dupd ri) := transform
 self := le;
end;

r1 t2(v2_Key_FCRA_History_did_dupd le, v1_Key_FCRA_History_did_dupd ri) := transform
 self := le;
end;

j1 := join(v1_Key_FCRA_History_did_dupd,v2_Key_FCRA_History_did_dupd,left.did=right.did,t1(left,right),left only,local);
j2 := join(v2_Key_FCRA_History_did_dupd,v1_Key_FCRA_History_did_dupd,left.did=right.did,t2(left,right),left only,local);

out5 := output(count(j1),named('HISTORY_FCRADIDs_only_in_v1_key'));
out6 := output(count(j2),named('HISTORY_FCRADIDs_only_in_v2_key'));
out7 := output(j1,named('HISTORY_FCRADIDs_only_in_v1_key_sample'));
out8 := output(j2,named('HISTORY_FCRADIDs_only_in_v2_key_sample'));

/////////////////////////////////////////////////////////////////////////////
///////DID compare
v1_Key_History_did_dist := distribute(v1_Key_History_did,hash(did));
v2_Key_History_did_dist := distribute(v2_Key_History_did,hash(did));

v1_Key_History_did_sort := sort(v1_Key_History_did_dist,did,local);
v2_Key_History_did_sort := sort(v2_Key_History_did_dist,did,local);

v1_Key_History_did_dupd := dedup(v1_Key_History_did_sort,did,local);
v2_Key_History_did_dupd := dedup(v2_Key_History_did_sort,did,local);

out1a := output(count(v1_Key_History_did_dist),named('HISTORY_v1_Key_History_did_ct'));
out2a := output(count(v2_Key_History_did_dist),named('HISTORY_v2_Key_History_did_ct'));
out3a := output(count(v1_Key_History_did_dupd),named('HISTORY_v1_Key_History_did_dupd_ct'));
out4a := output(count(v2_Key_History_did_dupd),named('HISTORY_v2_Key_History_did_dupd_ct'));

r1 t1a(v1_Key_History_did_dupd le, v2_Key_History_did_dupd ri) := transform
 self := le;
end;

r1 t2a(v2_Key_History_did_dupd le, v1_Key_History_did_dupd ri) := transform
 self := le;
end;

j1a := join(v1_Key_History_did_dupd,v2_Key_History_did_dupd,left.did=right.did,t1a(left,right),left only,local);
j2a := join(v2_Key_History_did_dupd,v1_Key_History_did_dupd,left.did=right.did,t2a(left,right),left only,local);

out5a := output(count(j1a),named('HISTORY_DIDs_only_in_v1_key'));
out6a := output(count(j2a),named('HISTORY_DIDs_only_in_v2_key'));
out7a := output(j1a,named('HISTORY_DIDs_only_in_v1_key_sample'));
out8a := output(j2a,named('HISTORY_DIDs_only_in_v2_key_sample'));

/////////////////////////////////////////////////////////////////////////////
///////BDID compare
v1_bdid_key_dist := distribute(v1_Key_FCRA_History_BDID,hash(bdid));
v2_bdid_key_dist := distribute(v2_Key_FCRA_History_BDID,hash(bdid));

v1_bdid_key_sort := sort(v1_bdid_key_dist,bdid,local);
v2_bdid_key_sort := sort(v2_bdid_key_dist,bdid,local);

v1_bdid_key_dupd := dedup(v1_bdid_key_sort,bdid,local);
v2_bdid_key_dupd := dedup(v2_bdid_key_sort,bdid,local);

out9  := output(count(v1_Key_FCRA_History_BDID),named('HISTORY_FCRAv1_bdid_key_ct'));
out10 := output(count(v2_Key_FCRA_History_BDID),named('HISTORY_FCRAv2_bdid_key_ct'));
out11 := output(count(v1_bdid_key_dupd),named('HISTORY_FCRAv1_bdid_key_dupd_ct'));
out12 := output(count(v2_bdid_key_dupd),named('HISTORY_FCRAv2_bdid_key_dupd_ct'));

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

out13 := output(count(j3),named('HISTORY_FCRABDIDs_only_in_v1_key'));
out14 := output(count(j4),named('HISTORY_FCRABDIDs_only_in_v2_key'));
out15 := output(j3,named('HISTORY_FCRABDIDs_only_in_v1_key_sample'));
out16 := output(j4,named('HISTORY_FCRABDIDs_only_in_v2_key_sample'));

/////////////////////////////////////////////////////////////////////////////
///////BDID compare nonFCRA

v1_bdid_key_dista := distribute(v1_Key_History_BDID,hash(bdid));
v2_bdid_key_dista := distribute(v2_Key_History_BDID,hash(bdid));

v1_bdid_key_sorta := sort(v1_bdid_key_dista,bdid,local);
v2_bdid_key_sorta := sort(v2_bdid_key_dista,bdid,local);

v1_bdid_key_dupda := dedup(v1_bdid_key_sorta,bdid,local);
v2_bdid_key_dupda := dedup(v2_bdid_key_sorta,bdid,local);

out9a  := output(count(v1_Key_History_BDID),named('HISTORY_v1_bdid_key_ct'));
out10a := output(count(v2_Key_History_BDID),named('HISTORY_v2_bdid_key_ct'));
out11a := output(count(v1_bdid_key_dupda),named('HISTORY_v1_bdid_key_dupd_ct'));
out12a := output(count(v2_bdid_key_dupda),named('HISTORY_v2_bdid_key_dupd_ct'));

r2 t3a(v1_bdid_key_dupda le, v2_bdid_key_dupda ri) := transform
 self := le;
end;

r2 t4a(v2_bdid_key_dupda le, v1_bdid_key_dupda ri) := transform
 self := le;
end;

j3a := join(v1_bdid_key_dupda,v2_bdid_key_dupda,left.bdid=right.bdid,t3a(left,right),left only,local);
j4a := join(v2_bdid_key_dupda,v1_bdid_key_dupda,left.bdid=right.bdid,t4a(left,right),left only,local);

out13a := output(count(j3a),named('HISTORY_BDIDs_only_in_v1_key'));
out14a := output(count(j4a),named('HISTORY_BDIDs_only_in_v2_key'));
out15a := output(j3a,named('HISTORY_BDIDs_only_in_v1_key_sample'));
out16a := output(j4a,named('HISTORY_BDIDs_only_in_v2_key_sample'));

/////////////////////////////////////////////////////////////////////////////
///////ADDR compare FCRA

v1_addr_key_dist := distribute(v1_Key_FCRA_History_Address,hash(prim_name,z5,prim_range,sec_range));
v2_addr_key_dist := distribute(v2_Key_FCRA_History_Address,hash(prim_name,z5,prim_range,sec_range));

v1_addr_key_sort := sort(v1_addr_key_dist,prim_name,z5,prim_range,sec_range,local);
v2_addr_key_sort := sort(v2_addr_key_dist,prim_name,z5,prim_range,sec_range,local);

v1_addr_key_dupd := dedup(v1_addr_key_sort,prim_name,z5,prim_range,sec_range,local);
v2_addr_key_dupd := dedup(v2_addr_key_sort,prim_name,z5,prim_range,sec_range,local);

out17 := output(count(v1_Key_FCRA_History_Address),named('HISTORY_FCRAv1_addr_key_ct'));
out18 := output(count(v2_Key_FCRA_History_Address),named('HISTORY_FCRAv2_addr_key_ct'));
out19 := output(count(v1_addr_key_dupd),named('HISTORY_FCRAv1_addr_key_dupd_ct'));
out20 := output(count(v2_addr_key_dupd),named('HISTORY_FCRAv2_addr_key_dupd_ct'));

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

out21 := output(count(j5),named('HISTORY_FCRAaddrs_only_in_v1_key'));
out22 := output(count(j6),named('HISTORY_FCRAaddrs_only_in_v2_key'));
out23 := output(j5,named('HISTORY_FCRAaddr_only_in_v1_key_sample'));
out24 := output(j6,named('HISTORY_FCRAaddr_only_in_v2_key_sample'));

/////////////////////////////////////////////////////////////////////////////
///////ADDR compare 

v1_addr_key_dista := distribute(v1_Key_History_Address,hash(prim_name,z5,prim_range,sec_range));
v2_addr_key_dista := distribute(v2_Key_History_Address,hash(prim_name,z5,prim_range,sec_range));

v1_addr_key_sorta := sort(v1_addr_key_dista,prim_name,z5,prim_range,sec_range,local);
v2_addr_key_sorta := sort(v2_addr_key_dista,prim_name,z5,prim_range,sec_range,local);

v1_addr_key_dupda := dedup(v1_addr_key_sorta,prim_name,z5,prim_range,sec_range,local);
v2_addr_key_dupda := dedup(v2_addr_key_sorta,prim_name,z5,prim_range,sec_range,local);

out17a := output(count(v1_Key_History_Address),named('HISTORY_v1_addr_key_ct'));
out18a := output(count(v2_Key_History_Address),named('HISTORY_v2_addr_key_ct'));
out19a := output(count(v1_addr_key_dupda),named('HISTORY_v1_addr_key_dupd_ct'));
out20a := output(count(v2_addr_key_dupda),named('HISTORY_v2_addr_key_dupd_ct'));


r3 t5a(v1_addr_key_dupda le, v2_addr_key_dupda ri) := transform
 self := le;
end;

r3 t6a(v2_addr_key_dupda le, v1_addr_key_dupda ri) := transform
 self := le;
end;

j5a := join(v1_addr_key_dupda,v2_addr_key_dupda,left.prim_name=right.prim_name and left.z5=right.z5 and left.prim_range=right.prim_range and left.sec_range=right.sec_range,t5a(left,right),left only,local);
j6a := join(v2_addr_key_dupda,v1_addr_key_dupda,left.prim_name=right.prim_name and left.z5=right.z5 and left.prim_range=right.prim_range and left.sec_range=right.sec_range,t6a(left,right),left only,local);

out21a := output(count(j5a),named('HISTORY_addrs_only_in_v1_key'));
out22a := output(count(j6a),named('HISTORY_addrs_only_in_v2_key'));
out23a := output(j5a,named('HISTORY_addr_only_in_v1_key_sample'));
out24a := output(j6a,named('HISTORY_addr_only_in_v2_key_sample'));

/////////////////////////////////////////////////////////////////////////////
/////// FCRA HHID compare

v1_hhid_key_dist := distribute(v1_Key_FCRA_History_Hhid,hash(hhid));
v2_hhid_key_dist := distribute(v2_Key_FCRA_History_Hhid,hash(hhid));

v1_hhid_key_sort := sort(v1_hhid_key_dist,hhid,local);
v2_hhid_key_sort := sort(v2_hhid_key_dist,hhid,local);

v1_hhid_key_dupd := dedup(v1_hhid_key_sort,hhid,local);
v2_hhid_key_dupd := dedup(v2_hhid_key_sort,hhid,local);

out25 := output(count(v1_Key_FCRA_History_Hhid),named('HISTORY_FCRAv1_hhid_key_ct'));
out26 := output(count(v2_Key_FCRA_History_Hhid),named('HISTORY_FCRAv2_hhid_key_ct'));
out27 := output(count(v1_hhid_key_dupd),named('HISTORY_FCRAv1_hhid_key_dupd_ct'));
out28 := output(count(v2_hhid_key_dupd),named('HISTORY_FCRAv2_hhid_key_dupd_ct'));

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

out29 := output(count(j7),named('HISTORY_FCRAHHIDs_only_in_v1_key'));
out30 := output(count(j8),named('HISTORY_FCRAHHIDs_only_in_v2_key'));
out31 := output(j7,named('HISTORY_FCRAHHIDs_only_in_v1_key_sample'));
out32 := output(j8,named('HISTORY_FCRAHHIDs_only_in_v2_key_sample'));

/////////////////////////////////////////////////////////////////////////////
/////// HHID compare

v1_hhid_key_dista := distribute(v1_Key_History_Hhid,hash(hhid));
v2_hhid_key_dista := distribute(v2_Key_History_Hhid,hash(hhid));

v1_hhid_key_sorta := sort(v1_hhid_key_dista,hhid,local);
v2_hhid_key_sorta := sort(v2_hhid_key_dista,hhid,local);

v1_hhid_key_dupda := dedup(v1_hhid_key_sorta,hhid,local);
v2_hhid_key_dupda := dedup(v2_hhid_key_sorta,hhid,local);

out25a := output(count(v1_Key_History_Hhid),named('HISTORY_v1_hhid_key_ct'));
out26a := output(count(v2_Key_History_Hhid),named('HISTORY_v2_hhid_key_ct'));
out27a := output(count(v1_hhid_key_dupda),named('HISTORY_v1_hhid_key_dupd_ct'));
out28a := output(count(v2_hhid_key_dupda),named('HISTORY_v2_hhid_key_dupd_ct'));


r4 t7a(v1_hhid_key_dupda le, v2_hhid_key_dupda ri) := transform
 self := le;
end;

r4 t8a(v2_hhid_key_dupda le, v1_hhid_key_dupda ri) := transform
 self := le;
end;

j7a := join(v1_hhid_key_dupda,v2_hhid_key_dupda,left.hhid=right.hhid,t7a(left,right),left only,local);
j8a := join(v2_hhid_key_dupda,v1_hhid_key_dupda,left.hhid=right.hhid,t8a(left,right),left only,local);

out29a := output(count(j7a),named('HISTORY_HHIDs_only_in_v1_key'));
out30a := output(count(j8a),named('HISTORY_HHIDs_only_in_v2_key'));
out31a := output(j7a,named('HISTORY_HHIDs_only_in_v1_key_sample'));
out32a := output(j8a,named('HISTORY_HHIDs_only_in_v2_key_sample'));

/////////////////////////////////////////////////////////////////////////////
/////// FCRA Phone compare

v1_phone_key_dist := distribute(v1_Key_FCRA_History_Phone,hash(phone7,area_code));
v2_phone_key_dist := distribute(v2_Key_FCRA_History_Phone,hash(phone7,area_code));

v1_phone_key_sort := sort(v1_phone_key_dist,phone7,area_code,local);
v2_phone_key_sort := sort(v2_phone_key_dist,phone7,area_code,local);

v1_phone_key_dupd := dedup(v1_phone_key_sort,phone7,area_code,local);
v2_phone_key_dupd := dedup(v2_phone_key_sort,phone7,area_code,local);

out33 := output(count(v1_Key_FCRA_History_Phone),named('HISTORY_FCRAv1_phone_key_ct'));
out34 := output(count(v2_Key_FCRA_History_Phone),named('HISTORY_FCRAv2_phone_key_ct'));
out35 := output(count(v1_phone_key_dupd),named('HISTORY_FCRAv1_phone_key_dupd_ct'));
out36 := output(count(v2_phone_key_dupd),named('HISTORY_FCRAv2_phone_key_dupd_ct'));

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

out37 := output(count(j9),named('HISTORY_FCRAPhones_only_in_v1_key'));
out38 := output(count(j10),named('HISTORY_FCRAPhones_only_in_v2_key'));
out39 := output(j9,named('HISTORY_FCRAPhones_only_in_v1_key_sample'));
out40 := output(j10,named('HISTORY_FCRAPhones_only_in_v2_key_sample'));

/////////////////////////////////////////////////////////////////////////////
/////// Phone compare

v1_phone_key_dista := distribute(v1_Key_History_Phone,hash(phone7,area_code));
v2_phone_key_dista := distribute(v2_Key_History_Phone,hash(phone7,area_code));

v1_phone_key_sorta := sort(v1_phone_key_dista,phone7,area_code,local);
v2_phone_key_sorta := sort(v2_phone_key_dista,phone7,area_code,local);

v1_phone_key_dupda := dedup(v1_phone_key_sorta,phone7,area_code,local);
v2_phone_key_dupda := dedup(v2_phone_key_sorta,phone7,area_code,local);

out33a := output(count(v1_Key_History_Phone),named('HISTORY_v1_phone_key_ct'));
out34a := output(count(v2_Key_History_Phone),named('HISTORY_v2_phone_key_ct'));
out35a := output(count(v1_phone_key_dupda),named('HISTORY_v1_phone_key_dupd_ct'));
out36a := output(count(v2_phone_key_dupda),named('HISTORY_v2_phone_key_dupd_ct'));

r5 t9a(v1_phone_key_dupda le, v2_phone_key_dupda ri) := transform
 self := le;
end;

r1 t10a(v2_phone_key_dupda le, v1_phone_key_dupda ri) := transform
 self := le;
end;

j9a  := join(v1_phone_key_dupda,v2_phone_key_dupda,left.phone7=right.phone7 and left.area_code=right.area_code, t9a(left,right),left only,local);
j10a := join(v2_phone_key_dupda,v1_phone_key_dupda,left.phone7=right.phone7 and left.area_code=right.area_code,t10a(left,right),left only,local);

out37a := output(count(j9a),named('HISTORY_Phones_only_in_v1_key'));
out38a := output(count(j10a),named('HISTORY_Phones_only_in_v2_key'));
out39a := output(j9a,named('HISTORY_Phones_only_in_v1_key_sample'));
out40a := output(j10a,named('HISTORY_Phones_only_in_v2_key_sample'));

/////////////////////////////////////////////////////////////////////////////
/////// Surname compare FCRA

v1_surname_key_dist := distribute(v1_Key_FCRA_History_Surname,hash(k_name_last,z5,k_name_first));
v2_surname_key_dist := distribute(v2_Key_FCRA_History_Surname,hash(k_name_last,z5,k_name_first));

v1_surname_key_sort := sort(v1_surname_key_dist,p_city_name,z5,prim_name,prim_range,name_last,name_first,local);
v2_surname_key_sort := sort(v2_surname_key_dist,p_city_name,z5,prim_name,prim_range,name_last,name_first,local);

v1_surname_key_dupd := dedup(v1_surname_key_sort,p_city_name,z5,prim_name,prim_range,name_last,name_first,local);
v2_surname_key_dupd := dedup(v2_surname_key_sort,p_city_name,z5,prim_name,prim_range,name_last,name_first,local);

out41 := output(count(v1_Key_FCRA_History_Surname),named('HISTORY_FCRAv1_surname_key_ct'));
out42 := output(count(v2_Key_FCRA_History_Surname),named('HISTORY_FCRAv2_surname_key_ct'));
out43 := output(count(v1_surname_key_dupd),named('HISTORY_FCRAv1_surname_key_dupd_ct'));
out44 := output(count(v2_surname_key_dupd),named('HISTORY_FCRAv2_surname_key_dupd_ct'));

r6 := record
 string25 p_city_name;
 string5  z5;
 string28 prim_name;
 string10 prim_range;
 string20 name_last;
 string20 name_first;
end;

r6 t11(v1_surname_key_dupd le, v2_surname_key_dupd ri) := transform
 self := le;
end;

r6 t12(v2_surname_key_dupd le, v1_surname_key_dupd ri) := transform
 self := le;
end;

j11 := join(v1_surname_key_dupd,v2_surname_key_dupd,left.p_city_name=right.p_city_name and left.z5=right.z5 and left.prim_name=right.prim_name and left.prim_range=right.prim_range and left.name_last=right.name_last and left.name_first=right.name_first,t11(left,right),left only,local);
j12 := join(v2_surname_key_dupd,v1_surname_key_dupd,left.p_city_name=right.p_city_name and left.z5=right.z5 and left.prim_name=right.prim_name and left.prim_range=right.prim_range and left.name_last=right.name_last and left.name_first=right.name_first,t12(left,right),left only,local);

out45 := output(count(j11),named('HISTORY_FCRAsurnames_only_in_v1_key'));
out46 := output(count(j12),named('HISTORY_FCRAsurnames_only_in_v2_key'));
out47 := output(j11,named('HISTORY_FCRAsurnames_only_in_v1_key_sample'));
out48 := output(j12,named('HISTORY_FCRAsurnames_only_in_v2_key_sample'));

/////////////////////////////////////////////////////////////////////////////
/////// Surname compare 

v1_surname_key_dista := distribute(v1_Key_History_Surname,hash(k_name_last,z5,k_name_first));
v2_surname_key_dista := distribute(v2_Key_History_Surname,hash(k_name_last,z5,k_name_first));

v1_surname_key_sorta := sort(v1_surname_key_dista,p_city_name,z5,prim_name,prim_range,name_last,name_first,local);
v2_surname_key_sorta := sort(v2_surname_key_dista,p_city_name,z5,prim_name,prim_range,name_last,name_first,local);

v1_surname_key_dupda := dedup(v1_surname_key_sorta,p_city_name,z5,prim_name,prim_range,name_last,name_first,local);
v2_surname_key_dupda := dedup(v2_surname_key_sorta,p_city_name,z5,prim_name,prim_range,name_last,name_first,local);

out41a := output(count(v1_Key_History_Surname),named('HISTORY_v1_surname_key_ct'));
out42a := output(count(v2_Key_History_Surname),named('HISTORY_v2_surname_key_ct'));
out43a := output(count(v1_surname_key_dupda),named('HISTORY_v1_surname_key_dupd_ct'));
out44a := output(count(v2_surname_key_dupda),named('HISTORY_v2_surname_key_dupd_ct'));

r6 t11a(v1_surname_key_dupda le, v2_surname_key_dupda ri) := transform
 self := le;
end;

r6 t12a(v2_surname_key_dupda le, v1_surname_key_dupda ri) := transform
 self := le;
end;

j11a := join(v1_surname_key_dupda,v2_surname_key_dupda,left.k_name_last=right.k_name_last and left.k_name_first=right.k_name_first and left.k_st=right.k_st,t11a(left,right),left only,local);
j12a := join(v2_surname_key_dupda,v1_surname_key_dupda,left.k_name_last=right.k_name_last and left.k_name_first=right.k_name_first and left.k_st=right.k_st,t12a(left,right),left only,local);

out45a := output(count(j11a),named('HISTORY_surnames_only_in_v1_key'));
out46a := output(count(j12a),named('HISTORY_surnames_only_in_v2_key'));
out47a := output(j11a,named('HISTORY_surnames_only_in_v1_key_sample'));
out48a := output(j12a,named('HISTORY_surnames_only_in_v2_key_sample'));

/////////////////////////////////////////////////////////////////////
////////////name FCRA compare	
				
v1_name_key_dist := distribute(v1_key_FCRA_history_name,hash(dph_name_last,p_name_first));
v2_name_key_dist := distribute(v2_key_FCRA_history_name,hash(dph_name_last,p_name_first));

v1_name_key_sort := sort(v1_name_key_dist,name_last,p_city_name,z5,name_first,local);
v2_name_key_sort := sort(v2_name_key_dist,name_last,p_city_name,z5,name_first,local);

v1_name_key_dupd := dedup(v1_name_key_sort,name_last,p_city_name,z5,name_first,local);
v2_name_key_dupd := dedup(v2_name_key_sort,name_last,p_city_name,z5,name_first,local);

out49 := output(count(v1_key_FCRA_history_name),named('HISTORY_FCRAv1_name_key_ct'));
out50 := output(count(v2_key_FCRA_history_name),named('HISTORY_FCRAv2_name_key_ct'));
out51 := output(count(v1_name_key_dupd),named('HISTORY_FCRAv1_name_key_dupd_ct'));
out52 := output(count(v2_name_key_dupd),named('HISTORY_FCRAv2_name_key_dupd_ct'));

r7 := record
 string dph_name_last;
 string name_last;
 string st;
 string p_name_first;
 string name_first;
end;

r7 t13(v1_name_key_dupd le, v2_name_key_dupd ri) := transform
 self := le;
end;

r7 t14(v2_name_key_dupd le, v1_name_key_dupd ri) := transform
 self := le;
end;

j13 := join(v1_name_key_dupd,v2_name_key_dupd,left.name_last = right.name_last and left.st = right.st and left.name_first = right.name_first and left.dph_name_last=right.dph_name_last and left.p_name_first=right.p_name_first,t13(left,right),left only,local);
j14 := join(v2_name_key_dupd,v1_name_key_dupd,left.name_last = right.name_last and left.st = right.st and left.name_first = right.name_first and left.dph_name_last=right.dph_name_last and left.p_name_first=right.p_name_first,t14(left,right),left only,local);

out53 := output(count(j13),named('HISTORY_FCRAnames_only_in_v1_key'));
out54 := output(count(j14),named('HISTORY_FCRAnames_only_in_v2_key'));
out55 := output(j13,named('HISTORY_FCRAnames_only_in_v1_key_sample'));
out56 := output(j14,named('HISTORY_FCRAnames_only_in_v2_key_sample'));

/////////////////////////////////////////////////////////////////////
////////////name compare	
				
v1_name_key_dista := distribute(v1_key_history_name,hash(dph_name_last,p_name_first));
v2_name_key_dista := distribute(v2_key_history_name,hash(dph_name_last,p_name_first));

v1_name_key_sorta := sort(v1_name_key_dista,name_last,p_city_name,z5,name_first,local);
v2_name_key_sorta := sort(v2_name_key_dista,name_last,p_city_name,z5,name_first,local);

v1_name_key_dupda := dedup(v1_name_key_sorta,name_last,p_city_name,z5,name_first,local);
v2_name_key_dupda := dedup(v2_name_key_sorta,name_last,p_city_name,z5,name_first,local);

out49a := output(count(v1_key_history_name),named('HISTORY_v1_name_key_ct'));
out50a := output(count(v2_key_history_name),named('HISTORY_v2_name_key_ct'));
out51a := output(count(v1_name_key_dupd),named('HISTORY_v1_name_key_dupd_ct'));
out52a := output(count(v2_name_key_dupd),named('HISTORY_v2_name_key_dupd_ct'));

r7 t13a(v1_name_key_dupda le, v2_name_key_dupda ri) := transform
 self := le;
end;

r7 t14a(v2_name_key_dupda le, v1_name_key_dupda ri) := transform
 self := le;
end;

j13a := join(v1_name_key_dupda,v2_name_key_dupda,left.dph_name_last=right.dph_name_last and left.p_name_first=right.p_name_first,t13a(left,right),left only,local);
j14a := join(v2_name_key_dupda,v1_name_key_dupda,left.dph_name_last=right.dph_name_last and left.p_name_first=right.p_name_first,t14a(left,right),left only,local);

out53a := output(count(j13a),named('HISTORY_names_only_in_v1_key'));
out54a := output(count(j14a),named('HISTORY_names_only_in_v2_key'));
out55a := output(j13a,named('HISTORY_names_only_in_v1_key_sample'));
out56a := output(j14a,named('HISTORY_names_only_in_v2_key_sample'));

/////////////////////////////////////////////////////////////////////
///////npa_nxx FCRA compare					

v1_npa_nxx_key_dist := distribute(v1_key_FCRA_history_npa_nxx_line,hash(npa,nxx,line));
v2_npa_nxx_key_dist := distribute(v2_key_FCRA_history_npa_nxx_line,hash(npa,nxx,line));

v1_npa_nxx_key_sort := sort(v1_npa_nxx_key_dist,npa,nxx,line,local);
v2_npa_nxx_key_sort := sort(v2_npa_nxx_key_dist,npa,nxx,line,local);

v1_npa_nxx_key_dupd := dedup(v1_npa_nxx_key_sort,npa,nxx,line,local);
v2_npa_nxx_key_dupd := dedup(v2_npa_nxx_key_sort,npa,nxx,line,local);

out57 := output(count(v1_key_FCRA_history_npa_nxx_line),named('HISTORY_FCRAv1_npa_nxx_key_ct'));
out58 := output(count(v2_key_FCRA_history_npa_nxx_line),named('HISTORY_FCRAv2_npa_nxx_key_ct'));
out59 := output(count(v1_npa_nxx_key_dupd),named('HISTORY_FCRAv1_npa_nxx_key_dupd_ct'));
out60 := output(count(v2_npa_nxx_key_dupd),named('HISTORY_FCRAv2_npa_nxx_key_dupd_ct'));

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

out61 := output(count(j15),named('HISTORY_FCRAnpa_nxxs_only_in_v1_key'));
out62 := output(count(j16),named('HISTORY_FCRAnpa_nxxs_only_in_v2_key'));
out63 := output(j15,named('HISTORY_FCRAnpa_nxxs_only_in_v1_key_sample'));
out64 := output(j16,named('HISTORY_FCRAnpa_nxxs_only_in_v2_key_sample'));

/////////////////////////////////////////////////////////////////////
///////npa_nxx compare					

v1_npa_nxx_key_dista := distribute(v1_key_history_npa_nxx_line,hash(npa,nxx,line));
v2_npa_nxx_key_dista := distribute(v2_key_history_npa_nxx_line,hash(npa,nxx,line));

v1_npa_nxx_key_sorta := sort(v1_npa_nxx_key_dista,npa,nxx,line,local);
v2_npa_nxx_key_sorta := sort(v2_npa_nxx_key_dista,npa,nxx,line,local);

v1_npa_nxx_key_dupda := dedup(v1_npa_nxx_key_sorta,npa,nxx,line,local);
v2_npa_nxx_key_dupda := dedup(v2_npa_nxx_key_sorta,npa,nxx,line,local);

out57a := output(count(v1_key_history_npa_nxx_line),named('HISTORY_v1_npa_nxx_key_ct'));
out58a := output(count(v2_key_history_npa_nxx_line),named('HISTORY_v2_npa_nxx_key_ct'));
out59a := output(count(v1_npa_nxx_key_dupda),named('HISTORY_v1_npa_nxx_key_dupd_ct'));
out60a := output(count(v2_npa_nxx_key_dupda),named('HISTORY_v2_npa_nxx_key_dupd_ct'));

r8 t15a(v1_npa_nxx_key_dupda le, v2_npa_nxx_key_dupda ri) := transform
 self := le;
end;

r8 t16a(v2_npa_nxx_key_dupda le, v1_npa_nxx_key_dupda ri) := transform
 self := le;
end;

j15a := join(v1_npa_nxx_key_dupda,v2_npa_nxx_key_dupda,left.npa=right.npa and left.nxx=right.nxx and left.line=right.line,t15a(left,right),left only,local);
j16a := join(v2_npa_nxx_key_dupda,v1_npa_nxx_key_dupda,left.npa=right.npa and left.nxx=right.nxx and left.line=right.line,t16a(left,right),left only,local);

out61a := output(count(j15a),named('HISTORY_npa_nxxs_only_in_v1_key'));
out62a := output(count(j16a),named('HISTORY_npa_nxxs_only_in_v2_key'));
out63a := output(j15a,named('HISTORY_npa_nxxs_only_in_v1_key_sample'));
out64a := output(j16a,named('HISTORY_npa_nxxs_only_in_v2_key_sample'));

/////////////////////////////////////////////////////////////////////
/////////// company name compare			
		
v1_companyname_key_dist := distribute(v1_key_history_companyname,hash(listed_name));
v2_companyname_key_dist := distribute(v2_key_history_companyname,hash(listed_name));

v1_companyname_key_sort := sort(v1_companyname_key_dist,record,local);
v2_companyname_key_sort := sort(v2_companyname_key_dist,record,local);

v1_companyname_key_dupd := dedup(v1_companyname_key_sort,record,local);
v2_companyname_key_dupd := dedup(v2_companyname_key_sort,record,local);

out65 := output(count(v1_key_history_companyname),named('HISTORY_v1_companyname_key_ct'));
out66 := output(count(v2_key_history_companyname),named('HISTORY_v2_companyname_key_ct'));
out67 := output(count(v1_companyname_key_dupd),named('HISTORY_v1_companyname_key_dupd_ct'));
out68 := output(count(v2_companyname_key_dupd),named('HISTORY_v2_companyname_key_dupd_ct'));

r9 := record
 string2  listed_name;
 end;

r9 t17(v1_companyname_key_dupd le, v2_companyname_key_dupd ri) := transform
 self := le;
end;

r9 t18(v2_companyname_key_dupd le, v1_companyname_key_dupd ri) := transform
 self := le;
end;

j17 := join(v1_companyname_key_dupd,v2_companyname_key_dupd,left.listed_name=right.listed_name,t17(left,right),left only,local);
j18 := join(v2_companyname_key_dupd,v1_companyname_key_dupd,left.listed_name=right.listed_name,t18(left,right),left only,local);

out69 := output(count(j17),named('HISTORY_companynames_only_in_v1_key'));
out70 := output(count(j18),named('HISTORY_companynames_only_in_v2_key'));
out71 := output(j17,named('HISTORY_companynames_only_in_v1_key_sample'));
out72 := output(j18,named('HISTORY_companynames_only_in_v2_key_sample'));

/////////////////////////////////////////////////////////////////
//////// zip name FCRA compare					

v1_zip_name_key_dist := distribute(v1_key_FCRA_history_zip_name,hash(zip5, dph_name_last));
v2_zip_name_key_dist := distribute(v2_key_FCRA_history_zip_name,hash(zip5, dph_name_last));

v1_zip_name_key_sort := sort(v1_zip_name_key_dist,record,local);
v2_zip_name_key_sort := sort(v2_zip_name_key_dist,record,local);

v1_zip_name_key_dupd := dedup(v1_zip_name_key_sort,record,local);
v2_zip_name_key_dupd := dedup(v2_zip_name_key_sort,record,local);

out73 := output(count(v1_key_FCRA_history_zip_name),named('HISTORY_FCRAv1_zip_name_key_ct'));
out74 := output(count(v2_key_FCRA_history_zip_name),named('HISTORY_FCRAv2_zip_name_key_ct'));
out75 := output(count(v1_zip_name_key_dupd),named('HISTORY_FCRAv1_zip_name_key_dupd_ct'));
out76 := output(count(v2_zip_name_key_dupd),named('HISTORY_FCRAv2_zip_name_key_dupd_ct'));

r10 := record
 unsigned integer  zip5;
 string dph_name_last;
end;

r10 t19(v1_zip_name_key_dupd le, v2_zip_name_key_dupd ri) := transform
 self := le;
end;

r10 t20(v2_zip_name_key_dupd le, v1_zip_name_key_dupd ri) := transform
 self := le;
end;

j19 := join(v1_zip_name_key_dupd,v2_zip_name_key_dupd,left.dph_name_last=right.dph_name_last and left.p_name_first=right.p_name_first and left.zip5 = right.zip5,t19(left,right),left only,local);
j20 := join(v2_zip_name_key_dupd,v1_zip_name_key_dupd,left.dph_name_last=right.dph_name_last and left.p_name_first=right.p_name_first and left.zip5 = right.zip5,t20(left,right),left only,local);

out77 := output(count(j19),named('HISTORY_FCRAzip_names_only_in_v1_key'));
out78 := output(count(j20),named('HISTORY_FCRAzip_names_only_in_v2_key'));
out79 := output(j19,named('HISTORY_FCRAzip_names_only_in_v1_key_sample'));
out80 := output(j20,named('HISTORY_FCRAzip_names_only_in_v2_key_sample'));

/////////////////////////////////////////////////////////////////
//////// zip name compare					

v1_zip_name_key_dista := distribute(v1_key_history_zip_name,hash(zip5, dph_name_last));
v2_zip_name_key_dista := distribute(v2_key_history_zip_name,hash(zip5, dph_name_last));

v1_zip_name_key_sorta := sort(v1_zip_name_key_dista,zip5, dph_name_last,local);
v2_zip_name_key_sorta := sort(v2_zip_name_key_dista,zip5, dph_name_last,local);

v1_zip_name_key_dupda := dedup(v1_zip_name_key_sorta,zip5, dph_name_last,local);
v2_zip_name_key_dupda := dedup(v2_zip_name_key_sorta,zip5, dph_name_last,local);

out73a := output(count(v1_key_history_zip_name),named('HISTORY_v1_zip_name_key_ct'));
out74a := output(count(v2_key_history_zip_name),named('HISTORY_v2_zip_name_key_ct'));
out75a := output(count(v1_zip_name_key_dupd),named('HISTORY_v1_zip_name_key_dupd_ct'));
out76a := output(count(v2_zip_name_key_dupd),named('HISTORY_v2_zip_name_key_dupd_ct'));

r10 t19a(v1_zip_name_key_dupda le, v2_zip_name_key_dupda ri) := transform
 self := le;
end;

r10 t20a(v2_zip_name_key_dupda le, v1_zip_name_key_dupda ri) := transform
 self := le;
end;

j19a := join(v1_zip_name_key_dupda,v2_zip_name_key_dupda,left.dph_name_last=right.dph_name_last and left.p_name_first=right.p_name_first and left.zip5 = right.zip5,t19a(left,right),left only,local);
j20a := join(v2_zip_name_key_dupda,v1_zip_name_key_dupda,left.dph_name_last=right.dph_name_last and left.p_name_first=right.p_name_first and left.zip5 = right.zip5,t20a(left,right),left only,local);

out77a := output(count(j19a),named('HISTORY_zip_names_only_in_v1_key'));
out78a := output(count(j20a),named('HISTORY_zip_names_only_in_v2_key'));
out79a := output(j19a,named('HISTORY_zip_names_only_in_v1_key_sample'));
out80a := output(j20a,named('HISTORY_zip_names_only_in_v2_key_sample'));

export proc_compare_history_v1_and_v2_keys := 
parallel(out1,
			out1a,
			out2,
			out2a,
			out3,
			out3a,
			out4,
			out4a,
			out5,
			out5a,
			out6,
			out6a,
			out7,
			out7a,
			out8,
			out8a,
			out9,
			out9a,
			out10,
			out10a,
			out11,
			out11a,
			out12,
			out12a,
			out13,
			out13a,
			out14,
			out14a,
			out15,
			out15a,
			out16,
			out16a,
			out17,
			out17a,
			out18,
			out18a,
			out19,
			out19a,
			out20,
			out20a,
			out21,
			out21a,
			out22,
			out22a,
			out23,
			out23a,
			out24,
			out24a,
			out25,
			out25a,
			out26,
			out26a,
			out27,
			out27a,
			out28,
			out28a,
			out29,
			out29a,
			out30,
			out30a,
			out31,
			out31a,
			out32,
			out32a,
			out33,
			out33a,
			out34,
			out34a,
			out35,
			out35a,
			out36,
			out36a,
			out37,
			out37a,
			out38,
			out38a,
			out39,
			out39a,
			out40,
			out40a,
			out41,
			out41a,
			out42,
			out42a,
			out43,
			out43a,
			out44,
			out44a,
			out45,
			out45a,
			out46,
			out46a,
			out47,
			out47a,
			out48,
			out48a,
			out49,
			out49a,
			out50,
			out50a,
			out51,
			out51a,
			out52,
			out52a,
			out53,
			out53a,
			out54,
			out54a,
			out55,
			out55a,
			out56,
			out56a,
			out57,
			out57a,
			out58,
			out58a,
			out59,
			out59a,
			out60,
			out60a,
			out61,
			out61a,
			out62,
			out62a,
			out63,
			out63a,
			out64,
			out64a,
			out65,
			out66,
			out67,
			out68,
			out69,
			out70,
			out71,
			out72,
			out73,
			out73a,
			out74,
			out74a,
			out75,
			out75a,
			out76,
			out76a,
			out77,
			out77a,
			out78,
			out78a,
			out79,
			out79a,
			out80,
			out80a);