import ut, business_header;

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

header.Layout_relatives slimand4(rlup l) := transform
	self.prim_range := -4;
	self := l;
end;
	
rlup_slim := project(rlup, slimand4(left));

export Business_Associates := rlup_slim(number_cohabits > 6)
	: persist('persist::business_associates');