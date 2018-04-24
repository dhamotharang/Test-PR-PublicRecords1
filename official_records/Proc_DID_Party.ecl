import official_records,did_add,fair_isaac,didville,ut,header_slimsort,watchdog, Business_Header_SS, Business_Header;

main_file := official_records.File_In_Party;

seqrec := record
	main_file;
	unsigned4	seq;
end;

seqrec into_seq(main_file L, integer C) := transform
	self.seq := C;
	self := L;
end;

df1 := project(main_file,into_seq(LEFT,COUNTER));


norm_off_rec := record
	unsigned4	seq;
	string8	dob;
	string9	ssn;
	string5	or_title;
	string20	or_fname;
	string20	or_mname;
	string20	or_lname;
	string5	or_suffix;
	end;

norm_off_rec normalize_rec(df1 L, integer cnt) := TRANSFORM
	self.or_title := choose(cnt,L.title1,L.title2,L.title3,L.title4,L.title5);
	self.or_fname := choose(cnt,L.fname1,L.fname2,L.fname3,L.fname4,L.fname5);
	self.or_mname := choose(cnt,L.mname1,L.mname2,L.mname3,L.mname4,L.mname5);
	self.or_lname := choose(cnt,L.lname1,L.lname2,L.lname3,L.lname4,L.lname5);
	self.or_suffix := choose(cnt,L.suffix1,L.suffix2,L.suffix3,L.suffix4,L.suffix5);
	self.seq := L.seq;
	self.dob := L.entity_dob;
	self.ssn := L.entity_ssn;
end;

df2 := normalize(df1,5,normalize_rec(left,counter));

temprec := record
	df2;
	unsigned6	 did := 0;
	unsigned1  did_score := 0;
	string9	 ssn_appended := '';
	string5	 fake_zip := '';
end;

df3 := table(df2(or_lname != ''),temprec);


myset := ['D','S','4'];

did_add.MAC_Match_Flex(df3,myset,ssn,dob,or_fname,or_mname,or_lname,
	or_suffix,foo, foo, foo, fake_zip, foo, foo,did,temprec,true,did_score,70,outf1);

outf2 := dedup(sort(distribute(outf1,hash(seq)),seq,-did_score,did,local),seq,local);

outrec := layout_party_out;

outrec into_out(df1 L, outf2 R) := transform
	self.did := R.did;
	self.bdid := 0;
	self.ssn_appended := '';
	self.ssn_restrictions := 0;
	self := L;
end;

outf3 := join(distribute(df1,hash(seq)), outf2, left.seq = right.seq, into_out(LEFT,RIGHT),local, left outer);

myset2 := ['N'];

business_header_ss.MAC_Match_Flex(outf3,myset2,
							entity_nm,
							foo,foo,foo,foo,foo,
							foo,foo,
							bdid,
							outrec,
							false,foo,
							outf4)

did_add.Mac_Append_SSN_With_Restrictions(outf4,outf5,did,ssn_appended,ssn_restrictions);

							
ut.MAC_SF_BuildProcess(outf5,'~thor_data400::base::official_recs_party',do1,2);

export proc_did_party := do1;
							