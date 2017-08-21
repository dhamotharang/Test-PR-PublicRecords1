import header;

ds := header.File_Headers(dt_last_seen<>0,prim_range<>'',prim_name<>'',zip<>'');

slim_rec := record
 unsigned6 did;
 string10  prim_range;
 string28  prim_name;
 string8   sec_range;
 string5   zip;
 unsigned3 dt_first_seen;
 unsigned3 dt_last_seen;
end;

slim_rec t_slim(ds l) := transform
 self := l;
end;

d_slim := project(ds,t_slim(left));

rec := record
 d_slim.did;
 d_slim.prim_range;
 d_slim.prim_name;
 d_slim.sec_range;
 d_slim.zip;
 unsigned3 min_dt_first_seen := min(group,d_slim.dt_first_seen);
 unsigned3 max_dt_last_seen  := max(group,d_slim.dt_last_seen);
end;

t_out      := distribute(table(d_slim,rec,did,prim_range,prim_name,sec_range,zip),hash(did));
t_out_sort := sort (t_out,                did,-max_dt_last_seen,local);
t_out_dupd := dedup(t_out_sort,           did,keep(1),local);

rec2 := record
 rec;
 string1 current_ind;
end;

rec2 t1(rec l, rec r) := transform
 
 boolean has_right_rec := r.did;
 
 self.current_ind := if(has_right_rec,'C','H');
 self             := l;
end;

//Change in Join to handle cases where there is more than 1 address with the same max_dt_last_seen
//Changed Join to include all addresses within 2 months of the "current" address
//(i.e. all addresses within 2 months of the "current" address are assumed to be current
j1 := join(t_out_sort,t_out_dupd,
           (left.did              = right.did and
		   (((unsigned2)(left.max_dt_last_seen[1..4])*12) + ((unsigned2)(left.max_dt_last_seen[5..6])))>=(((unsigned2)(right.max_dt_last_seen[1..4])*12) + ((unsigned2)(right.max_dt_last_seen[5..6])))-2
		    //left.max_dt_last_seen = right.max_dt_last_seen
			//left.prim_range=right.prim_range and
		    //left.prim_name=right.prim_name and
		    //left.sec_range=right.sec_range and
		    //left.zip=right.zip
		   ),
		   t1(left,right),
		   left outer,
		   local
		  );

export Find_Current_Address := distribute(j1,hash(did,prim_range,prim_name,sec_range,zip));
