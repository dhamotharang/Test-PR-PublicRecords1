import business_header,business_header_ss,ut,did_add;

//-----------[ nixie ]----------
df1 := busdata.File_SKA_Nixie_In;

rec1 := busdata.layout_ska_nixie_bdid;

rec1 into_bdid(df1 L) := transform
	self.bdid := 0;
	self := l;
end;

df1_2 := project(df1,into_bdid(LEFT));

business_header.MAC_Source_Match(df1_2,outf1,
				false,bdid,
				false,'SK',
				false,foo,
				company_name,
				mail_prim_range,mail_prim_name,mail_sec_range,mail_zip,
				true,phone,
				false,foo)

outf1_2_bdid := outf1(bdid != 0);
df1_3 := outf1(bdid = 0);
myset := ['A','P'];

business_header_ss.mac_match_flex(df1_3,myset,
							company_name,
							mail_prim_range,mail_prim_name,mail_zip,mail_sec_range,mail_st,
							phone,foo,
							bdid,
							rec1,
							false,foo,
							outf1_3)

outf1_4 := outf1_3 + outf1_2_bdid;

ut.MAC_SF_BuildProcess(outf1_4,'~thor_data400::base::ska_nixie',do1,2);

//--------------[ verified ]----------

df2 := busdata.File_SKA_Verified_In;

rec2 := record
	unsigned4	seq;
	busdata.layout_ska_verified_bdid;
end;

rec2 into_bdid2(df2 L,integer C) := transform
	self.bdid := 0;
	self.seq := C;
	self := l;
end;

df2_2 := project(df2,into_bdid2(LEFT,COUNTER));

rec3 := record
	rec2;
	string10	prim_range;
	string28	prim_name;
	string10	sec_range;
	string5	my_zip;
	string2	my_st;
	unsigned1 score;
end;

rec3 into_norm(df2_2 L, integer C) := transform
	self.prim_range := if (c = 1, L.mail_prim_range, L.alt_prim_range);
	self.prim_name := if (c = 1, L.mail_prim_name, L.alt_prim_name);
	self.sec_range := if (c = 1, L.mail_sec_range, L.alt_sec_range);
	self.my_zip := if (c = 1, L.mail_zip, L.alt_zip);
	self.my_st := if (c = 1, L.mail_st, L.alt_st);
	self.score := 0;
	self := L;
end;

df2_3 := normalize(df2_2,2,into_norm(LEFT,COUNTER));


business_header.MAC_Source_Match(df2_3,outf2,
				false,bdid,
				false,'SK',
				false,foo,
				company_name,
				prim_range,prim_name,sec_range,my_zip,
				true,phone,
				false,foo)

outf2_2_bdid := outf2(bdid != 0);
df2_4 := outf2(bdid = 0);
myset2 := ['A','P'];

business_header_ss.mac_match_flex(df2_4,myset2,
							company_name,
							prim_range,prim_name,my_zip,sec_range,my_st,
							phone,foo,
							bdid,
							rec3,
							true,score,
							outf2_3)


outf2_2_bdid fake_score(outf2_2_bdid L) := transform
	self.score := 101;
	self := l;
end;

outf2_2_bdid_score := project(outf2_2_bdid,fake_score(LEFT));

outf2_4 := dedup(sort(distribute(outf2_2_bdid_score + outf2_3,hash(seq)),seq,-score,bdid,local),seq,local);


busdata.layout_ska_verified_bdid into_out(outf2_4 L) := transform
	self := L;
end;

outf2_5 := join(outf2_4, df2_2, left.seq = right.seq, into_out(LEFT),hash);

ut.MAC_SF_BuildProcess(outf2_5,'~thor_data400::base::ska_verified',do2,2);

//------------------------------

export Proc_Build_SKAs := sequential(do1,do2);
