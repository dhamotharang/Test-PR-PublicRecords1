import ut,prte2_header;

hd := header.File_Headers;

ids := record
  hd.did;
  hd.lname;
  end;

t_ids := dedup(sort(distribute(table(hd,ids),hash(did)),did,lname,local),did,lname,local);

ids_a := record
  ids;
  data10 address_id;
  unsigned4 lname_weight;
  unsigned6 hhid;
  end;

ids_a app_hh_inf(t_ids le, hhid_table ri) := transform
  self.address_id := ri.addr_id;
  self.hhid := ri.hhid;
  self.lname_weight := ri.lname_weight;
  self := le;
  end;


jn := join(t_ids,hhid_table,left.did=right.did,
                            app_hh_inf(left,right),hash);

lname_equiv := record
  unsigned6 le_hhid;
  unsigned6 ri_hhid;
  unsigned6 did;
  end;

lname_equiv take_both(jn le, jn ri) := transform
  self.le_hhid := le.hhid;
  self.ri_hhid := ri.hhid;
  self.did := le.did;
  end;

lname_equiv take_two(hhid_table le, hhid_table ri) := transform
  self.le_hhid := le.hhid;
  self.ri_hhid := ri.hhid;
  //self.did := ut.stringsimilar100(le.lname,ri.lname);
  self.did := le.did;
  end;

l_e := join(jn,jn,left.lname=right.lname and left.address_id=right.address_id and
                  left.lname_weight+right.lname_weight <= lname_risk*2 and
                  left.hhid>right.hhid,take_both(left,right),hash);

ht := distribute(hhid_table,hash(addr_id));

ut.MAC_Remove_Withdups_Local(ht,addr_id,1000,h_dedup)

r_e := join(h_dedup,h_dedup,left.addr_id=right.addr_id and
                       left.hhid>right.hhid and
                       left.lname_weight+right.lname_weight <= lname_risk*2 and
                       ut.StringSimilar100(left.lname,right.lname) < 20
                       ,take_two(left,right),local);

e_e := l_e+r_e;
ut.MAC_Reduce_Pairs(e_e,ri_hhid,le_hhid,did,lname_equiv,led)
//led := dedup(sort(distribute(l_e+r_e,le_hhid),le_hhid,ri_hhid,local),le_hhid,local);

#IF (PRTE2_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Header.constants.PRTE_BUILD_WARN_MSG);
export HHID_Indiv_Joins := led;
#ELSE
export HHID_Indiv_Joins := led : persist('HHID_Indiv_Joins');
#END