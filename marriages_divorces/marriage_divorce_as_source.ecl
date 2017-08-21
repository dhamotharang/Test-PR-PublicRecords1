import header;
//in_file := dataset('~thor_200::Base::Marriage_Divorce_Building',marriages_divorces.layout_marriage_divorces, flat);
in_file := marriages_divorces.File_Marriage_Divorce_Base;

src_rec := record 
 unsigned4	seq := 0;
 header.Layout_Source_ID;
 unsigned6	did := 0;
 marriages_divorces.layout_marriage_divorces;
end;

header.Mac_Set_Header_Source(in_file,marriages_divorces.layout_marriage_divorces,src_rec,'',withUID)

src_rec add_seq(withUID L, integer C) := transform
	self.seq := C;
	self     := L;
end;

dfseq := project(withUID,add_seq(LEFT,COUNTER));

did_rec := record
 unsigned4 seq;
 unsigned6 did;
 unsigned1 score;
 string5   title;
 string20  fname;
 string20  mname;
 string20  lname;
 string5   name_suffix;
 string8   dob;
 string9   ssn;
 string3   age;  
 string10  prim_range;
 string2   predir;
 string28  prim_name;
 string4   addr_suffix;
 string2   postdir;
 string10  unit_desig;
 string8   sec_range;
 string25  city_name;
 string2   st;
 string5   zip;
 string4   zip4;
 string3   county;
 string7   geo_blk;
end;

did_rec into_norm(dfseq L, integer C) := transform
 self.title       := choose(c,l.p1_title,l.p1a_title,l.p2_title,l.p2a_title);
 self.fname       := choose(c,l.p1_fname,l.p1a_fname,l.p2_fname,l.p2a_fname);
 self.mname       := choose(c,l.p1_mname,l.p1a_mname,l.p2_mname,l.p2a_mname);
 self.lname       := choose(c,l.p1_lname,l.p1a_lname,l.p2_lname,l.p2a_lname);
 self.name_suffix := choose(c,l.p1_name_suffix,l.p1a_name_suffix,l.p2_name_suffix,l.p2a_name_suffix);
 self.dob         := choose(c,l.party1_dob,'',l.party2_dob,'');
 self.ssn         := choose(c,l.party1_ssn,'',l.party2_ssn,'');
 self.age         := choose(c,l.party1_age,'',l.party2_age,'');   
 self.prim_range  := choose(c,l.prim_range_1,l.prim_range_1,l.prim_range_2,l.prim_range_2);
 self.predir      := choose(c,l.predir_1,l.predir_1,l.predir_2,l.predir_2);
 self.prim_name   := choose(c,l.prim_name_1,l.prim_name_1,l.prim_name_2,l.prim_name_2);
 self.addr_suffix := choose(c,l.addr_suffix_1,l.addr_suffix_1,l.addr_suffix_2,l.addr_suffix_2);
 self.postdir     := choose(c,l.postdir_1,l.postdir_1,l.postdir_2,l.postdir_2);
 self.unit_desig  := choose(c,l.unit_desig_1,l.unit_desig_1,l.unit_desig_2,l.unit_desig_2);
 self.sec_range   := choose(c,l.sec_range_1,l.sec_range_1,l.sec_range_2,l.sec_range_2);
 self.city_name   := choose(c,l.v_city_name_1,l.v_city_name_1,l.v_city_name_2,l.v_city_name_2);
 self.st          := choose(c,l.st_1,l.st_1,l.st_2,l.st_2);
 self.zip         := choose(c,l.zip_1,l.zip_1,l.zip_2,l.zip_2);
 self.zip4        := choose(c,l.zip4_1,l.zip4_1,l.zip4_2,l.zip4_2);
 self.county      := choose(c,l.ace_fips_county_1,l.ace_fips_county_1,l.ace_fips_county_2,l.ace_fips_county_2);
 self.geo_blk     := choose(c,l.geo_blk_1,l.geo_blk_1,l.geo_blk_2,l.geo_blk_2);
 self.score       := 0;
 self             := l;
end;

dfready := normalize(dfseq,8,into_norm(LEFT,COUNTER));
dfready_filt := dfready(fname<>'',lname<>'');
dfready_dedup := dedup(dfready_filt,all);

matchset := ['A','S','D'];

did_add.MAC_Match_Flex
	(dfready_dedup, matchset,					
	 ssn, dob, fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip, st, phone, 
	 DID, did_rec, false, DID_Score_field,
	 75, dfout)
	 
export marriage_divorce_as_source := dfout : persist('persist::headerbuild_marriage_divorce_src');