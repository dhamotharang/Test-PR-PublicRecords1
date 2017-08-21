import header,ut;

hdr := project(header.File_Headers(src in ['EQ','WP']),header.layout_header_strings);
 
r1 := record
 hdr.did;
 hdr.prim_range;
 hdr.prim_name;
 hdr.sec_range;
 hdr.zip;
 boolean src_is_eq;
 boolean src_is_wp;
 integer eq_dt_last_seen;
 integer wp_dt_last_seen;
end;

r1 t1(hdr le) := transform
 self.src_is_eq       := if(le.src='EQ',true,false);
 self.src_is_wp       := if(le.src='WP',true,false);
 self.eq_dt_last_seen := if(self.src_is_eq=true,le.dt_last_seen,0);
 self.wp_dt_last_seen := if(self.src_is_wp=true,le.dt_last_seen,0);
 self                 := le;
end;

p1      := project(hdr,t1(left));
p1_dist := distribute(p1,hash(did));
p1_sort := sort(p1_dist,did,prim_range,prim_name,sec_range,zip,local);

r1 t2(p1_sort le, p1_sort ri) := transform
 self.src_is_eq       := if(le.src_is_eq=true,le.src_is_eq,ri.src_is_eq);
 self.src_is_wp       := if(le.src_is_wp=true,le.src_is_wp,ri.src_is_wp);
 self.eq_dt_last_seen := ut.max2(le.eq_dt_last_seen,ri.eq_dt_last_seen);
 self.wp_dt_last_seen := ut.max2(le.wp_dt_last_seen,ri.wp_dt_last_seen);
 self                 := le;
end;

p2 := rollup(p1_sort,left.did=right.did
                 and left.prim_range=right.prim_range
				 and left.prim_name =right.prim_name
				 and left.sec_range =right.sec_range
				 and left.zip       =right.zip,
				 t2(left,right),local);

p2_filt := p2(src_is_eq=true and src_is_wp=true);

r2 := record
 p2_filt;
 integer eq_mos;
 integer wp_mos;
 integer mos_diff;
end;

r2 t3(p2_filt le) := transform
 self.eq_mos   := header.ConvertYYYYMMToNumberOfMonths(le.eq_dt_last_seen);
 self.wp_mos   := header.ConvertYYYYMMToNumberOfMonths(le.wp_dt_last_seen);
 self.mos_diff := self.eq_mos-self.wp_mos;
 self          := le;
end;

p3 := project(p2_filt,t3(left));

//wp has a later date
p3_filt := p3(mos_diff<0 and wp_dt_last_seen>200800);

r3 := record
 p3_filt.mos_diff;
 count_ := count(group);
end;

ta1 := sort(table(p3_filt,r3,mos_diff,few),-mos_diff);

did_set := [
890193360,
890411078
];

count(p3);
count(p3(eq_dt_last_seen>wp_dt_last_seen));
count(p3(eq_dt_last_seen<wp_dt_last_seen));
output(p3(did in did_set));

export header_eq_wp_date_compare := output(ta1,all);