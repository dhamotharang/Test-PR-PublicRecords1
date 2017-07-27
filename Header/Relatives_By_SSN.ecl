import ut;
h := header.file_headers;

hssn := record
  h.did;
  h.ssn;
  h.lname;
  end;

h_ssn_recs := table(h((integer)ssn<>0),hssn);

h_dist := distribute(h_ssn_recs,hash(ssn));

h_ded := dedup(sort(h_dist,ssn,did,lname,local),ssn,did,lname,local);

ut.mac_remove_withdups_local(h_ded,ssn,10,h_ssn_nodup)

Layout_Relatives match_ssn(h_dist lef, h_dist rig) := transform
  self.person1 := lef.did;
  self.person2 := rig.did;
  self.same_lname := lef.lname=rig.lname;
  self.zip:=-1;
  self.prim_range:=-1;
  self.number_cohabits := 4;
  self.recent_cohabit := 0;
  end;


js := join(h_ssn_nodup,h_ssn_nodup,left.ssn=right.ssn and
                                   left.did > right.did,
                                   match_ssn(left,right),local);

export Relatives_By_SSN := dedup(js,person1,person2,all) : persist('ssn_rels');