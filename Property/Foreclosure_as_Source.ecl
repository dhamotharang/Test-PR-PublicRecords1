import header,business_header,business_header_ss,ut,did_add;
in_file := dataset('~thor_data400::Base::ForeclosureHeader_Building',Property.Layout_Fares_Foreclosure, flat);

src_rec := record 
 unsigned4	seq := 0;
 header.Layout_Source_ID;
 unsigned6	bdid := 0;
 Property.Layout_Fares_Foreclosure;
end;

header.Mac_Set_Header_Source(in_file,property.Layout_Fares_Foreclosure,src_rec,'FR',withUID)

src_rec add_seq(withUID L, integer C) := transform
	self.seq := C;
	self := L;
end;

dfseq := project(withUID,add_seq(LEFT,COUNTER));

bdid_rec := record
	unsigned4	seq;
	unsigned6	bdid;
	unsigned1	score;
	string60	company_name;
	string10	prim_range;
	string28	prim_name;
	string10	sec_range;
	string5	zip;
	string2	st;
end;

bdid_rec into_norm(dfseq L, integer C) := transform
	self.company_name := choose(C,L.name1_company,L.name1_company,L.name2_company,L.name2_company,L.name3_company,L.name3_company,L.name4_company,L.name4_company);
	self.prim_range := choose(C,L.situs1_prim_range,L.situs2_prim_range,L.situs1_prim_range,L.situs2_prim_range,L.situs1_prim_range,L.situs2_prim_range,L.situs1_prim_range,L.situs2_prim_range);
	self.prim_name := choose(C,L.situs1_prim_name,L.situs2_prim_name,L.situs1_prim_name,L.situs2_prim_name,L.situs1_prim_name,L.situs2_prim_name,L.situs1_prim_name,L.situs2_prim_name);
	self.sec_range := choose(C,L.situs1_sec_range,L.situs2_sec_range,L.situs1_sec_range,L.situs2_sec_range,L.situs1_sec_range,L.situs2_sec_range,L.situs1_sec_range,L.situs2_sec_range);
	self.zip := choose(C,L.situs1_zip,L.situs2_zip,L.situs1_zip,L.situs2_zip,L.situs1_zip,L.situs2_zip,L.situs1_zip,L.situs2_zip);
	self.st := choose(C,L.situs1_st,L.situs2_st,L.situs1_st,L.situs2_st,L.situs1_st,L.situs2_st,L.situs1_st,L.situs2_st);
     self.score := 0;
	self := L;
end;


dfready := normalize(dfseq,8,into_norm(LEFT,COUNTER));

myset := ['A'];

business_header_ss.mac_match_Flex(dfready,myset,
							company_name,
							prim_range,prim_name,zip,sec_range,st,
							foo,foo,
							bdid,
							bdid_rec,
							true,score,
							outf2);

outf4 := dedup(sort(distribute(outf2,hash(seq)),seq,-score,bdid,local),seq,local);							

dfseq rejoin(outf4 L, dfseq R) := transform
	self.bdid := L.bdid;
	self := R;
end;

outfinal := join(outf4,distribute(dfseq,hash(seq)),left.seq = right.seq,rejoin(LEFT,RIGHT),local);

export Foreclosure_as_Source := outfinal : persist('persist::headerbuild_foreclosure_src');
