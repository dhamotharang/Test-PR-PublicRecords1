import header, doxie;

r := doxie.File_Relatives_Plus;
//he := dataset('~thor_data400::base::headerkey_building',header.Layout_Header,flat);
//  Bug 12065, use blocked data filter on header instead of raw data
he := doxie_build.file_header_building; 

hs := record
  he.fname;
  he.lname;
  he.did;
  end;

ts := table(he,hs);

ta1 := record
  unsigned8 person1;
  unsigned8 person2;
  string10  fname1;
  string10  lname1;
  unsigned8 __filepos;
  end;

r_did1 := distribute(r,hash((integer8)person1));
ts_1 := dedup(sort(distribute(ts,hash((integer8)did)),did,fname,lname,local),did,fname,lname,local);

ta1 add_first(r le,hs ri) := transform
  self.fname1 := ri.fname;
  self.lname1 := ri.lname;
  self := le;
  end;

added_1 := join(r_did1,ts_1,left.person1=right.did,add_first(left,right),local);

dad2 := distribute(added_1,hash((integer8)person2));

ta2 := record
  ta1;
  string10 fname2;
  string10 lname2;
  end;

ta2 add_second(ta1 le, hs ri) := transform
  self.fname2 := ri.fname;
  self.lname2 := ri.lname;
  self := le;
  end;

added_2 := join(dad2,ts_1,left.person2=right.did,add_second(left,right),local);

export key_prep_relative_names := INDEX(added_2,{fname1,lname1,fname2,lname2,person1,person2,(big_endian unsigned8 )__filepos},'key::rel_names' + thorlib.wuid());