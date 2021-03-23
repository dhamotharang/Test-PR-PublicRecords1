import Header, MDR, STD;

// Total Lexid	 	457.5M 

hdr := Header.File_Headers;
hdr_filtered := hdr(src <> 'EN' and ~MDR.Source_is_DPPA(src)); 
output(count(hdr_filtered), named('hdr_filtered')); //9,253,422,710

seg := pull(Header.key_ADL_segmentation);
hdr_w_seg := join(distribute(hdr_filtered, hash(did)), distribute(seg, hash(did)), left.did = right.did, local);
hdr_seg_filtered := hdr_w_seg(ind1 in ['CORE', 'C_MERGE', 'DEAD']); 

output(count(hdr_seg_filtered), named('hdr_seg_filtered')); //7,775,831,559

threshold_ := 24;// 2 years data for names and address

hdr0 := DISTRIBUTE(hdr_seg_filtered,HASH(prim_range,prim_name,sec_range,zip));
rec := record
 hdr0.prim_range;
 hdr0.prim_name;
 hdr0.sec_range;
 hdr0.zip;
 unsigned3 max_dt_last_seen := max(group, hdr0.dt_last_seen);
end;

all_addresses := table(hdr0,rec,prim_range,prim_name,sec_range,zip,local);
keep_last_2_yrs := all_addresses(
                max_dt_last_seen=0
				or
                (STD.Date.MonthsBetween((integer)((string)max_dt_last_seen + '00'), Std.Date.Today()) <= threshold_)
			   );

//output(count(keep_last_2_yrs), named('last_2_yrs_uniq_address_cnt')); //204,400,521

dkeep_last_2_yrs := DISTRIBUTE(keep_last_2_yrs(prim_range = '16501' and prim_name = 'SHERMAN'),HASH(prim_range,prim_name,sec_range,zip));		   
dHdr_last_2_yrs := DISTRIBUTE(JOIN(hdr0(did = 6614),dkeep_last_2_yrs,LEFT.prim_range=RIGHT.prim_range AND LEFT.prim_name=RIGHT.prim_name AND LEFT.sec_range=RIGHT.sec_range AND LEFT.zip=RIGHT.zip,TRANSFORM(recordof(LEFT),SELF:=LEFT;),LOCAL),HASH(did));
dHdr_last_2_yrs_w_uniq_addr := DEDUP(SORT(dHdr_last_2_yrs, did, -dt_last_seen, LOCAL), did, prim_range,prim_name,sec_range,zip, all);

//dkeep_last_2_yrs;
// hdr0(did = 6614 and prim_range = '16501' and prim_name = 'SHERMAN');
// dHdr_last_2_yrs(did = 6614);
dHdr_last_2_yrs;
// dHdr_last_2_yrs_w_uniq_addr(did = 6614);

// output(count(dHdr_last_2_yrs_w_uniq_addr), named('dHdr_last_2_yrs_w_uniq_addr')); //6,700,322,038

dGrouped:=GROUP(dHdr_last_2_yrs_w_uniq_addr(did = 6614),did,LOCAL);
// dGrouped;

Address := distribute(PROJECT(dGrouped,TRANSFORM($.layouts.rAddress,SELF.LexId := LEFT.did, SELF.addr_ind:=if(COUNTER=1, 'C', 'F');SELF:=LEFT;)), hash(LexId));
// output(Address, named('Address_sample'));

// output(count(dedup(Address, LexId, all)), named('Final_Lexid_cnt'));  //452,316,051
t := table(Address, {LexId, addr_ind, cnt := count(group)}, LexId, addr_ind);

// output(sort(t, -cnt), named('Address_cnt_by_lexid'));
// output(t(addr_ind = 'C' and cnt > 1), named('current_address_cnt'));




