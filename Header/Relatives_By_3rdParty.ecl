export Relatives_By_3rdParty (dataset(header.layout_relatives_v2.main) f) :=
FUNCTION

slim_l := record
 unsigned6 person1;
 unsigned6 person2;
 integer   number_cohabits;
end;

rel_f := project(f, slim_l);

//Get high associations from relative file
strong_assoc := rel_f(number_cohabits >= 6);

//Get possible candidate pairs that could be put above threhold (greater than 5) by 3rd party high associations
weak_assoc := rel_f(number_cohabits between 3 and 5);

two_pair_l := record
 unsigned6 person1;
 unsigned6 person2;
 unsigned6 person1b;
 unsigned6 person2b;
 integer   number_cohabitsb;
end;

//Get all pairs related to the high associations pairs
get_p1_pairs_p1 := join(distribute(strong_assoc, hash(person1)),
												distribute(weak_assoc, hash(person1)),
												left.person1 = right.person1,
												transform(two_pair_l, 
																	self.person1b := right.person1,
																	self.person2b := right.person2,
																	self.number_cohabitsb := right.number_cohabits,
																	self := left),
												local);
												

get_p1_pairs_p2 := join(distribute(strong_assoc, hash(person1)),
												distribute(weak_assoc, hash(person2)),
												left.person1 = right.person2,
												transform(two_pair_l, 
																	self.person1b := right.person2,
																	self.person2b := right.person1,
																	self.number_cohabitsb := right.number_cohabits,
																	self := left),
												local);
												

get_p2_pairs_p1 := join(distribute(strong_assoc, hash(person2)),
												distribute(weak_assoc, hash(person1)),
												left.person2 = right.person1,
												transform(two_pair_l, 
																	self.person1b := right.person1,
																	self.person2b := right.person2,
																	self.number_cohabitsb := right.number_cohabits,
																	self := left),
												local);
												
	
get_p2_pairs_p2 := join(distribute(strong_assoc, hash(person2)),
												distribute(weak_assoc, hash(person2)),
												left.person2 = right.person2,
												transform(two_pair_l, 
																	self.person1b := right.person2,
																	self.person2b := right.person1,
																	self.number_cohabitsb := right.number_cohabits,
																	self := left),
												local);	

all_comb := get_p1_pairs_p1  + get_p1_pairs_p2 + get_p2_pairs_p1 + get_p2_pairs_p2;

all_comb_ded := dedup(sort(distribute(all_comb, hash(person1, person2, person1b, person2b)),person1, person2, person1b, person2b, local),person1, person2, person1b, person2b, local);


//Aggregate high association pairs and person2 that the pair may have in common
tbl:= table(all_comb_ded, {person1, person2, person2b, cnt := count(group)}, person1, person2, person2b);


//normalize the pairs that have a 3rd person in common (tbl cnt > 1), dd 3 points can be added to the 3rd party association
pair_ly := record
 unsigned6 person1;
 unsigned6 person2;
end;

pair_ly t_pairs(tbl le,unsigned1 cnt) := transform
  self.person1 := IF(cnt=1,le.person1,le.person2);
  self.person2 := le.person2b;
  end;

norm_pairs := normalize(tbl(cnt > 1),2, t_pairs(left,counter));


pair_ly swap2(norm_pairs le) := transform
 self.person1 := le.person2;
 self.person2 := le.person1;
 self         := le;
end;

// All pair to wich 3 points should be added due to 3rd party associations
all_add_3 := dedup(sort(distribute(project(norm_pairs,swap2(left)) + norm_pairs, hash(person1, person2)),person1, person2, local),person1, person2, local);


Add_points := join(distribute(header.file_relatives, hash(person1, person2)),
									 distribute(all_add_3, hash(person1, person2)),
									 left.person1 = right.person1 and
									 left.person2 = right.person2,
									 transform(recordof(header.layout_relatives_v2.main),
														 self.number_cohabits := if(left.person1 = right.person1 and
																												left.person2 = right.person2,
																												left.number_cohabits + 3,
																												left.number_cohabits),		
														self.prim_range := if(left.person1 = right.person1 and
																												left.person2 = right.person2,
																												-8,
																												left.prim_range);
														 self := left),
									 left outer,
									 local);
		
return Add_points;
end;