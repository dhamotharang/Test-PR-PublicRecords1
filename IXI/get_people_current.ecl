import ln_propertyv2;

//gets people on tax and deed records where current_record='Y'
//OA0145017846 and OA0145017845 -> gave current owners on separate records
ixi_people                := ixi.get_people;
ixi_people_dist_fid       := distribute(ixi.get_people,hash(ln_fares_id));
ixi_people_dist_aid_lname := distribute(ixi.get_people,hash(aid,lname));

curr_tax_recs  := distribute(ixi.get_tax (current_record='Y'),hash(ln_fares_id));
curr_deed_recs := distribute(ixi.get_deed(current_record='Y'),hash(ln_fares_id));

r1 := record
 ixi_people;
 boolean did_on_curr_tax;
end;

r1 t1(ixi_people_dist_fid le, curr_tax_recs ri) := transform
 self.did_on_curr_tax := if(le.ln_fares_id=ri.ln_fares_id,true,false);
 self                 := le;
end;

j1 := join(ixi_people_dist_fid,curr_tax_recs,left.ln_fares_id=right.ln_fares_id,t1(left,right),left outer,local);

r2 := record
 j1;
 boolean did_on_curr_deed;
end; 

r2 t2(j1 le, curr_deed_recs ri) := transform
 self.did_on_curr_deed := if(le.ln_fares_id=ri.ln_fares_id,true,false);
 self                  := le;
end;

j2 := join(j1,curr_deed_recs,left.ln_fares_id=right.ln_fares_id,t2(left,right),left outer,local);

//just care about finding other deed records? if so, remove tax condition
curr_people := distribute(j2(did_on_curr_tax=true or did_on_curr_deed=true),hash(did));

//bring in other people with the same aid and lname
curr_people_redist := distribute(curr_people,hash(aid,lname));

r2 t3(ixi_people_dist_aid_lname le, curr_people_redist ri) := transform
 self.did_on_curr_tax :=false;
 self.did_on_curr_deed:=false;
 self                 :=le;
end;

bring_in_others := join(ixi_people_dist_aid_lname,curr_people_redist,left.aid=right.aid and left.lname=right.lname and left.did<>right.did,t3(left,right),local);

concat := distribute(curr_people+bring_in_others,hash(aid,did));

ixi_people2 := dedup(sort(distribute(ixi.ixi_clean(pid>0),hash(aid,pid)),pid,local),pid,local);

r3 := record
 concat;
 boolean person_on_ixi_record;
end;

r3 t_in_ixi(concat le, ixi_people2 ri) := transform
 self.person_on_ixi_record := if(le.aid=ri.aid and le.did=ri.pid,true,false);
 self := le;
end;

j3 := join(concat,ixi_people2,left.aid=right.aid and left.did=right.pid,t_in_ixi(left,right),left outer,local);

//remove people who've appeared as a seller on the same property
//removed vendor condition - fares has seller transactions not in fidelity
ln_prop_srch := ln_propertyv2.File_Search_DID(
				  (prim_range<>'' or prim_name<>'')      and
				  zip<>''                                and 
				  source_code[1]='S'                     and 
				  source_code[2]='P'                     and
				  did>0);

r4 := record
 ln_prop_srch.did;
 unsigned8 aid;
end;

r4 t4(ln_prop_srch le) := transform
 self.aid := ixi.fn_address_hash(le.prim_range,le.prim_name,le.sec_range,le.zip);
 self     := le;
end;

p1        := project   (ln_prop_srch,t4(left));
p1_dist   := distribute(p1,hash(aid,did));
p1_sort   := sort      (p1_dist,aid,did,local);
p1_dupd   := dedup     (p1_sort,aid,did,local);

r3 t_drop_sellers(j3 le, p1_dupd ri) := transform
 self := le;
end;

j4 := join(j3,p1_dupd,left.aid=right.aid and left.did=right.did,t_drop_sellers(left,right),left only,local);

export get_people_current := dedup(j4,record,all) : persist('persist::ixi_get_people_current'+variables.pst_suffix);