import ut;

// Find the relatives/associates you can get by matching address 

h := header.File_Headers;

head_slim := record
	h.did;
	unsigned4 	first_seen;
	unsigned4 	last_seen;
	h.lname;
	h.prim_range; 			// ?5 bytes
	h.prim_name;
	h.sec_range; 			// ?
	h.zip; 					// udecimal5
	h.predir;
	h.postdir;
	integer8 	ufield;
	unsigned8 	lname_weight := 0;
end;

head_slim slim_down ( h l ) := transform
	self.did := l.DID;
	self.first_seen := get_header_first_seen(l);
	self.last_seen := get_header_last_seen(l);
	//pull out a number to use for prim_Range -- 
	//	   get it from prim name if necessary.
	self.ufield :=  hash(l.zip,l.sec_range,l.prim_name,l.prim_range); 
	// following doesn't make sense unless we do tough sec-range work
    // self.sec_range := if ( l.unit_desig <> '' and l.sec_range='','0',l.sec_range ); // Stop a match in the 'Apt ___' case
	self := l;
end;

hdrs := project(h(prim_name<>'',zip<>'',lname<>''),slim_down(left));

dh := distribute(hdrs,hash(prim_range,prim_name,zip));

head_slim rollem(dh l, dh r) := transform
	self.first_seen := ut.EarliestDate(l.first_seen, r.first_seen);
	self.last_seen := ut.LatestDate(l.last_seen, r.last_seen);
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

head_slim take_occup(head_slim le, occupancy_count ri) := transform
  self.lname_weight := ri.cnt;
  self := le;
  end;

hoc_d := distribute(header.Occupancy_Count,hash(prim_range,prim_name,zip));

j1 := join(rrdups,hoc_d,left.prim_range=right.prim_range and
                                     left.prim_name=right.prim_name and
                                     left.zip=right.zip and
                                     left.sec_range=right.sec_range,
                                     take_occup(left,right),local);

head_slim take_lnw(head_slim le, name_frequencies ri) := transform
  self.lname_weight := MAP( ri.percentage * le.lname_weight < 0.01 => 4,
                            ri.percentage * le.lname_weight < 0.1 => 3,
                            ri.percentage * le.lname_weight < 0.5 => 1, 0 );
  self := le;
  end;

j2 := join(j1,header.Name_Frequencies,left.lname=right.lname,take_lnw(left,right),skew(1));
//j3 := join(j1,header.Name_Frequencies(lname >= 'M'),left.lname=right.lname,take_lnw(left,right),hash);

head_slim2 := record
	j2.did;
	j2.first_seen;
	j2.last_seen;
	j2.lname;
	j2.prim_range; 			// ?5 bytes
	j2.prim_name; //Keep the prim_name, for Header.getSpecialRelPrim in Relatives_By_Address.
	unsigned4 addr4 := hash(j2.prim_range,j2.prim_name,j2.zip);
	//unsigned8 addr8 := hash64(j2.prim_range,j2.prim_name,j2.zip);
	j2.zip;
	j2.sec_range; 			// ?
	j2.predir;
	j2.postdir;
	j2.lname_weight;
end;

export Relative_Candidates := table(j2,head_slim2): persist('Relative_Candidates');