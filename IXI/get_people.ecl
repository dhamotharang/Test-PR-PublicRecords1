//gets full history of property owners for the provided ixi addresses
import ln_propertyv2;

ln_fid            := distribute(ixi.get_fid,hash(ln_fares_id));
ln_prop_srch      := ln_propertyv2.File_Search_DID(vendor_source_flag in variables.vendor and zip<>'' and source_code[1]<>'S' and fname<>'' and lname<>'' and did>0);
ln_prop_srch_dist := distribute(ln_prop_srch,hash(ln_fares_id));

r1 := record
 ln_fid.aid;
 ln_fid.ln_fares_id;
 ln_prop_srch_dist.did;
 ln_prop_srch_dist.fname;
 ln_prop_srch_dist.mname;
 ln_prop_srch_dist.lname;
 ln_prop_srch_dist.name_suffix;
end;

r1 t1(ln_prop_srch_dist le, ln_fid ri) := transform
 self := le;
 self := ri;
end;

j1        := join(ln_prop_srch_dist,ln_fid,left.ln_fares_id=right.ln_fares_id,t1(left,right),local);
j1_dist   := distribute(j1,hash(aid,ln_fares_id,did,fname,mname,lname,name_suffix));
j1_sort   := sort      (j1_dist,aid,ln_fares_id,did,fname,mname,lname,name_suffix,local);
j1_dupd   := dedup     (j1_sort,aid,ln_fares_id,did,fname,mname,lname,name_suffix,local) ;

export get_people := j1_dupd : persist('persist::ixi_get_people'+variables.pst_suffix);