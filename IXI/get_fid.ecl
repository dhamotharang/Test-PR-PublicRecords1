import ln_propertyv2;

ln_prop_srch := ln_propertyv2.File_Search_DID(
                  vendor_source_flag in variables.vendor and
                  (prim_range<>'' or prim_name<>'') and
				  zip<>''                         and 
				  source_code[1]<>'S'             and 
				  source_code[2]= 'P'             and
				  fname<>'' and lname<>'');

r1 := record
 ln_prop_srch.ln_fares_id;
 ln_prop_srch.prim_range;
 ln_prop_srch.prim_name;
 ln_prop_srch.sec_range;
 ln_prop_srch.zip;
 unsigned8 aid;
end;

r1 t1(ln_prop_srch le) := transform
 self.aid := ixi.fn_address_hash(le.prim_range,le.prim_name,le.sec_range,le.zip);
 self     := le;
end;

p1        := project(ln_prop_srch,t1(left));
p1_dist   := distribute(p1,hash(ln_fares_id,aid));
p1_sort   := sort      (p1_dist,ln_fares_id,aid,local);
p1_dupd   := dedup     (p1_sort,ln_fares_id,aid,local);
p1_redist := distribute(p1_dupd,hash(aid));

r2 := record
 ixi.ixi_clean;
 p1_redist.ln_fares_id;
end;

r2 t2(ixi.ixi_clean le, p1_redist ri) := transform
 self := le;
 self := ri;
end;

ixi_clean_dupd := dedup(ixi.ixi_clean,aid,all,local);

j1 := join(ixi_clean_dupd,p1_redist,left.aid=right.aid,t2(left,right),local);
		  
export get_fid := j1 : persist('persist::ixi_get_fid'+variables.pst_suffix);