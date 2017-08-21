import ut, business_header,header;

redis := BA_dist;
srted := sort(redis,person1,person2,local);
grp := group(srted,person1,person2,local);

AreSameComp (unsigned6 bdid1, unsigned6 bdid2, integer zip1, integer zip2, 
					   integer pr1, integer pr2, string cname1, string cname2) := 
		bdid1 = bdid2 or
		(zip1 = zip2 and
		 (pr1 = pr2 or UT.StringSimilar100(cname1, cname2) < 10));

typeof(grp) rollDates(grp L, grp R) := transform
 self.number_cohabits := //if two diff company associations, add the score, else take the higher
		if(not AreSameComp(l.bdid, r.bdid, l.zip, r.zip, l.prim_range, r.prim_range, l.company_name, r.company_name),
		   l.number_cohabits + r.number_cohabits,
			 if(l.number_cohabits>r.number_cohabits,l.number_cohabits,r.number_cohabits));
 self.recent_cohabit := if(l.recent_cohabit > r.recent_cohabit, l.recent_cohabit, r.recent_cohabit);
 self := r;
end;

rlup := rollup(grp,true,rollDates(left,right));

header.Layout_relatives_v2.slim slimand4(rlup l) := transform
	self.prim_range := -4;
	self := l;
end;
	
rlup_slim := project(rlup, slimand4(left));

rlup_slim_5 := dedup(sort(join(rlup_slim , redis,left.person1=right.person1 and left.person2=right.person2,
                            transform({header.layout_relatives_v2.temp},self.bdid := right.bdid ,self:=left),local),person1,person2,-number_cohabits,local),person1,person2,bdid,local);

export Business_Associates := dedup(rlup_slim_5(number_cohabits > 6),person1,person2, keep 5,local)
	                          : persist(persistnames().BusinessAssociates);