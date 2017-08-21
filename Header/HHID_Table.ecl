import ut, address,std,PRTE2_Header,PromoteSupers;
ad := header.addressid_occupancy;
TheDate := (unsigned4)((STRING8)Std.Date.Today());

f := header.file_headers;

hnf := header.Name_Frequencies(f);

MAC_Best_Address(f, did, 1, en)

hba := group(en);

hba_rid := record
  hba.rid;
  end;

bests := table(hba,hba_rid);

hd := header.File_Headers;

slimed_result := layout_hhid;

layout_hhid into(hd le) := transform
  self := le;
  self.addr_id := header.AddressID(le);
  end;

s1 := project(hd,into(left));

slimed_result take_left(layout_Hhid le) := transform
  self.first_current := TheDate;
  self.last_current := TheDate;
  self := le;
  end;

j1 := join(s1,bests,left.rid=right.rid,take_left(left),hash);

layout_hhid take_r(slimed_Result le) := transform
  self := le;
  end;

j1d := distribute(j1,hash(did));
fhd0 := distribute(file_hhid,hash(did));
hd_did := dedup(sort (hd,did,local),did,local); 

// refresh fhd file to have the did's only in current header 
fhd0 tra(fhd0 l) := transform
  self := l;
  end;
fhd :=  join(fhd0,hd_did,left.did=right.did,tra(left),local);

j := join(j1d,fhd,left.did=right.did and
                                 left.addr_id=right.addr_id,
                                 take_r(left),local,left only);

layout_hhid update_d(layout_hhid le,slimed_result ri) := transform
  self.last_current := IF(ri.did=0,le.last_current,TheDate);
  self := le;
  end;

updated := join(fhd,j1d,left.did=right.did and left.addr_id=right.addr_id,
                             update_d(left,right),local,left outer);

slimed_result take_aiw(layout_hhid le, ad ri) := transform
  self.oc_size := ri.cnt; // Take the #of people at address
  self := le;
  end;

wadd := join(j,ad,left.addr_id=right.ht1,take_aiw(left,right),hash);

slimed_result take_lname_weight(wadd le, hnf ri) := transform
  self.lname_weight := le.oc_size * 10000 * ri.percentage; // Chances in 10000 of a collision by chance
  self := le;
  end;

j_weighted := join(wadd,hnf,left.lname=right.lname,take_lname_weight(left,right),hash);

ut.MAC_Sequence_Records(j_weighted,hhid,j_out)

dj := dedup(j_out,addr_id,lname,all);

mc := max(file_hhid,hhid); 

slimed_result ass_hhid(j_out le,dj ri) := transform
  self.hhid := mc+if(le.lname_weight <= lname_risk,ri.hhid,le.hhid);
  self.hhid_indiv := mc+if(le.lname_weight <= lname_risk,ri.hhid,le.hhid);
  self.hhid_relat := mc+if(le.lname_weight <= lname_risk,ri.hhid,le.hhid);
  self := le;
  end;

id_back := join(j_out,dj,left.addr_id=right.addr_id and
                       left.lname=right.lname,ass_hhid(left,right),hash);

#IF (PRTE2_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Header.constants.PRTE_BUILD_WARN_MSG);
pHHID_Table := id_back+updated;
PromoteSupers.MAC_SF_BuildProcess(pHHID_Table,'~PRTE::BASE::HHID',make_hhid,2,,true,pVersion:=workunit);
export HHID_Table := pHHID_Table : success(make_hhid);
#ELSE
export HHID_Table := id_back+updated : persist('HHID_Table');
#END