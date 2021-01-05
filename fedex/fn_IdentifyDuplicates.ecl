//the function below establishes what fields constitute a unique record
//then from that determines the MAX dt_last_seen across it's duplicates
EXPORT fn_IdentifyDuplicates(dataset(recordof(FedEx.Layout_FedEx.Base)) in_ds) := function;

r1 := record
 in_ds.full_name;
 in_ds.company_name;
 in_ds.phone;
 in_ds.prim_range;
 in_ds.prim_name;
 in_ds.sec_range;
 in_ds.v_city_name;
 in_ds.st;
 in_ds.zip5;
 in_ds.zip6;
 in_ds.geo_lat;
 in_ds.geo_long;
 integer similar_recs_ct  := count(group);
 string8 max_dt_last_seen := max(group,in_ds.file_date);
 string  min_record_id    := min(group,in_ds.record_id);
end;

ta1 := table(in_ds,r1,full_name,company_name,phone,prim_range,prim_name,sec_range,v_city_name,st,zip5,zip6,geo_lat,geo_long);

r2 := record
 string  similar_recs_ct;
 string8 max_file_date; 
 string  parent_record_id;
 in_ds;
end;

//keeping the MIN record_id sticks with the similar concept of doing the same
//for the Header RID.  once we establish 2 records are the same then keep
//the earliest occurrence of it.
r2 x1(ta1 le,  in_ds ri) := transform
 self.similar_recs_ct  := (string)le.similar_recs_ct;
 self.max_file_date    := le.max_dt_last_seen;
 self.parent_record_id := le.min_record_id;
 self                  := ri;
end;

j1 := join(ta1,in_ds,
                left.full_name=right.full_name
						and left.company_name=right.company_name
						and left.phone=right.phone
						and left.prim_range=right.prim_range
						and left.prim_name=right.prim_name
						and left.sec_range=right.sec_range
						and left.v_city_name=right.v_city_name
						and left.st=right.st
						and left.zip5=right.zip5
						and left.zip6=right.zip6
						and left.geo_lat=right.geo_lat
						and left.geo_long=right.geo_long
						,x1(left,right),lookup);

return j1;

end;