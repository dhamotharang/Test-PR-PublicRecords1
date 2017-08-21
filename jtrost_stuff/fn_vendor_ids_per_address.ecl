import header;

export fn_vendor_ids_per_address(dataset(recordof(header.Layout_New_Records)) in_pp) := function

ds0 := in_pp((prim_range<>'' or prim_name<>'') and zip<>'');

ds  := ds0(rec_type='1');

r_slim := record
 ds.dt_last_seen;
 ds.vendor_id;
 ds.fname;
 ds.mname;
 ds.lname;
 ds.prim_range;
 ds.predir;
 ds.prim_name;
 ds.postdir;
 ds.suffix;
 ds.sec_range;
 ds.city_name;
 ds.st;
 ds.zip;
end;

r_slim t_slim(ds le) := transform
 self := le;
end;

ds_slim := dedup(project(ds,t_slim(left)),record);// : persist('jtrost_slim_temp');

rec := record
 integer vendor_ids_updated := 1;
 ds_slim;
end;

rec t1(ds_slim le) := transform
 self := le;
end;

ds2 := sort(project(ds_slim,t1(left)),dt_last_seen,prim_range,predir,prim_name,postdir,sec_range,city_name,st,zip);

rec t_rollup(ds2 le, ds2 ri) := transform 
 self.vendor_ids_updated := le.vendor_ids_updated+1;
 self                    := le;
end;

rollup_ := rollup(ds2,t_rollup(left,right),
                  left.dt_last_seen=right.dt_last_seen and
				  left.prim_range=right.prim_range and
				  left.predir=right.predir and
				  left.prim_name=right.prim_name and
				  left.postdir=right.postdir and
				  left.suffix=right.suffix and
				  left.sec_range=right.sec_range and
				  left.city_name=right.city_name and
				  left.st=right.st and
				  left.zip=right.zip
				  );// : persist('jtrost_rollup_temp');

r_slim2 := record
 rollup_.vendor_ids_updated;
 rollup_.dt_last_seen;
 rollup_.prim_range;
 rollup_.predir;
 rollup_.prim_name;
 rollup_.postdir;
 rollup_.suffix;
 rollup_.sec_range;
 rollup_.city_name;
 rollup_.st;
 rollup_.zip;
end;

slim_rollup := table(rollup_,r_slim2);

return slim_rollup;

end;

/*
filt1 := ds0(trim(prim_range)='5005' and trim(prim_name)='ROOSEVELT' and zip='33021');
filt2 := ds(trim(prim_range)='5005' and trim(prim_name)='ROOSEVELT' and zip='33021');
filt3 := slim_rollup(trim(prim_range)='5005' and trim(prim_name)='ROOSEVELT' and zip='33021');
filt4 := ds0(trim(fname)='PAUL' and trim(lname)='AVELLA' and st='FL');

output(filt1,named('all_people_at_5005_roosevelt')); 
output(filt2,named('current_people_at_5005_roosevelt'));
output(filt3,named('rolled_up_count_at_5005_roosevelt'));
output(filt4,named('all_paul_avellas_in_fl'));

stat1 := record
 slim_rollup.vendor_ids_updated;
 count_ := count(group);
end;

table1 := sort(distribute(table(slim_rollup,stat1,vendor_ids_updated,few),hash(vendor_ids_updated)),vendor_ids_updated,local);
output(sort(table1,vendor_ids_updated),all);
*/