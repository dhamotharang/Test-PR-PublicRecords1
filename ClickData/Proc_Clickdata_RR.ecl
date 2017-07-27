import didville, ut, did_add, watchdog, address, gong, header;

export proc_clickdata_RR(boolean append_bests) := function


df := dataset('~thor_data400::in::clickdata_RR',clickdata.layout_clickdata_in_RR,csv(heading(1),separator(','),quote('"'),terminator(['\r','\r\n','\n','\n\r'])));

seqrec := record
	df;
	unsigned4	seq;
end;

seqrec into_seq(df L, integer C) := transform
	self.seq := C;
	self := L;
end;

df2 := project(df,into_seq(LEFT,COUNTER));

// need did?

Loadxml('<FOO/>');

didville.Layout_Did_InBatch into_dib(df2 L) := transform
	clean_name := addrcleanlib.cleanperson73(L.full_name);
	clean_addr := addrcleanlib.cleanaddress182(L.addr1, L.city + ' ' + L.state + ' ' + L.zip);
	ut.MAC_Insert_CleanAddrs(clean_addr,'P')
	self.title := '';
	self.fname := clean_name[6..25];
	self.mname := clean_name[26..45];
	self.lname := clean_name[46..65];
	self.suffix := clean_name[66..70];
	self.dob := L.dob;
	self.phone10 := L.phone;
	self.ssn := '';
	self.seq := L.seq;
end;

df3 := project(df2((integer)did_in = 0),into_dib(LEFT));

did_add.Mac_Match_Fast_Roxie(df3, outfa, 'BEST_ALL','BEST_ALL, HHID_RELATIVES','ALL', false, true, true, true);

// have did?

didville.Layout_Did_OutBatch add_best_df2(df2 L, watchdog.File_Best_nonglb R) := transform
	self.best_fname := R.fname;
	self.best_mname := R.mname;
	self.best_lname := R.lname;
	self.best_name_suffix := R.name_suffix;
	self.best_addr1 := address.Addr1FromComponents(R.prim_range, R.predir, R.prim_name, R.suffix, R.postdir, R.unit_desig, R.sec_range);
	self.best_city := R.city_name;
	self.best_state := R.st;
	self.best_zip := R.zip;
	self.best_zip4 := R.zip4;
	self.best_addr_date := R.addr_dt_last_seen;
	self.did := (integer)L.did_in;
	self := L;
	self := [];
end;
	
outfb := join(distribute(df2((integer)did_in != 0),hash((integer)did_in)),
		    watchdog.File_Best_nonglb,
				(integer)left.did_in != 0 and
				(integer)left.did_in = right.did,
			add_best_df2(LEFT, RIGHT), 
			left outer, local);


// pick a base file based on has_bdids

outf := outfb + outfa;

outrec := layout_clickdata_out_RR; 	

temprec := record
	unsigned4	seq;
	outrec;
	unsigned6	temp_hhid;
	string20	lname;
	string10	prim_range;
	string28	prim_name;
	string8	sec_range;
	string2	st;
	string5	z5;
end;

temprec into_temp(outf L, df2 R) := transform
	self.best_fname := if (append_bests, L.best_fname, '');
	self.best_mname := if (append_bests, L.best_mname, '');
	self.best_lname := if (append_bests, L.best_lname, '');
	self.best_name_suffix := if (append_bests, L.best_name_suffix, '');
	self.best_addr1 := if (append_bests, L.best_addr1, '');
	self.best_city  := if (append_bests, L.best_city, '');
	self.best_st	 := if (append_bests, L.best_state, '');
	self.best_zip   := if (append_bests, L.best_zip + '-' + L.best_zip4, '');
	self.best_addr_date := if (append_bests, (string)L.best_addr_date, '');
	self.hhid := intformat(L.hhid, 12, 1);
	self.adl := intformat(L.did, 12, 1);
	self.best_name_score := intformat(L.verify_best_name, 3, 1);
	self.best_addr_score := intformat(L.verify_best_address, 3, 1);
	self.best_phone_score := intformat(L.verify_best_phone, 3, 1);
	self.header_count := intformat(L.head_cnt, 4, 1);
	self.best_phone := '';
	self := L;
	self := R;
	self := [];
end;

outf2 := join(distribute(outf, hash(seq)),
			distribute(df2, hash(seq)),
				left.seq = right.seq,
			into_temp(LEFT,RIGHT),
			local);


relrec := record
	unsigned4	seq;
	unsigned6	did;
	unsigned2	number_cohabits;
	integer3	recent_cohabit;
	string20	Rel_BestFname;
	string20	Rel_BestMname;
	string20	Rel_BestLname;
	string5	Rel_BestSuffix;
	string100	Rel_BestAddr1;
	string30	Rel_BestCity;
	string2	Rel_BestSt;
	string10	Rel_BestZip;
