import header,business_header;

bus_hdr := business_header.File_Business_Header(prim_range<>'' and prim_name<>'' and zip>0);
hdr     := header.file_headers(/*src='EQ' and*/ prim_range<>'' and prim_name<>'' and zip<>'');

r1 := record
 bus_hdr.bdid;
 string10 prim_range;
 string28 prim_name;
 string5  zip;
 integer  bdid_addr_cnt;
end;

r2 := record
 hdr.did;
 string10 prim_range;
 string28 prim_name;
 string5  zip;
 integer  did_addr_cnt;
end;

r1 t1(bus_hdr le) := transform
 self.zip           := (string)le.zip;
 self.bdid_addr_cnt := 1;
 self               := le;
end;

r2 t2(hdr le) := transform
 self.did_addr_cnt := 1;
 self              := le;
end;

p1 := project(bus_hdr,t1(left));
p2 := project(hdr,    t2(left));

p1_dist := distribute(p1,hash(prim_range,prim_name,zip));
p1_sort := sort (p1_dist,prim_range,prim_name,zip,bdid,local);
p1_dupd := dedup(p1_sort,prim_range,prim_name,zip,bdid,local);

p2_dist := distribute(p2,hash(prim_range,prim_name,zip));
p2_sort := sort (p2_dist,prim_range,prim_name,zip,did,local);
p2_dupd := dedup(p2_sort,prim_range,prim_name,zip,did,local);

r1 t3(r1 le, r1 ri) := transform
 self.bdid_addr_cnt := le.bdid_addr_cnt+1;
 self               := le;
end;

r2 t4(r2 le, r2 ri) := transform
 self.did_addr_cnt := le.did_addr_cnt+1;
 self              := le;
end;

p3 := rollup(p1_dupd,left.prim_range=right.prim_range and left.prim_name=right.prim_name and left.zip=right.zip,t3(left,right),local);
p4 := rollup(p2_dupd,left.prim_range=right.prim_range and left.prim_name=right.prim_name and left.zip=right.zip,t4(left,right),local);

r3 := record
 string10 prim_range;
 string28 prim_name;
 string5  zip;
 integer  bdid_cnt;
 integer  did_cnt;
end;

r3 t5(r1 le, r2 ri) := transform
 self.bdid_cnt := le.bdid_addr_cnt;
 self.did_cnt  := ri.did_addr_cnt;
 self          := le;
end;

j1 := join(p3,p4,left.prim_range=right.prim_range and left.prim_name=right.prim_name and left.zip=right.zip,t5(left,right),local);

f1 := j1(bdid_cnt>50 and did_cnt>1000);

export DID_and_BDID_counts_per_address := output(sort(f1,-did_cnt,-bdid_cnt));