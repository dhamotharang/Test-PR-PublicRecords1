import business_header,business_header_ss,did_add,ut;

df := govdata.File_OR_Workers_Comp_In;

seqrec := record
	df;
	unsigned4	seq;
end;

seqrec into_seq(df L, integer C) := transform
	self.seq := C;
	self := L;
end;

df2 := project(df,into_seq(LEFT,COUNTER));

myRec := record
	unsigned6	bdid;
	unsigned1	score;
	string10	phone;
	string10	prim_range;
	string28	prim_name;
	string10	sec_range;
	string5	zip;
	string2	st;
	string100	name;
	unsigned4	seq;
end;

myrec into_temp(df2 L, integer C) := transform
	self.name := L.employer_legal_name;
	self.phone := L.ppb_phone_number;
	self.prim_range := if (C = 1, L.ppb_prim_range, L.mailing_prim_Range);
	self.prim_name := if (C = 1, L.ppb_prim_name, L.mailing_prim_name);
	self.sec_range := if (C = 1, L.ppb_sec_range, L.mailing_sec_range);
	self.zip := If (C = 1, L.ppb_zip5,L.mailing_zip5);
	self.st := If (C = 1, L.ppb_st, L.mailing_st);
	self.seq := L.seq;
	self.bdid := 0;
	self.score := 0;
end;

df3 := normalize(df2,2,into_temp(LEFT,COUNTER));

business_header.MAC_Source_Match(df3,o1,
						false,bdid,
						false,'WC',
						false,foo,
						Name,
						prim_range,prim_name,sec_range,zip,
						true,Phone,
						false, foo)


o2_bdid := o1(bdid != 0);


// we want these at the top of the sort order.
o2_bdid add_fake_score(o2_bdid L) := transform
	self.score := 101;
	self := l;
end;

o2_bdid_score := project(o2_bdid,add_fake_score(LEFT));

o2 := o1(bdid = 0);

myset := ['A','P'];

business_header_ss.MAC_Match_Flex(o2,myset,
			name,
			prim_range,prim_name,zip,
			sec_range,st,
			Phone,foo,
			bdid,
			myrec,
			true,score,
			o3)
			

outf := dedup(sort(distribute(o3 + o2_bdid_score,hash(seq)),seq,-score,bdid,local),seq,local);

govdata.Layout_OR_Workers_Comp_Base into_final(df2 L, outf R) := transform
	self.bdid := R.bdid;
	self := L;
end;

outfinal := join(distribute(df2,hash(seq)),outf,left.seq = right.seq,
				into_final(LEFT,RIGHT),local,left outer);

ut.MAC_SF_BuildProcess(outfinal,'~thor_data400::base::OR_workers_comp',do1,2);

export Make_OR_Workers_Comp_BDID := do1;
			