end;

rels := header.File_Relatives(number_cohabits >= 6);

rels cross_pop(rels L) := transform
	self.person1 := L.person2;
	self.person2 := L.person1;
	self := L;
end;


rels2 := rels + project(rels,cross_pop(LEFT));

relrec into_rel(outf2 L, rels2 R) := transform
	self.seq := l.seq;
	self.did := R.person2;
	self.recent_cohabit := R.recent_cohabit;
	self.number_cohabits := R.number_cohabits;
	self := [];
end;

myrels1 := join(outf2, rels2,
				(integer)left.adl = right.person1,
			into_rel(LEFT,RIGHT),hash);

relrec rel_best(myrels1 L, watchdog.File_Best_nonglb R) := transform
	self.Rel_bestfname := R.fname;
	self.Rel_bestmname := R.mname;
	self.Rel_bestlname := R.lname;
	self.Rel_bestsuffix := R.name_suffix;
	self.Rel_bestaddr1 := address.Addr1FromComponents(R.prim_Range, R.predir, R.prim_Name, R.suffix, R.postdir, R.unit_desig, R.sec_range);
	self.Rel_BestCity := R.city_name;
	self.Rel_BestSt := R.st;
	self.Rel_BestZip := R.zip + '-' + R.zip4;
	self := l;
end;

myrels2 := join(distribute(myrels1, hash(did)), watchdog.File_Best_nonglb,
				left.did = right.did,
			 rel_best(LEFT,RIGHT),local);

myrels_use := if (append_bests, myrels2, myrels1);
		    
