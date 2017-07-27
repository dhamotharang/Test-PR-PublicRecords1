export fn_remove_old_records(dataset(recordof(header.Layout_Header)) in_hdr) := 
function

rm_score := distribute(in_hdr,hash(did));

r1 := record
 rm_score.did;
 rm_score.prim_range;
 rm_score.prim_name;
 rm_score.sec_range;
 rm_score.zip;
 integer   nbr_of_addr   := 1;
 unsigned3 max_last_seen := max(group,rm_score.dt_last_seen);
end;

t1 := table(rm_score,r1,did,prim_range,prim_name,sec_range,zip,local);

r1 t_rollup(r1 le, r1 ri) := transform
 self.nbr_of_addr := le.nbr_of_addr+1;
 self             := le;
end;

roll_em := rollup(t1,left.did=right.did,t_rollup(left,right),local);

//gt_100 count is small enough so that we can use it in a lookup join - no need to distribute
gt_100 := roll_em(nbr_of_addr>=100);
lt_100 := roll_em(nbr_of_addr< 100);

r1 t_j1(t1 le, gt_100 ri) := transform
 self := le;
end;

//This returns all the addresses for DID's having more than 100 addresses - we'll restrict to 100 later
j1 := join(t1,gt_100,
           left.did=right.did,
		   t_j1(left,right),
		   lookup
		  );

j1_sort := sort(j1,did,-max_last_seen,local);
j1_dupd := dedup(j1_sort,did,keep(100),local);

header.Layout_Header t_j2(header.Layout_Header le, r1 ri) := transform
 self := le;
end;

//Returns records of all DID's having less than 100 addresses
j2_a := join(rm_score,lt_100,
           left.did=right.did,
		   t_j2(left,right),
		   local
		  );

/*This returns all records of DID's having addresses within the most recent 100 threshold*/
j2_b := join(rm_score,j1_dupd,
           left.did        = right.did        and 
		   left.prim_range = right.prim_range and 
		   left.prim_name  = right.prim_name  and 
		   left.sec_range  = right.sec_range  and
		   left.zip        = right.zip,
		   t_j2(left,right),
		   local
		  );
		  
concat := j2_a+j2_b;

return concat;

end;