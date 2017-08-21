//export property_spouses := 'todo';

ds_a := ln_propertyv2.File_Assessment;
ds_d := ln_propertyv2.File_Deed;
ds_s := dedup(sort(distribute(ln_propertyv2.File_Search_DID(did>0 and which_orig in ['','1','2']),hash(ln_fares_id)),ln_fares_id,did,local),ln_fares_id,did,local);

r1 := record
 string12  ln_fares_id;
 unsigned6 did1            :=0;
 unsigned6 did2            :=0;
 boolean   is_hus_wife     :=false;
 boolean   is_hus_wife_curr:=false;
 boolean   is_bro_sis      :=false; //no is_curr for brother & sister
end;

r1 x1(ds_a le) := transform
 self.is_hus_wife := le.assessee_ownership_rights_code='HW'
                  or le.assessee_relationship_code='HW'
				  or le.assessee_relationship_code='HH';
 self.is_hus_wife_curr := self.is_hus_wife and le.current_record='Y';
 self.is_bro_sis       := le.assessee_relationship_code='BS';
 self := le;
end;

r1 x2(ds_d le) := transform
 self.is_hus_wife := le.name1_id_code='HW'
                  or le.name1_id_code='HH'
				  or le.name2_id_code='HW'
				  or le.name2_id_code='HH';
 self.is_hus_wife_curr := self.is_hus_wife and le.current_record='Y';				  
 self := le;
end;

p1     := project(ds_a,x1(left));
p2     := project(ds_d,x2(left));
concat := distribute((p1+p2)(is_hus_wife or is_bro_sis),hash(ln_fares_id));

r2 := record
 ds_s;
 integer   dids_per_fid:=1;
 unsigned6 did1:=0;
 unsigned6 did2:=0;
end;

p3 := project(ds_s,r2);

r2 x3(p3 le, p3 ri) := transform
 self.dids_per_fid := le.dids_per_fid+1;
 self.did1         := ut.max2(le.did,ri.did);
 self.did2         := ut.min2(le.did,ri.did);
 self              := le;
end;

p4 := rollup(p3,left.ln_fares_id=right.ln_fares_id,x3(left,right),local);
//exclude cases where the fid has only 1 or more than 2 DIDs
//tieing the search record to exact field (name1, name2) in the main file, while it does exist,
//is somewhat recent and is applicable to only a small percentage of the file.
f1 := distribute(p4(dids_per_fid=2),hash(ln_fares_id));

r1 x5(concat le, f1 ri) := transform
 self.did1 := ri.did1;
 self.did2 := ri.did2;
 self         := le;
end;

j2 := join(concat,f1,left.ln_fares_id=right.ln_fares_id,x5(left,right),local) : persist('persist::prop_rels');

hw := distribute(j2(is_hus_wife),hash(did1,did2));
bs := dedup(j2(is_bro_sis),did1,did2,all);

r1 x6(hw le, hw ri) := transform
 self.ln_fares_id      := if(le.is_hus_wife_curr,le.ln_fares_id,ri.ln_fares_id);
 self.is_hus_wife_curr := if(le.is_hus_wife_curr,le.is_hus_wife_curr,ri.is_hus_wife_curr);
 self                  := le;
end;

hw_rold := rollup(hw,left.did1=right.did1 and left.did2=right.did2,x6(left,right),local);

count(hw_rold);
output(hw_rold);
count(bs);
output(bs);

r3 := record
 hw_rold.is_hus_wife;
 hw_rold.is_hus_wife_curr;
 count_ := count(group);
end;

ta1 := table(hw_rold,r3,is_hus_wife,is_hus_wife_curr,few);
output(ta1);

concat2 := hw_rold+bs;
output(concat2,,'~thor_data400::out::property_spouses',__compressed__);