temprec denorm_out(outf2 L, myrels_use R, integer C) := transform
	self.Rel_ADL1 		:= if (C = 1, if (R.did = 0, '', intformat(R.did, 12, 1)), L.Rel_ADL1);
	self.Rel_BestFname1 := if (C = 1, R.Rel_BestFname, L.Rel_BestFname1);
	self.Rel_BestMname1 := if (C = 1, R.Rel_BestMname, L.Rel_BestMname1);
	self.Rel_bestLname1 := if (C = 1, R.Rel_BestLname, L.Rel_BestLname1);
	self.Rel_BestSuffix1 := if (C = 1, R.Rel_BestSuffix, L.reL_bestSuffix1);
	self.Rel_BestAddr1  := if (C = 1, R.Rel_BestAddr1, L.Rel_BestAddr1);
	self.Rel_BestCity1 	:= if (C = 1, R.Rel_BestCity, L.Rel_BestCity1);
	self.Rel_BestSt1	:= if (C = 1, R.Rel_BestSt, L.Rel_BestSt1);
	self.Rel_BestZip1	:= if (C = 1, R.Rel_BestZip, L.Rel_BestZip1);
	self.Rel_ADL2 		:= if (C = 2, if (R.did = 0, '', intformat(R.did, 12, 1)), L.Rel_ADL2);
	self.Rel_BestFname2 := if (C = 2, R.Rel_BestFname, L.Rel_BestFname2);
	self.Rel_BestMname2 := if (C = 2, R.Rel_BestMname, L.Rel_BestMname2);
	self.Rel_bestLname2 := if (C = 2, R.Rel_BestLname, L.Rel_BestLname2);
	self.Rel_BestSuffix2 := if (C = 2, R.Rel_BestSuffix, L.reL_bestSuffix2);
	self.Rel_BestAddr2 := if (C = 2, R.Rel_BestAddr1, L.Rel_BestAddr2);
	self.Rel_BestCity2 	:= if (C = 2, R.Rel_BestCity, L.Rel_BestCity2);
	self.Rel_BestSt2	:= if (C = 2, R.Rel_BestSt, L.Rel_BestSt2);
	self.Rel_BestZip2	:= if (C = 2, R.Rel_BestZip, L.Rel_BestZip2);
	self.Rel_ADL3 		:= if (C = 3, if (R.did = 0, '', intformat(R.did, 12, 1)), L.Rel_ADL3);
	self.Rel_BestFname3 := if (C = 3, R.Rel_BestFname, L.Rel_BestFname3);
	self.Rel_BestMname3 := if (C = 3, R.Rel_BestMname, L.Rel_BestMname3);
	self.Rel_bestLname3 := if (C = 3, R.Rel_BestLname, L.Rel_BestLname3);
	self.Rel_BestSuffix3 := if (C = 3, R.Rel_BestSuffix, L.reL_bestSuffix3);
	self.Rel_BestAddr3 := if (C = 3, R.Rel_BestAddr1, L.Rel_BestAddr3);
	self.Rel_BestCity3 	:= if (C = 3, R.Rel_BestCity, L.Rel_BestCity3);
	self.Rel_BestSt3	:= if (C = 3, R.Rel_BestSt, L.Rel_BestSt3);
	self.Rel_BestZip3	:= if (C = 3, R.Rel_BestZip, L.Rel_BestZip3);
	self.Rel_ADL4 		:= if (C = 4, if (R.did = 0, '', intformat(R.did, 12, 1)), L.Rel_ADL4);
	self.Rel_BestFname4 := if (C = 4, R.Rel_BestFname, L.Rel_BestFname4);
	self.Rel_BestMname4 := if (C = 4, R.Rel_BestMname, L.Rel_BestMname4);
	self.Rel_bestLname4 := if (C = 4, R.Rel_BestLname, L.Rel_BestLname4);
	self.Rel_BestSuffix4 := if (C = 4, R.Rel_BestSuffix, L.reL_bestSuffix4);
	self.Rel_BestAddr4 := if (C = 4, R.Rel_BestAddr1, L.Rel_BestAddr4);
	self.Rel_BestCity4 	:= if (C = 4, R.Rel_BestCity, L.Rel_BestCity4);
	self.Rel_BestSt4	:= if (C = 4, R.Rel_BestSt, L.Rel_BestSt4);
	self.Rel_BestZip4	:= if (C = 4, R.Rel_BestZip, L.Rel_BestZip4);
	self.Rel_ADL5 		:= if (C = 5, if (R.did = 0, '', intformat(R.did, 12, 1)), L.Rel_ADL5);
	self.Rel_BestFname5 := if (C = 5, R.Rel_BestFname, L.Rel_BestFname5);
	self.Rel_BestMname5 := if (C = 5, R.Rel_BestMname, L.Rel_BestMname5);
	self.Rel_bestLname5 := if (C = 5, R.Rel_BestLname, L.Rel_BestLname5);
	self.Rel_BestSuffix5 := if (C = 5, R.Rel_BestSuffix, L.reL_bestSuffix5);
	self.Rel_BestAddr5 := if (C = 5, R.Rel_BestAddr1, L.Rel_BestAddr5);
	self.Rel_BestCity5 	:= if (C = 5, R.Rel_BestCity, L.Rel_BestCity5);
	self.Rel_BestSt5	:= if (C = 5, R.Rel_BestSt, L.Rel_BestSt5);
	self.Rel_BestZip5	:= if (C = 5, R.Rel_BestZip, L.Rel_BestZip5);
	self.Rel_ADL6 		:= if (C = 6, if (R.did = 0, '', intformat(R.did, 12, 1)), L.Rel_ADL6);
	self.Rel_BestFname6 := if (C = 6, R.Rel_BestFname, L.Rel_BestFname6);
	self.Rel_BestMname6 := if (C = 6, R.Rel_BestMname, L.Rel_BestMname6);
	self.Rel_bestLname6 := if (C = 6, R.Rel_BestLname, L.Rel_BestLname6);
	self.Rel_BestSuffix6 := if (C = 6, R.Rel_BestSuffix, L.reL_bestSuffix6);
	self.Rel_BestAddr6 := if (C = 6, R.Rel_BestAddr1, L.Rel_BestAddr6);
	self.Rel_BestCity6 	:= if (C = 6, R.Rel_BestCity, L.Rel_BestCity6);
	self.Rel_BestSt6	:= if (C = 6, R.Rel_BestSt, L.Rel_BestSt6);
	self.Rel_BestZip6	:= if (C = 6, R.Rel_BestZip, L.Rel_BestZip6);
	self.Rel_ADL7 		:= if (C = 7, if (R.did = 0, '', intformat(R.did, 12, 1)), L.Rel_ADL7);
	self.Rel_BestFname7 := if (C = 7, R.Rel_BestFname, L.Rel_BestFname7);
	self.Rel_BestMname7 := if (C = 7, R.Rel_BestMname, L.Rel_BestMname7);
	self.Rel_bestLname7 := if (C = 7, R.Rel_BestLname, L.Rel_BestLname7);
	self.Rel_BestSuffix7 := if (C = 7, R.Rel_BestSuffix, L.reL_bestSuffix7);
	self.Rel_BestAddr7 := if (C = 7, R.Rel_BestAddr1, L.Rel_BestAddr7);
	self.Rel_BestCity7 	:= if (C = 7, R.Rel_BestCity, L.Rel_BestCity7);
	self.Rel_BestSt7	:= if (C = 7, R.Rel_BestSt, L.Rel_BestSt7);
	self.Rel_BestZip7	:= if (C = 7, R.Rel_BestZip, L.Rel_BestZip7);
	self.Rel_ADL8 		:= if (C = 8, if (R.did = 0, '', intformat(R.did, 12, 1)), L.Rel_ADL8);
	self.Rel_BestFname8 := if (C = 8, R.Rel_BestFname, L.Rel_BestFname8);
	self.Rel_BestMname8 := if (C = 8, R.Rel_BestMname, L.Rel_BestMname8);
	self.Rel_bestLname8 := if (C = 8, R.Rel_BestLname, L.Rel_BestLname8);
	self.Rel_BestSuffix8 := if (C = 8, R.Rel_BestSuffix, L.reL_bestSuffix8);
	self.Rel_BestAddr8 := if (C = 8, R.Rel_BestAddr1, L.Rel_BestAddr8);
	self.Rel_BestCity8	:= if (C = 8, R.Rel_BestCity, L.Rel_BestCity8);
	self.Rel_BestSt8	:= if (C = 8, R.Rel_BestSt, L.Rel_BestSt8);
	self.Rel_BestZip8	:= if (C = 8, R.Rel_BestZip, L.Rel_BestZip8);
	self.Rel_ADL9 		:= if (C = 9, if (R.did = 0, '', intformat(R.did, 12, 1)), L.Rel_ADL9);
	self.Rel_BestFname9 := if (C = 9, R.Rel_BestFname, L.Rel_BestFname9);
	self.Rel_BestMname9 := if (C = 9, R.Rel_BestMname, L.Rel_BestMname9);
	self.Rel_bestLname9 := if (C = 9, R.Rel_BestLname, L.Rel_BestLname9);
	self.Rel_BestSuffix9 := if (C = 9, R.Rel_BestSuffix, L.reL_bestSuffix9);
	self.Rel_BestAddr9 := if (C = 9, R.Rel_BestAddr1, L.Rel_BestAddr9);
	self.Rel_BestCity9 	:= if (C = 9, R.Rel_BestCity, L.Rel_BestCity9);
	self.Rel_BestSt9	:= if (C = 9, R.Rel_BestSt, L.Rel_BestSt9);
	self.Rel_BestZip9	:= if (C = 9, R.Rel_BestZip, L.Rel_BestZip9);
	self := l;
