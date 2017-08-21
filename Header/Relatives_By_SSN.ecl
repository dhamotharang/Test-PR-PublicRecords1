import ut;
export Relatives_By_SSN(
	dataset(header.Layout_Header) h
	) :=
FUNCTION

hssn := record
  h.did;
  h.ssn;
  h.lname;
  h.valid_ssn;
  end;

h_ssn_recs := table(h((integer)ssn<>0),hssn);

h_dist := distribute(h_ssn_recs,hash(ssn));

h_ded := dedup(sort(h_dist,ssn,did,lname,valid_ssn,local),ssn,did,lname,local);

ut.mac_remove_withdups_local(h_ded,ssn,10,h_ssn_nodup)

Layout_Relatives_v2.temp match_ssn(h_dist lef, h_dist rig) := transform
  self.person1 := lef.did;
  self.person2 := rig.did;
  self.same_lname := lef.lname=rig.lname;
  self.zip:=-1;
  self.prim_range:=-1;
  self.number_cohabits := if (self.same_lname= true and lef.valid_ssn not in ['F','B'] and rig.valid_ssn not in ['F','B'], 6 , 4);
  self.recent_cohabit := 0;
  self.ssn := lef.ssn ; 
  end;


js := join(h_ssn_nodup,h_ssn_nodup,left.ssn=right.ssn and
                                   left.did > right.did,
                                   match_ssn(left,right),local);

result := dedup(dedup(sort(js,person1,person2,local),person1,person2,ssn,local),person1,person2,keep 5 , local):persist('relatives_by_ssn'); 
return result;
END;