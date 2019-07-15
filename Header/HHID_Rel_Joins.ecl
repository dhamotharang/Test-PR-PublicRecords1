import ut,prte2_header;
fin := header.File_Relatives_v3(number_cohabits>5);

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

ids_a app_hh_inf(f le, header.hhid_table_i ri) := transform
  self.address_id := ri.addr_id;
  self.hhid := ri.hhid_indiv;
  self := le;
  end;


jn := join(f,header.hhid_table_i,left.person1=right.did,app_hh_inf(left,right),hash);

lname_equiv := record
  unsigned6 le_hhid;
  unsigned6 ri_hhid;
  unsigned1 flag := 0;
  end;

lname_equiv take_both(jn le, header.hhid_table_i ri) := transform
  self.le_hhid := le.hhid;
  self.ri_hhid := ri.hhid_indiv;
  end;

l_e := join(jn,header.hhid_table_i,left.address_id=right.addr_id and
                  left.person2=right.did and
                  left.hhid>right.hhid_indiv,take_both(left,right),hash);

//led := dedup(sort(distribute(l_e,le_hhid),le_hhid,ri_hhid,local),le_hhid,local);
ut.MAC_Reduce_Pairs(l_e,ri_hhid,le_hhid,flag,lname_equiv,led)

#IF (PRTE2_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Header.constants.PRTE_BUILD_WARN_MSG);
export HHID_Rel_Joins := led;
#ELSE
export HHID_Rel_Joins := led : persist('HHID_Rel_Joins');
#END