end;

outf3 := denormalize(outf2, sort(distribute(myrels_use, hash(seq)),seq, -number_cohabits, -recent_cohabit, local),
						left.seq = right.seq,
				    denorm_out(LEFT,RIGHT,COUNTER), local);


slimgong := record
	gong.File_Gong_History_Full.did;
	gong.File_Gong_History_Full.hhid;
	gong.File_Gong_History_Full.deletion_date;
	gong.File_Gong_History_Full.dt_first_seen;
end;

gf := table(gong.File_Gong_History_Full, slimgong);

outf3 get_gong_dates(outf3 L, gF R) := transform
	self.EDA_Disconnect := if ((integer)L.eda_disconnect > (integer)R.deletion_date, L.eda_disconnect, R.deletion_date);
	self.EDA_Connect := if (((integer)L.eda_connect != 0 and (integer)L.eda_connect < (integer)R.dt_first_seen) or (integer)R.dt_first_seen = 0, L.eda_connect, R.dt_first_seen);
	self := L;
end;

outf4a := join(distribute(outf3((integer)adl != 0), hash ((integer)adl)),
			distribute(gF(did != 0), hash (did)),
				(integer)left.adl = right.did,
			get_gong_dates(LEFT,RIGHT),
			left outer, local) + outf3((integer)adl = 0);
			
outf4 := join(distribute(outf4a((integer)hhid != 0), hash((integer)hhid)),
			distribute(gF(hhid != 0), hash(hhid)),
				(integer)left.hhid = right.hhid,
			get_gong_dates(LEFT,RIGHT),
			left outer, local) + outf4a((integer)hhid = 0);

outf4 roll_dates(outf4 L, outf4 R) := transform
	self.EDA_Disconnect := if ((integer)L.EDA_Disconnect > (integer)R.EDA_Disconnect, L.EDA_Disconnect, R.EDA_Disconnect);
	self.EDA_Connect := If (((integer)L.eda_connect != 0 and (integer)L.eda_connect < (integer)R.eda_connect) or (integer)R.eda_connect = 0, L.eda_connect, R.eda_connect);
	self := L;
end;

outf5 := group(rollup(group(sort(distribute(outf4,hash(Seq)),seq,local),seq,local), true, roll_dates(LEFT,RIGHT)));

outrec into_outfinal(outf5 L) := transform	
	self.best_phone := '';
	self := L;
end;

outfinal := project(outf5,into_outfinal(LEFT));

ut.MAC_SF_BuildProcess(outfinal,'~thor_data400::base::clickdata_RR',do1,3, true)

return do1;

end;