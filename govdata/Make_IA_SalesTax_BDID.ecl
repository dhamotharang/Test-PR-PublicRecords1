import business_header,business_header_SS,did_add,ut;

df := govdata.File_IA_Sales_Tax_In;

seqrec := record
	df;
	unsigned4	seq := 0;
end;

seqrec into_seq(df L, integer C) := transform
	self.seq := C;
	self := L;
end;

df2 := project(df,into_seq(LEFT,COUNTER));

myrec := record
	unsigned4	seq;
	unsigned6	bdid;
	unsigned1	score;
	string35	co_name;
	string10	prim_range;
	string28	prim_name;
	string10	sec_range;
	string5	zip;
	string2	st;
end;

myrec into_norm(df2 L, integer C) := transform
	self.seq := L.seq;
	self.bdid := 0;
	self.score := 0;
	self.prim_range := choose(C,L.mailing_prim_range,L.mailing_prim_range,L.location_prim_Range,L.location_prim_Range);
	self.prim_name := choose(C,L.mailing_prim_name,L.mailing_prim_name,L.location_prim_name,L.location_prim_name);
	self.sec_range := choose(C,L.mailing_sec_range,L.mailing_sec_range,L.location_sec_Range,L.location_sec_Range);
	self.zip := choose(C,L.mailing_zip,L.mailing_zip,L.location_zip,L.location_zip);
	self.st := choose(C,L.mailing_st,L.mailing_st,L.location_st,L.location_st);
	self.co_name := choose(C,L.company_name_1,L.company_name_2,L.company_name_1,L.company_name_2);
end;

df3 := normalize(df2,4,into_norm(LEFT,COUNTER));

business_header.MAC_Source_Match(df3,o1,
							false,bdid,
							false,'',
							false,foo,
							co_name,
							prim_range,prim_name,sec_range,zip,
							false,foo,
							false,foo)
							
mid1 := o1(bdid != 0);
mid2 := o1(bdid = 0);

//we want these at the top of the sort order later.
mid1 fake_score(mid1 L) := transform
	self.score := 101;
	self := L;
end;

mid1_score := project(mid1, fake_score(LEFT));

myset := ['A'];

business_header_ss.MAC_Match_Flex(mid2,myset,
						co_name,
						prim_range,prim_name,zip,sec_range,st,
						foo,foo,bdid,myrec,
						true,score,
						o2)

outf1 := dedup(sort(distribute(o2 + mid1_score,hash(seq)),seq,-score,bdid,local),seq,local);


govdata.Layout_IA_SalesTax_Base into_final(df2 L, outf1 R) := transform
	self.bdid := R.bdid;
	self := L;
end;

outfinal := join(distribute(df2,hash(seq)),outf1,left.seq = right.seq,
			into_final(LEFT,RIGHT),local,left outer);

ut.MAC_SF_BuildProcess(outfinal,'~thor_data400::base::IA_SaleS_Tax',do1,2);

export Make_IA_SalesTax_BDID := do1;

