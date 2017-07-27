import Corp2, phonesplus, ln_propertyv2;

r := record
  unsigned6 did;
  unsigned2 corp_affil_count := 0;
  unsigned2 comp_prop_count := 0;
	// placeholders for future expansion so that the layout of the key does not change every time
	// we need to add a count
  unsigned2 phonesplus_count := 0;
  unsigned2 nonfares_prop_count := 0;
  unsigned2 nofares_prop_asses_count := 0;
  unsigned2 nofares_prop_deeds_count := 0;
  unsigned2 filler5_count := 0;
  unsigned2 filler6_count := 0;
  unsigned2 filler7_count := 0;
  unsigned2 filler8_count := 0;
  unsigned2 filler9_count := 0;
  unsigned2 filler10_count := 0;
  end;

ca := distribute(Corp2.Files('').Base.Cont.Built(did<>0),hash(corp_key));

r from_ca(ca le) := transform
  self.did := le.did;
  self.corp_affil_count := 1;
end;
  
cas := project(dedup(sort(ca,corp_key,did,local),corp_key,did,local),from_ca(left));


pr1 := ln_propertyv2.File_Search_DID;

pr := dedup(sort(distribute(pr1,hash(ln_fares_id)),ln_fares_id,local),ln_fares_id,local);

r from_prop(pr le) := transform
  self.did := (unsigned6)le.did;
  self.nonfares_prop_count := IF(le.ln_fares_id[1] <>'R',1,0);
  self.nofares_prop_asses_count := IF(le.ln_fares_id[2] = 'A' AND le.ln_fares_id[1] <>'R', 1, 0);
  self.nofares_prop_deeds_count := IF(le.ln_fares_id[2] = 'D' AND le.ln_fares_id[1] <>'R', 1, 0);
  end;
  
ps := project(pr,from_prop(left));  

pp := phonesplus._keybuild_phonesplus_base(phonesplus.IsCellSource(vendor),confidencescore>10,(unsigned)CellPhone<>0);


r from_pp(pp le) := transform
  self.did := le.did;
  self.phonesplus_count := 1;
end;

pps := project(pp,from_pp(left));

comb := (cas + pps + ps)(did<>0);

res_layout := record
  unsigned6 did := comb.did;
  unsigned2 corp_affil_count := sum(group,comb.corp_affil_count);
//  unsigned2 comp_prop_count := sum(group,comb.comp_prop_cnt);
  unsigned2 phonesplus_count := sum(group,comb.phonesplus_count);
  unsigned2 nonfares_prop_count := sum(group,comb.nonfares_prop_count);
  unsigned2 nofares_prop_asses_count := sum(group,comb.nofares_prop_asses_count);
  unsigned2 nofares_prop_deeds_count := sum(group,comb.nofares_prop_deeds_count);
  unsigned2 filler5_count := 0;
  unsigned2 filler6_count := 0;
  unsigned2 filler7_count := 0;
  unsigned2 filler8_count := 0;
  unsigned2 filler9_count := 0;
  unsigned2 filler10_count := 0;
end;      
           
res := table(comb,res_layout,did);

export lookups_v2 := res : PERSIST('persist::lookups_v2');