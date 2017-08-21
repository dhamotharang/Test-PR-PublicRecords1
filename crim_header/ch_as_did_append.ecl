
ch:=crim_header.file_crim_header(vendor in crim_header.did_vendors_p1 or crim_header.did_vendors_p1=['']);

ch_d := distribute(ch,hash(cdl));
ch_do := distribute(ch,hash(offender_key));
//
//ch_d_ttl := count(ch_d);
//ch_d_cdls := count(dedup(sort(ch_d,cdl,local),cdl,local));
//ch_do_offender_keys := count(dedup(sort(ch_do,offender_key,local),offender_key,local));
//
//output(ch_d_ttl,named('Total_crim_header_records'));
//output(ch_do_offender_keys,named('Total_crim_header_offender_keys'));
//output(ch_d_cdls,named('Total_crim_header_CDLs'));
//
ch_d_d1 := dedup(sort(ch_d(did<>0),cdl,did,local),cdl,did,local);
ch_d_t1 := TABLE(ch_d_d1,{cdl,ttl_dids := COUNT(GROUP)},cdl,local);
//t1_did1:=count(ch_d_t1(ttl_dids=1));
//t1_did2:=count(ch_d_t1(ttl_dids=2));
//t1_did3:=count(ch_d_t1(ttl_dids=3));
//t1_did4:=count(ch_d_t1(ttl_dids=4));
//t1_did5:=count(ch_d_t1(ttl_dids=5));
//t1_didx:=count(ch_d_t1(ttl_dids>5));
//
//output(t1_did1,named('CDLs_with_1_dids'));
//output(t1_did2,named('CDLs_with_2_dids'));
//output(t1_did3,named('CDLs_with_3_dids'));
//output(t1_did4,named('CDLs_with_4_dids'));
//output(t1_did5,named('CDLs_with_5_dids'));
//output(t1_didx,named('CDLs_with_GT5_dids'));
//
crim_header.layout_crim_header to_ch_matchset(ch_d l,ch_d_t1 r) := transform
self := l;
end;
ch_matchset_d := join(ch_d,ch_d_t1(ttl_dids=1),left.cdl=right.cdl, to_ch_matchset(left,right),local);
//ch_matchset_d_ttl :=count(ch_matchset_d);
//output(ch_matchset_d_ttl,named('Total_crim_header_append_candidates'));
crim_header.layout_crim_header to_fill_did(ch_matchset_d l,ch_matchset_d r) := transform
self.did := if(r.did=0,l.did,r.did);
self := r;
end;
ch_matchset_use_do:= distribute(iterate(sort(ch_matchset_d,cdl,-did),to_fill_did(left,right),local),hash(offender_key));
//
export ch_as_did_append := ch_matchset_use_do :  persist ('~thor_data400::persist::crim_header::ch_as_did_append');
