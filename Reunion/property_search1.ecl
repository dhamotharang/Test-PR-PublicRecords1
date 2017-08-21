import ln_propertyv2;

ds_srch := ln_propertyv2.File_Search_DID(vendor_source_flag in ['D','O'] and fname<>'' and lname<>'');

srch_own  := ds_srch(source_code[2] in ['B','O']);
srch_prop := ds_srch(source_code[2] in ['P']);

r0 := record
 string12  ln_fares_id2;
 unsigned6 did;
 string1   owner_or_seller_ind;
 string20  fname;
 string20  mname;
 string20  lname;
 string20  name_suffix;
end;

r0 t0(ds_srch le) := transform
 self.ln_fares_id2 := le.ln_fares_id;
 self.did          := le.did;
 self.fname        := le.fname;
 self.mname        := le.mname;
 self.lname        := le.lname;
 self.name_suffix  := le.name_suffix;
 self.owner_or_seller_ind := if(le.source_code[1] in ['O','B'],'O',
                             if(le.source_code[1] ='S','S',
							 ''));
end;

p0      := project   (ds_srch,t0(left));
p0_filt := distribute(p0(owner_or_seller_ind='O'),hash(ln_fares_id2));
p0_dupd := dedup     (p0_filt,record,local);							 

//get owner addresses
r1 := record
 string12   own_ln_fares_id; 
 //string2    own_source_code_2; 
 string1    own_source_code_2; 
 string10   own_prim_range;
 string2    own_predir;
 string28   own_prim_name;
 string4    own_suffix;
 string2    own_postdir;
 string10   own_unit_desig;
 string8    own_sec_range;
 string25   own_v_city_name;
 string2    own_st;
 string5    own_zip;
 string4    own_zip4;
end;

r1 t1(srch_own le) := transform
 self.own_ln_fares_id   := le.ln_fares_id;
 self.own_source_code_2 := 'O';
 self.own_prim_range    := le.prim_range;
 self.own_predir        := le.predir;
 self.own_prim_name     := le.prim_name;
 self.own_suffix        := le.suffix;
 self.own_postdir       := le.postdir;
 self.own_unit_desig    := le.unit_desig;
 self.own_sec_range     := le.sec_range;
 self.own_v_city_name   := le.v_city_name;
 self.own_st            := le.st;
 self.own_zip           := le.zip;
 self.own_zip4          := le.zip4;
end;

p1      := project   (srch_own,t1(left));
p1_dist := distribute(p1,hash(own_ln_fares_id));
p1_dupd := dedup     (p1_dist,record,local);

//get property addresses
r2 := record
 string12   pro_ln_fares_id; 
 //string2    pro_source_code_2; 
 string1    pro_source_code_2; 
 string10   pro_prim_range;
 string2    pro_predir;
 string28   pro_prim_name;
 string4    pro_suffix;
 string2    pro_postdir;
 string10   pro_unit_desig;
 string8    pro_sec_range;
 string25   pro_v_city_name;
 string2    pro_st;
 string5    pro_zip;
 string4    pro_zip4;
end;

r2 t2(srch_prop le) := transform
 self.pro_ln_fares_id   := le.ln_fares_id;
 self.pro_source_code_2 := 'P';
 self.pro_prim_range    := le.prim_range;
 self.pro_predir        := le.predir;
 self.pro_prim_name     := le.prim_name;
 self.pro_suffix        := le.suffix;
 self.pro_postdir       := le.postdir;
 self.pro_unit_desig    := le.unit_desig;
 self.pro_sec_range     := le.sec_range;
 self.pro_v_city_name   := le.v_city_name;
 self.pro_st            := le.st;
 self.pro_zip           := le.zip;
 self.pro_zip4          := le.zip4;
end;

p2      := project   (srch_prop,t2(left));
p2_dist := distribute(p2,hash(pro_ln_fares_id));
p2_dupd := dedup     (p2_dist,record,local);

r3 := record
 string12 own_pro_ln_fares_id;
 p1_dupd;
 p2_dupd;
end;

r3 t3(p1_dupd le, p2_dupd ri) := transform
 self.own_pro_ln_fares_id := if(le.own_ln_fares_id<>'',le.own_ln_fares_id,ri.pro_ln_fares_id);
 self := le;
 self := ri;
end;

j1 := join(p1_dupd,p2_dupd,left.own_ln_fares_id=right.pro_ln_fares_id,t3(left,right),full outer,local);

j1_dist := distribute(j1,hash(own_pro_ln_fares_id));
			 
r4 := record
 p0_dupd;
 j1_dist;
end;

r4 t4(p0_dupd le, j1_dist ri) := transform
 self := le;
 self := ri;
end;

j2 := join(p0_dupd,j1_dist,left.ln_fares_id2=right.own_pro_ln_fares_id,t4(left,right),left outer,local);
		  
export property_search1 := dedup(j2,record,local);
