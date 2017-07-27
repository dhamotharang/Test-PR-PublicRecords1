import ut, doxie_build;

//h := dataset('~thor_data400::Base::HeaderKey_Building',header.Layout_Header,flat);
//  Bug 12065, use blocked data filter on header instead of raw data
h := doxie_build.file_header_building; 


ta := record
  unsigned8 states := ut.bit_set(0,ut.St2Code(h.st));
  unsigned4 lname1 := ut.bit_set(0,ut.Chr2Code(h.lname[1]));
  unsigned4 lname2 := ut.bit_set(0,ut.Chr2Code(h.lname[2]));
  unsigned4 lname3 := ut.bit_set(0,ut.Chr2Code(h.lname[3]));
  unsigned4 fname1 := ut.bit_set(0,ut.Chr2Code(h.fname[1])) | ut.bit_set(0,ut.Chr2Code(datalib.PreferredFirst(h.fname)[1]));
  unsigned4 fname2 := ut.bit_set(0,ut.Chr2Code(h.fname[2])) | ut.bit_set(0,ut.Chr2Code(datalib.PreferredFirst(h.fname)[2]));
  unsigned4 fname3 := ut.bit_set(0,ut.Chr2Code(h.fname[3])) | ut.bit_set(0,ut.Chr2Code(datalib.PreferredFirst(h.fname)[3]));
  unsigned4 city1 := ut.bit_set(0,ut.Chr2Code(h.city_name[1]));
  unsigned4 city2 := ut.bit_set(0,ut.Chr2Code(h.city_name[2]));
  unsigned4 city3 := ut.bit_set(0,ut.Chr2Code(h.city_name[3]));
  h.did;
  end;
  
res := sort(distribute(table(h,ta),hash(did)),did,local);

ta add(ta le,ta ri) := transform
  self.states := le.states|ri.states;
  self.lname1 := le.lname1|ri.lname1;
  self.lname2 := le.lname2|ri.lname2;
  self.lname3 := le.lname3|ri.lname3;
  self.fname1 := le.fname1|ri.fname1;
  self.fname2 := le.fname2|ri.fname2;
  self.fname3 := le.fname3|ri.fname3;
  self.city1 := le.city1|ri.city1;
  self.city2 := le.city2|ri.city2;
  self.city3 := le.city3|ri.city3;
  self.did := le.did;
  end;
  
res1 := rollup(res,left.did=right.did,add(left,right),local);

rf := header.File_Relatives;

header.Layout_Relatives switch(rf le) := transform
  self.person1 := le.person2;
  self.person2 := le.person1;
  self := le;
  end;

bw := dedup(sort(group(rf + project(rf,switch(left)),person1,all),-number_cohabits,-recent_cohabit),left.person1=right.person1,keep(5));

app_bw_r := record
  header.Layout_Relatives;
  ta;
  end;
  
app_bw_r app(bw le,res1 ri) := transform
  self := le;
  self := ri;
  end;

jn := join(bw,res1,left.person2=right.did,app(left,right),hash);

taa := record
  ta;
  unsigned4 rel_fname1;
  unsigned4 rel_fname2;
  unsigned4 rel_fname3; 
  end;

taa take_rels(ta le,app_bw_r ri) := transform
  self.lname1 := le.lname1|ri.lname1;
  self.lname2 := le.lname2|ri.lname2;
  self.lname3 := le.lname3|ri.lname3;
  self := le;
  self.rel_fname1 := ri.fname1;
  self.rel_fname2 := ri.fname2;
  self.rel_fname3 := ri.fname3;
  end;

with_rels := join(res1,jn,left.did=right.person1,take_rels(left,right),hash,left outer);

taa add_again(taa le,taa ri) := transform
  self.rel_fname1 := le.rel_fname1|ri.rel_fname1;
  self.rel_fname2 := le.rel_fname2|ri.rel_fname2;
  self.rel_fname3 := le.rel_fname3|ri.rel_fname3; 
  self.lname1 := le.lname1|ri.lname1;
  self.lname2 := le.lname2|ri.lname2;
  self.lname3 := le.lname3|ri.lname3;
  self := le;
  end;

rl2 := rollup( sort(with_rels,did,local), left.did=right.did, add_again(left,right), local );

export dids_instates := rl2 : persist('dids_instates');