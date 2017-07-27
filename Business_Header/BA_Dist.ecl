import ut,header;

c := business_header.File_Business_Contacts_Stats(did<>0,bdid<>0,combined_score>50);
relrec := header.Layout_relatives;
cmi := record
  c.bdid;
  c.did;
  c.combined_score;
  c.company_zip;
  prim_range := (unsigned2)c.company_prim_range;
	c.company_name;
  c.lname;
  c.company_title;
  dt_first_seen := c.dt_first_seen div 100;
  dt_last_seen := c.dt_last_seen div 100;
  end;

associates_init_dist := distribute(table(c,cmi),hash(bdid));

associates_init_dedup := dedup(sort(associates_init_dist,bdid,did,-combined_score,local),bdid,did,local);

ut.MAC_Remove_Withdups_Local(associates_init_dedup,bdid,500,associates_init_reduced)

temprec := record
	relrec;
	unsigned6 bdid;
	c.company_name;
end;

temprec by_company(cmi lef, cmi rig) := transform
  self.person1 := lef.did;
  self.person2 := rig.did;
		//if there was a known overlap in their time at the same comp., 6, else 3
  self.number_cohabits := 
						 if(rig.dt_last_seen>0 and lef.dt_last_seen > 0 and rig.dt_first_seen > 0 and lef.dt_first_seen > 0 and
								((rig.dt_last_seen >= lef.dt_first_seen and rig.dt_last_seen <=lef.dt_last_seen) or
								 (rig.dt_first_seen >= lef.dt_first_seen and rig.dt_first_seen <= lef.dt_last_seen) or
								 (lef.dt_last_seen >= rig.dt_first_seen and lef.dt_last_seen <=rig.dt_last_seen) or
								 (lef.dt_first_seen >= rig.dt_first_seen and lef.dt_first_seen <=rig.dt_last_seen)
								),
								6,3);
  self.recent_cohabit := MAP ( lef.dt_first_seen > rig.dt_last_seen => 0,
                               rig.dt_first_seen > lef.dt_last_seen => 0,
                               lef.dt_first_seen > rig.dt_first_seen => IF ( lef.dt_last_seen > rig.dt_last_seen,rig.dt_last_seen,lef.dt_last_seen ),
                               IF ( lef.dt_last_seen > rig.dt_last_seen, rig.dt_last_seen, lef.dt_last_seen ) );
  self.same_lname := lef.lname=rig.lname;
  self.zip := lef.company_zip;
  self.prim_range := lef.prim_range;
	self.bdid := lef.bdid;
	self := lef;
  end;

withDups := join(associates_init_reduced,
                                   associates_init_reduced,
                                   left.bdid=right.bdid and
                                    left.did>right.did,
                                   by_company(left,right),local);

redis := distribute(withDups,hash(person1,person2));

export BA_Dist := redis : persist('Business_Header_BA_Dist');