import ut;
fin := header.file_relatives(number_cohabits>5);

r := record
  unsigned6 person1;
  unsigned6 person2;
  end;

r take(fin le,unsigned1 cnt) := transform
   self.person1 := if ( cnt=1, le.person1, le.person2 );
   self.person2 := if ( cnt=1, le.person2, le.person1 );
   end;

f := normalize(fin,2,take(left,counter));

ids_a := record
  unsigned6 person1;
  unsigned6 person2;
  data10 address_id;
  unsigned6 hhid;
  end;

ids_a app_hh_inf(f le, fcra_hhid_table_i ri) := transform
  self.address_id := ri.addr_id;
  self.hhid := ri.hhid_indiv;
  self := le;
  end;


jn := join(f,fcra_hhid_table_i,left.person1=right.did,app_hh_inf(left,right),hash);

lname_equiv := record
  unsigned6 le_hhid;
  unsigned6 ri_hhid;
  unsigned1 flag := 0;
  end;

lname_equiv take_both(jn le, fcra_hhid_table_i ri) := transform
  self.le_hhid := le.hhid;
  self.ri_hhid := ri.hhid_indiv;
  end;

l_e := join(jn,fcra_hhid_table_i,left.address_id=right.addr_id and
                  left.person2=right.did and
                  left.hhid>right.hhid_indiv,take_both(left,right),hash);

ut.MAC_Reduce_Pairs(l_e,ri_hhid,le_hhid,flag,lname_equiv,led)

export FCRA_HHID_Rel_Joins := led : persist('FCRA_HHID_Rel_Joins');