import ut,header,header_quick;

export fn_preprocess(boolean pFastHeader=true) := function

pp_month  := header.preprocess(pFastHeader);
pp_weekly := header.preprocess_weekly;
pp_other_srcs := header.preProcess_other_srcs;

ds_monthly_dist := distribute(pp_month, hash(vendor_id,fname,mname,lname,prim_range,prim_name,sec_range,zip,ssn));
ds_weekly_dist  := distribute(header_quick.set_weekly_ind(pp_weekly),hash(vendor_id,fname,mname,lname,prim_range,prim_name,sec_range,zip,ssn));

header.layout_new_records j1(header.layout_new_records le, header.layout_new_records ri) := transform
 self := le;
end;

ds_only_in_weekly := join(ds_weekly_dist,ds_monthly_dist,
                          left.vendor_id =right.vendor_id  and
                          left.fname     =right.fname      and
					      left.mname     =right.mname      and
					      left.lname     =right.lname      and
					      left.prim_range=right.prim_range and
					      left.prim_name =right.prim_name  and
					      left.sec_range =right.sec_range  and
					      left.zip       =right.zip        and
					      ut.NNEQ(left.ssn,right.ssn),
					      j1(left,right),
					      left only, local
					     );

concat0 := pp_month+ds_only_in_weekly+pp_other_srcs;

recordof(concat0) t1(concat0 le) := transform
 self.ssn := if(le.ssn in ut.set_badssn,'',le.ssn);
 self     := le;
end;

concat := project(concat0,t1(left)) : persist('~thor_data400::persist::header_preprocess_join_to_weekly');

output(count(pp_month),         named('monthly_count'));
output(count(ds_only_in_weekly),named('only_in_weekly_count'));
output(count(concat),           named('cumulative'));

return concat;

end;