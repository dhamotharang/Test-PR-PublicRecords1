import ut;

export Relative_Candidates( 
	dataset(header.Layout_Header) hf
	):=
FUNCTION

// Find the relatives/associates you can get by matching address 

h 			:= hf(jflag2='');
d_ar   	:= header.address_recency(hf,36).recent_addresses;
hoc 		:= header.Occupancy_Count(hf);
hnf 		:= header.Name_Frequencies(hf);

h_dist    := distribute(h,hash(zip,prim_name,sec_range));
d_ar_dist := distribute(d_ar,hash(zip,prim_name,sec_range));

header.Layout_Header t_keep_recent(header.Layout_Header le, d_ar ri) := transform
 self := le;
end;

t_join := join(h_dist,d_ar_dist,
			   (ut.nneq(left.prim_range,right.prim_range) and
				left.prim_name = right.prim_name  and
				left.sec_range = right.sec_range  and
				left.zip       = right.zip
			   ),
			   t_keep_recent(left,right),
			   local
			  );

head_slim := record
	t_join.did;
	unsigned4 	first_seen;
	unsigned4 	last_seen;
	t_join.lname;
	t_join.prim_range; 				// ?5 bytes
	t_join.predir ; 
	t_join.prim_name;
	t_join.suffix;
	t_join.postdir; 
	t_join.unit_desig; 
	t_join.sec_range; 				// ?
	t_join.city_name;
	t_join.st; 
	t_join.zip; 					// udecimal5
	integer8 	ufield;
	unsigned8 	lname_weight := 0;
	
end;

head_slim slim_down ( t_join l ) := transform
	self.did := l.DID;
	self.first_seen := l.dt_first_seen ; 
	self.last_seen := l.dt_last_seen ; 
	//pull out a number to use for prim_Range -- 
	//	   get it from prim name if necessary.
	self.ufield :=  hash32(l.zip,l.sec_range,l.prim_name,l.prim_range); 
	// following doesn't make sense unless we do tough sec-range work
    // self.sec_range := if ( l.unit_desig <> '' and l.sec_range='','0',l.sec_range ); // Stop a match in the 'Apt ___' case
	self := l;
end;

hdrs := project(t_join(prim_name<>'',zip<>'',lname<>''),slim_down(left));

dh := distribute(hdrs,hash(prim_range,prim_name,zip));

head_slim rollem(dh l, dh r) := transform
	self.first_seen := ut.EarliestDate(l.first_seen, r.first_seen);
	self.last_seen := max(l.last_seen, r.last_seen);
	
	self.predir := 	if(r.predir 	> l.predir, 	r.predir, 	l.predir);
	self.postdir := if(r.postdir 	> l.postdir, 	r.postdir, 	l.postdir);
	
	self := l;
end;

rdups := rollup( 
             sort( dh,
                   prim_name,
                   zip,
                   prim_range, 
                   did, 
                   lname,
                   -sec_range, 
									 record,
                   local), 
              left.prim_name = right.prim_name and
              left.zip = right.zip and
              left.prim_range = right.prim_range and
              left.did=right.did and 
              left.lname=right.lname and
              ( left.sec_range=right.sec_range or
                right.sec_range='' ),
				rollem(left, right),
                local);

ut.mac_remove_withdups_local(rdups,ufield,500,rrdups)

head_slim take_occup(head_slim le, hoc ri) := transform
  self.lname_weight := ri.cnt;
  self := le;
  end;

hoc_d := distribute(hoc,hash(prim_range,prim_name,zip));

j1 := join(rrdups,hoc_d,left.prim_range=right.prim_range and
                                     left.prim_name=right.prim_name and
                                     left.zip=right.zip and
                                     left.sec_range=right.sec_range,
                                     take_occup(left,right),local);

head_slim take_lnw(head_slim le, hnf ri) := transform
  self.lname_weight := MAP( ri.percentage * le.lname_weight < 0.01 => 4,
                            ri.percentage * le.lname_weight < 0.1 => 3,
                            ri.percentage * le.lname_weight < 0.5 => 1, 0 );
  self := le;
  end;

j2 := join(j1,hnf,left.lname=right.lname,take_lnw(left,right),skew(1));
//j3 := join(j1,header.Name_Frequencies(lname >= 'M'),left.lname=right.lname,take_lnw(left,right),hash);

layout := record
	j2.did;
	j2.first_seen;
	j2.last_seen;
	j2.lname;
	j2.prim_range; 			// ?5 bytes
	j2.prim_name; //Keep the prim_name, for Header.getSpecialRelPrim in Relatives_By_Address.
	unsigned4 addr4 := hash32(j2.prim_range,j2.prim_name,j2.zip);
	//unsigned8 addr8 := hash64(j2.prim_range,j2.prim_name,j2.zip);
	j2.zip;
	j2.sec_range; 			// ?
	j2.predir;
	j2.postdir;
	j2.suffix;
	j2.unit_desig;
	j2.city_name;
	j2.st; 
	j2.lname_weight;
	
end;

records := table(j2,layout) : persist('Relative_candidates') ;
return records;

END;