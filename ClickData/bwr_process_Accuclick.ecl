import didville, did_add;

df := dataset('~thor_data400::in::accuclick_20050812',clickdata.layout_accuclick,csv(quote('"')));

seqrec := record
	df;
	unsigned4	seq;
	string182	clean_address;
	string73	clean_name;
end;

seqrec into_seq(df L, integer C) := transform
	self.seq := C;
	self.clean_address := addrcleanlib.cleanaddress182(L.address, L.city + ' ' + L.state + ' ' + l.zip);
	self.clean_name := addrcleanlib.cleanperson73(L.full_name);
	self := L;
end;

dfseq := project(df, into_seq(LEFT,COUNTER));

didville.layout_did_inbatch into_dib(dfseq L) := transform
	self.fname := L.clean_name[6..25];
	self.mname := L.clean_name[26..45];
	self.lname := L.clean_name[46..65];
	self.suffix := L.clean_name[66..70];
	self.prim_range := l.clean_address[1..10];
	self.prim_name := L.clean_address[13..40];
	self.sec_range := l.clean_address[57..64];
	self.st := L.clean_address[115..116];
	self.z5 := L.clean_address[117..121];
	self.dob := L.dob;
	self.ssn := '';
	self.phone10 := l.phone;
	self.seq := l.seq;
	self := [];
end;

dfready := project(dfseq,into_dib(LEFT));

did_add.Mac_Match_Fast_Roxie(dfready,outf,'ANY_ALL','BEST_ALL, HHID_RELATIVES')

outrec := record
	df;
	string12	adl;
	string100	best_addr1;
	string25	best_city;
	string2	best_state;
	string10	best_zip;
	string20	best_fname;
	string20	best_mname;
	string20	best_lname;
	string4	best_name_suffix;
	string12	hhid;
end;

outrec into_out(outf L, dfseq R) := transform
	self := R;
	self.adl := intformat(L.did, 12,1 );
	self.hhid := intformat(L.hhid, 12, 1);
	self := L;
end;

outfinal := join (outf,
			   dfseq,
					left.seq = right.seq,
			  into_out(LEFT,RIGHT), hash);
			  
output(outfinal,,'~thor_Data400::out::accuclick_withappends20050812',csv(quote('"')), overwrite);
output((count(outfinal((integer)adl != 0))/count(outfinal))*100);
output((count(outfinal((integer)hhid != 0))/count(outfinal))*100);
output((count(outfinal(best_addr1 != ''))/count(outfinal))*100);
output((count(outfinal(best_lname != ''))/count(outfinal))*100);
