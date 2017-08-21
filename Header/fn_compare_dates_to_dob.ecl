import _control;

//if the seen and/or vendor dates precede the MIN dob for the DID, blank them

export fn_compare_dates_to_dob(dataset(recordof(header.layout_header)) in_hdr) := function

hdr     := distribute(in_hdr,hash(did));
hdr_dob := hdr(dob>0);

r0 := record
 hdr_dob.did;
 typeof(hdr_dob.dob) min_dob := min(group,hdr_dob.dob);
end;

min_did_dob := table(hdr_dob,r0,did,local);

r1 := record
 hdr;
 min_did_dob.min_dob;
 boolean   fs;
 boolean   ls;
 boolean   vf;
 boolean   vl;
end;

r1 t1(hdr le, min_did_dob ri) := transform
 
 integer v_fs := le.dt_first_seen;
 integer v_ls := le.dt_last_seen;
 integer v_vf := le.dt_vendor_first_reported;
 integer v_vl := le.dt_vendor_last_reported;
 
 integer v_dob := (integer)((string)ri.min_dob)[1..6];

 self.fs := if(v_fs>0 and v_fs<v_dob,true,false);
 self.ls := if(v_ls>0 and v_ls<v_dob,true,false);
 self.vf := if(v_vf>0 and v_vf<v_dob,true,false);
 self.vl := if(v_vl>0 and v_vl<v_dob,true,false);
 
 self    := le;
 self    := ri;
end;

j1 := join(hdr,min_did_dob,left.did=right.did,t1(left,right),left outer,local);

//f1 := j1(fs=true or ls=true or vf=true or vl=true) : persist('persist::hdr_dates_precede_dob',_control.TargetQueue.adl_400);
//output(count(f1),named('recs_with_bad_dates'));

recordof(in_hdr) t2(j1 le) := transform

 unsigned3 v1 := if(le.fs=true,0,le.dt_first_seen);
 unsigned3 v2 := if(le.ls=true,0,le.dt_last_seen);
 unsigned3 v3 := if(le.vf=true,0,le.dt_vendor_first_reported);
 unsigned3 v4 := if(le.vl=true,0,le.dt_vendor_last_reported);
 
 self.dt_first_seen            := if(v1=0 or v2=0,0,v1);
 self.dt_last_seen             := if(v1=0 or v2=0,0,v2);
 self.dt_vendor_first_reported := if(v3=0 or v4=0,0,v3);
 self.dt_vendor_last_reported  := if(v3=0 or v4=0,0,v4);
 self                          := le;
end;

p1 := project(j1,t2(left));

return p1;

end;