import header;
#workunit('name', 'Relative Doxie keys');
//if(header.version <> doxie.rel_version_new , fail('You have a mismatch between header.version and doxie.rel_version_new.  Please be sure that this is what you want.'));


Build_unix_keys := true;
Build_relatives := true;
Build_business := false;
Build_names := true;


b := doxie.File_BusAssoc_Plus;
r := doxie.File_Relatives_Plus;
u := doxie.File_Relatives_Unix_Plus;
h := header.File_Headers;

rel_plus_size := 29;

doxie.Layout_Relatives_Plus swap(doxie.Layout_Relatives_Plus le) := transform
  self.person1 := le.person2;
  self.person2 := le.person1;
  self := le;
  end;

res := r + project(r,swap(left));

#if(build_unix_keys)
	BUILDINDEX(u,{
	same_lname,
	person1,(big_endian unsigned8 )__filepos},'key::rel_same_lname_person1_' + header.version_build,moxie);
	
	BUILDINDEX(u,{
	same_lname,
	person2,(big_endian unsigned8 )__filepos},'key::rel_same_lname_person2_' + header.version_build,moxie);
#end


#if(build_relatives)
	BUILDINDEX(res,{person1,same_lname,number_cohabits,recent_cohabit,person2,(big_endian unsigned8 )__filepos},'key::relatives' + header.version_build, doxie.Filename_Relatives_Plus, bias(rel_plus_size));
#end

bres := b + project(b,swap(left));

#if(build_business)
	BUILDINDEX(bres,{person1,same_lname,number_cohabits,recent_cohabit,person2,(big_endian unsigned8 )__filepos},'key::busassoc' + header.version_build, doxie.Filename_Relatives_Plus);
#end

he := h;

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
#if(build_names)
	BUILDINDEX(added_2,{fname1,lname1,fname2,lname2,person1,person2,(big_endian unsigned8 )__filepos},'key::rel_names' + header.version_build, doxie.Filename_Relatives_Plus, bias(rel_plus_size));
#end