import did_add, header_slimsort, header, doxie, watchdog, ut, didville;


df := dataset('~thor_data400::base::ln_tu_comp',cjm_misc.Layout_LN_TU_Comp,flat);

seqrec := record
	unsigned4	seq;
	df;
end;

seqrec into_seq(df L, integer C) := transform
	self.seq := C;
	self := L;
end;

df2 := project(df, into_seq(LEFT,COUNTER));

indic_rec := record
	unsigned4	seq;
	string20	fname;
	string20	mname;
	string20	lname;
	string5	name_suffix;
	string10	prim_range;
	string28	prim_name;
	string8	sec_range;
	string2	st;
	string5	zip;
	string8	dob;
	string10	phone;
	string9	ssn;
	unsigned6	did;
	unsigned1	score;
	unsigned6	hhid;
end;



indic_rec into_indic(df2 L, integer C) := transform
	self.seq := L.seq;
	self.fname := choose(C,L.clean_name1[6..25], L.clean_name2[6..25], L.clean_name3[6..25], L.clean_name4[6..25]);
	self.mname := choose(C,L.clean_name1[26..45], L.clean_name2[26..45], L.clean_name3[26..45], L.clean_name4[26..45]);
	self.lname := choose(C,L.clean_name1[46..65], L.clean_name2[46..65], L.clean_name3[46..65], L.clean_name4[46..65]);
	self.name_suffix := choose(C,L.clean_name1[66..70], L.clean_name2[66..70], L.clean_name3[66..70], L.clean_name4[66..70]);
	self.prim_range := L.clean[1..10];
	self.prim_name := L.clean[13..40];
	self.sec_range := L.clean[57..64];
	self.st 		:= L.clean[115..116];
	self.zip 		:= L.clean[117..121];
	self.dob		:= L.orig_birthdate_ccyymm;
	self.phone 	:= L.orig_telephone;
	self.ssn		:= L.orig_ssn;
	self.did		:= 0;
	self.score	:= 0;
	self.hhid		:= 0;
end;

df3 := normalize(df2,4,into_indic(LEFT,COUNTER))(lname != '');

myset := ['A','D','P','S','G','4','Z'];

did_add.MAC_Match_Flex(df3,myset,
			ssn, dob, fname, mname, lname, name_suffix,
			prim_range, prim_name, Sec_range, zip, st, phone,
			did,
			indic_rec,
			true, score,
			0,
			outf1)
			

outf1 get_HHID_By_DID(outf1 L, header.File_HHID_Current R) := transform
	self.hhid := R.hhid_relat;
	self := L;
end;

outf2 := join(outf1, header.File_HHID_Current,
				left.did = right.did and right.ver = 1,
			get_HHID_By_DID(LEFT,RIGHT),
			left outer, hash);

outf2_hhid := outf2(hhid != 0);
outf2_noHHID := outf2(hhid = 0);

didville.MAC_HHID_Append_By_Address(outf2_noHHID, outf3a, hhid, lname, 
							prim_range, prim_name, sec_range, st, zip);

outf3 := outf3a + outf2_hhid;

outrec := record
  string1 orig_record_type;
  string15 orig_first_name;
  string15 orig_middle_name;
  string25 orig_last_name;
  string2 orig_name_prefix;
  string3 orig_name_suffix;
  string12 orig_perm_id;
  string9 orig_ssn;
  string32 orig_aka_1;
  string32 orig_aka_2;
  string32 orig_aka_3;
  string7 orig_telephone;
  string15 orig_driver_license;
  string8 orig_file_date_mmddccyy;
  string6 orig_house_number;
  string2 orig_street_suffix;
  string2 orig_street_direction;
  string27 orig_street_name;
  string5 orig_apartment_number;
  string27 orig_city;
  string2 orig_state;
  string5 orig_zip5;
  string8 orig_date_reported_mmddccyy;
  string6 orig_birthdate_ccyymm;
  string1 orig_deceased_flag;
  string2	orig_crlf;
  string12	did;
  string12	hhid;
  string3		did_score;
end;

outrec into_out(outf3 L, df2 R) := transform
	self.did := if (L.did = 0, '', intformat(L.did, 12, 1));
	self.did_score := if (L.score = 0, '', intformat(L.score, 3, 1));
	self.hhid 	:= if (L.hhid = 0, '', intformat(L.hhid, 12, 1));
	self := R;
end;

outf4 := dedup(sort(distribute(outf3,hash(seq)),seq,did,hhid,local),seq,did,hhid,local);


outfinal := join(outf4, distribute(df2, hash (seq)),
				left.seq = right.seq,
			into_out(LEFT,RIGHT),
			local);

output(outfinal,,'~thor_data400::out::ln_tu_comp_' + thorlib.wuid());
