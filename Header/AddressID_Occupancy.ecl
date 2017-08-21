import prte2_header;
h := header.File_Headers;

tp := record
data10 ht1 := header.addressid(h);
h.did;
  end;

aids := distribute(table(h,tp),hash(ht1[1..8]));

o_did := dedup(sort(aids,ht1,did,local),ht1,did,local);

cnts := record
  o_did.ht1;
  unsigned4 cnt := count(group);
  unsigned4 a_cnt := 0;
  end;

t := table(o_did,cnts,ht1,local);

ddt := dedup(t,ht1,local);

mpt := ddt.ht1[1..8];
acnts := record
  mpt;
  unsigned4 a_cnt := count(group);
  end;

t1 := table(ddt,acnts,mpt,local);

cnts f_result(t le, t1 ri) := transform
  self.a_cnt := ri.a_cnt;
  self := le;
  end;

j_back := join(t,t1,left.ht1[1..8] = right.mpt,f_result(left,right),local);

#IF (PRTE2_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Header.constants.PRTE_BUILD_WARN_MSG);
export AddressID_Occupancy := j_back;
#ELSE
export AddressID_Occupancy := j_back : persist('AddressID_Occupancy');
#END